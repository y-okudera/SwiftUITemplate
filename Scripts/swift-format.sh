#!/usr/bin/env sh

if [ $ENABLE_PREVIEWS == "NO" ]
then
  $SRCROOT/Tools/.build/release/swift-format -r $SRCROOT/App/Sources $SRCROOT/Frameworks/Sources -i || true
  $SRCROOT/Tools/.build/release/swift-format -r $SRCROOT/App/Sources $SRCROOT/Frameworks/Sources -m lint || true
else
  echo "Skipping the script because of preview mode"
fi
