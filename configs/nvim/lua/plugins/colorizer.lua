return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    options = {
      display = {
        mode = "virtualtext",
        virtualtext = { position = "after" },
      },
    },
  },
}
