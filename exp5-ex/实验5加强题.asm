DATA SEGMENT
ARRAY DB 13,24,92,42,25,46,75,81,53,10 ; 声明一个数组，包含了一组数字
MA DB ' MAX = ','$' ; 声明一个字符串常量，用于显示最大值
MI DB 0DH,0AH,' MIN = $' ; 声明一个字符串常量，用于显示最小值
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA

MAIN PROC FAR ; 主程序定义为 FAR 类型
    MOV AX,DATA ; 将数据段的地址加载到 AX 寄存器
    MOV DS,AX ; 将 AX 寄存器中的值移动到 DS 寄存器，将数据段设置为 DS 寄存器的值

    LEA DX,MA ; 将字符串 "MAX = " 的地址加载到 DX 寄存器
    MOV AH,9 ; 设置 AH 寄存器的值为 9，表示要打印字符串
    INT 21H ; 调用 DOS 中断 21H，显示字符串

    LEA BX,ARRAY ; 将数组 ARRAY 的地址加载到 BX 寄存器
    CALL MAX ; 调用 MAX 过程，查找最大值
    CMP DL,10 ; 检查最大值是否为两位数
    JC AA6 ; 如果最大值为两位数，跳转到标签 AA6

    MOV DH,30H ; 将十位数的 ASCII 值加载到 DH 寄存器
AA5: INC DH ; 十位数加一
    SUB DL,10 ; 对个位数进行模 10
    CMP DL,10 ; 检查是否超过个位数的范围
    JNC AA5 ; 如果超过范围，跳转到标签 AA5

    PUSH DX ; 将最大值保存在堆栈中
    MOV DL,DH ; 将十位数的值移动到 DL 寄存器，准备显示
    MOV AH,2 ; 设置 AH 寄存器的值为 2，表示要打印字符
    INT 21H ; 调用 DOS 中断 21H，显示十位数

    POP DX ; 恢复最大值到 DX 寄存器
AA6: ADD DL,30H ; 将个位数的 ASCII 值加载到 DL 寄存器
    MOV AH,2 ; 设置 AH 寄存器的值为 2，表示要打印字符
    INT 21H ; 调用 DOS 中断 21H，显示个位数

    LEA DX,MI ; 将字符串 "回车 MIN = " 的地址加载到 DX 寄存器
    MOV AH,9 ; 设置 AH 寄存器的值为 9，表示要打印字符串
    INT 21H ; 调用 DOS 中断 21H，显示字符串

    LEA BX,ARRAY ; 将数组 ARRAY 的地址加载到 BX 寄存器
    CALL MIN ; 调用 MIN 过程，查找最小值
    CMP DL,10 ; 检查最小值是否为两位数
    JC AA8 ; 如果最小值为两位数，跳转到标签 AA8

    MOV DH,30H ; 将十位数的 ASCII 值加载到 DH 寄存器
AA7: INC DH ; 十位数加一
    SUB DL,10 ; 对个位数进行模 10
    CMP DL,10 ; 检查是否超过个位数的范围
    JNC AA7 ; 如果超过范围，跳转到标签 AA7

    PUSH DX ; 将最小值保存在堆栈中
    MOV DL,DH ; 将十位数的值移动到 DL 寄存器，准备显示
    MOV AH,2 ; 设置 AH 寄存器的值为 2，表示要打印字符
    INT 21H ; 调用 DOS 中断 21H，显示十位数

    POP DX ; 恢复最小值到 DX 寄存器
AA8: ADD DL,30H ; 将个位数的 ASCII 值加载到 DL 寄存器
    MOV AH,2 ; 设置 AH 寄存器的值为 2，表示要打印字符
    INT 21H ; 调用 DOS 中断 21H，显示个位数

    MOV AH,4CH ; 设置 AH 寄存器的值为 4CH，表示要返回到 DOS
    INT 21H ; 调用 DOS 中断 21H

MAX PROC NEAR ; 最大值查找子过程
    MOV CX,10 ; 设置计数器的初始值为 10，用于查找循环
    MOV DL,[BX] ; 将 BX 寄存器指向的内存位置的值移动到 DL 寄存器，初始化最大值

AA1: MOV DH,[BX] ; 将 BX 寄存器指向的内存位置的值移动到 DH 寄存器
    CMP DL,DH ; 比较当前最大值和当前元素值
    JC AA2 ; 如果当前元素值大于当前最大值，跳转到标签 AA2

    INC BX ; 移动到下一个元素的位置
    DEC CX ; 计数器减一
    CMP CX,0 ; 检查计数器是否为零
    JZ OUT1 ; 如果计数器为零，跳转到标签 OUT1

    JMP AA1 ; 继续循环查找最大值

AA2: MOV DL,DH ; 更新最大值为当前元素值
    INC BX ; 移动到下一个元素的位置
    DEC CX ; 计数器减一
    CMP CX,0 ; 检查计数器是否为零
    JZ OUT1 ; 如果计数器为零，跳转到标签 OUT1
    JMP AA1 ; 继续循环查找最大值

OUT1: RET ; 返回到主函数

MAX ENDP ; MAX 过程结束

MIN PROC NEAR ; 最小值查找子过程，查找过程与 MAX 过程类似
    MOV CX,10 ; 设置计数器的初始值为 10，用于查找循环
    MOV DL,[BX] ; 将 BX 寄存器指向的内存位置的值移动到 DL 寄存器，初始化最小值

AA3: MOV DH,[BX] ; 将 BX 寄存器指向的内存位置的值移动到 DH 寄存器
    CMP DL,DH ; 比较当前最小值和当前元素值
    JNC AA4 ; 如果当前元素值小于当前最小值，跳转到标签 AA4
    INC BX ; 移动到下一个元素的位置
    DEC CX ; 计数器减一
    CMP CX,0 ; 检查计数器是否为零
    JZ OUT2 ; 如果计数器为零，跳转到标签 OUT2
    JMP AA3 ; 继续循环查找最小值

AA4: MOV DL,DH ; 更新最小值为当前元素值
    INC BX ; 移动到下一个元素的位置
    DEC CX ; 计数器减一
    CMP CX,0 ; 检查计数器是否为零  
    
    JZ OUT2 ; 如果计数器为零，跳转到标签 OUT2 
    ;要修改的地方，源代码给的是OUT1

    JMP AA3 ; 继续循环查找最小值

OUT2: RET ; 返回到主函数

MIN ENDP ; MIN 过程结束

CODE ENDS
END MAIN
