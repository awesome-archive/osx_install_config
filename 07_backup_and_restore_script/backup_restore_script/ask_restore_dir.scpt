FasdUAS 1.101.10   ��   ��    k             l    
 ����  O     
  	  I   	������
�� .miscactvnull��� ��� null��  ��   	 m     ��
�� misccura��  ��     
  
 l     ��������  ��  ��        l     ��  ��    � �set restoreDir to (choose folder name with prompt "Select directory containing restore files..." default location path to desktop) as text     �   s e t   r e s t o r e D i r   t o   ( c h o o s e   f o l d e r   n a m e   w i t h   p r o m p t   " S e l e c t   d i r e c t o r y   c o n t a i n i n g   r e s t o r e   f i l e s . . . "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p )   a s   t e x t      l     ��  ��    � �set restoreDir to (choose folder with prompt "Select directory containing restore files..." default location path to desktop) as text     �  
 s e t   r e s t o r e D i r   t o   ( c h o o s e   f o l d e r   w i t h   p r o m p t   " S e l e c t   d i r e c t o r y   c o n t a i n i n g   r e s t o r e   f i l e s . . . "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p )   a s   t e x t      l    ����  r        I   �� ��
�� .sysoexecTEXT���     TEXT  m       �   o s a s c r i p t   - e   ' ( c h o o s e   f o l d e r   w i t h   p r o m p t   " S e l e c t   d i r e c t o r y   c o n t a i n i n g   r e s t o r e   f i l e s . . . "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p )   a s   t e x t '��    o      ���� 0 
restoredir 
restoreDir��  ��        l     ����   r     ! " ! n     # $ # 1    ��
�� 
strq $ n     % & % 1    ��
�� 
psxp & o    ���� 0 
restoredir 
restoreDir " o      ���� 0 opp  ��  ��     ' ( ' l     )���� ) r      * + * n     , - , 1    ��
�� 
psxp - o    ���� 0 
restoredir 
restoreDir + o      ���� &0 exportpathrestore exportpathRestore��  ��   (  . / . l     ��������  ��  ��   /  0 1 0 l  ! , 2���� 2 r   ! , 3 4 3 n   ! * 5 6 5 1   ( *��
�� 
strq 6 n   ! ( 7 8 7 1   & (��
�� 
psxp 8 l  ! & 9���� 9 I  ! &�� :��
�� .earsffdralis        afdr :  f   ! "��  ��  ��   4 o      ���� 0 ptm  ��  ��   1  ; < ; l     �� = >��   = b \do shell script "export TARGZSAVEDIR=\"$(dirname " & opp & ")\"/\"$(basename " & opp & ")\""    > � ? ? � d o   s h e l l   s c r i p t   " e x p o r t   T A R G Z S A V E D I R = \ " $ ( d i r n a m e   "   &   o p p   &   " ) \ " / \ " $ ( b a s e n a m e   "   &   o p p   &   " ) \ " " <  @ A @ l     �� B C��   B  set myfile to choose file    C � D D 2 s e t   m y f i l e   t o   c h o o s e   f i l e A  E�� E l  - / F���� F L   - / G G o   - .���� &0 exportpathrestore exportpathRestore��  ��  ��       �� H I��   H ��
�� .aevtoappnull  �   � **** I �� J���� K L��
�� .aevtoappnull  �   � **** J k     / M M   N N   O O   P P  ' Q Q  0 R R  E����  ��  ��   K   L ���� ����������������
�� misccura
�� .miscactvnull��� ��� null
�� .sysoexecTEXT���     TEXT�� 0 
restoredir 
restoreDir
�� 
psxp
�� 
strq�� 0 opp  �� &0 exportpathrestore exportpathRestore
�� .earsffdralis        afdr�� 0 ptm  �� 0� *j UO�j E�O��,�,E�O��,E�O)j 	�,�,E�O�ascr  ��ޭ