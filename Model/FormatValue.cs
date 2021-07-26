using System.Text;
using System.Text.RegularExpressions;

namespace Model
{
    public class FormatValue
    {
        public static string ConvertToLink(string s)
        {
            Regex regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
            string temp = s.Normalize(NormalizationForm.FormD);
            string result = "";

            result = regex.Replace(temp, string.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D').ToLower();

            result = Regex.Replace(result, @"[^a-zA-Z0-9\s]", string.Empty);
            result = Regex.Replace(result, @"\s{2,}", " ");

            result = result.Replace(" ", "-");

            return result;
        }
    }
}