Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270496;
	b=azOaXKqFoz3DQqRuDWXYYYjEPWidS2jMUwJdMe4UyiDfoAaJjdM5bgFnRb5mxY29/lEi
	 pPyydn9Y+hdoHhSaBhFVqi2MNcLzxumLpStIztQXfLqsAhy1vR510AmQqDSscEbP3MS0P
	 zXJy13iyk1TLGdEPIHmnpVeP91TnZVDNlKkdjaeMhhGyVF7NXULZozY4bdn3ZdnF/U6xh
	 oqcYL/BhASF5DGDz7U9tc/zqf/wpSGHxNJsgxI6/KZOqt3cyh4dWVmSZTY47AAMvwtV7a
	 vICdyPIsXfJ3ZLXkHU1M2xi+qlC0Ie3fnkWV+VzO1TJ5VhFMlkdppHTPKWY01aZGM3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=3g7kfyVBhaRbyTmppBNdIyKQbxI92hU1r88LdkjjqH0=;
	b=nhDZCw7iVebmJ8IWIm/eZTnIVkt7zV9xX9nNVoEcFpQ+44cLJrkcSXVuEFfo/8pof31Y
	 pEpTC/3bNrmq4EKeMWSCScWq5xzSftpT+9TCQe8BmHf+/gSHB/vjmTh0OKcXEKUmYMAIK
	 scuflneeDsxAlugcMpkzsYhcXOGfsOm9dHD3KMTsZnvPVdG3Ux0v9BNr2dZataozTt30w
	 bdONUIMaaBKALSCY46B71Jzwm2LcIfGlO1vLe10FSOAsdxbHf65CPfyuCisrgA4Umou3I
	 xiP8fU0l5TkWCwVsvW1r6Tn84+z11L9t63mqq85RcxE2hCTUp+UMP3IXkcOvPeZWolw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n1I5eNUp;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30F606A330
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F30F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n1I5eNUp
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4912e5f330dso687451f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270494; x=1794875294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3g7kfyVBhaRbyTmppBNdIyKQbxI92hU1r88LdkjjqH0=;
        b=n1I5eNUp5nkJobVFDgAWa2ksSYkDRBAD3uyr7SC/Iv6aP/IflzkYEBbuhKtTxsM9Rf
         6wkE/OHi3CODY/sXkrd6ZB3EQFI2kttmAlu+Vp87rzhHX93DJPgF2YIs/DH5JhRYXCl2
         ab3xiJuBQF4goQ8zmHpaOq1HZWhmk5ePbsu/prC1Ksd/kxBRNehpojy5lV1KW0MAep+l
         XA3Z4LHrEQYKW8eTpAGGci4kEL6cmhB9nC4nCKU4ofF3ZxDNfwMf1RaWrn1yr3MxuZAF
         phIDpw1eAesx31QSpKspJm4uUFs733EjNwJ4j3lBv1Ai6q2NLo0ismtiG/zEB00mAoHB
         69Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270494; x=1794875294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3g7kfyVBhaRbyTmppBNdIyKQbxI92hU1r88LdkjjqH0=;
        b=TyyavwxuBEpQyDLYAySSvZdCSAcbZZJrTJImFc90gn0gX0XY4HLKPg6eRuApWq9JOE
         vAZZb8R2kCrH35TgbB2LJICXl5PYDIb0doxzFfBsYSgcCjVzhZIJeYOazOfUogXqqDcb
         eD0LoLsTG1dT95H/155lxviIO9cXJDO+qzQA6FY6ohkW8ixkxt3bR2LZDTCBtp+tFm42
         ziJzkew6IaJv7aJK48C7QC7LEvOVtMDcnxAuHuhEhyiHyzUcrua4mZIhvgzyTaJ08u2b
         JIbM0NRS4tkKARAFUsOH9k+WdSVhS1fZyrKjJX6a1G78Cg+1meA87x4QxQ2VIegh/tXu
         xFIw==
X-Gm-Message-State: APuU4Z9DgLzEy442mrXGMMnwAW27tj9HPrZbnaVGwqy1LIeDhdeS3D1t
	3CIA0mGbiF4z2S/Ztqzjd9f5O3K3fRo/QT3mmu6INkp2EC/UL61JBZBhqmXWpDbJ
