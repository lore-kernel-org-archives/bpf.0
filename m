Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F812CD8B
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176502; cv=none; b=g0NqJft8+8KSnVkX7Pl+NBmES4Gc0FB7m7TdHz+3EukP6SXPtzbV3p46EajfukqiSMdESGdUBtjx5RslTQEK4sRcoq4dSyw/u9wwqFnV+c5QW0Dx5JGppbMaH9680+oxZ81ateqH0xntKRzP56PINbb9UAjtdGaGq35mYfncQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176502; c=relaxed/simple;
	bh=+LWVciFvVAgNpSnU8cAr3zP8kXeZcU7in5dr031JjJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IibvMkfGV3sBY8G3BNFUn4z8IIW/C7VDeHp/vj+ZHkK157kc421NXK0os4P7h8x7RRiBE4IHaBHT/rbZPvA1Cl2qSlCxrxCnHF/pSlhg0qpSZRrh+eBQxE/9llwbzj7j0+hrQvJO1wKAgLnYjjZVu7Xy0eqHQ3RQcDOBDaEI0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lthohmQn; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lthohmQn"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65890a6ca20so1239199d50.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176499; x=1778781299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFO56iJVhDBdyEhVzyO673UTaUkLyoCV4A8NBFX0Qk8=;
        b=lthohmQnQZqSYyxnK2pr6wBhOoOE8cIl+WTifHVP17UHqS1x4E2gSDeaDP4pQSI+Tj
         dZYwW0EBuaI8wWMIB7v2yjsPGdcCnUiruth3BvVAxol0pst7zHn/E1cwXh4Mi2K5Agkj
         bYbxOmwY/8OF+B5p/PF8wc2ykwVqVa+bsKQ7R6ZfF9Ne+844cag17t+5Q0WFm5BQwv1k
         GWeOcbEghdcCk5Za9Egwvb2rx6mxB77Oh78/366ZdZD5h4I3B0qLfz0xPf0WXaD9LEl5
         KYykIyQ4zgUtlZL/POYMTGebu/ZXOr/rwkz3dCkj+dPV5apBiNLgSwOk67Z+R73wTTUz
         2fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176499; x=1778781299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFO56iJVhDBdyEhVzyO673UTaUkLyoCV4A8NBFX0Qk8=;
        b=Mxv1m1iRSMNl0EFy3U6/hoOz5r5dAGj4m3Sb96lISgfmeXTu6oKeXexM7ZROlcCisS
         YBhIFQoIBBwS7dyCqVKKZ1uNU13f+AtB3QiJZ5QAN2SWX3LdbpGXTlXdvLLhLf//XE1/
         rMUrsrvF43LaqxjTSHTqCLWcZbyTkTth/0vI9k/yd7fGmr086yLYpxXb79+ZmlxL9lqX
         tq/WaihvhiGCUF52/8QdQ51alUt2eE959T75mrbTCjbUspKF9Cnyuch/VWF6YC2YNgNE
         XYK5p5u/dcFVGW0UtaGprjgLizGCfWPrTBPebabLfhd4PnVLxB74XChDYj7ntzBs9JUu
         joyw==
X-Forwarded-Encrypted: i=1; AFNElJ+IIQJU47ziwhsR6wpogHizVlo5iVBT8SlQNNSF9h2+KKhjNvKaYcVIO3rD2Ha8fVKC5wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlfn9LIhehniswIgnz2dNyryysWBOP7bOAB4YXfcw84rYwP7wg
	J2XAu9wsa1bu5eq9YkMwoCifqY1kbFV5vT6GeSuuMqxhVydLTvKEkXEM
