return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup(opts)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    for _, punct in pairs({ ",", ";" }) do
      npairs.add_rules({
        Rule("", punct)
          :with_move(function(o)
            return o.char == punct
          end)
          :with_pair(function()
            return false
          end)
          :with_del(function()
            return false
          end)
          :with_cr(function()
            return false
          end)
          :use_key(punct),
      })
    end

    npairs.add_rules({
      Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
        :use_regex(true)
        :set_end_pair_length(2),
      Rule("=", "")
        :with_pair(cond.not_inside_quote())
        :with_pair(function(o)
          local last_char = o.line:sub(o.col - 1, o.col - 1)
          if last_char:match("[%w%=%s]") then
            return true
          end
          return false
        end)
        :replace_endpair(function(o)
          local prev_2char = o.line:sub(o.col - 2, o.col - 1)
          local next_char = o.line:sub(o.col, o.col)
          next_char = next_char == " " and "" or " "
          if prev_2char:match("%w$") then
            return "<bs> =" .. next_char
          end
          if prev_2char:match("%=$") then
            return next_char
          end
          if prev_2char:match("=") then
            return "<bs><bs>=" .. next_char
          end
          return ""
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none()),
    })
  end,
}
