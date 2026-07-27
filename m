Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59F3BE636
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121627; cv=none; b=GD23HjcWpUyAUpdnuxMMTElCaNY4P79MxIw8EncpFAgu5jtHWJ2O0eKFOHUV0fzbs4qjMOtRAi/Mbv2YNNI8rAamja+ESTSnWXfSNxlM2LGJdTUSHJcsaukbe8fSxFHKwWgEFRMAVpbQy4xc76cKDI5Sv0F8Grpfm8MUhkl1t6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121627; c=relaxed/simple;
	bh=mJqacue8S4GbeocFcNdKBc8wRkOp0HnioTmCqMhaFUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0C8EBz+lT98GuR6D2TCxTMctHkCHnID840XitOGFqYLrcPJVIxOIbM9Buj0k/zDI8i+GPTfy5wRxvlPP2KN50KcN7bT13CTSHNW4CaLQL3HZO/r2CEzcdZFNVdBo/U0zBZW+ZvuvOdDYy36pPN6sXZvGEYBGVr0CX/bhy2L2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pj6Unl4B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pj6Unl4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785121625; x=1816657625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJqacue8S4GbeocFcNdKBc8wRkOp0HnioTmCqMhaFUw=;
  b=Pj6Unl4BE8s1aoqMG2VQDRUeS4RNaqaec78HLEpwqxSEAS+GIjApOjWi
   e2t2P76Dipd7e+9YiPP+0G3b8sclMbDc98Tk6XEFKmViAnHIb+XjiFjkW
   GewD4chRiizb8br2dEP+uPKp+B6ZpkDHhoTBjkMwD3cRNLIGLiawfNcJb
   MdNuFzpfKzO8H/q+VD0hKoi1JwHeXeFfIxtotbjq5XrDBUjCdWk8NIG98
   jI2uVSlyt3ztR/NZkQAXUvMBmlxgVkQegU4xnQQw1QKAE46zyJ0vKUwEL
   w43ufswNICKKhY1eorlCx6ka3zjtCGK+x472k09xaXqY/9u26lO9KCBOr
   A==;
X-CSE-ConnectionGUID: zU+SIFvETJmS9HPQWfdAsQ==
X-CSE-MsgGUID: 2XB/1RqATAybtDmJZItN5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="88222578"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="88222578"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:07:04 -0700
X-CSE-ConnectionGUID: PCfJ9+fKTeqxBXJ5mYDI0Q==
X-CSE-MsgGUID: 56RX5CspSdW7C5e+LAGV2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="254963349"
Received: from tester.sh.intel.com ([10.112.106.126])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jul 2026 20:07:03 -0700
From: Tao Yu <tao1.yu@intel.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	tao1.yu@intel.com,
	syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com
Subject: [PATCH v2] bpf: normalize arg_track state construction
Date: Mon, 27 Jul 2026 11:06:43 +0800
Message-Id: <20260727030643.1682974-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723055508.1403247-1-tao1.yu@intel.com>
References: <20260723055508.1403247-1-tao1.yu@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninitialized read from `a.mask` in
`__arg_track_join()` during liveness analysis.

=====================================================
BUG: KMSAN: uninit-value in __arg_track_join+0x15a/0x810 kernel/bpf/liveness.c:743
 __arg_track_join+0x15a/0x810 kernel/bpf/liveness.c:743
 arg_track_join+0x186/0x870 kernel/bpf/liveness.c:784
 compute_subprog_args kernel/bpf/liveness.c:1623 [inline]
 analyze_subprog+0x3eb0/0xff30 kernel/bpf/liveness.c:1799
 bpf_compute_subprog_arg_access+0x3ee/0x2370 kernel/bpf/liveness.c:1937
 bpf_compute_live_registers+0xfdb/0x3090 kernel/bpf/liveness.c:2149
 bpf_check+0x5bcb/0x9360 kernel/bpf/verifier.c:20065
 bpf_prog_load+0x28d2/0x2d00 kernel/bpf/syscall.c:3082
 __sys_bpf+0x8e0/0xee0 kernel/bpf/syscall.c:6274
 __do_sys_bpf kernel/bpf/syscall.c:6387 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6385 [inline]
 __ia32_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6385
 ia32_sys_call+0x33e7/0x4360 arch/x86/include/generated/asm/syscalls_32.h:358
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x195/0x470 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable old created at:
 arg_track_join+0x86/0x870 kernel/bpf/liveness.c:783
 compute_subprog_args kernel/bpf/liveness.c:1623 [inline]
 analyze_subprog+0x3eb0/0xff30 kernel/bpf/liveness.c:1799

