FasdUAS 1.101.10   ��   ��    k             l    
 ����  O     
  	  I   	������
�� .miscactvnull��� ��� null��  ��   	 m     ��
�� misccura��  ��     
  
 l     ��������  ��  ��        l     ��  ��    , &display dialog "starting archiving..."     �   L d i s p l a y   d i a l o g   " s t a r t i n g   a r c h i v i n g . . . "      l     ��������  ��  ��        l    ����  r        l    ����  I   ���� 
�� .sysostflalis    ��� null��    ��  
�� 
prmp  m       �   < S e l e c t   a   f o l d e r   t o   b e   a r c h i v e d  �� ��
�� 
dflc  I   �� ��
�� .earsffdralis        afdr  m    ��
�� afdrdesk��  ��  ��  ��    o      ���� 0 inputfolder inputFolder��  ��       !   l   % "���� " O   % # $ # r    $ % & % n    " ' ( ' 1     "��
�� 
posx ( o     ���� 0 inputfolder inputFolder & o      ���� $0 posixinputfolder posixinputFolder $ m     ) )�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  ��  ��   !  * + * l  & + ,���� , r   & + - . - n   & ) / 0 / 1   ' )��
�� 
strq 0 o   & '���� $0 posixinputfolder posixinputFolder . o      ���� 0 ipp  ��  ��   +  1 2 1 l     �� 3 4��   3  display dialog ipp    4 � 5 5 $ d i s p l a y   d i a l o g   i p p 2  6 7 6 l  , ; 8���� 8 r   , ; 9 : 9 l  , 7 ;���� ; I  , 7�� <��
�� .sysoexecTEXT���     TEXT < b   , 3 = > = b   , / ? @ ? m   , - A A � B B " e c h o   " $ ( b a s e n a m e   @ o   - .���� 0 ipp   > m   / 2 C C � D D  ) " . t a r . g z . g p g��  ��  ��   : o      ���� "0 defaultsavename defaultSaveName��  ��   7  E F E l     �� G H��   G $ display dialog defaultSaveName    H � I I < d i s p l a y   d i a l o g   d e f a u l t S a v e N a m e F  J K J l  < M L���� L r   < M M N M l  < I O���� O I  < I�� P��
�� .sysoexecTEXT���     TEXT P b   < E Q R Q b   < A S T S m   < ? U U � V V   e c h o   " $ ( d i r n a m e   T o   ? @���� 0 ipp   R m   A D W W � X X  ) "��  ��  ��   N o      ���� "0 defaultsavepath defaultSavePath��  ��   K  Y Z Y l     �� [ \��   [ $ display dialog defaultSavePath    \ � ] ] < d i s p l a y   d i a l o g   d e f a u l t S a v e P a t h Z  ^ _ ^ l  N ^ `���� ` r   N ^ a b a c   N Z c d c 4   N V�� e
�� 
psxf e o   R U���� "0 defaultsavepath defaultSavePath d m   V Y��
�� 
alis b o      ���� 80 defaultsavepathapplescript defaultSavePathApplescript��  ��   _  f g f l     �� h i��   h / )display dialog defaultSavePathApplescript    i � j j R d i s p l a y   d i a l o g   d e f a u l t S a v e P a t h A p p l e s c r i p t g  k l k l     ��������  ��  ��   l  m n m l     �� o p��   o , & save to same directory without asking    p � q q L   s a v e   t o   s a m e   d i r e c t o r y   w i t h o u t   a s k i n g n  r s r l     �� t u��   t = 7set fileSave to defaultSavePath & "/" & defaultSaveName    u � v v n s e t   f i l e S a v e   t o   d e f a u l t S a v e P a t h   &   " / "   &   d e f a u l t S a v e N a m e s  w x w l     �� y z��   y #  ask for directory to save to    z � { { :   a s k   f o r   d i r e c t o r y   t o   s a v e   t o x  | } | l  _ z ~���� ~ r   _ z  �  I  _ v���� �
�� .sysonwflfile    ��� null��   � �� � �
�� 
prmt � m   c f � � � � �  S a v e   A s � �� � �
�� 
dfnm � o   i l���� "0 defaultsavename defaultSaveName � �� ���
�� 
dflc � o   m p���� 80 defaultsavepathapplescript defaultSavePathApplescript��   � o      ���� 0 filesave fileSave��  ��   }  � � � l     �� � ���   �  display dialog fileSave    � � � � . d i s p l a y   d i a l o g   f i l e S a v e �  � � � l  { � ����� � r   { � � � � n   { � � � � 1   ~ ���
�� 
psxp � o   { ~���� 0 filesave fileSave � o      ���� 0 filesave fileSave��  ��   �  � � � l  � � ����� � Z  � � � ����� � H   � � � � D   � � � � � o   � ����� 0 filesave fileSave � m   � � � � � � �  . t a r . g z . g p g � r   � � � � � b   � � � � � o   � ����� 0 filesave fileSave � m   � � � � � � �  . t a r . g z . g p g � o      ���� 0 filesave fileSave��  ��  ��  ��   �  � � � l     �� � ���   �  display dialog fileSave    � � � � . d i s p l a y   d i a l o g   f i l e S a v e �  � � � l     ��������  ��  ��   �  � � � l  � � ����� � r   � � � � � n   � � � � � 1   � ���
�� 
strq � n   � � � � � 1   � ���
�� 
psxp � o   � ����� 0 filesave fileSave � o      ���� 0 opp  ��  ��   �  � � � l     �� � ���   �  display dialog opp    � � � � $ d i s p l a y   d i a l o g   o p p �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � > 8 testing if file already exists, macos does that already    � � � � p   t e s t i n g   i f   f i l e   a l r e a d y   e x i s t s ,   m a c o s   d o e s   t h a t   a l r e a d y �  � � � l     �� � ���   � $ set testFileExists to fileSave    � � � � < s e t   t e s t F i l e E x i s t s   t o   f i l e S a v e �  � � � l     �� � ���   �  tell application "Finder"    � � � � 2 t e l l   a p p l i c a t i o n   " F i n d e r " �  � � � l     �� � ���   � ) #	if exists file testFileExists then    � � � � F 	 i f   e x i s t s   f i l e   t e s t F i l e E x i s t s   t h e n �  � � � l     �� � ���   � r l		set question to display dialog "file already exists, overwrite it?" buttons {"Yes", "No"} default button 2    � � � � � 	 	 s e t   q u e s t i o n   t o   d i s p l a y   d i a l o g   " f i l e   a l r e a d y   e x i s t s ,   o v e r w r i t e   i t ? "   b u t t o n s   { " Y e s " ,   " N o " }   d e f a u l t   b u t t o n   2 �  � � � l     �� � ���   � 1 +		set answer to button returned of question    � � � � V 	 	 s e t   a n s w e r   t o   b u t t o n   r e t u r n e d   o f   q u e s t i o n �  � � � l     �� � ���   � ! 		if (answer is "Yes") then    � � � � 6 	 	 i f   ( a n s w e r   i s   " Y e s " )   t h e n �  � � � l     �� � ���   � Z T			do shell script "cd \"$(dirname " & opp & ")\" && rm \"$(basename " & opp & ")\""    � � � � � 	 	 	 d o   s h e l l   s c r i p t   " c d   \ " $ ( d i r n a m e   "   &   o p p   &   " ) \ "   & &   r m   \ " $ ( b a s e n a m e   "   &   o p p   &   " ) \ " " �  � � � l     �� � ���   �  return true    � � � �  r e t u r n   t r u e �  � � � l     �� � ���   �  		else    � � � �  	 	 e l s e �  � � � l     �� � ���   �  			return false    � � � �  	 	 	 r e t u r n   f a l s e �  � � � l     �� � ���   �  		end if    � � � �  	 	 e n d   i f �  � � � l     �� � ���   �  	else    � � � � 
 	 e l s e �  � � � l     �� � ��   �  return false     �  r e t u r n   f a l s e �  l     ����    	end if    �  	 e n d   i f  l     ��	
��  	  end tell   
 �  e n d   t e l l  l     ��������  ��  ��    l     ����   E ? using which to detect the install path of the homebrew command    � ~   u s i n g   w h i c h   t o   d e t e c t   t h e   i n s t a l l   p a t h   o f   t h e   h o m e b r e w   c o m m a n d  l  � ���� r   � � I  � ��~�}
�~ .sysoexecTEXT���     TEXT b   � � b   � � b   � � b   � �  m   � �!! �""� i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u - t a r )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p i g z )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   g n u - t a r ,   p i g z ,   p v ,   c o r e u t i l s   a n d   g n u p g   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e   e c h o   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   g d u ' )   - s c b   " $ ( d i r n a m e    o   � ��|�| 0 ipp   m   � �## �$$  ) " / " $ ( b a s e n a m e   o   � ��{�{ 0 ipp   m   � �%% �&& � ) " /   |   t a i l   - 1   |   a w k   ' { p r i n t   $ 1 } '   |   w h i l e   r e a d   i   ;   d o   e c h o   $ ( e c h o   $ i * 1 . 0   |   b c   |   c u t   - d ' . '   - f 1     )   ;   d o n e ) ;   f i�}   o      �z�z 
0 pvsize  ��  �   '(' l     �y�x�w�y  �x  �w  ( )*) l  �R+�v�u+ Z   �R,-�t., =  � �/0/ n   � �121 1   � ��s
�s 
prun2 m   � �33�                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  0 m   � ��r
�r boovtrue- O   �;454 k   �:66 787 I  � ��q�p�o
�q .miscactvnull��� ��� null�p  �o  8 9:9 I  � ��n;�m
�n .sysodelanull��� ��� nmbr; m   � �<< ?�      �m  : =>= Z   �2?@�lA? =  � �BCB l  � �D�k�jD I  � ��iE�h
�i .corecnte****       ****E 2  � ��g
�g 
cwin�h  �k  �j  C m   � ��f�f  @ k   �FF GHG O  �IJI I  ��eKL
�e .prcskprsnull���     ctxtK m   � �MM �NN  nL �dO�c
�d 
faalO m   �b
�b eMdsKcmd�c  J m   � �PP�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  H Q�aQ I 	�`R�_
�` .sysodelanull��� ��� nmbrR m  	SS ?��������_  �a  �l  A k  2TT UVU O *WXW I )�^YZ
�^ .prcskprsnull���     ctxtY m  [[ �\\  nZ �]]�\
�] 
faal] J  %^^ _`_ m   �[
�[ eMdsKopt` a�Za m   #�Y
�Y eMdsKcmd�Z  �\  X m  bb�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  V c�Xc I +2�Wd�V
�W .sysodelanull��� ��� nmbrd m  +.ee ?��������V  �X  > f�Uf I 3:�Tg�S
�T .sysodelanull��� ��� nmbrg m  36hh ?�      �S  �U  5 m   � �ii�                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �t  . O  >Rjkj k  DQll mnm I DI�R�Q�P
�R .miscactvnull��� ��� null�Q  �P  n o�Oo I JQ�Np�M
�N .sysodelanull��� ��� nmbrp m  JMqq ?�      �M  �O  k m  >Arr�                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �v  �u  * sts l     �L�K�J�L  �K  �J  t uvu l S�w�I�Hw O  S�xyx k  Y�zz {|{ I Y^�G�F�E
�G .miscactvnull��� ��� null�F  �E  | }~} l __�D��D   J Dtell application "System Events" to keystroke "t" using command down   � ��� � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " t "   u s i n g   c o m m a n d   d o w n~ ��� l __�C���C  � L Frepeat while contents of selected tab of window 1 starts with linefeed   � ��� � r e p e a t   w h i l e   c o n t e n t s   o f   s e l e c t e d   t a b   o f   w i n d o w   1   s t a r t s   w i t h   l i n e f e e d� ��� l __�B���B  �  
	delay 1.5   � ���  	 d e l a y   1 . 5� ��� l __�A���A  �  
