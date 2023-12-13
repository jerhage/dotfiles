return {
  {
    "ThePrimeagen/harpoon",
    enabled = true,
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add file to Harpoon mark list",
      },
      {
        "<leader>e",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Show Harpoon marks",
      },
      {
        "<leader>4",
        function()
          require("harpoon.ui").nav_file(1)
        end,
      },
      {
        "<leader>5",
        function()
          require("harpoon.ui").nav_file(2)
        end,
      },
      {
        "<leader>6",
        function()
          require("harpoon.ui").nav_file(3)
        end,
      },
      {
        "<leader>7",
        function()
          require("harpoon.ui").nav_file(4)
        end,
      },
      {
        "<leader>8",
        function()
          require("harpoon.ui").nav_file(5)
        end,
      },
      {
        "<leader>9",
        function()
          require("harpoon.ui").nav_file(6)
        end,
      },
    },
  },
}
