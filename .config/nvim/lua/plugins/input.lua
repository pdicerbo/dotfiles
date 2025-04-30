return {
    -- lazy.nvim
    {
        "folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
            input = {
                icon = " ",
                icon_hl = "SnacksInputIcon",
                icon_pos = "left",
                prompt_pos = "title",
                win = { style = "input" },
                expand = true,
            }
        }
    }
}
