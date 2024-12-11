DSEG SEGMENT PARA PUBLIC 'DSEG'; 定义数据段DSEG，用于存储数据
M DB 1H,2H,3H,4H,5H,6H,7H,8H,9H,10H,-1H,-2H,-3H,-4H,-5H,-6H,-7H,-8H,-9H,-10H, ;填写实际需要分组的数值
P DB 20 DUP(0)
N DB 20 DUP(1)
DSEG ENDS ; 数据段DSEG定义结束

CODE SEGMENT ; 定义代码段CODE
ASSUME CS:CODE,DS:DSEG ; 设置代码段和数据段的段寄存器

START: 
MOV AX,DSEG ; 将数据段DSEG的段地址加载到寄存器AX中
MOV DS,AX ; 将DS寄存器设置为数据段DSEG的段地址

LEA SI,P ; 将正数数组P的首地址加载到寄存器SI中
LEA DI,N ; 将负数数组N的首地址加载到寄存器DI中
LEA BX,M ; 将输入数组M的首地址加载到寄存器BX中

XOR AX,AX ; 将AX寄存器清零
XOR DX,DX ; 将DX寄存器清零

MOV CX,20 ; 将CX寄存器设置为20，即循环次数为20

L1: MOV AL,[BX] ; 将BX寄存器指向的内存地址中的值加载到AL寄存器中
TEST AL,80H ; 将AL寄存器与80H进行逻辑与运算，检查最高位是否为1
JZ L2 ; 如果最高位为0，则跳转到标签L2

MOV [DI],AL ; 将AL寄存器的值存储到DI寄存器指向的内存地址中，即放入负数数组N
INC BX ; 增加BX的值，指向下一个输入数组的元素
INC DI ; 增加DI的值，指向下一个负数数组的位置
INC DH ; 增加DH的值，即负数个数增加
JMP L3 ; 跳转到标签L3

L2: MOV [SI],AL ; 将AL寄存器的值存储到SI寄存器指向的内存地址中，即放入正数数组P
INC BX ; 增加BX的值，指向下一个输入数组的元素
INC SI ; 增加SI的值，指向下一个正数数组的位置
INC DL ; 增加DL的值，即正数个数增加

L3: LOOP L1 ; 循环，继续执行标签L1处的指令，直到CX寄存器的值为0

MOV CX,2 ; 将CX寄存器设置为2，用于后续输出操作

L5: MOV BL,DL ; 将DL寄存器的值复制到BL寄存器中，然后每4位输出
SHR DL,1 ; 将DL寄存器右移1位，相当于除以2
SHR DL,1 ; 将DL寄存器右移1位
SHR DL,1 ; 将DL寄存器右移1位
SHR DL,1 ; 将DL寄存器右移1位
AND DL,0FH ; 将DL寄存器与0FH进行逻辑与运算，保留低4位的值

CMP DL,10 ; 将DL寄存器的值与10进行比较
JB L4 ; 如果DL的值小于10，则跳转到标签L4

ADD DL,7 ; 如果DL的值大于等于10，加7进行调整后输出

L4: ADD DL,30H ; 将DL的值加上30H，即将数字转换为ASCII码值进行输出

MOV AH,2 ; 将AH寄存器设置为2，表示进行字符输出
INT 21H ; 调用21H中断，实现字符输出

MOV DL,BL ; 将BL寄存器的值复制到DL寄存器中
AND DL,0FH ; 将DL寄存器与0FH进行逻辑与运算，保留低4位的值

CMP DL,10 ; 将DL寄存器的值与10进行比较
JB L6 ; 如果DL的值小于10，则跳转到标签L6

ADD DL,7 ; 如果DL的值大于等于10，加7进行调整后输出

L6: ADD DL,30H ; 将DL的值加上30H，即将数字转换为ASCII码值进行输出

MOV AH,2 ; 将AH寄存器设置为2，表示进行字符输出
INT 21H ; 调用21H中断，实现字符输出

MOV DL,0AH ; 将DL寄存器设置为换行符的ASCII码值
MOV AH,2 ; 将AH寄存器设置为2，表示进行字符输出
INT 21H ; 调用21H中断，实现字符输出

MOV DL,0DH ; 将DL寄存器设置为回车符的ASCII码值
MOV AH,2 ; 将AH寄存器设置为2，表示进行字符输出
INT 21H ; 调用21H中断，实现字符输出
MOV DL,DH ; 将DH的值复制到DL寄存器中，即负数个数进行输出
LOOP L5 ; 循环，继续执行标签L5处的指令，直到CX寄存器的值为0
MOV AH,4CH ; 将AH寄存器设置为4CH，表示程序退出
INT 21H ; 调用21H中断，实现程序退出

CODE ENDS ; 代码段CODE定义结束
END START ; 程序结束
