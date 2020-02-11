package by.epam.ft.dao;

import by.epam.ft.connection.ConnectionPool;
import by.epam.ft.entity.TopVacancy;
import by.epam.ft.entity.Vacancy;
import org.apache.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static by.epam.ft.constant.AttributeAndParameterConstant.*;
import static by.epam.ft.constant.LogConstant.*;
import static by.epam.ft.constant.PreparedConstant.*;

/**
 * manages data in the Vacancy table
 */
public class VacancyDAO implements DAO<Vacancy> {
    private static final Logger logger = Logger.getLogger(AccountDAO.class);

    public Vacancy showById(int id) {
        Connection connection = ConnectionPool.getInstance().getConnection();
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(GET_VACANCY);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Vacancy vacancy = new Vacancy();
                vacancy.setIdVacancy(resultSet.getInt(ID_VACANCY));
                vacancy.setDescription(resultSet.getString(DESCRIPTION));
                vacancy.setName(resultSet.getString(NAME));

                return vacancy;
            }
        } catch (SQLException e) {
            logger.error(e + SQL_DAO_EXCEPTION);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.error(e + SQL_CLOSE_CONNECTION_EXCEPTION);
            }
        }

        return null;
    }

    public LinkedHashMap<String, Integer> takePopularVacancies() {
        LinkedHashMap<String, Integer> topList = new LinkedHashMap<>();
        Connection connection = ConnectionPool.getInstance().getConnection();
        try {
            PreparedStatement statement = connection.prepareStatement(GET_POPULAR_VACANCIES);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
//                TopVacancy vacancy = new TopVacancy();
//                vacancy.setCount(resultSet.getInt("count(*)"));
//                vacancy.setName(resultSet.getString("name"));
                topList.put(resultSet.getString("name"), resultSet.getInt("count(*)"));
//                topList.add(vacancy);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return topList;
    }

    /**
     * No implementation needed
     * @deprecated
     * @return
     */
    @Override
    public Vacancy showById(int id, String query) {
        return null;
    }

    /**
     * @see DAO
     * @return List<Vacancy>
     */
    @Override
    public List<Vacancy> showAll() {
        List<Vacancy> result = new ArrayList<>();
        Connection connection = ConnectionPool.getInstance().getConnection();
        try {
            PreparedStatement statement = connection.prepareStatement(GET_ALL_VACANCY);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                Vacancy vacancy = new Vacancy();
                vacancy.setIdVacancy(resultSet.getInt(ID_VACANCY));
                vacancy.setName(resultSet.getString(NAME));
                vacancy.setDescription(resultSet.getString(DESCRIPTION));
                result.add(vacancy);
            }
        } catch (SQLException e) {
            logger.error(e + SQL_DAO_EXCEPTION);
        }finally {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.error(e + SQL_CLOSE_CONNECTION_EXCEPTION);
            }
        }
        return result;
    }

    /**
     * No implementation needed
     * @deprecated
     * @return
     */
    @Override
    public boolean updateInfo(Vacancy vacancy, String query) {
        return false;
    }

    /**
     * Delete chosen vacancy from database
     * @param vacancy
     * @param query
     * @return
     */
    public boolean deleteInfo(Vacancy vacancy, String query) {
        Connection connection = ConnectionPool.getInstance().getConnection();
        boolean result = false;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, vacancy.getIdVacancy());
            result = preparedStatement.execute();
        } catch (SQLException e) {
            logger.error(e + SQL_DAO_EXCEPTION);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.error(e + SQL_CLOSE_CONNECTION_EXCEPTION);
            }
        }
        return result;
    }

    /**
     * Create new Vacancy in database
     * @param vacancy
     * @param query
     * @return true - if successful, false - otherwise
     */
    public boolean insertInfo(Vacancy vacancy, String query) {
        Connection connection = ConnectionPool.getInstance().getConnection();
        boolean result = false;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, vacancy.getName());
            preparedStatement.setString(2, vacancy.getDescription());
            result = preparedStatement.execute();
        } catch (SQLException e) {
            logger.error(e + SQL_DAO_EXCEPTION);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                logger.error(e + SQL_CLOSE_CONNECTION_EXCEPTION);
            }
        }
        return result;
    }

}
