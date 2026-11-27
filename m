Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805908;
	b=ojZHVllYeMPMwfa0ItKRLF0Nq9PPnmILDQvudqtTz4gC2Nr59sKectLdQuT2zcr31VoN
	 cLN3i+6J/h6wvQu4LFCIb3wxlnXoCSyxfMRHRKOG0CO2eguqZy+254zIeZNrD3vem5Fi0
	 udklIjnlGXky3sAG0KlT7rcA41uq/RKSsGPhZCWjpwwETpj1guJiKYp2f2/3TKGOJrraB
	 IMuQ+95IrtRsobxualR6OvfQXXZMjVEnVFcFT4moVgDqnhfBPIKTtJle3jcLMBCVndSsf
	 SqfPDxxY/vNKkjBYmML3ciku1KsAMT49Ec2OcdrDVhTjTXu4XJX8SUe9VcNqEtxLdRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805908;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UYAk5OCIDhY0tZYkh0/pBMWL6d4j8z+mQiO9Q3KCzDk=;
	b=o5RoE5N50/ZNuEwOIfa6EfHZeYkWQRJZkl4JOsyW/nRwGhJ0g5cOiuL5jLBNG+4y6myQ
	 KvFS5LnxFet+Wc/rzO8dcHSY2A+ZqPX/+yPI9/v2l+4FPLxjU9fTi/O/VSuAMme9Lujxl
	 SCQh8jB94Powjwz3qPmBt5IOuW8IIhwrn0iI0EKB9OnXBYGY9sYJm0fpEUthex/cOItB4
	 k4bIli5V3FkvJQGtZnLgGGvyfGStESDzYp11w0lNxGyjVL6lx3TrcmQKf2covQFxzM/3/
	 xZUdeVnAwcwjRjT/VYppdEZmwTrQ1vGKjIjH1zgSeMZuSs4Zcu3UWg8TLITstuLrlmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=SNI4So+B;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FC60A2600;
	Fri, 27 Nov 2026 18:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 701FC60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=SNI4So+B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795805905;
	bh=UYAk5OCIDhY0tZYkh0/pBMWL6d4j8z+mQiO9Q3KCzDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNI4So+BitHYFar+JbOHww1CKeitCAqdJK/Klo0ZOYcQlaDWsReJ2pr5sLXyylvUl
	 VDPkd+3EzOKqzpdBg03sXWZg5p4W+1U8YGuxgyk7Rwx1elkwaa0tKGWI2MvIMZkSNp
	 TrXcAGHQpQr5ofktCUPCEAUtyvWB+BIBjVzydciDutyyzY+DnD9teTYV3M3vf/biDn
	 LWAJrkgF82R9FwEcFmvQ1bcL3ufgKbS1R7QeJ35ds207R5H9HbTOLxFDwrgXu+Mzls
	 X4WnAvnVtzZmUpc1gVPZZ1yK/OJlmUU9FfgVLzHZvyUqBJ2FSdd40uBLjcNPtNMHfL
	 Zcrj4sj9Nhgnw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbjNx55VDzXmP;
	Fri, 27 Nov 2026 13:58:25 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Aniket Gattani <aniketgattani@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	bpf@vger.kernel.org,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 16/16] selftests/membarrier: Check the core serialization of the sync core command
Date: Fri, 27 Nov 2026 13:58:21 -0500
Message-ID: <20261127185822.158216-17-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
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

MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE promises more than a
memory barrier. Each running sibling thread of the caller executes a
core serializing instruction after the call starts, and before it
runs user-space code again. A thread which is not running executes
one before it resumes user-space. This supports memory reclaim by a
JIT compiler.

On x86, the kernel serializes the core in the IPI handler and in the
scheduler. membarrier_test_barrier counts the memory barriers of each
thread, but not these instructions.

Count them as well. These are the instructions, for x86-64:

 - sync_core() in ipi_sync_core(),
 - the writes to CR3 in switch_mm_irqs_off(),
 - sync_core() in finish_task_switch().

sync_core() issues SERIALIZE or IRET. An IRET cannot be probed, so the
instruction before it is probed instead.

The sync core test case then checks two more things:

 - A call makes each target execute a core serializing instruction
   in the IPI handler. A check where the target was scheduled out is
   dropped.

 - A target can be scheduled in after a task of another mm or after
   a kernel thread. The scheduler then executes a core serializing
   instruction before the target is scheduled out again.