X-Gm-Gg: AYBFou3z7PT3rhZjkAozftjoIBNPh3YvW/amGW0Zl7O5/qpjiB2/eYebaR4s+Kz008U
	Upw6iqxUCcYX4JEpkjeDHLc2DFvjVltv0dN9Xr8gIqufo+L3SBlJJIgsVAuRQ1E7hhdEwMLLuHv
	p/ha4v1wVRpCzMKvy20mVXJzA6zs4Q2oJkTozLU1290n7sHZwQ3Ax7vawiIXvIhFHznWr0W/4f7
	gbQm2EgksSTBDekBfhfeUOiq0/HTNCv6SZpxpyXH6UuNpy9NHV89ePOCh3QOibUeFNn2tOS1/Ib
	unDWLPEAWqc20owM2GXw99hr+Rt0q1p7E7hcOvKnja0uDNJOnofy0VwSAkgYDWNoVik1zBaPi0Y
	NuZwT6Tw8WVvESbMHBNpK+YhiggUDwMjARt4OTbtFBU/WwN4PApXJ7pgoK8eH9DKkY7+dsqjQaD
	RRuDikH714RF7z+NLZfgVDbiYSMKapRJNTw7OQda6jZkCmSKSwEWgZZYKabig6LQ71M4RXRvSTM
	5sULm+FSIwCtpGD9n6pjeWCx8be8u7BIXDt3F8okh0SGVslTlHekHVHkqOcvRO+kIIFQLKrUm8M
	opXX4Bg2kf+8ow3F06aKCl5AjYMD8dDMoaKC17SG26mfKfdtbElO6tDkuqvKHkKTbTJNjG3Ui/p
	MDjX8Yo1BaQgr1rijUkCvlPyNv5n0L2iHXoGaKVIX0pvTzKgQ+mtHkhgnoDCrbF/nIk3McvFPYb
	dB350E7eNKH7E3Nw==
X-Received: by 2002:a05:600c:3b93:b0:4b3:ad9d:e21 with SMTP id 5b1f17b1804b1-4ba0233fdf5mr16416995e9.12.1794270493931;
        Mon, 09 Nov 2026 16:28:13 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc8fsm1672605f8f.30.2026.11.09.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:13 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 15/20] selftests/bpf: Test what survives bpf_task_park()
Date: Tue, 10 Nov 2026 01:27:37 +0100
Message-ID: <c9ddff388d86013c3988da460ad403d2191840f7.1794269507.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18502; i=memxor@gmail.com; h=from:subject:message-id; bh=EJTNQgjn8BNPEOWnZxKHtrnoTrf8xTGX7zr+bq8BwWU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTosekm8ks2REMz4Ti3fx1mLI6xXkk/KpunHktsX6l1 RtJuWMdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMhiR4b/foluk449l6q8fkzv ceT/b8/5VucuXyvCaiVVxbL5Zt7Lv4wMC5p2rp1Qonfn0Y5/f2ZqZrZV3il9zrDuvcDe3UWPrXa +4QcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Pin the verifier's contract for a park in the main program: what the
sleep lets go, what the program keeps, and where the call is refused.

Gone after the park: a hash map value, in a register or spilled to the
stack, since a concurrent delete frees the element after a grace period
the sleeper no longer delays; a per-CPU array value, since the task may
resume on another CPU; a trusted task pointer without a reference; an
inner map pointer found through a map-in-map lookup, and a value of
that inner map even though the inner map is an array, since only the
outer element holds it.

Kept: a referenced task; the stack; the context; an arena pointer; the
pointer to a map the program references directly; a value of the
program's own array map, which the map allocates and frees with
itself; and a global variable read in a loop around the park, which is
the case that matters in practice, since globals are array values and
the compiler hoists their address out of the loop. Whether it hoists is
its own choice, so the hoisted form is pinned in assembly as well.

Refused: a live dynptr on the stack, local or ringbuf-backed, and a live
bits iterator, both named with their frame, because the verifier can
neither invalidate them without breaking the slot invariants nor
release them on the program's behalf; the tests match the frame only,
since the stack offset depends on the compiler. A bpf_iter_num loop
around a park is accepted, since its state lives on the stack. Also
refused: a park under bpf_spin_lock or bpf_res_spin_lock, inside an
RCU read section, a preempt-disabled region or an IRQ-disabled region,
each with the verifier's exact message, and a park from a program type
it is not registered for. The wake is registered for every type, which
an XDP program that wakes pins.

Refused for now as well, since each keeps state per CPU across the run:
a park in a program with a may_goto, be it the program's own or the one
the verifier adds to a loop without a bound, and a park in a program
that uses the stack in arena, which is tested next to the other uses of
R12.

For bpf_task_wake(), an untrusted task pointer and a possibly NULL RCU
pointer are refused, while a task kptr read under bpf_rcu_read_lock()
and checked for NULL is accepted.

