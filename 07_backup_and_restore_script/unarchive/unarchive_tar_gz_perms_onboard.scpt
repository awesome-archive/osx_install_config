FasdUAS 1.101.10   ��   ��    k             l     ��  ��     tell application "Finder"     � 	 	 2 t e l l   a p p l i c a t i o n   " F i n d e r "   
  
 l     ����  r         l     ����  I    ���� 
�� .sysostdfalis    ��� null��    ��  
�� 
prmp  m       �   8 S e l e c t   a   f i l e   t o   b e   u n p a c k e d  �� ��
�� 
dflc  I   	�� ��
�� .earsffdralis        afdr  m    ��
�� afdrdesk��  ��  ��  ��    o      ���� 0 	inputfile 	inputFile��  ��        l    ����  O       r        n        1    ��
�� 
posx  o    ���� 0 	inputfile 	inputFile  o      ����  0 posixinputfile posixinputFile  m        �                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  ��  ��     ! " ! l     #���� # r      $ % $ n     & ' & 1    ��
�� 
strq ' o    ����  0 posixinputfile posixinputFile % o      ���� 0 ipp  ��  ��   "  ( ) ( l     ��������  ��  ��   )  * + * l  ! . ,���� , r   ! . - . - l  ! * /���� / I  ! *�� 0��
�� .sysoexecTEXT���     TEXT 0 b   ! & 1 2 1 b   ! $ 3 4 3 m   ! " 5 5 � 6 6 " e c h o   " $ ( b a s e n a m e   4 o   " #���� 0 ipp   2 m   $ % 7 7 � 8 8 @   |   r e v   |   c u t   - d ' . '   - f - 2   |   r e v   ) "��  ��  ��   . o      ����  0 fileextensions fileExtensions��  ��   +  9 : 9 l  / G ;���� ; Z   / G < =�� > < l  / 6 ?���� ? =  / 6 @ A @ o   / 2����  0 fileextensions fileExtensions A m   2 5 B B � C C  t a r . g z��  ��   = k   9 9 D D  E F E l  9 9�� G H��   G # display dialog fileExtensions    H � I I : d i s p l a y   d i a l o g   f i l e E x t e n s i o n s F  J�� J l  9 9�� K L��   K   tar.gz    L � M M    t a r . g z��  ��   > k   = G N N  O P O I  = D�� Q��
�� .sysodlogaskr        TEXT Q m   = @ R R � S S � W r o n g   f i l e t y p e ,   p l e a s e   s e l e c t   t h e   f i r s t   f i l e   o f   t h e   a r c h i v e   e n d i n g   w i t h   . t a r . g z��   P  T�� T L   E G U U m   E F��
�� boovfals��  ��  ��   :  V W V l     ��������  ��  ��   W  X Y X l  H Y Z���� Z r   H Y [ \ [ l  H U ]���� ] I  H U�� ^��
�� .sysoexecTEXT���     TEXT ^ b   H Q _ ` _ b   H M a b a m   H K c c � d d " e c h o   " $ ( b a s e n a m e   b o   K L���� 0 ipp   ` m   M P e e � f f @   |   r e v   |   c u t   - d ' . '   - f 3 -   |   r e v   ) "��  ��  ��   \ o      ���� 0 newfoldername newFolderName��  ��   Y  g h g l     �� i j��   i " display dialog newFolderName    j � k k 8 d i s p l a y   d i a l o g   n e w F o l d e r N a m e h  l m l l     �� n o��   n  	 filename    o � p p    f i l e n a m e m  q r q l     ��������  ��  ��   r  s t s l  Z k u���� u r   Z k v w v l  Z g x���� x I  Z g�� y��
�� .sysoexecTEXT���     TEXT y b   Z c z { z b   Z _ | } | m   Z ] ~ ~ �   " e c h o   " $ ( b a s e n a m e   } o   ] ^���� 0 ipp   { m   _ b � � � � � @   |   r e v   |   c u t   - d ' . '   - f 1 -   |   r e v   ) "��  ��  ��   w o      ���� $0 filenamenosuffix filenameNoSuffix��  ��   t  � � � l     �� � ���   �   filename.tar.gz    � � � �     f i l e n a m e . t a r . g z �  � � � l     �� � ���   � % display dialog filenameNoSuffix    � � � � > d i s p l a y   d i a l o g   f i l e n a m e N o S u f f i x �  � � � l     ��������  ��  ��   �  � � � l  l y ����� � r   l y � � � I  l u���� �
�� .sysostflalis    ��� null��   � �� ���
�� 
prmp � m   n q � � � � � 0 S e l e c t   t h e   o u t p u t   f o l d e r��   � o      ���� 0 outputfolder outputFolder��  ��   �  � � � l  z � ����� � r   z � � � � n   z � � � � 1   � ���
�� 
strq � n   z � � � � 1   } ���
�� 
psxp � o   z }���� 0 outputfolder outputFolder � o      ���� 0 opp  ��  ��   �  � � � l  � � ����� � r   � � � � � b   � � � � � b   � � � � � l  � � ����� � c   � � � � � o   � ����� 0 outputfolder outputFolder � m   � ���
�� 
ctxt��  ��   � o   � ����� 0 newfoldername newFolderName � m   � � � � � � �  : � o      ���� $0 testfolderexists testFolderExists��  ��   �  � � � l     ��������  ��  ��   �  � � � l  � ����� � O   � � � � Z   � � ��� � � I  � ��� ���
�� .coredoexnull���     obj  � 4   � ��� �
�� 
cfol � o   � ����� $0 testfolderexists testFolderExists��   � k   � � �  � � � r   � � � � � I  � ��� � �
�� .sysodlogaskr        TEXT � m   � � � � � � � H f o l d e r   a l r e a d y   e x i s t s ,   o v e r w r i t e   i t ? � �� � �
�� 
btns � J   � � � �  � � � m   � � � � � � �  Y e s �  ��� � m   � � � � � � �  N o��   � �� ���
�� 
dflt � m   � ����� ��   � o      ���� 0 question   �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
bhit � o   � ����� 0 question   � o      ���� 
0 answer   �  ��� � Z   � � ��� � � l  � � ����� � =  � � � � � o   � ����� 
0 answer   � m   � � � � � � �  Y e s��  ��   � k   � � �  � � � l  � ��� � ���   � $ display dialog "answer is yes"    � � � � < d i s p l a y   d i a l o g   " a n s w e r   i s   y e s " �  � � � I  ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � �  c d   " $ ( d i r n a m e   � o   � ����� 0 opp   � m   � � � � � � �  ) " / " $ ( b a s e n a m e   � o   � ��� 0 opp   � m   � � � � � � � , ) " /   & &   r m   - r f   " $ ( e c h o   � o   � ��~�~ 0 newfoldername newFolderName � m   � � � � � � �  ) "��   �  ��} � l �| � ��|   �  return true    � � � �  r e t u r n   t r u e�}  ��   � L   � � m  �{
�{ boovfals��  ��   � l �z � �z   �  return false     �  r e t u r n   f a l s e � m   � ��                                                                                  MACS  alis    @  macintosh_hd                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    m a c i n t o s h _ h d  &System/Library/CoreServices/Finder.app  / ��  ��  ��   �  l     �y�x�w�y  �x  �w    l ��v�u Z  �	�t
 =  n   1  �s
�s 
prun m  �                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��   m  �r
�r boovtrue	 O  x k   w  I  %�q�p�o
�q .miscactvnull��� ��� null�p  �o    I &+�n�m
�n .sysodelanull��� ��� nmbr m  &'�l�l �m    Z  ,o�k = ,7 l ,5�j�i I ,5�h �g
�h .corecnte****       ****  2 ,1�f
�f 
cwin�g  �j  �i   m  56�e�e   k  :M!! "#" I :?�d�c�b
�d .aevtrappnull��� ��� null�c  �b  # $%$ I @E�a�`�_
�a .miscactvnull��� ��� null�`  �_  % &'& l FF�^()�^  ( J Dtell application "System Events" to keystroke "n" using command down   ) �** � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " n "   u s i n g   c o m m a n d   d o w n' +�]+ I FM�\,�[
�\ .sysodelanull��� ��� nmbr, m  FI-- ?��������[  �]  �k   k  Po.. /0/ O Pg121 I Tf�Z34
�Z .prcskprsnull���     ctxt3 m  TW55 �66  n4 �Y7�X
�Y 
faal7 J  Zb88 9:9 m  Z]�W
�W eMdsKopt: ;�V; m  ]`�U
�U eMdsKcmd�V  �X  2 m  PQ<<�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  0 =�T= I ho�S>�R
�S .sysodelanull��� ��� nmbr> m  hk?? ?��������R  �T   @�Q@ I pw�PA�O
�P .sysodelanull��� ��� nmbrA m  psBB ?�      �O  �Q   m  CC�                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �t  
 O  {�DED k  ��FF GHG I ���N�M�L
�N .miscactvnull��� ��� null�M  �L  H I�KI I ���JJ�I
�J .sysodelanull��� ��� nmbrJ m  ��KK ?�      �I  �K  E m  {~LL�                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �v  �u   MNM l     �H�G�F�H  �G  �F  N OPO l ��Q�E�DQ O  ��RSR k  ��TT UVU I ���C�B�A
�C .miscactvnull��� ��� null�B  �A  V WXW I ���@Y�?
�@ .sysodelanull��� ��� nmbrY m  ��ZZ ?�      �?  X [\[ l ���>�=�<�>  �=  �<  \ ]^] r  ��_`_ I ���;ab
�; .coredoscnull��� ��� ctxta b  ��cdc b  ��efe b  ��ghg b  ��iji b  ��klk b  ��mnm b  ��opo b  ��qrq b  ��sts b  ��uvu b  ��wxw b  ��yzy b  ��{|{ b  ��}~} b  ��� b  ����� b  ����� b  ����� m  ���� ���� p r i n t f   ' \ e c '   & &   e c h o   ' '   & &   e c h o   - e   ' \ 0 3 3 [ 1 m s t a r t i n g   u n a r c h i v i n g . . . \ 0 3 3 [ 0 m ' ;   i f   s u d o   - n   t r u e   2 > / d e v / n u l l ;   t h e n   : ;   e l s e   e c h o   ' p l e a s e   e n t e r   s u d o   p a s s w o r d   t o   p r e s e r v e   p e r m i s s i o n s   w h i l e   e x t r a c t i n g : '   & &   s u d o   - v ;   f i ;   e c h o   ' ' ;   e c h o   u n a r c h i v i n g   " $ ( d i r n a m e  � o  ���:�: 0 ipp  � m  ���� ���  ) " / " $ ( e c h o  � o  ���9�9 $0 filenamenosuffix filenameNoSuffix� m  ���� ��� F ) " ;   p r i n t f   ' % - 1 2 s '   ' t o '   " $ ( d i r n a m e  ~ o  ���8�8 0 opp  | m  ���� ���  ) " / " $ ( b a s e n a m e  z o  ���7�7 0 opp  x m  ���� ���  ) " / " $ ( e c h o  v o  ���6�6 0 newfoldername newFolderNamet m  ���� ��� H ) "   & &   e c h o ;   e c h o   ' ' ;   c a t   " $ ( d i r n a m e  r o  ���5�5 0 ipp  p m  ���� ���  ) " / " $ ( e c h o  n o  ���4�4 $0 filenamenosuffix filenameNoSuffixl m  ���� ��� b ) "   |   s u d o   t i m e   - p   t a r   - - s a m e - o w n e r   - C   " $ ( d i r n a m e  j o  ���3�3 0 opp  h m  ���� ���  ) " / " $ ( b a s e n a m e  f o  ���2�2 0 opp  d m  ���� ���� ) " /   - x p f   - ;   i f   [   $ ?   =   0   ] ;   t h e n   e c h o   ' '   & &   e c h o   - e   ' u n a r c h i v i n g   \ 0 3 3 [ 1 ; 3 2 m S U C C E S S F U L \ 0 3 3 [ 0 m '   & &   e c h o   ' ' ;   e l s e   e c h o   ' '   & &   e c h o   - e   ' a n   \ 0 3 3 [ 1 ; 3 1 m E R R O R \ 0 3 3 [ 0 m   o c c u r e d ,   p l e a s e   u n a r c h i v e   a g a i n . . . '   & &   e c h o   ' ' ;   f ib �1��0
�1 
kfil� 4  ���/�
�/ 
cwin� m  ���.�. �0  ` o      �-�- 0 
currenttab 
currentTab^ ��,� l ���+�*�)�+  �*  �)  �,  S m  �����                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �E  �D  P ��� l     �(�'�&�(  �'  �&  � ��� l     �%�$�#�%  �$  �#  � ��� l     �"���"  � !  \" keeping spaces alive \"   � ��� 6   \ "   k e e p i n g   s p a c e s   a l i v e   \ "� ��� l     �!� ��!  �   �  � ��� l     ����  �   cd to directory   � ���     c d   t o   d i r e c t o r y� ��� l     ����  �  �  � ��� l     ����  � 2 , cat virtualbox.tar.gz.* > virtualbox.tar.gz   � ��� X   c a t   v i r t u a l b o x . t a r . g z . *   >   v i r t u a l b o x . t a r . g z� ��� l     ����  � , & pigz -dc virtualbox.tar.gz | tar xf -   � ��� L   p i g z   - d c   v i r t u a l b o x . t a r . g z   |   t a r   x f   -� ��� l     ����  �  �  � ��� l     ����  � 6 0 cat virtualbox.tar.gz.* | pigz -dc - | tar xf -   � ��� `   c a t   v i r t u a l b o x . t a r . g z . *   |   p i g z   - d c   -   |   t a r   x f   -� ��� l     ����  � - ' cat *.tar.gz.* | pigz -dc - | tar xf -   � ��� N   c a t   * . t a r . g z . *   |   p i g z   - d c   -   |   t a r   x f   -� ��� l     ����  � E ? cat *.tar.gz.* | pigz -dc - | tar -C /Users/tom/Desktop/ -xf -   � ��� ~   c a t   * . t a r . g z . *   |   p i g z   - d c   -   |   t a r   - C   / U s e r s / t o m / D e s k t o p /   - x f   -� ��� l     ����  � � | cat *.tar.gz.* | pv -s $(cat *.tar.gz.* | du -s | awk '{print $1}')"k" | pigz -dc - | tar -C /Users/tom/Desktop/test/ -xf -   � ��� �   c a t   * . t a r . g z . *   |   p v   - s   $ ( c a t   * . t a r . g z . *   |   d u   - s   |   a w k   ' { p r i n t   $ 1 } ' ) " k "   |   p i g z   - d c   -   |   t a r   - C   / U s e r s / t o m / D e s k t o p / t e s t /   - x f   -� ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     ����  � 4 . cat virtualbox.tar.bz2.* > virtualbox.tar.bz2   � ��� \   c a t   v i r t u a l b o x . t a r . b z 2 . *   >   v i r t u a l b o x . t a r . b z 2� ��� l     �
���
  � / ) pbzip2 -dck virtualbox.tar.gz | tar xf -   � ��� R   p b z i p 2   - d c k   v i r t u a l b o x . t a r . g z   |   t a r   x f   -� ��� l     �	���	  �  �  � ��� l     ����  � : 4 cat virtualbox.tar.bz2.* | pbzip2 -dck - | tar xf -   � ��� h   c a t   v i r t u a l b o x . t a r . b z 2 . *   |   p b z i p 2   - d c k   -   |   t a r   x f   -� ��� l     ����  �  �  � ��� l     ��� �  �  �   � ���� l     ������  � / ) brew install pigz coreutils p7zip pbzip2   � ��� R   b r e w   i n s t a l l   p i g z   c o r e u t i l s   p 7 z i p   p b z i p 2��       ������  � ��
�� .aevtoappnull  �   � ****� �����������
�� .aevtoappnull  �   � ****� k    ���  
��  ��  !��  *��  9��  X��  s��  ���  ���  ���  ��� �� O����  ��  ��  �  � N�� ������������  �������� 5 7���� B R�� c e�� ~ ��� ����������� ������� ��� � ��������� � � � � �������������-5��������BZ����������������
�� 
prmp
�� 
dflc
�� afdrdesk
�� .earsffdralis        afdr�� 
�� .sysostdfalis    ��� null�� 0 	inputfile 	inputFile
�� 
posx��  0 posixinputfile posixinputFile
�� 
strq�� 0 ipp  
�� .sysoexecTEXT���     TEXT��  0 fileextensions fileExtensions
�� .sysodlogaskr        TEXT�� 0 newfoldername newFolderName�� $0 filenamenosuffix filenameNoSuffix
�� .sysostflalis    ��� null�� 0 outputfolder outputFolder
�� 
psxp�� 0 opp  
�� 
ctxt�� $0 testfolderexists testFolderExists
�� 
cfol
�� .coredoexnull���     obj 
�� 
btns
�� 
dflt�� 0 question  
�� 
bhit�� 
0 answer  
�� 
prun
�� .miscactvnull��� ��� null
�� .sysodelanull��� ��� nmbr
�� 
cwin
�� .corecnte****       ****
�� .aevtrappnull��� ��� null
�� 
faal
�� eMdsKopt
�� eMdsKcmd
�� .prcskprsnull���     ctxt
�� 
kfil
�� .coredoscnull��� ��� ctxt�� 0 
currenttab 
currentTab�� *����j � E�O� ��,E�UO��,E�O��%�%j E` O_ a   hY a j OfOa �%a %j E` Oa �%a %j E` O*�a l E` O_ a ,�,E` O_ a &_ %a  %E` !Oa " l*a #_ !/j $ \a %a &a 'a (lva )l� E` *O_ *a +,E` ,O_ ,a -  &a ._ %a /%_ %a 0%_ %a 1%j OPY fY hUOa 2a 3,e  ca 2 Y*j 4Okj 5O*a 6-j 7j  *j 8O*j 4Oa 9j 5Y !� a :a ;a <a =lvl >UOa 9j 5Oa ?j 5UY a 2 *j 4Oa ?j 5UOa 2 j*j 4Oa @j 5Oa A�%a B%_ %a C%_ %a D%_ %a E%_ %a F%�%a G%_ %a H%_ %a I%_ %a J%a K*a 6k/l LE` MOPUascr  ��ޭ