package com.webbanhang.repository;

import com.webbanhang.model.Notification;
import com.webbanhang.model.Setting;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
import java.util.List;

@Repository
public class NotificationSettingRepository {
   
	  @Autowired
	  private SessionFactory sessionFactory;
	  
	  public void saveNotification(Notification notification) {
	        sessionFactory.getCurrentSession().save(notification);
	    }
	 
	    public List<Notification> findNotificationsByUser(Integer userId) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Notification n WHERE n.user.userId = :userId ORDER BY n.createdDate DESC", Notification.class)
	                .setParameter("userId", userId)
	                .list();
	    }
	 
	    public List<Notification> findUnreadByUser(Integer userId) {
	        return sessionFactory.getCurrentSession()
	                .createQuery("FROM Notification n WHERE n.user.userId = :userId AND n.isRead = false ORDER BY n.createdDate DESC", Notification.class)
	                .setParameter("userId", userId)
	                .list();
	    }
	 
	    public void markAsRead(Integer notificationId) {
	    	      sessionFactory.getCurrentSession()
	                .createQuery("UPDATE Notification n SET n.isRead = true WHERE n.notificationId = :id")
	                .setParameter("id", notificationId)
	                .executeUpdate();
	    }
	 
	    public void markAllAsRead(Integer userId) {
	               	sessionFactory.getCurrentSession()
	                .createQuery("UPDATE Notification n SET n.isRead = true WHERE n.user.userId = :userId")
	                .setParameter("userId", userId)
	                .executeUpdate();
	    }
	    
	   //Setting
	    public void saveSetting(Setting setting) {
	    	sessionFactory.getCurrentSession().save(setting);
	    }
	 
	    public void updateSetting(Setting setting) {
	    	sessionFactory.getCurrentSession().update(setting);
	    }
	 
	    public Setting findSettingByUserAndKey(Integer userId, String key) {
	        return 	sessionFactory.getCurrentSession()
	                .createQuery("FROM Setting s WHERE s.user.userId = :userId AND s.settingKey = :key", Setting.class)
	                .setParameter("userId", userId)
	                .setParameter("key", key)
	                .uniqueResult();
	    }
	 
	    public List<Setting> findSettingsByUser(Integer userId) {
	        return 	sessionFactory.getCurrentSession()
	                .createQuery("FROM Setting s WHERE s.user.userId = :userId", Setting.class)
	                .setParameter("userId", userId)
	                .list();
	    }
}