The context test is load-only on purpose: the test runner refuses a
context smaller than what the program reads, and the test loader
passes none.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/task_park.c      |   3 +
 .../bpf/progs/verifier_arena_stack.c          |  27 +
 .../selftests/bpf/progs/verifier_task_park.c  | 550 ++++++++++++++++++
 3 files changed, 580 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_task_park.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_park.c b/tools/testing/selftests/bpf/prog_tests/task_park.c
index a65539fdc412..2ba4c24ae598 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_park.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_park.c
@@ -6,6 +6,7 @@
 #include <signal.h>
 #include <sys/syscall.h>
 #include "task_park.skel.h"
+#include "verifier_task_park.skel.h"
 
 static int run_syscall_prog(struct bpf_program *prog, __u32 *retval)
 {
@@ -219,6 +220,8 @@ void test_task_park(void)
 {
 	struct task_park *skel;
 
+	RUN_TESTS(verifier_task_park);
+
 	skel = task_park__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		return;
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
index b46e30a9c67f..e09a9ce10187 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
@@ -1307,6 +1307,33 @@ __naked void packet_write_prologue(void)
 	: __clobber_all);
 }
 
+extern int bpf_task_park(__u64 timeout_ns, __u64 flags) __ksym;
+
+/* the call is in asm, which gives the kfunc no BTF */
+void __park_btf_root(void)
+{
+	bpf_task_park(0, 0);
+}
+
+/* The stack goes back to the cpu that the run ends on, and a park may change that cpu. */
+SEC("syscall")
+__description("arena stack: a program that parks")
+__failure __msg("bpf_task_park() cannot be called in a program that uses R12")
+__naked void parks(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 0;"
+	"r2 = 0;"
+	"call %[bpf_task_park];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm(bpf_task_park)
+	: __clobber_all);
+}
+
 #endif
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_task_park.c b/tools/testing/selftests/bpf/progs/verifier_task_park.c
new file mode 100644
index 000000000000..33bc29f08058
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_task_park.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+/* What survives a bpf_task_park(), what does not, and where the park is refused. */
+char _license[] SEC("license") = "GPL";
+
+extern struct task_struct *bpf_task_acquire(struct task_struct *task) __ksym;
+extern void bpf_task_release(struct task_struct *task) __ksym;
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+extern void bpf_local_irq_save(unsigned long *flags) __weak __ksym;
+extern void bpf_local_irq_restore(unsigned long *flags) __weak __ksym;
+extern int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __weak __ksym;
+extern void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __weak __ksym;
+extern int bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign,
+			     u32 nr_words) __weak __ksym;
+extern void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __weak __ksym;
+
+struct park_elem {
+	struct bpf_spin_lock lock;
+	struct task_struct __kptr *task;
+	struct task_struct __kptr_untrusted *untrusted_task;
+	__u32 state;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct park_elem);
+} park_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct park_elem);
+} hash_map SEC(".maps");
+
+struct rlock_elem {
+	struct bpf_res_spin_lock lock;
+	__u32 state;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct rlock_elem);
+} rlock_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(max_entries, 1);
+		__type(key, __u32);
+		__type(value, __u32);
+	});
+} outer_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+static __always_inline struct park_elem *lookup_elem(void)
+{
+	__u32 key = 0;
+
+	return bpf_map_lookup_elem(&park_map, &key);
+}
+
+/*
+ * A hash map frees a deleted element after a grace period the sleeper no
+ * longer delays: its value is gone after a park, in a register or spilled.
+ */
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int hash_value_after_park(void *ctx)
+{
+	struct park_elem *elem;
+	__u32 key = 0;
+
+	elem = bpf_map_lookup_elem(&hash_map, &key);
+	if (!elem)
+		return 0;
+	bpf_task_park(0, 0);
+	return elem->state;
+}
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+__naked int spilled_hash_value_after_park(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32 *)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[hash_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	*(u64 *)(r10 - 16) = r0;			\
+	r1 = 0;						\
+	r2 = 0;						\
+	call bpf_task_park;				\
+	r6 = *(u64 *)(r10 - 16);			\
+	r0 = *(u32 *)(r6 + %[state_off]);		\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(hash_map),
+	  __imm_const(state_off, offsetof(struct park_elem, state))
+	: __clobber_all);
+}
+
+/* An array allocates its values with the map, which the program holds: they survive. */
+SEC("syscall")
+__success __retval(0)
+int array_value_survives_park(void *ctx)
+{
+	struct park_elem *elem = lookup_elem();
+
+	if (!elem)
+		return 1;
+	bpf_task_park(0, 0);
+	return elem->state;
+}
+
+/*
+ * Global variables are array values too, and the compiler hoists their address
+ * out of loops; whether it does is its choice, so the hoisted form is pinned in
+ * assembly as well.
+ */
+__u32 rounds = 2;
+
+SEC("syscall")
+__success __retval(0)
+int global_survives_park_in_loop(void *ctx)
+{
+	__u32 i, n = 0;
+
+	for (i = 0; i < 4 && i < rounds; i++) {
+		bpf_task_park(0, 0);
+		n++;
+	}
+	return n != 2;
+}
+
+SEC("syscall")
+__success __retval(2)
+__naked int global_pointer_survives_park(void)
+{
+	asm volatile ("					\
+	r6 = %[rounds] ll;				\
+	r1 = 0;						\
+	r2 = 0;						\
+	call bpf_task_park;				\
+	r0 = *(u32 *)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(rounds)
+	: __clobber_all);
+}
+
+/* A per-CPU value is gone: the task may resume on another CPU. */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} percpu_map SEC(".maps");
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int percpu_value_after_park(void *ctx)
+{
+	__u32 key = 0, *val;
+
+	val = bpf_map_lookup_elem(&percpu_map, &key);
+	if (!val)
+		return 0;
+	bpf_task_park(0, 0);
+	return *val;
+}
+
+/* A trusted but unreferenced pointer is gone after a park. */
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int task_pointer_after_park(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	bpf_task_park(0, 0);
+	return task->pid;
+}
+
+/* A referenced pointer survives a park. */
+SEC("syscall")
+__success __retval(0)
+int referenced_task_survives_park(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return 1;
+	bpf_task_park(0, 0);
+	bpf_task_release(task);
+	return 0;
+}
+
+/* The stack and the context belong to the invocation: both survive a park. */
+SEC("syscall")
+__success __retval(7)
+int stack_survives_park(void *ctx)
+{
+	volatile __u32 word = 7;
+
+	bpf_task_park(0, 0);
+	return word;
+}
+
+/*
+ * Load only: the runner refuses a context smaller than the program reads, and
+ * the loader passes none.
+ */
+SEC("syscall")
+__success
+int ctx_survives_park(__u32 *ctx)
+{
+	bpf_task_park(0, 0);
+	return *ctx;
+}
+
+/* Arena memory is held by the arena map, which the program holds: it survives a park. */
+SEC("syscall")
+__success __retval(0)
+int arena_pointer_survives_park(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	volatile int __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page)
+		return 1;
+	*page = 7;
+	bpf_task_park(0, 0);
+	return *page != 7;
+#else
+	/* Nothing to test without arena casts; the program must still load. */
+	return 0;
+#endif
+}
+
+/* A map the program references directly is held by the invocation: its pointer survives. */
+SEC("syscall")
+__success __retval(0)
+__naked int map_pointer_survives_park(void)
+{
+	asm volatile ("					\
+	r6 = %[park_map] ll;				\
+	r1 = 0;						\
+	r2 = 0;						\
+	call bpf_task_park;				\
+	r1 = 0;						\
+	*(u32 *)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = r6;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(park_map)
+	: __clobber_all);
+}
+
+/*
+ * An inner map is held only by the outer map's element: neither its pointer
+ * nor its values survive, even though the inner map is an array.
+ */
+SEC("syscall")
+__failure __msg("expected=map_ptr")
+int inner_map_pointer_after_park(void *ctx)
+{
+	__u32 key = 0;
+	void *inner;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	if (!inner)
+		return 0;
+	bpf_task_park(0, 0);
+	return bpf_map_lookup_elem(inner, &key) != NULL;
+}
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int inner_array_value_after_park(void *ctx)
+{
+	__u32 key = 0, *val;
+	void *inner;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	if (!inner)
+		return 0;
+	val = bpf_map_lookup_elem(inner, &key);
+	if (!val)
+		return 0;
+	bpf_task_park(0, 0);
+	return *val;
+}
+
+/* A dynptr on the stack is refused across a park, referenced or not. */
+char dynptr_buf[8];
+
+SEC("syscall")
+__failure __msg("bpf_task_park() with a live dynptr at frame 0")
+int dynptr_across_park(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem(dynptr_buf, sizeof(dynptr_buf), 0, &ptr);
+	bpf_task_park(0, 0);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() with a live dynptr at frame 0")
+int ringbuf_dynptr_across_park(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &ptr);
+	bpf_task_park(0, 0);
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* A number iterator lives entirely on the stack: a park inside the loop is fine. */
+SEC("syscall")
+__success __retval(0)
+int num_iterator_survives_park(void *ctx)
+{
+	int i;
+
+	bpf_for(i, 0, 3)
+		bpf_task_park(0, 0);
+	return 0;
+}
+
+/* Any other iterator is refused across a park. */
+SEC("syscall")
+__failure __msg("bpf_task_park() with a live bits iterator at frame 0")
+int bits_iterator_across_park(void *ctx)
+{
+	struct bpf_iter_bits it;
+	__u64 word = 1;
+
+	bpf_iter_bits_new(&it, &word, 1);
+	bpf_task_park(0, 0);
+	bpf_iter_bits_destroy(&it);
+	return 0;
+}
+
+/* Regions that pin the CPU or hold a lock refuse a sleepable call, the park included. */
+SEC("syscall")
+__failure __msg("function calls are not allowed while holding a lock")
+int park_while_locked(void *ctx)
+{
+	struct park_elem *elem = lookup_elem();
+
+	if (!elem)
+		return 0;
+	bpf_spin_lock(&elem->lock);
+	bpf_task_park(0, 0);
+	bpf_spin_unlock(&elem->lock);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("function calls are not allowed while holding a lock")
+int park_while_res_locked(void *ctx)
+{
+	struct rlock_elem *elem;
+	__u32 key = 0;
+
+	elem = bpf_map_lookup_elem(&rlock_map, &key);
+	if (!elem)
+		return 0;
+	if (bpf_res_spin_lock(&elem->lock))
+		return 0;
+	bpf_task_park(0, 0);
+	bpf_res_spin_unlock(&elem->lock);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("kernel func bpf_task_park is sleepable within rcu_read_lock region")
+int park_in_rcu_region(void *ctx)
+{
+	bpf_rcu_read_lock();
+	bpf_task_park(0, 0);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("kernel func bpf_task_park is sleepable within non-preemptible region")
+int park_in_preempt_disabled_region(void *ctx)
+{
+	bpf_preempt_disable();
+	bpf_task_park(0, 0);
+	bpf_preempt_enable();
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("kernel func bpf_task_park is sleepable within IRQ-disabled region")
+int park_in_irq_disabled_region(void *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	bpf_task_park(0, 0);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+/*
+ * The time slice of may_goto is kept per CPU, and a program that parks may go
+ * on on another one. That holds for a may_goto the program asks for and for one
+ * the verifier adds to a loop it cannot bound.
+ */
+SEC("syscall")
+__failure __msg("may_goto cannot be used in a program that may migrate")
+int park_with_may_goto(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < 4 && can_loop; i++)
+		bpf_task_park(0, 0);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("may_goto cannot be used in a program that may migrate")
+int park_in_unbounded_loop(void *ctx)
+{
+	while (*(volatile __u32 *)&rounds)
+		bpf_task_park(0, 0);
+	return 0;
+}
+
+/* The park is registered for syscall programs only. */
+SEC("tp/syscalls/sys_enter_nanosleep")
+__failure __msg("calling kernel function bpf_task_park is not allowed")
+int park_from_non_syscall(void *ctx)
+{
+	return bpf_task_park(0, 0);
+}
+
+/* The wake is registered for every program type. */
+SEC("xdp")
+__success
+int wake_from_xdp(void *ctx)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *task;
+
+	if (!elem)
+		return XDP_PASS;
+	bpf_rcu_read_lock();
+	task = elem->task;
+	if (task)
+		bpf_task_wake(task, 0);
+	bpf_rcu_read_unlock();
+	return XDP_PASS;
+}
+
+/* bpf_task_wake() takes a referenced, trusted or RCU-protected task that is not NULL. */
+SEC("syscall")
+__failure __msg("R1 must be a rcu pointer")
+int wake_untrusted_task(void *ctx)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *task;
+
+	if (!elem)
+		return 0;
+	task = elem->untrusted_task;
+	if (!task)
+		return 0;
+	return bpf_task_wake(task, 0);
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+int wake_maybe_null_task(void *ctx)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *task;
+	int ret;
+
+	if (!elem)
+		return 0;
+	bpf_rcu_read_lock();
+	task = elem->task;
+	ret = bpf_task_wake(task, 0);
+	bpf_rcu_read_unlock();
+	return ret;
+}
+
+SEC("syscall")
+__success
+int wake_rcu_task(void *ctx)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *task;
+	int ret = 0;
+
+	if (!elem)
+		return 0;
+	bpf_rcu_read_lock();
+	task = elem->task;
+	if (task)
+		ret = bpf_task_wake(task, 0);
+	bpf_rcu_read_unlock();
+	return ret;
+}
-- 
2.53.0

