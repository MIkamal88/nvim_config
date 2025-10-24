return {
  { import = "lazyvim.plugins.extras.util.rest" },
  {
    "mistweaverco/kulala.nvim",
    opts = {
      icons = {
        inlay = {
          loading = "󰔟",
          done = " ",
          error = " ",
        },
        lualine = " ",
      },
      ui = {
        formatter = true,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "kulala-fmt",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.http = opts.formatters_by_ft.http or {}
      table.insert(opts.formatters_by_ft.http, "kulala")
      return opts
    end,
  },
}
