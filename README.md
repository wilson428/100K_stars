# 100K Stars

Submission for the March 2018 /r/dataisbeautiful challenge

## Setup

It wouldn't be proper to redistribute the source data in this repo, so first you need to download it into the `/data` directory:

	cd data
	wget https://github.com/astronexus/HYG-Database/blob/master/hygdata_v3.csv?raw=true
	mv hygdata_v3.csv\?raw\=true hygdata_v3.csv
	wc -l hygdata_v3.csv #should find 119,615 lines as of March 12, 2018

Then install the Node packages, after you've made sure `npm` is up-to-date:

	npm install npm@latest -g
	npm install

If installing `canvas` gives you any grief, check out [the dependencies you need for your OS](https://github.com/Automattic/node-canvas#compiling).
