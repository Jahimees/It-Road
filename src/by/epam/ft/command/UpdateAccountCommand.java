package by.epam.ft.command;

import by.epam.ft.constant.PreparedConstant;
import by.epam.ft.dao.AccountDAO;
import by.epam.ft.entity.Account;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateAccountCommand implements ActionCommand {

    Logger logger = Logger.getLogger(UpdateAccountCommand.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        logger.info("Updating account...");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String resume = request.getParameter("resume");
        int id = Integer.parseInt(request.getParameter("id"));

        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.showById(id);

        account.setName(name);
        account.setSurname(surname);
        account.setEmail(email);
        account.setResume(resume != null ? resume : "");

        accountDAO.updateInfo(account, PreparedConstant.UPDATE_ACCOUNT);
        accountDAO.setConfirmEmailStatus(id, false);

        logger.info("Account data successfully changed!");
        return new OpenAccountCommand().execute(request, response);
    }
}
