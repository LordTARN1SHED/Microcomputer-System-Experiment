DATA SEGMENT
    STRING DB 100 DUP(0) ;�������������ַ�������󳤶�Ϊ100�ֽ�
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA

MAIN PROC FAR
    MOV AX,DATA
    MOV DS,AX ;��DS�Ĵ�������Ϊ���ݶεĶε�ַ

    LEA BX,STRING ;���ַ�������ʼ��ַ���ص�BX�Ĵ���
    MOV CL,0 ;Сд��ĸ������ʼ��Ϊ0

AA1:
    MOV AH,1 ;�����ַ�
    INT 21H

    CMP AL,0DH ;������س�ʱ������Сд��ĸ���������
    JZ AA3

    CMP AL,41H ;С�� 'A' ���ַ����˳�
    JC AA4

    CMP AL,5BH ;���� 'Z' ���ַ����˳�
    JNC AA2

    MOV [BX],AL ;��������ַ������ڴ�
    INC BX ;�ƶ�����һ���洢λ��
    JMP AA1 ;���������ַ�

AA2:
    CMP AL,61H ;С�� 'a' ������ 'Z' ���ַ����˳�
    ;����a
    JC AA4

    CMP AL,7BH ;���� 'z' ���ַ����˳�
    ;����123��122��z
    JNC AA4

    MOV [BX],AL ;��������ַ������ڴ�
    INC BX ;�ƶ�����һ���洢λ��
    INC CL ;Сд��ĸ������һ
    JMP AA1 ;���������ַ�

AA3:
    PUSH CX ;����Сд��ĸ������
    MOV AH,3 ;��ȡ��ǰ���λ��
    INT 10H

    MOV AH,2 ;���ù��λ��
    LEA DI,STRING ;���ַ�������ʼ��ַ���ص�DI�Ĵ���
    SUB BX,DI ;��������λ��
    MOV DL,BL ;�������λ�ñ��浽DL�Ĵ���
    INC DL ;�������ƶ�һλ
    INT 10H

    POP CX ;�ָ�Сд��ĸ������
    MOV DL,CL
    ADD DL,30H ;��Сд��ĸ������ʮ����ת����ʮ������

    CMP DL, 3AH ;����Ƿ����9
    JBE DisplayDigit ;С�ڵ���9��ֱ����ʾ
    ADD DL, 7H ;����9������7Hת����A-F��ASCII��

DisplayDigit:
    MOV AH, 2 ;��ʾDL�Ĵ����е��ַ�
    INT 21H

AA4:
    MOV AH, 4CH ;�������������DOS
    INT 21H

CODE ENDS

END MAIN ;�������
