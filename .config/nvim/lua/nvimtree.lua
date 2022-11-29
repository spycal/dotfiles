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

r
