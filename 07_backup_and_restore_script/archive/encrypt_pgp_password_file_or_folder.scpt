FasdUAS 1.101.10   ��   ��    k             l    
 ����  O     
  	  I   	������
�� .miscactvnull��� ��� null��  ��   	 m     ��
�� misccura��  ��     
  
 l     ��������  ��  ��        l     ��  ��    , &display dialog "starting archiving..."     �   L d i s p l a y   d i a l o g   " s t a r t i n g   a r c h i v i n g . . . "      l     ��������  ��  ��        l    ����  r        J           m       �    f i l e   ��  m       �    d i r e c t o r y��    o      ����  0 thechoiceslist theChoicesList��  ��       !   l    "���� " r     # $ # I   �� % &
�� .gtqpchltns    @   @ ns   % o    ����  0 thechoiceslist theChoicesList & �� ' (
�� 
prmp ' m     ) ) � * * h S e l e c t   i f   y o u   w a n t   t o   a r c h i v e   a   f i l e   o r   a   d i r e c t o r y : ( �� +��
�� 
inSL + J     , ,  -�� - m     . . � / /  f i l e��  ��   $ o      ���� 0 	inputtype 	inputType��  ��   !  0 1 0 l     �� 2 3��   2  display dialog inputType    3 � 4 4 0 d i s p l a y   d i a l o g   i n p u t T y p e 1  5 6 5 l     �� 7 8��   7 = 7if inputType is not equal to "file" or "directory" then    8 � 9 9 n i f   i n p u t T y p e   i s   n o t   e q u a l   t o   " f i l e "   o r   " d i r e c t o r y "   t h e n 6  : ; : l     �� < =��   < B <	display dialog "Error: No valid input selected, exiting..."    = � > > x 	 d i s p l a y   d i a l o g   " E r r o r :   N o   v a l i d   i n p u t   s e l e c t e d ,   e x i t i n g . . . " ;  ? @ ? l     �� A B��   A  	return    B � C C  	 r e t u r n @  D E D l     �� F G��   F  end if    G � H H  e n d   i f E  I J I l     ��������  ��  ��   J  K L K l    f M���� M Z     f N O P Q N =    % R S R o     !���� 0 	inputtype 	inputType S J   ! $ T T  U�� U m   ! " V V � W W  f i l e��   O k   ( 9 X X  Y Z Y l  ( (�� [ \��   [ � �set inputFolder to (choose file with prompt "Select a file to be archived" default location path to desktop with multiple selections allowed)    \ � ] ] s e t   i n p u t F o l d e r   t o   ( c h o o s e   f i l e   w i t h   p r o m p t   " S e l e c t   a   f i l e   t o   b e   a r c h i v e d "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p   w i t h   m u l t i p l e   s e l e c t i o n s   a l l o w e d ) Z  ^�� ^ r   ( 9 _ ` _ l  ( 5 a���� a I  ( 5���� b
�� .sysostdfalis    ��� null��   b �� c d
�� 
prmp c m   * + e e � f f 8 S e l e c t   a   f i l e   t o   b e   a r c h i v e d d �� g��
�� 
dflc g I  , 1�� h��
�� .earsffdralis        afdr h m   , -��
�� afdrdesk��  ��  ��  ��   ` o      ���� 0 	inputitem 	inputItem��   P  i j i =  < C k l k o   < =���� 0 	inputtype 	inputType l J   = B m m  n�� n m   = @ o o � p p  d i r e c t o r y��   j  q�� q k   F Y r r  s t s l  F F�� u v��   u � �set inputItem to (choose folder with prompt "Select a directory to be archived" default location path to desktop with multiple selections allowed)    v � w w$ s e t   i n p u t I t e m   t o   ( c h o o s e   f o l d e r   w i t h   p r o m p t   " S e l e c t   a   d i r e c t o r y   t o   b e   a r c h i v e d "   d e f a u l t   l o c a t i o n   p a t h   t o   d e s k t o p   w i t h   m u l t i p l e   s e l e c t i o n s   a l l o w e d ) t  x�� x r   F Y y z y l  F U {���� { I  F U���� |
�� .sysostflalis    ��� null��   | �� } ~
�� 
prmp } m   H K   � � � B S e l e c t   a   d i r e c t o r y   t o   b e   a r c h i v e d ~ �� ���
�� 
dflc � I  L Q�� ���
�� .earsffdralis        afdr � m   L M��
�� afdrdesk��  ��  ��  ��   z o      ���� 0 	inputitem 	inputItem��  ��   Q k   \ f � �  � � � I  \ c�� ���
�� .sysodlogaskr        TEXT � m   \ _ � � � � � T E r r o r :   N o   v a l i d   i n p u t   s e l e c t e d ,   e x i t i n g . . .��   �  ��� � L   d f����  ��  ��  ��   L  � � � l     ��������  ��  ��   �  � � � l  g y ����� � O  g y � � � r   m x � � � n   m t � � � 1   p t��
�� 
posx � o   m p���� 0 	inputitem 	inputItem � o      ����  0 posixinputitem posixinputItem � m   g j � ��                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  ��  ��   �  � � � l  z � ����� � r   z � � � � n   z � � � � 1   } ���
�� 
strq � o   z }����  0 posixinputitem posixinputItem � o      ���� 0 ipp  ��  ��   �  � � � l     �� � ���   �  display dialog ipp    � � � � $ d i s p l a y   d i a l o g   i p p �  � � � l     ��������  ��  ��   �  � � � l  � � ����� � r   � � � � � l  � � ����� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � m   � � � � � � � " e c h o   " $ ( b a s e n a m e   � o   � ����� 0 ipp   � m   � � � � � � � (   |   c u t   - d .   - f 1 ) " . g p g��  ��  ��   � o      ���� "0 defaultsavename defaultSaveName��  ��   �  � � � l     �� � ���   � $ display dialog defaultSaveName    � � � � < d i s p l a y   d i a l o g   d e f a u l t S a v e N a m e �  � � � l  � � ����� � r   � � � � � l  � � ����� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � m   � � � � � � �   e c h o   " $ ( d i r n a m e   � o   � ����� 0 ipp   � m   � � � � � � �  ) "��  ��  ��   � o      ���� "0 defaultsavepath defaultSavePath��  ��   �  � � � l     �� � ���   � $ display dialog defaultSavePath    � � � � < d i s p l a y   d i a l o g   d e f a u l t S a v e P a t h �  � � � l  � � ����� � r   � � � � � c   � � � � � 4   � ��� �
�� 
psxf � o   � ����� "0 defaultsavepath defaultSavePath � m   � ���
�� 
alis � o      ���� 80 defaultsavepathapplescript defaultSavePathApplescript��  ��   �  � � � l     �� � ���   � / )display dialog defaultSavePathApplescript    � � � � R d i s p l a y   d i a l o g   d e f a u l t S a v e P a t h A p p l e s c r i p t �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � , & save to same directory without asking    � � � � L   s a v e   t o   s a m e   d i r e c t o r y   w i t h o u t   a s k i n g �  � � � l     �� � ���   � = 7set fileSave to defaultSavePath & "/" & defaultSaveName    � � � � n s e t   f i l e S a v e   t o   d e f a u l t S a v e P a t h   &   " / "   &   d e f a u l t S a v e N a m e �  � � � l     �� � ���   � #  ask for directory to save to    � � � � :   a s k   f o r   d i r e c t o r y   t o   s a v e   t o �  � � � l  � � ����� � r   � � � � � I  � ����� �
�� .sysonwflfile    ��� null��   � �� � �
�� 
prmt � m   � � � � � � �  S a v e   A s � �� � �
�� 
dfnm � o   � ����� "0 defaultsavename defaultSaveName � �� ��
�� 
dflc � o   � ��~�~ 80 defaultsavepathapplescript defaultSavePathApplescript�   � o      �}�} 0 filesave fileSave��  ��   �  � � � l     �| � ��|   �  display dialog fileSave    � � � � . d i s p l a y   d i a l o g   f i l e S a v e �  � � � l  � � ��{�z � r   � � �  � n   � � 1   � ��y
�y 
psxp o   � ��x�x 0 filesave fileSave  o      �w�w 0 filesave fileSave�{  �z   �  l  ��v�u Z  ��t�s H   � � D   � �	
	 o   � ��r�r 0 filesave fileSave
 m   � � �  . g p g r   � � b   � � o   � ��q�q 0 filesave fileSave m   � � �  . g p g o      �p�p 0 filesave fileSave�t  �s  �v  �u    l     �o�o    display dialog fileSave    � . d i s p l a y   d i a l o g   f i l e S a v e  l     �n�m�l�n  �m  �l    l �k�j r   n    1  	�i
�i 
strq  n  	!"! 1  	�h
�h 
psxp" o  �g�g 0 filesave fileSave o      �f�f 0 opp  �k  �j   #$# l     �e%&�e  %  display dialog opp   & �'' $ d i s p l a y   d i a l o g   o p p$ ()( l     �d*+�d  * > 8 testing if file already exists, macos does that already   + �,, p   t e s t i n g   i f   f i l e   a l r e a d y   e x i s t s ,   m a c o s   d o e s   t h a t   a l r e a d y) -.- l     �c/0�c  / $ set testFileExists to fileSave   0 �11 < s e t   t e s t F i l e E x i s t s   t o   f i l e S a v e. 232 l     �b45�b  4  tell application "Finder"   5 �66 2 t e l l   a p p l i c a t i o n   " F i n d e r "3 787 l     �a9:�a  9 ) #	if exists file testFileExists then   : �;; F 	 i f   e x i s t s   f i l e   t e s t F i l e E x i s t s   t h e n8 <=< l     �`>?�`  > r l		set question to display dialog "file already exists, overwrite it?" buttons {"Yes", "No"} default button 2   ? �@@ � 	 	 s e t   q u e s t i o n   t o   d i s p l a y   d i a l o g   " f i l e   a l r e a d y   e x i s t s ,   o v e r w r i t e   i t ? "   b u t t o n s   { " Y e s " ,   " N o " }   d e f a u l t   b u t t o n   2= ABA l     �_CD�_  C 1 +		set answer to button returned of question   D �EE V 	 	 s e t   a n s w e r   t o   b u t t o n   r e t u r n e d   o f   q u e s t i o nB FGF l     �^HI�^  H ! 		if (answer is "Yes") then   I �JJ 6 	 	 i f   ( a n s w e r   i s   " Y e s " )   t h e nG KLK l     �]MN�]  M Z T			do shell script "cd \"$(dirname " & opp & ")\" && rm \"$(basename " & opp & ")\""   N �OO � 	 	 	 d o   s h e l l   s c r i p t   " c d   \ " $ ( d i r n a m e   "   &   o p p   &   " ) \ "   & &   r m   \ " $ ( b a s e n a m e   "   &   o p p   &   " ) \ " "L PQP l     �\RS�\  R  return true   S �TT  r e t u r n   t r u eQ UVU l     �[WX�[  W  		else   X �YY  	 	 e l s eV Z[Z l     �Z\]�Z  \  			return false   ] �^^  	 	 	 r e t u r n   f a l s e[ _`_ l     �Yab�Y  a  		end if   b �cc  	 	 e n d   i f` ded l     �Xfg�X  f  	else   g �hh 
 	 e l s ee iji l     �Wkl�W  k  return false   l �mm  r e t u r n   f a l s ej non l     �Vpq�V  p  	end if   q �rr  	 e n d   i fo sts l     �Uuv�U  u  end tell   v �ww  e n d   t e l lt xyx l     �T�S�R�T  �S  �R  y z{z l     �Q|}�Q  | E ? using which to detect the install path of the homebrew command   } �~~ ~   u s i n g   w h i c h   t o   d e t e c t   t h e   i n s t a l l   p a t h   o f   t h e   h o m e b r e w   c o m m a n d{ � l -��P�O� r  -��� I )�N��M
�N .sysoexecTEXT���     TEXT� b  %��� b  !��� b  ��� b  ��� m  �� ���� i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   p v ,   c o r e u t i l s   a n d   g n u p g   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e   e c h o   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   g d u ' )   - s c b   " $ ( d i r n a m e  � o  �L�L 0 ipp  � m  �� ���  ) " / " $ ( b a s e n a m e  � o   �K�K 0 ipp  � m  !$�� ��� � ) "   |   t a i l   - 1   |   a w k   ' { p r i n t   $ 1 } '   |   w h i l e   r e a d   i   ;   d o   e c h o   $ ( e c h o   $ i * 1 . 0   |   b c   |   c u t   - d ' . '   - f 1     )   ;   d o n e ) ;   f i�M  � o      �J�J 
0 pvsize  �P  �O  � ��� l     �I�H�G�I  �H  �G  � ��� l .���F�E� Z  .����D�� = .7��� n  .5��� 1  15�C
�C 
prun� m  .1���                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  � m  56�B
�B boovtrue� O  :���� k  @��� ��� I @E�A�@�?
�A .miscactvnull��� ��� null�@  �?  � ��� I FK�>��=
�> .sysodelanull��� ��� nmbr� m  FG�<�< �=  � ��� Z  L����;�� = LW��� l LU��:�9� I LU�8��7
�8 .corecnte****       ****� 2 LQ�6
�6 
cwin�7  �:  �9  � m  UV�5�5  � k  Zm�� ��� I Z_�4�3�2
�4 .aevtrappnull��� ��� null�3  �2  � ��� I `e�1�0�/
�1 .miscactvnull��� ��� null�0  �/  � ��� l ff�.���.  � J Dtell application "System Events" to keystroke "n" using command down   � ��� � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " n "   u s i n g   c o m m a n d   d o w n� ��-� I fm�,��+
�, .sysodelanull��� ��� nmbr� m  fi�� ?��������+  �-  �;  � k  p��� ��� O p���� I v��*��
�* .prcskprsnull���     ctxt� m  vy�� ���  n� �)��(
�) 
faal� J  |��� ��� m  |�'
�' eMdsKopt� ��&� m  ��%
�% eMdsKcmd�&  �(  � m  ps���                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  � ��$� I ���#��"
�# .sysodelanull��� ��� nmbr� m  ���� ?��������"  �$  � ��!� I ��� ��
�  .sysodelanull��� ��� nmbr� m  ���� ?�      �  �!  � m  :=���                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �D  � O  ����� k  ���� ��� I �����
� .miscactvnull��� ��� null�  �  � ��� I �����
� .sysodelanull��� ��� nmbr� m  ���� ?�      �  �  � m  �����                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �F  �E  � ��� l     ����  �  �  � ��� l �%���� O  �%��� k  �$�� ��� I �����
� .miscactvnull��� ��� null�  �  � ��� l ������  � J Dtell application "System Events" to keystroke "t" using command down   � ��� � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " t "   u s i n g   c o m m a n d   d o w n� ��� l ������  � L Frepeat while contents of selected tab of window 1 starts with linefeed   � ��� � r e p e a t   w h i l e   c o n t e n t s   o f   s e l e c t e d   t a b   o f   w i n d o w   1   s t a r t s   w i t h   l i n e f e e d� ��� l ������  �  
	delay 1.5   � ���  	 d e l a y   1 . 5� ��� l ������  �  
end repeat   � ���  e n d   r e p e a t� ��� l �����
�  �  �
  � ��� I ���	��
�	 .sysodelanull��� ��� nmbr� m  ��   ?�      �  �  l ������  �  �    I �"�
� .coredoscnull��� ��� ctxt b  � b  �	
	 b  �	 b  � b  � b  �� b  �� b  �� b  �� b  �� b  �� b  �� b  ��  b  ��!"! b  ��#$# b  ��%&% b  ��'(' b  ��)*) m  ��++ �,,  p r i n t f   ' \ e c '   & &   e c h o   ' '   & &   e c h o   - e   ' \ 0 3 3 [ 1 m s t a r t i n g   e n c r y p t i o n . . . \ 0 3 3 [ 0 m ' ; i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   p v   a n d   c o r e u t i l s   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e     e c h o   ' '   & &   e c h o   ' p l e a s e   s e t   e n c r y p t i o n   p a s s w o r d . . . '   & &   G P G _ P A S S W O R D = '         '   & &   w h i l e   [ [   $ G P G _ P A S S W O R D   ! =   $ G P G _ P A S S W O R D 2   ] ]   | |   [ [   $ G P G _ P A S S W O R D   = =   ' '   ] ] ;   d o   s t t y   - e c h o   & &   t r a p   ' s t t y   e c h o '   E X I T   & &   p r i n t f   ' g p g   p a s s w o r d :   '   & &   r e a d   - r   $ @   G P G _ P A S S W O R D   & &   p r i n t f   '   '   & &   e c h o   ' '   & &   p r i n t f   ' r e - e n t e r   g p g   p a s s w o r d :   '   & &   r e a d   - r   $ @   G P G _ P A S S W O R D 2   & &   s t t y   e c h o   & &   t r a p   -   E X I T   & &   e c h o   ' ' ;   d o n e   & &   e c h o   ' ' ;   e c h o   e n c r y p t i n g   " $ ( d i r n a m e  * o  ���� 0 ipp  ( m  ��-- �..  ) " / " $ ( b a s e n a m e  & o  ���� 0 ipp  $ m  ��// �00 > ) " ; p r i n t f   ' % - 1 1 s '   ' t o '   " $ ( e c h o  " o  ���� 0 opp    m  ��11 �22 @ ) "   & &   e c h o   ' ' ;   p u s h d   " $ ( d i r n a m e   o  ��� �  0 ipp   m  ��33 �44 B ) "   1 >   / d e v / n u l l ;   c a t   " $ ( b a s e n a m e   o  ������ 0 ipp   m  ��55 �66 F ) "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p v ' )   - s   o  ������ 
0 pvsize   m  ��77 �88�   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - c   - - b a t c h   - - y e s   - - q u i e t   - - s y m m e t r i c   - - p a s s p h r a s e = $ G P G _ P A S S W O R D   - - s 2 k - c i p h e r - a l g o   A E S 2 5 6   - - s 2 k - d i g e s t - a l g o   S H A 5 1 2   - - s 2 k - c o u n t   6 5 5 3 6   - - c o m p r e s s - a l g o   0   - o   " $ ( e c h o   o  ������ 0 opp   m  � 99 �:: � ) " ;   p o p d   1 >   / d e v / n u l l   & &   e c h o   ' '   & &   e c h o   ' t e s t i n g   i n t e g r i t y   o f   f i l e ( s ) '   & &   e c h o   - n   " $ ( b a s e n a m e   o  ���� 0 opp   m  ;; �<< ) " ' . . .   '   & &   b u i l t i n   e c h o   $ G P G _ P A S S W O R D   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - q u i e t   - - b a t c h   - - n o - t t y   - - y e s   - - p a s s p h r a s e - f d   0   - - d r y - r u n   - d   " $ ( e c h o  
 o  	���� 0 opp   m  == �>> ) "   > / d e v / n u l l   2 > & 1   & &   e c h o   - e   ' f i l e   i s   \ 0 3 3 [ 1 ; 3 2 m O K \ 0 3 3 [ 0 m '   | |   e c h o   - e   ' f i l e   i s   \ 0 3 3 [ 1 ; 3 1 m I N V A L I D \ 0 3 3 [ 0 m ' ;   e c h o   ' ' ;   e c h o   ' d o n e   ; ) ' ;   e c h o   ' ' ;   f i ��?��
�� 
kfil? n  @A@ 1  ��
�� 
tcntA 4 ��B
�� 
cwinB m  ���� ��   C��C l ##��������  ��  ��  ��  � m  ��DD�                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �  �  � EFE l     ��������  ��  ��  F GHG l     ��������  ��  ��  H IJI l     ��������  ��  ��  J KLK l     ��MN��  M !  \" keeping spaces alive \"   N �OO 6   \ "   k e e p i n g   s p a c e s   a l i v e   \ "L PQP l     ��������  ��  ��  Q R��R l     ��������  ��  ��  ��       ��ST��  S ��
�� .aevtoappnull  �   � ****T ��U����VW��
�� .aevtoappnull  �   � ****U k    %XX  YY  ZZ   [[  K\\  �]]  �^^  �__  �``  �aa  �bb  �cc dd ee ff �gg �����  ��  ��  V  W P����  ���� )�� .������ V e���������� o �� ��� ��������� � ����� � ����������� ���������������������������������������� +-/13579;=������
�� misccura
�� .miscactvnull��� ��� null��  0 thechoiceslist theChoicesList
�� 
prmp
�� 
inSL�� 
�� .gtqpchltns    @   @ ns  �� 0 	inputtype 	inputType
�� 
dflc
�� afdrdesk
�� .earsffdralis        afdr
�� .sysostdfalis    ��� null�� 0 	inputitem 	inputItem
�� .sysostflalis    ��� null
�� .sysodlogaskr        TEXT
�� 
posx��  0 posixinputitem posixinputItem
�� 
strq�� 0 ipp  
�� .sysoexecTEXT���     TEXT�� "0 defaultsavename defaultSaveName�� "0 defaultsavepath defaultSavePath
�� 
psxf
�� 
alis�� 80 defaultsavepathapplescript defaultSavePathApplescript
�� 
prmt
�� 
dfnm�� 
�� .sysonwflfile    ��� null�� 0 filesave fileSave
�� 
psxp�� 0 opp  �� 
0 pvsize  
�� 
prun
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
�� 
tcnt
�� .coredoscnull��� ��� ctxt��&� *j UO��lvE�O�����kv� 
E�O��kv  *����j � E` Y ,�a kv  *�a ��j � E` Y a j OhOa  _ a ,E` UO_ a ,E` Oa _ %a %j E`  Oa !_ %a "%j E` #O*a $_ #/a %&E` &O*a 'a (a )_  �_ &a * +E` ,O_ ,a -,E` ,O_ ,a . _ ,a /%E` ,Y hO_ ,a -,a ,E` 0Oa 1_ %a 2%_ %a 3%j E` 4Oa 5a 6,e  ea 5 [*j Okj 7O*a 8-j 9j  *j :O*j Oa ;j 7Y #a  a <a =a >a ?lvl @UOa ;j 7Oa Aj 7UY a 5 *j Oa Aj 7UOa 5 n*j Oa Bj 7Oa C_ %a D%_ %a E%_ 0%a F%_ %a G%_ %a H%_ 4%a I%_ 0%a J%_ 0%a K%_ 0%a L%a M*a 8k/a N,l OOPUascr  ��ޭ