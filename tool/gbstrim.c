#include <stdio.h>
#include <stdlib.h>


enum ReturnCodes {
    NO_ERROR,
    FILEIO_ERROR,
    ARGUMENT_ERROR,
    FILE_DESTROYED_ERROR
};

size_t fsize(FILE * file) {
    // Get the size of the file relative to the initial offset.
    long pos = ftell(file);
    fseek(file, 0, SEEK_END);
    size_t size = ftell(file) - pos;
    fseek(file, pos, SEEK_SET);
    return size;
}

int main (int argc, char ** argv) {
    // This tool takes only one argument.
    if (argc < 2) {
        fputs("error: insufficient arguments\n", stderr);
        return ARGUMENT_ERROR;
    }
    if (argc > 2) {
        fprintf(stderr, "error: unrecognized argument: %s\n", argv[2]);
        return ARGUMENT_ERROR;
    }

    // Try to open the file for reading.
    const char * filename = argv[1];
    FILE * file = fopen(filename, "rb");
    if (!file) {
        fprintf(stderr, "error: file not found: %s\n", filename);
        return FILEIO_ERROR;
    }

    // Skip null bytes.
    while (!feof(file) && !fgetc(file));
    if (feof(file)) {
        fprintf(stderr, "error: input file has no data: %s\n", filename);
        fclose(file);
        return FILEIO_ERROR;
    }
    if (ftell(file)) fseek(file, -1, SEEK_CUR);

    // Get the size of the file.
    size_t current_size = fsize(file);
    if (!current_size) {
        fprintf(stderr, "error: input file has no data: %s\n", filename);
        fclose(file);
        return FILEIO_ERROR;
    }

    // Try to read the file's contents starting from the GBS offset.
    char * buffer = malloc(current_size); // this is too large for the stack
    if (fread(buffer, 1, current_size, file) < 1) {
        fprintf(stderr, "error: could not read file: %s\n", filename);
        fclose(file);
        free(buffer);
        return FILEIO_ERROR;
    }
    fclose(file);

    // Trim trailing null bytes.
    while (current_size && !buffer[-- current_size]);
    if (buffer[current_size]) current_size ++; // the loop will go down one byte too many, unless the actual size is zero
    if (!current_size) {
        fprintf(stderr, "error: input file has no data: %s\n", filename);
        free(buffer);
        return FILEIO_ERROR;
    }

    // Try to open the file for writing, overwriting its previous contents.
    if (!(file = fopen(filename, "wb"))) {
        fprintf(stderr, "error: could not open file for writing: %s\n", filename);
        free(buffer);
        return FILEIO_ERROR;
    }

    // Write the file.
    // If the program errors beyond this point, the file will no longer be usable.
    size_t rv = fwrite(buffer, 1, current_size, file);
    free(buffer);
    fclose(file);
    if (rv < current_size) {
        fprintf(stderr, "fatal: could not write file: %s\n", filename);
        return FILE_DESTROYED_ERROR;
    }
    return NO_ERROR;
}
