import { LightningElement,track, api, wire} from 'lwc';
import MOVIE_OBJECT from '@salesforce/schema/Movie__C';
import NAME_FIELD from '@salesforce/schema/Movie__c.Name__c';
import DESCRIPTION_FIELD from '@salesforce/schema/Movie__c.Description__c';

export default class NewMovieModalLWC extends LightningElement {
    @api
    closeModal() {
      //do modal close stuff
      this.dispatchEvent(new CustomEvent('close'));
    }

    handleSaveRecord(){
      
    }
}