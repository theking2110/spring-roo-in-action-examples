package org.rooina.coursemanager.web.scaffold;

import org.rooina.coursemanager.model.Offering;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "offerings", formBackingObject = Offering.class)
@RequestMapping("/offerings")
@Controller
public class OfferingController {
}