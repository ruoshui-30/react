#!/bin/bash

OUTPUT_FILE="combined_text.txt"
DIRECTORY_PATH="$(pwd)"  # 获取当前工作目录

# 编码转换函数
convert_encoding() {
    local input_file="$1"
    iconv -f ISO-8859-1 -t UTF-8 "$input_file" -o "$input_file".utf8
    echo "$input_file".utf8
}

> $OUTPUT_FILE

for FILE in "$DIRECTORY_PATH"/*; do
    # 如果遇到输出文件本身，则跳过
    if [ "$FILE" == "$DIRECTORY_PATH/$OUTPUT_FILE" ]; then
        continue
    fi
    
    FILE_NAME=$(basename "$FILE")
    
    # 对文件执行编码转换
    CONVERTED_FILE=$(convert_encoding "$FILE")
    
    if [[ "$FILE_NAME" == *.html ]]; then
        echo "### $FILE_NAME" >> $OUTPUT_FILE
        echo '```html' >> $OUTPUT_FILE
        cat "$CONVERTED_FILE" >> $OUTPUT_FILE
        echo '```' >> $OUTPUT_FILE
    else
        echo "## $FILE_NAME" >> $OUTPUT_FILE
        cat "$CONVERTED_FILE" >> $OUTPUT_FILE
    fi
    
    # 删除转换后的文件
    rm "$CONVERTED_FILE"

    echo "" >> $OUTPUT_FILE
done

echo "内容已写入到$OUTPUT_FILE中。"
