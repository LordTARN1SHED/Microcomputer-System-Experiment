DATA SEGMENT
    STRING DB 100 DUP(0) ;用来存放输入的字符串，最大长度为100字节
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA

MAIN PROC FAR
    MOV AX,DATA
    MOV DS,AX ;将DS寄存器设置为数据段的段地址

    LEA BX,STRING ;将字符串的起始地址加载到BX寄存器
    MOV CL,0 ;小写字母数，初始化为0

AA1:
    MOV AH,1 ;输入字符
    INT 21H

    CMP AL,0DH ;当输入回车时，计算小写字母个数并输出
    JZ AA3

    CMP AL,41H ;小于 'A' 的字符，退出
    JC AA4

    CMP AL,5BH ;大于 'Z' 的字符，退出
    JNC AA2

    MOV [BX],AL ;将输入的字符存入内存
    INC BX ;移动到下一个存储位置
    JMP AA1 ;继续输入字符

AA2:
    CMP AL,61H ;小于 'a' 而大于 'Z' 的字符，退出
    ;这是a
    JC AA4

    CMP AL,7BH ;大于 'z' 的字符，退出
    ;这是123，122是z
    JNC AA4

    MOV [BX],AL ;将输入的字符存入内存
    INC BX ;移动到下一个存储位置
    INC CL ;小写字母数量加一
    JMP AA1 ;继续输入字符

AA3:
    PUSH CX ;保存小写字母的数量
    MOV AH,3 ;获取当前光标位置
    INT 10H

    MOV AH,2 ;设置光标位置
    LEA DI,STRING ;将字符串的起始地址加载到DI寄存器
    SUB BX,DI ;计算光标列位置
    MOV DL,BL ;将光标列位置保存到DL寄存器
    INC DL ;光标向后移动一位
    INT 10H

    POP CX ;恢复小写字母的数量
    MOV DL,CL
    ADD DL,30H ;将小写字母数量从十进制转换成十六进制

    CMP DL, 3AH ;检查是否大于9
    JBE DisplayDigit ;小于等于9，直接显示
    ADD DL, 7H ;大于9，加上7H转换成A-F的ASCII码

DisplayDigit:
    MOV AH, 2 ;显示DL寄存器中的字符
    INT 21H

AA4:
    MOV AH, 4CH ;程序结束，返回DOS
    INT 21H

CODE ENDS

END MAIN ;程序结束
