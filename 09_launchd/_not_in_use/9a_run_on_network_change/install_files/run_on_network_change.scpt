FasdUAS 1.101.10   ��   ��    k             l    ����  Q      	 
  k          l   ��������  ��  ��        l   ��  ��    3 - taking actions on changing network locations     �   Z   t a k i n g   a c t i o n s   o n   c h a n g i n g   n e t w o r k   l o c a t i o n s      l   ��������  ��  ��        l   ��  ��      setting variables     �   $   s e t t i n g   v a r i a b l e s      r        m       �   2 / t m p / n e t w o r k _ l o c a t i o n . t x t  o      ���� 0 filepath       !   I   �� "��
�� .sysoexecTEXT���     TEXT " b    
 # $ # m     % % � & &  t o u c h   $ o    	���� 0 filepath  ��   !  ' ( ' r     ) * ) m     + + � , ,  U n i f i e d   R e m o t e * o      ���� 0 appname   (  - . - r     / 0 / m     1 1 � 2 2  W h a t s A p p 0 o      ���� 0 appname2   .  3 4 3 r     5 6 5 m     7 7 � 8 8  W h a t s A p p   H e l p e r 6 o      ���� 0 appname3   4  9 : 9 l   ��������  ��  ��   :  ; < ; l   �� = >��   = < 6 waiting for the system to apply network location name    > � ? ? l   w a i t i n g   f o r   t h e   s y s t e m   t o   a p p l y   n e t w o r k   l o c a t i o n   n a m e <  @ A @ I    �� B��
