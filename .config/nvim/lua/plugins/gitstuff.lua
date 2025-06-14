return {

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            preview_config = {
                border = 'rounded',
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                end

                -- Navigation
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")

                -- Actions
                map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")

                map("v", "<leader>gs", function() -- stage selected hunk
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Stage hunk")
                map("v", "<leader>gr", function() -- reset selected hunk
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Reset hunk")

                map("n", "<leader>gS", gs.stage_buffer, "Stage buffer") -- stage whole buffer
                map("n", "<leader>gR", gs.reset_buffer, "Reset buffer") -- unstage whole buffer
                map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>gi", gs.preview_hunk_inline, "Preview hunk inline")
                map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "Blame line")
                map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
                map("n", "<leader>gw", gs.toggle_word_diff, "Toggle intra-line word-diff in the buffer")
                map("n", "<leader>gd", gs.diffthis, "Diff this")
                map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this ~")

                -- Text object
                -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
            { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "Open Diff View file history" },
            { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
        },
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                enhanced_diff_hl = true,
                keymaps = {
                    file_panel = {
                        { "n",  "u",     actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
                        { "n",  "d",     actions.scroll_view(0.25),  { desc = "Scroll the view down" } },
                    },
                }
            })
        end,
    },
}