X-Gm-Gg: Acq92OFlFVNgHFF7oilcXwTEvOiImycdOcyXtcIVsN5iPAGqDkHxSxcEdc34N6PWeHT
	MbG33tCa03mzOrHIjYxsnpiHSmDREUjOHwH0/x7oYYv3JIfASYglnjZG0MX9e9Nqyloea4gVhtB
	xpSOcK8zZuf3pzvyE1jp73SKjf6SSq6Ma1QVMol4cAJgUPU6c/Jy5Np0UFnwe+0JrU/XYr2rGzv
	1o1s0XNdAVW6hAp1Fg0pgloXVTqSxL5e0GHMFU117yXgbQPGGCVtjTR4Dc7VPmBiUh0tEW5KR7C
	P856Na8WGRYk/xEx0NjYuwYZIsCs+gY4XviFyiYwOxJ2FYrOpjs8cpza6b5s0C07Wplko/uhqMD
	HtWaYBZ+viEfl+Hjg8iXNDg49JAGvkd1t/LGq0tCHzWBAqdyhsi1kHakrud2JMRY7Jbc8BiCkLE
	qac62fNmiGy5W9xYjwCvEGgt7OSVVuHOiWg8m5f0Csj67ELgUXOR6JYM0XZI2t4n8q0wPsQjM=
X-Received: by 2002:a05:690e:d41:b0:651:c321:9dc with SMTP id 956f58d0204a3-65c79e60c8emr8576402d50.33.1778176499006;
        Thu, 07 May 2026 10:54:59 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:491:bfe9:4001:a4da])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d933410e8sm2246d50.1.2026.05.07.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:54:58 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Date: Thu,  7 May 2026 13:54:52 -0400
Message-ID: <20260507175453.1140400-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507175453.1140400-1-utilityemal77@gmail.com>
References: <20260507175453.1140400-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF program attached to tp_btf/nmi_handler can delete map entries or
swap out referenced kptrs from NMI context. Today that runs the kptr
destructor inline. Destructors such as bpf_cpumask_release() can take
RCU-related locks, so running them from NMI can deadlock the system.

Queue destructor-backed teardown to irq_work and track the preallocated
capacity with an idle-slot surplus counter. Two pcpu_freelists are
maintained: one for the idle slots and one for active jobs.
pcpu_freelist is built for NMI context, using raw_res_spin_lock and per
cpu list heads.

This counter is positive when the idle slots for work exceeds the number
of kptrs exchanged into maps. The counter is negative when the idle slots
for work is less than the number of ref kptrs exchanged into maps.

The counter will always attempt to trend to zero, keeping exactly the
amount of work slots ready for the worst case, freeing excess surplus
while allocating new surplus when needed.

This keeps NMI teardown on the fast path: it only has to pop an idle job
and never allocate. On consumption of a job, the memory is returned to
the idle queue for reuse.

Each successful install can consume at most one future offload slot, so
bpf_kptr_offload_slot_acquire() decrements surplus and provisions one
additional idle job only when the pool falls short. Teardown and
irq_work completion return that slot with
bpf_kptr_offload_slot_release(), which rechecks the surplus before
freeing an extra idle job.

There are two main safety nets against memory exhaustion:

If reserving another offload slot fails while installing a new
destructor-backed kptr through bpf_kptr_xchg(), leave the destination
unchanged and return the incoming pointer so the caller keeps ownership.

This should only happen under severe memory pressure, as the work is
only 24 bytes on 64 bit architectures, and slots are reused whenever
possible.

If NMI teardown still fails to grab an idle offload job despite that
accounting, warn once and run the destructor inline rather than leak the
object permanently. This warn condition is a canary for accounting bugs,
since the xchg safety net shouldn't let this state be reached. The
justification for falling back to running the dtor in nmi is leaking
memory is less debuggable and visible to users than an explicit
warning and a possible deadlock that is recoverable by the watchdog.

This fix does come with small performance tradeoffs for safety. xchg can
no longer be inlined for referenced kptrs, as inlining would break the
slot accounting. The inlining fix is preserved for kptrs with no
destructor defined.

There is a small price paid of a potential alloc and a few atomic ops in
the xchg path for kptrs with dtors. The nmi dtor path has a few atomic ops
and an IPI for the irq_work overhead.

This keeps refcounted kptr teardown out of NMI context without slowing
down raw kptr exchanges that never need destructor handling.

