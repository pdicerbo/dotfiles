return {
    {
        "rmagatti/auto-session",
        config = function()
            local auto_session = require("auto-session")

            auto_session.setup({
                auto_restore = false,
                suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" }
            })

            local keymap = vim.keymap
            keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
            keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
        end,
    },

    {
        "tpope/vim-surround"
    },

    {
        "cappyzawa/trim.nvim",
        config = function()
            require("trim").setup({
                ft_blocklist = {"markdown", "snacks-dashboard"},
                trim_on_write = true,
                trim_trailing = true,
                trim_last_line = true,
                trim_first_line = true,
                highlight = true,
                highlight_bg = '#ff0000', -- or 'red'
                highlight_ctermbg = 'red',
                notifications = true,
            })
            vim.keymap.set("n", "<C-k><C-x>", ":Trim<CR>", { desc = "Trim whitespace" })
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "<leader>fj", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<leader>fT", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },

    {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("nvim-navic").setup({
                icons = {
                    File = "󰈙 ",
                    Module        = " ",
                    Namespace = "󰌗 ",
                    Package = "󰏖 ",
                    Class = "󰠱 ",
                    Method = "󰊕 ",
                    Property = "󰜢 ",
                    Field = "󰇽 ",
                    Constructor   = " ",
                    Enum = "󰕘 ",
                    Interface = "󰕘 ",
                    Function = "󰊕 ",
                    Variable = "󰂡 ",
                    Constant = "󰏿 ",
                    String = "󰅬 ",
                    Number = "󰎠 ",
                    Boolean = "󰔨 ",
                    Array = "󰅪 ",
                    Object = "󰅩 ",
                    Key = "󰌋 ",
                    Null          = "󰟢 ",
                    EnumMember    = " ",
                    Struct = "󰌗 ",
                    Event = "",
                    Operator      = "󰆕 ",
                    TypeParameter = "󰊄 ",
                },
                lsp = {
                    auto_attach = true,
                    preference = nil, -- use default LSP client
                },
                highlight = true,
            })
        end,
    },

    {
        "hasansujon786/nvim-navbuddy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
            "numToStr/Comment.nvim",        -- Optional
            "nvim-telescope/telescope.nvim" -- Optional
        },
        config = function()
            require("nvim-navbuddy").setup({
                lsp = {
                    auto_attach = true,
                    preference = nil, -- use default LSP client
                },
                window = {
                    border = "rounded",
                    position = "50%",
                    size = {
                        width = "50%",
                        height = "50%",
                    },
                },
            })
        end,
    },
}
