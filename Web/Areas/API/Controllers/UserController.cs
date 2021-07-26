using System;
using System.Web.Mvc;
using Model.DAO;
using Web.Global;

namespace Web.Areas.API.Controllers
{
    public class UserController : Controller
    {
        [HttpPost]
        public JsonResult Login(string username, string password, int type = 0)
        {
            if (type == 0)
            {
                StudentDAO dao = new StudentDAO();

                int status = dao.Login(username, Encryptor.MD5Hash(password));
                if (status == 1)
                {
                    var student = dao.Get(username);
                    var user = new User();
                    user.Username = student.Id;
                    user.Avatar = student.Avatar;
                    user.FullName = student.FullName;
                    user.Gender = student.Gender;

                    Session[Constants.USER] = user;

                    return Json(new
                    {
                        status = status,
                        data = student
                    });
                } else
                {
                    return Json(new
                    {
                        status = status
                    });
                }
            } else if (type == 1)
            {
                StaffDAO dao = new StaffDAO();

                int status = dao.Login(username, Encryptor.MD5Hash(password));
                if (status == 1)
                {
                    var staff = dao.Get(username);
                    var user = new User();
                    user.Username = staff.Id;
                    user.Avatar = staff.Avatar;
                    user.FullName = staff.FullName;
                    user.Gender = staff.Gender;

                    Session[Constants.ADMIN] = user;

                    return Json(new
                    {
                        status = status,
                        data = staff
                    });
                }
                else
                {
                    return Json(new
                    {
                        status = status
                    });
                }
            } else
            {
                return Json(new
                {
                    status = -1
                });
            }
        }

        [HttpPost]
        public JsonResult Logout(int type = 0)
        {
            if (type == 0)
            {
                Session[Constants.USER] = null;
            } else
            {
                Session[Constants.ADMIN] = null;
            }

            return Json(new
            {
                status = 1
            });
        }
    }
}