package com.medical.model;

import java.util.Date;
import java.util.List;

public class CaseRecord {
    private String caseId;
    private String patientId;
    private String doctorId;
    private Date visitDate;
    private String department;
    private String chiefComplaint;  // 主诉
    private String presentIllness;  // 现病史
    private String pastHistory;     // 既往史
    private String allergyHistory;  // 过敏史
    private Double temperature;     // 体温
    private String bloodPressure;   // 血压
    private Integer heartRate;      // 心率
    private Integer respiratory;    // 呼吸
    private String physicalExam;    // 体格检查
    private String examItems;       // 检查项目
    private String examResults;     // 检查结果
    private String diagnosis;       // 诊断
    private String diagnosisBasis;  // 诊断依据
    private String treatmentPrinciple; // 治疗原则
    private String medicalAdvice;   // 医嘱
    private String status;          // draft, submitted, completed
    private Date createTime;
    private Date updateTime;
    private List<Prescription> prescriptions; // 处方列表
    
    // Getters and Setters
    public String getCaseId() { return caseId; }
    public void setCaseId(String caseId) { this.caseId = caseId; }
    
    public String getPatientId() { return patientId; }
    public void setPatientId(String patientId) { this.patientId = patientId; }
    
    public String getDoctorId() { return doctorId; }
    public void setDoctorId(String doctorId) { this.doctorId = doctorId; }
    
    public Date getVisitDate() { return visitDate; }
    public void setVisitDate(Date visitDate) { this.visitDate = visitDate; }
    
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    
    public String getChiefComplaint() { return chiefComplaint; }
    public void setChiefComplaint(String chiefComplaint) { this.chiefComplaint = chiefComplaint; }
    
    public String getPresentIllness() { return presentIllness; }
    public void setPresentIllness(String presentIllness) { this.presentIllness = presentIllness; }
    
    public String getPastHistory() { return pastHistory; }
    public void setPastHistory(String pastHistory) { this.pastHistory = pastHistory; }
    
    public String getAllergyHistory() { return allergyHistory; }
    public void setAllergyHistory(String allergyHistory) { this.allergyHistory = allergyHistory; }
    
    public Double getTemperature() { return temperature; }
    public void setTemperature(Double temperature) { this.temperature = temperature; }
    
    public String getBloodPressure() { return bloodPressure; }
    public void setBloodPressure(String bloodPressure) { this.bloodPressure = bloodPressure; }
    
    public Integer getHeartRate() { return heartRate; }
    public void setHeartRate(Integer heartRate) { this.heartRate = heartRate; }
    
    public Integer getRespiratory() { return respiratory; }
    public void setRespiratory(Integer respiratory) { this.respiratory = respiratory; }
    
    public String getPhysicalExam() { return physicalExam; }
    public void setPhysicalExam(String physicalExam) { this.physicalExam = physicalExam; }
    
    public String getExamItems() { return examItems; }
    public void setExamItems(String examItems) { this.examItems = examItems; }
    
    public String getExamResults() { return examResults; }
    public void setExamResults(String examResults) { this.examResults = examResults; }
    
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    
    public String getDiagnosisBasis() { return diagnosisBasis; }
    public void setDiagnosisBasis(String diagnosisBasis) { this.diagnosisBasis = diagnosisBasis; }
    
    public String getTreatmentPrinciple() { return treatmentPrinciple; }
    public void setTreatmentPrinciple(String treatmentPrinciple) { this.treatmentPrinciple = treatmentPrinciple; }
    
    public String getMedicalAdvice() { return medicalAdvice; }
    public void setMedicalAdvice(String medicalAdvice) { this.medicalAdvice = medicalAdvice; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
    
    public List<Prescription> getPrescriptions() { return prescriptions; }
    public void setPrescriptions(List<Prescription> prescriptions) { this.prescriptions = prescriptions; }
}