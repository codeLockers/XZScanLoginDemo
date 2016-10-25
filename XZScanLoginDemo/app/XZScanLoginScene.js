import React, { Component } from 'react';

import {
  StyleSheet,
  View,
  requireNativeComponent,
  Dimensions
} from 'react-native';

var XZScanLoginView = requireNativeComponent('XZScanLogin',null)


class XZScanLoginScene extends Component {
  render() {
    return (
      
      <XZScanLoginView style = {{width:Dimensions.get('window').width,height:Dimensions.get('window').height,backgroundColor:'blue',marginTop:64}}/>
    );
  }
}

const styles = StyleSheet.create({

});


export default XZScanLoginScene;