end repeat   � ���  e n d   r e p e a t� ��� l __�@�?�>�@  �?  �>  � ��� I _f�=��<
�= .sysodelanull��� ��� nmbr� m  _b�� ?�      �<  � ��� l gg�;�:�9�;  �:  �9  � ��� l gg�8���8  � #  using gui input for password   � ��� :   u s i n g   g u i   i n p u t   f o r   p a s s w o r d� ��� l gg�7���7  ���do script "printf '\\ec' && echo '' && echo -e '\\033[1mstarting encryption...\\033[0m'; if [[ $($($SHELL -l -c 'which brew') list | grep gnu-tar) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep pigz) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep pv) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep coreutils) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep gnupg) == '' ]]; then echo at least one homebrew tool of gnu-tar, pigz, pv and coreutils is missing, exiting... && exit; else echo ''; echo archiving \"$(dirname " & ipp & ")\"/\"$(basename " & ipp & ")\"/;printf '%-10s' 'to' \"$(echo " & opp & ")\" && echo; pushd \"$(dirname " & ipp & ")\" 1> /dev/null; $($SHELL -l -c 'which gtar') -cpf - \"$(basename " & ipp & ")\" | $($SHELL -l -c 'which pv') -s " & pvsize & " | $($SHELL -l -c 'which pigz') --best | $($SHELL -l -c 'which gpg') --batch --yes --quiet --symmetric --s2k-cipher-algo AES256 --s2k-digest-algo SHA512 --s2k-count 65536 --compress-algo 0 -o \"$(echo " & opp & ")\"; popd 1> /dev/null && echo '' && echo 'testing integrity of file(s)' && echo '' && echo -n \"$(basename " & opp & ")\"'... ' && $($SHELL -l -c 'which gpg') --quiet -d \"$(echo " & opp & ")\" | $($SHELL -l -c 'which unpigz') | $($SHELL -l -c 'which gtar') -tvv >/dev/null 2>&1 && echo -e 'file is \\033[1;32mOK\\033[0m' || echo -e 'file is \\033[1;31mINVALID\\033[0m'; echo ''; echo 'done ;)'; echo ''; fi" in selected tab of front window   � ���z d o   s c r i p t   " p r i n t f   ' \ \ e c '   & &   e c h o   ' '   & &   e c h o   - e   ' \ \ 0 3 3 [ 1 m s t a r t i n g   e n c r y p t i o n . . . \ \ 0 3 3 [ 0 m ' ;   i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u - t a r )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p i g z )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   g n u - t a r ,   p i g z ,   p v   a n d   c o r e u t i l s   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e   e c h o   ' ' ;   e c h o   a r c h i v i n g   \ " $ ( d i r n a m e   "   &   i p p   &   " ) \ " / \ " $ ( b a s e n a m e   "   &   i p p   &   " ) \ " / ; p r i n t f   ' % - 1 0 s '   ' t o '   \ " $ ( e c h o   "   &   o p p   &   " ) \ "   & &   e c h o ;   p u s h d   \ " $ ( d i r n a m e   "   &   i p p   &   " ) \ "   1 >   / d e v / n u l l ;   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - c p f   -   \ " $ ( b a s e n a m e   "   &   i p p   &   " ) \ "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p v ' )   - s   "   &   p v s i z e   &   "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p i g z ' )   - - b e s t   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - b a t c h   - - y e s   - - q u i e t   - - s y m m e t r i c   - - s 2 k - c i p h e r - a l g o   A E S 2 5 6   - - s 2 k - d i g e s t - a l g o   S H A 5 1 2   - - s 2 k - c o u n t   6 5 5 3 6   - - c o m p r e s s - a l g o   0   - o   \ " $ ( e c h o   "   &   o p p   &   " ) \ " ;   p o p d   1 >   / d e v / n u l l   & &   e c h o   ' '   & &   e c h o   ' t e s t i n g   i n t e g r i t y   o f   f i l e ( s ) '   & &   e c h o   ' '   & &   e c h o   - n   \ " $ ( b a s e n a m e   "   &   o p p   &   " ) \ " ' . . .   '   & &   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - q u i e t   - d   \ " $ ( e c h o   "   &   o p p   &   " ) \ "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   u n p i g z ' )   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - t v v   > / d e v / n u l l   2 > & 1   & &   e c h o   - e   ' f i l e   i s   \ \ 0 3 3 [ 1 ; 3 2 m O K \ \ 0 3 3 [ 0 m '   | |   e c h o   - e   ' f i l e   i s   \ \ 0 3 3 [ 1 ; 3 1 m I N V A L I D \ \ 0 3 3 [ 0 m ' ;   e c h o   ' ' ;   e c h o   ' d o n e   ; ) ' ;   e c h o   ' ' ;   f i "   i n   s e l e c t e d   t a b   o f   f r o n t   w i n d o w� ��� l gg�6���6  � !  using own password upfornt   � ��� 6   u s i n g   o w n   p a s s w o r d   u p f o r n t� ��� I g��5��
�5 .coredoscnull��� ��� ctxt� b  g���� b  g���� b  g���� b  g���� b  g���� b  g���� b  g���� b  g���� b  g���� b  g���� b  g���� b  g���� b  g~��� b  gz��� b  gv��� b  gr��� b  gp��� b  gl��� m  gj�� ���D p r i n t f   ' \ e c '   & &   e c h o   ' '   & &   e c h o   - e   ' \ 0 3 3 [ 1 m s t a r t i n g   e n c r y p t i o n . . . \ 0 3 3 [ 0 m ' ;   i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u - t a r )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p i g z )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   g n u - t a r ,   p i g z ,   p v   a n d   c o r e u t i l s   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e     e c h o   ' '   & &   e c h o   ' p l e a s e   s e t   e n c r y p t i o n   p a s s w o r d . . . '   & &   G P G _ P A S S W O R D = '         '   & &   w h i l e   [ [   $ G P G _ P A S S W O R D   ! =   $ G P G _ P A S S W O R D 2   ] ]   | |   [ [   $ G P G _ P A S S W O R D   = =   ' '   ] ] ;   d o   s t t y   - e c h o   & &   t r a p   ' s t t y   e c h o '   E X I T   & &   p r i n t f   ' g p g   p a s s w o r d :   '   & &   r e a d   - r   $ @   G P G _ P A S S W O R D   & &   p r i n t f   '   '   & &   e c h o   ' '   & &   p r i n t f   ' r e - e n t e r   g p g   p a s s w o r d :   '   & &   r e a d   - r   $ @   G P G _ P A S S W O R D 2   & &   s t t y   e c h o   & &   t r a p   -   E X I T   & &   e c h o   ' ' ;   d o n e   & &   e c h o   ' ' ;   e c h o   a r c h i v i n g   " $ ( d i r n a m e  � o  jk�4�4 0 ipp  � m  lo�� ���  ) " / " $ ( b a s e n a m e  � o  pq�3�3 0 ipp  � m  ru�� ��� @ ) " / ; p r i n t f   ' % - 1 0 s '   ' t o '   " $ ( e c h o  � o  vy�2�2 0 opp  � m  z}�� ��� @ ) "   & &   e c h o   ' ' ;   p u s h d   " $ ( d i r n a m e  � o  ~�1�1 0 ipp  � m  ���� ��� � ) "   1 >   / d e v / n u l l ;   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - c p f   -   " $ ( b a s e n a m e  � o  ���0�0 0 ipp  � m  ���� ��� F ) "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p v ' )   - s  � o  ���/�/ 
0 pvsize  � m  ���� ����   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p i g z ' )   - - b e s t   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - b a t c h   - - y e s   - - q u i e t   - - s y m m e t r i c   - - p a s s p h r a s e = $ G P G _ P A S S W O R D   - - s 2 k - c i p h e r - a l g o   A E S 2 5 6   - - s 2 k - d i g e s t - a l g o   S H A 5 1 2   - - s 2 k - c o u n t   6 5 5 3 6   - - c o m p r e s s - a l g o   0   - o   " $ ( e c h o  � o  ���.�. 0 opp  � m  ���� ��� � ) " ;   p o p d   1 >   / d e v / n u l l   & &   e c h o   ' '   & &   e c h o   ' t e s t i n g   i n t e g r i t y   o f   f i l e ( s ) '   & &   e c h o   ' '   & &   e c h o   - n   " $ ( b a s e n a m e  � o  ���-�- 0 opp  � m  ���� ��� ) " ' . . .   '   & &   b u i l t i n   e c h o   $ G P G _ P A S S W O R D   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - q u i e t   - - b a t c h   - - n o - t t y   - - y e s   - - p a s s p h r a s e - f d   0   - d   " $ ( e c h o  � o  ���,�, 0 opp  � m  ���� ���� ) "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   u n p i g z ' )   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - t v v   > / d e v / n u l l   2 > & 1   & &   e c h o   - e   ' f i l e   i s   \ 0 3 3 [ 1 ; 3 2 m O K \ 0 3 3 [ 0 m '   | |   e c h o   - e   ' f i l e   i s   \ 0 3 3 [ 1 ; 3 1 m I N V A L I D \ 0 3 3 [ 0 m ' ;   e c h o   ' ' ;   e c h o   ' d o n e   ; ) ' ;   e c h o   ' ' ;   f i� �+��*
�+ 
kfil� n  ����� 1  ���)
�) 
tcnt� 4 ���(�
�( 
cwin� m  ���'�' �*  � ��&� l ���%�$�#�%  �$  �#  �&  y m  SV���                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �I  �H  v ��� l     �"�!� �"  �!  �   � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     ����  � !  \" keeping spaces alive \"   � ��� 6   \ "   k e e p i n g   s p a c e s   a l i v e   \ "� ��� l     ����  �  �  � ��� l     ����  �  �  �       ����  � �
� .aevtoappnull  �   � ****� �������
� .aevtoappnull  �   � ****� k    ���  ��  ��       *  6  J  ^  |  �  �  � 		 )

 u��  �  �  �  � B�
�	� ������ )�� ���� A C���� U W���������� ����������� � ���!#%��3��<������M������S[�������������������
�
 misccura
�	 .miscactvnull��� ��� null
� 
prmp
� 
dflc
� afdrdesk
� .earsffdralis        afdr� 
� .sysostflalis    ��� null� 0 inputfolder inputFolder
� 
posx�  $0 posixinputfolder posixinputFolder
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
�� 
faal
�� eMdsKcmd
�� .prcskprsnull���     ctxt
�� eMdsKopt
�� 
kfil
�� 
tcnt
�� .coredoscnull��� ��� ctxt��� *j UO*����j � E�O� ��,E�UO��,E�O��%a %j E` Oa �%a %j E` O*a _ /a &E` O*a a a _ �_ a  E` O_ a ,E` O_ a   _ a !%E` Y hO_ a ,�,E` "Oa #�%a $%�%a %%j E` &Oa 'a (,e  la ' b*j Oa )j *O*a +-j ,j  � a -a .a /l 0UOa 1j *Y !� a 2a .a 3a /lvl 0UOa 1j *Oa )j *UY a ' *j Oa )j *UOa ' f*j Oa 4j *Oa 5�%a 6%�%a 7%_ "%a 8%�%a 9%�%a :%_ &%a ;%_ "%a <%_ "%a =%_ "%a >%a ?*a +k/a @,l AOPUascr  ��ޭ