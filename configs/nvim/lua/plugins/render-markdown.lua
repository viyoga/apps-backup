return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    pipe_table = {
      -- 'raw'  = only replaces | borders, doesn't pad columns to max width.
      -- This prevents word-wrap from destroying the table layout when cells
      -- have very long content (e.g. NuGet/MSBuild documentation files).
      cell = "raw",
    },
  },
}
