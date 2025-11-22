package com.medical.servlet;

import com.medical.dao.PatientDAO;
import com.medical.model.Patient;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/patient")
public class PatientServlet extends HttpServlet {
    
    private PatientDAO patientDAO = new PatientDAO();
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("list".equals(action) || action == null) {
            // 获取患者列表
            List<Patient> patients = patientDAO.getAllPatients();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/patient_manage.jsp").forward(request, response);
            
        } else if ("search".equals(action)) {
            // 搜索患者
            String keyword = request.getParameter("keyword");
            List<Patient> patients = patientDAO.searchPatients(keyword);
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/patient_manage.jsp").forward(request, response);
            
        } else if ("view".equals(action)) {
            // 查看患者详情
            String patientId = request.getParameter("patientId");
            Patient patient = patientDAO.getPatientById(patientId);
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/patient_detail.jsp").forward(request, response);
            
        } else if ("edit".equals(action)) {
            // 编辑患者信息页面
            String patientId = request.getParameter("patientId");
            Patient patient = patientDAO.getPatientById(patientId);
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/patient_form.jsp").forward(request, response);
            
        } else if ("delete".equals(action)) {
            // 删除患者
            String patientId = request.getParameter("patientId");
            boolean success = patientDAO.deletePatient(patientId);
            
            if (success) {
                request.setAttribute("successMessage", "患者删除成功");
            } else {
                request.setAttribute("errorMessage", "患者删除失败");
            }
            
            List<Patient> patients = patientDAO.getAllPatients();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/patient_manage.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // 添加患者
            Patient patient = new Patient();
            patient.setName(request.getParameter("name"));
            patient.setGender(request.getParameter("gender"));
            
            try {
                patient.setBirthDate(sdf.parse(request.getParameter("birthDate")));
            } catch (ParseException e) {
                e.printStackTrace();
            }
            
            patient.setIdCard(request.getParameter("idCard"));
            patient.setPhone(request.getParameter("phone"));
            patient.setAddress(request.getParameter("address"));
            patient.setInsuranceType(request.getParameter("insurance"));
            patient.setEmergencyContact(request.getParameter("emergencyContact"));
            patient.setEmergencyPhone(request.getParameter("emergencyPhone"));
            patient.setAllergyHistory(request.getParameter("allergy"));
            
            boolean success = patientDAO.addPatient(patient);
            
            if (success) {
                request.setAttribute("successMessage", "患者添加成功");
            } else {
                request.setAttribute("errorMessage", "患者添加失败");
            }
            
            response.sendRedirect("patient?action=list");
            
        } else if ("update".equals(action)) {
            // 更新患者信息
            Patient patient = new Patient();
            patient.setPatientId(request.getParameter("patientId"));
            patient.setName(request.getParameter("name"));
            patient.setGender(request.getParameter("gender"));
            
            try {
                patient.setBirthDate(sdf.parse(request.getParameter("birthDate")));
            } catch (ParseException e) {
                e.printStackTrace();
            }
            
            patient.setIdCard(request.getParameter("idCard"));
            patient.setPhone(request.getParameter("phone"));
            patient.setAddress(request.getParameter("address"));
            patient.setInsuranceType(request.getParameter("insurance"));
            patient.setEmergencyContact(request.getParameter("emergencyContact"));
            patient.setEmergencyPhone(request.getParameter("emergencyPhone"));
            patient.setAllergyHistory(request.getParameter("allergy"));
            
            boolean success = patientDAO.updatePatient(patient);
            
            if (success) {
                request.setAttribute("successMessage", "患者信息更新成功");
            } else {
                request.setAttribute("errorMessage", "患者信息更新失败");
            }
            
            response.sendRedirect("patient?action=list");
        }
    }
}