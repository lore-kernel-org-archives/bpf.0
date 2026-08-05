Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721039061C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955491; cv=none; b=Ld7jV6UcyRl56DrGLMxxNXUHTO8NztOaiA0avNoPWlRspVD1r26yYpcPvjAoRJnHsdzyrnfRYhZw3zy45g/Zewa7UunYz1scA4e/AsFgEDqmlgTWCKKVzeDLqwok/MqEfsu1nyUJdNSgEIfwv151nkIiPgz+DM1Ryyxs/YXjosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955491; c=relaxed/simple;
	bh=Sjj5Y2RfhOlcM/mgqWSQxO89Ssrl6aOmUGcTlzCBjgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KefyHmSKKJWM3asSlSNcEtZeHEr+72sreBv+C6CzYrSiRkAGRN+9UX1xheE5H+oIjGqMAZWrpiB1LyTXc+gWKdJ/MfE1HIS2leq8WjWkQe+aJaA7AIPkPd9nYRqXlpUUgquv5VStyKQiG43kQoCAaD/H6jwsnp1cSDo+qMaRUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eyAxNSmD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eyAxNSmD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cBDapzXQB2n+U8KpnFmdYyScWpKnIH3WMJlae9ipdBs=; b=eyAxNSmDehz+XRtMhqY0KPm1FJ
	/uK1Pv7KO8tUAs9nuJAbeihJgnGU8WiI8o94V9Hu8M9tR3vJzwcHUwI/N0+HE0+Oxev1o6jzcOVXK
	DDZqfdfwHU3VUgxd4HeavWABElAAnkmK1uRkEjZWX0gcYPkW+qxcZPY/Jeth50uyyraUysyTHqZV8
	P9caJmq+znyy2tDAFM3j65Vpm4fIRiBivt6dowbvWTNxf329mke4wPbB8/xfTdlRHDIm5jeAnAeV+
	wl0k0LHe5Dwx4sEGaYMMi5JJ9+8YUi8viCk6M0UP4g2qEKp1FEkWgeQjJv7iQGXW/uNhRUUXO5QYl
	xYtZ9mWA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrgbd-000JYU-0S;
	Wed, 05 Aug 2026 20:44:45 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf: Mark pending sub-register zero extension before pruning a state
Date: Wed,  5 Aug 2026 20:44:41 +0200
Message-ID: <20260805184444.292828-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28083/Wed Aug  5 08:24:50 2026)

A 32-bit write records the writing instruction in reg->subreg_def, and a
later 64-bit read of that register calls mark_insn_zext() to record that
the definition has to be zero extended. Architectures whose JIT sets
bpf_jit_needs_zext() rely on that mark to emit the extension.

The mark is produced by walking the path from the definition to the read.
If the walk stops at a state equivalent to an already explored one, the
reads the explored path performs from there on are not repeated for this
path's registers, so a definition whose only 64-bit read lies beyond the
pruning point never gets marked and keeps a garbage upper half.

Example with BPF_F_TEST_STATE_FREQ making every instruction a checkpoint:

      r7 = *(u32 *)(r1 + offsetof(struct __sk_buff, len))
      r6 = 0        /* 64-bit define */
      if r7 != 0 goto l1
      goto l0                              path A, explored first
  l1: w6 = 0        /* 32-bit define */    path B, explored second
  l0: r0 = r6       /* 64-bit read   */
      r0 >>= 32
      exit

Now, path A is the fall-through of the conditional and is explored first.
It reaches l0 with r6 defined by the 64-bit r6 = 0, so reg->subreg_def is
DEF_NOT_SUBREG and the read marks nothing. The walk runs on to exit and
leaves a checkpoint at every instruction along the way. Path B is explored
second. w6 = 0 sets r6->subreg_def to that instruction, so a zero extension
is pending and only the 64-bit read at l0 can resolve it. B then arrives
at l0, where bpf_is_state_visited() finds the checkpoint A left behind:
r6 is the scalar 0 in both states, so they are equivalent and B is pruned
before r0 = r6 is verified.

Without the fix nothing happens at that point, so the one read that would
have called mark_insn_zext() for w6 is never walked and the definition
stays unmarked:

  l1: w6 = 0        /* subreg_def = w6, pending */
  l0: r0 = r6     <--- B pruned, read never walked, w6 stays unmarked