CPU: 0 UID: 0 PID: 18676 Comm: syz.0.5880 Tainted: G        W           syzkaller #0 PREEMPT(lazy)
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
=====================================================

arg_track is a tagged-union state machine, but a number of transitions
were previously expressed by mutating selected fields or by manually
assembling temporary values. This makes the state encoding less explicit
and weakens the invariant that each logical arg_track state is
materialized as a complete object.

Normalize arg_track state construction through explicit helpers for the
special states used by the analysis: ARG_NONE, ARG_UNVISITED,
offset-imprecise, and ARG_IMPRECISE. Use these helpers consistently
instead of open-coded partial updates and ad-hoc temporaries.

Besides making the state transitions easier to reason about, this makes
the state representation explicit at each transition and avoids carrying
partially materialized union-backed state through by-value copies and
joins, matching the class of issue reported by KMSAN.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Reported-by: syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com
Signed-off-by: Tao Yu <tao1.yu@intel.com>
---
 kernel/bpf/liveness.c | 65 ++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc5..58b979c17c3e4 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -607,6 +607,31 @@ enum arg_track_state {
 	ARG_IMPRECISE	= -3,	/* lost identity; .mask is arg bitmask */
 };
 
+static struct arg_track arg_track_state(s8 frame)
+{
+	return (struct arg_track){ .frame = frame };
+}
+
+static struct arg_track arg_track_none(void)
+{
+	return arg_track_state(ARG_NONE);
+}
+
+static struct arg_track arg_track_unvisited(void)
+{
+	return arg_track_state(ARG_UNVISITED);
+}
+
+static struct arg_track arg_track_off_imprecise(s8 frame)
+{
+	return arg_track_state(frame);
+}
+
+static struct arg_track arg_track_imprecise(u16 mask)
+{
+	return (struct arg_track){ .mask = mask, .frame = ARG_IMPRECISE };
+}
+
 /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes each) */
 #define MAX_ARG_SPILL_SLOTS 64
 
