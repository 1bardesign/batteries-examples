# ⚡ Examples for `batteries`

A collection of example usage scripts for [batteries](https://github.com/1bardesign/batteries).

Kept separate from the main `batteries` repo to avoid cluttering the commit history and bloating the repo size.

Comes with a [love](https://love2d.org)-compatible `main.lua` which allows browsing the source and output interactively.

# Index of Examples

- `table.lua` - table api extensions
- `math.lua` - math api extensions.
- `class.lua` - simple object oriented basics
- `functional.lua` - functional programming facilities
- `sequence.lua` - oop sugar for anything sequential
- `2d_geom.lua` - basic colliding and overlapping entities using `intersect` and `vec2`; requires love.
- `set.lua` - in/out sets

# TODO

- `state_boring.lua` - barebones state machine example.
- `stable_sort.lua` - show the benefit of a stable sort for sprite z sorting; requires love.
- `state_ai.lua` - visualised state machine ai for a sparring partner; requires love.
- `colour.lua` - various colour routines; requires love.
- `benchmark.lua` - benchmark various functionality interactively; requires love.

# Library Culture and Contributing

As with batteries - I'm open to collaboration and happy to talk through issues or shortcomings.

Pull Requests with new demos are welcome, though it will be required that they work with the rest of the example framework.

Fixes and enhancements to existing demos are also great and will generally be merged optimistically.
