using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;
using Web.Global;

namespace Web.Areas.API.Controllers
{
    public class StudentController : Controller
    {
        StudentDAO dao = new StudentDAO();

        [HttpGet]
        public JsonResult Gets(string key = "", int status = 2, int page = 1, int pageSize = 5)
        {
            try
            {
                List<Student> data = dao.Gets(key, status, page, pageSize);
                int totalRow = dao.Count(key, status);

                return Json(new
                {
                    data = data,
                    totalRow = totalRow
                }, JsonRequestBehavior.AllowGet);
            } 
            catch (Exception)
            {
                return Json(new
                {
                    data = DBNull.Value.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult Get(string id)
        {
            try
            {
                Student data = dao.Get(id);

                return Json(new
                {
                    data = data
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    data = DBNull.Value.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult Insert(Student model)
        {
            try
            {
                model.Password = (model.Password == null ? Encryptor.MD5Hash(model.Id) : Encryptor.MD5Hash(model.Password));

                int status = dao.Insert(model);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpPut]
        public JsonResult Update(Student model)
        {
            try
            {
                model.Password = (model.Password == null ? "" : Encryptor.MD5Hash(model.Password));

                int status = dao.Update(model);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpPut]
        public JsonResult UpdateStatus(string id)
        {
            try
            {
                int status = dao.UpdateStatus(id);

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }

        [HttpDelete]
        public JsonResult Delete(string[] id)
        {
            try
            {
                int[] status = new int[id.Length];

                for (int i = 0; i < id.Length; i++)
                {
                    status[i] = dao.Delete(id[i]);
                }

                return Json(new
                {
                    status = status
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    status = 0
                });
            }
        }
    }
}