FasdUAS 1.101.10   ��   ��    k             l     ��  ��     tell application "Finder"     � 	 	 2 t e l l   a p p l i c a t i o n   " F i n d e r "   
  
 l     ��  ��    L F	set ScriptDir to (POSIX path of (container of (path to me) as alias))     �   � 	 s e t   S c r i p t D i r   t o   ( P O S I X   p a t h   o f   ( c o n t a i n e r   o f   ( p a t h   t o   m e )   a s   a l i a s ) )      l     ��  ��     end tell     �    e n d   t e l l      l     ����  r         n         1   	 ��
�� 
psxp  l    	 ����  b     	    l     ����  I    ��   
�� .earsffdralis        afdr   f        �� !��
�� 
rtyp ! m    ��
�� 
ctxt��  ��  ��    m     " " � # #  : :��  ��    o      ���� 0 	scriptdir 	ScriptDir��  ��     $ % $ l     ��������  ��  ��   %  & ' & l     �� ( )��   ( H B checking if one entry is already selected, e.g. by another script    ) � * * �   c h e c k i n g   i f   o n e   e n t r y   i s   a l r e a d y   s e l e c t e d ,   e . g .   b y   a n o t h e r   s c r i p t '  + , + l    -���� - r     . / . I   �� 0��
�� .sysoexecTEXT���     TEXT 0 m     1 1 � 2 2 . e c h o   $ G U I _ A P P _ T O _ B A C K U P��   / o      ���� 0 appname appName��  ��   ,  3 4 3 l    5���� 5 r     6 7 6 J     8 8  9 : 9 m     ; ; � < <  C a l e n d a r :  = > = m     ? ? � @ @  C o n t a c t s >  A�� A m     B B � C C  R e m i n d e r s��   7 o      ���� 0 
appoptions 
appOptions��  ��   4  D E D l   3 F���� F Z    3 G H�� I G =   ! J K J o    ���� 0 appname appName K m      L L � M M   H r   $ / N O N c   $ - P Q P J   $ + R R  S�� S I  $ )�� T��
�� .gtqpchltns    @   @ ns   T o   $ %���� 0 
appoptions 
appOptions��  ��   Q m   + ,��
�� 
ctxt O o      ���� 0 appname appName��   I l  2 2�� U V��   U 0 *do something else, in this case nothing ;)    V � W W T d o   s o m e t h i n g   e l s e ,   i n   t h i s   c a s e   n o t h i n g   ; )��  ��   E  X Y X l  4 C Z���� Z r   4 C [ \ [ I  4 ?�� ]��
�� .sysoexecTEXT���     TEXT ] b   4 ; ^ _ ^ b   4 7 ` a ` m   4 5 b b � c c 
 e c h o   a o   5 6���� 0 appname appName _ m   7 : d d � e e 8 |   t r   ' [ : u p p e r : ] '   ' [ : l o w e r : ] '��   \ o      ����  0 appnamelowered appNameLowered��  ��   Y  f g f l     ��������  ��  ��   g  h i h l     �� j k��   j W Q checking if GUI_APP_TO_BACKUP is written correctly if passed from another script    k � l l �   c h e c k i n g   i f   G U I _ A P P _ T O _ B A C K U P   i s   w r i t t e n   c o r r e c t l y   i f   p a s s e d   f r o m   a n o t h e r   s c r i p t i  m n m l  D X o���� o Z   D X p q�� r p E   D G s t s o   D E���� 0 
