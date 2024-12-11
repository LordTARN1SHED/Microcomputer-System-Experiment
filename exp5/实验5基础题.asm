DATA SEGMENT
NUMBER1 DB 8 DUP(0) ; 被加数参数列表，8个字节大小，初始值为0
NUMBER2 DB 8 DUP(0) ; 加数参数列表，8个字节大小，初始值为0
NUMBER3 DB 9 DUP(0) ; 和参数列表，9个字节大小，初始值为0
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN PROC FAR ; 主程序定义为 FAR 类型

MOV AX,DATA
MOV DS,AX ; 将数据段的地址加载到DS寄存器中，以便访问数据段的变量

CALL SUB1 ; 调用SUB1非压缩BCD码接收子程序
POP CX ; 取被加数位数

LEA BX,NUMBER1 ; 取被加数参数表地址
AA3: POP AX ; 取被加数个位、十位、百位...
MOV [BX],AL ; 将被加数存入参数表
INC BX ; 形成下一个地址
LOOP AA3 ; 循环，直到被加数的所有位都被处理完毕

MOV AH,3 ; 查找当前光标位置
INT 10H

MOV AH,2 ; 设置光标位置
MOV DL,8
INT 10H

MOV DL,2BH ; 输出加号(+)
MOV AH,2
INT 21H

CALL SUB1 ; 调用SUB1非压缩BCD码接收子程序
POP CX ; 取加数位数

LEA BX,NUMBER2 ; 取加数参数表地址
AA4: POP AX ; 取加数个位、十位、百位...
MOV [BX],AL ; 将加数存入参数表
INC BX ; 形成下一个地址
LOOP AA4 ; 循环，直到加数的所有位都被处理完毕

MOV AH,3 ; 查找当前光标位置
INT 10H

MOV AH,2 ; 设置光标位置
MOV DL,17
INT 10H

MOV DL,3DH ; 输出等号(=)
MOV AH,2
INT 21H

LEA SI,NUMBER1 ; 取被加数参数表地址
LEA DI,NUMBER2 ; 取加数参数表地址
LEA BX,NUMBER3 ; 取和参数表地址

SUB CX,CX ; 将CX清零，用作计数器
MOV CX,8 ; 加位数计数器初值

AA5: MOV AL,[SI] ; 取被加数
ADC AL,[DI] ; 非压缩BCD码加法
AAA ; 调整和的结果

MOV [BX],AX ; 将和存到NUMBER3中
INC SI ; 形成下一个地址
INC DI ; 形成下一个地址
INC BX ; 形成下一个地址
LOOP AA5 ; 循环，直到加法运算的所有位都被处理完毕

ADC CL,CL ; 最高位送CL
MOV [BX],CL ; 存储最高位

LEA AX,NUMBER3+8 ; 取和参数表最高位地址
PUSH AX ; 向子程序提供和参数表最高位地址
CALL SUB2 ; 非压缩BCD码显示子程序

MOV CX,16
LEA BX,NUMBER1 ; 取被加数参数表地址
XOR AL,AL
QQQ2: MOV [BX],AL ; 将被加数参数表的值清零
INC BX
LOOP QQQ2

MOV AH,4CH ; 返回DOS
INT 21H

SUB1 PROC NEAR ; 非压缩BCD码数据输入子程序
POP BX ; 保存返回地址
SUB CX,CX ; 键入位数计数器清零

AA1: MOV AH,1
INT 21H

CMP AL,30H ; 判断是否小于0键，如果是，则返回主程序
JC AA2

CMP AL,3AH ; 判断是否大于9键，如果是，则返回主程序
JNC AA2

INC CX ; 输入数据位数
PUSH AX ; 非压缩BCD码压栈
JMP AA1 ; 继续接收输入的数据

AA2: PUSH CX ; 输入数据位数压栈
PUSH BX ; 返回地址压栈
RET ; 返回主函数

SUB1 ENDP

SUB2 PROC NEAR ; 非压缩BCD码显示子程序
POP AX ; 保存返回地址
POP BX ; 取和参数表最高位地址
PUSH AX ; 返回地址压栈

MOV CX,9

AA7: MOV AL,[BX] ; 消除头部的无效数字0
CMP AL,0
JNZ AA6

DEC CX
DEC BX
JMP AA7

AA6: MOV DL,[BX] ; 取和最高位、次高位...个位
ADD DL,30H ; 将数字转换为ASCII码
MOV AH,2
INT 21H

DEC BX
LOOP AA6

RET

SUB2 ENDP

CODE ENDS
END MAIN
