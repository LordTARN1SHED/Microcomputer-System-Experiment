DATA SEGMENT
MATRIX1 DB 3H,4H,15H,8H  ; ����MATRIX1���󣬰���4��4�е��ֽ�����
DB 4H,5H,6H,17H
DB 8H,9H,3H,2H
DB 1H,1H,4H,6H
MATRIX2 DB 0F3H,0F9H,8H,0E6H  ; ����MATRIX2���󣬰���1��4�е��ֽ�����
UNIT DW 4 DUP(0)  ; ����UNIT���飬����4���ֵĿռ䣬��ʼֵΪ0
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA  ; �����ݶε�ַ��ֵ��AX�Ĵ���
MOV DS,AX  ; ��AX�Ĵ�����ֵ����DS�Ĵ������������ݶμĴ���

LEA SI,MATRIX1  ; ��MATRIX1��ƫ�Ƶ�ַ����SI�Ĵ���
LEA DI,MATRIX2  ; ��MATRIX2��ƫ�Ƶ�ַ����DI�Ĵ���
LEA BX,UNIT  ; ��UNIT��ƫ�Ƶ�ַ����BX�Ĵ���

MOV CL,4H  ; �������ѭ����������ֵΪ4

AA0: SUB AX,AX  ; ���AX�Ĵ�����ֵ
MOV CH,4H  ; �����ڲ�ѭ����������ֵΪ4

AA1: MOV DX,AX  ; ��AX��ֵ�洢��DX�Ĵ���
MOV AL,[DI]  ; ��[DI]�ڴ��е�ֵ���ص�AL�Ĵ���
MUL BYTE PTR[SI]  ; ��AL��[SI]�ڴ��е�ֵ��ˣ�����洢��AX��
ADD AX,DX  ; ��AX��DX��ӣ�����洢��AX��
INC SI  ; ��SI�Ĵ�����ֵ��1���ƶ�����һ��MATRIX1��Ԫ��
INC DI  ; ��DI�Ĵ�����ֵ��1���ƶ�����һ��MATRIX2��Ԫ��
DEC CH  ; �ڲ�ѭ����������1
JNZ AA1  ; ����ڲ�ѭ����������Ϊ0����ת��AA1��ǩ������ѭ��

LEA DI,MATRIX2  ; ��MATRIX2��ƫ�Ƶ�ַ����DI�Ĵ���
MOV [BX],AX  ; ��AX�Ĵ����е�ֵ�洢��BX��ָ����ڴ��ַ�������������
INC BX  ; ��BX�Ĵ�����ֵ��1���ƶ�����һ��UNIT�����Ԫ��
INC BX  ; �ٴν�BX�Ĵ�����ֵ��1���ƶ�����һ��UNIT�����Ԫ��
DEC CL  ; ���ѭ����������1
JNZ AA0  ; ������ѭ����������Ϊ0����ת��AA0��ǩ������ѭ��

MOV AH,4CH  ; ����AH�Ĵ�����ֵΪ4CH����ʾ������ֹ
INT 21H  ; ����21H�жϣ�DOS���ܵ��ã�
CODE ENDS
END START
