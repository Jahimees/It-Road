package by.epam.ft.command;

import by.epam.ft.dao.VacancyDAO;
import by.epam.ft.entity.Vacancy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static by.epam.ft.constant.AttributeAndParameterConstant.*;
import static by.epam.ft.constant.PreparedConstant.UPDATE_VACANCY;

public class ChangeVacancyCommand implements ActionCommand {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String idVacancy = request.getParameter(ID_VACANCY);
        String vacancyName = request.getParameter(VACANCY_NAME);
        String vacancyDescription = request.getParameter(DESCRIPTION);

        Vacancy vacancy = new Vacancy();

        vacancy.setIdVacancy(Integer.parseInt(idVacancy));
        vacancy.setName(vacancyName);
        vacancy.setDescription(vacancyDescription);

        VacancyDAO vacancyDAO = new VacancyDAO();
        vacancyDAO.updateInfo(vacancy, UPDATE_VACANCY);

        return new LoadOpenedVacancyPageCommand().execute(request, response);
    }
}
