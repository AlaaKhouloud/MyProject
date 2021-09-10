import { LightningElement,track, api, wire} from 'lwc';
import getMovieList from '@salesforce/apex/MovieController.getMovieList';
import { NavigationMixin } from 'lightning/navigation';
//import {refreshApex} from '@salesforce/apex';

export default class FilterMoviesLwc extends NavigationMixin(LightningElement) {
    shownCreationModal = false;
    showResults = false;
    showSpinner = false;
    @track movies = [];
    @track searchKey='';
    @track openModal;


    handleCreateMovie(evt){
        //emmpty search field
        let temp = {
          type: 'standard__objectPage',
          attributes: {
              objectApiName: 'Movie__c',
              actionName: 'new'                
          },
          state : {
              nooverride: '1',
              navigationLocation: 'RELATED_LIST'
            }
        };
        this[NavigationMixin.Navigate](temp);
    }

    handleModalClosed(evt) {
        this.openModal = false;
        //refreshApex(this.movies);
        this.handleSearchMovies(evt,this.searchKey);
    }

    handleSearchMovies(evt,key){
        this.movies = [];
        this.showSpinner = true;
        if(key){
            this.searchKey = key;
        }else{
            this.searchKey = evt.target.value;
        }
        getMovieList({searchKey : this.searchKey})
            .then(result => {
                this.movies = result;
                this.showResults = true;
                setTimeout(() => {
                    this.showSpinner = false;
                }, 1000);
            })
            .catch(error => {
                this.error = error;
            });
    }
}