<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    // Method to show the home page view
    public function index()
    {
        // Passing data to the view (optional)
        $data = [
            'message' => 'Welcome to the Home Page!'
        ];

        // Returning the view with data
        return view('home', $data);
    }
}
