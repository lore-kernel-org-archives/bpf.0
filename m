Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46AD52F
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710479898; cv=none; b=uYs5tlLlYGIbA9EfWD9wX/rvRBniRnB1qFWQOd3sDZHadEn4bZqzUcrNyM+6YBE3+szwvkYROBFZnrpi8N3qV6mJq+7BYcgcwRqpUpCIb6U2VI1eMMocJb+jhfsOAVweawxoHNT0oyJWn129F/yOHlxctf7Y1swQoX45bILrZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710479898; c=relaxed/simple;
	bh=mGo7nMFk6ll6SFskCWi+UUv+92T0erpahBKOw39hgmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W34Pp/j4SUi8am4JFtHCEieuWdLcW/K5pMIPgSOBHI9Or7JrBr94ygtT3m2wHytt2E7FfQgvfCcHNq1Bk3d/HTwQqKdyvF3/HhKoOMotEk9n+1/0KkuIaGlbd3C216kg4qUx4lsSZSmeOayHLsZaglUpy/ZaIKUrWYGUkl17dc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR1oo/z7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR1oo/z7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BACBC433C7;
	Fri, 15 Mar 2024 05:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710479897;
	bh=mGo7nMFk6ll6SFskCWi+UUv+92T0erpahBKOw39hgmg=;
	h=From:To:Cc:Subject:Date:From;
	b=pR1oo/z7GL0kWxP5oOlrlAFA83zIIB36zHJ3KENug2He8i1YZWSUb/dHge18XcF02
	 Opj3JIKDWGbhhyvxdxYlFOgurNVHGkKLnGDFN0SiVN7EPWKHxh83rRdiD+Jf1u7mDB
	 xOfQ1/IgfajdM22pM01FIEaWw1z3K9lnN+M2Zu/S/8hRZupaA4IzG/219yRQYXa5BV
	 wu1qwBIgKZRcgyRJi5P/nkc2aHYd3S0vQlIZLd46032V/cs3KnGkQlsN1JFOviKJzZ
	 GBB7Iw/QEk06PFCZm2qDmZSf/iS4wEmKhemONP9zfXrN/1hsyvcIVvDKYh3fC7Y4HH
	 pJdNPvKSgl+/Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/2] selftests/bpf: scale benchmark counting by using per-CPU counters
Date: Thu, 14 Mar 2024 22:18:12 -0700
Message-ID: <20240315051813.1320559-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When benchmarking with multiple threads (-pN, where N>1), we start
contending on single atomic counter that both BPF trigger benchmarks are
using, as well as "baseline" tests in user space (trig-base and
trig-uprobe-base benchmarks). As such, we start bottlenecking on
something completely irrelevant to benchmark at hand.

Scale counting up by using per-CPU counters on BPF side. On use space
side we do the next best thing: hash thread ID to approximate per-CPU
behavior. It seems to work quite well in practice.

To demonstrate the difference, I ran three benchmarks with 1, 2, 4, 8,
16, and 32 threads:
  - trig-uprobe-base (no syscalls, pure tight counting loop in user-space);
  - trig-base (get_pgid() syscall, atomic counter in user-space);
  - trig-fentry (syscall to trigger fentry program, atomic uncontended per-CPU
    counter on BPF side).

Command used:

  for b in uprobe-base base fentry; do \
    for p in 1 2 4 8 16 32; do \
      printf "%-11s %2d: %s\n" $b $p \
        "$(sudo ./bench -w2 -d5 -a -p$p trig-$b | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)"; \
    done; \
  done

Before these changes, aggregate throughput across all threads doesn't
scale well with number of threads, it actually even falls sharply for
uprobe-base due to a very high contention:

  uprobe-base  1:  138.998 ± 0.650M/s
  uprobe-base  2:   70.526 ± 1.147M/s
  uprobe-base  4:   63.114 ± 0.302M/s
  uprobe-base  8:   54.177 ± 0.138M/s
  uprobe-base 16:   45.439 ± 0.057M/s
  uprobe-base 32:   37.163 ± 0.242M/s
  base         1:   16.940 ± 0.182M/s
  base         2:   19.231 ± 0.105M/s
  base         4:   21.479 ± 0.038M/s
  base         8:   23.030 ± 0.037M/s
  base        16:   22.034 ± 0.004M/s
  base        32:   18.152 ± 0.013M/s
  fentry       1:   14.794 ± 0.054M/s
  fentry       2:   17.341 ± 0.055M/s
  fentry       4:   23.792 ± 0.024M/s
  fentry       8:   21.557 ± 0.047M/s
  fentry      16:   21.121 ± 0.004M/s
  fentry      32:   17.067 ± 0.023M/s