These checks are skipped with page table isolation. The kernel then
serializes the core with the write to CR3 of each return to
user-space, in entry code which cannot be probed.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../membarrier/membarrier_test_barrier.bpf.c  |  11 +-
 .../membarrier/membarrier_test_barrier.c      | 102 +++++++++++++++++-
 .../membarrier/membarrier_test_barrier.h      |   6 ++
 3 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c b/tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c
index 46cfba13f00f..ce18089f8dab 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Count the memory barriers which membarrier relies on, for each
- * registered thread.
+ * Count the memory barriers and the core serializing instructions which
+ * membarrier relies on, for each registered thread.
  *
  * See membarrier_test_barrier.c.
  */
@@ -40,6 +40,7 @@ struct {
 
 /* What the scheduler owes to the thread which it switched to. */
 #define OWES_BARRIER	1
+#define OWES_SYNC_CORE	2
 
 struct cpu_state {
 	/* Slot, plus one, of the thread which this CPU last switched to. */
@@ -111,6 +112,8 @@ int barrier_site(struct pt_regs *ctx)
 		slot = state->slot;
 		if (mask & (1U << MBT_SWITCH_MM))
 			state->owed &= ~OWES_BARRIER;
+		if (mask & (1U << MBT_SYNC_CORE_SWITCH))
+			state->owed &= ~OWES_SYNC_CORE;
 	} else {
 		slot = slot_of(bpf_get_current_task_btf());
 	}
@@ -131,13 +134,15 @@ int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
 	/* The CPU leaves the thread which it last switched to. */
 	if (state->owed & OWES_BARRIER)
 		count(state->slot, 1U << MBT_SCHED_IN_MISSED);
+	if (state->owed & OWES_SYNC_CORE)
+		count(state->slot, 1U << MBT_SYNC_CORE_IN_MISSED);
 	count(slot_of(prev), 1U << MBT_SCHED_OUT);
 	slot = slot_of(next);
 	state->slot = slot;
 	state->owed = 0;
 	/* The cases which need a barrier after the store to rq->curr. */
 	if (slot && next->mm && prev->mm != next->mm) {
-		state->owed = OWES_BARRIER;
+		state->owed = OWES_BARRIER | OWES_SYNC_CORE;
 		count(slot, 1U << MBT_SCHED_IN);
 	}
 	return 0;
diff --git a/tools/testing/selftests/membarrier/membarrier_test_barrier.c b/tools/testing/selftests/membarrier/membarrier_test_barrier.c
index 88c5dbf5d7c7..082f048541b0 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_barrier.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_barrier.c
@@ -36,6 +36,9 @@
  * must then execute a memory barrier after the store to rq->curr,
  * before the target is scheduled out again.
  *
+ * The sync core command is checked in the same way, with the core
+ * serializing instructions.
+ *
  * The instructions are found by their bytes in the kernel text, which
  * is read from /proc/kcore. The list is for x86-64. It depends on what
  * the compiler inlines into the functions it names.
@@ -94,6 +97,10 @@ struct target_stats {
 	atomic_ulong sched_in;
 	/* Scheduled in without a barrier after the store to rq->curr. */
 	atomic_ulong sched_in_missed;
+	/* Checks where the target did not serialize its core. */
+	atomic_ulong sync_core_missed;
+	/* Scheduled in without a core serializing instruction. */
+	atomic_ulong sync_core_in_missed;
 };
 
 struct shared {
@@ -126,6 +133,9 @@ struct target {
 static struct shared *shared;
 static int shared_fd;
 
+/* The targets of this process also check the sync core guarantee. */
+static bool check_sync_core;
+
 static int sys_membarrier(int cmd, unsigned int flags, int cpu_id)
 {
 	return syscall(__NR_membarrier, cmd, flags, cpu_id);
@@ -191,6 +201,11 @@ enum match {
 	MATCH_CR3,
 	/* Instruction with a LOCK prefix. */
 	MATCH_LOCK,
+	/*
+	 * SERIALIZE or IRET, as issued by sync_core(). An IRET cannot be
+	 * probed: the instruction before it is probed instead.
+	 */
+	MATCH_SYNC_CORE,
 };
 
 struct site {
@@ -206,15 +221,21 @@ struct site {
 #define IPI		(1U << MBT_IPI)
 #define SYSCALL		(1U << MBT_SYSCALL)
 #define SWITCH_MM	(1U << MBT_SWITCH_MM)
+#define SYNC_CORE	(1U << MBT_SYNC_CORE)
+#define SYNC_CORE_SWITCH (1U << MBT_SYNC_CORE_SWITCH)
 
 static const struct site sites[] = {
 	{ "ipi_mb", MATCH_MB, IPI },
 	{ "ipi_sync_core", MATCH_MB, IPI },
+	{ "ipi_sync_core", MATCH_SYNC_CORE, SYNC_CORE },
 	{ "ipi_rseq", MATCH_MB, IPI },
 	{ "membarrier_global_expedited", MATCH_MB, SYSCALL },
 	{ "membarrier_private_expedited", MATCH_MB, SYSCALL },
-	/* Switch to another mm: write to CR3. It is a full barrier. */
-	{ "switch_mm_irqs_off", MATCH_CR3, SWITCH_MM, true },
+	/*
+	 * Switch to another mm: write to CR3. It is a full barrier and
+	 * it is core serializing.
+	 */
+	{ "switch_mm_irqs_off", MATCH_CR3, SWITCH_MM | SYNC_CORE_SWITCH, true },
 	/* Switch to the mm which the CPU kept in lazy TLB mode: smp_mb(). */
 	{ "switch_mm_irqs_off", MATCH_MB, SWITCH_MM, true },
 	/*
@@ -222,6 +243,8 @@ static const struct site sites[] = {
 	 * locked instruction of this function counts as well.
 	 */
 	{ "finish_task_switch", MATCH_LOCK, SWITCH_MM, true },
+	/* membarrier_mm_sync_core_before_usermode() */
+	{ "finish_task_switch", MATCH_SYNC_CORE, SYNC_CORE_SWITCH, true },
 };
 
 struct probe {
@@ -320,6 +343,7 @@ static void scan_function(const struct site *site, const struct ksym *sym,
 {
 	unsigned char *text;
 	size_t i, left;
+	int32_t imm;
 
 	text = malloc(size);
 	if (!text || !read_kernel(sym->addr, text, size)) {
@@ -351,6 +375,24 @@ static void scan_function(const struct site *site, const struct ksym *sym,
 			if (insn[0] == 0xf0)
 				probe_insn(site, sym, addr);
 			break;
+		case MATCH_SYNC_CORE:
+			/* SERIALIZE is 0f 01 e8. */
+			if (left >= 3 && insn[0] == 0x0f && insn[1] == 0x01 &&
+			    insn[2] == 0xe8) {
+				probe_insn(site, sym, addr);
+				break;
+			}
+			/*
+			 * iret_to_self() is "pushq $1f; iretq; 1:". Probe the
+			 * push.
+			 */
+			if (left < 7 || insn[0] != 0x68 || insn[5] != 0x48 ||
+			    insn[6] != 0xcf)
+				break;
+			memcpy(&imm, insn + 1, sizeof(imm));
+			if (imm == (int32_t)(addr + 7))
+				probe_insn(site, sym, addr);
+			break;
 		}
 	}
 	free(text);
@@ -630,8 +672,9 @@ static bool check_call(const uint64_t *counters, struct target_stats *stats)
 	unsigned long done = atomic_load(&shared->done);
 	uint64_t ipi = counter(counters, MBT_IPI);
 	uint64_t sched_out = counter(counters, MBT_SCHED_OUT);
+	uint64_t sync_core = counter(counters, MBT_SYNC_CORE);
 	unsigned long started = atomic_load(&shared->started);
-	bool by_ipi, scheduled;
+	bool by_ipi, scheduled, serialized;
 	int spins = 0;
 
 	/* A call is in flight. */
@@ -643,6 +686,7 @@ static bool check_call(const uint64_t *counters, struct target_stats *stats)
 	}
 	by_ipi = counter(counters, MBT_IPI) != ipi;
 	scheduled = counter(counters, MBT_SCHED_OUT) != sched_out;
+	serialized = counter(counters, MBT_SYNC_CORE) != sync_core;
 	if (scheduled) {
 		atomic_fetch_add(&stats->by_sched, 1);
 		return true;
@@ -654,6 +698,8 @@ static bool check_call(const uint64_t *counters, struct target_stats *stats)
 		atomic_fetch_add(&stats->by_ipi, 1);
 	else
 		atomic_fetch_add(&stats->missed, 1);
+	if (check_sync_core && !serialized)
+		atomic_fetch_add(&stats->sync_core_missed, 1);
 	return true;
 }
 
@@ -664,7 +710,8 @@ static void run_target(const struct target *target)
 	const uint64_t *counters;
 	long deadline = now_ms() + target->ms;
 	unsigned long checks = 0;
-	uint64_t first_ipi, first_sched_in;
+	uint64_t first_ipi, first_sched_in, first_sync_core_missed;
+	uint64_t first_sched_out;
 
 	/*
 	 * Register before moving to the CPU. The BPF program then sees
@@ -681,6 +728,18 @@ static void run_target(const struct target *target)
 	atomic_fetch_add(&shared->ready, 1);
 	while (!atomic_load(&shared->registered) && !atomic_load(&shared->stop))
 		sched_yield();
+	/*
+	 * The scheduler serializes the core of a registered process
+	 * only. The target may have been scheduled in before the
+	 * registration. So wait until it is scheduled out, and count
+	 * from there.
+	 */
+	first_sched_out = counter(counters, MBT_SCHED_OUT);
+	while (check_sync_core &&
+	       counter(counters, MBT_SCHED_OUT) == first_sched_out &&
+	       !atomic_load(&shared->stop))
+		usleep(1000);
+	first_sync_core_missed = counter(counters, MBT_SYNC_CORE_IN_MISSED);
 	first_ipi = counter(counters, MBT_IPI);
 	first_sched_in = counter(counters, MBT_SCHED_IN);
 	while (!atomic_load(&shared->stop)) {
@@ -700,6 +759,10 @@ static void run_target(const struct target *target)
 			 counter(counters, MBT_SCHED_IN) - first_sched_in);
 	atomic_fetch_add(&stats->sched_in_missed,
 			 counter(counters, MBT_SCHED_IN_MISSED));
+	if (check_sync_core)
+		atomic_fetch_add(&stats->sync_core_in_missed,
+				 counter(counters, MBT_SYNC_CORE_IN_MISSED) -
+				 first_sync_core_missed);
 }
 
 static void *target_thread(void *arg)
@@ -826,6 +889,9 @@ static void sum_stats(int first, int nr, struct target_stats *sum)
 		sum->ipis += atomic_load(&stats->ipis);
 		sum->sched_in += atomic_load(&stats->sched_in);
 		sum->sched_in_missed += atomic_load(&stats->sched_in_missed);
+		sum->sync_core_missed += atomic_load(&stats->sync_core_missed);
+		sum->sync_core_in_missed +=
+			atomic_load(&stats->sync_core_in_missed);
 	}
 }
 
@@ -838,6 +904,8 @@ static void sum_stats(int first, int nr, struct target_stats *sum)
 	       __sum.by_ipi, __sum.by_sched, __sum.ipis);		\
 	EXPECT_EQ(__sum.missed, 0);					\
 	EXPECT_EQ(__sum.sched_in_missed, 0);				\
+	EXPECT_EQ(__sum.sync_core_missed, 0);				\
+	EXPECT_EQ(__sum.sync_core_in_missed, 0);			\
 	EXPECT_GT(__sum.by_ipi + __sum.by_sched + __sum.missed, 0);			\
 } while (0)
 
@@ -919,8 +987,34 @@ TEST(private_expedited)
 		     MEMBARRIER_CMD_PRIVATE_EXPEDITED);
 }
 
+/*
+ * With page table isolation, the kernel serializes the core with the
+ * write to CR3 of each return to user-space. This write is in the entry
+ * code, which cannot be probed.
+ */
+static bool page_table_isolation(void)
+{
+	char *line = NULL;
+	bool pti = false;
+	size_t len = 0;
+	FILE *f;
+
+	f = fopen("/proc/cpuinfo", "r");
+	if (!f)
+		return false;
+	while (!pti && getline(&line, &len, f) >= 0)
+		pti = !strncmp(line, "flags", 5) &&
+		      (strstr(line, " pti ") || strstr(line, " pti\n"));
+	free(line);
+	fclose(f);
+	return pti;
+}
+
 TEST(private_expedited_sync_core)
 {
+	check_sync_core = !page_table_isolation();
+	if (!check_sync_core)
+		TH_LOG("page table isolation: core serialization not checked");
 	test_private(_metadata,
 		     MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
 		     MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE);
diff --git a/tools/testing/selftests/membarrier/membarrier_test_barrier.h b/tools/testing/selftests/membarrier/membarrier_test_barrier.h
index d615ad1d9e8a..7c31d8cba544 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_barrier.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_barrier.h
@@ -24,6 +24,12 @@ enum {
 	 * the scheduler executed no memory barrier in between.
 	 */
 	MBT_SCHED_IN_MISSED,
+	/* Core serializing instruction of the membarrier IPI handler. */
+	MBT_SYNC_CORE,
+	/* Core serializing instruction of the scheduler. */
+	MBT_SYNC_CORE_SWITCH,
+	/* Like MBT_SCHED_IN_MISSED, for a core serializing instruction. */
+	MBT_SYNC_CORE_IN_MISSED,
 	MBT_NR_COUNTERS,
 };
 
-- 
2.47.3

