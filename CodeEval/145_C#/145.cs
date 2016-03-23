using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;


class Program
{
    static void Main(string[] args)
    {
        int i=0,j=0,k=0,totVote=0,cost=0,stateVote=0;
        int nState=51;
        int winVote=270;
        int winCost=1000000000;
        var nVote = new int[nState];
        StreamReader reader = File.OpenText(args[0]);
        string line = reader.ReadLine();
        string[] data = line.Split(':');
        int nIssue = Int32.Parse(data[1]);
        var costIssue = new int[nIssue];
        var nameIssue = new string[nIssue];
        var winList = new int[nIssue];
        var nVoteIssue = new int[nState,nIssue];
        line = reader.ReadLine();
        for (i = 0; i < nIssue; i++)
        {
            line = reader.ReadLine();
            data = line.Split(':');
            nameIssue[i] = data[0];
            costIssue[i] = Int32.Parse(data[1]);
        }
        for (j = 0; j < nState; j++)
        {
            line = reader.ReadLine();
            line = reader.ReadLine();
            line = reader.ReadLine();
            data = line.Split(':');
            nVote[j] = Int32.Parse(data[1]);
            for (i = 0; i < nIssue; i++)
            {
                line = reader.ReadLine();
                data = line.Split(':');
                string nametmp = data[0];
                for (k = 0; k < nIssue; k++)
                    if (nameIssue[k] == nametmp)
                        break;
                nVoteIssue[j,k] = Int32.Parse(data[1]);
            }
        }
        for (i = 1; i <= nIssue; i++)
        {
            var numList = new int[nIssue];
            for (j = 0; j < i; j++) numList[nIssue-j-1] = 1;

            totVote = 0;
            for (j = 0; j < nState; j++)
            {
                stateVote = 0;
                for (k=0; k < nIssue; k++)
                    stateVote += nVoteIssue[j,k]*numList[k];
                if (stateVote > nVote[j]/2) totVote += nVote[j];
            }
            if (totVote >= winVote)
            {
                cost = 0;
                for  (k=0; k < nIssue; k++)
                    cost += numList[k]*costIssue[k];
                if (cost < winCost)
                {
                    Array.Copy(numList, winList, nIssue);
                    winCost = cost;
                }
            }

            while ( NextPermutation(numList))
            {
                totVote = 0;
                for (j = 0; j < nState; j++)
                {
                    stateVote = 0;
                    for (k=0; k < nIssue; k++)
                        stateVote += nVoteIssue[j,k]*numList[k];
                    if (stateVote > nVote[j]/2) totVote += nVote[j];
                }
                if (totVote >= winVote)
                {
                    cost = 0;
                    for  (k=0; k < nIssue; k++)
                        cost += numList[k]*costIssue[k];
                    if (cost < winCost)
                    {
                        Array.Copy(numList, winList, nIssue);
                        winCost = cost;
                    }

                }
            }
            if (winCost < 1000000000) break;
        }
        var winIssue = new string[i];
        j=0;
        for(k=0; k < nIssue; k++)
        {
            if (winList[k] > 0)
            {
                winIssue[j] = nameIssue[k];
                j++;
            }
        }
        Array.Sort(winIssue);
        for (j=0; j < i; j++) Console.WriteLine(winIssue[j]);
    }

    private static bool NextPermutation(int[] numList)
    {
        var largestIndex = -1;
        for (var i = numList.Length - 2; i >= 0; i--)
        {
            if (numList[i] < numList[i + 1]) {
                largestIndex = i;
                break;
            }
        }

        if (largestIndex < 0) return false;

        var largestIndex2 = -1;
        for (var i = numList.Length - 1 ; i >= 0; i--) {
            if (numList[largestIndex] < numList[i]) {
                largestIndex2 = i;
                break;
            }
        }

        var tmp = numList[largestIndex];
        numList[largestIndex] = numList[largestIndex2];
        numList[largestIndex2] = tmp;

        for (int i = largestIndex + 1, j = numList.Length - 1; i < j; i++, j--) {
            tmp = numList[i];
            numList[i] = numList[j];
            numList[j] = tmp;
        }

        return true;
    }
}
