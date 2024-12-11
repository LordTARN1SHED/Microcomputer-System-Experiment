DATA SEGMENT
STRING1 DB 'ABCDEF' ;存放输入的字符串
STRING2 DB 'ABCDEFG'
YES DB 'YES$'
NO DB 'NO$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA

MAIN PROC FAR
MOV AX,DATA        ; 将数据段的首地址装入AX寄存器
MOV DS,AX          ; 将DS寄存器设置为数据段的地址
MOV CX,STRING2-STRING1  ; 计算字符串长度，存入CX寄存器
MOV BX,YES-STRING2  ; 计算字符串长度，存入BX寄存器

CMP CX,BX          ; 比较两个字符串的长度
JNZ AA2            ; 如果长度不相等，跳转到标号AA2处，输出"NO"

LEA BX,STRING1     ; 将STRING1的地址装入BX寄存器
LEA SI,STRING2     ; 将STRING2的地址装入SI寄存器

AA1:               ; 循环开始标号
MOV AL,[BX]        ; 将BX寄存器指向的内存位置的值装入AL寄存器，即取得字符串1的字符
MOV AH,[SI]        ; 将SI寄存器指向的内存位置的值装入AH寄存器，即取得字符串2的字符
CMP AL,AH          ; 比较字符串1和字符串2对应位置的字符
JNZ AA2            ; 如果不相等，跳转到标号AA2处，输出"NO"

INC BX             ; 字符相等，将BX寄存器递增，指向字符串1的下一个字符
INC SI             ; 字符相等，将SI寄存器递增，指向字符串2的下一个字符
LOOP AA1           ; 继续循环，直到CX寄存器的值为0，即字符串比较结束

MOV AH,9           ; 设置AH寄存器的值为9，表示打印字符串
LEA DX,YES         ; 将YES的地址装入DX寄存器，准备打印"Yes"
INT 21H            ; 调用21H中断，执行打印操作

MOV AH,4CH         ; 设置AH寄存器的值为4CH，表示程序终止
INT 21H            ; 调用21H中断，程序正常终止

AA2:               ; 字符串长度不相等或字符比较失败时的标号
MOV AH,9           ; 设置AH寄存器的值为9，表示打印字符串
LEA DX,NO          ; 将NO的地址装入DX寄存器，准备打印"No"
INT 21H            ; 调用21H中断，执行打印操作

MOV AH,4CH         ; 设置AH寄存器的值为4CH，表示程序终止
INT 21H            ; 调用21H中断，程序正常终止

MAIN ENDP
CODE ENDS
END MAIN
