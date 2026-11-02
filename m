Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604895;
	b=bUyIL2RxrLtXIuHEuJaD4PsRbUpNYSmr+YCeeqrHYCxg91W04zUUyXm318nD2pvCS5TO
	 seqh2d0tM7oZ3KNHNc7FUCE0jMe0KuQusIQe36z9jvHcQwCD2DHHcb8T1wqEq64sSAzEM
	 z5doDQB4qlrM7O8TtIee7sdrPA8em5FcLb5kH+7ZMlCrNDqXXEUk9DYVh6cReTlN/VOXS
	 6YRr03qP0LZ9PI9f9UC9fw/GNVEb12JB/2fKDQ7Y7WzVS0vQfIx9vDbkr2TMvdiwtRouL
	 q7R2wbDIPol14rwKmp59FKdyW5ZfY4ob0djMBxk6ClGBr2BC4Pxe0D2rcv3Tvvum7qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9T5LkrQk4slGV/16n1Vm0fv2Bqad8AN58NGlmXOqvoQ=;
	b=5Q+k0GzUsQCK4Q+VKH3tkfgvlGmtRu9TAo56SVRoLN4WXuZwERV+z+mG8I5O3k4CTJn4
	 ZiCFgmhWK3hJDqhLh8Ul6zmpNpd9G1u2SQRgQOXVZiRCAb7Few7flaaPxvNMN9OefSkCm
	 JnXxCK/HPW1vdL/0vMZzUSmhjKeqF8B5UBtYVgDsNUJcts9kEajIZpJZXJm6B5XALn/m1
	 ExjYUiHiACA/8OOZbSQRhOLF9HQDe/wtN2HLtrM1nuD6fQkSYeSptgfsbfABre251eVvl
	 Ojnk0fZJdbGe1mv13NeRUL0Bc10StQ1/nI5XF+Zm4ML1gae8QBRbfFXtE3MtsJyaMww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Ct3iwYA1;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDC606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EDC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Ct3iwYA1
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab41538192so2191912a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793604894; x=1794209694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9T5LkrQk4slGV/16n1Vm0fv2Bqad8AN58NGlmXOqvoQ=;
        b=Ct3iwYA168FHqwSEv/3CjWFjpjR6u5RYdQSxaySg7P3eDV5N7xGG8hvA1qAbsLb2AA
         YIK/OQqqORM22rSFaYVUe+dbw4mwocxLzTHWdmSk4toRj0tB5kajTI8x/pyf/9lJ6jvP
         cMmXf0cuph7+Sv52hls5oy6RGlTrzohzhrb3gw0/OQbJEjBRJE6tlhSFAm5bplEgwViC
         ERkwGdUrGL46ke5ZesaxG7uPIfOdSsfpoMSR7uCmClkWPEPF4/ULcHK3kwp6LVdAaOdo
         Npw2WI3KNp4OkPhs2011rMZ4+8pykJrc1pozMO39iBOb0HWqepUBcJaVXAqVaOBuXz8d
         uQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604894; x=1794209694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9T5LkrQk4slGV/16n1Vm0fv2Bqad8AN58NGlmXOqvoQ=;
        b=2cILamUAvZ2JU8Ou4EYhWled/8hX4jZYcE64LancxRDpezPR2CGlTIgbyyaTLcsCZf
         qt3GybtdeAzOryo4B8y7+VHBitdXuepuAQ6dtKwTASVoY+enMQ0hxw/K5QFVV1eAwglX
         4gtMjcJEL/6WuhTWc7GJlTc+xhg9Fjw7vDhAkA8tx0aGJgX2uH1fJpR3j0j7495l/iLs
         OLKrr/+dUjb83R1I+06ug+oFgn5k5BkhvHJMFQNU2RJlVxqW3qZi3QP4aXea8KzYOlN3
         gHUuDxVRTgDBq4aGTjslS8zF+Ex6ZnNV7lQFZZEwIPTcI03qBKhN2gI5fOJ9laWP/5yw
         +s7g==
X-Gm-Message-State: APuU4Z9rXZxc9MHSUOCeqYg3H4v330g3NsU5M5cGxegywFY1pIAOXpJT
	pqJH5S08Qg2uoCqb+QIQfIBHUJwvkWPvMK02bLaXIMwPTLL7zUT+83c915clmLQEotXQ5MYJudH
	cy8fN
