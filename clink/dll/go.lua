--
-- Copyright (c) 2013 Dobroslaw Zybort
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

--------------------------------------------------------------------------------
local function flags(...)
    local p = clink.arg.new_parser()
    p:set_flags(...)
    return p
end

--------------------------------------------------------------------------------
local go_tool_parser = clink.arg.new_parser()
go_tool_parser:set_flags("-n")
go_tool_parser:set_arguments({
    "8a", "8c", "8g", "8l", "addr2line", "api", "cgo", "colcmp", "dist",
    "ebnflint", "gotype", "nm", "objdump", "pack", "pprof", "yacc",
    "cov"  .. flags("-l", "-s", "-v", "-g", "-m"),
    "fix"  .. flags("-diff", "-r", "-?"),
    "prof" .. flags("-p", "-t", "-d", "-P", "-h", "-f", "-l", "-r", "-s"),
    "vet"  .. flags("-printf", "-methods", "-structtags", "-composites", "-v",
                    "-printfuncs"),
})

--------------------------------------------------------------------------------
local go_parser = clink.arg.new_parser()
go_parser:set_arguments({
    "env",
    "fix",
    "version",
    "build"    .. flags("-a", "-n", "-p", "-v", "-work", "-x", "-race",
                        "-ccflags", "-compiler", "-gccgoflags", "-gcflags",
                        "-ldflags", "-tags"),
    "clean"    .. flags("-i", "-n", "-r", "-x"),
    "doc"      .. flags("-n", "-x"),
    "fmt"      .. flags("-n", "-x"),
    "get"      .. flags("-a", "-d", "-fix", "-n", "-p", "-u", "-v", "-x"),
    "install"  .. flags("-a", "-n", "-p", "-v", "-work", "-x", "-race",
                        "-ccflags", "-compiler", "-gccgoflags", "-gcflags",
                        "-ldflags", "-tags"),
    "list"     .. flags("-e", "-f", "-json"),
    "run"      .. flags("-a", "-n", "-p", "-v", "-work", "-x", "-race",
                        "-ccflags", "-compiler", "-gccgoflags", "-gcflags",
                        "-ldflags", "-tags"),
    "test"     .. flags("-c", "-i", "-a", "-n", "-p", "-v", "-work", "-x",
                        "-race", "-ccflags", "-compiler", "-gccgoflags",
                        "-gcflags", "-ldflags", "-tags"),
    "tool"     .. go_tool_parser,
    "vet"      .. flags("-n", "-x"),
})

--------------------------------------------------------------------------------
local go_help_parser = clink.arg.new_parser()
go_help_parser:set_arguments({
    "help" .. clink.arg.new_parser():set_arguments({
        go_parser:flatten_argument(1)
    })
})

--------------------------------------------------------------------------------
local godoc_parser = clink.arg.new_parser()
godoc_parser:set_flags(
    "-goroot", "-html", "-http", "-index", "-index_files", "-index_throttle",
    "-maxresults", "-play", "-q", "-server", "-src", "-tabwidth", "-templates",
    "-testdir", "-timestamps", "-url", "-v", "-write_index", "-zip"
)

--------------------------------------------------------------------------------
local gofmt_parser = clink.arg.new_parser()
gofmt_parser:set_flags(
    "-d", "-e", "-l", "-r", "-s", "-w",
    -- Formatting control flags
    "-comments", "-tabs", "-tabwidth"
)

--------------------------------------------------------------------------------
clink.arg.register_parser("go", go_parser)
clink.arg.register_parser("go", go_help_parser)
clink.arg.register_parser("godoc", godoc_parser)
clink.arg.register_parser("gofmt", gofmt_parser)
