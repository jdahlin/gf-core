# AC_C_ALIGNOF
# ------------
# Check whether the C compiler supports the alignof(type) operator
AC_DEFUN([AC_C_ALIGNOF],
[
  AC_CACHE_CHECK([for alignof],ac_cv_c_alignof,
    [ac_cv_c_alignof=no
     for ac_kw in alignof __alignof __alignof__; do
       AC_COMPILE_IFELSE(
	 [AC_LANG_PROGRAM([], [int align = $ac_kw (int);])],
	 [ac_cv_c_alignof=$ac_kw; break])
     done])
  if test $ac_cv_c_alignof != no; then
    AC_DEFINE([HAVE_ALIGNOF], 1,
      [Define to 1 if alignof works on your compiler])
    if test $ac_cv_c_alignof != alignof; then
      AC_DEFINE_UNQUOTED([alignof], [$ac_cv_c_alignof],
	[Define to the name of the alignof operator.])
    fi
  fi
])

# AC_C_FAM_IN_MEM
# ---------------
# Check whether the C compiler supports a flexible array member
# in a struct that is the (last) member of a struct
AC_DEFUN([AC_C_FAM_IN_MEM],
[
  AC_CACHE_CHECK([for flexible array members in struct members],
    ac_cv_c_fam_in_mem,
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([
	struct { struct { char foo[]; } bar; } baz;
      ])], 
      [ac_cv_c_fam_in_mem=yes],
      [ac_cv_c_fam_in_mem=no])])
  if test $ac_cv_c_fam_in_mem = yes; then
    AC_DEFINE([CAN_HAVE_FAM_IN_MEMBER], 1,
    [Define to 1 if a struct with flexible array members can be 
     the last member of another struct.])
  fi
])
