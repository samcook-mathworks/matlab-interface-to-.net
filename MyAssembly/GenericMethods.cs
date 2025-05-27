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
        public T ConvertTo<T>()
        {
            return (T)Convert.ChangeType(Value, typeof(T));
        }
    }
}
