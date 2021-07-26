using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Model.EF;
using Model.DAO;

namespace Web.Areas.API.Controllers
{
    public class BorrowController : Controller
    {
        BorrowDAO dao = new BorrowDAO();

        [HttpGet]
        public JsonResult Gets(long id = 0, string student = "", string staff = "", string book = "", string borrowDate = "", string returnDate = "", int status = 2, int page = 1, int pageSize = 5)
        {
            try
            {
                List<Borrow> data = dao.Gets(id, student, staff, book, borrowDate, returnDate, status, page, pageSize);
                int totalRow = dao.Count(id, student, staff, book, borrowDate, returnDate, status);

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
                Borrow data = dao.Get(id);

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

        [HttpGet]
        public JsonResult GetQuantity(string startDate = "", string endDate = "", int type = 2)
        {
            try
            {
                int[] data = dao.GetQuantity(startDate, endDate, type);

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

        [HttpGet]
        public JsonResult GetTopBook(int top = 5, string startDate = "", string endDate = "", int type = 0)
        {
            try
            {
                List<TopBook> data = dao.GetTopBook(top, startDate, endDate, type);

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

        [HttpGet]
        public JsonResult GetTopStudent(int top = 5, string startDate = "", string endDate = "", int type = 0)
        {
            try
            {
                List<TopStudent> data = dao.GetTopStudent(top, startDate, endDate, type);

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
        public JsonResult Insert(Borrow model)
        {
            try
            {
                int status =  dao.Insert(model);

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
        public JsonResult Update(Borrow model)
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

        [HttpPut]
        public JsonResult UpdateStatus(Borrow model)
        {
            try
            {
                int status = dao.UpdateStatus(model);

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