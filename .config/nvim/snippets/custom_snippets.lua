local luasnip = require('luasnip')
local s = luasnip.snippet
local t = luasnip.text_node

luasnip.snippets = {
  all = {
    s('date', t(os.date('%Y-%m-%d'))),
    -- more snippets...
  },
}
