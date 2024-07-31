return {
    'artemave/workspace-diagnostics.nvim',
    opts = {
        workspace_files = function()
            local files = vim.fn.systemlist("git ls-files")
            local extensions = { "lua", "script", "gui_script" }
            local filtered_files = {}

            for _, file in ipairs(files) do
                for _, ext in ipairs(extensions) do
                    if string.match(file, "%." .. ext .. "$") then
                        table.insert(filtered_files, file)
                    end
                end
            end

            return filtered_files
        end
    }
}
