// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.rooinaction.taskmanager.service;

import java.util.List;
import org.rooinaction.taskmanager.model.Task;
import org.rooinaction.taskmanager.service.TaskService;

privileged aspect TaskService_Roo_Service {
    
    public abstract long TaskService.countAllTasks();    
    public abstract void TaskService.deleteTask(Task task);    
    public abstract Task TaskService.findTask(Long id);    
    public abstract List<Task> TaskService.findAllTasks();    
    public abstract List<Task> TaskService.findTaskEntries(int firstResult, int maxResults);    
    public abstract void TaskService.saveTask(Task task);    
    public abstract Task TaskService.updateTask(Task task);    
}
