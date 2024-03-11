   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.9 - 19 Apr 2023
   3                     ; Generator (Limited) V4.5.6 - 18 Jul 2023
2804                     ; 15 @far @interrupt void NonHandledInterrupt (void)
2804                     ; 16 {
2805                     	switch	.text
2806  0000               f_NonHandledInterrupt:
2810                     ; 20 	return;
2813  0000 80            	iret
2837                     ; 27 @far @interrupt void TIM4_interrupt(void)
2837                     ; 28 {
2838                     	switch	.text
2839  0001               f_TIM4_interrupt:
2843                     ; 29 	TIM4_SR &=~(1<<0);
2845  0001 72115342      	bres	_TIM4_SR,#0
2846                     ; 30 	tick_msec++;
2848  0005 be00          	ldw	x,_tick_msec
2849  0007 1c0001        	addw	x,#1
2850  000a bf00          	ldw	_tick_msec,x
2851                     ; 31 	return;
2854  000c 80            	iret
2856                     .const:	section	.text
2857  0000               __vectab:
2858  0000 82            	dc.b	130
2860  0001 00            	dc.b	page(__stext)
2861  0002 0000          	dc.w	__stext
2862  0004 82            	dc.b	130
2864  0005 00            	dc.b	page(f_NonHandledInterrupt)
2865  0006 0000          	dc.w	f_NonHandledInterrupt
2866  0008 82            	dc.b	130
2868  0009 00            	dc.b	page(f_NonHandledInterrupt)
2869  000a 0000          	dc.w	f_NonHandledInterrupt
2870  000c 82            	dc.b	130
2872  000d 00            	dc.b	page(f_NonHandledInterrupt)
2873  000e 0000          	dc.w	f_NonHandledInterrupt
2874  0010 82            	dc.b	130
2876  0011 00            	dc.b	page(f_NonHandledInterrupt)
2877  0012 0000          	dc.w	f_NonHandledInterrupt
2878  0014 82            	dc.b	130
2880  0015 00            	dc.b	page(f_NonHandledInterrupt)
2881  0016 0000          	dc.w	f_NonHandledInterrupt
2882  0018 82            	dc.b	130
2884  0019 00            	dc.b	page(f_NonHandledInterrupt)
2885  001a 0000          	dc.w	f_NonHandledInterrupt
2886  001c 82            	dc.b	130
2888  001d 00            	dc.b	page(f_NonHandledInterrupt)
2889  001e 0000          	dc.w	f_NonHandledInterrupt
2890  0020 82            	dc.b	130
2892  0021 00            	dc.b	page(f_NonHandledInterrupt)
2893  0022 0000          	dc.w	f_NonHandledInterrupt
2894  0024 82            	dc.b	130
2896  0025 00            	dc.b	page(f_NonHandledInterrupt)
2897  0026 0000          	dc.w	f_NonHandledInterrupt
2898  0028 82            	dc.b	130
2900  0029 00            	dc.b	page(f_NonHandledInterrupt)
2901  002a 0000          	dc.w	f_NonHandledInterrupt
2902  002c 82            	dc.b	130
2904  002d 00            	dc.b	page(f_NonHandledInterrupt)
2905  002e 0000          	dc.w	f_NonHandledInterrupt
2906  0030 82            	dc.b	130
2908  0031 00            	dc.b	page(f_NonHandledInterrupt)
2909  0032 0000          	dc.w	f_NonHandledInterrupt
2910  0034 82            	dc.b	130
2912  0035 00            	dc.b	page(f_NonHandledInterrupt)
2913  0036 0000          	dc.w	f_NonHandledInterrupt
2914  0038 82            	dc.b	130
2916  0039 00            	dc.b	page(f_NonHandledInterrupt)
2917  003a 0000          	dc.w	f_NonHandledInterrupt
2918  003c 82            	dc.b	130
2920  003d 00            	dc.b	page(f_NonHandledInterrupt)
2921  003e 0000          	dc.w	f_NonHandledInterrupt
2922  0040 82            	dc.b	130
2924  0041 00            	dc.b	page(f_NonHandledInterrupt)
2925  0042 0000          	dc.w	f_NonHandledInterrupt
2926  0044 82            	dc.b	130
2928  0045 00            	dc.b	page(f_NonHandledInterrupt)
2929  0046 0000          	dc.w	f_NonHandledInterrupt
2930  0048 82            	dc.b	130
2932  0049 00            	dc.b	page(f_NonHandledInterrupt)
2933  004a 0000          	dc.w	f_NonHandledInterrupt
2934  004c 82            	dc.b	130
2936  004d 00            	dc.b	page(f_NonHandledInterrupt)
2937  004e 0000          	dc.w	f_NonHandledInterrupt
2938  0050 82            	dc.b	130
2940  0051 00            	dc.b	page(f_NonHandledInterrupt)
2941  0052 0000          	dc.w	f_NonHandledInterrupt
2942  0054 82            	dc.b	130
2944  0055 00            	dc.b	page(f_NonHandledInterrupt)
2945  0056 0000          	dc.w	f_NonHandledInterrupt
2946  0058 82            	dc.b	130
2948  0059 00            	dc.b	page(f_NonHandledInterrupt)
2949  005a 0000          	dc.w	f_NonHandledInterrupt
2950  005c 82            	dc.b	130
2952  005d 00            	dc.b	page(f_NonHandledInterrupt)
2953  005e 0000          	dc.w	f_NonHandledInterrupt
2954  0060 82            	dc.b	130
2956  0061 00            	dc.b	page(f_NonHandledInterrupt)
2957  0062 0000          	dc.w	f_NonHandledInterrupt
2958  0064 82            	dc.b	130
2960  0065 01            	dc.b	page(f_TIM4_interrupt)
2961  0066 0001          	dc.w	f_TIM4_interrupt
2962  0068 82            	dc.b	130
2964  0069 00            	dc.b	page(f_NonHandledInterrupt)
2965  006a 0000          	dc.w	f_NonHandledInterrupt
2966  006c 82            	dc.b	130
2968  006d 00            	dc.b	page(f_NonHandledInterrupt)
2969  006e 0000          	dc.w	f_NonHandledInterrupt
2970  0070 82            	dc.b	130
2972  0071 00            	dc.b	page(f_NonHandledInterrupt)
2973  0072 0000          	dc.w	f_NonHandledInterrupt
2974  0074 82            	dc.b	130
2976  0075 00            	dc.b	page(f_NonHandledInterrupt)
2977  0076 0000          	dc.w	f_NonHandledInterrupt
2978  0078 82            	dc.b	130
2980  0079 00            	dc.b	page(f_NonHandledInterrupt)
2981  007a 0000          	dc.w	f_NonHandledInterrupt
2982  007c 82            	dc.b	130
2984  007d 00            	dc.b	page(f_NonHandledInterrupt)
2985  007e 0000          	dc.w	f_NonHandledInterrupt
3036                     	xdef	__vectab
3037                     	xdef	f_TIM4_interrupt
3038                     	xref.b	_tick_msec
3039                     	xref	__stext
3040                     	xdef	f_NonHandledInterrupt
3059                     	end
