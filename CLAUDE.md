# CLAUDE.md — ruby_german_zip_codes

## Was dieses Projekt ist

Ruby-Gem für die Suche nach deutschen Postleitzahlen (PLZ). Gibt zu einer PLZ Stadt, Landkreis/Bezirk und Bundesland zurück. Kein US-Support — das ist ein Fork des ursprünglichen `zip-codes`-Gems, der ausschließlich auf Deutschland fokussiert ist.

## Projektstruktur

```
lib/
  zip-codes.rb          # Haupt-Einstiegspunkt, öffentliche API
  zip-codes/
    city_map.rb         # Datenstruktur für den PLZ-Hash (YAML ↔ Ruby)
    converter.rb        # CSV → YAML Konverter (für Datenpflege)
    version.rb          # VERSION-Konstante
  data/
    DE.yml              # Produktiv-Datenbank (~8.000 PLZ, ~1 MB)
    de.csv              # Quelldaten (OSM-Export, Basis für DE.yml)
    DE_old.yml          # Veraltete Version – kann entfernt werden
    US.yml              # Nicht genutzt – Überbleibsel vom Original-Fork
```

## Datenformat

`DE.yml` enthält einen Hash mit PLZ-String als Key:

```yaml
'20535':
  :osm_id: '62782'
  :code: '20535'
  :city: Hamburg
  :county: Hamburg-Mitte
  :state: Hamburg
```

Bei mehreren Städten pro PLZ wird `city` als Semikolon-separierter String gespeichert (`"Stadt1;Stadt2"`).

## Datenpflege: CSV → YAML neu generieren

```bash
bundle exec rake convert
```

Liest `lib/data/de.csv` und schreibt `lib/data/DE.yml` neu. Das CSV hat folgende Spalten (Semikolon-getrennt):

| Index | Feld     |
|-------|----------|
| 0     | osm_id   |
| 1     | city     |
| 2     | code     |
| 3     | county   |
| 4     | state    |

## Wichtige Hinweise

- Die YAML-Datei wird beim ersten Aufruf vollständig in den Speicher geladen (Memoize via `@db`). In Rails-Apps `ZipCodes.load` im Initializer aufrufen.
- Der `city_index` (Reverse-Index Stadt → [PLZ]) wird lazy beim ersten `codes`-Aufruf aufgebaut und ebenfalls gecacht.
- `YAML.load_file` mit `permitted_classes: [Symbol]` ist notwendig, weil `DE.yml` Symbol-Keys enthält (Psych 4 / Ruby 3.1+).

## Tests ausführen

```bash
bundle exec rspec
```

Code-Style prüfen:

```bash
bundle exec standardrb
```

## CI

GitHub Actions (`.github/workflows/ci.yml`): läuft bei Push auf `main` und bei PRs. Führt StandardRb und RSpec aus.
