return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup {
            window = {
                width = 90,
                options = {
                    number = true,
                    relativenumber = true,
                }
            },
        }

        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").toggle()
            vim.wo.wrap = false
            -- Note: ColorMyPencils() is defined in colors.lua, 
            -- but we need to require it or make it global
            if vim.g.ColorMyPencils then
                vim.g.ColorMyPencils()
            end
        end)
    end,
}
