#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)
target_dir=$script_dir/scripts

# スクリプトへの実行権限付与
find $target_dir -type f -name "*.sh" | xargs chmod 755