This change ensures that dtors can be written for hardirq context
instead of NMI.

Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Reported-by: Justin Suess <utilityemal77@gmail.com>
Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/bpf.h          |  16 ++++
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/fixups.c          |  33 +++++---
 kernel/bpf/helpers.c         |  24 +++++-
 kernel/bpf/syscall.c         | 159 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  13 +++
 6 files changed, 232 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 715b6df9c403..583e8551d162 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3454,6 +3454,22 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
 
 void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 			  struct bpf_map **used_maps, u32 len);
+/* Direct-call target used by fixups for bpf_kptr_xchg() sites without dtors. */
+u64 bpf_kptr_xchg_nodtor(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+
+#ifdef CONFIG_BPF_SYSCALL
+int bpf_kptr_offload_slot_acquire(void);
+void bpf_kptr_offload_slot_release(void);
+#else
+static inline int bpf_kptr_offload_slot_acquire(void)
+{
+	return 0;
+}
+
+static inline void bpf_kptr_offload_slot_release(void)
+{
+}
+#endif
 
 bool bpf_prog_get_ok(struct bpf_prog *, enum bpf_prog_type *, bool);
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 976e2b2f40e8..26bc8b5c9030 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -672,6 +672,8 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	u8 kptr_has_dtor:1;
+	u8 kptr_has_dtor_seen:1;
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fba9e8c00878..459e855e86a5 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2284,23 +2284,30 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		/* Implement bpf_kptr_xchg inline */
-		if (prog->jit_requested && BITS_PER_LONG == 64 &&
-		    insn->imm == BPF_FUNC_kptr_xchg &&
-		    bpf_jit_supports_ptr_xchg()) {
-			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
-			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
-			cnt = 2;
+		/* Implement bpf_kptr_xchg inline. */
+		if (insn->imm == BPF_FUNC_kptr_xchg &&
+		    !env->insn_aux_data[i + delta].kptr_has_dtor) {
+			if (prog->jit_requested && BITS_PER_LONG == 64 &&
+			    bpf_jit_supports_ptr_xchg()) {
+				insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
+				insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG,
+						     BPF_REG_1, BPF_REG_0, 0);
+				cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+				if (!new_prog)
+					return -ENOMEM;
 
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+				delta    += cnt - 1;
+				env->prog = prog = new_prog;
+				insn      = new_prog->insnsi + i + delta;
+				goto next_insn;
+			}
+
+			insn->imm = bpf_kptr_xchg_nodtor - __bpf_call_base;
 			goto next_insn;
 		}
+
 patch_call_imm:
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index baa12b24bb64..51717a88f627 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1728,7 +1728,7 @@ void bpf_wq_cancel_and_free(void *val)
 	bpf_async_cancel_and_free(val);
 }
 
-BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
+BPF_CALL_2(bpf_kptr_xchg_nodtor, void *, dst, void *, ptr)
 {
 	unsigned long *kptr = dst;
 
@@ -1736,12 +1736,32 @@ BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
 	return xchg(kptr, (unsigned long)ptr);
 }
 
