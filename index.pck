GDPC                �                                                                         X   res://.godot/exported/133200997/export-053c088fcfd156ea19f3d1ba53835dc9-character.scn          /      �0��H��) r;    T   res://.godot/exported/133200997/export-76e0adcbc83681695885bae615f516ae-world.scn          k      *��`xd�k���R,�    T   res://.godot/exported/133200997/export-b8bf26edbee999f9750edc64c317f94f-bonus.scn          n      N���.�0b�N�	    ,   res://.godot/global_script_class_cache.cfg  �#             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexP      �      �Yz=������������       res://.godot/uid_cache.bin  �'      v       d��>4������8).�       res://bonus.gd                *�q0��2b�\p��AJY       res://bonus.tscn.remap  p"      b       )�ge�=���;ڔ�       res://character.gd  �      �      ��^�ga[���CG       res://character.tscn.remap  �"      f       U;�u*��6\��f�(.       res://icon.svg  �#      �      C��=U���^Qu��U3       res://icon.svg.import   0      �       ���#�=�_�#�Dc'ŗ       res://project.binary (            �A+�&fFkz�       res://world.tscn.remap  P#      b       �t�׵B�}��6�x    -�Q�extends Area2D

@export var color := Color.GOLD

func _on_body_entered(body):
	if body.is_in_group("player_character"):
		print("YAY")
	elif body.is_in_group("hammer"):
		print("OH NO")
	queue_free()


func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, color)
?HX�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://bonus.gd ��������      local://CircleShape2D_jcdi7 P         local://PackedScene_k00hs z         CircleShape2D            �A         PackedScene          	         names "         Bonus    script    Area2D    CollisionShape2D    shape    _on_body_entered    body_entered    	   variants                                 node_count             nodes        ��������       ����                            ����                   conn_count             conns                                       node_paths              editable_instances              version             RSRCeextends CharacterBody2D


@export var mass := 70.0
@export var walking_speed := 100

@export_category("Rope")
@export var min_rope_length := 75.0
@export var max_rope_length := 250.0
@export var rope_adjustment_speed := 70.0

@export_category("Hammer")
@export var hammer_mass := 10.0
@export var min_rotation_speed := TAU / 2.0
@export var max_rotation_speed := TAU * 3.0
@export var rotation_adjustment_speed := TAU / 8.0
## An extra factor by which the hammer's rotational speed affects the player's position.
## Tuned for a good game feel.
@export var fudge_factor := 2.0

var _angle_to_hammer := 0.0
var _rotation_speed := PI * 1.5
var _rope_length := 150.0

@onready var _hammer := $Hammer


func _physics_process(delta):
	var direction := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	position += direction * walking_speed * delta

	# Adjust rope length
	var rope_adjustment := Input.get_axis("reel_in", "let_out")
	_rope_length = clampf(_rope_length + rope_adjustment * rope_adjustment_speed * delta,
		min_rope_length, max_rope_length)
		
	# Adjust spinning speed
	var power_adjustment := Input.get_axis("decrease_power", "increase_power")
	_rotation_speed = clampf(_rotation_speed + power_adjustment * delta * rotation_adjustment_speed,
		min_rotation_speed, max_rotation_speed)
	
	# Adjust hammer position
	_angle_to_hammer += _rotation_speed * delta
	_hammer.position = Vector2(cos(_angle_to_hammer), sin(_angle_to_hammer)) * _rope_length
	
	# _rotation_speed here is a proxy for "power" being applied
	position += Vector2(1,0).rotated(_angle_to_hammer) * hammer_mass / mass * _rotation_speed * fudge_factor
	
	queue_redraw()


func _draw():
	draw_line(Vector2.ZERO, $Hammer.position, Color.SLATE_GRAY, 4)
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.CADET_BLUE)
	draw_circle($Hammer.position, $Hammer/CollisionShape2D.shape.radius, Color.SLATE_GRAY)
RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://character.gd ��������      local://CircleShape2D_qt8ih |         local://CircleShape2D_2kfd2 �         local://PackedScene_ryu33 �         CircleShape2D            HB         CircleShape2D            �A         PackedScene          	         names "   	   
   Character    script    player_character    CharacterBody2D    CollisionShape2D    shape    Hammer 	   position    hammer    	   variants                           
     �B                   node_count             nodes     &   ��������       ����                              ����                           ����                            ����                   conn_count              conns               node_paths              editable_instances              version             RSRCGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[  ���%fy[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dc1xafkrbcb6i"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 V�#(��˅~/�cRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://character.tscn �S�橊{s   PackedScene    res://bonus.tscn zݫ��J�[      local://PackedScene_67a32 >         PackedScene          	         names "         World    Node2D 
   Character 	   position    Node    Bonus    Bonus2    Bonus3    Bonus4    Bonus5    Bonus6    	   variants    	             
     D ��C         
     (C  C
     �B ��C
    @gD ��C
    @ND  C
    @	D  8B
     �C @D      node_count    	         nodes     M   ��������       ����                ���                                  ����               ���                          ���                          ���                          ���                          ���	                          ���
                         conn_count              conns               node_paths              editable_instances              version             RSRC�r���[remap]

path="res://.godot/exported/133200997/export-b8bf26edbee999f9750edc64c317f94f-bonus.scn"
��:������[remap]

path="res://.godot/exported/133200997/export-053c088fcfd156ea19f3d1ba53835dc9-character.scn"
��&帑J��[remap]

path="res://.godot/exported/133200997/export-76e0adcbc83681695885bae615f516ae-world.scn"
��&�f�{�0Z@�list=Array[Dictionary]([])
!�L�<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
�D� �HX�"F   zݫ��J�[   res://bonus.tscn�S�橊{s   res://character.tscn�N��.f   res://icon.svg�ҟt%�O   res://world.tscnkxG߳��T�ECFG      application/config/name         Project    application/run/main_scene         res://world.tscn   application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height            display/window/stretch/mode         canvas_items   input/move_up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script         input/move_down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/move_left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/move_right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/let_out�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/reel_in�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/increase_power�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/decrease_power�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         physics/2d/default_gravity          �!	��@�
dq\