FasdUAS 1.101.10   ��   ��    k             l    
 ����  O     
  	  I   	������
�� .miscactvnull��� ��� null��  ��   	 m     ��
�� misccura��  ��     
  
 l     ��������  ��  ��        l     ��  ��    , &display dialog "starting archiving..."     �   L d i s p l a y   d i a l o g   " s t a r t i n g   a r c h i v i n g . . . "      l     ��������  ��  ��        l    ����  r        l    ����  I   ���� 
�� .sysostdfalis    ��� null��    ��  
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
strq 0 o   & '���� $0 posixinputfolder posixinputFolder . o      ���� 0 ipp  ��  ��   +  1 2 1 l     ��������  ��  ��   2  3 4 3 l  , D 5���� 5 O  , D 6 7 6 r   0 C 8 9 8 l  0 ? :���� : e   0 ? ; ; n   0 ? < = < m   : >��
�� 
pcls = 4   0 :�� >
�� 
cobj > l  2 9 ?���� ? c   2 9 @ A @ o   2 5���� 0 unobjet unObjet A m   5 8��
�� 
ctxt��  ��  ��  ��   9 o      ���� 0 thetype theType 7 m   , - B B�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  ��  ��   4  C D C l  E H E���� E o   E H���� 0 thetype theType��  ��   D  F G F l     ��������  ��  ��   G  H I H l     �� J K��   J  display dialog ipp    K � L L $ d i s p l a y   d i a l o g   i p p I  M N M l  I Z O���� O r   I Z P Q P l  I V R���� R I  I V�� S��
�� .sysoexecTEXT���     TEXT S b   I R T U T b   I N V W V m   I L X X � Y Y " e c h o   " $ ( b a s e n a m e   W o   L M���� 0 ipp   U m   N Q Z Z � [ [ 6   |   c u t   - d .   - f 1 ) " . t a r . g z . g p g��  ��  ��   Q o      ���� "0 defaultsavename defaultSaveName��  ��   N  \ ] \ l     �� ^ _��   ^ $ display dialog defaultSaveName    _ � ` ` < d i s p l a y   d i a l o g   d e f a u l t S a v e N a m e ]  a b a l  [ l c���� c r   [ l d e d l  [ h f���� f I  [ h�� g��
�� .sysoexecTEXT���     TEXT g b   [ d h i h b   [ ` j k j m   [ ^ l l � m m   e c h o   " $ ( d i r n a m e   k o   ^ _���� 0 ipp   i m   ` c n n � o o  ) "��  ��  ��   e o      ���� "0 defaultsavepath defaultSavePath��  ��   b  p q p l     �� r s��   r $ display dialog defaultSavePath    s � t t < d i s p l a y   d i a l o g   d e f a u l t S a v e P a t h q  u v u l  m } w���� w r   m } x y x c   m y z { z 4   m u�� |
�� 
psxf | o   q t���� "0 defaultsavepath defaultSavePath { m   u x��
�� 
alis y o      ���� 80 defaultsavepathapplescript defaultSavePathApplescript��  ��   v  } ~ } l     ��  ���    / )display dialog defaultSavePathApplescript    � � � � R d i s p l a y   d i a l o g   d e f a u l t S a v e P a t h A p p l e s c r i p t ~  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � , & save to same directory without asking    � � � � L   s a v e   t o   s a m e   d i r e c t o r y   w i t h o u t   a s k i n g �  � � � l     �� � ���   � = 7set fileSave to defaultSavePath & "/" & defaultSaveName    � � � � n s e t   f i l e S a v e   t o   d e f a u l t S a v e P a t h   &   " / "   &   d e f a u l t S a v e N a m e �  � � � l     �� � ���   � #  ask for directory to save to    � � � � :   a s k   f o r   d i r e c t o r y   t o   s a v e   t o �  � � � l  ~ � ����� � r   ~ � � � � I  ~ ����� �
�� .sysonwflfile    ��� null��   � �� � �
�� 
prmt � m   � � � � � � �  S a v e   A s � �� � �
�� 
dfnm � o   � ����� "0 defaultsavename defaultSaveName � �� ���
�� 
dflc � o   � ����� 80 defaultsavepathapplescript defaultSavePathApplescript��   � o      ���� 0 filesave fileSave��  ��   �  � � � l     �� � ���   �  display dialog fileSave    � � � � . d i s p l a y   d i a l o g   f i l e S a v e �  � � � l  � � ����� � r   � � � � � n   � � � � � 1   � ���
�� 
psxp � o   � ����� 0 filesave fileSave � o      ���� 0 filesave fileSave��  ��   �  � � � l  � � ����� � Z  � � � ����� � H   � � � � D   � � � � � o   � ����� 0 filesave fileSave � m   � � � � � � �  . t a r . g z . g p g � r   � � � � � b   � � � � � o   � ����� 0 filesave fileSave � m   � � � � � � �  . t a r . g z . g p g � o      ���� 0 filesave fileSave��  ��  ��  ��   �  � � � l     �� � ���   �  display dialog fileSave    � � � � . d i s p l a y   d i a l o g   f i l e S a v e �  � � � l     ��������  ��  ��   �  � � � l  � � ����� � r   � � � � � n   � � � � � 1   � ���
�� 
strq � n   � � � � � 1   � ���
�� 
psxp � o   � ����� 0 filesave fileSave � o      ���� 0 opp  ��  ��   �  � � � l     �� � ���   �  display dialog opp    � � � � $ d i s p l a y   d i a l o g   o p p �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � > 8 testing if file already exists, macos does that already    � � � � p   t e s t i n g   i f   f i l e   a l r e a d y   e x i s t s ,   m a c o s   d o e s   t h a t   a l r e a d y �  � � � l     � � ��   � $ set testFileExists to fileSave    � � � � < s e t   t e s t F i l e E x i s t s   t o   f i l e S a v e �  � � � l     �~ � ��~   �  tell application "Finder"    � � � � 2 t e l l   a p p l i c a t i o n   " F i n d e r " �  � � � l     �} � ��}   � ) #	if exists file testFileExists then    � � � � F 	 i f   e x i s t s   f i l e   t e s t F i l e E x i s t s   t h e n �  � � � l     �| � ��|   � r l		set question to display dialog "file already exists, overwrite it?" buttons {"Yes", "No"} default button 2    � � � � � 	 	 s e t   q u e s t i o n   t o   d i s p l a y   d i a l o g   " f i l e   a l r e a d y   e x i s t s ,   o v e r w r i t e   i t ? "   b u t t o n s   { " Y e s " ,   " N o " }   d e f a u l t   b u t t o n   2 �  � � � l     �{ � ��{   � 1 +		set answer to button returned of question    � � � � V 	 	 s e t   a n s w e r   t o   b u t t o n   r e t u r n e d   o f   q u e s t i o n �  � � � l     �z � ��z   � ! 		if (answer is "Yes") then    � � � � 6 	 	 i f   ( a n s w e r   i s   " Y e s " )   t h e n �  � � � l     �y � ��y   � Z T			do shell script "cd \"$(dirname " & opp & ")\" && rm \"$(basename " & opp & ")\""    � � � � � 	 	 	 d o   s h e l l   s c r i p t   " c d   \ " $ ( d i r n a m e   "   &   o p p   &   " ) \ "   & &   r m   \ " $ ( b a s e n a m e   "   &   o p p   &   " ) \ " " �  � � � l     �x � ��x   �  return true    � � � �  r e t u r n   t r u e �    l     �w�w    		else    �  	 	 e l s e  l     �v�v    			return false    �		  	 	 	 r e t u r n   f a l s e 

 l     �u�u    		end if    �  	 	 e n d   i f  l     �t�t    	else    � 
 	 e l s e  l     �s�s    return false    �  r e t u r n   f a l s e  l     �r�r    	end if    �  	 e n d   i f  l     �q !�q     end tell   ! �""  e n d   t e l l #$# l     �p�o�n�p  �o  �n  $ %&% l     �m'(�m  ' E ? using which to detect the install path of the homebrew command   ( �)) ~   u s i n g   w h i c h   t o   d e t e c t   t h e   i n s t a l l   p a t h   o f   t h e   h o m e b r e w   c o m m a n d& *+* l  � �,�l�k, r   � �-.- I  � ��j/�i
