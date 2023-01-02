import * as React from 'react';
import { useState, useEffect } from "react";
import axios from "axios";
import useFetch from "react-fetch-hook";
import { createTheme, ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import ClearIcon from '@mui/icons-material/Clear';
import Container from '@mui/material/Container';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import MenuIcon from '@mui/icons-material/Menu';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import { mainListItems, secondaryListItems } from './listItems';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';
import Button from '@mui/material/Button';
import Copyright from "./CopyRight";
import {AppBar,Drawer} from './AppBarDrawer';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemSecondaryAction from '@mui/material/ListItemSecondaryAction';
import AddIcon from '@mui/icons-material/Add';
import RemoveIcon from '@mui/icons-material/Remove';
import DeleteIcon from '@mui/icons-material/Delete';
import { Slider } from '@mui/material';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormLabel from '@mui/material/FormLabel';
import RadioGroup from '@mui/material/RadioGroup';
import Radio from '@mui/material/Radio';
import logo from '../assets/images/logo.png';

const mdTheme = createTheme();



function DashboardContent() {
    const [open, setOpen] = React.useState(true);
    const [section, setSections] = React.useState([]);
    const [coursesSections, setCoursesSections] = React.useState([]);
    const [numberOfDays, setNumberOfDays] = React.useState(5);
    const handleChange = async (event, course) => {
      let sectionValueNew = [...section];
      sectionValueNew[addedCourses.indexOf(course)] = event.target.value;
      setSections(sectionValueNew);
    };
  
    const addDataIntoCache = (cacheName, url, response) => {
      if('caches' in window) {
        caches.open(cacheName)
        .then(cache => {
          cache.put(url, response);
          alert('Data saved in cache');
        })
      }
    }
    const [loading, setLoading] = useState(false);

    const [data, setData] = useState([]);
    useEffect(() => {
        const fetchData = async () => {
          setLoading(true);
          try{
            let response;
            const cachedData = localStorage.getItem('courses');
            if(cachedData) {
              response = {data: JSON.parse(cachedData)};
              console.log('data from cache');
            } else {
              response = await axios.get(
                '//localhost:8080/getAllCourseNames',
              );
              localStorage.setItem('courses', JSON.stringify(response.data));
              console.log('data from server');
            }
            setData(response.data);
          } catch{
            console.log('error');
          }finally{
            setLoading(false);
          }
          
        };
        fetchData();
    }, []);

    const fullCoursesList = data ? data: null;
    const coursesList = [...new Set(fullCoursesList)];
    const [selectedCourse, setSelectedCourse] = React.useState();
    const [addedCourses, setAddedCourses]= React.useState([]);
    const toggleDrawer = () => {
        setOpen(!open);
    };
    const addCourse = async() => {
      let course = selectedCourse.split(" ")[0];
      let selectedCoursesTemp = [...addedCourses, course];
      let uniqeSelectedCoursesTemp = [...new Set(selectedCoursesTemp)];
      setAddedCourses(uniqeSelectedCoursesTemp );
    }
    const removeCourse = (course)=>{
    console.log('removed ' +course) 
      let sectionsNew = [...section];
      sectionsNew.splice(addedCourses.indexOf(course),1);
      setSections(sectionsNew);
      setAddedCourses(addedCourses.filter(code => code !== course));

  }
    const [isClicked, setIsClicked] = React.useState(false);
    useEffect(() => {
      isClicked && setIsClicked(false);
   },[isClicked]);
   //const {tables} = useFetch("http://localhost:8080/api/v1/getcourses", {depends : [isClicked]});

   const [tables, setTables]= React.useState([]);

   const getData = async () => {

    setLoading(true);
    try{
      let response;
      
      response =  await axios.post('//localhost:8080/createTableNoClash', 
      {
        id: addedCourses,
        useFilters: false,
        filters: null,
        }
      );
      console.log('data from server' + response.data);
      setTables(response.data);
    } catch{
      console.log('error');
    }finally{
      setLoading(false);
    }

    
  };
  const courseType = (type) =>{
    if(type===0){
        return "Lecture"
    }else if (type===1){
        return "Lab"
    }else {
        return "Tutorial"
    }
}
const courseSubSection = (section) =>{
    if(section===0){
        return " "
    }else if (section===1){
        return "a"
    }else {
        return "b"
    }
}

const courseDay = (day) =>{
    const days = ["Saturday","Sunday", "Monday","Tuesday","Wednesday","Thursday", "Friday"];
    return days[day];
}

const marks = [
    {
        value: 0,
        label: '0',
    },
    {
        value: 1,
        label: '1',
    },
    {
        value: 2,
        label: '2',
    },
    {
        value: 3,
        label: '3',
    },
    {
        value: 4,
        label: '4',
    },
    {
        value: 5,
        label: '5',
    },
    {
        value: 6,
        label: '6',
    },    
]
   useEffect(() => {
 
  },[tables])
  return (    
    <ThemeProvider theme={mdTheme}>
      <Box sx={{ display: 'flex' }}>
        <CssBaseline />
        <AppBar position="absolute" open={open} style={{backgroundColor:`#03045e`}}>
          <Toolbar sx={{ pr: '24px'}} >
            <IconButton edge="start" color="inherit" aria-label="open drawer" onClick={toggleDrawer} sx={{ marginRight: '36px', ...(open && { display: 'none' }), }} >
              <MenuIcon />
            </IconButton>
            <Typography component="h1" variant="h6" color="inherit" noWrap sx={{ flexGrow: 1 }} >
              NU Smart Helper
            </Typography>
          </Toolbar>
        </AppBar>
        <Drawer variant="permanent" open={open}style={{background:`#03045e`}} >
          <Toolbar sx={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-end', px: [1],backgroundColor:`#03045e` }} >
          <img src={logo} alt="logo" style={{ width: "180px", height:"60px" }} />

            <IconButton onClick={toggleDrawer}>
              <ChevronLeftIcon style={{color:`#fff`}}/>
            </IconButton>
          </Toolbar>
          <Divider />
          <List component="nav" >
            {mainListItems}
            <Divider sx={{ my: 1 }} />
            {secondaryListItems}
          </List>
        </Drawer>
        <Box component="main" sx={{ backgroundColor: (theme) => theme.palette.mode === 'light' ? theme.palette.grey[100] : theme.palette.grey[900], flexGrow: 1, height: '100vh', overflow: 'auto', }} >
          <Toolbar />
          <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
            <Grid container spacing={3}>
              {/* Search Courses */}
              <Grid item xs={12} md={8} lg={9}>
                <Paper sx={{p: 2,display: 'flex',flexDirection: 'column',maxheight: 400,overflow: 'auto',backgroundColor: `#caf0f8`}}>
                    <Grid container spacing={3} >

                        <Grid item xs={9} md={8} lg={9} >
                                <Autocomplete disablePortal id="combo-box-demo" options={coursesList} inputValue = {selectedCourse} onChange={(event, newValue) => { setSelectedCourse(newValue); }}  renderInput={(params) => <TextField {...params}   label="Search Courses" />} />
                            </Grid>
                            <Grid item xs={3} md={4} lg={3}>
                                <Button sx={{backgroundColor: `#0077b6`}} variant="contained" onClick={() => {addCourse();}} >Add</Button>
                            </Grid>
                    </Grid>
                </Paper>
            </Grid>
              <Grid item xs={12} md={8} lg={9}>
                <Paper sx={{p: 2,display: 'flex',flexDirection: 'column',maxheight: 400,backgroundColor: `#0077b6`}}>
                    <Paper elevation={0} style={{minHeight: 400,maxHeight: 600, overflow: 'auto',backgroundColor: `#0077b6`}}>

                                <List>
                                  {tables && tables.map((table, index) => (

                                    <Paper key  ={index}sx={{ p:2, m: 2,backgroundColor: `#caf0f8`, alignItems:'center'}}>
                                      <Typography> Table number {index+1} </Typography>
                                      {table.map((course, index)=>(
                                        <Paper key  ={course.id}sx={{ p:2, m: 2,backgroundColor: `#caf7b8`}}>
                                          <Typography> {course.courseId + " " + course.courseName} </Typography>
                                          <Typography> Section: {course.section } </Typography>
                                          <Typography> {course.courseType + " " + course.section} </Typography>
                                          <Typography> {course.schedule[0].dayDesc + " " + course.schedule[0].startTime + " - " + course.schedule[0].endTime} </Typography>
                                          <Typography> Instructor :{ course.instructors[0].fullName}</Typography>
                                        </Paper>
                                      ))}
                                      <Button >Choose Table</Button>
                                    </Paper>
                                  ))}
                                                                     
                                </List>
                    </Paper>
                </Paper>
              </Grid>
              {/* Recent Deposits */}
              <Grid item  xs={12} md={4} lg={3} sx={{flexDirection:'row'}}>
                <Paper sx={{ p: 2, display: 'flex', flexDirection: 'column', minHeight:350 ,backgroundColor: `#caf0f8` }}>
                  <List>
                    <Typography variant="h6">Added Courses</Typography>
                    <Divider/>
                    {addedCourses && addedCourses.map((course) => (
                        <ListItem key={course}>
                            <ListItemText primary={course} />
                            <ListItemSecondaryAction>
                                <IconButton edge="end" aria-label="delete" onClick={() => {removeCourse(course);}}>
                                    <DeleteIcon />
                                </IconButton>
                            </ListItemSecondaryAction>
                        </ListItem>
                    ))}

      
      
      
                  
                  </List>
                </Paper>
                <Paper sx={{ m:1, p: 2, display: 'flex', flexDirection: 'column', backgroundColor: `#caf0f8` }}>
                    <Typography>Number of days to go </Typography>
                    <Slider
                        aria-label="Temperature"
                        defaultValue={5}
                        valueLabelDisplay="auto"
                        step={1}
                        marks={marks}
                        min={1}
                        max={6}
                    />
                    <FormControl>
                        <FormLabel id="demo-radio-buttons-group-label">Days To go</FormLabel>
                            <RadioGroup
                                aria-labelledby="demo-radio-buttons-group-label"
                                name="radio-buttons-group"
                            >
                                <FormControlLabel value="Sunday" control={<Radio />} label="Sunday" />
                                <FormControlLabel value="Monday" control={<Radio />} label="Monday" />
                                <FormControlLabel value="Tuesday" control={<Radio />} label="Tuesday" />
                                <FormControlLabel value="Wednesday" control={<Radio />} label="Wednesday" />
                                <FormControlLabel value="Thurusday" control={<Radio />} label="Thurusday" />
                                
                                
                            </RadioGroup>
                    </FormControl>
                </Paper>
                <Paper sx={{ m:1, p: 2, display: 'flex', flexDirection: 'column', backgroundColor: `#caf0f8` }}>
                  <Button sx={{backgroundColor: `#0077b6`}} variant="contained" onClick={() => {getData();}}  >Generate Tables</Button>
                </Paper>
              </Grid>              
            </Grid>
            <Copyright sx={{ pt: 4 }} />
          </Container>
        </Box>
      </Box>
    </ThemeProvider>
  );
}

export default function TableMaker() {
  return <DashboardContent />;
}