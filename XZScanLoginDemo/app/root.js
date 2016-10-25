import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Navigator,
  TouchableOpacity,
  Image
} from 'react-native';

import XZScanLoginScene from './XZScanLoginScene.js'

export default class XZScanLoginDemo extends Component {

  _renderNavBar(){

    var routeMapper = {

      RightButton(route,navigator,index,navState){

      },

      LeftButton(route,navigator,index,navState){

        return(
          <TouchableOpacity>
            <Image 
            style = {{width:11.5,height:21,marginLeft:10,marginTop:(40-21)/2}}
            source = {require('../image/back.png')}/>
          </TouchableOpacity>
        )
      },

      Title(route,navigator,index,navState){
        return (
            <View style = {{flex:1,justifyContent: 'center',alignItems: 'center'}}>
             <Text style = {{fontSize : 20,color:'white'}}>{route.title}</Text>
            </View>
          )
      },
    }


    return (
      <Navigator.NavigationBar
      style = {{backgroundColor:'rgb(11,116,255)',justifyContent: 'center',alignItems: 'center',}}
      routeMapper = {routeMapper}/>
      )
  }


  render() {
    return (

      <Navigator
        initialRoute={{title:'扫描登陆页二维码',component:XZScanLoginScene}}
        renderScene = {(route, navigator) => {

          return <route.component {...route} navigator = {navigator} />
        }}
        navigationBar = {
          this._renderNavBar()
        }
      />
    );
  }
}

const styles = StyleSheet.create({

});

AppRegistry.registerComponent('XZScanLoginDemo', () => XZScanLoginDemo);
