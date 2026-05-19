# dnf5-fish-completion

Fish shell completions for `dnf` / `dnf5` — powered by dnf5's own completion engine.

不依赖手工列子命令，直接调用 dnf5 内置 `--complete` 接口，自动覆盖所有子命令。

## 与官方 fish 补全的区别

fish 官方在 `share/completions/dnf.fish` 里内置了一套 dnf 补全，但它是**手工逐个列举子命令**的。我们的方案走的是不同路子：

| | 官方 fish 补全 | 本方案 |
|---|---|---|
| 实现 | 手工 `complete -c dnf -xa copr` … | 调用 `dnf5 --complete=$cword` |
| 覆盖范围 | 常见子命令（~20 个） | **全部** dnf5 子命令（46 个） |
| `copr` | ✅ list/enable/disable/remove/debug | ✅ 同上 |
| `advisory` / `builddep` / `changelog` / … | ❌ 没列 | ✅ 自动覆盖 |
| dnf5 升级加新子命令 | 等 fish 发版更新 | **自动适配**，无需等待 |
| 代码量 | ~500 行 | **~20 行** |

**简单说：官方补全是手写的清单，我们是直接问 dnf5 "你能补啥"。** 后者更薄、更全、更省心。

## 安装

```fish
git clone https://github.com/<你的用户名>/dnf5-fish-completion
cp dnf5-fish-completion/completions/dnf.fish ~/.config/fish/completions/
```

或者用附带的安装脚本：

```fish
source dnf5-fish-completion/install.sh
```

**重启 fish 终端**或 `source ~/.config/fish/completions/dnf.fish` 即可生效。

> 注意：本补全会覆盖 fish 官方自带的 `dnf.fish`，因为后者覆盖不全且维护滞后。如有需要可随时删除本文件恢复官方版本。

## 补全范围

| 输入 | 补全 |
|---|---|
| `dnf ` + Tab | 全部顶级子命令：`install`, `remove`, `search`, `copr`, `advisory`, `builddep`, … 共 46 个 |
| `dnf5 ` + Tab | 同上 |
| `dnf install ` + Tab | 可安装的包名 |
| `dnf remove ` + Tab | 已安装的包名 |
| `dnf copr ` + Tab | `list`, `enable`, `disable`, `remove`, `debug` |
| `dnf search ` + Tab | 搜索关键词 |

## 依赖

- fish 3.0+
- dnf5（Fedora 41+）

## 许可证

MIT — 随便用随便改
