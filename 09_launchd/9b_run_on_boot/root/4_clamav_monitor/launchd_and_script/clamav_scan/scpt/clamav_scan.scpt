FasdUAS 1.101.10   ��   ��    k             l    & ����  O     &  	  k    % 
 
     I   	������
�� .miscactvnull��� ��� obj ��  ��        l  
 
��  ��    s mset fileSave to (choose folder name with prompt "Save backup to..." default location path to desktop) as text     �   � s e t   f i l e S a v e   t o   ( c h o o s e   f o l d e r   n a m e   w i t h   p r o m p t   " S a v e   b a c k u p   t o . . . "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p )   a s   t e x t      l  
 
��  ��    n hset fileSave to (choose folder with prompt "Save backup to..." default location path to desktop) as text     �   � s e t   f i l e S a v e   t o   ( c h o o s e   f o l d e r   w i t h   p r o m p t   " S a v e   b a c k u p   t o . . . "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p )   a s   t e x t      r   
     I  
 �� ��
�� .sysoexecTEXT���     TEXT  m   
    �   � o s a s c r i p t   - e   ' ( c h o o s e   f o l d e r   w i t h   p r o m p t   " S e l e c t   d i r e c t o r y   t o   s c a n   w i t h   c l a m a v . . . "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p )   a s   t e x t '��    o      ���� 0 scandir scanDir      r       !   n     " # " 1    ��
�� 
strq # n     $ % $ 1    ��
�� 
psxp % o    ���� 0 scandir scanDir ! o      ���� 0 scandirpath scanDirPath   & ' & l   ��������  ��  ��   '  (�� ( r    % ) * ) n    # + , + 1   ! #��
�� 
strq , n    ! - . - 1    !��
�� 
psxp . l    /���� / I   �� 0��
�� .earsffdralis        afdr 0  f    ��  ��  ��   * o      ���� 0 ptm  ��   	 m      1 1�                                                                                  MACS  alis    @  macintosh_hd                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    m a c i n t o s h _ h d  &System/Library/CoreServices/Finder.app  / ��  ��  ��     2 3 2 l     ��������  ��  ��   3  4 5 4 l  ' � 6���� 6 Z   ' � 7 8�� 9 7 =  ' , : ; : n   ' * < = < 1   ( *��
�� 
prun = m   ' ( > >�                                                                                      @ alis    J  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    m a c i n t o s h _ h d  *System/Applications/Utilities/Terminal.app  / ��   ; m   * +��
�� boovtrue 8 O   / � ? @ ? k   3 � A A  B C B I  3 8������
�� .miscactvnull��� ��� obj ��  ��   C  D E D I  9 >�� F��
�� .sysodelanull��� ��� nmbr F m   9 :���� ��   E  G H G Z   ? � I J�� K I =  ? H L M L l  ? F N���� N I  ? F�� O��
�� .corecnte****       **** O 2  ? B��
�� 
cwin��  ��  ��   M m   F G����   J k   K ^ P P  Q R Q I  K P������
�� .aevtrappnull��� ��� null��  ��   R  S T S I  Q V������
�� .miscactvnull��� ��� obj ��  ��   T  U V U l  W W�� W X��   W J Dtell application "System Events" to keystroke "n" using command down    X � Y Y � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " n "   u s i n g   c o m m a n d   d o w n V  Z�� Z I  W ^�� [��
�� .sysodelanull��� ��� nmbr [ m   W Z \ \ ?���������  ��  ��   K k   a � ] ]  ^ _ ^ O  a z ` a ` I  g y�� b c
�� .prcskprsnull���     ctxt b m   g j d d � e e  n c �� f��
�� 
faal f J   m u g g  h i h m   m p��
�� eMdsKopt i  j�� j m   p s��
�� eMdsKcmd��  ��   a m   a d k k�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��   _  l�� l I  { ��� m��
�� .sysodelanull��� ��� nmbr m m   { ~ n n ?���������  ��   H  o�� o I  � ��� p��
�� .sysodelanull��� ��� nmbr p m   � � q q ?�      ��  ��   @ m   / 0 r r�                                                                                      @ alis    J  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    m a c i n t o s h _ h d  *System/Applications/Utilities/Terminal.app  / ��  ��   9 O   � � s t s k   � � u u  v w v I  � �������
�� .miscactvnull��� ��� obj ��  ��   w  x�� x I  � ��� y��
�� .sysodelanull��� ��� nmbr y m   � � z z ?�      ��  ��   t m   � � { {�                                                                                      @ alis    J  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    m a c i n t o s h _ h d  *System/Applications/Utilities/Terminal.app  / ��  ��  ��   5  | } | l  � � ~���� ~ I  � ��� ��
�� .sysodelanull��� ��� nmbr  m   � ����� ��  ��  ��   }  � � � l  � � ����� � O   � � � � � k   � � � �  � � � l  � ��� � ���   � h b runs the script with the shebang interpreter from inside the script, not with the used $SHELL				    � � � � �   r u n s   t h e   s c r i p t   w i t h   t h e   s h e b a n g   i n t e r p r e t e r   f r o m   i n s i d e   t h e   s c r i p t ,   n o t   w i t h   t h e   u s e d   $ S H E L L 	 	 	 	 �  ��� � I  � ��� � �
�� .coredoscnull��� ��� ctxt � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � � H e x p o r t   D I R E C T O R Y _ T O _ S C A N = " $ ( d i r n a m e   � o   � ����� 0 scandirpath scanDirPath � m   � � � � � � �  ) " / " $ ( b a s e n a m e   � o   � ����� 0 scandirpath scanDirPath � m   � � � � � � � * ) " ;     t i m e   " $ ( d i r n a m e   � o   � ����� 0 ptm   � m   � � � � � � � � ) " / c l a m a v _ s c a n . a p p / C o n t e n t s / c u s t o m _ f i l e s / c l a m a v _ s c a n . s h ;   e c h o   ' ' � �� ���
�� 
kfil � n   � � � � � 4   � ��� �
�� 
ttab � m   � �����  � 4  � ��� �
�� 
cwin � m   � ����� ��  ��   � m   � � � ��                                                                                      @ alis    J  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    m a c i n t o s h _ h d  *System/Applications/Utilities/Terminal.app  / ��  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  ��� � l     �� � ���   �  delay 5    � � � �  d e l a y   5��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     � � �   � �  4 � �  | � �  �����  ��  ��   �   �  1�� �������������� >������~�} \ k d�|�{�z�y q � � � ��x�w�v
�� .miscactvnull��� ��� obj 
�� .sysoexecTEXT���     TEXT�� 0 scandir scanDir
�� 
psxp
�� 
strq�� 0 scandirpath scanDirPath
�� .earsffdralis        afdr�� 0 ptm  
�� 
prun
�� .sysodelanull��� ��� nmbr
� 
cwin
�~ .corecnte****       ****
�} .aevtrappnull��� ��� null
�| 
faal
�{ eMdsKopt
�z eMdsKcmd
�y .prcskprsnull���     ctxt
�x 
kfil
�w 
ttab
�v .coredoscnull��� ��� ctxt�� �� #*j O�j E�O��,�,E�O)j �,�,E�UO��,e  a� Y*j Okj O*�-j j  *j O*j Oa j Y #a  a a a a lvl UOa j Oa j UY � *j Oa j UOkj O� 'a �%a %�%a %�%a %a *�k/a k/l U ascr  ��ޭ