return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },
    
    -- Import all plugin specs
    require("indy.lazy.colors"),
    require("indy.lazy.telescope"),
    require("indy.lazy.treesitter"),
    require("indy.lazy.lsp"),
    require("indy.lazy.harpoon"),
    require("indy.lazy.undotree"),
    require("indy.lazy.fugitive"),
    require("indy.lazy.zenmode"),
    require("indy.lazy.copilot"),
    require("indy.lazy.vim-be-good"),
}
