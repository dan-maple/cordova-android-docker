FROM danmaple/cordova:10.0.0

# Set build variables.
ARG JDK_VERSION="8.0.282.hs-adpt"
ARG GRADLE_VERSION="6.5"
ARG ANDROID_PLATFORM="platforms;android-29"
ARG ANDROID_BUILD_TOOLS="build-tools;30.0.3"

# Set evironment variables.
ENV JAVA_HOME=/root/.sdkman/candidates/java/current
ENV ANDROID_SDK_ROOT=/android_sdk
ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin

# Install Software Development Kit Manager (SKKMAN), Java Development Kit (JDK) and Gradle
RUN curl -s "https://get.sdkman.io" | bash && \
    source ${HOME}/.sdkman/bin/sdkman-init.sh && \
    sdk install java ${JDK_VERSION} && \
    sdk install gradle ${GRADLE_VERSION}

# Install Android SDK command-line, platform and build tools.
RUN curl https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip -o tools.zip && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools && \
    unzip tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools && \
    rm tools.zip && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    yes | sdkmanager ${ANDROID_PLATFORM} ${ANDROID_BUILD_TOOLS}
