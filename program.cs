using System;
using System.Collections.Generic;

class Program
{
    static void Main(string[] args)
    {
        List<string> sortedList = new List<string>(); 
        while (true) 
        {
            Console.WriteLine("Введите информацию:"); 
            string input = Console.ReadLine(); 

            if (input == "") 
            {
                break;
            }

            sortedList.Add(input); 
            sortedList.Sort(); 
        }

        Console.WriteLine("\nСписок:"); 
        foreach (string item in sortedList)
        {
            Console.WriteLine(item);
        }
    }
}
