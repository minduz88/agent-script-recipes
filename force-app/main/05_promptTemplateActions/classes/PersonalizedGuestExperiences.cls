public with sharing class PersonalizedGuestExperiences {
    // Make this method available for grounding
    // the Generate_Personalized_Schedule prompt template
    @InvocableMethod(
        label='Get sessions of interest for today'
        description='Get today\'s sessions that match the user\'s interests.'
    )
    public static List<Response> getSessions(List<Request> requests) {
        Id guestId = requests[0].guest.Id;

        // Get experiences for contact
        List<ASR_Experience__c> experiences = ExperienceController.getExperiences(
            guestId
        );

        // Create expected response
        List<Response> responses = new List<Response>();
        Response res = new Response();
        res.prompt = JSON.serialize(experiences);
        responses.add(res);
        return responses;
    }

    // The variables in this class need to match the prompt template inputs,
    // that may be different on each prompt template
    public class Request {
        @InvocableVariable(required=true description='The guest (Contact) ID')
        public Contact guest;
    }

    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}
