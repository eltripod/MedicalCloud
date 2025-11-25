package com.medical.servlet;

import com.medical.dao.CaseRecordDAO;
import com.medical.model.CaseRecord;
import com.medical.model.Prescription;
import com.medical.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/caseRecord")
public class CaseRecordServlet extends HttpServlet {
    
    private CaseRecordDAO caseRecordDAO = new CaseRecordDAO();
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User doctor = (User) session.getAttribute("user");
        
        // 检查是否是医生
        if (doctor == null || !"DOCTOR".equals(doctor.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("save".equals(action) || action == null) {
            // 保存病例
            CaseRecord caseRecord = new CaseRecord();
            caseRecord.setPatientId(request.getParameter("patientId"));
            caseRecord.setDoctorId(doctor.getUserId());
            
            try {
                caseRecord.setVisitDate(sdf.parse(request.getParameter("visitDate")));
            } catch (Exception e) {
                caseRecord.setVisitDate(new java.util.Date());
            }
            
            caseRecord.setDepartment(request.getParameter("department"));
            caseRecord.setChiefComplaint(request.getParameter("chiefComplaint"));
            caseRecord.setPresentIllness(request.getParameter("presentIllness"));
            caseRecord.setPastHistory(request.getParameter("pastHistory"));
            caseRecord.setAllergyHistory(request.getParameter("allergyHistory"));
            
            String temp = request.getParameter("temperature");
            if (temp != null && !temp.isEmpty()) {
                caseRecord.setTemperature(Double.parseDouble(temp));
            }
            
            caseRecord.setBloodPressure(request.getParameter("bloodPressure"));
            
            String heartRate = request.getParameter("heartRate");
            if (heartRate != null && !heartRate.isEmpty()) {
                caseRecord.setHeartRate(Integer.parseInt(heartRate));
            }
            
            String respiratory = request.getParameter("respiratory");
            if (respiratory != null && !respiratory.isEmpty()) {
                caseRecord.setRespiratory(Integer.parseInt(respiratory));
            }
            
            caseRecord.setPhysicalExam(request.getParameter("physicalExam"));
            
            // 处理检查项目
            String[] examItems = request.getParameterValues("examItems");
            if (examItems != null) {
                caseRecord.setExamItems(String.join(",", examItems));
            }
            
            caseRecord.setExamResults(request.getParameter("examResults"));
            caseRecord.setDiagnosis(request.getParameter("diagnosis"));
            caseRecord.setDiagnosisBasis(request.getParameter("diagnosisBasis"));
            caseRecord.setTreatmentPrinciple(request.getParameter("treatmentPrinciple"));
            caseRecord.setMedicalAdvice(request.getParameter("medicalAdvice"));
            
            // 设置状态
            String submitType = request.getParameter("submitType");
            if ("draft".equals(submitType)) {
                caseRecord.setStatus("draft");
            } else {
                caseRecord.setStatus("submitted");
            }
            
            // 处理处方药品
            String[] medicineNames = request.getParameterValues("medicineName[]");
            String[] medicineDosages = request.getParameterValues("medicineDosage[]");
            String[] medicineFrequencies = request.getParameterValues("medicineFrequency[]");
            String[] medicineDays = request.getParameterValues("medicineDays[]");
            String[] medicineQuantities = request.getParameterValues("medicineQuantity[]");
            
            List<Prescription> prescriptions = new ArrayList<>();
            if (medicineNames != null) {
                for (int i = 0; i < medicineNames.length; i++) {
                    if (medicineNames[i] != null && !medicineNames[i].trim().isEmpty()) {
                        Prescription prescription = new Prescription();
                        prescription.setMedicineName(medicineNames[i]);
                        prescription.setDosage(medicineDosages[i]);
                        prescription.setFrequency(medicineFrequencies[i]);
                        prescription.setDays(Integer.parseInt(medicineDays[i]));
                        prescription.setQuantity(medicineQuantities[i]);
                        prescriptions.add(prescription);
                    }
                }
            }
            caseRecord.setPrescriptions(prescriptions);
            
            // 保存病例记录
            boolean success = caseRecordDAO.addCaseRecord(caseRecord);
            
            if (success) {
                request.setAttribute("successMessage", "病例保存成功");
                response.sendRedirect("case_record.jsp?success=true");
            } else {
                request.setAttribute("errorMessage", "病例保存失败");
                request.getRequestDispatcher("/case_record.jsp").forward(request, response);
            }
        }
    }
}