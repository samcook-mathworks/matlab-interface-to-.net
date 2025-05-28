// Copyright The MathWorks 2025
using System;

namespace MyAssembly
{
    public class GenericMethods
    {
        public T DisplayAndReturn<T>(T value)
        {
            Console.WriteLine(value);
            return value;
        }

        public static T StaticDisplayAndReturn<T>(T value)
        {
            Console.WriteLine(value);
            return value;
        }
    }

    public class GenericClass<TOut>
    {
        public static TOut StaticDisplayAndReturn<TIn>(TIn value)
        {
            Console.WriteLine(value);
            return (TOut)Convert.ChangeType(value, typeof(TOut));
        }
    }
}
