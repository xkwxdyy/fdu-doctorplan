# fdu-doctorplan

复旦大学博士科研计划书文档类。该类保留原仓库的 `fdu-doctorplan` 类名和 `\fdpsetup` 接口；可从本项目的 `templates/main.tex` 开始使用。归档恢复的个人申请材料位于 `applications/`。

## 独立仓库维护

本目录由独立仓库 [`xkwxdyy/fdu-doctorplan`](https://github.com/xkwxdyy/fdu-doctorplan) 维护。
在本目录执行 `git commit` 和 `git push`，操作对象均为本项目。
`fduTeX` 仅通过 Git 子模块记录本项目的版本，不直接维护本项目源码。

首次在总项目中维护子模块时，先确认当前分支为 `main`；首次递归检出可能处于分离的提交状态。
先推送本项目，再按需更新 `fduTeX` 记录的子模块版本。
个人材料、活动资产和编译产物继续保留在本地，不因迁移而删除。

公开仓库不纳入 `applications/`、个人参考材料或本地分享压缩包。