+BPF_CALL_2(bpf_ref_kptr_xchg, void *, dst, void *, ptr)
+{
+	unsigned long *kptr = dst;
+	void *old;
+
+	/*
+	 * If the incoming pointer cannot be torn down safely from NMI later on,
+	 * leave the destination untouched and return ptr so the caller keeps
+	 * ownership.
+	 */
+	if (ptr && bpf_kptr_offload_slot_acquire())
+		return (unsigned long)ptr;
+
+	old = (void *)xchg(kptr, (unsigned long)ptr);
+	if (old)
+		bpf_kptr_offload_slot_release();
+	return (unsigned long)old;
+}
+
 /* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg()
  * helper is determined dynamically by the verifier. Use BPF_PTR_POISON to
  * denote type that verifier will determine.
+ * No-dtor callsites are redirected to bpf_kptr_xchg_nodtor() from fixups.
  */
 static const struct bpf_func_proto bpf_kptr_xchg_proto = {
-	.func         = bpf_kptr_xchg,
+	.func         = bpf_ref_kptr_xchg,
 	.gpl_only     = false,
 	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
 	.ret_btf_id   = BPF_PTR_POISON,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b1f0ba02f61..d34fdb99eb8a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -7,6 +7,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
 #include <linux/bpf_verifier.h>
+#include <linux/bpf_mem_alloc.h>
 #include <linux/bsearch.h>
 #include <linux/btf.h>
 #include <linux/hex.h>
@@ -19,6 +20,7 @@
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/irq_work.h>
 #include <linux/license.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
@@ -42,6 +44,8 @@
 #include <linux/cookie.h>
 #include <linux/verification.h>
 
+#include "percpu_freelist.h"
+
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
 #include <net/tcx.h>
@@ -65,6 +69,111 @@ static DEFINE_SPINLOCK(map_idr_lock);
 static DEFINE_IDR(link_idr);
 static DEFINE_SPINLOCK(link_idr_lock);
 
+struct bpf_dtor_kptr_work {
+	struct pcpu_freelist_node fnode;
+	void *obj;
+	btf_dtor_kfunc_t dtor;
+};
+
+/* Queue pending dtors; the idle pool uses a global pcpu_freelist. */
+static struct pcpu_freelist bpf_dtor_kptr_jobs;
+static struct pcpu_freelist bpf_dtor_kptr_idle;
+/* Keep surplus = total - needed = idle - refs >= 0 so NMI frees never need to allocate. */
+static atomic_long_t bpf_dtor_kptr_surplus = ATOMIC_LONG_INIT(0);
+
+static void bpf_dtor_kptr_worker(struct irq_work *work);
+static DEFINE_PER_CPU(struct irq_work, bpf_dtor_kptr_irq_work) =
+	IRQ_WORK_INIT_HARD(bpf_dtor_kptr_worker);
+
+static struct bpf_dtor_kptr_work *bpf_dtor_kptr_pop_idle(void)
+{
+	struct pcpu_freelist_node *node;
+
+	node = pcpu_freelist_pop(&bpf_dtor_kptr_idle);
+	if (!node)
+		return NULL;
+
+	return container_of(node, struct bpf_dtor_kptr_work, fnode);
+}
+
+static void bpf_dtor_kptr_release_one(void)
+{
+	struct bpf_dtor_kptr_work *job;
+	long surplus;
+
+	for (;;) {
+		surplus = atomic_long_read(&bpf_dtor_kptr_surplus);
+		if (surplus <= 0)
+			return;
+
+		job = bpf_dtor_kptr_pop_idle();
+		if (!job)
+			return;
+
+		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_surplus, &surplus,
+						     surplus - 1)) {
+			pcpu_freelist_push(&bpf_dtor_kptr_idle, &job->fnode);
+			continue;
+		}
+
+		bpf_mem_free(&bpf_global_ma, job);
+		return;
+	}
+}
+
+void bpf_kptr_offload_slot_release(void)
+{
+	if (atomic_long_inc_return(&bpf_dtor_kptr_surplus) > 0)
+		bpf_dtor_kptr_release_one();
+}
+
+int bpf_kptr_offload_slot_acquire(void)
+{
+	struct bpf_dtor_kptr_work *job;
+	long surplus;
+
+	if (unlikely(!bpf_global_ma_set ||
+		     !READ_ONCE(bpf_dtor_kptr_idle.freelist) ||
+		     !READ_ONCE(bpf_dtor_kptr_jobs.freelist)))
+		return -ENOMEM;
+
+	/*
+	 * Each successful install can decrease the surplus by at most one, so it only
+	 * ever needs to provision one additional idle job.
+	 */
+	surplus = atomic_long_dec_return(&bpf_dtor_kptr_surplus);
+	if (surplus >= 0)
+		return 0;
+
+	job = bpf_mem_alloc(&bpf_global_ma, sizeof(*job));
+	if (!job) {
+		atomic_long_inc(&bpf_dtor_kptr_surplus);
+		return -ENOMEM;
+	}
+
+	pcpu_freelist_push(&bpf_dtor_kptr_idle, &job->fnode);
+	/* A racing teardown may have already removed the demand that forced this. */
+	bpf_kptr_offload_slot_release();
+
+	return 0;
+}
+
+static int __init bpf_dtor_kptr_init(void)
+{
+	int err;
+
+	err = pcpu_freelist_init(&bpf_dtor_kptr_idle);
+	if (err)
+		return err;
+
+	err = pcpu_freelist_init(&bpf_dtor_kptr_jobs);
+	if (err)
+		return err;
+
+	return 0;
+}
+late_initcall(bpf_dtor_kptr_init);
+
 int sysctl_unprivileged_bpf_disabled __read_mostly =
 	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
 
