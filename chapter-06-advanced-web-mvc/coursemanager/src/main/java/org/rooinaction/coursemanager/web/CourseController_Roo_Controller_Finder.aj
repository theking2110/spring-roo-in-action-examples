// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.rooinaction.coursemanager.web;

import org.rooinaction.coursemanager.model.Course;
import org.rooinaction.coursemanager.web.CourseController;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect CourseController_Roo_Controller_Finder {
    
    @RequestMapping(params = { "find=ByNameLike", "form" }, method = RequestMethod.GET)
    public String CourseController.findCoursesByNameLikeForm(Model uiModel) {
        return "courses/findCoursesByNameLike";
    }
    
    @RequestMapping(params = "find=ByNameLike", method = RequestMethod.GET)
    public String CourseController.findCoursesByNameLike(@RequestParam("name") String name, Model uiModel) {
        uiModel.addAttribute("courses", Course.findCoursesByNameLike(name).getResultList());
        return "courses/list";
    }
    
}
