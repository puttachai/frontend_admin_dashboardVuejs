<template>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
      <div class="bg-white rounded-xl shadow-lg w-full max-w-5xl mt-10 overflow-hidden">
        <div class="flex flex-col md:flex-row">
          <!-- Dynamic Form -->
          <component :is="step === 1 ? 'SinginForm' : 'SignupForm'" />
  
          <!-- Banner -->
          <div
            class="w-full md:w-1/2 bg-blue-500 text-white flex flex-col items-center justify-center p-12"
            :class="step === 1 ? 'rounded-bl-[300px]' : 'rounded-br-[300px]'"
          >
            <h3 class="text-2xl font-semibold text-center">
              {{ step === 1 ? "Don't Have an Account Yet?" : "Already Signed up?" }}
            </h3>
            <p class="text-center mt-2">
              {{ step === 1
                ? "Let's get you all set up so you can start creating your first onboarding experience"
                : "Log in to your account so you can continue building and editing your onboarding flows" }}
            </p>
            <button class="mt-6 border border-white px-4 py-2 rounded-md" @click="toggleStep">
              {{ step === 1 ? "SIGN UP" : "Log in" }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import SinginForm from './SinginForm.vue';
  import SignupForm from './SignupForm.vue';
  
  export default {
    components: {
      SinginForm,
      SignupForm
    },
    data() {
      return {
        step: 1
      };
    },
    methods: {
      toggleStep() {
        this.step = this.step === 1 ? 2 : 1;
      }
    }
  };
  </script>
  