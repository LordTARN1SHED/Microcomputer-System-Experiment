DATA SEGMENT
NUMBER1 DB 8 DUP(0) ; �����������б�8���ֽڴ�С����ʼֵΪ0
NUMBER2 DB 8 DUP(0) ; ���������б�8���ֽڴ�С����ʼֵΪ0
NUMBER3 DB 9 DUP(0) ; �Ͳ����б�9���ֽڴ�С����ʼֵΪ0
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN PROC FAR ; ��������Ϊ FAR ����

MOV AX,DATA
MOV DS,AX ; �����ݶεĵ�ַ���ص�DS�Ĵ����У��Ա�������ݶεı���

CALL SUB1 ; ����SUB1��ѹ��BCD������ӳ���
POP CX ; ȡ������λ��

LEA BX,NUMBER1 ; ȡ�������������ַ
AA3: POP AX ; ȡ��������λ��ʮλ����λ...
MOV [BX],AL ; �����������������
INC BX ; �γ���һ����ַ
LOOP AA3 ; ѭ����ֱ��������������λ�����������

MOV AH,3 ; ���ҵ�ǰ���λ��
INT 10H

MOV AH,2 ; ���ù��λ��
MOV DL,8
INT 10H

MOV DL,2BH ; ����Ӻ�(+)
MOV AH,2
INT 21H

CALL SUB1 ; ����SUB1��ѹ��BCD������ӳ���
POP CX ; ȡ����λ��

LEA BX,NUMBER2 ; ȡ�����������ַ
AA4: POP AX ; ȡ������λ��ʮλ����λ...
MOV [BX],AL ; ���������������
INC BX ; �γ���һ����ַ
LOOP AA4 ; ѭ����ֱ������������λ�����������

MOV AH,3 ; ���ҵ�ǰ���λ��
INT 10H

MOV AH,2 ; ���ù��λ��
MOV DL,17
INT 10H

MOV DL,3DH ; ����Ⱥ�(=)
MOV AH,2
INT 21H

LEA SI,NUMBER1 ; ȡ�������������ַ
LEA DI,NUMBER2 ; ȡ�����������ַ
LEA BX,NUMBER3 ; ȡ�Ͳ������ַ

SUB CX,CX ; ��CX���㣬����������
MOV CX,8 ; ��λ����������ֵ

AA5: MOV AL,[SI] ; ȡ������
ADC AL,[DI] ; ��ѹ��BCD��ӷ�
AAA ; �����͵Ľ��

MOV [BX],AX ; ���ʹ浽NUMBER3��
INC SI ; �γ���һ����ַ
INC DI ; �γ���һ����ַ
INC BX ; �γ���һ����ַ
LOOP AA5 ; ѭ����ֱ���ӷ����������λ�����������

ADC CL,CL ; ���λ��CL
MOV [BX],CL ; �洢���λ

LEA AX,NUMBER3+8 ; ȡ�Ͳ��������λ��ַ
PUSH AX ; ���ӳ����ṩ�Ͳ��������λ��ַ
CALL SUB2 ; ��ѹ��BCD����ʾ�ӳ���

MOV CX,16
LEA BX,NUMBER1 ; ȡ�������������ַ
XOR AL,AL
QQQ2: MOV [BX],AL ; ���������������ֵ����
INC BX
LOOP QQQ2

MOV AH,4CH ; ����DOS
INT 21H

SUB1 PROC NEAR ; ��ѹ��BCD�����������ӳ���
POP BX ; ���淵�ص�ַ
SUB CX,CX ; ����λ������������

AA1: MOV AH,1
INT 21H

CMP AL,30H ; �ж��Ƿ�С��0��������ǣ��򷵻�������
JC AA2

CMP AL,3AH ; �ж��Ƿ����9��������ǣ��򷵻�������
JNC AA2

INC CX ; ��������λ��
PUSH AX ; ��ѹ��BCD��ѹջ
JMP AA1 ; �����������������

AA2: PUSH CX ; ��������λ��ѹջ
PUSH BX ; ���ص�ַѹջ
RET ; ����������

SUB1 ENDP

SUB2 PROC NEAR ; ��ѹ��BCD����ʾ�ӳ���
POP AX ; ���淵�ص�ַ
POP BX ; ȡ�Ͳ��������λ��ַ
PUSH AX ; ���ص�ַѹջ

MOV CX,9

AA7: MOV AL,[BX] ; ����ͷ������Ч����0
CMP AL,0
JNZ AA6

DEC CX
DEC BX
JMP AA7

AA6: MOV DL,[BX] ; ȡ�����λ���θ�λ...��λ
ADD DL,30H ; ������ת��ΪASCII��
MOV AH,2
INT 21H

DEC BX
LOOP AA6

RET

SUB2 ENDP

CODE ENDS
END MAIN
