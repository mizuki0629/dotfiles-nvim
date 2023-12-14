local function try_require(modname)
    local success, result = xpcall(require, debug.traceback, modname)
    if success then
        return result
    else
        vim.api.nvim_echo({ {result, "WarningMsg"}, }, true, {})
        return nil
    end
end


return {
    try_require = try_require,
}
