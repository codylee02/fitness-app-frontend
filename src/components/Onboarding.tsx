import React, { useState } from "react";
import { IonContent, IonPage, IonButton, IonInput, IonSelect, IonSelectOption } from "@ionic/react";

const Onboarding: React.FC = () => {
	const [step, setStep] = useState(1);
	const [userData, setUserData] = useState({
		name: "",
		age: "",
		gender: "",
		height: "",
		weight: "",
		fitnessGoal: "",
		experienceLevel: "",
	});

	const handleInputChange = (event: CustomEvent) => {
		const { name, value } = event.detail;
		setUserData({ ...userData, [name]: value });
	};

	const nextStep = () => setStep(step + 1);
	const prevStep = () => setStep(step - 1);

	const submitData = async () => {
		// Send userData to backend
		// Redirect to main app
	};

	return (
		<IonPage>
			<IonContent>
				{step === 1 && (
					<>
						<h2>Welcome! Let's get to know you.</h2>
						<IonInput name='name' value={userData.name} onIonChange={handleInputChange} placeholder='Your Name' />
						<IonInput
							name='age'
							type='number'
							value={userData.age}
							onIonChange={handleInputChange}
							placeholder='Your Age'
						/>
						<IonButton onClick={nextStep}>Next</IonButton>
					</>
				)}
				{step === 2 && (
					<>
						<h2>Physical Information</h2>
						<IonSelect name='gender' value={userData.gender} onIonChange={handleInputChange}>
							<IonSelectOption value='male'>Male</IonSelectOption>
							<IonSelectOption value='female'>Female</IonSelectOption>
							<IonSelectOption value='other'>Other</IonSelectOption>
						</IonSelect>
						<IonInput
							name='height'
							type='number'
							value={userData.height}
							onIonChange={handleInputChange}
							placeholder='Height (cm)'
						/>
						<IonInput
							name='weight'
							type='number'
							value={userData.weight}
							onIonChange={handleInputChange}
							placeholder='Weight (kg)'
						/>
						<IonButton onClick={prevStep}>Back</IonButton>
						<IonButton onClick={nextStep}>Next</IonButton>
					</>
				)}
				{step === 3 && (
					<>
						<h2>Fitness Goals</h2>
						<IonSelect name='fitnessGoal' value={userData.fitnessGoal} onIonChange={handleInputChange}>
							<IonSelectOption value='loseWeight'>Lose Weight</IonSelectOption>
							<IonSelectOption value='gainMuscle'>Gain Muscle</IonSelectOption>
							<IonSelectOption value='improveEndurance'>Improve Endurance</IonSelectOption>
						</IonSelect>
						<IonSelect name='experienceLevel' value={userData.experienceLevel} onIonChange={handleInputChange}>
							<IonSelectOption value='beginner'>Beginner</IonSelectOption>
							<IonSelectOption value='intermediate'>Intermediate</IonSelectOption>
							<IonSelectOption value='advanced'>Advanced</IonSelectOption>
						</IonSelect>
						<IonButton onClick={prevStep}>Back</IonButton>
						<IonButton onClick={submitData}>Finish</IonButton>
					</>
				)}
			</IonContent>
		</IonPage>
	);
};

export default Onboarding;
