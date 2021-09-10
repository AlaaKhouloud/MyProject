import { LightningElement,api,track,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

export default class MoviePreviewLwc extends NavigationMixin(LightningElement) {
    showEditFields = false;
    @api recordid;

    closeModal() {
        this.dispatchEvent(new CustomEvent('close'));
    }

    handleEditMovie(evt){
        this.showEditFields = true;
    }

    handleDeleteMovie(evt){
        //delete
        deleteRecord(this.recordid)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: '',
                    message: 'This Movie Item Was Deleted Successfully.',
                    variant: 'success',
                })
            );
            //close modal
            this.dispatchEvent(new CustomEvent('close'));
        })
        .catch(error => {
            console.log(error);
        });
    }

    handleReset(evt){
        this.showEditFields = false;
        this.closeModal();
    }

    handleSuccess( event ) {  
        const toastEvent = new ShowToastEvent({  
            title: 'Contact Updated',  
            message: 'Contact Updated Successfully!!!',  
            variant: 'success'  
        }); 
        
        this.dispatchEvent( toastEvent );  
        this.showEditFields = false;
    }  

    handleSubmit(event){
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);   
    }
}