X-Gm-Gg: AYBFou06CFTvihri/2O4jBYHXZ1mDiFNq3BvmZbnWf8JkJWudMx9utEO34WipHJYa/V
	HOOI4rGE738tbhCao5U+XalxVFaliw3sD4rRmMIcXlFNTmTxVid8BzQPoyQ9lUqP9S8eAvthiRN
	kUU6u50MRC16rQGNd/Fm9XGImT9cp8r4vtghsjcY34qFMNjlOfefs8dC9ArdzASnV52SNMhI+Q+
	BNYnjMRN+4mZ4LGNy/+eI+mmYVL9leBJRWrb+NBPOYusFlCqsDqRkdOTx+oOb2oJMIVVs3+ic4h
	xkjueTk/cluuGQOOjqrGiaejQNIzWOg5dBu0Qaqih7ltCsZCWgIRG7L0h4vhR4M4Gjco8qYXz5q
	A7mtH1Afh5xDoPTnjw+PFDdeF+iHJW2aDOuZE9aCkqRCmJ6lPFcpyEYPnSF6v8lqJiumuHJG8Pz
	65rbftG5jhucVGOjoHzkBk6lYlZ94vea5uxR/NxOppigYRX5W4RhJOKE+iLyLj0DuZG/PGYxI7y
	DfrfvT4xMMuUxJewN8C+VSOGlDBO5akkXHllnNPSk5mK2zYqGQud4m6dsToae4dyVr+nz5PaIrE
	fmR+a2o+LRS+E/j6kH9lFupBKDYLsSRv7GhUWtb7kUM1CjIGQTOEkr35duwaq5ic9uDX
X-Received: by 2002:a17:90b:4cd0:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3ae8974b76dmr7507735a91.29.1793604894441;
        Sun, 01 Nov 2026 23:34:54 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9db612sm17551965a91.17.2026.11.01.23.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:34:54 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add a selftest for program allocation/freeing
Date: Mon,  2 Nov 2026 07:34:39 +0000
Message-ID: <20261102073439.6822-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102073439.6822-1-emil@etsalapatis.com>
References: <20261102073439.6822-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that stresses BPF program allocation/free
paths.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/bpf_prog_free_stress.c      | 184 ++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_prog_free_stress.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 986a6389186b..ba72f8ac1f72 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -2,6 +2,7 @@
 bpftool
 bpf-helpers*
 bpf-syscall*
+/bpf_prog_free_stress
 test_verifier
 test_maps
 test_lru_map
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 93c707116fad..e59e07c4bd12 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -137,6 +137,7 @@ TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
+	bpf_prog_free_stress \
 	bench \
 	flow_dissector_load \
 	test_cpp \
