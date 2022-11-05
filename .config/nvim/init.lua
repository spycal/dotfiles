----- Plugins ------
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("neovim/nvim-lspconfig")

	--- appearance ---
	use("Everblush/everblush.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("p00f/nvim-ts-rainbow")
	use("lukas-reineke/indent-blankline.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("nvim-tree/nvim-web-devicons")

	--- productivity ---
	use("windwp/nvim-autopairs")
	use("nvim-tree/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("nvim-lua/plenary.nvim")

	--- completions ---
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")
	use("onsails/lspkind.nvim")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-calc")
end)

------ Settings ------
local set = vim.o

set.relativenumber = true
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.t_Co = 256
set.termguicolors = true
set.history = 1000
set.encoding = "UTF-8"
set.cursorline = true
set.splitright = true
set.splitbelow = true
set.shell = zsh
set.scrolloff = true
set.laststatus = 2

vim.cmd([[set mouse+=a]])
vim.cmd([[set nowrap]])
vim.cmd([[set statusline=\ %f\ %=\ %l\:\%L ]])

------ Keymaps ------
local leader = ","
local keymap = vim.keymap

keymap.set("n", "nn", ":set norelativenumber<CR>")
keymap.set("n", "sn", ":set relativenumber<CR>")
keymap.set("v", "<Tab>", ">gv", { silent = true })

--- tab ---
keymap.set("n", "<C-n>", ":tabnew<CR>", { silent = true })
keymap.set("n", "<C-w>", ":bd<CR>", { silent = true })

--- window ---
keymap.set("n", "sr", ":vsplit<CR>", { silent = true })
keymap.set("n", "sd", ":split<CR>", { silent = true })
keymap.set("n", "w<left>", "<C-w>h")
keymap.set("n", "w<up>", "<C-w>k")
keymap.set("n", "w<down>", "<C-w>j")
keymap.set("n", "w<right>", "<C-w>l")

--- colorizer ---
keymap.set("n", "co", ":ColorizerToggle<CR>")

--- nvim-tree ---
keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>", { silent = true })
keymap.set("n", "<C-f>", ":NvimTreeFocus<CR>", { silent = true })

--- bufferline ---
keymap.set("n", "<A-Tab>", ":BufferLineCycleNext<CR>")

--- null-ls ---
keymap.set("n", "ff", ":lua vim.lsp.buf.format()<CR>", { silent = true })

------ Appearance ------
local colors = require("everblush.core").get_colors()
require("everblush").setup({
	override = {
		Comment = { fg = colors.comment, italic = true },
		VertSplit = { fg = colors.cursorline, bg = colors.cursorline },
		Boolean = { fg = colors.color1, italic = true },
		NvimTreeVertSplit = { fg = colors.background, bg = colors.background },
		NvimTreeNormal = { bg = colors.contrast },
	},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "lua", "bash", "yaml", "json", "ruby", "haskell", "python", "html", "css" },
	highlight = { enable = true },
	rainbow = {
		enable = false,
		extented_mode = true,
	},
})

require("indent_blankline").setup({
	show_current_context = true,
	show_end_of_line = true,
})

require("colorizer").setup()

------ Productivity ------
require("nvim-autopairs").setup({
	disable_filetype = {},
})

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	hijack_cursor = true,
	view = {
		width = 21,
	},
	renderer = {
		full_name = true,
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = false,
				git = false,
			},
		},
	},
})

require("bufferline").setup({
	options = {
		mode = "buffers",
		diagnostic = "nvim_lsp",
		modified_icon = "+",
		show_buffer_icons = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				separator = true,
			},
		},
	},
	highlights = {
		offset_separator = {
			fg = colors.background,
			bg = colors.background,
		},
	},
})

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettierd,
		require("null-ls").builtins.formatting.rufo,
	},
})

------ Completion ------
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "text",
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				calc = "[calc]",
			},
		}),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["ESC"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Repalce, select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "calc" } },
})

require("luasnip.loaders.from_vscode").lazy_load()
