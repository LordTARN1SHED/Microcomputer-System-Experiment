DATA SEGMENT
STRING1 DB 'ABCDEF' ;���������ַ���
STRING2 DB 'ABCDEFG'
YES DB 'YES$'
NO DB 'NO$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA

MAIN PROC FAR
MOV AX,DATA        ; �����ݶε��׵�ַװ��AX�Ĵ���
MOV DS,AX          ; ��DS�Ĵ�������Ϊ���ݶεĵ�ַ
MOV CX,STRING2-STRING1  ; �����ַ������ȣ�����CX�Ĵ���
MOV BX,YES-STRING2  ; �����ַ������ȣ�����BX�Ĵ���

CMP CX,BX          ; �Ƚ������ַ����ĳ���
JNZ AA2            ; ������Ȳ���ȣ���ת�����AA2�������"NO"

LEA BX,STRING1     ; ��STRING1�ĵ�ַװ��BX�Ĵ���
LEA SI,STRING2     ; ��STRING2�ĵ�ַװ��SI�Ĵ���

AA1:               ; ѭ����ʼ���
MOV AL,[BX]        ; ��BX�Ĵ���ָ����ڴ�λ�õ�ֵװ��AL�Ĵ�������ȡ���ַ���1���ַ�
MOV AH,[SI]        ; ��SI�Ĵ���ָ����ڴ�λ�õ�ֵװ��AH�Ĵ�������ȡ���ַ���2���ַ�
CMP AL,AH          ; �Ƚ��ַ���1���ַ���2��Ӧλ�õ��ַ�
JNZ AA2            ; �������ȣ���ת�����AA2�������"NO"

INC BX             ; �ַ���ȣ���BX�Ĵ���������ָ���ַ���1����һ���ַ�
INC SI             ; �ַ���ȣ���SI�Ĵ���������ָ���ַ���2����һ���ַ�
LOOP AA1           ; ����ѭ����ֱ��CX�Ĵ�����ֵΪ0�����ַ����ȽϽ���

MOV AH,9           ; ����AH�Ĵ�����ֵΪ9����ʾ��ӡ�ַ���
LEA DX,YES         ; ��YES�ĵ�ַװ��DX�Ĵ�����׼����ӡ"Yes"
INT 21H            ; ����21H�жϣ�ִ�д�ӡ����

MOV AH,4CH         ; ����AH�Ĵ�����ֵΪ4CH����ʾ������ֹ
INT 21H            ; ����21H�жϣ�����������ֹ

AA2:               ; �ַ������Ȳ���Ȼ��ַ��Ƚ�ʧ��ʱ�ı��
MOV AH,9           ; ����AH�Ĵ�����ֵΪ9����ʾ��ӡ�ַ���
LEA DX,NO          ; ��NO�ĵ�ַװ��DX�Ĵ�����׼����ӡ"No"
INT 21H            ; ����21H�жϣ�ִ�д�ӡ����

MOV AH,4CH         ; ����AH�Ĵ�����ֵΪ4CH����ʾ������ֹ
INT 21H            ; ����21H�жϣ�����������ֹ

MAIN ENDP
CODE ENDS
END MAIN