diff --git a/tools/testing/selftests/bpf/bpf_prog_free_stress.c b/tools/testing/selftests/bpf/bpf_prog_free_stress.c
new file mode 100644
index 000000000000..8c761845c703
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_prog_free_stress.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <err.h>
+#include <linux/bpf.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "../../../include/linux/filter.h"
+
+/*
+ * Spread allocations over vmap nodes, then queue frees from CPU0, whose purge
+ * helper runs asynchronously. Tiny programs fill packs densely enough to build
+ * a backlog exceeding the system workqueue's active-work limit.
+ */
+#define LOAD_CPUS 64
+#define PROGRAMS 65536
+#define WAITERS 1024
+#define DEFAULT_DURATION_SEC 5
+
+static int fds[PROGRAMS];
+static const struct bpf_insn insns[] = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+};
+
+static void pin_cpu(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask))
+		err(EXIT_FAILURE, "sched_setaffinity CPU%d", cpu);
+}
+
+static int load_prog(void)
+{
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+		.insn_cnt = sizeof(insns) / sizeof(insns[0]),
+		.insns = (uintptr_t)insns,
+		.license = (uintptr_t)"GPL",
+	};
+	int fd;
+
+	fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (fd < 0)
+		err(EXIT_FAILURE, "BPF_PROG_LOAD");
+	return fd;
+}
+
+static void *load_worker(void *arg)
+{
+	int cpu = (uintptr_t)arg;
+	int first = cpu * (PROGRAMS / LOAD_CPUS);
+	int i;
+
+	pin_cpu(cpu);
+	for (i = first; i < first + PROGRAMS / LOAD_CPUS; i++)
+		fds[i] = load_prog();
+	return NULL;
+}
+
+static void *load_waiter(void *arg)
+{
+	(void)arg;
+
+	pin_cpu(0);
+	if (close(load_prog()))
+		err(EXIT_FAILURE, "close waiter program");
+	return NULL;
+}
+
+static void check_pthread(int error, const char *operation)
+{
+	if (error)
+		errx(EXIT_FAILURE, "%s: %s", operation, strerror(error));
+}
+
+static void run_threads(int count, void *(*worker)(void *))
+{
+	pthread_t threads[WAITERS];
+	pthread_attr_t attr;
+	int i;
+
+	check_pthread(pthread_attr_init(&attr), "pthread_attr_init");
+	check_pthread(pthread_attr_setstacksize(&attr, 64 * 1024),
+		      "pthread_attr_setstacksize");
+	for (i = 0; i < count; i++)
+		check_pthread(pthread_create(&threads[i], &attr, worker,
+					     (void *)(uintptr_t)i),
+			      "pthread_create");
+	for (i = 0; i < count; i++)
+		check_pthread(pthread_join(threads[i], NULL), "pthread_join");
+	check_pthread(pthread_attr_destroy(&attr), "pthread_attr_destroy");
+}
+
+static long monotonic_sec(void)
+{
+	struct timespec now;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &now))
+		err(EXIT_FAILURE, "clock_gettime");
+	return now.tv_sec;
+}
+
+static long parse_duration(int argc, char **argv)
+{
+	char *end;
+	long duration;
+
+	if (argc == 1)
+		return DEFAULT_DURATION_SEC;
+	if (argc != 2)
+		errx(EXIT_FAILURE, "usage: %s [duration_sec]", argv[0]);
+
+	errno = 0;
+	duration = strtol(argv[1], &end, 10);
+	if (errno || *end || duration <= 0)
+		errx(EXIT_FAILURE, "usage: %s [duration_sec]", argv[0]);
+	return duration;
+}
+
+static void run_burst(int round)
+{
+	struct sched_param priority = { .sched_priority = 80 };
+	int i;
+
+	printf("Round %d: loading %d programs across %d CPUs\n", round,
+	       PROGRAMS, LOAD_CPUS);
+	run_threads(LOAD_CPUS, load_worker);
+	printf("Round %d: loaded %d programs; closing from CPU0\n", round,
+	       PROGRAMS);
+
+	if (sched_setscheduler(0, SCHED_FIFO, &priority))
+		err(EXIT_FAILURE, "sched_setscheduler SCHED_FIFO");
+	for (i = 0; i < PROGRAMS; i++)
+		if (close(fds[i]))
+			err(EXIT_FAILURE, "close program %d", i);
+	priority.sched_priority = 0;
+	if (sched_setscheduler(0, SCHED_OTHER, &priority))
+		err(EXIT_FAILURE, "sched_setscheduler SCHED_OTHER");
+
+	printf("Closed %d programs; starting %d allocation waiters\n",
+	       PROGRAMS, WAITERS);
+	run_threads(WAITERS, load_waiter);
+}
+
+int main(int argc, char **argv)
+{
+	struct rlimit limit = { PROGRAMS + 1024, PROGRAMS + 1024 };
+	long duration = parse_duration(argc, argv);
+	long start;
+	int round = 0;
+
+	setvbuf(stdout, NULL, _IOLBF, 0);
+	if (sysconf(_SC_NPROCESSORS_ONLN) < LOAD_CPUS)
+		errx(EXIT_FAILURE, "need at least %d online CPUs", LOAD_CPUS);
+
+	if (setrlimit(RLIMIT_NOFILE, &limit))
+		err(EXIT_FAILURE, "setrlimit RLIMIT_NOFILE");
+	limit.rlim_cur = limit.rlim_max = RLIM_INFINITY;
+	if (setrlimit(RLIMIT_MEMLOCK, &limit))
+		err(EXIT_FAILURE, "setrlimit RLIMIT_MEMLOCK");
+	pin_cpu(0);
+
+	printf("Running for %ld seconds\n", duration);
+	start = monotonic_sec();
+	do {
+		run_burst(++round);
+	} while (monotonic_sec() - start < duration);
+
+	printf("Completed %d rounds\n", round);
+	return EXIT_SUCCESS;
+}
-- 
2.52.0

