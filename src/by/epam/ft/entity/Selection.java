package by.epam.ft.entity;

import java.sql.Date;
import java.util.Objects;

public class Selection extends MyEntity {
    private int idSelection;
    private int idHr;
    private int idCandidate;
    private Date selectionDate;
    private int idVacancy;
    private String status;
    private Date registrationDate;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Selection)) return false;
        Selection selection = (Selection) o;
        return getIdSelection() == selection.getIdSelection() &&
                getIdHr() == selection.getIdHr() &&
                getIdCandidate() == selection.getIdCandidate() &&
                getIdVacancy() == selection.getIdVacancy() &&
                Objects.equals(getSelectionDate(), selection.getSelectionDate()) &&
                Objects.equals(getStatus(), selection.getStatus()) &&
                Objects.equals(getRegistrationDate(), selection.getRegistrationDate());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getIdSelection(), getIdHr(), getIdCandidate(), getSelectionDate(), getIdVacancy(), getStatus());
    }

    public void setIdVacancy(int idVacancy) {
        this.idVacancy = idVacancy;
    }

    public int getIdVacancy() { return idVacancy; }

    public Date getSelectionDate() {
        return selectionDate;
    }

    public void setSelectionDate(Date selectionDate) {
        this.selectionDate = selectionDate;
    }

    public int getIdCandidate() {
        return idCandidate;
    }

    public void setIdCandidate(int idCandidate) {
        this.idCandidate = idCandidate;
    }

    public int getIdHr() {
        return idHr;
    }

    public void setIdHr(int idHr) {
        this.idHr = idHr;
    }

    public int getIdSelection() {
        return idSelection;
    }

    public void setIdSelection(int idSelection) {
        this.idSelection = idSelection;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }
}
