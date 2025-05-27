// Copyright The MathWorks 2025
using System;

namespace MyAssembly
{
    public class GenericMethods
    {
        public double Value { get; set; }
        public GenericMethods(double value)
        {
            Value = value;
        }
        
        // Converts the object to the specified type
        public T ConvertTo<T>()
        {
            return (T)Convert.ChangeType(Value, typeof(T));
        }

        // Sets the value of the object and returns its old value
        public double Swap<T>(T newValue)
        {
            double tmp = Value;
            Value = Convert.ToDouble(newValue);
            return tmp;
        }
    }
}
