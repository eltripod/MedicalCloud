package com.medical.dao;

import com.medical.model.CaseRecord;
import com.medical.model.Prescription;
import com.medical.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CaseRecordDAO {
    
    // 添加病例记录
    public boolean addCaseRecord(CaseRecord caseRecord) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // 开启事务
            
            // 插入病例主记录
            String sql = "INSERT INTO case_records (case_id, patient_id, doctor_id, visit_date, " +
                        "department, chief_complaint, present_illness, past_history, allergy_history, " +
                        "temperature, blood_pressure, heart_rate, respiratory, physical_exam, " +
                        "exam_items, exam_results, diagnosis, diagnosis_basis, treatment_principle, " +
                        "medical_advice, status, create_time, update_time) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, generateCaseId());
            stmt.setString(2, caseRecord.getPatientId());
            stmt.setString(3, caseRecord.getDoctorId());
            stmt.setDate(4, new java.sql.Date(caseRecord.getVisitDate().getTime()));
            stmt.setString(5, caseRecord.getDepartment());
            stmt.setString(6, caseRecord.getChiefComplaint());
            stmt.setString(7, caseRecord.getPresentIllness());
            stmt.setString(8, caseRecord.getPastHistory());
            stmt.setString(9, caseRecord.getAllergyHistory());
            stmt.setDouble(10, caseRecord.getTemperature() != null ? caseRecord.getTemperature() : 0);
            stmt.setString(11, caseRecord.getBloodPressure());
            stmt.setInt(12, caseRecord.getHeartRate() != null ? caseRecord.getHeartRate() : 0);
            stmt.setInt(13, caseRecord.getRespiratory() != null ? caseRecord.getRespiratory() : 0);
            stmt.setString(14, caseRecord.getPhysicalExam());
            stmt.setString(15, caseRecord.getExamItems());
            stmt.setString(16, caseRecord.getExamResults());
            stmt.setString(17, caseRecord.getDiagnosis());
            stmt.setString(18, caseRecord.getDiagnosisBasis());
            stmt.setString(19, caseRecord.getTreatmentPrinciple());
            stmt.setString(20, caseRecord.getMedicalAdvice());
            stmt.setString(21, caseRecord.getStatus());
            
            stmt.executeUpdate();
            
            // 插入处方记录
            if (caseRecord.getPrescriptions() != null && !caseRecord.getPrescriptions().isEmpty()) {
                String prescriptionSql = "INSERT INTO prescriptions (prescription_id, case_id, " +
                                        "medicine_name, dosage, frequency, days, quantity) " +
                                        "VALUES (?, ?, ?, ?, ?, ?, ?)";
                
                PreparedStatement prescStmt = conn.prepareStatement(prescriptionSql);
                for (Prescription prescription : caseRecord.getPrescriptions()) {
                    prescStmt.setString(1, generatePrescriptionId());
                    prescStmt.setString(2, caseRecord.getCaseId());
                    prescStmt.setString(3, prescription.getMedicineName());
                    prescStmt.setString(4, prescription.getDosage());
                    prescStmt.setString(5, prescription.getFrequency());
                    prescStmt.setInt(6, prescription.getDays());
                    prescStmt.setString(7, prescription.getQuantity());
                    prescStmt.addBatch();
                }
                prescStmt.executeBatch();
            }
            
            conn.commit(); // 提交事务
            return true;
            
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback(); // 回滚事务
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // 获取患者的所有病例记录
    public List<CaseRecord> getCaseRecordsByPatientId(String patientId) {
        List<CaseRecord> caseRecords = new ArrayList<>();
        String sql = "SELECT * FROM case_records WHERE patient_id = ? ORDER BY visit_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, patientId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                CaseRecord record = new CaseRecord();
                record.setCaseId(rs.getString("case_id"));
                record.setPatientId(rs.getString("patient_id"));
                record.setDoctorId(rs.getString("doctor_id"));
                record.setVisitDate(rs.getDate("visit_date"));
                record.setDepartment(rs.getString("department"));
                record.setChiefComplaint(rs.getString("chief_complaint"));
                record.setPresentIllness(rs.getString("present_illness"));
                record.setPastHistory(rs.getString("past_history"));
                record.setAllergyHistory(rs.getString("allergy_history"));
                record.setTemperature(rs.getDouble("temperature"));
                record.setBloodPressure(rs.getString("blood_pressure"));
                record.setHeartRate(rs.getInt("heart_rate"));
                record.setRespiratory(rs.getInt("respiratory"));
                record.setPhysicalExam(rs.getString("physical_exam"));
                record.setExamItems(rs.getString("exam_items"));
                record.setExamResults(rs.getString("exam_results"));
                record.setDiagnosis(rs.getString("diagnosis"));
                record.setDiagnosisBasis(rs.getString("diagnosis_basis"));
                record.setTreatmentPrinciple(rs.getString("treatment_principle"));
                record.setMedicalAdvice(rs.getString("medical_advice"));
                record.setStatus(rs.getString("status"));
                record.setCreateTime(rs.getTimestamp("create_time"));
                record.setUpdateTime(rs.getTimestamp("update_time"));
                
                // 获取处方信息
                record.setPrescriptions(getPrescriptionsByCaseId(record.getCaseId()));
                
                caseRecords.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return caseRecords;
    }
    
    // 获取病例的处方信息
    private List<Prescription> getPrescriptionsByCaseId(String caseId) {
        List<Prescription> prescriptions = new ArrayList<>();
        String sql = "SELECT * FROM prescriptions WHERE case_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, caseId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Prescription prescription = new Prescription();
                prescription.setPrescriptionId(rs.getString("prescription_id"));
                prescription.setCaseId(rs.getString("case_id"));
                prescription.setMedicineName(rs.getString("medicine_name"));
                prescription.setDosage(rs.getString("dosage"));
                prescription.setFrequency(rs.getString("frequency"));
                prescription.setDays(rs.getInt("days"));
                prescription.setQuantity(rs.getString("quantity"));
                prescriptions.add(prescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return prescriptions;
    }
    
    // 更新病例状态
    public boolean updateCaseStatus(String caseId, String status) {
        String sql = "UPDATE case_records SET status = ?, update_time = NOW() WHERE case_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, caseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 生成病例ID
    private String generateCaseId() {
        return "CR" + System.currentTimeMillis();
    }
    
    // 生成处方ID
    private String generatePrescriptionId() {
        return "RX" + System.currentTimeMillis();
    }
}