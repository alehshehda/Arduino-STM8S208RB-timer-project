/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include "stm8s208r.h"

int sec_passed = 50;
int min_passed = 59;
int hours_passed = 3;
int hours_prev = 0;
unsigned int first_sec, second_sec, first_min, second_min,
first_hour, second_hour, tick_msec;


/*  --7--
   |     |
  2|     |6
   |     |
    --1--
   |     |
  3|     |5
   |     |
    --4-- .0
*/
char segm_dec[10] = 
{// 76543210    76543210
  0b00000011, 0b10011111, 
  0b00100101, 0b00001101,
  0b10011001, 0b01001001,
  0b01000001, 0b00011111,
  0b00000001, 0b00001001,
};              //76543210       
char H_letter = 0b10010001;
char S_letter = 0b01001001;
char M_letter[2] =
 //76543210  	 76543210  
{0b00010011, 0b00010011};


char segm_val[4];
char segm_pos;


void TIM4_init(void)
{
	TIM4_PSCR = 3;
	TIM4_IER |= (1<<0);
	TIM4_CR1 |= (1<<0);
	TIM4_ARR = 249;
}

void S_init(void)
{
	PB_DDR &= ~(1<<4)|(1<<3)|(1<<2);
	PB_CR1 |= (1<<4)|(1<<3)|(1<<2);
	PB_CR2 &= ~(1<<4)|(1<<3)|(1<<2); 	
}

void segm_init(void)
{
  //PD3 OUT PP (SDI)
  PD_DDR |= 1<<3;
  PD_CR1 |= 1<<3;
  PD_CR2 |= 1<<3;

  //PC3 OUT PP (SFTCLK)
  PC_DDR |= 1<<3;
  PC_CR1 |= 1<<3;
  PC_CR2 |= 1<<3;

  //PG0 OUT PP (LCHCLK)
  PG_DDR |= 1<<0;
  PG_CR1 |= 1<<0;
  PG_CR2 |= 1<<0;
}

void buzzer_init(void)
{
	PC_DDR |= (1<<1);
	PC_CR1 |= (1<<1);
	PC_CR2 &= ~(1<<1);
}


void time_update_value(int num, unsigned int *first, unsigned int *second) 
{
    if (num >= 10 && num <= 59) {
        *first = num / 10;
        *second = num % 10;
    } else if (num >= 0 && num <= 9) {
        *first = 0;  
        *second = num;
    } else {
        *first = *second = 0;  
    }
}


void delay(int ms)
{
	tick_msec = 0;
	while(tick_msec<ms){}	
}


void segm_shift(char shift)
{
  char i;

  for (i = 0; i < 8; ++i)
  {			
    if (shift & 0x01)
      PD_ODR |= 1<<3;	//SDI=1
    else
      PD_ODR &= ~(1<<3); //SDI=0
			
    PC_ODR |= 1<<3; //SFTCLK=1
    PC_ODR &= ~(1<<3); //SFTCLK=0
			
    shift >>= 1;
  }
}

void segm_latch(char pos, char val)
{	
  segm_shift(val);
  segm_shift(0x80 >> pos);
	//0x80 = 0b10000000	
  PG_ODR |= 1<<0; //LCHCLK=1
  PG_ODR &= ~(1<<0); //LCHCLK=0
}

void segm_next(void)
{
  segm_latch(segm_pos, segm_val[segm_pos]);
  if (++segm_pos >= 4) segm_pos = 0;
}


void time_overflow(void)
{
		if (sec_passed == 60)
		{
			sec_passed = 0;
			min_passed += 1;
		}	
		if (min_passed == 60)
		{
			min_passed = 0;
			hours_passed += 1;
		}
		if (hours_passed == 12)
			hours_passed = 0;
		
		hours_prev = hours_passed - 1;
}

void buzzer_beep(void)
{
	if(min_passed == 0 && sec_passed < hours_passed) 
	{
		if(tick_msec < 100)
		{
			PC_ODR &= ~(1<<1);
		}
		else
		{
			PC_ODR |= (1<<1);
		}
	}
	else
	{
		if(min_passed == 0 && hours_passed == 0 && sec_passed < 12)
		{
			if(tick_msec < 100)
			{
				PC_ODR &= ~(1<<1);
			}
		else
		{
			PC_ODR |= (1<<1);
		}
		}
		else
		{
			PC_ODR |= (1<<1);
		}
	}	
}


void main(void)
{
	// inicjalizacja licznika, wyswietlacza i przyciskow
	TIM4_init();
	segm_init();
	buzzer_init();
	S_init();//sec dla S1, min dla S2, hours dla S3
	
	// inicializacja oblsugi przerwan	
	#asm
	rim
	#endasm
	
	while (1)
	{
			// przekraczanie sekund na minuty i minut na godziny
			time_overflow();
			
			// jezeli minela sekunda, zerujemy licznik
			// i obliczami wartosci do wyswietlania
			if (tick_msec == 1000)
			{
				sec_passed +=1;
				time_update_value(sec_passed, &first_sec, &second_sec);
				time_update_value(min_passed, &first_min, &second_min);
				time_update_value(hours_passed, &first_hour, &second_hour);
				tick_msec = 0;
			}
			
			// standartowo wyswietlamy sekundy
			if ( ((PB_IDR & (1<<4)) != 0 ) && ((PB_IDR & (1<<3)) != 0 ) && ((PB_IDR & (1<<2)) != 0 ) )
			{
				segm_latch(0, segm_dec[first_sec]);
				segm_latch(1, segm_dec[second_sec]);
				segm_latch(3, S_letter);
			}
			
			// s1 dla wyswietlania sekund
			if ((PB_IDR & (1<<4)) == 0) 
			{
				segm_latch(0, segm_dec[first_sec]);
				segm_latch(1, segm_dec[second_sec]);
				segm_latch(3, S_letter);
				PC_CR2 ^= (1<<1);

			}
			
			// s2 dla wyswietlania minut
			if ((PB_IDR & (1<<3)) == 0)
			{
				segm_latch(0, segm_dec[first_min]);
				segm_latch(1, segm_dec[second_min]);	
				segm_latch(2, M_letter[0]);
				segm_latch(3, M_letter[1]);
			}
			
			// s2 dla wyswietlania godzin
			if ((PB_IDR & (1<<2)) == 0)
			{
				segm_latch(0, segm_dec[first_hour]);
				segm_latch(1, segm_dec[second_hour]);
				segm_latch(3, H_letter);
			}
			
			buzzer_beep();
	}
}