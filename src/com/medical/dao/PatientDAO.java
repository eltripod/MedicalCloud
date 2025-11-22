package com.medical.dao;

import com.medical.model.Patient;
import com.medical.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {
    
    // 获取所有患者
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patients ORDER BY create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientId(rs.getString("patient_id"));
                patient.setName(rs.getString("name"));
                patient.setGender(rs.getString("gender"));
                patient.setBirthDate(rs.getDate("birth_date"));
                patient.setAge(calculateAge(rs.getDate("birth_date")));
                patient.setIdCard(rs.getString("id_card"));
                patient.setPhone(rs.getString("phone"));
                patient.setAddress(rs.getString("address"));
                patient.setInsuranceType(rs.getString("insurance_type"));
                patient.setEmergencyContact(rs.getString("emergency_contact"));
                patient.setEmergencyPhone(rs.getString("emergency_phone"));
                patient.setAllergyHistory(rs.getString("allergy_history"));
                patient.setStatus(rs.getString("status"));
                patient.setCreateTime(rs.getTimestamp("create_time"));
                patient.setUpdateTime(rs.getTimestamp("update_time"));
                patients.add(patient);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return patients;
    }
    
    // 根据ID获取患者
    public Patient getPatientById(String patientId) {
        String sql = "SELECT * FROM patients WHERE patient_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, patientId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientId(rs.getString("patient_id"));
                patient.setName(rs.getString("name"));
                patient.setGender(rs.getString("gender"));
                patient.setBirthDate(rs.getDate("birth_date"));
                patient.setAge(calculateAge(rs.getDate("birth_date")));
                patient.setIdCard(rs.getString("id_card"));
                patient.setPhone(rs.getString("phone"));
                patient.setAddress(rs.getString("address"));
                patient.setInsuranceType(rs.getString("insurance_type"));
                patient.setEmergencyContact(rs.getString("emergency_contact"));
                patient.setEmergencyPhone(rs.getString("emergency_phone"));
                patient.setAllergyHistory(rs.getString("allergy_history"));
                patient.setStatus(rs.getString("status"));
                patient.setCreateTime(rs.getTimestamp("create_time"));
                patient.setUpdateTime(rs.getTimestamp("update_time"));
                return patient;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // 添加患者
    public boolean addPatient(Patient patient) {
        String sql = "INSERT INTO patients (patient_id, name, gender, birth_date, id_card, " +
                     "phone, address, insurance_type, emergency_contact, emergency_phone, " +
                     "allergy_history, status, create_time, update_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, generatePatientId());
            stmt.setString(2, patient.getName());
            stmt.setString(3, patient.getGender());
            stmt.setDate(4, new java.sql.Date(patient.getBirthDate().getTime()));
            stmt.setString(5, patient.getIdCard());
            stmt.setString(6, patient.getPhone());
            stmt.setString(7, patient.getAddress());
            stmt.setString(8, patient.getInsuranceType());
            stmt.setString(9, patient.getEmergencyContact());
            stmt.setString(10, patient.getEmergencyPhone());
            stmt.setString(11, patient.getAllergyHistory());
            stmt.setString(12, "active");
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 更新患者信息
    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE patients SET name=?, gender=?, birth_date=?, id_card=?, " +
                     "phone=?, address=?, insurance_type=?, emergency_contact=?, " +
                     "emergency_phone=?, allergy_history=?, update_time=NOW() " +
                     "WHERE patient_id=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, patient.getName());
            stmt.setString(2, patient.getGender());
            stmt.setDate(3, new java.sql.Date(patient.getBirthDate().getTime()));
            stmt.setString(4, patient.getIdCard());
            stmt.setString(5, patient.getPhone());
            stmt.setString(6, patient.getAddress());
            stmt.setString(7, patient.getInsuranceType());
            stmt.setString(8, patient.getEmergencyContact());
            stmt.setString(9, patient.getEmergencyPhone());
            stmt.setString(10, patient.getAllergyHistory());
            stmt.setString(11, patient.getPatientId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 删除患者
    public boolean deletePatient(String patientId) {
        String sql = "DELETE FROM patients WHERE patient_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, patientId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 搜索患者
    public List<Patient> searchPatients(String keyword) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patients WHERE name LIKE ? OR phone LIKE ? OR id_card LIKE ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Patient patient = new Patient();
                // 设置患者属性...
                patients.add(patient);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return patients;
    }
    
    // 生成患者ID
    private String generatePatientId() {
        return "P" + System.currentTimeMillis();
    }
    
    // 计算年龄
    private int calculateAge(Date birthDate) {
        if (birthDate == null) return 0;
        long ageInMillis = System.currentTimeMillis() - birthDate.getTime();
        return (int) (ageInMillis / (365.25 * 24 * 60 * 60 * 1000));
    }
}