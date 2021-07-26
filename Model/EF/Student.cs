using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.EF
{
    public class Student
    {
        public string Id { set; get; }
        public string Password { set; get; }
        public string Avatar { set; get; }
        public string FullName { set; get; }
        public string Gender { set; get; }
        public string Birthday { set; get; }
        public string Address { set; get; }
        public string Phone { set; get; }
        public string Email { set; get; }
        public string Class { set; get; }
        public int Status { set; get; }
    }
}
