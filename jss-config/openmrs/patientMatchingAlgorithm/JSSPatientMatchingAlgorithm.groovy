import org.bahmni.csv.KeyValue
import org.bahmni.module.admin.csv.patientmatchingalgorithm.PatientMatchingAlgorithm
import org.bahmni.module.admin.csv.patientmatchingalgorithm.exception.CannotMatchPatientException
import org.openmrs.Patient

public class JSSPatientMatchingAlgorithm extends PatientMatchingAlgorithm {
    @Override
    Patient run(List<Patient> patientList, List<KeyValue> patientAttributesFromCSV) {
        String genderFromCSV = valueFor("Gender", patientAttributesFromCSV);
        String nameFromCSV = valueFor("Name", patientAttributesFromCSV);

        List<Patient> matchingPatients = new ArrayList<Patient>();
        if (patientList == null || patientList.size() < 1) {
            throw new CannotMatchPatientException();
        }
        for (Patient patient : patientList) {
            if (matchGenderAndName(patient, genderFromCSV, nameFromCSV)) {
                matchingPatients.add(patient);
            }
        }
        if (matchingPatients.size() == 1) {
            return matchingPatients.get(0);
        } else if (matchingPatients.size() > 1) {
            throw new CannotMatchPatientException(matchingPatients);
        } else {
            throw new CannotMatchPatientException(patientList);
        }
    }

    private boolean matchGenderAndName(Patient patient, String genderFromCSV, String nameFromCSV) {
        return patient.getGender().equalsIgnoreCase(genderFromCSV) &&
                doesAnyNamePartMatch(patient, nameFromCSV);
    }

    private boolean doesAnyNamePartMatch(Patient patient, String patientNameFromCSV) {
        return doNamePartsMatch(patient.getGivenName(), patientNameFromCSV) ||
                doNamePartsMatch(patient.getFamilyName(), patientNameFromCSV)
    }

    boolean doNamePartsMatch(String patientGivenName, String patientNameFromCSV) {
        def givenNameParts = patientGivenName.toLowerCase().split(" ").toList();
        def patientNameFromCSVParts = patientNameFromCSV.toLowerCase().split(" ").toList();
        return givenNameParts.intersect(patientNameFromCSVParts);
    }
}