# Apex interface for Opportunity Territory to Assignment Filter

## OpportunityTerritory2AssignmentFilter

Apex interface that allows an implementing class to assign a single territory to an opportunity.
It is a blueprint copy of the code from salesforce here, with test classes.
https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_interface_TerritoryMgmt_OpportunityTerritory2AssignmentFilter.htm

### Usage

Method called by Opportunity Territory Assignment job to assign territory to opportunity. Input is a list of (up to 1000) opportunityIds that have IsExcludedFromTerritory2Filter=false. Returns a map of OpportunityId to Territory2Id, which is used to update the Territory2Id field on the Opportunity object.

## Deployment

**OBS** \
This code is dependent on salesforce TestFactory.csl. Before installing make sure that you do not have a class with this name. \
The below steps will overrite any existing code. 

**Step 1:** Install as an unlocked package: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t2G000000Y19lQAC \
**Step 2:** Quick deploy this repo to the same org. \
[![Deploy to salesforce](/.assets/deploy.png)](https://githubsfdeploy.herokuapp.com/?owner=ehsky&repo=OpportunityTerritory2AssignmentFilter)
