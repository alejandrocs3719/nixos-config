return {

    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
	    highlight = {
		enable = true
	    },
	    indent = { enable = true },
	    autotage = { enable = true },
	    ensure_installed = {
		"lua",
		"nix",
	    },
	    enable_autoinstall = false,
	})
    end
}
