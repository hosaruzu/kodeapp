# Kode
Kode is the application that loads the list of employees via API and sorts them by departments.

## Stack
* iOS 13 (UIKit)
* MVVM + Coordinator
* Structured (modern) concurrency
* URLSession + URLCache
* No dependencies

## Features
- Caсhing request for 1 hour
- Custom async image loader with caching to disk and loading indicator 
- Network monitor with connection error popup
  
<br/>

- Shimmer (skeleton) loader
- Custom carousel with empty states
- Searching functionality across all departments
- Filter by ascending/descending order
- Phone call capability
- Error handling including timeout and absence of connection

## Demo
<p>
<img src="content/golden.gif" width="25%" height=auto /> <img src="content/4.filter.gif" width="25%" height=auto />
<br/>
<em>1.First start with searching and navigating to profile screen. <br/>2.Filter</em>
</p>
<br/>
<p>
<img src="content/5.no-internet.gif" width="25%" height=auto /> <img src="content/6.toast.gif" width="25%" height=auto />
<br/>
<em>Network connection error and toast error</em>
</p>
<br/>
<p>
<img src="content/7.dark-mode.gif" width="25%" height=auto />
<br/>
<em>Dark mode</em>
</p>
