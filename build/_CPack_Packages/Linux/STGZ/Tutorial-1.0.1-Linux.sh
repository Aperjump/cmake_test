#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0.1-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +147 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� 5Y[ �Zl�g珓&�[ZP�X�8q�-�8��K�.$�l���cCl�	��"�*�
1������M*���6�V�JL�B@U��M.mEh���{��}���]R��[�(�����{�{�{�]$60�
Ju�"���nnj�1�onrky��z����mj�������������)�TR$pW�R�Tt�Ln�r:���P��oJ�'"���x,t�/dx>�������� ��i�4��o��7#�}!;aF���_W��a�P�]JHA>>,G�$���$ˑ�`���LM������$lF\�ﹽcM���mM_?�@G7p����_��a)^��kV�7ձ��Z���g�����
��U�؀������������_��8��_
��.��O蛟�O�{���D����������xs��i���&w���Ih��s���ry+���d��o���+�:�����k�BT��E9����ܖkG�k��y�/Dz�ix�4㙜���9=��g*U��J^�Gh��,z=��C��Py��-����^��|%��"��~,Iz�{X~3�s���+A�ON�{h{f����P7��6�k�"��H�H�����J�]J��Tvuw�"O����ϧ)?���k?�����%ښx���s_'eeT���N�Z4��VTT�����JZO�5�/l�u➲�����SU,���}��}G��ᮆ�wO�o��{6?��K;>�W��`��7?���1� ��y�#&��&�wM����kM�I���p��EU��Tk{�"krEz����Q�*�3��~ʿ���DwS;�|E�M��y��/P���Q�=�.��'���t@G)~X��m��yx�ʯ���ۥ����+�=G��z����%�]h0���DoW�P<&���$$���xL$g�,����`�L�P�L��xJF9B��D$&�p]#_�C�I�D�VDb�$SD*�D)�&L�=X�S�HLL%��Vk�b)F��d�ʯ��hk\�&:/:7V%�M��>�deRWEʈN�N)�C�}E-���a?{������&l��B��C�%(����V����scR�k�ͳܦ��Ie|�'�g���4x�C�kMV;a���x$<�O�d����Q��C��
�븶�H^����b���<��co(�/Kyu�>�O���塝�N�Ɏ��B�a�ɵ��;�oò�79�V��d�u|�v�Ù>aG���K�
��+qW�-U�Z�!;r9�ݪԿa��2�����M�P��q
����BzR؟�U�
���*\a�VXA*4�o�
"�Ru�؊f��#����X�s�J<⌀/�y��o!z��C�x���c!,ARx���O�����'�����	a���t	�|dWC/q�8����_Q��֩l6/|�D�b�D?�x���*�c����L.		�M����Mb~���?�Y�):�+��I	N�M�5��t�*��;����bgN��͑�_��Vh��ߺ��;�>^���X���%�v_�\G�L�+����5� �Cx���׿5t���L�Y��ԗ���06�	K������6���m�m��;�-����X/yF-�:ɯ��H<�W]�AԗJ�2�R�~)Q�z���/HH|"��x���#I��������7�������6�[pw��9�|=�=x�Ȝ�#�|�n�I̧��=؃�'wuE�m'W�$8�13�N8���ZL��X��؝��U�9�<`ۂn�j�M��ׁ>���`9�>Bt�����>+g���|��^Yby���<DƄǢ��mv瓖6{�V���Q�f�y�X��+�-c�]�ք��gw��5mv�a�6�Mه��a\�v_��o�������}�WP~u�s~\������6����L�Sٸ�O�	�RM�z���{�9�p��|���{��6+P�#��WP�Z���%�~��lh�;H/�UVG�)����ei�5I�_����浾ǅ��}��?ҁ���RC�	����������TLN��.��][�M)Yύ*0c]V<�-��0{q+�񢜽��✝��=����:�q[n}�xYΎ�xy���x��C�+�nC�M����7��(x�������z|����=>?�����hE��_=^x_T��{��_Y����}�eq��Y��6=n������{�Yi�
U�����JI�C��3��3����3&�7ׯ��y����X���e�<��sE��:����x�������k`W�Z?��
^h�q����8����3~��!�9�x���?�p�����,g/����_L��g/9��K^F��ݜq��8�r�3��|e���8��8��g�A	9)�B!� ��VD9*��I�D5���P�?0$�x")R#h �d)�j�.�)�1�HFE)&'FQ(�Jb0��bMN	��D᥶k`dˮ��u�E�J��K�8J0ÁX�D�V�����h׋Ѡ����O��:ae�z�ڡ�՝k�|��U�n������N�X�&���Z[��[�#�xXb���$�b%����!'M�IcM$c�����eȕ�ʁ~���Ð����˒���Q+in0�r��"C��H)�p F��hקr9��ܯ^Su�%�� ���!�4�K���8N���UVΕ�+������D>����j@��FpBQ��\�	�bS5x��#"~?9s`�5{��1��>�ž���"&_���|���~|�ڠ�!�)���0��H���>�����C|��ް��e��	�;@��mD�]��/���?�zIy�0���x+��߂
�� R�����%v�`�[�~̓?�kD�r�'P�]!8'�ý�]�4��5�VF���}�Á��ec��}8w��3��>�~������g���?��? �Ϡ��o�~�L�eF��m�����*R}s�'��7˳���wh����}���#�;���\
h���#��9T���P��gh�F?�G:����@�}����m��Ń>��ŝ��-T�M'��3����/��]K��U��T��sM���L18�?Kz"��`�M��_�¶1����������u�~�s)h�́�@���:^O[�7����<f��z��ħ"�&ȭ����>b������&���$�d�l���U(��N9��3�EY���*��N9�TR�Vʱq���g�����E���:���?t?�"�bUx=~S�0=r�꺆&n=��ٻ'⛃������*���,�D�j�CZM"��� p㯲��8 m-8� /���<M?7A"odHk{�h19JH��Ϊ���a$a�w)��K�\D���z�\��B�9�f�����>�R������j�|���@�p��}9}:������7 �ס�W����/Az_���#ce�O �"�"c_	�H�&�o3��s�V�d�oQ�f�߃���q��S]v�L}=��$͓�t�����WC+e�z��������2����,��,�?���5� <  