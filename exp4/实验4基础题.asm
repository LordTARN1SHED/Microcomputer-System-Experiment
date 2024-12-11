DATA SEGMENT
COURSE1 DB 70H,88H,92H,90H,99H ; 第一门课成绩
DB 67H,77H,88H,76H,69H ; 第二门课成绩
DB 74H,87H,77H,74H,70H ; 第三门课成绩
DB 99H,97H,94H,98H,96H ; 第四门课成绩
NUM1 DW 5 DUP(0) ; 用于存储学生总分的数组
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA ; 将数据段地址赋值给AX寄存器
MOV DS,AX ; 将AX寄存器的值赋给DS寄存器，设置数据段寄存器

LEA SI,COURSE1 ; 将COURSE1的偏移地址赋给SI寄存器
LEA DI, NUM1 ; 将NUM1的偏移地址赋给DI寄存器

SUB SI,5 ; 将SI寄存器的值减去5，以便循环
MOV CL,5 ; 设置外层循环计数器初值为5

AA1: MOV BX,SI ; 将SI的值赋给BX寄存器，形成某个学生第一门课成绩的地址减去5
SUB AX,AX ; 清空AX寄存器的值
MOV CH,4 ; 设置内层循环计数器初值为4

AA2: ADD BX,5 ; 将BX的值增加5，形成某个学生的1、2、...、4门课成绩的地址
ADD AL,[BX] ; 将[BX]内存中的值加到AL寄存器中，按BCD码求和
DAA ; 压缩BCD码并进行调整
ADC AH,0 ; 将进位加到AH寄存器中
DEC CH ; 内层循环计数器减1
JNZ AA2 ; 如果内层循环计数器不为0，跳转到AA2标签处继续循环

ADD [DI],AX ; 将AX寄存器中的值存储到DI所指向的内存地址（保存总分）
INC SI ; 将SI寄存器的值加1，形成下一个学生第一门课成绩的地址减去5
ADD DI,2 ; 将DI寄存器的值增加2，形成下一个学生的总分地址
DEC CL ; 外层循环计数器减1
JNZ AA1 ; 如果外层循环计数器不为0，跳转到AA1标签处继续循环

MOV AH,4CH ; 设置AH寄存器的值为4CH，表示程序终止
INT 21H ; 调用21H中断（DOS功能调用）

CODE ENDS
END START
