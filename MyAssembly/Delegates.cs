using System;
namespace MyAssembly
{
    public delegate void RefStringDelegate(ref string refString);
    public delegate void OutDoubleDelegate(out double outDouble);

    public class DelegateExample
    {
        public static void StaticMethod() =>
            Console.WriteLine("StaticMethod");

        public void MyMethod() =>
            Console.WriteLine("MyMethod");

        public void StringMethod(string value) =>
            Console.WriteLine("value: {0}", value);

        public void InvokeAction(Action action) =>
            action();
    }
}