appoptions 
appOptions t o   E F���� 0 appname appName q l  J J�� u v��   u 8 2- do nothing, in this case continue running script    v � w w d -   d o   n o t h i n g ,   i n   t h i s   c a s e   c o n t i n u e   r u n n i n g   s c r i p t��   r k   N X x x  y z y I  N U�� {��
�� .sysodlogaskr        TEXT { m   N Q | | � } } V E r r o r :   T h e   a p p N a m e   i s   n o t   v a l i d ,   e x i t i n g . . .��   z  ~�� ~ L   V X����  ��  ��  ��   n   �  l     ��������  ��  ��   �  � � � l     �� � ���   � . ( creating and / or cleaning of directory    � � � � P   c r e a t i n g   a n d   /   o r   c l e a n i n g   o f   d i r e c t o r y �  � � � l     �� � ���   � E ? saving to /Users/$USER/documents/backup/GUI_APP_TO_BACKUP/DATE    � � � � ~   s a v i n g   t o   / U s e r s / $ U S E R / d o c u m e n t s / b a c k u p / G U I _ A P P _ T O _ B A C K U P / D A T E �  � � � l  Y d ����� � r   Y d � � � I  Y `�� ���
�� .sysoexecTEXT���     TEXT � m   Y \ � � � � �   d a t e   " + % Y - % m - % d "��   � o      ���� 0 	timestamp 	timeStamp��  ��   �  � � � l  e � ����� � r   e � � � � b   e � � � � b   e | � � � b   e x � � � b   e t � � � l  e p ����� � l  e p ����� � I  e p�� � �
�� .earsffdralis        afdr � l  e h ����� � m   e h��
�� afdrdocs��  ��   � �� ���
�� 
rtyp � m   i l��
�� 
TEXT��  ��  ��  ��  ��   � m   p s � � � � �  b a c k u p : � o   t w����  0 appnamelowered appNameLowered � m   x { � � � � �  : � o   | ���� 0 	timestamp 	timeStamp � o      ���� 0 backup_folder  ��  ��   �  � � � l  � � ����� � r   � � � � � l  � � ����� � l  � � ����� � n   � � � � � 1   � ���
�� 
psxp � o   � ����� 0 backup_folder  ��  ��  ��  ��   � o      ���� &0 mybackuppathposix myBackupPathPosix��  ��   �  � � � l  � � ����� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � m   � � � � � � �  m k d i r   - p   � n   � � � � � 1   � ���
�� 
strq � o   � ����� &0 mybackuppathposix myBackupPathPosix��  ��  ��   �  � � � l  � � ����� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � m   � � � � � � �  r m   - r f   � n   � � � � � 1   � ���
�� 
strq � o   � ����� &0 mybackuppathposix myBackupPathPosix � m   � � � � � � �  / *��  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � &   quitting app if already running    � � � � @   q u i t t i n g   a p p   i f   a l r e a d y   r u n n i n g �  � � � l  � � ����� � Q   � � � ��� � O   � � � � � I  � �������
�� .aevtquitnull��� ��� null��  ��   � 4   � ��� �
�� 
capp � o   � ����� 0 appname appName � R      ������
�� .ascrerr ****      � ****��  ��  ��  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l  � � ����� � I  � ��� ��
�� .sysodelanull��� ��� nmbr � m   � ��~�~ �  ��  ��   �  � � � l     �}�|�{�}  �|  �{   �  � � � l     �z � ��z   �   opening app cleanly    � � � � (   o p e n i n g   a p p   c l e a n l y �  � � � l  � ��y�x � O   � � � � k   � � �  � � � I  � ��w�v�u
�w .ascrnoop****      � ****�v  �u   �  � � � I  � ��t ��s
�t .sysodelanull��� ��� nmbr � m   � ��r�r �s   �  � � � I  � ��q�p�o
�q .miscactvnull��� ��� null�p  �o   �  � � � I  � ��n ��m
�n .sysodelanull��� ��� nmbr � m   � ��l�l �m   �  � � � l  � ��k � ��k   � o i when trying is was not enough to use select to get contacts app to export all vcards in the selected row    � � � � �   w h e n   t r y i n g   i s   w a s   n o t   e n o u g h   t o   u s e   s e l e c t   t o   g e t   c o n t a c t s   a p p   t o   e x p o r t   a l l   v c a r d s   i n   t h e   s e l e c t e d   r o w �  � � � l  � ��j � ��j   � d ^ the app has to be "activated" and clicked so that the selection appears in color, not in grey    � �   �   t h e   a p p   h a s   t o   b e   " a c t i v a t e d "   a n d   c l i c k e d   s o   t h a t   t h e   s e l e c t i o n   a p p e a r s   i n   c o l o r ,   n o t   i n   g r e y � �i Z   ��h�g =  � � o   � ��f�f 0 appname appName m   � � �  C o n t a c t s O   �	 O  

 k    l �e�e   6 0 getting x and y coordintates of contacts window    � `   g e t t i n g   x   a n d   y   c o o r d i n t a t e s   o f   c o n t a c t s   w i n d o w �d O   k    r  $ 1   �c
�c 
posn o      �b�b 0 p    r  %1 l %-�a�` n  %-  4  (-�_!
�_ 
cobj! m  +,�^�^   o  %(�]�] 0 p  �a  �`   o      �\�\ 0 xcoordinate xCoordinate "#" r  2>$%$ l 2:&�[�Z& n  2:'(' 4  5:�Y)
�Y 
cobj) m  89�X�X ( o  25�W�W 0 p  �[  �Z  % o      �V�V 0 ycoordinate yCoordinate# *+* r  ?J,-, [  ?F./. o  ?B�U�U 0 xcoordinate xCoordinate/ m  BE�T�T - o      �S�S 0 xclick xClick+ 010 r  KV232 [  KR454 o  KN�R�R 0 ycoordinate yCoordinate5 m  NQ�Q�Q <3 o      �P�P 0 yclick yClick1 676 l WW�O89�O  8 * $return {p, xCoordinate, yCoordinate}   9 �:: H r e t u r n   { p ,   x C o o r d i n a t e ,   y C o o r d i n a t e }7 ;<; l WW�N=>�N  = � | checking if mouseclick binary is installed, if not checking if cliclick is installed, if not stop script with error message   > �?? �   c h e c k i n g   i f   m o u s e c l i c k   b i n a r y   i s   i n s t a l l e d ,   i f   n o t   c h e c k i n g   i f   c l i c l i c k   i s   i n s t a l l e d ,   i f   n o t   s t o p   s c r i p t   w i t h   e r r o r   m e s s a g e< @A@ r  WhBCB I Wd�MD�L
�M .sysoexecTEXT���     TEXTD b  W`EFE b  W\GHG m  WZII �JJ 
 e c h o  H o  Z[�K�K 0 	scriptdir 	ScriptDirF m  \_KK �LL  m o u s e c l i c k�L  C o      �J�J $0 mouseclickbinary mouseClickBinaryA MNM r  ipOPO m  ilQQ �RR  P o      �I�I 00 mouseclickbinaryexists mouseClickBinaryExistsN STS Q  q�UVWU k  t�XX YZY c  t�[\[ 4  t|�H]
�H 
psxf] o  x{�G�G $0 mouseclickbinary mouseClickBinary\ m  |�F
�F 
alisZ ^�E^ r  ��_`_ m  ��aa �bb  t r u e` o      �D�D 00 mouseclickbinaryexists mouseClickBinaryExists�E  V R      �C�B�A
�C .ascrerr ****      � ****�B  �A  W r  ��cdc m  ��ee �ff 
 f a l s ed o      �@�@ 00 mouseclickbinaryexists mouseClickBinaryExistsT ghg Z  �ij�?ki = ��lml o  ���>�> 00 mouseclickbinaryexists mouseClickBinaryExistsm m  ��nn �oo  t r u ej k  ��pp qrq I ���=s�<
�= .sysoexecTEXT���     TEXTs b  ��tut b  ��vwv m  ��xx �yy  c h m o d   7 7 0  w o  ���;�; 0 	scriptdir 	ScriptDiru m  ��zz �{{  m o u s e c l i c k�<  r |�:| I ���9}�8
�9 .sysoexecTEXT���     TEXT} b  ��~~ b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� m  ���� ���  � o  ���7�7 0 	scriptdir 	ScriptDir� m  ���� ���  m o u s e c l i c k� m  ���� ���    - x  � o  ���6�6 0 xclick xClick� m  ���� ���    - y  � o  ���5�5 0 yclick yClick m  ���� ���  �8  �:  �?  k k  ��� ��� r  ����� I ���4��3
�4 .sysoexecTEXT���     TEXT� m  ���� ��� J e c h o   $ ( $ S H E L L   - l   - c   ' w h i c h   c l i c l i c k ' )�3  � o      �2�2 40 checkifinstalledcliclick checkIfInstalledCliclick� ��1� Z  ����0�� = ����� o  ���/�/ 40 checkifinstalledcliclick checkIfInstalledCliclick� m  ���� ���  � k  ���� ��� I ���.��-
�. .sysodlogaskr        TEXT� m  ���� ���\ E r r o r :   n e i t h e r   a   m o u s e c l i c k   b i n a r y   n o r   c l i c l i c k   i s   i n s t a l l e d . . . 
 P l e a s e   c o m p i l e   m o u s e c l i c k   b i n a r y   f r o m   t h e   s c r i p t   i n   t h e   g u i _ a p p s   d i r e c t o r y   o r   i n s t a l l   c l i c l i c k   v i a   h o m e b r e w . . .�-  � ��,� L  ���+�+  �,  �0  � k  ��� ��� l ���*���*  � [ Udo shell script "$($SHELL -l -c 'which cliclick') -r c:" & xClick & "," & yClick & ""   � ��� � d o   s h e l l   s c r i p t   " $ ( $ S H E L L   - l   - c   ' w h i c h   c l i c l i c k ' )   - r   c : "   &   x C l i c k   &   " , "   &   y C l i c k   &   " "� ��)� I ��(��'
�( .sysoexecTEXT���     TEXT� b  �
��� b  ���� b  ���� b  ����� m  ���� ��� F $ ( $ S H E L L   - l   - c   ' w h i c h   c l i c l i c k ' )   c :� o  ���&�& 0 xclick xClick� m  ��� ���  ,� o  �%�% 0 yclick yClick� m  	�� ���  �'  �)  �1  h ��$� I �#��"
�# .sysodelanull��� ��� nmbr� m  �!�! �"  �$   n  ��� 4  � �
�  
uiel� m  �� � 4  ��
� 
cwin� m  �� �d   4  
��
� 
prcs� o  	�� 0 appname appName	 m   ����                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  �h  �g  �i   � 4   � ���
� 
capp� o   � ��� 0 appname appName�y  �x   � ��� l     ����  �  �  � ��� l ���� O  ��� O  #��� k  ,�� ��� l ,,����  �  �  � ��� l ,,����  � . ( setting sidebar as outline for each app   � ��� P   s e t t i n g   s i d e b a r   a s   o u t l i n e   f o r   e a c h   a p p� ��� Z  ,V����� = ,1��� o  ,-�� 0 appname appName� m  -0�� ���  C a l e n d a r� r  4R��� n  4N��� 4  IN��
� 
outl� m  LM�� � n  4I��� 4  DI�
�
�
 
scra� m  GH�	�	 � n  4D��� 4  ?D��
� 
splg� m  BC�� � n  4?��� 4  :?��
� 
splg� m  =>�� � 4  4:��
� 
cwin� m  89�� � o      �� 0 
appoutline 
appOutline�  �  � ��� Z  W����� � = W\��� o  WX���� 0 appname appName� m  X[�� ���  C o n t a c t s� k  _��� ��� l __��� ��  �  	 sidebar      �    s i d e b a r  �  r  _x n  _t 4  ot��
�� 
outl m  rs����  n  _o	
	 4  jo��
�� 
scra m  mn���� 
 n  _j 4  ej��
�� 
splg m  hi����  4  _e��
�� 
cwin m  cd����  o      ���� 0 
appoutline 
appOutline  l yy����     contacts list    �    c o n t a c t s   l i s t �� r  y� n  y� 4  ����
�� 
outl m  ������  n  y� 4  ����
�� 
scra m  ������  n  y� 4  ��� 
�� 
splg  m  ������  4  y��!
�� 
cwin! m  }~����  o      ���� 0 appoutline2 appOutline2��  �  �   � "#" Z  ��$%����$ = ��&'& o  ������ 0 appname appName' m  ��(( �))  R e m i n d e r s% r  ��*+* n  ��,-, 4  ����.
�� 
tabB. m  ������ - n  ��/0/ 4  ����1
�� 
scra1 m  ������ 0 n  ��232 4  ����4
�� 
splg4 m  ������ 3 4  ����5
�� 
cwin5 m  ������ + o      ���� 0 
appoutline 
appOutline��  ��  # 676 l ����������  ��  ��  7 898 l ����:;��  : - ' counting number of rows in the outline   ; �<< N   c o u n t i n g   n u m b e r   o f   r o w s   i n   t h e   o u t l i n e9 =>= r  ��?@? n  ��ABA 2 ����
�� 
crowB o  ������ 0 
appoutline 
appOutline@ o      ����  0 alloutlinerows allOutlineRows> CDC r  ��EFE I ����G��
�� .corecnte****       ****G o  ������  0 alloutlinerows allOutlineRows��  F o      ���� *0 numberofoutlinerows numberOfOutlineRowsD HIH l ����JK��  J ! display dialog numberOfRows   K �LL 6 d i s p l a y   d i a l o g   n u m b e r O f R o w sI MNM l ����������  ��  ��  N OPO l ����QR��  Q   resetting loops   R �SS     r e s e t t i n g   l o o p sP TUT r  ��VWV m  ������  W o      ���� 0 	countloop 	countLoopU XYX r  ��Z[Z m  ������  [ o      ���� 0 savecountloop SaveCountLoopY \]\ l ����������  ��  ��  ] ^_^ l ����`a��  ` - ' repeat process for each row in outline   a �bb N   r e p e a t   p r o c e s s   f o r   e a c h   r o w   i n   o u t l i n e_ cdc W  �kefe k  �fgg hih r  ��jkj [  ��lml o  ������ 0 	countloop 	countLoopm m  ������ k o      ���� 0 	countloop 	countLoopi non I ���p��
�� .miscslctnull���     uielp n  �qrq 4  ���s
�� 
crows o  � ���� 0 	countloop 	countLoopr o  ������ 0 
appoutline 
appOutline��  o tut l ��������  ��  ��  u vwv l ��xy��  x U O checking if row is selectable or non-selectable text, only go on if selectable   y �zz �   c h e c k i n g   i f   r o w   i s   s e l e c t a b l e   o r   n o n - s e l e c t a b l e   t e x t ,   o n l y   g o   o n   i f   s e l e c t a b l ew {��{ Z  f|}��~| n  � 1  ��
�� 
selE� n  ��� 4  	���
�� 
crow� o  ���� 0 	countloop 	countLoop� o  	���� 0 
appoutline 
appOutline} k  b�� ��� r  (��� m  ��
�� boovtrue� n      ��� 1  #'��
�� 
selE� n  #��� 4  #���
�� 
crow� o  "���� 0 	countloop 	countLoop� o  ���� 0 
appoutline 
appOutline� ��� I ).�����
�� .sysodelanull��� ��� nmbr� m  )*���� ��  � ��� l //��������  ��  ��  � ��� l //������  � � ~ backup every selectable row except for contacts - as vcards not groups are exported empty selections would result in an error   � ��� �   b a c k u p   e v e r y   s e l e c t a b l e   r o w   e x c e p t   f o r   c o n t a c t s   -   a s   v c a r d s   n o t   g r o u p s   a r e   e x p o r t e d   e m p t y   s e l e c t i o n s   w o u l d   r e s u l t   i n   a n   e r r o r� ��� r  /6��� m  /2�� ���  y e s� o      ���� 0 backupthisrow backupThisRow� ��� Z  7�������� = 7<��� o  78���� 0 appname appName� m  8;�� ���  C o n t a c t s� k  ?|�� ��� r  ?\��� n  ?X��� 2 TX��
�� 
crow� n  ?T��� 4  OT���
�� 
outl� m  RS���� � n  ?O��� 4  JO���
�� 
scra� m  MN���� � n  ?J��� 4  EJ���
�� 
splg� m  HI���� � 4  ?E���
�� 
cwin� m  CD���� � o      ���� "0 alloutline2rows allOutline2Rows� ��� r  ]h��� I ]d�����
�� .corecnte****       ****� o  ]`���� "0 alloutline2rows allOutline2Rows��  � o      ���� ,0 numberofoutline2rows numberOfOutline2Rows� ���� Z  i|������� A in��� o  il���� ,0 numberofoutline2rows numberOfOutline2Rows� m  lm���� � r  qx��� m  qt�� ���  n o� o      ���� 0 backupthisrow backupThisRow��  ��  ��  ��  ��  � ��� l ����������  ��  ��  � ���� Z  �b������ = ����� o  ������ 0 backupthisrow backupThisRow� m  ���� ���  y e s� k  �^�� ��� l ����������  ��  ��  � ��� l ��������  � ? 9 getting name of uielement for later usage in save dialog   � ��� r   g e t t i n g   n a m e   o f   u i e l e m e n t   f o r   l a t e r   u s a g e   i n   s a v e   d i a l o g� ��� l ��������  � g aset UiElementName to get value of every UI element of UI element 1 of row countLoop of appOutline   � ��� � s e t   U i E l e m e n t N a m e   t o   g e t   v a l u e   o f   e v e r y   U I   e l e m e n t   o f   U I   e l e m e n t   1   o f   r o w   c o u n t L o o p   o f   a p p O u t l i n e� ��� r  ����� e  ���� n  ����� 1  ����
�� 
valL� n  ����� 4 �����
�� 
uiel� m  ������ � n  ����� 4  �����
�� 
uiel� m  ������ � n  ����� 4  ����
� 
crow� o  ���~�~ 0 	countloop 	countLoop� o  ���}�} 0 
appoutline 
appOutline� o      �|�| 0 uielementname UiElementName� ��� l ���{���{  � � zset UiElementNameNoSpaces to do shell script "echo " & testName & " | tr -s ' ' | tr ' ' '_' | tr '[:upper:]' '[:lower:]'"   � ��� � s e t   U i E l e m e n t N a m e N o S p a c e s   t o   d o   s h e l l   s c r i p t   " e c h o   "   &   t e s t N a m e   &   "   |   t r   - s   '   '   |   t r   '   '   ' _ '   |   t r   ' [ : u p p e r : ] '   ' [ : l o w e r : ] ' "� ��� r  ����� I ���z��y
�z .sysoexecTEXT���     TEXT� b  ����� b  ����� m  ���� ��� 
 e c h o  � o  ���x�x 0 uielementname UiElementName� m  ���� ��� X |   s e d   ' s /   / _ / g '   |   t r   ' [ : u p p e r : ] '   ' [ : l o w e r : ] '�y  � o      �w�w .0 uielementnamenospaces UiElementNameNoSpaces� ��� l ���v �v    * $display dialog UiElementNameNoSpaces    � H d i s p l a y   d i a l o g   U i E l e m e n t N a m e N o S p a c e s�  l ���u�t�s�u  �t  �s    I ���r�q
�r .sysodelanull��� ��� nmbr m  ���p�p �q   	 l ���o�n�m�o  �n  �m  	 

 l ���l�l   8 2 clicking respective menu bar entries for each app    � d   c l i c k i n g   r e s p e c t i v e   m e n u   b a r   e n t r i e s   f o r   e a c h   a p p  Z  ��k�j = �� o  ���i�i 0 appname appName m  �� �  C a l e n d a r k  �  I ���h�g
�h .sysodelanull��� ��� nmbr m  ���f�f �g    Z  ���e = �� !  o  ���d�d 0 uielementname UiElementName! l ��"�c�b" I ���a#�`
�a .sysoexecTEXT���     TEXT# m  ��$$ �%%  e c h o   $ U S E R�`  �c  �b   k  ��&& '(' l ���_)*�_  ) - 'display dialog "this is my calendar ;)"   * �++ N d i s p l a y   d i a l o g   " t h i s   i s   m y   c a l e n d a r   ; ) "( ,�^, r  ��-.- o  ���]�] 0 	countloop 	countLoop. o      �\�\ 0 mycalendarrow myCalendarRow�^  �e   l ���[/0�[  /  - do nothing   0 �11  -   d o   n o t h i n g 2�Z2 I ��Y3�X
�Y .prcsclicnull��� ��� uiel3 n  �454 4  	�W6
�W 
menI6 m  77 �88  E x p o r t i e r e n   &5 n  �	9:9 4  	�V;
�V 
menE; m  �U�U : n  �<=< 4  ��T>
�T 
menI> m   ?? �@@  E x p o r t i e r e n= n  ��ABA 4  ���SC
�S 
menEC m  ���R�R B n  ��DED 4  ���QF
�Q 
mbriF m  ��GG �HH  A b l a g eE 4  ���PI
�P 
mbarI m  ���O�O �X  �Z  �k  �j   JKJ Z  �LM�N�ML = NON o  �L�L 0 appname appNameO m  PP �QQ  C o n t a c t sM k  !�RR STS I !&�KU�J
�K .sysodelanull��� ��� nmbrU m  !"�I�I �J  T VWV l ''�HXY�H  X V P making sure a contact is selected, otherwise the script will stop with an error   Y �ZZ �   m a k i n g   s u r e   a   c o n t a c t   i s   s e l e c t e d ,   o t h e r w i s e   t h e   s c r i p t   w i l l   s t o p   w i t h   a n   e r r o rW [\[ r  '.]^] m  '*__ �``  0^ o      �G�G &0 countloopcontacts countLoopContacts\ aba r  /6cdc m  /2ee �ff 
 f a l s ed o      �F�F "0 contactselected ContactSelectedb ghg W  7�iji k  C�kk lml r  CLnon [  CHpqp o  CF�E�E &0 countloopcontacts countLoopContactsq m  FG�D�D o o      �C�C &0 countloopcontacts countLoopContactsm rsr r  M]tut m  MN�B
�B boovtrueu n      vwv 1  X\�A
�A 
selEw n  NXxyx 4  QX�@z
�@ 
crowz o  TW�?�? &0 countloopcontacts countLoopContactsy o  NQ�>�> 0 appoutline2 appOutline2s {|{ I ^c�=}�<
�= .sysodelanull��� ��� nmbr} m  ^_�;�; �<  | ~~ l dd�:���:  � N H checking if row is selectable and exit repeat with first selectable row   � ��� �   c h e c k i n g   i f   r o w   i s   s e l e c t a b l e   a n d   e x i t   r e p e a t   w i t h   f i r s t   s e l e c t a b l e   r o w ��9� Z  d����8�� n  ds��� 1  nr�7
�7 
selE� n  dn��� 4  gn�6�
�6 
crow� o  jm�5�5 &0 countloopcontacts countLoopContacts� o  dg�4�4 0 appoutline2 appOutline2� r  v}��� m  vy�� ���  t r u e� o      �3�3 "0 contactselected ContactSelected�8  � l ���2���2  �  - do nothing   � ���  -   d o   n o t h i n g�9  j =  ;B��� o  ;>�1�1 "0 contactselected ContactSelected� m  >A�� ���  t r u eh ��� l ���0���0  � "  alternatively, also working   � ��� 8   a l t e r n a t i v e l y ,   a l s o   w o r k i n g� ��� l ���/���/  � ( "keystroke "f" using {command down}   � ��� D k e y s t r o k e   " f "   u s i n g   { c o m m a n d   d o w n }� ��� l ���.���.  �  delay 2   � ���  d e l a y   2� ��� l ���-���-  �  keystroke tab   � ���  k e y s t r o k e   t a b� ��� l ���,���,  �  delay 2   � ���  d e l a y   2� ��� l ���+���+  � ( "keystroke "a" using {command down}   � ��� D k e y s t r o k e   " a "   u s i n g   { c o m m a n d   d o w n }� ��� l ���*���*  �  delay 2   � ���  d e l a y   2� ��� l ���)�(�'�)  �(  �'  � ��� I ���&��%
�& .sysodelanull��� ��� nmbr� m  ���$�$ �%  � ��� l ���#�"�!�#  �"  �!  � ��� l ��� ���   � 9 3set selected of row countLoop of appOutline to true   � ��� f s e t   s e l e c t e d   o f   r o w   c o u n t L o o p   o f   a p p O u t l i n e   t o   t r u e� ��� l ������  �  delay 1   � ���  d e l a y   1� ��� l ������  �  �  � ��� I �����
� .prcsclicnull��� ��� uiel� n  ����� 4  ����
� 
menI� m  ���� ��� & v C a r d   e x p o r t i e r e n   &� n  ����� 4  ����
� 
menE� m  ���� � n  ����� 4  ����
� 
menI� m  ���� ���  E x p o r t i e r e n� n  ����� 4  ����
� 
menE� m  ���� � n  ����� 4  ����
� 
mbri� m  ���� ���  A b l a g e� 4  ����
� 
mbar� m  ���� �  �  �N  �M  K ��� Z  ������� = ����� o  ���� 0 appname appName� m  ���� ���  R e m i n d e r s� k  ���� ��� I �����
� .sysodelanull��� ��� nmbr� m  ���
�
 �  � ��	� I �����
� .prcsclicnull��� ��� uiel� n  ����� 4  ����
� 
menI� m  ���� ���  E x p o r t i e r e n   &� n  ����� 4  ����
� 
menE� m  ���� � n  ����� 4  ����
� 
mbri� m  ���� ���  A b l a g e� 4  ��� 
� 
mbar  m  ���� �  �	  �  �  �  l ��� �����   ��  ��    I ������
�� .sysodelanull��� ��� nmbr m  ������ ��    l ����������  ��  ��   	 l ����
��  
 L F navigating to correct directory on first time opening the save dialog    � �   n a v i g a t i n g   t o   c o r r e c t   d i r e c t o r y   o n   f i r s t   t i m e   o p e n i n g   t h e   s a v e   d i a l o g	  r  �� [  �� o  ������ 0 savecountloop SaveCountLoop m  ������  o      ���� 0 savecountloop SaveCountLoop  Z  �O���� =  � o  � ���� 0 savecountloop SaveCountLoop m   ����  k  K  I ��
�� .prcskprsnull���     ctxt m   �  g �� ��
�� 
faal  J  !! "#" m  ��
�� eMdsKcmd# $��$ m  ��
�� eMdsKsft��  ��   %&% I ��'��
�� .sysodelanull��� ��� nmbr' m  ���� ��  & ()( I  '��*��
�� .prcskprsnull���     ctxt* o   #���� &0 mybackuppathposix myBackupPathPosix��  ) +,+ I (/��-��
�� .sysodelanull��� ��� nmbr- m  (+���� ��  , .��. I 0K��/��
�� .prcsclicnull��� ��� uiel/ n  0G010 4  @G��2
�� 
butT2 m  CF33 �44  � f f n e n1 n  0@565 4  ;@��7
�� 
sheE7 m  >?���� 6 n  0;898 4  6;��:
�� 
sheE: m  9:���� 9 4  06��;
�� 
cwin; m  45���� ��  ��  ��  ��   <=< l PP��������  ��  ��  = >?> I PU��@��
�� .sysodelanull��� ��� nmbr@ m  PQ���� ��  ? ABA l VV��������  ��  ��  B CDC Z  V�EF��GE =  V]HIH o  VY���� .0 uielementnamenospaces UiElementNameNoSpacesI m  Y\JJ �KK  m i s s i n g _ v a l u eF k  `�LL MNM l ``��OP��  O 7 1 if there are issues with the file name extension   P �QQ b   i f   t h e r e   a r e   i s s u e s   w i t h   t h e   f i l e   n a m e   e x t e n s i o nN RSR l ``��TU��  T ( "keystroke "a" using {command down}   U �VV D k e y s t r o k e   " a "   u s i n g   { c o m m a n d   d o w n }S WXW l ``��YZ��  Y  delay 1   Z �[[  d e l a y   1X \]\ I `o��^_
�� .prcskprsnull���     ctxt^ m  `c`` �aa  c_ ��b��
�� 
faalb J  fkcc d��d m  fi��
�� eMdsKcmd��  ��  ] efe I pu��g��
�� .sysodelanull��� ��� nmbrg m  pq���� ��  f hih r  v�jkj l v}l����l I v}����m
�� .JonsgClp****    ��� null��  m ��n��
�� 
rtypn m  xy��
�� 
ctxt��  ��  ��  k o      ���� 0 uielementname UiElementNamei opo l ����qr��  q l fset defaultSaveNameExtension to do shell script "echo " & defaultSaveName & "| awk '{print $NF}' FS=."   r �ss � s e t   d e f a u l t S a v e N a m e E x t e n s i o n   t o   d o   s h e l l   s c r i p t   " e c h o   "   &   d e f a u l t S a v e N a m e   &   " |   a w k   ' { p r i n t   $ N F } '   F S = . "p tut l ����vw��  v - 'if appName is equal to "Reminders" then   w �xx N i f   a p p N a m e   i s   e q u a l   t o   " R e m i n d e r s "   t h e nu yzy l ����{|��  { , &	set defaultSaveNameExtension to "ics"   | �}} L 	 s e t   d e f a u l t S a v e N a m e E x t e n s i o n   t o   " i c s "z ~~ l ��������  �  end if   � ���  e n d   i f ��� l ��������  �  delay 1   � ���  d e l a y   1� ��� r  ����� I �������
�� .sysoexecTEXT���     TEXT� b  ����� b  ����� m  ���� ��� 
 e c h o  � o  ������ 0 uielementname UiElementName� m  ���� ��� X |   s e d   ' s /   / _ / g '   |   t r   ' [ : u p p e r : ] '   ' [ : l o w e r : ] '��  � o      ���� .0 uielementnamenospaces UiElementNameNoSpaces� ���� l ��������  � f `keystroke (SaveCountLoop as text) & "_" & UiElementNameNoSpaces & "." & defaultSaveNameExtension   � ��� � k e y s t r o k e   ( S a v e C o u n t L o o p   a s   t e x t )   &   " _ "   &   U i E l e m e n t N a m e N o S p a c e s   &   " . "   &   d e f a u l t S a v e N a m e E x t e n s i o n��  ��  G l ��������  �  -   � ���  -D ��� l ����������  ��  ��  � ��� l ��������  � K E inserting save name, numbered, no whitespaces and lowered characters   � ��� �   i n s e r t i n g   s a v e   n a m e ,   n u m b e r e d ,   n o   w h i t e s p a c e s   a n d   l o w e r e d   c h a r a c t e r s� ��� I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��  � ��� I �������
�� .prcskprsnull���     ctxt� b  ����� b  ����� l �������� c  ����� o  ������ 0 savecountloop SaveCountLoop� m  ����
�� 
ctxt��  ��  � m  ���� ���  _� o  ������ .0 uielementnamenospaces UiElementNameNoSpaces��  � ��� I �������
�� .sysodelanull��� ��� nmbr� m  ������ ��  � ��� l ����������  ��  ��  � ��� l ��������  � ? 9 clicking respective export menu bar entries for each app   � ��� r   c l i c k i n g   r e s p e c t i v e   e x p o r t   m e n u   b a r   e n t r i e s   f o r   e a c h   a p p� ��� Z  ��������� = ����� o  ������ 0 appname appName� m  ���� ���  C a l e n d a r� I �������
�� .prcsclicnull��� ��� uiel� n  ����� 4  �����
�� 
butT� m  ���� ���  E x p o r t i e r e n� n  ����� 4  �����
�� 
sheE� m  ������ � 4  �����
�� 
cwin� m  ������ ��  ��  ��  � ��� Z  ��������� = ����� o  ������ 0 appname appName� m  ���� ���  C o n t a c t s� I �������
�� .prcsclicnull��� ��� uiel� n  ����� 4  �����
�� 
butT� m  ���� ���  S i c h e r n� n  ����� 4  �����
�� 
sheE� m  ������ � 4  �����
�� 
cwin� m  ������ ��  ��  ��  � ��� Z   "������� =  ��� o   ���� 0 appname appName� m  �� ���  R e m i n d e r s� I ����
�� .prcsclicnull��� ��� uiel� n  ��� 4  �~�
�~ 
butT� m  �� ���  E x p o r t i e r e n� n  ��� 4  �}�
�} 
sheE� m  �|�| � 4  �{�
�{ 
cwin� m  �z�z �  ��  ��  � ��� l ##�y�x�w�y  �x  �w  � ��� l ##�v���v  � , & waiting for next row depending on app   � ��� L   w a i t i n g   f o r   n e x t   r o w   d e p e n d i n g   o n   a p p� ��� Z  #6���u�t� = #(��� o  #$�s�s 0 appname appName� m  $'�� �    C a l e n d a r� l +2 I +2�r�q
�r .sysodelanull��� ��� nmbr m  +.�p�p �q   M G Change the delay time if your computer is running too slow or too fast    � �   C h a n g e   t h e   d e l a y   t i m e   i f   y o u r   c o m p u t e r   i s   r u n n i n g   t o o   s l o w   o r   t o o   f a s t�u  �t  �  Z  7J	�o�n = 7<

 o  78�m�m 0 appname appName m  8; �  C o n t a c t s	 l ?F I ?F�l�k
�l .sysodelanull��� ��� nmbr m  ?B�j�j 
�k   M G Change the delay time if your computer is running too slow or too fast    � �   C h a n g e   t h e   d e l a y   t i m e   i f   y o u r   c o m p u t e r   i s   r u n n i n g   t o o   s l o w   o r   t o o   f a s t�o  �n   �i Z  K^�h�g = KP o  KL�f�f 0 appname appName m  LO �  R e m i n d e r s l SZ I SZ�e�d
�e .sysodelanull��� ��� nmbr m  SV�c�c 
�d   M G Change the delay time if your computer is running too slow or too fast    � �   C h a n g e   t h e   d e l a y   t i m e   i f   y o u r   c o m p u t e r   i s   r u n n i n g   t o o   s l o w   o r   t o o   f a s t�h  �g  �i  ��  � l aa�b �b    - do nothing     �!!  -   d o   n o t h i n g��  ��  ~ l ee�a"#�a  "  - do nothing   # �$$  -   d o   n o t h i n g��  f = ��%&% o  ���`�` 0 	countloop 	countLoop& o  ���_�_ *0 numberofoutlinerows numberOfOutlineRowsd '(' l ll�^�]�\�^  �]  �\  ( )*) l ll�[+,�[  + / ) select first selectable entry in sidebar   , �-- R   s e l e c t   f i r s t   s e l e c t a b l e   e n t r y   i n   s i d e b a r* ./. l ll�Z01�Z  0 - 'set appList to {"Calendar", "Contacts"}   1 �22 N s e t   a p p L i s t   t o   { " C a l e n d a r " ,   " C o n t a c t s " }/ 343 l ll�Y56�Y  5 &  if appList contains appName then   6 �77 @ i f   a p p L i s t   c o n t a i n s   a p p N a m e   t h e n4 898 Z  l�:;�X<: = lq=>= o  lm�W�W 0 appname appName> m  mp?? �@@  C o n t a c t s; k  t�AA BCB l tt�VDE�V  D  display dialog "yes"   E �FF ( d i s p l a y   d i a l o g   " y e s "C G�UG O  t�HIH O  z�JKJ k  ��LL MNM r  ��OPO m  ��QQ �RR  0P o      �T�T 0 	countloop 	countLoopN STS r  ��UVU m  ��WW �XX 
 f a l s eV o      �S�S $0 firstrowselected FirstRowSelectedT Y�RY W  ��Z[Z k  ��\\ ]^] r  ��_`_ [  ��aba o  ���Q�Q 0 	countloop 	countLoopb m  ���P�P ` o      �O�O 0 	countloop 	countLoop^ cdc r  ��efe m  ���N
�N boovtruef n      ghg 1  ���M
�M 
selEh n  ��iji 4  ���Lk
�L 
crowk o  ���K�K 0 	countloop 	countLoopj o  ���J�J 0 
appoutline 
appOutlined lml I ���In�H
�I .sysodelanull��� ��� nmbrn m  ���G�G �H  m opo l ���Fqr�F  q N H checking if row is selectable and exit repeat with first selectable row   r �ss �   c h e c k i n g   i f   r o w   i s   s e l e c t a b l e   a n d   e x i t   r e p e a t   w i t h   f i r s t   s e l e c t a b l e   r o wp t�Et Z  ��uv�Dwu n  ��xyx 1  ���C
�C 
selEy n  ��z{z 4  ���B|
�B 
crow| o  ���A�A 0 	countloop 	countLoop{ o  ���@�@ 0 
appoutline 
appOutlinev r  ��}~} m  �� ���  t r u e~ o      �?�? $0 firstrowselected FirstRowSelected�D  w l ���>���>  �  - do nothing   � ���  -   d o   n o t h i n g�E  [ =  ����� o  ���=�= $0 firstrowselected FirstRowSelected� m  ���� ���  t r u e�R  K 4  z��<�
�< 
prcs� o  ~�;�; 0 appname appNameI m  tw���                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  �U  �X  < k  ���� ��� l ���:���:  �  display dialog "no"   � ��� & d i s p l a y   d i a l o g   " n o "� ��9� l ���8���8  �  - do nothing   � ���  -   d o   n o t h i n g�9  9 ��� l ���7�6�5�7  �6  �5  � ��� Z  ����4�� = ����� o  ���3�3 0 appname appName� m  ���� ���  C a l e n d a r� Z  ����2�� > ����� o  ���1�1 0 mycalendarrow myCalendarRow� m  ���� ���  � k  ��� ��� r  ���� m  ���0
�0 boovtrue� n      ��� 1  
�/
�/ 
selE� n  ���� 4  ��.�
�. 
crow� o  �-�- 0 mycalendarrow myCalendarRow� o  ���,�, 0 
appoutline 
appOutline� ��+� I �*��)
�* .sysodelanull��� ��� nmbr� m  �(�( �)  �+  �2  � l �'���'  �  -   � ���  -�4  � l �&���&  �  -   � ���  -� ��� l �%�$�#�%  �$  �#  � ��"� l �!� ��!  �   �  �"  � 4  #)��
� 
prcs� o  '(�� 0 appname appName� m   ���                                                                                  sevs  alis    \  macintosh_hd                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    m a c i n t o s h _ h d  -System/Library/CoreServices/System Events.app   / ��  �  �  � ��� l     ����  �  �  � ��� l #���� I #���
� .sysodelanull��� ��� nmbr� m  �� �  �  �  � ��� l     ����  �  �  � ��� l     ����  �   quitting app   � ���    q u i t t i n g   a p p� ��� l $3���� O  $3��� I -2���
� .aevtquitnull��� ��� null�  �  � 4  $*��
� 
capp� o  ()�
�
 0 appname appName�  �  � ��	� l     ����  �  �  �	       ����  � �
� .aevtoappnull  �   � ****� ������� 
� .aevtoappnull  �   � ****� k    3��  ��  +��  3��  D��  X��  m��  ���  ���  ���  ���  ���  ���  ���  ��� ��� ��� �����  �  �  �  � ������� "���� 1���� ; ? B�� L�� b d�� |�� ������� � ����� ��� � ����������������������������������������IK��Q������aenxz�������������������������(������������������������������������$������G����?7��P_��e������������������������3J`����������������?QW�����
�� 
rtyp
�� 
ctxt
�� .earsffdralis        afdr
�� 
psxp�� 0 	scriptdir 	ScriptDir
�� .sysoexecTEXT���     TEXT�� 0 appname appName�� 0 
appoptions 
appOptions
�� .gtqpchltns    @   @ ns  ��  0 appnamelowered appNameLowered
�� .sysodlogaskr        TEXT�� 0 	timestamp 	timeStamp
�� afdrdocs
�� 
TEXT�� 0 backup_folder  �� &0 mybackuppathposix myBackupPathPosix
�� 
strq
�� 
capp
�� .aevtquitnull��� ��� null��  ��  
�� .sysodelanull��� ��� nmbr
�� .ascrnoop****      � ****
�� .miscactvnull��� ��� null
�� 
prcs
�� 
cwin
�� 
uiel
�� 
posn�� 0 p  
�� 
cobj�� 0 xcoordinate xCoordinate�� 0 ycoordinate yCoordinate�� �� 0 xclick xClick�� <�� 0 yclick yClick�� $0 mouseclickbinary mouseClickBinary�� 00 mouseclickbinaryexists mouseClickBinaryExists
�� 
psxf
�� 
alis�� 40 checkifinstalledcliclick checkIfInstalledCliclick
�� 
splg
�� 
scra
�� 
outl�� 0 
appoutline 
appOutline�� 0 appoutline2 appOutline2
�� 
tabB
�� 
crow��  0 alloutlinerows allOutlineRows
�� .corecnte****       ****�� *0 numberofoutlinerows numberOfOutlineRows�� 0 	countloop 	countLoop�� 0 savecountloop SaveCountLoop
�� .miscslctnull���     uiel
�� 
selE�� 0 backupthisrow backupThisRow�� "0 alloutline2rows allOutline2Rows�� ,0 numberofoutline2rows numberOfOutline2Rows
�� 
valL�� 0 uielementname UiElementName�� .0 uielementnamenospaces UiElementNameNoSpaces�� 0 mycalendarrow myCalendarRow
�� 
mbar
�� 
mbri
�� 
menE
�� 
menI
�� .prcsclicnull��� ��� uiel�� &0 countloopcontacts countLoopContacts�� "0 contactselected ContactSelected�� 
�� 
faal
�� eMdsKcmd
�� eMdsKsft
�� .prcskprsnull���     ctxt
�� 
sheE
�� 
butT
�� .JonsgClp****    ��� null�� �� 
�� $0 firstrowselected FirstRowSelected� 4)��l �%�,E�O�j E�O���mvE�O��  �j kv�&E�Y hO��%a %j E` O�� hY a j OhOa j E` Oa �a l a %_ %a %_ %E` O_ �,E` Oa _ a ,%j Oa _ a ,%a %j O *a  �/ *j !UW X " #hOlj $O*a  �/?*j %Omj $O*j &Omj $O�a ' a (*a )�/
*a *k/a +k/ �*a ,,E` -O_ -a .k/E` /O_ -a .l/E` 0O_ /a 1E` 2O_ 0a 3E` 4Oa 5�%a 6%j E` 7Oa 8E` 9O *a :_ 7/a ;&Oa <E` 9W X " #a =E` 9O_ 9a >  4a ?�%a @%j Oa A�%a B%a C%_ 2%a D%_ 4%a E%j Y <a Fj E` GO_ Ga H  a Ij OhY a J_ 2%a K%_ 4%a L%j Okj $UUUY hUOa (�*a )�/��a M  #*a *k/a Nk/a Nk/a Ok/a Pk/E` QY hO�a R  8*a *k/a Nk/a Ok/a Pk/E` QO*a *k/a Nk/a Ol/a Pk/E` SY hO�a T  *a *k/a Nk/a Ok/a Uk/E` QY hO_ Qa V-E` WO_ Wj XE` YOjE` ZOjE` [O�h_ Z_ Y _ ZkE` ZO_ Qa V_ Z/j \O_ Qa V_ Z/a ],EOe_ Qa V_ Z/a ],FOkj $Oa ^E` _O�a `  B*a *k/a Nk/a Ol/a Pk/a V-E` aO_ aj XE` bO_ bk a cE` _Y hY hO_ _a d �_ Qa V_ Z/a +k/a +k/a e,EE` fOa g_ f%a h%j E` iOlj $O�a j  Nkj $O_ fa kj   _ ZE` lY hO*a mk/a na o/a pk/a qa r/a pk/a qa s/j tY hO�a u  �mj $Oa vE` wOa xE` yO Nh_ ya z _ wkE` wOe_ Sa V_ w/a ],FOkj $O_ Sa V_ w/a ],E a {E` yY h[OY��Okj $O*a mk/a na |/a pk/a qa }/a pk/a qa ~/j tY hO�a   (kj $O*a mk/a na �/a pk/a qa �/j tY hOa �j $O_ [kE` [O_ [k  Ka �a �a �a �lvl �Oa �j $O_ j �Oa �j $O*a *k/a �k/a �k/a �a �/j tY hOkj $O_ ia �  <a �a �a �kvl �Okj $O*��l �E` fOa �_ f%a �%j E` iOPY hOlj $O_ [�&a �%_ i%j �Okj $O�a �  *a *k/a �k/a �a �/j tY hO�a �  *a *k/a �k/a �a �/j tY hO�a �  *a *k/a �k/a �a �/j tY hO�a �  a �j $Y hO�a �  a �j $Y hO�a �  a �j $Y hY hY h[OY�|O�a �  ua ( k*a )�/ aa �E` ZOa �E` �O Nh_ �a � _ ZkE` ZOe_ Qa V_ Z/a ],FOkj $O_ Qa V_ Z/a ],E a �E` �Y h[OY��UUY hO�a �  )_ la � e_ Qa V_ l/a ],FOkj $Y hY hOPUUOlj $O*a  �/ *j !U ascr  ��ޭ