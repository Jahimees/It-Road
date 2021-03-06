package by.epam.ft.dao;

import by.epam.ft.connection.ConnectionPool;
import by.epam.ft.entity.Hr;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import static by.epam.ft.constant.AttributeAndParameterConstant.ID_HR;
import static by.epam.ft.constant.LogConstant.SQL_CLOSE_CONNECTION_EXCEPTION;
import static by.epam.ft.constant.LogConstant.SQL_DAO_EXCEPTION;
import static by.epam.ft.constant.PreparedConstant.GET_HR_BY_ID_ACCOUNT;

/**
 * manages data in the HR table
 */
public class HrDAO implements DAO<Hr>, UserDAO {

    private static final Logger logger = Logger.getLogger(AccountDAO.class);

    /**
     * No implementation needed
     * @deprecated
     * @return
     */
    @Override
    public Hr showById(int id) {
        return null;
    }

    /**
     * Shows HR info by account id
     * @param id
     * @return
     */
    @Override
    public Hr showByAccountId(int id) {
        logger.info("Showing hr by account id: " + id);
        Connection connection = ConnectionPool.getInstance().getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(GET_HR_BY_ID_ACCOUNT);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Hr hr = new Hr();
                hr.setIdAccount(id);
                hr.setIdHr(resultSet.getInt(ID_HR));
                logger.info("HR was found!");
                return hr;
            }
        } catch (SQLException e) {
            logger.error(SQL_DAO_EXCEPTION, e);
        } finally {
            try {
                logger.info("Connection closing...");
                connection.close();
            } catch (SQLException e) {
                logger.error(SQL_CLOSE_CONNECTION_EXCEPTION, e);
            }
        }
        logger.info("HR was not found!");
        return null;
    }

    /**
     * No implementation needed
     * @deprecated
     * @return
     */
    @Override
    public List<Hr> showAll() {
        return null;
    }

    /**
     * No implementation needed
     * @deprecated
     * @return
     */
    @Override
    public boolean updateInfo(Hr hr, String query) {
        return false;
    }

    /**
     * No implementation needed
     * @deprecated
     * @return
     */
    @Override
    public boolean deleteInfo(Hr hr, String query) {
        return false;
    }

    /**
     * No implementation needed
     * @deprecated
     * @return
     */
    @Override
    public boolean insertInfo(Hr hr, String query) {
        return false;
    }
}
