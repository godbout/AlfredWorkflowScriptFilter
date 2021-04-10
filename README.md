<h1 align="center">Alfred Workflow ScriptFilter</h1>

<p align="center">
    <a href="https://github.com/godbout/AlfredWorkflowScriptFilter/releases"><img src="https://img.shields.io/github/release/godbout/AlfredWorkflowScriptFilter.svg" alt="GitHub Release"></a>
    <a href="https://github.com/godbout/AlfredWorkflowScriptFilter/actions"><img src="https://img.shields.io/github/workflow/status/godbout/AlfredWorkflowScriptFilter/tests%20and%20coverage" alt="Build Status"></a>
    <a href="https://app.codacy.com/gh/godbout/AlfredWorkflowScriptFilter"><img src="https://img.shields.io/codacy/grade/5de193eef6ef499c86f7abebc667e4dd" alt="Quality Score"></a>
    <a href="https://codecov.io/gh/godbout/AlfredWorkflowScriptFilter"><img src="https://img.shields.io/codecov/c/gh/godbout/AlfredWorkflowScriptFilter" alt="Code Coverage"></a>
</p>

___

# WHY

ever tried generating JSON results for Alfred manually? LOL. also that library exists in [PHP](https://github.com/godbout/alfred-workflow-scriptfilter) but macOS is getting rid of interpreters so here you go Swift. 

# INSTALLATION

no idea about CocoaPod or Carthage. for Swift Package Manager:

```swift
let package = Package(
    ...
    dependencies: [
        .package(
            name: "AlfredWorkflowScriptFilter",
            url: "https://github.com/godbout/AlfredWorkflowScriptFilter",
            from: "1.0.0"
        ),
    ...
```

then don't forget 

```bash
swift package update
```

# USAGE

## print shits

```swift
import AlfredWorkflowScriptFilter

print(ScriptFilter.output())
```

will result in (hopefully):

```json
{"items":[]}
```

## add shits

you can add items, variables, rerun automatically your script:

```swift
ScriptFilter.add(
    Item(title: "titlee")
        .uid("uuid")
        .subtitle("subtitlee")
        .arg("argg")
        .icon(
            Icon(path: "icon path")
        )
        .valid()
        .match("matchh")
        .autocomplete("autocompletee")
        .mod(
            Ctrl()
                .arg("ctrl arg")
                .subtitle("ctrl subtitle")
                .valid()
        )
        .text("copyy", for: .copy)
        .text("largetypee", for: .largetype)
        .quicklookurl("quicklookurll")
)
        
ScriptFilter.add(
    Variable(name: "food", value: "chocolate"),
    Variable(name: "dessert", value: "red beans")
)
        
ScriptFilter.rerun(secondsToWait: 4.5)

let anotherItem = Item(title: "Another Item in the Wall")
    .icon(
        Icon(path: "icon pathh", type: .fileicon)
    )
    .mods(
        Shift()
            .subtitle("shift subtitle"),
        Fn()
            .arg("fn arg")
            .valid(true)
    )

let thirdItem = Item(title: "3rd")
    .variables(
        Variable(name: "guitar", value: "fender"),
        Variable(name: "amplifier", value: "orange")
    )
    .mod(
        Alt()
            .icon(
                Icon(path: "alt icon path", type: .fileicon)
            )
            .variables(
                Variable(name: "grade", value: "colonel"),
                Variable(name: "drug", value: "power")
            )
    )

ScriptFilter.add(
    anotherItem,
    thirdItem
)

print(ScriptFilter.output())
```

will result in (but not that pretty):

```json
{
    "rerun": 4.5,
    "variables": {
        "food": "chocolate",
        "dessert": "red beans"
    },
    "items": [
        {
            "uid": "uidd",
            "title": "titlee",
            "subtitle": "subtitlee",
            "arg": "argg",
            "icon": {
                "path": "icon path"
            },
            "valid": true,
            "match": "matchh",
            "autocomplete": "autocompletee",
            "mods": {
                "ctrl": {
                    "arg": "ctrl arg",
                    "subtitle": "ctrl subtitle",
                    "valid": true
                }
            },
            "text": {
                "copy": "copyy",
                "largetype": "largetypee"
            },
            "quicklookurl": "quicklookurll"
        },
        {
            "title": "Another Item in the Wall",
            "icon": {
                "path": "icon pathh",
                "type": "fileicon"
            },
            "mods": {
                "shift": {
                    "subtitle": "shift subtitle"
                },
                "fn": {
                    "arg": "fn arg",
                    "valid": true
                }
            }
        },
        {
            "title": "3rd",
            "mods": {
                "alt": {
                    "icon": {
                        "path": "alt icon path",
                        "type": "fileicon"
                    },
                    "variables": {
                        "grade": "colonel",
                        "drug": "power"
                    }
                }
            },
            "variables": {
                "guitar": "fender",
                "amplifier": "orange"
            }
        }
    ]
}
```

## sort shits

ascendingly or descendingly, by title, subtitle or match:

```swift
/**
 * sort items ascendingly by titles
 */
ScriptFilter.add(...)
ScriptFilter.sortItems()
print(ScriptFilter.output())

/**
 * sort items descendingly by subtitles
 */
ScriptFilter.add(...)
ScriptFilter.sortItems(by: .subtitle, .descendingly)
print(ScriptFilter.output())
```

## filter shits

you might want to do this based on the user input, by title or subtitle:

```swift
/**
 * only items with a title that contains
 * 'big' will show up in the output.
 */
ScriptFilter.add(...)
ScriptFilter.filterItems(by: .title, containing: "big")
print(ScriptFilter.output())

/**
 * only items with a subtitle that contains
 * 'duck' will show up in the output.
 */
ScriptFilter.add(...)
ScriptFilter.filterItems(by: .subtitle, containing: "duck")
print(ScriptFilter.output())
```

# MORE BETTER™ API

the API respects word for word the [Alfred JSON ScriptFilter format](https://www.alfredapp.com/help/workflows/inputs/script-filter/json/), but usually offers some More Better™ ways to build your ScriptFilter results.

e.g.:

```swift
/**
 * when you want to add only one item, variable or mod
 * you can use the singular form rather than the plural
 */
blah.item(item)
blah.variable(variable)
blah.mod(Cmd())

/**
 * rather than using ScriptFilter.item or ScriptFilter.variable
 * you can just use ScriptFilter.add and throw your shits in there
 */
 ScriptFilter.add(item1, item68)
 ScriptFilter.add(variable1, variable2)
```

best is to go have a look through the [Feature Tests](https://github.com/godbout/AlfredWorkflowScriptFilter/tree/master/Tests/AlfredWorkflowScriptFilterTests/Feature) to see the whole API.

# SPECIAL DEDICATED THANKS TO

ME.
