<template>
  <div class="flex items-center justify-center min-h-screen bg-gray-100">
    <div class="bg-white rounded-xl shadow-lg w-full max-w-5xl mt-10 overflow-hidden">
      <div class="flex flex-col md:flex-row">
        <!-- Login Form -->
        <div class="w-full md:w-1/2 p-10" v-if="step === 1">
          <h4 class="text-2xl font-semibold text-center">Login to Your Account</h4>
          <p class="text-center text-gray-500 mb-8">
            Log in to your account so you can continue building <br /> and editing your onboarding flows
          </p>

          <div class="max-w-md mx-auto space-y-6">
            <input type="email" placeholder="Email" class="w-full px-4 py-2 border rounded-md" />
            <input type="password" placeholder="Password" class="w-full px-4 py-2 border rounded-md" />

            <!-- <div class="flex justify-between items-center text-sm">
              <label class="flex items-center">
                <input type="checkbox" class="mr-2" /> Remember Me
              </label>
              <a href="#" class="text-blue-500">Forgot password</a>
            </div> -->

            <button class="w-full bg-blue-500 text-white py-2 rounded-md">Log in</button>

            <!-- <p class="text-center text-gray-500 mt-4">Or log in using</p> -->
            <!-- <div class="flex justify-between mt-4">
              <button class="border p-2 rounded-md w-1/3"><i class="fab fa-google text-red-500"></i></button>
              <button class="border p-2 rounded-md w-1/3"><i class="fab fa-facebook-f text-blue-500"></i></button>
              <button class="border p-2 rounded-md w-1/3"><i class="fab fa-twitter text-sky-400"></i></button>
            </div> -->

          </div>
        </div>

        <!-- Left Banner for Login -->
        <div class="w-full md:w-1/2 bg-blue-500 text-white flex flex-col items-center justify-center p-12 rounded-bl-[300px]" v-if="step === 1">
          <h3 class="text-2xl font-semibold text-center">Don't Have an Account Yet?</h3>
          <p class="text-center mt-2">
            Let's get you all set up so you can start creating your <br /> first onboarding experience
          </p>
          <button class="mt-6 border border-white px-4 py-2 rounded-md" @click="step++">SIGN UP</button>
        </div>

        <!-- Left Banner for Signup -->
        <div class="w-full md:w-1/2 bg-blue-500 text-white flex flex-col items-center justify-center p-12 rounded-br-[300px]" v-else>
          <h3 class="text-2xl font-semibold text-center">Already Signed up?</h3>
          <p class="text-center mt-2">
            Log in to your account so you can continue building and <br /> editing your onboarding flows
          </p>
          <button class="mt-6 border border-white px-4 py-2 rounded-md" @click="step--">Log in</button>
        </div>

        <!-- Signup Form -->
        <div class="w-full md:w-1/2 p-10" v-else>
          <h4 class="text-2xl font-semibold text-center">Sign Up for an Account</h4>
          <p class="text-center text-gray-500 mb-8">
            Let's get you all set up so you can start creating your <br /> first onboarding experience
          </p>

          <div class="max-w-md mx-auto space-y-4">
            <div class="flex space-x-4">
              <input type="text" placeholder="First Name" class="w-1/2 px-4 py-2 border rounded-md" />
              <input type="text" placeholder="Last Name" class="w-1/2 px-4 py-2 border rounded-md" />
            </div>
            <input type="email" placeholder="Email" class="w-full px-4 py-2 border rounded-md" />
            <input type="password" placeholder="Password" class="w-full px-4 py-2 border rounded-md" />

            <div class="flex justify-between items-center text-sm">
              <label class="flex items-center">
                <input type="checkbox" class="mr-2" /> I Accept AAE
              </label>
              <span class="text-blue-500">Terms & Conditions</span>
            </div>

            <button class="w-full bg-blue-500 text-white py-2 rounded-md">Sign up</button>

            <p class="text-center text-gray-500 mt-4">Or sign up using</p>
            <div class="flex justify-between mt-4">
              <button class="border p-2 rounded-md w-1/3"><i class="fab fa-google text-red-500"></i></button>
              <button class="border p-2 rounded-md w-1/3"><i class="fab fa-facebook-f text-blue-500"></i></button>
              <button class="border p-2 rounded-md w-1/3"><i class="fab fa-twitter text-sky-400"></i></button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      step: 1
    };
  }
};
</script>
