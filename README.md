# project-manager

A project-manager script written by shell.

用shell写的项目管理脚本。


## usage 

./pm init: to init two git repo.

./pm test: to check git and git repos.

./pm clone: to clone the two repos from url.

./pm config \[draft|finalization\]: config repo's remote url.

./pm pull | ./pm -p: pull the two repos' codes.

./pm draft | ./pm -d: push the draft repo to remote repo.

./pm finalization | ./pm -f: copy the code files from draft to finalization.

## 用法

./pm init: 初始化draft和finalization两个仓库。

./pm test: 检测环境（git和两个目录）。

./pm clone: 从输入的url克隆两个仓库。

./pm config \[draft|finalization\]: 设置指定仓库的远程仓库链接。

./pm pull | ./pm -p: 从远程仓库拉取两个仓库的代码。

./pm draft | ./pm -d: 将draft仓库的代码推送到远程仓库。

./pm finalization | ./pm -f: 将draft的文件复制到finalization仓库中，等待手动commit。
