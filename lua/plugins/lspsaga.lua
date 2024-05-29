return {
    "nvimdev/lspsaga.nvim",
    config = function()
        local keymap = vim.keymap

        require("lspsaga").setup({
            ui = {
                border = "rounded",
                code_action = "",
            },
            symbol_in_winbar = {
                folder_level = 5,
            },
            outline = {
                win_width = 50,
            },
            finder = {
                layout = "normal",
                keys = {
                    toggle_or_open = "<cr>",
                },
            },
            -- rename = {
            --   keys = {
            --     quit = "<esc>",
            --   },
            -- },
            floaterm = {
                height = 0.9,
                width = 0.9,
            },
        })

        -- keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
        -- keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>')
        keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", opts)
                vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<cr>", opts)
                vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", opts)
                vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
            end,
        })
    end,
}
