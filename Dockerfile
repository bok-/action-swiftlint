FROM swift:5.3
LABEL version="3.1.2"
LABEL repository="https://github.com/norio-nomura/action-swiftlint"
LABEL homepage="https://github.com/norio-nomura/action-swiftlint"
LABEL maintainer="Norio Nomura <norio.nomura@gmail.com>"

LABEL "com.github.actions.name"="GitHub Action for SwiftLint"
LABEL "com.github.actions.description"="A tool to enforce Swift style and conventions."
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="orange"

ENV SWIFTLINT_REVISION="master"

# Install SwiftLint
RUN git clone --branch $SWIFTLINT_REVISION https://github.com/realm/SwiftLint.git && \
    cd SwiftLint && \
    swift build --configuration release --static-swift-stdlib && \
    mv `swift build --configuration release --static-swift-stdlib --show-bin-path`/swiftlint /usr/bin && \
    cd .. && \
    rm -rf SwiftLint

# Print Installed SwiftLint Version
RUN swiftlint version
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
