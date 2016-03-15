#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define MinMax 4
#define FiveMinMax 11
#define HourMax 11
#define MainMax 128        // Maximum balls + 1
#define MainMin 27         // MinMax + FiveMinMax + HourMax + 1
#define MinPerHalfDay 720 // Minutes per 12 hours

//Structure describing the current state of the ball clock

struct ballclock
{
  int numMin;               //ball count in minute track
  int numFiveMin;             //ball count in five-minute track
  int numHour;                 //ball count in hour track
  int numMain;                 //ball count in main track
  int Min[MinMax];     //ball #s in minute track
  int FiveMin[FiveMinMax]; //ball #s in five-minute track
  int Hour[HourMax];    //ball #s in hour track
  int Main[MainMax];    //ball #s in main track
};

int compareClocks(struct ballclock b1, struct ballclock b2);
int compareClocks(struct ballclock b1, struct ballclock b2)
{
  int ii;
  for(ii = 0; ii < b1.numMain; ii++) {
    if (b1.Main[ii] != b2.Main[ii]) return 0;
  }
  return 1;
}

  
  
//Initialize the ball clock with all balls in main track
void initialize (struct ballclock *b);
void initialize (struct ballclock *b)
{
  int i;
  b->numMin = 0;
  b->numFiveMin = 0;
  b->numHour = 0;
  for (i=0; i < b->numMain; i++) b->Main[i] = i+1;
}

/*
   Print out the current state of the ball clock in JSON format.  While there
   is almost certainly an easier way to do this, for a one-off this was a lot
   quicker than spending hours fussing over documentation
*/
void  printJSON(struct ballclock b);
void  printJSON(struct ballclock b)
{
  int i;
  printf("{\"Min\":[");
  if (b.numMin > 0)
    {
      printf("%d", b.Min[0]);
      for ( i = 1; i < b.numMin; i++) printf(",%d", b.Min[i]);
    }
  printf("],\"FiveMin\":[");
  if (b.numFiveMin > 0)
    {
      printf("%d", b.FiveMin[0]);
      for ( i = 1; i < b.numFiveMin; i++ ) printf(",%d", b.FiveMin[i]);
    }
  printf("],\"Hour\":[");
  if (b.numHour > 0)
    {
      printf("%d", b.Hour[0]);
      for ( i = 1; i < b.numHour; i++) printf(",%d", b.Hour[i]);
    }
  printf("],\"Main\":[");
  if (b.numMain > 0)
    {
      printf("%d", b.Main[0]);
      for (i = 1; i < b.numMain; i++) printf(",%d", b.Main[i]);
    }
  printf("]}\n");
}

// Advance the ball clock by one minute
void advance (struct ballclock *b);
void advance (struct ballclock *b)
{
  int i=0, hotball;

  // The ball in motion -- the hotball

  hotball = b->Main[0];

  // Move the balls in the main track down one position

  for (i = 0; i < b->numMain; i++) b->Main[i] = b->Main[i+1];
  b->numMain--;

  // Drop the hotball in the minute track

  if (b->numMin < MinMax)
    {
      b->Min[b->numMin] = hotball;
      b->numMin++;
    }
  else
    {
      // Return the minute track balls to the main track
      for (i=0; i < MinMax; i++ )
	{
	  b->Main[b->numMain+i] = b->Min[MinMax-i-1];
	  b->Min[MinMax-i-1] = 0;
	}
      b->numMin = 0;
      b->numMain += MinMax;

      // Drop the hotball in the five minute track

      if (b->numFiveMin < FiveMinMax)
	{
	  b->FiveMin[b->numFiveMin] = hotball;
	  b->numFiveMin++;
	}
      else
	{
	  // Return the five minute balls to the main track
	 
	  for (i = 0; i < FiveMinMax; i++)
	    {
	      b->Main[b->numMain+i] = b->FiveMin[FiveMinMax-i-1];
	      b->FiveMin[FiveMinMax-i-1] = 0;
	    }
	  b->numFiveMin = 0;
	  b->numMain += FiveMinMax;

	  // Drop the hotball in the hour track
	  
	  if (b->numHour < HourMax)
	    {
	      b->Hour[b->numHour] = hotball;
	      b->numHour++;
	    }
	  else
	    {
	      // Return the hour balls to the main track
	      for (i = 0; i < HourMax; i++)
		{
		  b->Main[b->numMain+i] = b->Hour[HourMax-i-1];
		  b->Hour[HourMax-i-1] = 0;
		}
	      b->numHour = 0;
	      b->numMain += HourMax;

	      // Return the hotball to the main track

	      b->Main[b->numMain] = hotball;
	      b->numMain++;
	    }
	}
    }
}

int main (int argc, char *argv[])
{
  // Parse the command line
  int i, numBall, numAdvance;
  float days;
  struct ballclock b, bstart;
  if (argc < 2 || argc > 3)
    {
      fprintf(stderr, "Usage: ballclock <number of balls> [<minutes>]\n");
      exit(2);
    }

  // Make sure the numBall variable is an integer

  if (!sscanf(argv[1], "%d", &numBall))
    {
      fprintf(stderr, "Please enter an integer number of balls\n");
      exit(2);
    }

	// Make sure the numBall variable is in the range [27,127]

  if (numBall < MainMin)
    {
      printf("Not enough balls!\n");
      exit(2);
    }
  else if (numBall > MainMax-1)
    {
      printf("Too many balls!\n");
      exit(2);
    }

	// Initialize the ball clock

  b.numMain = numBall;
  initialize(&b);

	// Initialize a second ball clock to preserve the starting point

 bstart.numMain = numBall;
 initialize(&bstart);

 // Consider case where number of minutes is specified

 if (argc == 3)
   {
     
     // Make sure variable numAdvance is an integer
     if (!sscanf(argv[2], "%d", &numAdvance))
       {
	 fprintf(stderr, "Please enter an integer number of minutes\n");
	 exit(2);
       }
  
     // Advance ball clock by NumAdvance minutes or until it cycles

     for (i = 0; i < numAdvance; i++)
       {
	 advance(&b);
	 if (b.numMain == numBall)
	   {
	     if (compareClocks(b, bstart))
	       {
		 break;
	       }
	   }
       }
     i++;
     
     // If clock cycles subtract the number of full cycles from
     // numAdvance and then advance clock rest of the way

     if (i < numAdvance)
       {
	 numAdvance = (int)fmod((float)numAdvance, (float)i);
	 for (i = 0; i < numAdvance; i++) advance(&b);
       }
     // Print result in JSON and exit
     printJSON(b);
     exit(0);
   }

 for ( i = 0; i < MinPerHalfDay; i++) advance(&b);
 days = 0.5;

 // Advance 12 hours at a time until it cycles
 
 while (!compareClocks(b, bstart))
   {
     for (i = 0; i < MinPerHalfDay; i++) advance(&b);
     days += 0.5;
   }
 printf("%d balls cycle after %g days.\n", numBall, days);
 printJSON(b);
 exit(0);
}
