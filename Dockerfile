# Use Python 3 as the base image
FROM python:3

# Set environment variables (if required)
ENV key=value

# Set the working directory inside the container
WORKDIR /app 

# Copy the requirements.txt to the container and install dependencies
COPY requirements.txt /app
RUN pip install -r requirements.txt 

# Copy the entire project (including manage.py) into the container
COPY . /app 

# Expose port 8000 (the port your Django app will run on)
EXPOSE 8000

# Use the full command to run Django's development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
