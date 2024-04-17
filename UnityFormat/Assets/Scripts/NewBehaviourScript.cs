using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Test
{
    internal class NewBehaviourScript : MonoBehaviour
    {
        private const float Pascal = 0.0f;

        protected void Awake()
        {
            Debug.LogError(Pascal);

            List<int> numbers = new();

            string line = string.Empty;
            using StreamReader reader = File.OpenText("numbers.txt");
            while ((line = reader.ReadLine()) != null)
            {
                if (int.TryParse(line, out int number))
                {
                    numbers.Add(number);
                }
            }
        }
    }
}