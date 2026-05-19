#!/usr/bin/env fish
# install.sh — 安装 dnf5 fish completions

set COMPLETION_DIR ~/.config/fish/completions

if not test -d $COMPLETION_DIR
    mkdir -p $COMPLETION_DIR
end

cp (dirname (status filename))"/completions/dnf.fish" $COMPLETION_DIR/
echo "✅ Installed to $COMPLETION_DIR/dnf.fish"
echo "🔄 Run: source $COMPLETION_DIR/dnf.fish"
echo "   or open a new terminal"
