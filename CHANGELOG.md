# Changelog

Alle relevanten Änderungen an diesem Projekt werden hier dokumentiert.

Format basiert auf [Keep a Changelog](https://keepachangelog.com/de/1.0.0/),
Versionierung folgt [Semantic Versioning](https://semver.org/lang/de/).

---

## [0.3.0] - 2026-07-07

### Verbessert
- `codes(city)` nutzt jetzt einen lazy gecachten Reverse-Index (`city → [codes]`) statt O(n)-Scan — deutlich schneller bei wiederholten Aufrufen
- `codes(city)` gibt eine Kopie des Arrays zurück, damit Aufrufer den internen Cache nicht korrumpieren können
- `like(code)` verwendet `start_with?` statt `key.index(code) == 0`
- `YAML.load(File.open(...))` ersetzt durch `YAML.load_file(..., permitted_classes: [Symbol])` — schließt File-Handle korrekt, kompatibel mit Psych 4 (Ruby 3.1+)

### Hinzugefügt
- `CLAUDE.md`: Projektstruktur, Datenformat, Datenpflege-Dokumentation
- Testabdeckung von 6 auf 13 Specs erweitert (nil-Lookup, unbekannte Stadt, `like_search:`, Edge Cases)

### Geändert
- `README.md` vollständig auf Deutsch übersetzt, Datenfeld-Tabelle ergänzt
- `gemspec`: Autor, E-Mail und Homepage auf diesen Fork aktualisiert; `required_ruby_version >= 3.1.0`, `bundler >= 2.0`
- `Rakefile`: US-spezifischen `convert`-Task durch DE-Converter ersetzt
- Alle Abhängigkeiten auf aktuelle Versionen aktualisiert

## [0.2.1] - 2024-01-xx

### Geändert
- Berliner Bezirke ergänzt
- Hamburger Bezirke ergänzt

## [0.2.0] - 2023-xx-xx

### Geändert
- Umstellung auf deutsche PLZ-Datenbank (OpenStreetMap)
- Ursprünglicher Fork von [monterail/zip-codes](https://github.com/monterail/zip-codes)
