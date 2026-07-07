# ZipCodes [![Gem Version](https://badge.fury.io/rb/zip-codes.png)](http://badge.fury.io/rb/zip-codes)
![Testing](https://github.com/Skulli/ruby_german_zip_codes/actions/workflows/ci.yml/badge.svg?branch=main)
<a href="https://github.com/testdouble/standard" target="_blank">
  <img alt="Ruby Code Style" src="https://img.shields.io/badge/Ruby_Code_Style-standard-brightgreen.svg" />
</a>

Ruby-Gem zur Suche nach deutschen Postleitzahlen (PLZ). Gibt zu einer PLZ die zugehörige Stadt, den Landkreis bzw. Bezirk und das Bundesland zurück. Der vollständige Datensatz (~8.000 PLZ) ist als YAML-Datei eingebettet und wird beim ersten Zugriff in den Arbeitsspeicher geladen.

## Installation

In der `Gemfile` eintragen:

```ruby
gem 'zip-codes'
```

Dann ausführen:

    $ bundle install

Oder direkt installieren:

    $ gem install zip-codes

## Verwendung

### Exakte Suche

```ruby
ZipCodes.identify('20535')
# => { city: "Hamburg", code: "20535", county: "Hamburg-Mitte", osm_id: "62782", state: "Hamburg" }

ZipCodes.identify('99999')
# => nil
```

### Präfix-Suche

```ruby
ZipCodes.identify('205', like_search: true)
# => { "20535" => { city: "Hamburg", ... }, "20537" => { ... }, ... }

# Kurzform:
ZipCodes.like('205')
```

### Alle PLZ einer Stadt

```ruby
ZipCodes.codes('Hamburg')
# => ["20095", "20097", ..., "22769"]  # 98 Einträge
```

### Rails: Vorladen beim Start

Damit die YAML-Datei nicht beim ersten Request geparst wird, kann die Datenbank in einem Initializer vorgeladen werden:

```ruby
# config/initializers/zip_codes.rb
ZipCodes.load unless Rails.env.development?
```

## Datenfelder

| Feld     | Beispiel           | Beschreibung             |
|----------|--------------------|--------------------------|
| `code`   | `"20535"`          | PLZ (5-stelliger String) |
| `city`   | `"Hamburg"`        | Stadt / Gemeinde         |
| `county` | `"Hamburg-Mitte"`  | Landkreis oder Bezirk    |
| `state`  | `"Hamburg"`        | Bundesland               |
| `osm_id` | `"62782"`          | OpenStreetMap-Relation   |

Die Daten basieren auf OpenStreetMap-Daten.

## Mitwirken

1. Fork erstellen
2. Feature-Branch anlegen (`git checkout -b mein-feature`)
3. Änderungen committen (`git commit -am 'Feature hinzufügen'`)
4. Branch pushen (`git push origin mein-feature`)
5. Pull Request öffnen
