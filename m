Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A73BA253
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786125; cv=none; b=dFPf66UUk2FgZdXFGr5tcj+1SdZL0ZSlG+W50wlaMPPjpG/lPspLOPVjX1X2jvTMsu9YcxfoBRPgnJzWK9UA2DqRYTlE3FBdOfA3VWfqTUc9VJc0ZJZOGoOFHyNOFfNJodTacp97C92JUzVENuE/yuD7jglbrB8BPz8LgSDCFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786125; c=relaxed/simple;
	bh=mjg482SqVEV1od3q6X8otmiKbzew73tuFwMUhuUhHdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrcEslJXHCvgm8Ko0edFkBKcHacgSkiOdemJncxm1Jop3EDwz+VDv9Le9KgsdEzswWYai+4h0pK2Al7xKSsAZxxH1zLVmzaQRf8g0NvxUOR3hAAxnUFhzaqUTsbaWmafVLONt1sENKQZ6wR/1Edgh5qXhbhtTZcOJpMvQijL7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUMfKtO0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUMfKtO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784786122; x=1816322122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mjg482SqVEV1od3q6X8otmiKbzew73tuFwMUhuUhHdg=;
  b=HUMfKtO0UrgQ/UV16wmb71iaUq5oo6jw53wBz0Pv01aZe77IOEX8xVMv
   vHmEdctUUNAel009Fs3tst57KMVgIzPxJebX68DrXHA95cDbgkvA+sEDT
   j5S9WRYin1F1mTqwlOYTaqbh08jQbNln2kV/NStJLda/kHiQ2QAQWfDVV
   Z6AV7KedncJt0Rqnw+E16fh4s4OcpWXZEGdsiLxk5yplYab/zAKITcOXO
   7rv2fxLLqMPDomWh9AIffQH4fb6JcEIzB2FFVwLfaRQl2LeI8SLuiV/lI
   JqzUuhUbs645Qk1Pf55s0x9S68g3tHHxaqsz37tyxa3s4xwVZvcj3zTN8
   g==;
X-CSE-ConnectionGUID: P4LOC1DDSB6rH+1uwvENIg==
X-CSE-MsgGUID: +5DBaPxwSZGDrtogKh2oBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96573092"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96573092"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:55:21 -0700
X-CSE-ConnectionGUID: 7OGbB9nATmyw3HQ8SA5yvA==
X-CSE-MsgGUID: 8nHKCSVLTFSdNfCKqJorgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="254378326"
Received: from tester.sh.intel.com ([10.112.106.126])
  by fmviesa010.fm.intel.com with ESMTP; 22 Jul 2026 22:55:18 -0700
From: Tao Yu <tao1.yu@intel.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	tao1.yu@intel.com,
	syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com
Subject: [PATCH] bpf: normalize arg_track state construction
Date: Thu, 23 Jul 2026 13:55:08 +0800
Message-Id: <20260723055508.1403247-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reports an uninit-value bug in __arg_track_join() when liveness
analysis propagates arg_track states:

  BUG: KMSAN: uninit-value in __arg_track_join

arg_track carries its state in a union:
- precise pointers use .off[] with off_cnt > 0;
- offset-imprecise pointers use frame >= 0 with off_cnt == 0;
- fully-imprecise pointers use frame == ARG_IMPRECISE with .mask.

The bug is caused by ad-hoc state downgrades and partial state
construction. Some paths only updated selected fields, such as switching
to offset-imprecise by writing off_cnt = 0, or building temporary
arg_track values by filling fields manually. Later joins then copied and
merged these values and KMSAN could observe uninitialized union content
when the state was interpreted through a different union member.

Fix this by normalizing arg_track state construction:
- introduce helpers for ARG_NONE, ARG_UNVISITED, offset-imprecise, and
  fully-imprecise states;
- use these helpers when producing downgraded states;
- replace in-place off_cnt-only downgrades with full object assignment;
- initialize temporary resolved states through the same constructors
  before filling precise offsets.

This keeps arg_track state transitions explicit and ensures every state
seen by join/merge code is fully initialized.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Reported-by: syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com
Signed-off-by: Yu Tao <tao1.yu@intel.com>
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

