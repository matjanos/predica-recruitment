using System;

namespace Task2.Domain.Models
{
    public class Car
    {
        public string PlateNumber { get; set; }
        public string Color { get; set; }
        public DateTime FirstRegistration { get; set; }

        public Car (string plateNumber, string color, DateTime firstRegistration)
        {
            PlateNumber = plateNumber;
            Color = color;
            FirstRegistration = firstRegistration;
        }
    }
}