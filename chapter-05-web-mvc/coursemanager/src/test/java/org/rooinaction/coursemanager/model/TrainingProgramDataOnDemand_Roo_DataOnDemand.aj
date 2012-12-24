// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.rooinaction.coursemanager.model;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.rooinaction.coursemanager.model.TrainingProgram;
import org.rooinaction.coursemanager.model.TrainingProgramDataOnDemand;
import org.springframework.stereotype.Component;

privileged aspect TrainingProgramDataOnDemand_Roo_DataOnDemand {
    
    declare @type: TrainingProgramDataOnDemand: @Component;
    
    private Random TrainingProgramDataOnDemand.rnd = new SecureRandom();
    
    private List<TrainingProgram> TrainingProgramDataOnDemand.data;
    
    public TrainingProgram TrainingProgramDataOnDemand.getNewTransientTrainingProgram(int index) {
        TrainingProgram obj = new TrainingProgram();
        setName(obj, index);
        return obj;
    }
    
    public void TrainingProgramDataOnDemand.setName(TrainingProgram obj, int index) {
        String name = "name_" + index;
        obj.setName(name);
    }
    
    public TrainingProgram TrainingProgramDataOnDemand.getSpecificTrainingProgram(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        TrainingProgram obj = data.get(index);
        Long id = obj.getId();
        return TrainingProgram.findTrainingProgram(id);
    }
    
    public TrainingProgram TrainingProgramDataOnDemand.getRandomTrainingProgram() {
        init();
        TrainingProgram obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return TrainingProgram.findTrainingProgram(id);
    }
    
    public boolean TrainingProgramDataOnDemand.modifyTrainingProgram(TrainingProgram obj) {
        return false;
    }
    
    public void TrainingProgramDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = TrainingProgram.findTrainingProgramEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'TrainingProgram' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<TrainingProgram>();
        for (int i = 0; i < 10; i++) {
            TrainingProgram obj = getNewTransientTrainingProgram(i);
            try {
                obj.persist();
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