After these changes, we see almost perfect linear scaling, as expected.
The sub-linear scaling when going from 8 to 16 threads is interesting
and consistent on my test machine, but I haven't investigated what is
causing it this peculiar slowdown (across all benchmarks, could be due
to hyperthreading effects, not sure).

  uprobe-base  1:  139.980 ± 0.648M/s
  uprobe-base  2:  270.244 ± 0.379M/s
  uprobe-base  4:  532.044 ± 1.519M/s
  uprobe-base  8: 1004.571 ± 3.174M/s
  uprobe-base 16: 1720.098 ± 0.744M/s
  uprobe-base 32: 3506.659 ± 8.549M/s
  base         1:   16.869 ± 0.071M/s
  base         2:   33.007 ± 0.092M/s
  base         4:   64.670 ± 0.203M/s
  base         8:  121.969 ± 0.210M/s
  base        16:  207.832 ± 0.112M/s
  base        32:  424.227 ± 1.477M/s
  fentry       1:   14.777 ± 0.087M/s
  fentry       2:   28.575 ± 0.146M/s
  fentry       4:   56.234 ± 0.176M/s
  fentry       8:  106.095 ± 0.385M/s
  fentry      16:  181.440 ± 0.032M/s
  fentry      32:  369.131 ± 0.693M/s

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/benchs/bench_trigger.c      | 40 ++++++++++++++++---
 .../selftests/bpf/progs/trigger_bench.c       | 39 ++++++++++++------
 2 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index ace0d1011a8e..8fbc78d5f8a4 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -1,15 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#define _GNU_SOURCE
+#include <unistd.h>
 #include "bench.h"
 #include "trigger_bench.skel.h"
 #include "trace_helpers.h"
 
+/* adjust slot shift in inc_hits() if changing */
+#define MAX_BUCKETS 256
+
 /* BPF triggering benchmarks */
 static struct trigger_ctx {
 	struct trigger_bench *skel;
 } ctx;
 
-static struct counter base_hits;
+static struct counter base_hits[MAX_BUCKETS];
+
+static __always_inline void inc_counter(struct counter *counters)
+{
+	static __thread int tid = 0;
+	unsigned slot;
+
+	if (unlikely(tid == 0))
+		tid = gettid();
+
+	/* multiplicative hashing, it's fast */
+	slot = 2654435769U * tid;
+	slot >>= 24;
+
+	atomic_inc(&base_hits[slot].value); /* use highest byte as an index */
+}
+
+static __always_inline long sum_and_reset_counters(struct counter *counters)
+{
+	int i;
+	long sum = 0;
+
+	for (i = 0; i < MAX_BUCKETS; i++)
+		sum += atomic_swap(&counters[i].value, 0);
+	return sum;
+}
 
 static void trigger_validate(void)
 {
@@ -23,14 +53,14 @@ static void *trigger_base_producer(void *input)
 {
 	while (true) {
 		(void)syscall(__NR_getpgid);
-		atomic_inc(&base_hits.value);
+		inc_counter(base_hits);
 	}
 	return NULL;
 }
 
 static void trigger_base_measure(struct bench_res *res)
 {
-	res->hits = atomic_swap(&base_hits.value, 0);
+	res->hits = sum_and_reset_counters(base_hits);
 }
 
 static void *trigger_producer(void *input)
@@ -42,7 +72,7 @@ static void *trigger_producer(void *input)
 
 static void trigger_measure(struct bench_res *res)
 {
-	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+	res->hits = sum_and_reset_counters(ctx.skel->bss->hits);
 }
 
 static void setup_ctx(void)
@@ -164,7 +194,7 @@ static void *uprobe_base_producer(void *input)
 {
 	while (true) {
 		uprobe_target_nop();
-		atomic_inc(&base_hits.value);
+		inc_counter(base_hits);
 	}
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 5fda43901033..42ec202015ed 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -9,12 +9,27 @@
 
 char _license[] SEC("license") = "GPL";
 
-long hits = 0;
+#define CPU_MASK 255
+#define MAX_CPUS (CPU_MASK + 1) /* should match MAX_BUCKETS in benchs/bench_trigger.c */
+
+/* matches struct counter in bench.h */
+struct counter {
+	long value;
+} __attribute__((aligned(128)));
+
+struct counter hits[MAX_CPUS];
+
+static __always_inline void inc_counter(void)
+{
+	int cpu = bpf_get_smp_processor_id();
+
+	__sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
+}
 
 SEC("tp/syscalls/sys_enter_getpgid")
 int bench_trigger_tp(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
@@ -22,69 +37,69 @@ SEC("raw_tp/sys_enter")
 int BPF_PROG(bench_trigger_raw_tp, struct pt_regs *regs, long id)
 {
 	if (id == __NR_getpgid)
-		__sync_add_and_fetch(&hits, 1);
+		inc_counter();
 	return 0;
 }
 
 SEC("kprobe/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_kprobe(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
 SEC("kretprobe/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_kretprobe(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
 SEC("kprobe.multi/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_kprobe_multi(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
 SEC("kretprobe.multi/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_kretprobe_multi(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fentry(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
 SEC("fexit/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fexit(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
 SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fentry_sleep(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
 
 SEC("fmod_ret/" SYS_PREFIX "sys_getpgid")
 int bench_trigger_fmodret(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return -22;
 }
 
 SEC("uprobe")
 int bench_trigger_uprobe(void *ctx)
 {
-	__sync_add_and_fetch(&hits, 1);
+	inc_counter();
 	return 0;
 }
-- 
2.43.0

