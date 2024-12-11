DATA SEGMENT
MATRIX1 DB 3H,4H,15H,8H  ; 定义MATRIX1矩阵，包含4行4列的字节数据
DB 4H,5H,6H,17H
DB 8H,9H,3H,2H
DB 1H,1H,4H,6H
MATRIX2 DB 0F3H,0F9H,8H,0E6H  ; 定义MATRIX2矩阵，包含1行4列的字节数据
UNIT DW 4 DUP(0)  ; 定义UNIT数组，包含4个字的空间，初始值为0
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA  ; 将数据段地址赋值给AX寄存器
MOV DS,AX  ; 将AX寄存器的值赋给DS寄存器，设置数据段寄存器

LEA SI,MATRIX1  ; 将MATRIX1的偏移地址赋给SI寄存器
LEA DI,MATRIX2  ; 将MATRIX2的偏移地址赋给DI寄存器
LEA BX,UNIT  ; 将UNIT的偏移地址赋给BX寄存器

MOV CL,4H  ; 设置外层循环计数器初值为4

AA0: SUB AX,AX  ; 清空AX寄存器的值
MOV CH,4H  ; 设置内层循环计数器初值为4

AA1: MOV DX,AX  ; 将AX的值存储到DX寄存器
MOV AL,[DI]  ; 将[DI]内存中的值加载到AL寄存器
MUL BYTE PTR[SI]  ; 将AL与[SI]内存中的值相乘，结果存储在AX中
ADD AX,DX  ; 将AX与DX相加，结果存储在AX中
INC SI  ; 将SI寄存器的值加1，移动到下一个MATRIX1的元素
INC DI  ; 将DI寄存器的值加1，移动到下一个MATRIX2的元素
DEC CH  ; 内层循环计数器减1
JNZ AA1  ; 如果内层循环计数器不为0，跳转到AA1标签处继续循环

LEA DI,MATRIX2  ; 将MATRIX2的偏移地址赋给DI寄存器
MOV [BX],AX  ; 将AX寄存器中的值存储到BX所指向的内存地址（保存计算结果）
INC BX  ; 将BX寄存器的值加1，移动到下一个UNIT数组的元素
INC BX  ; 再次将BX寄存器的值加1，移动到下一个UNIT数组的元素
DEC CL  ; 外层循环计数器减1
JNZ AA0  ; 如果外层循环计数器不为0，跳转到AA0标签处继续循环

MOV AH,4CH  ; 设置AH寄存器的值为4CH，表示程序终止
INT 21H  ; 调用21H中断（DOS功能调用）
CODE ENDS
END START
