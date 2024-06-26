local highlights = {
   ["ErrorComment"] = {"!", "DEPRECATED"},
   ["QuestComment"] = {"?", "QUESTION", "SAFETY"},
   ["NoteComment"] = {"#", "FOOTNOTE", "NOTE", "INFO"},
}

for highlight, keywords in pairs(highlights) do
   local pattern = table.concat(keywords, "|")
   vim.api.nvim_command(string.format("syntax match %s /\\v\\/\\/ *(\\%s).*$/", highlight, pattern))
end
