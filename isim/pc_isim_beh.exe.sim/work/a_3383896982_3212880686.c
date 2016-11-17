/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "F:/2016FALL/JY/cpu/mcpu/src/pc.vhd";
extern char *IEEE_P_2592010699;
extern char *WORK_P_0972559976;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1258338084_503743352(char *, char *, unsigned int , unsigned int );
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );


static void work_a_3383896982_3212880686_p_0(char *t0)
{
    char t19[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    unsigned char t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned int t20;
    unsigned int t21;

LAB0:    xsi_set_current_line(24, ng0);
    t1 = (t0 + 1152U);
    t2 = ieee_p_2592010699_sub_1258338084_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3880);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(25, ng0);
    t3 = (t0 + 1032U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t3 = ((WORK_P_0972559976) + 2488U);
    t6 = *((char **)t3);
    t7 = *((unsigned char *)t6);
    t8 = (t5 == t7);
    if (t8 != 0)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(32, ng0);
    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_0972559976) + 1168U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t7 = (t2 == t5);
    if (t7 != 0)
        goto LAB13;

LAB15:    xsi_set_current_line(36, ng0);
    t1 = ((WORK_P_0972559976) + 1888U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 4040);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t9 = (t6 + 56U);
    t11 = *((char **)t9);
    *((unsigned char *)t11) = t2;
    xsi_driver_first_trans_fast_port(t1);

LAB14:    goto LAB3;

LAB5:    xsi_set_current_line(26, ng0);
    t3 = (t0 + 1512U);
    t9 = *((char **)t3);
    t10 = *((unsigned char *)t9);
    t3 = ((WORK_P_0972559976) + 2728U);
    t11 = *((char **)t3);
    t12 = *((unsigned char *)t11);
    t13 = (t10 == t12);
    if (t13 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(29, ng0);
    t1 = (t0 + 2152U);
    t3 = *((char **)t1);
    t1 = (t0 + 2160U);
    t4 = *((char **)t1);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t19, t3, t4, 1);
    t9 = (t19 + 12U);
    t20 = *((unsigned int *)t9);
    t21 = (1U * t20);
    t2 = (16U != t21);
    if (t2 == 1)
        goto LAB11;

LAB12:    t11 = (t0 + 3976);
    t14 = (t11 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t6, 16U);
    xsi_driver_first_trans_fast(t11);

LAB9:    goto LAB6;

LAB8:    xsi_set_current_line(27, ng0);
    t3 = (t0 + 1672U);
    t14 = *((char **)t3);
    t3 = (t0 + 3976);
    t15 = (t3 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t14, 16U);
    xsi_driver_first_trans_fast(t3);
    goto LAB9;

LAB11:    xsi_size_not_matching(16U, t21, 0);
    goto LAB12;

LAB13:    xsi_set_current_line(33, ng0);
    t1 = ((WORK_P_0972559976) + 2008U);
    t6 = *((char **)t1);
    t8 = *((unsigned char *)t6);
    t1 = (t0 + 4040);
    t9 = (t1 + 56U);
    t11 = *((char **)t9);
    t14 = (t11 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = t8;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(34, ng0);
    t1 = ((WORK_P_0972559976) + 3568U);
    t3 = *((char **)t1);
    t1 = (t0 + 3976);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t9 = (t6 + 56U);
    t11 = *((char **)t9);
    memcpy(t11, t3, 16U);
    xsi_driver_first_trans_fast(t1);
    goto LAB14;

}

static void work_a_3383896982_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(40, ng0);

LAB3:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 4104);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 16U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3896);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3383896982_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3383896982_3212880686_p_0,(void *)work_a_3383896982_3212880686_p_1};
	xsi_register_didat("work_a_3383896982_3212880686", "isim/pc_isim_beh.exe.sim/work/a_3383896982_3212880686.didat");
	xsi_register_executes(pe);
}
