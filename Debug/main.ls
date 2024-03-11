   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.9 - 19 Apr 2023
   3                     ; Generator (Limited) V4.5.6 - 18 Jul 2023
2775                     	bsct
2776  0000               _sec_passed:
2777  0000 0032          	dc.w	50
2778  0002               _min_passed:
2779  0002 003b          	dc.w	59
2780  0004               _hours_passed:
2781  0004 0003          	dc.w	3
2782  0006               _hours_prev:
2783  0006 0000          	dc.w	0
2784  0008               _segm_dec:
2785  0008 03            	dc.b	3
2786  0009 9f            	dc.b	159
2787  000a 25            	dc.b	37
2788  000b 0d            	dc.b	13
2789  000c 99            	dc.b	153
2790  000d 49            	dc.b	73
2791  000e 41            	dc.b	65
2792  000f 1f            	dc.b	31
2793  0010 01            	dc.b	1
2794  0011 09            	dc.b	9
2795  0012               _H_letter:
2796  0012 91            	dc.b	145
2797  0013               _S_letter:
2798  0013 49            	dc.b	73
2799  0014               _M_letter:
2800  0014 13            	dc.b	19
2801  0015 13            	dc.b	19
2834                     ; 45 void TIM4_init(void)
2834                     ; 46 {
2836                     	switch	.text
2837  0000               _TIM4_init:
2841                     ; 47 	TIM4_PSCR = 3;
2843  0000 35035345      	mov	_TIM4_PSCR,#3
2844                     ; 48 	TIM4_IER |= (1<<0);
2846  0004 72105341      	bset	_TIM4_IER,#0
2847                     ; 49 	TIM4_CR1 |= (1<<0);
2849  0008 72105340      	bset	_TIM4_CR1,#0
2850                     ; 50 	TIM4_ARR = 249;
2852  000c 35f95346      	mov	_TIM4_ARR,#249
2853                     ; 51 }
2856  0010 81            	ret
2882                     ; 53 void S_init(void)
2882                     ; 54 {
2883                     	switch	.text
2884  0011               _S_init:
2888                     ; 55 	PB_DDR &= ~(1<<4)|(1<<3)|(1<<2);
2890  0011 72195007      	bres	_PB_DDR,#4
2891                     ; 56 	PB_CR1 |= (1<<4)|(1<<3)|(1<<2);
2893  0015 c65008        	ld	a,_PB_CR1
2894  0018 aa1c          	or	a,#28
2895  001a c75008        	ld	_PB_CR1,a
2896                     ; 57 	PB_CR2 &= ~(1<<4)|(1<<3)|(1<<2); 	
2898  001d 72195009      	bres	_PB_CR2,#4
2899                     ; 58 }
2902  0021 81            	ret
2934                     ; 60 void segm_init(void)
2934                     ; 61 {
2935                     	switch	.text
2936  0022               _segm_init:
2940                     ; 63   PD_DDR |= 1<<3;
2942  0022 72165011      	bset	_PD_DDR,#3
2943                     ; 64   PD_CR1 |= 1<<3;
2945  0026 72165012      	bset	_PD_CR1,#3
2946                     ; 65   PD_CR2 |= 1<<3;
2948  002a 72165013      	bset	_PD_CR2,#3
2949                     ; 68   PC_DDR |= 1<<3;
2951  002e 7216500c      	bset	_PC_DDR,#3
2952                     ; 69   PC_CR1 |= 1<<3;
2954  0032 7216500d      	bset	_PC_CR1,#3
2955                     ; 70   PC_CR2 |= 1<<3;
2957  0036 7216500e      	bset	_PC_CR2,#3
2958                     ; 73   PG_DDR |= 1<<0;
2960  003a 72105020      	bset	_PG_DDR,#0
2961                     ; 74   PG_CR1 |= 1<<0;
2963  003e 72105021      	bset	_PG_CR1,#0
2964                     ; 75   PG_CR2 |= 1<<0;
2966  0042 72105022      	bset	_PG_CR2,#0
2967                     ; 76 }
2970  0046 81            	ret
2996                     ; 78 void buzzer_init(void)
2996                     ; 79 {
2997                     	switch	.text
2998  0047               _buzzer_init:
3002                     ; 80 	PC_DDR |= (1<<1);
3004  0047 7212500c      	bset	_PC_DDR,#1
3005                     ; 81 	PC_CR1 |= (1<<1);
3007  004b 7212500d      	bset	_PC_CR1,#1
3008                     ; 82 	PC_CR2 &= ~(1<<1);
3010  004f 7213500e      	bres	_PC_CR2,#1
3011                     ; 83 }
3014  0053 81            	ret
3068                     ; 86 void time_update_value(int num, unsigned int *first, unsigned int *second) 
3068                     ; 87 {
3069                     	switch	.text
3070  0054               _time_update_value:
3072  0054 89            	pushw	x
3073       00000000      OFST:	set	0
3076                     ; 88     if (num >= 10 && num <= 59) {
3078  0055 9c            	rvf
3079  0056 a3000a        	cpw	x,#10
3080  0059 2f1c          	jrslt	L3502
3082  005b 9c            	rvf
3083  005c a3003c        	cpw	x,#60
3084  005f 2e16          	jrsge	L3502
3085                     ; 89         *first = num / 10;
3087  0061 a60a          	ld	a,#10
3088  0063 cd0000        	call	c_sdivx
3090  0066 1605          	ldw	y,(OFST+5,sp)
3091  0068 90ff          	ldw	(y),x
3092                     ; 90         *second = num % 10;
3094  006a 1e01          	ldw	x,(OFST+1,sp)
3095  006c a60a          	ld	a,#10
3096  006e cd0000        	call	c_smodx
3098  0071 1607          	ldw	y,(OFST+7,sp)
3099  0073 90ff          	ldw	(y),x
3101  0075 2023          	jra	L5502
3102  0077               L3502:
3103                     ; 91     } else if (num >= 0 && num <= 9) {
3105  0077 9c            	rvf
3106  0078 1e01          	ldw	x,(OFST+1,sp)
3107  007a 2f14          	jrslt	L7502
3109  007c 9c            	rvf
3110  007d 1e01          	ldw	x,(OFST+1,sp)
3111  007f a3000a        	cpw	x,#10
3112  0082 2e0c          	jrsge	L7502
3113                     ; 92         *first = 0;  
3115  0084 1e05          	ldw	x,(OFST+5,sp)
3116  0086 905f          	clrw	y
3117  0088 ff            	ldw	(x),y
3118                     ; 93         *second = num;
3120  0089 1e07          	ldw	x,(OFST+7,sp)
3121  008b 1601          	ldw	y,(OFST+1,sp)
3122  008d ff            	ldw	(x),y
3124  008e 200a          	jra	L5502
3125  0090               L7502:
3126                     ; 95         *first = *second = 0;  
3128  0090 1e07          	ldw	x,(OFST+7,sp)
3129  0092 905f          	clrw	y
3130  0094 ff            	ldw	(x),y
3131  0095 1e05          	ldw	x,(OFST+5,sp)
3132  0097 905f          	clrw	y
3133  0099 ff            	ldw	(x),y
3134  009a               L5502:
3135                     ; 97 }
3138  009a 85            	popw	x
3139  009b 81            	ret
3174                     ; 100 void delay(int ms)
3174                     ; 101 {
3175                     	switch	.text
3176  009c               _delay:
3178  009c 89            	pushw	x
3179       00000000      OFST:	set	0
3182                     ; 102 	tick_msec = 0;
3184  009d 5f            	clrw	x
3185  009e bf05          	ldw	_tick_msec,x
3187  00a0               L5012:
3188                     ; 103 	while(tick_msec<ms){}	
3190  00a0 be05          	ldw	x,_tick_msec
3191  00a2 1301          	cpw	x,(OFST+1,sp)
3192  00a4 25fa          	jrult	L5012
3193                     ; 104 }
3196  00a6 85            	popw	x
3197  00a7 81            	ret
3242                     ; 107 void segm_shift(char shift)
3242                     ; 108 {
3243                     	switch	.text
3244  00a8               _segm_shift:
3246  00a8 88            	push	a
3247  00a9 88            	push	a
3248       00000001      OFST:	set	1
3251                     ; 111   for (i = 0; i < 8; ++i)
3253  00aa 0f01          	clr	(OFST+0,sp)
3255  00ac               L3312:
3256                     ; 113     if (shift & 0x01)
3258  00ac 7b02          	ld	a,(OFST+1,sp)
3259  00ae a501          	bcp	a,#1
3260  00b0 2706          	jreq	L1412
3261                     ; 114       PD_ODR |= 1<<3;	//SDI=1
3263  00b2 7216500f      	bset	_PD_ODR,#3
3265  00b6 2004          	jra	L3412
3266  00b8               L1412:
3267                     ; 116       PD_ODR &= ~(1<<3); //SDI=0
3269  00b8 7217500f      	bres	_PD_ODR,#3
3270  00bc               L3412:
3271                     ; 118     PC_ODR |= 1<<3; //SFTCLK=1
3273  00bc 7216500a      	bset	_PC_ODR,#3
3274                     ; 119     PC_ODR &= ~(1<<3); //SFTCLK=0
3276  00c0 7217500a      	bres	_PC_ODR,#3
3277                     ; 121     shift >>= 1;
3279  00c4 0402          	srl	(OFST+1,sp)
3280                     ; 111   for (i = 0; i < 8; ++i)
3282  00c6 0c01          	inc	(OFST+0,sp)
3286  00c8 7b01          	ld	a,(OFST+0,sp)
3287  00ca a108          	cp	a,#8
3288  00cc 25de          	jrult	L3312
3289                     ; 123 }
3292  00ce 85            	popw	x
3293  00cf 81            	ret
3338                     ; 125 void segm_latch(char pos, char val)
3338                     ; 126 {	
3339                     	switch	.text
3340  00d0               _segm_latch:
3342  00d0 89            	pushw	x
3343       00000000      OFST:	set	0
3346                     ; 127   segm_shift(val);
3348  00d1 9f            	ld	a,xl
3349  00d2 add4          	call	_segm_shift
3351                     ; 128   segm_shift(0x80 >> pos);
3353  00d4 7b01          	ld	a,(OFST+1,sp)
3354  00d6 5f            	clrw	x
3355  00d7 97            	ld	xl,a
3356  00d8 a680          	ld	a,#128
3357  00da 5d            	tnzw	x
3358  00db 2704          	jreq	L42
3359  00dd               L62:
3360  00dd 44            	srl	a
3361  00de 5a            	decw	x
3362  00df 26fc          	jrne	L62
3363  00e1               L42:
3364  00e1 adc5          	call	_segm_shift
3366                     ; 130   PG_ODR |= 1<<0; //LCHCLK=1
3368  00e3 7210501e      	bset	_PG_ODR,#0
3369                     ; 131   PG_ODR &= ~(1<<0); //LCHCLK=0
3371  00e7 7211501e      	bres	_PG_ODR,#0
3372                     ; 132 }
3375  00eb 85            	popw	x
3376  00ec 81            	ret
3402                     ; 134 void segm_next(void)
3402                     ; 135 {
3403                     	switch	.text
3404  00ed               _segm_next:
3408                     ; 136   segm_latch(segm_pos, segm_val[segm_pos]);
3410  00ed b600          	ld	a,_segm_pos
3411  00ef 5f            	clrw	x
3412  00f0 97            	ld	xl,a
3413  00f1 e601          	ld	a,(_segm_val,x)
3414  00f3 97            	ld	xl,a
3415  00f4 b600          	ld	a,_segm_pos
3416  00f6 95            	ld	xh,a
3417  00f7 add7          	call	_segm_latch
3419                     ; 137   if (++segm_pos >= 4) segm_pos = 0;
3421  00f9 3c00          	inc	_segm_pos
3422  00fb b600          	ld	a,_segm_pos
3423  00fd a104          	cp	a,#4
3424  00ff 2502          	jrult	L7712
3427  0101 3f00          	clr	_segm_pos
3428  0103               L7712:
3429                     ; 138 }
3432  0103 81            	ret
3459                     ; 141 void time_overflow(void)
3459                     ; 142 {
3460                     	switch	.text
3461  0104               _time_overflow:
3465                     ; 143 		if (sec_passed == 60)
3467  0104 be00          	ldw	x,_sec_passed
3468  0106 a3003c        	cpw	x,#60
3469  0109 260a          	jrne	L1122
3470                     ; 145 			sec_passed = 0;
3472  010b 5f            	clrw	x
3473  010c bf00          	ldw	_sec_passed,x
3474                     ; 146 			min_passed += 1;
3476  010e be02          	ldw	x,_min_passed
3477  0110 1c0001        	addw	x,#1
3478  0113 bf02          	ldw	_min_passed,x
3479  0115               L1122:
3480                     ; 148 		if (min_passed == 60)
3482  0115 be02          	ldw	x,_min_passed
3483  0117 a3003c        	cpw	x,#60
3484  011a 260a          	jrne	L3122
3485                     ; 150 			min_passed = 0;
3487  011c 5f            	clrw	x
3488  011d bf02          	ldw	_min_passed,x
3489                     ; 151 			hours_passed += 1;
3491  011f be04          	ldw	x,_hours_passed
3492  0121 1c0001        	addw	x,#1
3493  0124 bf04          	ldw	_hours_passed,x
3494  0126               L3122:
3495                     ; 153 		if (hours_passed == 12)
3497  0126 be04          	ldw	x,_hours_passed
3498  0128 a3000c        	cpw	x,#12
3499  012b 2603          	jrne	L5122
3500                     ; 154 			hours_passed = 0;
3502  012d 5f            	clrw	x
3503  012e bf04          	ldw	_hours_passed,x
3504  0130               L5122:
3505                     ; 156 		hours_prev = hours_passed - 1;
3507  0130 be04          	ldw	x,_hours_passed
3508  0132 5a            	decw	x
3509  0133 bf06          	ldw	_hours_prev,x
3510                     ; 157 }
3513  0135 81            	ret
3541                     ; 159 void buzzer_beep(void)
3541                     ; 160 {
3542                     	switch	.text
3543  0136               _buzzer_beep:
3547                     ; 161 	if(min_passed == 0 && sec_passed < hours_passed) 
3549  0136 be02          	ldw	x,_min_passed
3550  0138 261a          	jrne	L7222
3552  013a 9c            	rvf
3553  013b be00          	ldw	x,_sec_passed
3554  013d b304          	cpw	x,_hours_passed
3555  013f 2e13          	jrsge	L7222
3556                     ; 163 		if(tick_msec < 100)
3558  0141 be05          	ldw	x,_tick_msec
3559  0143 a30064        	cpw	x,#100
3560  0146 2406          	jruge	L1322
3561                     ; 165 			PC_ODR &= ~(1<<1);
3563  0148 7213500a      	bres	_PC_ODR,#1
3565  014c 202d          	jra	L5322
3566  014e               L1322:
3567                     ; 169 			PC_ODR |= (1<<1);
3569  014e 7212500a      	bset	_PC_ODR,#1
3570  0152 2027          	jra	L5322
3571  0154               L7222:
3572                     ; 174 		if(min_passed == 0 && hours_passed == 0 && sec_passed < 12)
3574  0154 be02          	ldw	x,_min_passed
3575  0156 261f          	jrne	L7322
3577  0158 be04          	ldw	x,_hours_passed
3578  015a 261b          	jrne	L7322
3580  015c 9c            	rvf
3581  015d be00          	ldw	x,_sec_passed
3582  015f a3000c        	cpw	x,#12
3583  0162 2e13          	jrsge	L7322
3584                     ; 176 			if(tick_msec < 100)
3586  0164 be05          	ldw	x,_tick_msec
3587  0166 a30064        	cpw	x,#100
3588  0169 2406          	jruge	L1422
3589                     ; 178 				PC_ODR &= ~(1<<1);
3591  016b 7213500a      	bres	_PC_ODR,#1
3593  016f 200a          	jra	L5322
3594  0171               L1422:
3595                     ; 182 			PC_ODR |= (1<<1);
3597  0171 7212500a      	bset	_PC_ODR,#1
3598  0175 2004          	jra	L5322
3599  0177               L7322:
3600                     ; 187 			PC_ODR |= (1<<1);
3602  0177 7212500a      	bset	_PC_ODR,#1
3603  017b               L5322:
3604                     ; 190 }
3607  017b 81            	ret
3654                     ; 193 void main(void)
3654                     ; 194 {
3655                     	switch	.text
3656  017c               _main:
3660                     ; 196 	TIM4_init();
3662  017c cd0000        	call	_TIM4_init
3664                     ; 197 	segm_init();
3666  017f cd0022        	call	_segm_init
3668                     ; 198 	buzzer_init();
3670  0182 cd0047        	call	_buzzer_init
3672                     ; 199 	S_init();//sec dla S1, min dla S2, hours dla S3
3674  0185 cd0011        	call	_S_init
3676                     ; 203 	rim
3679  0188 9a            rim
3681  0189               L7522:
3682                     ; 209 			time_overflow();
3684  0189 cd0104        	call	_time_overflow
3686                     ; 213 			if (tick_msec == 1000)
3688  018c be05          	ldw	x,_tick_msec
3689  018e a303e8        	cpw	x,#1000
3690  0191 2637          	jrne	L3622
3691                     ; 215 				sec_passed +=1;
3693  0193 be00          	ldw	x,_sec_passed
3694  0195 1c0001        	addw	x,#1
3695  0198 bf00          	ldw	_sec_passed,x
3696                     ; 216 				time_update_value(sec_passed, &first_sec, &second_sec);
3698  019a ae000f        	ldw	x,#_second_sec
3699  019d 89            	pushw	x
3700  019e ae0011        	ldw	x,#_first_sec
3701  01a1 89            	pushw	x
3702  01a2 be00          	ldw	x,_sec_passed
3703  01a4 cd0054        	call	_time_update_value
3705  01a7 5b04          	addw	sp,#4
3706                     ; 217 				time_update_value(min_passed, &first_min, &second_min);
3708  01a9 ae000b        	ldw	x,#_second_min
3709  01ac 89            	pushw	x
3710  01ad ae000d        	ldw	x,#_first_min
3711  01b0 89            	pushw	x
3712  01b1 be02          	ldw	x,_min_passed
3713  01b3 cd0054        	call	_time_update_value
3715  01b6 5b04          	addw	sp,#4
3716                     ; 218 				time_update_value(hours_passed, &first_hour, &second_hour);
3718  01b8 ae0007        	ldw	x,#_second_hour
3719  01bb 89            	pushw	x
3720  01bc ae0009        	ldw	x,#_first_hour
3721  01bf 89            	pushw	x
3722  01c0 be04          	ldw	x,_hours_passed
3723  01c2 cd0054        	call	_time_update_value
3725  01c5 5b04          	addw	sp,#4
3726                     ; 219 				tick_msec = 0;
3728  01c7 5f            	clrw	x
3729  01c8 bf05          	ldw	_tick_msec,x
3730  01ca               L3622:
3731                     ; 223 			if ( ((PB_IDR & (1<<4)) != 0 ) && ((PB_IDR & (1<<3)) != 0 ) && ((PB_IDR & (1<<2)) != 0 ) )
3733  01ca c65006        	ld	a,_PB_IDR
3734  01cd a510          	bcp	a,#16
3735  01cf 272b          	jreq	L5622
3737  01d1 c65006        	ld	a,_PB_IDR
3738  01d4 a508          	bcp	a,#8
3739  01d6 2724          	jreq	L5622
3741  01d8 c65006        	ld	a,_PB_IDR
3742  01db a504          	bcp	a,#4
3743  01dd 271d          	jreq	L5622
3744                     ; 225 				segm_latch(0, segm_dec[first_sec]);
3746  01df be11          	ldw	x,_first_sec
3747  01e1 e608          	ld	a,(_segm_dec,x)
3748  01e3 5f            	clrw	x
3749  01e4 97            	ld	xl,a
3750  01e5 cd00d0        	call	_segm_latch
3752                     ; 226 				segm_latch(1, segm_dec[second_sec]);
3754  01e8 be0f          	ldw	x,_second_sec
3755  01ea e608          	ld	a,(_segm_dec,x)
3756  01ec ae0100        	ldw	x,#256
3757  01ef 97            	ld	xl,a
3758  01f0 cd00d0        	call	_segm_latch
3760                     ; 227 				segm_latch(3, S_letter);
3762  01f3 b613          	ld	a,_S_letter
3763  01f5 ae0300        	ldw	x,#768
3764  01f8 97            	ld	xl,a
3765  01f9 cd00d0        	call	_segm_latch
3767  01fc               L5622:
3768                     ; 231 			if ((PB_IDR & (1<<4)) == 0) 
3770  01fc c65006        	ld	a,_PB_IDR
3771  01ff a510          	bcp	a,#16
3772  0201 2621          	jrne	L7622
3773                     ; 233 				segm_latch(0, segm_dec[first_sec]);
3775  0203 be11          	ldw	x,_first_sec
3776  0205 e608          	ld	a,(_segm_dec,x)
3777  0207 5f            	clrw	x
3778  0208 97            	ld	xl,a
3779  0209 cd00d0        	call	_segm_latch
3781                     ; 234 				segm_latch(1, segm_dec[second_sec]);
3783  020c be0f          	ldw	x,_second_sec
3784  020e e608          	ld	a,(_segm_dec,x)
3785  0210 ae0100        	ldw	x,#256
3786  0213 97            	ld	xl,a
3787  0214 cd00d0        	call	_segm_latch
3789                     ; 235 				segm_latch(3, S_letter);
3791  0217 b613          	ld	a,_S_letter
3792  0219 ae0300        	ldw	x,#768
3793  021c 97            	ld	xl,a
3794  021d cd00d0        	call	_segm_latch
3796                     ; 236 				PC_CR2 ^= (1<<1);
3798  0220 9012500e      	bcpl	_PC_CR2,#1
3799  0224               L7622:
3800                     ; 241 			if ((PB_IDR & (1<<3)) == 0)
3802  0224 c65006        	ld	a,_PB_IDR
3803  0227 a508          	bcp	a,#8
3804  0229 2626          	jrne	L1722
3805                     ; 243 				segm_latch(0, segm_dec[first_min]);
3807  022b be0d          	ldw	x,_first_min
3808  022d e608          	ld	a,(_segm_dec,x)
3809  022f 5f            	clrw	x
3810  0230 97            	ld	xl,a
3811  0231 cd00d0        	call	_segm_latch
3813                     ; 244 				segm_latch(1, segm_dec[second_min]);	
3815  0234 be0b          	ldw	x,_second_min
3816  0236 e608          	ld	a,(_segm_dec,x)
3817  0238 ae0100        	ldw	x,#256
3818  023b 97            	ld	xl,a
3819  023c cd00d0        	call	_segm_latch
3821                     ; 245 				segm_latch(2, M_letter[0]);
3823  023f b614          	ld	a,_M_letter
3824  0241 ae0200        	ldw	x,#512
3825  0244 97            	ld	xl,a
3826  0245 cd00d0        	call	_segm_latch
3828                     ; 246 				segm_latch(3, M_letter[1]);
3830  0248 b615          	ld	a,_M_letter+1
3831  024a ae0300        	ldw	x,#768
3832  024d 97            	ld	xl,a
3833  024e cd00d0        	call	_segm_latch
3835  0251               L1722:
3836                     ; 250 			if ((PB_IDR & (1<<2)) == 0)
3838  0251 c65006        	ld	a,_PB_IDR
3839  0254 a504          	bcp	a,#4
3840  0256 261d          	jrne	L3722
3841                     ; 252 				segm_latch(0, segm_dec[first_hour]);
3843  0258 be09          	ldw	x,_first_hour
3844  025a e608          	ld	a,(_segm_dec,x)
3845  025c 5f            	clrw	x
3846  025d 97            	ld	xl,a
3847  025e cd00d0        	call	_segm_latch
3849                     ; 253 				segm_latch(1, segm_dec[second_hour]);
3851  0261 be07          	ldw	x,_second_hour
3852  0263 e608          	ld	a,(_segm_dec,x)
3853  0265 ae0100        	ldw	x,#256
3854  0268 97            	ld	xl,a
3855  0269 cd00d0        	call	_segm_latch
3857                     ; 254 				segm_latch(3, H_letter);
3859  026c b612          	ld	a,_H_letter
3860  026e ae0300        	ldw	x,#768
3861  0271 97            	ld	xl,a
3862  0272 cd00d0        	call	_segm_latch
3864  0275               L3722:
3865                     ; 257 			buzzer_beep();
3867  0275 cd0136        	call	_buzzer_beep
3870  0278 ac890189      	jpf	L7522
4041                     	xdef	_main
4042                     	xdef	_buzzer_beep
4043                     	xdef	_time_overflow
4044                     	xdef	_segm_next
4045                     	xdef	_segm_latch
4046                     	xdef	_segm_shift
4047                     	xdef	_delay
4048                     	xdef	_time_update_value
4049                     	xdef	_buzzer_init
4050                     	xdef	_segm_init
4051                     	xdef	_S_init
4052                     	xdef	_TIM4_init
4053                     	switch	.ubsct
4054  0000               _segm_pos:
4055  0000 00            	ds.b	1
4056                     	xdef	_segm_pos
4057  0001               _segm_val:
4058  0001 00000000      	ds.b	4
4059                     	xdef	_segm_val
4060                     	xdef	_M_letter
4061                     	xdef	_S_letter
4062                     	xdef	_H_letter
4063                     	xdef	_segm_dec
4064  0005               _tick_msec:
4065  0005 0000          	ds.b	2
4066                     	xdef	_tick_msec
4067  0007               _second_hour:
4068  0007 0000          	ds.b	2
4069                     	xdef	_second_hour
4070  0009               _first_hour:
4071  0009 0000          	ds.b	2
4072                     	xdef	_first_hour
4073  000b               _second_min:
4074  000b 0000          	ds.b	2
4075                     	xdef	_second_min
4076  000d               _first_min:
4077  000d 0000          	ds.b	2
4078                     	xdef	_first_min
4079  000f               _second_sec:
4080  000f 0000          	ds.b	2
4081                     	xdef	_second_sec
4082  0011               _first_sec:
4083  0011 0000          	ds.b	2
4084                     	xdef	_first_sec
4085                     	xdef	_hours_prev
4086                     	xdef	_hours_passed
4087                     	xdef	_min_passed
4088                     	xdef	_sec_passed
4089                     	xref.b	c_x
4109                     	xref	c_smodx
4110                     	xref	c_sdivx
4111                     	end
