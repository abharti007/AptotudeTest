<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Invert_Refund</fullName>
        <description>Used to convert the transaction amount to a negative upon successful refund of a transaction. This will now calculate properly in Balance Due and Total Transactions</description>
        <field>Amount__c</field>
        <formula>0</formula>
        <name>Invert Refund</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Invert Refund</fullName>
        <actions>
            <name>Invert_Refund</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>No longer used. A Refund will now create a NEW transaction with a negative amount.</description>
        <formula>1=2</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
