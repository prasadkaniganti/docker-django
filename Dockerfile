FROM ubuntu

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Copy requirements file and application code
COPY requirements.txt /app
COPY devops /app

# Install Python packages in the virtual environment
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install -r requirements.txt

# Set the command to run your application
ENTRYPOINT ["/opt/venv/bin/python"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