�� .sysodelanull��� ��� nmbr B m    ���� ��   A  C D C l  ! !��������  ��  ��   D  E F E l  ! !�� G H��   G > 8 getting the name of the current active network location    H � I I p   g e t t i n g   t h e   n a m e   o f   t h e   c u r r e n t   a c t i v e   n e t w o r k   l o c a t i o n F  J K J O   ! < L M L O   % ; N O N k   + : P P  Q R Q e   + 2 S S c   + 2 T U T l  + 0 V���� V n   + 0 W X W 1   . 0��
�� 
pnam X 1   + .��
�� 
locc��  ��   U m   0 1��
�� 
ctxt R  Y�� Y r   3 : Z [ Z l  3 6 \���� \ 1   3 6��
�� 
rslt��  ��   [ o      ���� 0 network_location_current  ��   O 1   % (��
�� 
netp M m   ! " ] ]�                                                                                  sevs  alis    ^  macintosh_hd2                  BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d 2  -System/Library/CoreServices/System Events.app   / ��   K  ^ _ ^ l  = =��������  ��  ��   _  ` a ` l  = =�� b c��   b S Mdisplay notification "active network location is " & network_location_current    c � d d � d i s p l a y   n o t i f i c a t i o n   " a c t i v e   n e t w o r k   l o c a t i o n   i s   "   &   n e t w o r k _ l o c a t i o n _ c u r r e n t a  e f e l  = =��������  ��  ��   f  g h g l  = =�� i j��   i - ' reading old network location from file    j � k k N   r e a d i n g   o l d   n e t w o r k   l o c a t i o n   f r o m   f i l e h  l m l r   = R n o n l  = N p���� p I  = N�� q��
�� .sysoexecTEXT���     TEXT q b   = J r s r m   = @ t t � u u  c a t   s n   @ I v w v 1   E I��
�� 
strq w l  @ E x���� x n   @ E y z y 1   A E��
�� 
psxp z o   @ A���� 0 filepath  ��  ��  ��  ��  ��   o o      ���� 0 network_location_old   m  { | { l  S S��������  ��  ��   |  } ~ } l  S S��  ���    f ` checking if network location has changed, if yes stopping app (if is running) and restarting it    � � � � �   c h e c k i n g   i f   n e t w o r k   l o c a t i o n   h a s   c h a n g e d ,   i f   y e s   s t o p p i n g   a p p   ( i f   i s   r u n n i n g )   a n d   r e s t a r t i n g   i t ~  � � � Z   S � ����� � >  S Z � � � o   S V���� 0 network_location_old   � o   V Y���� 0 network_location_current   � k   ]  � �  � � � l  ] ]�� � ���   � � �display notification "network location was changed from " & network_location_old & " to " & network_location_current & " ,restarting " & appname with title "Network Script"    � � � �X d i s p l a y   n o t i f i c a t i o n   " n e t w o r k   l o c a t i o n   w a s   c h a n g e d   f r o m   "   &   n e t w o r k _ l o c a t i o n _ o l d   &   "   t o   "   &   n e t w o r k _ l o c a t i o n _ c u r r e n t   &   "   , r e s t a r t i n g   "   &   a p p n a m e   w i t h   t i t l e   " N e t w o r k   S c r i p t " �  � � � l  ] ]��������  ��  ��   �  � � � l  ] ]�� � ���   �  ## app1    � � � �  # #   a p p 1 �  � � � l  ] ]��������  ��  ��   �  � � � Z   ] � � ����� � =  ] i � � � n   ] g � � � 1   c g��
�� 
prun � 4   ] c�� �
�� 
capp � o   a b���� 0 appname   � m   g h��
�� boovtrue � k   l � � �  � � � l  l l��������  ��  ��   �  � � � O   l � � � � k   p � � �  � � � r   p { � � � n   p w � � � 1   u w��
�� 
pnam � 2   p u��
�� 
prcs � o      ���� 0 processlist ProcessList �  ��� � Z   | � � ����� � E  | � � � � o   | ���� 0 processlist ProcessList � o    ����� 0 appname   � k   � � � �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
idux � 4   � ��� �
�� 
prcs � o   � ����� 0 appname   � o      ���� 0 thepid ThePID �  ��� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � m   � � � � � � �  k i l l   - -   � o   � ����� 0 thepid ThePID��  ��  ��  ��  ��   � m   l m � ��                                                                                  sevs  alis    ^  macintosh_hd2                  BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d 2  -System/Library/CoreServices/System Events.app   / ��   �  � � � l  � ���������  ��  ��   �  � � � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��   �  � � � l  � ���������  ��  ��   �  � � � O  � � � � � I  � �������
�� .ascrnoop****      � ****��  ��   � 4   � ��� �
�� 
capp � o   � ����� 0 appname   �  ��� � l  � ���������  ��  ��  ��  ��  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �  ## app2    � � � �  # #   a p p 2 �  � � � l  � ���������  ��  ��   �  � � � Z   �� � ����� � =  � � � � � n   � � � � � 1   � ���
�� 
prun � 4   � ��� �
�� 
capp � o   � ��� 0 appname2   � m   � ��~
�~ boovtrue � k   �� � �  � � � l  � ��}�|�{�}  �|  �{   �  � � � O   � � � � k   � � �  � � � r   � � � � � n   � � � � � 1   � ��z
�z 
pnam � 2   � ��y
�y 
prcs � o      �x�x 0 processlist ProcessList �  ��w � Z   � � ��v�u � E  � � � � � o   � ��t�t 0 processlist ProcessList � o   � ��s�s 0 appname2   � k   � � �  � � � r   � � � � � n   � � � � � 1   � ��r
�r 
idux � 4   � ��q �
�q 
prcs � o   � ��p�p 0 appname2   � o      �o�o 0 thepid ThePID �  � � � I  ��n ��m
�n .sysoexecTEXT���     TEXT � b   � � �  � m   � � �  k i l l   - -    o   � ��l�l 0 thepid ThePID�m   � �k l �j�j   ) #do shell script "kill -9 " & ThePID    � F d o   s h e l l   s c r i p t   " k i l l   - 9   "   &   T h e P I D�k  �v  �u  �w   � m   � ��                                                                                  sevs  alis    ^  macintosh_hd2                  BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d 2  -System/Library/CoreServices/System Events.app   / ��   � 	 l 		�i�h�g�i  �h  �g  	 

 O  	B k  A  r   n   1  �f
�f 
pnam 2  �e
�e 
prcs o      �d�d 0 processlist ProcessList �c Z  A�b�a E  o  �`�` 0 processlist ProcessList o  �_�_ 0 appname3   k  !=  r  !/ n  !+  1  '+�^
�^ 
idux  4  !'�]!
�] 
prcs! o  %&�\�\ 0 appname3   o      �[�[ 0 thepid ThePID "#" I 0;�Z$�Y
�Z .sysoexecTEXT���     TEXT$ b  07%&% m  03'' �((  k i l l   - -  & o  36�X�X 0 thepid ThePID�Y  # )�W) l <<�V*+�V  * ) #do shell script "kill -9 " & ThePID   + �,, F d o   s h e l l   s c r i p t   " k i l l   - 9   "   &   T h e P I D�W  �b  �a  �c   m  	
--�                                                                                  sevs  alis    ^  macintosh_hd2                  BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d 2  -System/Library/CoreServices/System Events.app   / ��   ./. l CC�U�T�S�U  �T  �S  / 010 O  C|232 k  G{44 565 r  GR787 n  GN9:9 1  LN�R
�R 
pnam: 2  GL�Q
�Q 
prcs8 o      �P�P 0 processlist ProcessList6 ;�O; Z  S{<=�N�M< E SX>?> o  SV�L�L 0 processlist ProcessList? o  VW�K�K 0 appname3  = k  [w@@ ABA r  [iCDC n  [eEFE 1  ae�J
�J 
iduxF 4  [a�IG
�I 
prcsG o  _`�H�H 0 appname3  D o      �G�G 0 thepid ThePIDB HIH I ju�FJ�E
�F .sysoexecTEXT���     TEXTJ b  jqKLK m  jmMM �NN  k i l l   - -  L o  mp�D�D 0 thepid ThePID�E  I O�CO l vv�BPQ�B  P ) #do shell script "kill -9 " & ThePID   Q �RR F d o   s h e l l   s c r i p t   " k i l l   - 9   "   &   T h e P I D�C  �N  �M  �O  3 m  CDSS�                                                                                  sevs  alis    ^  macintosh_hd2                  BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d 2  -System/Library/CoreServices/System Events.app   / ��  1 TUT l }}�A�@�?�A  �@  �?  U VWV I }��>X�=
�> .sysodelanull��� ��� nmbrX m  }~�<�< �=  W YZY l ���;�:�9�;  �:  �9  Z [\[ l ���8]^�8  ] E ?do shell script "open -g -a /Applications/" & appname2 & ".app"   ^ �__ ~ d o   s h e l l   s c r i p t   " o p e n   - g   - a   / A p p l i c a t i o n s / "   &   a p p n a m e 2   &   " . a p p "\ `a` O ��bcb I ���7�6�5
�7 .ascrnoop****      � ****�6  �5  c 4  ���4d
�4 
cappd o  ���3�3 0 appname2  a efe I ���2g�1
�2 .sysodelanull��� ��� nmbrg m  ��hh ?�      �1  f iji O ��klk r  ��mnm m  ���0
�0 boovfalsn l     o�/�.o n      pqp 1  ���-
�- 
pvisq 4  ���,r
�, 
prcsr o  ���+�+ 0 appname2  �/  �.  l m  ��ss�                                                                                  sevs  alis    ^  macintosh_hd2                  BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d 2  -System/Library/CoreServices/System Events.app   / ��  j tut l ���*vw�*  v  	delay 0.1   w �xx  d e l a y   0 . 1u yzy l ���){|�)  { O Itell application "Finder" to set the visible of process appname2 to false   | �}} � t e l l   a p p l i c a t i o n   " F i n d e r "   t o   s e t   t h e   v i s i b l e   o f   p r o c e s s   a p p n a m e 2   t o   f a l s ez ~~ l ���(���(  �  	delay 0.1   � ���  d e l a y   0 . 1 ��� l ���'���'  �  tell application appname2   � ��� 2 t e l l   a p p l i c a t i o n   a p p n a m e 2� ��� l ���&���&  � M G	tell application "System Events" to keystroke "h" using {command down}   � ��� � 	 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " h "   u s i n g   { c o m m a n d   d o w n }� ��� l ���%���%  �  end tell   � ���  e n d   t e l l� ��$� l ���#�"�!�#  �"  �!  �$  ��  ��   � ��� l ��� ���   �  �  � ��� I �����
� .sysodelanull��� ��� nmbr� m  ���� �  � ��� l ������  �  �  � ��� l ������  � C = writing current network location to file for next scritp run   � ��� z   w r i t i n g   c u r r e n t   n e t w o r k   l o c a t i o n   t o   f i l e   f o r   n e x t   s c r i t p   r u n� ��� I �����
� .sysoexecTEXT���     TEXT� b  ����� m  ���� ���  r m  � o  ���� 0 filepath  �  � ��� I �����
� .sysoexecTEXT���     TEXT� b  ����� m  ���� ���  t o u c h  � o  ���� 0 filepath  �  � ��� r  ����� I �����
� .rdwropenshor       file� o  ���� 0 filepath  � ���
� 
perm� m  ���
� boovtrue�  � o      �� 0 fd  � ��� I ���
��
�
 .rdwrwritnull���     ****� o  ���	�	 0 network_location_current  � ���
� 
refn� o  ���� 0 fd  � ���
� 
as  � m  ���
� 
utf8� ���
� 
wrat� m  ���
� rdwreof �  � ��� I ����� 
� .rdwrclosnull���     ****� o  ������ 0 fd  �   � ���� l ����������  ��  ��  ��  ��  ��   � ���� l ��������  ��  ��  ��   	 R      ������
�� .ascrerr ****      � ****��  ��   
 l ������  �  -   � ���  -��  ��    ��� l     ��������  ��  ��  � ��� l     ������  � Y Sdisplay notification "network location was not changed" with title "Network Script"   � ��� � d i s p l a y   n o t i f i c a t i o n   " n e t w o r k   l o c a t i o n   w a s   n o t   c h a n g e d "   w i t h   t i t l e   " N e t w o r k   S c r i p t "� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       ����  + 1 7���������������������  � ��������������������������������
�� .aevtoappnull  �   � ****�� 0 filepath  �� 0 appname  �� 0 appname2  �� 0 appname3  �� 0 network_location_current  �� 0 network_location_old  �� 0 processlist ProcessList�� 0 thepid ThePID�� 0 fd  ��  ��  ��  ��  ��  ��  � �����������
�� .aevtoappnull  �   � ****� k    ��  ����  ��  ��  �  � 2 �� %�� +�� 1�� 7���� ]������������ t������������������ ���'Mh�������������������������������� 0 filepath  
�� .sysoexecTEXT���     TEXT�� 0 appname  �� 0 appname2  �� 0 appname3  
�� .sysodelanull��� ��� nmbr
�� 
netp
�� 
locc
�� 
pnam
�� 
ctxt
�� 
rslt�� 0 network_location_current  
�� 
psxp
�� 
strq�� 0 network_location_old  
�� 
capp
�� 
prun
�� 
prcs�� 0 processlist ProcessList
�� 
idux�� 0 thepid ThePID
�� .ascrnoop****      � ****
�� 
pvis
�� 
perm
�� .rdwropenshor       file�� 0 fd  
�� 
refn
�� 
as  
�� 
utf8
�� 
wrat
�� rdwreof �� 
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****��  ��  ���E�O��%j O�E�O�E�O�E�Okj 
O� *�, *�,�,�&O_ E` UUOa �a ,a ,%j E` O_ _ �*a �/a ,e  T� 4*a -�,E` O_ � *a �/a ,E` Oa _ %j Y hUOkj 
O*a �/ *j UOPY hO*a �/a ,e  �� 6*a -�,E` O_ � !*a �/a ,E` Oa _ %j OPY hUO� 6*a -�,E` O_ � !*a �/a ,E` Oa _ %j OPY hUO� 6*a -�,E` O_ � !*a �/a ,E` Oa  _ %j OPY hUOlj 
O*a �/ *j UOa !j 
O� f*a �/a ",FUOPY hOlj 
Oa #�%j Oa $�%j O�a %el &E` 'O_ a (_ 'a )a *a +a ,a - .O_ 'j /OPY hOPW X 0 1h� ���  o f f i c e _ l a n� ���  A u t o m a t i s c h� ����� 1� 1 ����������������������������������� 	
��� �  l o g i n w i n d o w� � & V i e w B r i d g e A u x i l i a r y� �   u n i v e r s a l a c c e s s d� �  A p p   S t o r e� �  P r e v i e w� � $ G e b u r t s t a g s C h e c k e r� �  S y s t e m U I S e r v e r� �  t a l a g e n t� �  D o c k� � & V i e w B r i d g e A u x i l i a r y� �  F i n d e r� �  S p o t l i g h t� � $ N o t i f i c a t i o n C e n t e r� �  F i n d e r S y n c E x t� � ( c o m . a p p l e . d o c k . e x t r a� � " C o r e L o c a t i o n A g e n t� �   O v e r S i g h t   H e l p e r� �  w i t c h d a e m o n� �  i m k l a u n c h a g e n t� �    A i r P l a y U I A g e n t� �!!  W i F i A g e n t� �""  n b a g e n t� �##  i S t a t M e n u s A g e n t� �$$ $ i S t a t   M e n u s   S t a t u s� �%% 8 K e y c h a i n   C i r c l e   N o t i f i c a t i o n� �&&  L a t e r A g e n t� �''  s t o r e a s s e t d� �((  c l o u d p h o t o s d� �))  O v e r f l o w� �** B c o m . a p p l e . s p e e c h . s p e e c h s y n t h e s i s d� �++  O S D U I H e l p e r� �,,  K e e p i n g Y o u A w a k e� �-- & C o r e S e r v i c e s U I A g e n t� �..  T e r m i n a l� �//  C o t E d i t o r  �00  S a f a r i �11 6 c o m . a p p l e . W e b K i t . N e t w o r k i n g �22 0 c o m . a p p l e . W e b K i t . S t o r a g e �33 6 c o m . a p p l e . W e b K i t . W e b C o n t e n t �44 < c o m . a p p l e . S a f a r i . S a n d b o x B r o k e r �55  i T e r m 2 �66  P r e f s   E d i t o r �77  S y s t e m   E v e n t s �88 . F o l d e r A c t i o n s D i s p a t c h e r	 �99  S c r i p t   E d i t o r
 �::  W h a t s A p p
�� 
msng �;;  F i n d e r S y n c E x t �<<  S e c u r i t y A g e n t��*��� .��  ��  ��  ��  ��  ��   ascr  ��ޭ