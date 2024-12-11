DATA SEGMENT
DIGIT DB "DIGIT",0AH,0DH  ; 存储"数字"字符串，0AH和0DH是换行符
LETTER DB "LETTER",0AH,0DH  ; 存储"字母"字符串，0AH和0DH是换行符
OTHER DB "OTHER",0AH,0DH  ; 存储"其他"字符串，0AH和0DH是换行符
DATA ENDS

CODE SEGMENT  ; 代码段开始
ASSUME CS:CODE,DS:DATA  ; 设置代码段寄存器CS和数据段寄存器DS的默认值为CODE和DATA

START: MOV AX,DATA  ; 将DATA段的起始地址加载到AX寄存器
MOV DS,AX  ; 将AX中的值移动到DS寄存器，将DS设置为DATA段的段地址

MOV AH,07  ; 设置AH寄存器为07H，表示输入字符但不回显
INT 21H  ; 调用21H中断，等待用户输入字符，结果存储在AL寄存器

CMP AL,30H  ; 将AL寄存器的值与ASCII码为30H的字符('0')进行比较
JB AA1  ; 如果小于'0'，跳转到标号AA1

CMP AL,39H  ; 将AL寄存器的值与ASCII码为39H的字符('9')进行比较
JA AA1  ; 如果大于'9'，跳转到标号AA1   
                        
                        
                        
                        
                        
;非数字就跳转到AA1
                                         
;是数字就执行下面的代码
                   
MOV CX,7  ; 将CX寄存器设置为7，用于循环显示"数字"
LEA SI,DIGIT  ; 将DIGIT字符串的偏移地址加载到SI寄存器

AA0: MOV DL,[SI]  ; 将SI指向的内存位置中的值移动到DL寄存器，即获取字符串中的一个字符
MOV AH,2  ; 设置AH寄存器为2，表示在屏幕上显示一个字符
INT 21H  ; 调用21H中断，显示DL寄存器中的字符

INC SI  ; 递增SI寄存器的值，移动到下一个字符
LOOP AA0  ; 循环执行AA0标号处的代码，循环次数为CX寄存器的值，即显示"数字"字符串的所有字符 

JMP BB  ; 跳转到标号BB，跳过后续的判断和显示代码
                                                     
                                                     
                                                     
                                                     
                                                     
;非数字，看看是不是大写字母                                                     
AA1: CMP AL,41H  ; 将AL寄存器的值与ASCII码为41H的字符('A')进行比较
JB AA3  ; 如果小于'A'，跳转到标号AA3

CMP AL,5AH  ; 将AL寄存器的值与ASCII码为5AH的字符('Z')进行比较
JA AA2  ; 如果大于'Z'，跳转到标号AA2

LEA SI,LETTER  ; 将LETTER字符串的偏移地址加载到SI寄存器
MOV CX,8  ; 将CX寄存器设置为8，用于循环显示"字母"

AA4: MOV DL,[SI]  ; 将SI指向的内存位置中的值移动到DL寄存器，即获取字符串中的一个字符
MOV AH,2  ; 设置AH寄存器为2，表示在屏幕上显示一个字符
INT 21H  ; 调用21H中断，显示DL寄存器中的字符

INC SI  ; 递增SI寄存器的值，移动到下一个字符
LOOP AA4  ; 循环执行AA4标号处的代码，循环次数为CX寄存器的值，即显示"字母"字符串的所有字符
JMP BB  ; 跳转到标号BB，跳过后续的判断和显示代码
                                                      
      
                                                      
;非数字且非大写字母看看是不是小写字母                                                      
AA2: CMP AL,61H  ; 将AL寄存器的值与ASCII码为61H的字符('a')进行比较
JB AA3  ; 如果小于'a'，跳转到标号AA3

CMP AL,7AH  ; 将AL寄存器的值与ASCII码为7AH的字符('z')进行比较
JA AA3  ; 如果大于'z'，跳转到标号AA3

LEA SI,LETTER  ; 将LETTER字符串的偏移地址加载到SI寄存器
MOV CX,8  ; 将CX寄存器设置为8，用于循环显示"字母"
                                                       
                                                       
                                                       
                                                       
                                                       
AA5: MOV DL,[SI]  ; 将SI指向的内存位置中的值移动到DL寄存器，即获取字符串中的一个字符
MOV AH,2  ; 设置AH寄存器为2，表示在屏幕上显示一个字符
INT 21H  ; 调用21H中断，显示DL寄存器中的字符

INC SI  ; 递增SI寄存器的值，移动到下一个字符
LOOP AA5  ; 循环执行AA5标号处的代码，循环次数为CX寄存器的值，即显示"字母"字符串的所有字符
JMP BB  ; 跳转到标号BB，跳过后续的判断和显示代码

AA3: LEA SI,OTHER  ; 将OTHER字符串的偏移地址加载到SI寄存器
MOV CX,7  ; 将CX寄存器设置为7，用于循环显示"其他"

AA6: MOV DL,[SI]  ; 将SI指向的内存位置中的值移动到DL寄存器，即获取字符串中的一个字符
MOV AH,2  ; 设置AH寄存器为2，表示在屏幕上显示一个字符
INT 21H  ; 调用21H中断，显示DL寄存器中的字符

INC SI  ; 递增SI寄存器的值，移动到下一个字符
LOOP AA6  ; 循环执行AA6标号处的代码，循环次数为CX寄存器的值，即显示"其他"字符串的所有字符

BB: MOV AH,4CH  ; 设置AH寄存器为4CH，表示程序的正常退出
INT 21H  ; 调用21H中断，结束程序的执行

CODE ENDS  ; 代码段结束
END START  ; 程序的入口点为START标号处，程序结束