The JIT of an architecture that needs explicit zero extension then emits
none, and the upper half of w6's definition is left undefined (under
BPF_F_TEST_RND_HI32 it holds the randomized half, which r0 >>= 32 returns).
This used to be handled by the registers chain based liveness: the
propagate_liveness() called mark_insn_zext() for every parent register
whose read mark was REG_LIVE_READ64, which carried the requirement across
a pruned state. Commit 107e16979905 ("bpf: disable and remove registers
chain based liveness") removed that machinery and with it the propagation,
leaving the mark dependent on the path actually being walked.

Mark the pending definitions where the walk stops instead, i.e. on the way
into the prune rather than at the read that is no longer reached:

  l1: w6 = 0        /* subreg_def = w6, pending */
  l0: r0 = r6     <--- mark w6, r6 is live here

The set of registers to mark is the one the pruning decision was made on:
func_states_equal() compares the registers live at the instruction, per
insn_aux_data[].live_regs_before, and those are exactly the registers that
can still be read. A register that is not live there is never read again
and needs nothing. This is conservative in one direction: a live register
whose remaining reads are all 32-bit also gets its definition marked,
which costs a zero extension that is not needed. However, it never marks
too little, and it does not weaken pruning. On x86-64 the effect is only
observable with BPF_F_TEST_RND_HI32.

The one live scalar whose subreg_def can point at a call insn is r0 of a
kfunc returning a 32-bit value. Marking that one is harmless, the fixup pass
skips kfunc calls since their zero extension is done by the caller.

Fixes: 107e16979905 ("bpf: disable and remove registers chain based liveness")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/states.c          |  2 ++
 kernel/bpf/verifier.c        | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2a40caca0a0..0952fa5649db 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1212,6 +1212,8 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env, struct bpf_verifier_st
 int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 			     struct bpf_verifier_state *starting_state,
 			     int regno, bool *changed);
+void bpf_mark_live_subregs_zext(struct bpf_verifier_env *env,
+				struct bpf_verifier_state *vstate);
 
 static inline int bpf_get_spi(s32 off)
 {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index ea2153cf28d0..24009a606249 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1405,6 +1405,8 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 hit:
 			sl->hit_cnt++;
 
+			bpf_mark_live_subregs_zext(env, cur);
+
 			/* if previous state reached the exit with precision and
 			 * current state is equivalent to it (except precision marks)
 			 * the precision needs to be propagated back in
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09588b7b08b0..e62b350b37af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3161,6 +3161,44 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
 	reg->subreg_def = DEF_NOT_SUBREG;
 }
 
+/*
+ * Reaching a state equivalent to an already explored one stops the walk, so a
+ * register that still carries a subreg_def may have its only 64-bit read on
+ * the path that is no longer walked, and without the mark the JIT of an
+ * architecture that needs explicit zero extension leaves the upper half of the
+ * definition undefined. Mark the definitions of the registers live at this
+ * instruction, i.e. the ones the equivalence was decided on and thus the only
+ * ones that can still be read. This is conservative in that a live register
+ * which is only ever read as a sub-register also gets its definition marked,
+ * at the cost of a zero extension that is not needed.
+ *
+ * Only scalars are considered since a live_regs_before bit does not imply that
+ * the register holds a readable value: the caller saved regs of a frame below
+ * the current one are clobbered to NOT_INIT at the call while keeping the
+ * subreg_def of the call insn. Such a definition must not be marked, the call
+ * insn has no destination register to zero extend.
+ */
+void bpf_mark_live_subregs_zext(struct bpf_verifier_env *env,
+				struct bpf_verifier_state *vstate)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_func_state *func;
+	u16 live_regs;
+	int i, j;
+
+	for (i = vstate->curframe; i >= 0; i--) {
+		live_regs = aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
+		func = vstate->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			if (!(live_regs & BIT(j)))
+				continue;
+			if (func->regs[j].type != SCALAR_VALUE)
+				continue;
+			mark_insn_zext(env, &func->regs[j]);
+		}
+	}
+}
+
 static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
 			   enum bpf_reg_arg_type t)
 {
-- 
2.43.0

