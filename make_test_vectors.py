import random

def generate_test_vector_file(file_name, num_vectors):
    with open(file_name, 'w') as file:
        for _ in range(num_vectors):
            ra1 = ''.join([str(random.randint(0, 1)) for _ in range(5)]) 
            ra2 = ''.join([str(random.randint(0, 1)) for _ in range(5)])
            wa3 = ''.join([str(random.randint(0, 1)) for _ in range(5)])
            wd3 = ''.join([str(random.randint(0, 1)) for _ in range(32)])
            if ra1 == '00000':
                rd1 = '00000000000000000000000000000000'
            else :
                rd1 = wd3
            if ra2 == '00000':
                rd2 = '00000000000000000000000000000000'
            else :
                rd2 = wd3
            vector = ra1 + '_' + ra2 + '_' + wa3 + '_' + wd3 + '_' + rd1 + '_' + rd2
            file.write(vector + '\n')

if __name__ == "__main__":
    file_name = "regfile.tv"
    num_vectors = 10  # Change this to the number of vectors you want
    generate_test_vector_file(file_name, num_vectors)
    print(f"{num_vectors} random vectors have been generated and saved in {file_name}.")
