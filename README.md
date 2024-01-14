# DevOps Hub - A Demo Social Media App (NodeJS + React + MySQL)

This is a simple demo social media app originally created to teach DevOps
from the perspective of running on Virtual Machines (VMs) vs Containers

## Features

1. User registration and login
2. Ability to Create/Read/Update/Delete text only posts like `X`
3. Ability for public to view posts

## Components

### 1. The Backend - NodeJS + Express

uses Node.js + Express.js to create the backend (the API)

### 2. Frontend - React

I am no Javascript dev, but React seems to be the most popular one these days, let's go with it

### 3. Database - MySQL

While MySQL may not be the ideal database for a social media application, we are not building the
next `X`, and I wanted to pick something where most people are familiar with. So I chose MySQL

## Setting it up / Running it

We will be running/setting up this in two separate ways
1. Using a single Virtual Machine
2. Using Docker

### 1. Everything on a single VM

I recommend you setup a dedicated Virtual Machine (Running Debian 12)

#### Setting up NodeJS

Ensure you have NodeJS setup. Refer [HERE](./docs/setting-up-nodejs.md)



### 2. Using Docker