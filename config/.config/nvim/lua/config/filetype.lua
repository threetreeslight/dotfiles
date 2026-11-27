-- Filetype overrides for files Neovim misdetects or does not know
vim.filetype.add({
  extension = {
    tf = "terraform", -- built-in detection maps *.tf to TinyFugue ("tf")
    jbuilder = "ruby",
  },
})