�j .sysoexecTEXT���     TEXT/ b   � �010 b   � �232 b   � �454 b   � �676 m   � �88 �99� i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u - t a r )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p i g z )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   g n u - t a r ,   p i g z ,   p v ,   c o r e u t i l s   a n d   g n u p g   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e   e c h o   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   g d u ' )   - s c b   " $ ( d i r n a m e  7 o   � ��h�h 0 ipp  5 m   � �:: �;;  ) " / " $ ( b a s e n a m e  3 o   � ��g�g 0 ipp  1 m   � �<< �== � ) " /   |   t a i l   - 1   |   a w k   ' { p r i n t   $ 1 } '   |   w h i l e   r e a d   i   ;   d o   e c h o   $ ( e c h o   $ i * 1 . 0   |   b c   |   c u t   - d ' . '   - f 1     )   ;   d o n e ) ;   f i�i  . o      �f�f 
0 pvsize  �l  �k  + >?> l     �e�d�c�e  �d  �c  ? @A@ l  �qB�b�aB Z   �qCD�`EC =  � �FGF n   � �HIH 1   � ��_
�_ 
prunI m   � �JJ�                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  G m   � ��^
�^ boovtrueD O   �ZKLK k   �YMM NON I  � ��]�\�[
�] .miscactvnull��� ��� null�\  �[  O PQP I  ��ZR�Y
�Z .sysodelanull��� ��� nmbrR m   �SS ?�      �Y  Q TUT Z  QVW�XXV = YZY l [�W�V[ I �U\�T
�U .corecnte****       ****\ 2 �S
�S 
cwin�T  �W  �V  Z m  �R�R  W k  /]] ^_^ O '`a` I &�Qbc
�Q .prcskprsnull���     ctxtb m  dd �ee  nc �Pf�O
�P 
faalf m  "�N
�N eMdsKcmd�O  a m  gg�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  _ h�Mh I (/�Li�K
�L .sysodelanull��� ��� nmbri m  (+jj ?��������K  �M  �X  X k  2Qkk lml O 2Inon I 6H�Jpq
�J .prcskprsnull���     ctxtp m  69rr �ss  nq �It�H
�I 
faalt J  <Duu vwv m  <?�G
�G eMdsKoptw x�Fx m  ?B�E
�E eMdsKcmd�F  �H  o m  23yy�                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  m z�Dz I JQ�C{�B
�C .sysodelanull��� ��� nmbr{ m  JM|| ?��������B  �D  U }�A} I RY�@~�?
�@ .sysodelanull��� ��� nmbr~ m  RU ?�      �?  �A  L m   � ����                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �`  E O  ]q��� k  cp�� ��� I ch�>�=�<
�> .miscactvnull��� ��� null�=  �<  � ��;� I ip�:��9
�: .sysodelanull��� ��� nmbr� m  il�� ?�      �9  �;  � m  ]`���                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �b  �a  A ��� l     �8�7�6�8  �7  �6  � ��� l r���5�4� O  r���� k  x��� ��� I x}�3�2�1
�3 .miscactvnull��� ��� null�2  �1  � ��� l ~~�0���0  � J Dtell application "System Events" to keystroke "t" using command down   � ��� � t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   k e y s t r o k e   " t "   u s i n g   c o m m a n d   d o w n� ��� l ~~�/���/  � L Frepeat while contents of selected tab of window 1 starts with linefeed   � ��� � r e p e a t   w h i l e   c o n t e n t s   o f   s e l e c t e d   t a b   o f   w i n d o w   1   s t a r t s   w i t h   l i n e f e e d� ��� l ~~�.���.  �  
	delay 1.5   � ���  	 d e l a y   1 . 5� ��� l ~~�-���-  �  
end repeat   � ���  e n d   r e p e a t� ��� l ~~�,�+�*�,  �+  �*  � ��� I ~��)��(
�) .sysodelanull��� ��� nmbr� m  ~��� ?�      �(  � ��� l ���'�&�%�'  �&  �%  � ��� l ���$���$  � #  using gui input for password   � ��� :   u s i n g   g u i   i n p u t   f o r   p a s s w o r d� ��� l ���#���#  ���do script "printf '\\ec' && echo '' && echo -e '\\033[1mstarting encryption...\\033[0m'; if [[ $($($SHELL -l -c 'which brew') list | grep gnu-tar) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep pigz) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep pv) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep coreutils) == '' ]] || [[ $($($SHELL -l -c 'which brew') list | grep gnupg) == '' ]]; then echo at least one homebrew tool of gnu-tar, pigz, pv and coreutils is missing, exiting... && exit; else echo ''; echo archiving \"$(dirname " & ipp & ")\"/\"$(basename " & ipp & ")\"/;printf '%-10s' 'to' \"$(echo " & opp & ")\" && echo; pushd \"$(dirname " & ipp & ")\" 1> /dev/null; $($SHELL -l -c 'which gtar') -cpf - \"$(basename " & ipp & ")\" | $($SHELL -l -c 'which pv') -s " & pvsize & " | $($SHELL -l -c 'which pigz') --best | $($SHELL -l -c 'which gpg') --batch --yes --quiet --symmetric --s2k-cipher-algo AES256 --s2k-digest-algo SHA512 --s2k-count 65536 --compress-algo 0 -o \"$(echo " & opp & ")\"; popd 1> /dev/null && echo '' && echo 'testing integrity of file(s)' && echo '' && echo -n \"$(basename " & opp & ")\"'... ' && $($SHELL -l -c 'which gpg') --quiet -d \"$(echo " & opp & ")\" | $($SHELL -l -c 'which unpigz') | $($SHELL -l -c 'which gtar') -tvv >/dev/null 2>&1 && echo -e 'file is \\033[1;32mOK\\033[0m' || echo -e 'file is \\033[1;31mINVALID\\033[0m'; echo ''; echo 'done ;)'; echo ''; fi" in selected tab of front window   � ���z d o   s c r i p t   " p r i n t f   ' \ \ e c '   & &   e c h o   ' '   & &   e c h o   - e   ' \ \ 0 3 3 [ 1 m s t a r t i n g   e n c r y p t i o n . . . \ \ 0 3 3 [ 0 m ' ;   i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u - t a r )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p i g z )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   g n u - t a r ,   p i g z ,   p v   a n d   c o r e u t i l s   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e   e c h o   ' ' ;   e c h o   a r c h i v i n g   \ " $ ( d i r n a m e   "   &   i p p   &   " ) \ " / \ " $ ( b a s e n a m e   "   &   i p p   &   " ) \ " / ; p r i n t f   ' % - 1 0 s '   ' t o '   \ " $ ( e c h o   "   &   o p p   &   " ) \ "   & &   e c h o ;   p u s h d   \ " $ ( d i r n a m e   "   &   i p p   &   " ) \ "   1 >   / d e v / n u l l ;   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - c p f   -   \ " $ ( b a s e n a m e   "   &   i p p   &   " ) \ "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p v ' )   - s   "   &   p v s i z e   &   "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p i g z ' )   - - b e s t   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - b a t c h   - - y e s   - - q u i e t   - - s y m m e t r i c   - - s 2 k - c i p h e r - a l g o   A E S 2 5 6   - - s 2 k - d i g e s t - a l g o   S H A 5 1 2   - - s 2 k - c o u n t   6 5 5 3 6   - - c o m p r e s s - a l g o   0   - o   \ " $ ( e c h o   "   &   o p p   &   " ) \ " ;   p o p d   1 >   / d e v / n u l l   & &   e c h o   ' '   & &   e c h o   ' t e s t i n g   i n t e g r i t y   o f   f i l e ( s ) '   & &   e c h o   ' '   & &   e c h o   - n   \ " $ ( b a s e n a m e   "   &   o p p   &   " ) \ " ' . . .   '   & &   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - q u i e t   - d   \ " $ ( e c h o   "   &   o p p   &   " ) \ "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   u n p i g z ' )   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - t v v   > / d e v / n u l l   2 > & 1   & &   e c h o   - e   ' f i l e   i s   \ \ 0 3 3 [ 1 ; 3 2 m O K \ \ 0 3 3 [ 0 m '   | |   e c h o   - e   ' f i l e   i s   \ \ 0 3 3 [ 1 ; 3 1 m I N V A L I D \ \ 0 3 3 [ 0 m ' ;   e c h o   ' ' ;   e c h o   ' d o n e   ; ) ' ;   e c h o   ' ' ;   f i "   i n   s e l e c t e d   t a b   o f   f r o n t   w i n d o w� ��� l ���"���"  � !  using own password upfornt   � ��� 6   u s i n g   o w n   p a s s w o r d   u p f o r n t� ��� I ���!��
�! .coredoscnull��� ��� ctxt� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� m  ���� ���D p r i n t f   ' \ e c '   & &   e c h o   ' '   & &   e c h o   - e   ' \ 0 3 3 [ 1 m s t a r t i n g   e n c r y p t i o n . . . \ 0 3 3 [ 0 m ' ;   i f   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u - t a r )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p i g z )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   p v )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   c o r e u t i l s )   = =   ' '   ] ]   | |   [ [   $ ( $ ( $ S H E L L   - l   - c   ' w h i c h   b r e w ' )   l i s t   |   g r e p   g n u p g )   = =   ' '   ] ] ;   t h e n   e c h o   a t   l e a s t   o n e   h o m e b r e w   t o o l   o f   g n u - t a r ,   p i g z ,   p v   a n d   c o r e u t i l s   i s   m i s s i n g ,   e x i t i n g . . .   & &   e x i t ;   e l s e     e c h o   ' '   & &   e c h o   ' p l e a s e   s e t   e n c r y p t i o n   p a s s w o r d . . . '   & &   G P G _ P A S S W O R D = '         '   & &   w h i l e   [ [   $ G P G _ P A S S W O R D   ! =   $ G P G _ P A S S W O R D 2   ] ]   | |   [ [   $ G P G _ P A S S W O R D   = =   ' '   ] ] ;   d o   s t t y   - e c h o   & &   t r a p   ' s t t y   e c h o '   E X I T   & &   p r i n t f   ' g p g   p a s s w o r d :   '   & &   r e a d   - r   $ @   G P G _ P A S S W O R D   & &   p r i n t f   '   '   & &   e c h o   ' '   & &   p r i n t f   ' r e - e n t e r   g p g   p a s s w o r d :   '   & &   r e a d   - r   $ @   G P G _ P A S S W O R D 2   & &   s t t y   e c h o   & &   t r a p   -   E X I T   & &   e c h o   ' ' ;   d o n e   & &   e c h o   ' ' ;   e c h o   a r c h i v i n g   " $ ( d i r n a m e  � o  ��� �  0 ipp  � m  ���� ���  ) " / " $ ( b a s e n a m e  � o  ���� 0 ipp  � m  ���� ��� @ ) " / ; p r i n t f   ' % - 1 0 s '   ' t o '   " $ ( e c h o  � o  ���� 0 opp  � m  ���� ��� @ ) "   & &   e c h o   ' ' ;   p u s h d   " $ ( d i r n a m e  � o  ���� 0 ipp  � m  ���� ��� � ) "   1 >   / d e v / n u l l ;   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - c p f   -   " $ ( b a s e n a m e  � o  ���� 0 ipp  � m  ���� ��� F ) "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p v ' )   - s  � o  ���� 
0 pvsize  � m  ���� ����   |   $ ( $ S H E L L   - l   - c   ' w h i c h   p i g z ' )   - - b e s t   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - b a t c h   - - y e s   - - q u i e t   - - s y m m e t r i c   - - p a s s p h r a s e = $ G P G _ P A S S W O R D   - - s 2 k - c i p h e r - a l g o   A E S 2 5 6   - - s 2 k - d i g e s t - a l g o   S H A 5 1 2   - - s 2 k - c o u n t   6 5 5 3 6   - - c o m p r e s s - a l g o   0   - o   " $ ( e c h o  � o  ���� 0 opp  � m  ���� ��� � ) " ;   p o p d   1 >   / d e v / n u l l   & &   e c h o   ' '   & &   e c h o   ' t e s t i n g   i n t e g r i t y   o f   f i l e ( s ) '   & &   e c h o   ' '   & &   e c h o   - n   " $ ( b a s e n a m e  � o  ���� 0 opp  � m  ���� ��� ) " ' . . .   '   & &   b u i l t i n   e c h o   $ G P G _ P A S S W O R D   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g p g ' )   - - q u i e t   - - b a t c h   - - n o - t t y   - - y e s   - - p a s s p h r a s e - f d   0   - d   " $ ( e c h o  � o  ���� 0 opp  � m  ���� ���� ) "   |   $ ( $ S H E L L   - l   - c   ' w h i c h   u n p i g z ' )   |   $ ( $ S H E L L   - l   - c   ' w h i c h   g t a r ' )   - t v v   > / d e v / n u l l   2 > & 1   & &   e c h o   - e   ' f i l e   i s   \ 0 3 3 [ 1 ; 3 2 m O K \ 0 3 3 [ 0 m '   | |   e c h o   - e   ' f i l e   i s   \ 0 3 3 [ 1 ; 3 1 m I N V A L I D \ 0 3 3 [ 0 m ' ;   e c h o   ' ' ;   e c h o   ' d o n e   ; ) ' ;   e c h o   ' ' ;   f i� ���
� 
kfil� n  ����� 1  ���
� 
tcnt� 4 ����
� 
cwin� m  ���� �  � ��� l ������  �  �  �  � m  ru  �                                                                                      @ alis    <  macintosh_hd                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c i n t o s h _ h d  #Applications/Utilities/Terminal.app   / ��  �5  �4  �  l     ����  �  �    l     ��
�	�  �
  �	    l     ����  �  �    l     �	
�  	 !  \" keeping spaces alive \"   
 � 6   \ "   k e e p i n g   s p a c e s   a l i v e   \ "  l     ����  �  �   � l     � �����   ��  ��  �       ����   ��
�� .aevtoappnull  �   � **** ��������
�� .aevtoappnull  �   � **** k    �         *  3  C  M  a  u  �  �  �    �!! *"" @## �����  ��  ��     G������ ������������ )������������������ X Z���� l n���������� ����������� � ���8:<��J��S������d������jr�������������������
�� misccura
�� .miscactvnull��� ��� null
�� 
prmp
�� 
dflc
�� afdrdesk
�� .earsffdralis        afdr�� 
�� .sysostdfalis    ��� null�� 0 inputfolder inputFolder
�� 
posx�� $0 posixinputfolder posixinputFolder
�� 
strq�� 0 ipp  
�� 
cobj�� 0 unobjet unObjet
�� 
ctxt
�� 
pcls�� 0 thetype theType
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
�� .coredoscnull��� ��� ctxt���� *j UO*����j � E�O� ��,E�UO��,E�O� *�_ a &/a ,EE` UO_ Oa �%a %j E` Oa �%a %j E` O*a _ /a &E` O*a a a  _ �_ a ! "E` #O_ #a $,E` #O_ #a % _ #a &%E` #Y hO_ #a $,�,E` 'Oa (�%a )%�%a *%j E` +Oa ,a -,e  la , b*j Oa .j /O*a 0-j 1j  � a 2a 3a 4l 5UOa 6j /Y !� a 7a 3a 8a 4lvl 5UOa 6j /Oa .j /UY a , *j Oa .j /UOa , f*j Oa 9j /Oa :�%a ;%�%a <%_ '%a =%�%a >%�%a ?%_ +%a @%_ '%a A%_ '%a B%_ '%a C%a D*a 0k/a E,l FOPU ascr  ��ޭ