@@ -807,6 +916,43 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
 	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
 }
 
+static void bpf_dtor_kptr_worker(struct irq_work *work)
+{
+	struct pcpu_freelist_node *fnode;
+	struct bpf_dtor_kptr_work *job;
+
+	while ((fnode = pcpu_freelist_pop(&bpf_dtor_kptr_jobs))) {
+		job = container_of(fnode, struct bpf_dtor_kptr_work, fnode);
+		job->dtor(job->obj);
+		pcpu_freelist_push(&bpf_dtor_kptr_idle, &job->fnode);
+		bpf_kptr_offload_slot_release();
+	}
+}
+
+static void bpf_dtor_kptr_offload(void *obj, btf_dtor_kfunc_t dtor)
+{
+	struct bpf_dtor_kptr_work *job;
+
+	/* Handing storage teardown off to irq_work consumes one idle slot. */
+	atomic_long_dec(&bpf_dtor_kptr_surplus);
+	job = bpf_dtor_kptr_pop_idle();
+	if (WARN_ON_ONCE(!job)) {
+		atomic_long_inc(&bpf_dtor_kptr_surplus);
+		/*
+		 * This should stay unreachable if reserve accounting is correct. If it
+		 * ever breaks, running the destructor unsafely is still better than
+		 * leaking the object permanently.
+		 */
+		dtor(obj);
+		return;
+	}
+
+	job->obj = obj;
+	job->dtor = dtor;
+	pcpu_freelist_push(&bpf_dtor_kptr_jobs, &job->fnode);
+	irq_work_queue(this_cpu_ptr(&bpf_dtor_kptr_irq_work));
+}
+
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
 	const struct btf_field *fields;
@@ -842,6 +988,19 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
 			if (!xchgd_field)
 				break;
+			if (in_nmi() && field->kptr.dtor) {
+				bpf_dtor_kptr_offload(xchgd_field, field->kptr.dtor);
+				bpf_kptr_offload_slot_release();
+				break;
+			}
+			if (field->kptr.dtor)
+				/*
+				 * Dtor kptrs reach storage through bpf_ref_kptr_xchg(), which
+				 * pairs installation with bpf_kptr_offload_slot_acquire(). Return
+				 * that slot on non-NMI teardown once no active transition is
+				 * needed.
+				 */
+				bpf_kptr_offload_slot_release();
 
 			if (!btf_is_kernel(field->kptr.btf)) {
 				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11054ad89c14..d042be8ed789 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9891,6 +9891,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
 	int i, err, func_id;
+	bool kptr_has_dtor;
 
 	/* find function prototype */
 	func_id = insn->imm;
@@ -9950,6 +9951,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (err)
 			return err;
 	}
+	if (func_id == BPF_FUNC_kptr_xchg) {
+		kptr_has_dtor = !!meta.kptr_field->kptr.dtor;
+		if (env->insn_aux_data[insn_idx].kptr_has_dtor_seen &&
+		    env->insn_aux_data[insn_idx].kptr_has_dtor != kptr_has_dtor) {
+			verbose(env,
+				"same insn cannot call bpf_kptr_xchg() on both dtor and non-dtor kptrs\n");
+			return -EINVAL;
+		}
+
+		env->insn_aux_data[insn_idx].kptr_has_dtor_seen = true;
+		env->insn_aux_data[insn_idx].kptr_has_dtor = kptr_has_dtor;
+	}
 
 	err = record_func_map(env, &meta, func_id, insn_idx);
 	if (err)
-- 
2.53.0

