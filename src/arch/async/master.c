/*
 * MIT License
 *
 * Copyright (c) 2011-2018 Pedro Henrique Penna <pedrohenriquepenna@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.  THE SOFTWARE IS PROVIDED
 * "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <nanvix/arch/mppa.h>
#include <assert.h>
#include <stdlib.h>
#include "kernel.h"

int main(int argc, const char **argv)
{
	((void) argc);
	((void) argv);

	int size;
	utask_t t;
	int status;
	int nclusters;

	assert(argc == 3);
	assert((nclusters = atoi(argv[1])) <= NR_CCLUSTER);
	assert((size = atoi(argv[2])) <= MAX_BUFFER_SIZE);

	mppa_rpc_server_init(1, 0, nclusters);
	mppa_async_server_init();

	const char *args[] = { "slave.elf", argv[1] , argv[2], NULL };
	for(int i = 0; i < nclusters; i++)
		assert(mppa_power_base_spawn(i, args[0], args, NULL, MPPA_POWER_SHUFFLING_ENABLED) != -1);

	utask_create(&t, NULL, (void*)mppa_rpc_server_start, NULL);

	for(int i = 0; i < nclusters; i++)
		assert(mppa_power_base_waitpid(i, &status, 0) >= 0);

	return 0;
}