@@ -693,8 +718,8 @@ static struct arg_track arg_single(s8 arg, s16 off)
  */
 static struct arg_track arg_merge_offsets(struct arg_track a, struct arg_track b)
 {
-	struct arg_track result = { .frame = a.frame };
-	struct arg_track imp = { .frame = a.frame };
+	struct arg_track result = arg_track_state(a.frame);
+	struct arg_track imp = arg_track_off_imprecise(a.frame);
 	int i = 0, j = 0, k = 0;
 
 	while (i < a.off_cnt && j < b.off_cnt) {
@@ -747,7 +772,7 @@ static struct arg_track arg_join_imprecise(struct arg_track a, struct arg_track
 	else if (b.frame == ARG_IMPRECISE)
 		m |= b.mask;
 
-	return (struct arg_track){ .mask = m, .frame = ARG_IMPRECISE };
+	return arg_track_imprecise(m);
 }
 
 /* Join two arg_track values at merge points */
@@ -760,7 +785,7 @@ static struct arg_track __arg_track_join(struct arg_track a, struct arg_track b)
 	if (a.frame == b.frame && a.frame >= 0) {
 		/* Both offset-imprecise: stay imprecise */
 		if (a.off_cnt == 0 || b.off_cnt == 0)
-			return (struct arg_track){ .frame = a.frame };
+			return arg_track_off_imprecise(a.frame);
 		/* Merge offset sets; falls back to off_cnt=0 if >4 */
 		return arg_merge_offsets(a, b);
 	}
@@ -837,7 +862,7 @@ static void arg_track_alu64(struct arg_track *dst, const struct arg_track *src)
 		 * rX += rY where rY is not arg derived
 		 * rX += rX
 		 */
-		dst->off_cnt = 0;
+		*dst = arg_track_off_imprecise(dst->frame);
 		return;
 	}
 	if (src->frame >= 0 && dst->frame == ARG_NONE) {
@@ -845,8 +870,7 @@ static void arg_track_alu64(struct arg_track *dst, const struct arg_track *src)
 		 * rX += rY where rX is not arg derived
 		 * rY identity leaks into rX
 		 */
-		dst->off_cnt = 0;
-		dst->frame = src->frame;
+		*dst = arg_track_off_imprecise(src->frame);
 		return;
 	}
 
@@ -875,7 +899,7 @@ static void arg_padd(struct arg_track *at, s64 delta)
 		s16 new_off;
 
 		if (arg_add(at->off[i], delta, &new_off)) {
-			at->off_cnt = 0;
+			*at = arg_track_off_imprecise(at->frame);
 			return;
 		}
 		at->off[i] = new_off;
@@ -901,11 +925,8 @@ static struct arg_track fill_from_stack(struct bpf_insn *insn,
 					struct arg_track *at_stack_out,
 					int depth)
 {
-	struct arg_track imp = {
-		.mask = (1u << (depth + 1)) - 1,
-		.frame = ARG_IMPRECISE
-	};
-	struct arg_track result = { .frame = ARG_NONE };
+	struct arg_track imp = arg_track_imprecise((1u << (depth + 1)) - 1);
+	struct arg_track result = arg_track_state(ARG_NONE);
 	int cnt, i;
 
 	if (reg == BPF_REG_FP) {
@@ -940,7 +961,7 @@ static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
 			   int reg, struct arg_track *at_stack_out,
 			   struct arg_track *val, u32 sz)
 {
-	struct arg_track none = { .frame = ARG_NONE };
+	struct arg_track none = arg_track_none();
 	struct arg_track new_val = sz == 8 ? *val : none;
 	int cnt, i;
 
@@ -979,7 +1000,7 @@ static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
  */
 static void clear_overlapping_stack_slots(struct arg_track *at_stack, s16 off, u32 sz, int cnt)
 {
-	struct arg_track none = { .frame = ARG_NONE };
+	struct arg_track none = arg_track_none();
 
 	if (cnt == 0) {
 		for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++)
@@ -1103,7 +1124,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	u8 code = BPF_OP(insn->code);
 	struct arg_track *dst = &at_out[insn->dst_reg];
 	struct arg_track *src = &at_out[insn->src_reg];
-	struct arg_track none = { .frame = ARG_NONE };
+	struct arg_track none = arg_track_none();
 	int r, slot;
 
 	/* Handle stack arg stores and loads. */
@@ -1128,7 +1149,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				arg_padd(dst, -(s64)insn->imm);
 			else
 				/* Any other 64-bit alu on the pointer makes it imprecise */
-				dst->off_cnt = 0;
+				*dst = arg_track_off_imprecise(dst->frame);
 		} /* else if dst->frame is imprecise it stays so */
 	} else if (class == BPF_ALU64 && BPF_SRC(insn->code) == BPF_X) {
 		if (code == BPF_MOV) {
@@ -1379,11 +1400,11 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 
 	/* Resolve offsets: fold insn->off into arg_track */
 	if (ptr->off_cnt > 0) {
+		resolved = arg_track_state(ptr->frame);
 		resolved.off_cnt = ptr->off_cnt;
-		resolved.frame = ptr->frame;
 		for (oi = 0; oi < ptr->off_cnt; oi++) {
 			if (arg_add(ptr->off[oi], insn->off, &resolved.off[oi])) {
-				resolved.off_cnt = 0;
+				resolved = arg_track_off_imprecise(ptr->frame);
 				break;
 			}
 		}
@@ -1630,8 +1651,8 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 	struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS] = NULL;
 	struct arg_track *at_stack_out = NULL;
 	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
-	struct arg_track unvisited = { .frame = ARG_UNVISITED };
-	struct arg_track none = { .frame = ARG_NONE };
+	struct arg_track unvisited = arg_track_unvisited();
+	struct arg_track none = arg_track_none();
 	bool changed;
 	int i, p, r, err = -ENOMEM;
 
@@ -1895,7 +1916,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	for (int p = po_start; p < po_end; p++) {
 		int idx = env->cfg.insn_postorder[p];
 		struct arg_track callee_args[MAX_AT_TRACK_REGS] = {};
-		struct arg_track none = { .frame = ARG_NONE };
+		struct arg_track none = arg_track_none();
 		struct bpf_insn *insn = &insns[idx];
 		struct func_instance *callee_instance;
 		int callee, target;
-- 
2.34.1

