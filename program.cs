using System;
using System.Collections.Generic;

class Program
{
    static void Main(string[] args)
    {
        List<string> sortedList = new List<string>(); // создаем пустой список

        while (true) // бесконечный цикл
        {
            Console.WriteLine("Введите информацию:"); // просим пользователя ввести информацию
            string input = Console.ReadLine(); // считываем введенную информацию

            if (input == "") // если пользователь нажал Enter без ввода информации, выходим из цикла
            {
                break;
            }

            sortedList.Add(input); // добавляем введенную информацию в список
            sortedList.Sort(); // сортируем список по алфавиту
        }

        Console.WriteLine("\nСписок:"); // выводим отсортированный список на экран
        foreach (string item in sortedList)
        {
            Console.WriteLine(item);
        }
    }
}
