using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;

namespace Web.Areas.API.Controllers
{
    public class AuthorController : Controller
    {
        AuthorDAO dao = new AuthorDAO();

        [HttpGet]
        public JsonResult Gets(string key = "", int page = 1, int pageSize = 5)
        {
            try
            {
                List<Author> data = dao.Gets(key, page, pageSize);
                int totalRow = dao.Count(key);

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
        public JsonResult Get(long id)
        {
            try
            {
                Author data = dao.Get(id);

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
        public JsonResult Insert(Author model)
        {
            try
            {
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
        public JsonResult Update(Author model)
        {
            try
            {
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

        [HttpDelete]
        public JsonResult Delete(long[] id)
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