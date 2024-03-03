from flask import Flask, render_template, request
from numpy.linalg import norm
from numpy import dot

app = Flask(__name__)

def cosine_similarity(A, B):
    return dot(A, B) / (norm(A) * norm(B))



# Define the list of female characters

female_characters = [
    {
        "name": "Ada Lovelace",
        "image" :"ada_lovelace.jpg",
        "vector": [0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        "biography": "Ada Lovelace was an English mathematician and writer, known for her work on Charles Babbage's proposed mechanical general-purpose computer, the Analytical Engine. She is often regarded as the first to recognise the full potential of a computing machine and the first computer programmer.",
        "similarities": "Known for her mathematical genius and visionary insights into computing.",
        "fun_facts": "She was the daughter of the poet Lord Byron, which added a poetic dimension to her analytical mind.",
        "inspiration": "Her pioneering work laid the foundations for the modern computing era, inspiring countless women in STEM."
    },
    {
        "name": "Grace Hopper",
        "image": "grace_hopper.jpg",
        "vector": [1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0],
        "biography": "Rear Admiral Grace Murray Hopper was an American computer scientist and United States Navy officer. A pioneer of computer programming, Hopper was one of the first programmers of the Harvard Mark I computer and developed the first compiler for a computer programming language.",
        "similarities": "Her tenacity and pioneering spirit in computer science are legendary.",
        "fun_facts": "She popularized the term 'debugging' for fixing computer glitches after removing an actual moth from a computer.",
        "inspiration": "Grace Hopper's contributions to computer science revolutionized the way we think about software development and programming."
    },
    {
        "name": "Margaret Hamilton",
        "image": "margaret_hamilton.jpg",
        "vector": [1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0],
        "biography": "Margaret Hamilton is an American computer scientist, systems engineer, and business owner. She was director of the Software Engineering Division of the MIT Instrumentation Laboratory, which developed on-board flight software for NASA's Apollo space program.",
        "similarities": "Her problem-solving skills and dedication to software reliability set her apart.",
        "fun_facts": "Her work on the Apollo software project helped land astronauts on the moon and safely return them to Earth.",
        "inspiration": "Hamilton's pioneering software engineering work is considered one of the foundations of modern software practices."
    },
    {
        "name": "Radia Perlman",
        "image": "radia_perlman.jpg",
        "vector": [1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1],
        "biography": "Radia Perlman is an American computer programmer and network engineer. She is most famous for her invention of the spanning-tree protocol (STP), which is fundamental to the operation of network bridges, and for her work on link-state routing protocols.",
        "similarities": "Her innovative thinking and contributions to network engineering have been critical.",
        "fun_facts": "Often called the 'Mother of the Internet,' her inventions made today's internet possible.",
        "inspiration": "Perlman's work demonstrates the impact of robust and reliable network infrastructure on global communication."
    },
    {
        "name": "Barbara Liskov",
        "image": "barbara_liskov.jpg",
        "vector": [1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1],
        "biography": "Barbara Liskov is an American computer scientist who is an institute professor at the Massachusetts Institute of Technology (MIT). Liskov developed the Liskov Substitution Principle, which is a principle of object-oriented programming.",
        "similarities": "Her groundbreaking work in programming languages and software design has set standards in the field.",
        "fun_facts": "In 2008, she was awarded the Turing Award, often considered the 'Nobel Prize of computing,' for her contributions to practical and theoretical foundations of programming language and system design.",
        "inspiration": "Liskov's contributions have significantly influenced the development of modern programming languages and software engineering practices."
    },
    # Add more characters here
]



test_questions = [
    {"question": "I sometimes feel like giving up when I encounter difficult problems in computer science", "id": 1},
    {"question": "I understand that setbacks and failures are opportunities for growth and learning", "id": 2},
    {"question": " I have a passion for science", "id": 3},
    {"question": "There were times that I felt like I was the only not smart person in the room ", "id": 4},
    {"question": " I enjoy exploring different topic", "id": 5},
    {"question": "  I am a  self motivated person", "id": 6},
    {"question": "I have been taking computer science related classes before high school", "id": 7},
    {"question": "I do not have much coding experience and I feel self conscious  about it ", "id": 8},
    {"question": "I doubted whether computer science is for me ", "id": 9},
    {"question": "I want to invent something that never existed before using my computer science related skills ", "id": 10},
    {"question": "There were times that I felt frustrated of how slow I was while completing coding assignment when my friends understood it quickly finished without a problem ", "id": 11},
    {"question": "There were times that I felt like computer science is not for women", "id": 12}
    
     
    # Add more questions as needed
]

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/take_test')
def take_test():
    # Display the test questions with True/False buttons
    return render_template('take_test.html', questions=test_questions)


@app.route('/personality_test', methods=['POST'])
def personality_test():
     # Initialize an empty vector for the responses
    responses = []
    # Iterate over each question and add the response to the vector
    for question in test_questions:
        response = request.form.get(f"question_{question['id']}", "0")
        responses.append(int(response))
        
    highest_similarity = -1
    matched_character = None
    
    
    for character in female_characters:
        similarity = cosine_similarity(responses, character["vector"])
        if similarity > highest_similarity:
            highest_similarity = similarity
            matched_character = character
    
   # print("Responses Vector:", responses)
    
    # Here you can implement the logic to determine the match based on responses
    #matched_character = female_characters[0]  # Placeholder for matched character
    return render_template('result.html', character=matched_character)
    #return render_template('result.html', character=matched_character)

if __name__ == '__main__':
    app.run(debug=True, port= 5234)
    