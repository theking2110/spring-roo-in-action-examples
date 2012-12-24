// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.rooinaction.taskmanager.web;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.rooinaction.taskmanager.model.Task;
import org.rooinaction.taskmanager.service.TaskService;
import org.rooinaction.taskmanager.web.TaskController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect TaskController_Roo_Controller {
    
    @Autowired
    TaskService TaskController.taskService;
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String TaskController.create(@Valid Task task, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, task);
            return "tasks/create";
        }
        uiModel.asMap().clear();
        taskService.saveTask(task);
        return "redirect:/tasks/" + encodeUrlPathSegment(task.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String TaskController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Task());
        return "tasks/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String TaskController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("task", taskService.findTask(id));
        uiModel.addAttribute("itemId", id);
        return "tasks/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String TaskController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("tasks", taskService.findTaskEntries(firstResult, sizeNo));
            float nrOfPages = (float) taskService.countAllTasks() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("tasks", taskService.findAllTasks());
        }
        return "tasks/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String TaskController.update(@Valid Task task, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, task);
            return "tasks/update";
        }
        uiModel.asMap().clear();
        taskService.updateTask(task);
        return "redirect:/tasks/" + encodeUrlPathSegment(task.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String TaskController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, taskService.findTask(id));
        return "tasks/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String TaskController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Task task = taskService.findTask(id);
        taskService.deleteTask(task);
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/tasks";
    }
    
    void TaskController.populateEditForm(Model uiModel, Task task) {
        uiModel.addAttribute("task", task);
    }
    
    String TaskController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
