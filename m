Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4B31E838
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783521; cv=none; b=IpwnYS37Sb4Yk+AZTqZ+4/yVhIQWHieE7Lv8YyaPxHwyn7kWOXL4L6CQ5c7jkEMlCX81ujd0PfFtJboINzb6Hu1Un7FgP5MjDU15G6h9G8QEc9kWZNA9GrmwCbU+6ZXYCw+L4r24NcPiloj5p4z6Kh036OFvkYt9PDl4CZKAYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783521; c=relaxed/simple;
	bh=ofehPBg6p5ypgMtflxb4hjg7hI60RrOpaD26S9Ytwzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyOVK3S6XqaAXohNPtZx9W7kCTugfUBYJntxgFfLvkiVyIG4vQS++l8J8mhHnzLP4HUjOm19p6POH4fAhnRQ35aPJHv0lKrc68WqPRbw77LxT8gplDmynJEZozVPoAgQVkgDJA3uIirLEL5P/efh91A20hrBWuTiBOZxj96jTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvubIfdf; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvubIfdf"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso810467eec.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783518; x=1776388318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocVmzbZwX5WQlXWp4Rea9luCKOiqE96uEd6CEE74usg=;
        b=YvubIfdfh2f9Xdx7gSgt5m4dEma5sq2el/HXIX7KQKD6VOnJIr5Dcyz7W4k4+GFM1N
         xUQNnwaDNcC0WVmJthE6fZInR0iBeZHOBG4at2lLKjOjzZnXAvKYaYL02E4N6ZEoXQHS
         5Vj+WBAbkiGeFA2PPEkIOMnw+Lbr/ma8y3sLexGcBjubO2OlkgxgOL0uXI/WGhGN3EX/
         Jb1+YDgEevYU+MFaDSmNqkRdOKdSDdTWiaBTF2agOnKhEyS26edimsa/CeqG4i4nAyV9
         cjsV6831Wyh/WayWAu0vdA9qzI5HiTCiZzGM4/0Dlb/0dGaLfYmaJpnJjmqCtnpk2NIM
         GsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783518; x=1776388318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ocVmzbZwX5WQlXWp4Rea9luCKOiqE96uEd6CEE74usg=;
        b=je/i17aGitDQ03ZTX8UDRTiAJrjyUrtJ8tJz4xpJR/clQjVj6vNQmzZfYPTKKXduEt
         wryYOYYZ1PbgcrxR/n0SBi0AKKY/F4iebxQXcD6PP9sSPgN9nMwMewM0JvPMLaPru3k1
         tBnGWMR/y1BWcrLqKzel+lrJ/UPymwP3+QeJhj6GayN/LPK2fZsH3u2nDI9fDVLRHRVt
         Q6Ohe6OXyXYO+F4FxyJSxDLl3u6csFMrV8ZwgJ8KKdc+jyOJC2v6ilc8/G45o+PqzDpp
         9bvE/lyXbZttI0pz/i405mGoE/2NWXWPIouF2hOmBc2chVx+KSTnzK1S9vCikKiZ6BTo
         oUqA==
X-Gm-Message-State: AOJu0Yw9T2WMhW+HUskOrRj4epAFY/LCeRBjfMGDnO13OJYSrOCTI8HJ
	CyPQsOybk/3t2GswCI59n4AYUeDdijZMTwSo2J4TwQRJFvbsrsp8Th9FaleKAWmG
X-Gm-Gg: AeBDievYUSIMrNulgh9YFyBTkmD7QJL/VndsqVOnssTHEbmYZUGQqCFMQR5h/jTT0Za
	R22B7ECOfyY2Yot1EyuQXHpZibaCd3jLptfNUgLGKgVEEJ7kH5AGOb1rCXO9P9sg3+ed2WJzuJo
	bvIHQg5tYXbWz285MqZ282hxeGZiIeNSJHTZvsBIyO6k+INQ5/OJZmdyYaQ5QaJ7MSc/7FZkoXm
	i6Ln0z9wkzt3rzuauYT/6nex3h4Hxakvg/oPnOcLPYx3GEvsujD9USUnJMUCUHwYOU4ZgmAMcOH
	hDOWzYGZoHxQ6m+QAGk06eSjCKLcpszR/kXo0LMAqUXDMaujYqUqcgduLY9oXJbv8GuCyxUaHl8
	qlBO76N5Y3LyhgZOkoRsClwL7EWY5sMTI+ga27ao19qVLPbgthIef7fDEN5gpNrzFHpC7vm51gU
	cO2eq4yB2bHh+FCM1Rv4rF+FTEwPQmlaB55MAsymcOpc4AqszCuyzavfI2p0Ae/Ttg/dfGiU2df
	HduRhU=
X-Received: by 2002:a05:7301:408b:b0:2d0:239a:23b5 with SMTP id 5a478bee46e88-2d59c3a8b6emr535140eec.15.1775783517338;
        Thu, 09 Apr 2026 18:11:57 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 07/13] bpf: introduce forward arg-tracking dataflow analysis
Date: Thu,  9 Apr 2026 18:11:26 -0700
Message-ID: <20260409-patch-set-v2-7-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The analysis is a basis for static liveness tracking mechanism
introduced by the next two commits.

A forward fixed-point analysis that tracks which frame's FP each
register value is derived from, and at what byte offset. This is
needed because a callee can receive a pointer to its caller's stack
frame (e.g. r1 = fp-16 at the call site), then do *(u64 *)(r1 + 0)
inside the callee — a cross-frame stack access that the callee's local
liveness must attribute to the caller's stack.

Each register holds an arg_track value from a three-level lattice:
- Precise {frame=N, off=[o1,o2,...]} — known frame index and
  up to 4 concrete byte offsets
- Offset-imprecise {frame=N, off_cnt=0} — known frame, unknown offset
- Fully-imprecise {frame=ARG_IMPRECISE, mask=bitmask} — unknown frame,
   mask says which frames might be involved

At CFG merge points the lattice moves toward imprecision (same
frame+offset stays precise, same frame different offsets merges offset
sets or becomes offset-imprecise, different frames become
fully-imprecise with OR'd bitmask).

The analysis also tracks spills/fills to the callee's own stack
(at_stack_in/out), so FP derived values spilled and reloaded.

This pass is run recursively per call site: when subprog A calls B
with specific FP-derived arguments, B is re-analyzed with those entry
args. The recursion follows analyze_subprog -> compute_subprog_args ->
(for each call insn) -> analyze_subprog. Subprogs that receive no
FP-derived args are skipped during recursion and analyzed
independently at depth 0.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |    4 +
 kernel/bpf/liveness.c        | 1293 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   16 +-
 3 files changed, 1311 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fac9bf403c5d..b93cb9619d79 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -226,6 +226,7 @@ enum bpf_stack_slot_type {
 
 /* 4-byte stack slot granularity for liveness analysis */
 #define BPF_HALF_REG_SIZE	4
+#define STACK_SLOT_SZ		4
 #define STACK_SLOTS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)	/* 128 */
 
 typedef struct {
@@ -887,6 +888,8 @@ struct bpf_verifier_env {
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
+	/* Per-callsite copy of parent's converged at_stack_in for cross-frame fills. */
+	struct arg_track **callsite_at_stack;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
@@ -1214,6 +1217,7 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
 s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 				 struct bpf_insn *insn, int arg,
 				 int insn_idx);
+int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index a3af5972520f..1b2abc96d5a3 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2,10 +2,13 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf_verifier.h>
+#include <linux/btf.h>
 #include <linux/hashtable.h>
 #include <linux/jhash.h>
 #include <linux/slab.h>
 
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
 /*
  * This file implements live stack slots analysis. After accumulating
  * stack usage data, the analysis answers queries about whether a
@@ -107,6 +110,7 @@ struct per_frame_masks {
 struct func_instance {
 	struct hlist_node hl_node;
 	struct callchain callchain;
+	u32 subprog;		/* subprog index */
 	u32 insn_cnt;		/* cached number of insns in the function */
 	bool updated;
 	bool must_write_dropped;
@@ -200,11 +204,30 @@ static struct func_instance *__lookup_instance(struct bpf_verifier_env *env,
 		return ERR_PTR(-ENOMEM);
 	}
 	memcpy(&result->callchain, callchain, sizeof(*callchain));
+	result->subprog = subprog - env->subprog_info;
 	result->insn_cnt = subprog_sz;
 	hash_add(liveness->func_instances, &result->hl_node, key);
 	return result;
 }
 
+static struct func_instance *call_instance(struct bpf_verifier_env *env,
+					   struct func_instance *caller,
+					   u32 callsite, int subprog)
+{
+	struct callchain cc;
+
+	if (caller) {
+		cc = caller->callchain;
+		cc.callsites[cc.curframe] = callsite;
+		cc.curframe++;
+	} else {
+		memset(&cc, 0, sizeof(cc));
+	}
+	cc.sp_starts[cc.curframe] = env->subprog_info[subprog].start;
+	cc.callsites[cc.curframe] = cc.sp_starts[cc.curframe];
+	return __lookup_instance(env, &cc);
+}
+
 static struct func_instance *lookup_instance(struct bpf_verifier_env *env,
 					     struct bpf_verifier_state *st,
 					     u32 frameno)
@@ -786,3 +809,1273 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
 
 	return false;
 }
+
+/*
+ * Per-register tracking state for compute_subprog_args().
+ * Tracks which frame's FP a value is derived from
+ * and the byte offset from that frame's FP.
+ *
+ * The .frame field forms a lattice with three levels of precision:
+ *
+ *   precise {frame=N, off=V}      -- known absolute frame index and byte offset
+ *        |
+ *   offset-imprecise {frame=N, off=OFF_IMPRECISE}
+ *        |                        -- known frame identity, unknown offset
+ *   fully-imprecise {frame=ARG_IMPRECISE, mask=bitmask}
+ *                                 -- unknown frame identity; .mask is a
+ *                                    bitmask of which frame indices might be
+ *                                    involved
+ *
+ * At CFG merge points, arg_track_join() moves down the lattice:
+ *   - same frame + same offset  -> precise
+ *   - same frame + different offset -> offset-imprecise
+ *   - different frames          -> fully-imprecise (bitmask OR)
+ *
+ * At memory access sites (LDX/STX/ST), offset-imprecise marks only
+ * the known frame's access mask as U64_MAX, while fully-imprecise
+ * iterates bits in the bitmask and routes each frame to its target.
+ */
+#define MAX_ARG_OFFSETS 4
+
+struct arg_track {
+	union {
+		s16 off[MAX_ARG_OFFSETS]; /* byte offsets; off_cnt says how many */
+		u16 mask;	/* arg bitmask when arg == ARG_IMPRECISE */
+	};
+	s8 frame;	/* absolute frame index, or enum arg_track_state */
+	s8 off_cnt;	/* 0 = offset-imprecise, 1-4 = # of precise offsets */
+};
+
+enum arg_track_state {
+	ARG_NONE	= -1,	/* not derived from any argument */
+	ARG_UNVISITED	= -2,	/* not yet reached by dataflow */
+	ARG_IMPRECISE	= -3,	/* lost identity; .mask is arg bitmask */
+};
+
+#define OFF_IMPRECISE	S16_MIN	/* arg identity known but offset unknown */
+
+/* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes each) */
+#define MAX_ARG_SPILL_SLOTS 64
+
+static bool arg_is_visited(const struct arg_track *at)
+{
+	return at->frame != ARG_UNVISITED;
+}
+
+static bool arg_is_fp(const struct arg_track *at)
+{
+	return at->frame >= 0 || at->frame == ARG_IMPRECISE;
+}
+
+/*
+ * Clear all tracked callee stack slots overlapping the byte range
+ * [off, off+sz-1] where off is a negative FP-relative offset.
+ */
+static void clear_overlapping_stack_slots(struct arg_track *at_stack, s16 off, u32 sz)
+{
+	struct arg_track none = { .frame = ARG_NONE };
+
+	if (off == OFF_IMPRECISE) {
+		for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++)
+			at_stack[i] = none;
+		return;
+	}
+	for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++) {
+		int slot_start = -((i + 1) * 8);
+		int slot_end = slot_start + 8;
+
+		if (slot_start < off + sz && slot_end > off)
+			at_stack[i] = none;
+	}
+}
+
+static void verbose_arg_track(struct bpf_verifier_env *env, struct arg_track *at)
+{
+	int i;
+
+	switch (at->frame) {
+	case ARG_NONE:      verbose(env, "_");                          break;
+	case ARG_UNVISITED: verbose(env, "?");                          break;
+	case ARG_IMPRECISE: verbose(env, "IMP%x", at->mask);            break;
+	default:
+		/* frame >= 0: absolute frame index */
+		if (at->off_cnt == 0) {
+			verbose(env, "fp%d ?", at->frame);
+		} else {
+			for (i = 0; i < at->off_cnt; i++) {
+				if (i)
+					verbose(env, "|");
+				verbose(env, "fp%d%+d", at->frame, at->off[i]);
+			}
+		}
+		break;
+	}
+}
+
+static bool arg_track_eq(const struct arg_track *a, const struct arg_track *b)
+{
+	int i;
+
+	if (a->frame != b->frame)
+		return false;
+	if (a->frame == ARG_IMPRECISE)
+		return a->mask == b->mask;
+	if (a->frame < 0)
+		return true;
+	if (a->off_cnt != b->off_cnt)
+		return false;
+	for (i = 0; i < a->off_cnt; i++)
+		if (a->off[i] != b->off[i])
+			return false;
+	return true;
+}
+
+static struct arg_track arg_single(s8 arg, s16 off)
+{
+	struct arg_track at = {};
+
+	at.frame = arg;
+	at.off[0] = off;
+	at.off_cnt = 1;
+	return at;
+}
+
+/*
+ * Merge two sorted offset arrays, deduplicate.
+ * Returns off_cnt=0 if the result exceeds MAX_ARG_OFFSETS.
+ * Both args must have the same frame and off_cnt > 0.
+ */
+static struct arg_track arg_merge_offsets(struct arg_track a, struct arg_track b)
+{
+	struct arg_track result = { .frame = a.frame };
+	struct arg_track imp = { .frame = a.frame };
+	int i = 0, j = 0, k = 0;
+
+	while (i < a.off_cnt && j < b.off_cnt) {
+		s16 v;
+
+		if (a.off[i] <= b.off[j]) {
+			v = a.off[i++];
+			if (v == b.off[j])
+				j++;
+		} else {
+			v = b.off[j++];
+		}
+		if (k > 0 && result.off[k - 1] == v)
+			continue;
+		if (k >= MAX_ARG_OFFSETS)
+			return imp;
+		result.off[k++] = v;
+	}
+	while (i < a.off_cnt) {
+		if (k >= MAX_ARG_OFFSETS)
+			return imp;
+		result.off[k++] = a.off[i++];
+	}
+	while (j < b.off_cnt) {
+		if (k >= MAX_ARG_OFFSETS)
+			return imp;
+		result.off[k++] = b.off[j++];
+	}
+	result.off_cnt = k;
+	return result;
+}
+/*
+ * Collapse to ARG_IMPRECISE with a bitmask of which arg
+ * identities are involved.  This lets memory access sites
+ * mark only the relevant args' access masks and only set
+ * stack_use when AT_CURRENT (bit 0) is in the bitmask.
+ */
+static struct arg_track arg_join_imprecise(struct arg_track a, struct arg_track b)
+{
+	u32 m = 0;
+
+	if (a.frame >= 0)
+		m |= BIT(a.frame);
+	else if (a.frame == ARG_IMPRECISE)
+		m |= a.mask;
+
+	if (b.frame >= 0)
+		m |= BIT(b.frame);
+	else if (b.frame == ARG_IMPRECISE)
+		m |= b.mask;
+
+	return (struct arg_track){ .mask = m, .frame = ARG_IMPRECISE };
+}
+
+/* Join two arg_track values at merge points */
+static struct arg_track __arg_track_join(struct arg_track a, struct arg_track b)
+{
+	if (!arg_is_visited(&b))
+		return a;
+	if (!arg_is_visited(&a))
+		return b;
+	if (a.frame == b.frame && a.frame >= 0) {
+		/* Both offset-imprecise: stay imprecise */
+		if (a.off_cnt == 0 || b.off_cnt == 0)
+			return (struct arg_track){ .frame = a.frame };
+		/* Merge offset sets; falls back to off_cnt=0 if >4 */
+		return arg_merge_offsets(a, b);
+	}
+
+	/*
+	 * args are different, but one of them is known
+	 * arg + none -> arg
+	 * none + arg -> arg
+	 *
+	 * none + none -> none
+	 */
+	if (a.frame == ARG_NONE && b.frame == ARG_NONE)
+		return a;
+	if (a.frame >= 0 && b.frame == ARG_NONE) {
+		/*
+		 * When joining single fp-N add fake fp+0 to
+		 * keep stack_use and prevent stack_def
+		 */
+		if (a.off_cnt == 1)
+			return arg_merge_offsets(a, arg_single(a.frame, 0));
+		return a;
+	}
+	if (b.frame >= 0 && a.frame == ARG_NONE) {
+		if (b.off_cnt == 1)
+			return arg_merge_offsets(b, arg_single(b.frame, 0));
+		return b;
+	}
+
+	return arg_join_imprecise(a, b);
+}
+
+static bool arg_track_join(struct bpf_verifier_env *env, int idx, int target, int r,
+			   struct arg_track *in, struct arg_track out)
+{
+	struct arg_track old = *in;
+	struct arg_track new_val = __arg_track_join(old, out);
+
+	if (arg_track_eq(&new_val, &old))
+		return false;
+
+	*in = new_val;
+	if (!(env->log.level & BPF_LOG_LEVEL2) || !arg_is_visited(&old))
+		return true;
+
+	verbose(env, "arg JOIN insn %d -> %d ", idx, target);
+	if (r >= 0)
+		verbose(env, "r%d: ", r);
+	else
+		verbose(env, "fp%+d: ", r * 8);
+	verbose_arg_track(env, &old);
+	verbose(env, " + ");
+	verbose_arg_track(env, &out);
+	verbose(env, " => ");
+	verbose_arg_track(env, &new_val);
+	verbose(env, "\n");
+	return true;
+}
+
+/*
+ * Compute the result when an ALU op destroys offset precision.
+ * If a single arg is identifiable, preserve it with OFF_IMPRECISE.
+ * If two different args are involved or one is already ARG_IMPRECISE,
+ * the result is fully ARG_IMPRECISE.
+ */
+static void arg_track_alu64(struct arg_track *dst, const struct arg_track *src)
+{
+	WARN_ON_ONCE(!arg_is_visited(dst));
+	WARN_ON_ONCE(!arg_is_visited(src));
+
+	if (dst->frame >= 0 && (src->frame == ARG_NONE || src->frame == dst->frame)) {
+		/*
+		 * rX += rY where rY is not arg derived
+		 * rX += rX
+		 */
+		dst->off_cnt = 0;
+		return;
+	}
+	if (src->frame >= 0 && dst->frame == ARG_NONE) {
+		/*
+		 * rX += rY where rX is not arg derived
+		 * rY identity leaks into rX
+		 */
+		dst->off_cnt = 0;
+		dst->frame = src->frame;
+		return;
+	}
+
+	if (dst->frame == ARG_NONE && src->frame == ARG_NONE)
+		return;
+
+	*dst = arg_join_imprecise(*dst, *src);
+}
+
+static s16 arg_add(s16 off, s64 delta)
+{
+	s64 res;
+
+	if (off == OFF_IMPRECISE)
+		return OFF_IMPRECISE;
+	res = (s64)off + delta;
+	if (res < S16_MIN + 1 || res > S16_MAX)
+		return OFF_IMPRECISE;
+	return res;
+}
+
+static void arg_padd(struct arg_track *at, s64 delta)
+{
+	int i;
+
+	if (at->off_cnt == 0)
+		return;
+	for (i = 0; i < at->off_cnt; i++) {
+		s16 new_off = arg_add(at->off[i], delta);
+
+		if (new_off == OFF_IMPRECISE) {
+			at->off_cnt = 0;
+			return;
+		}
+		at->off[i] = new_off;
+	}
+}
+
+/*
+ * Convert a byte offset from FP to a callee stack slot index (0-7).
+ * Returns -1 if out of range or not 8-byte aligned.
+ * Slot 0 = fp-8, slot 1 = fp-16, ..., slot 7 = fp-64.
+ */
+static int fp_off_to_slot(s16 off)
+{
+	if (off == OFF_IMPRECISE)
+		return -1;
+	if (off >= 0 || off < -(int)(MAX_ARG_SPILL_SLOTS * 8))
+		return -1;
+	if (off % 8)
+		return -1;
+	return (-off) / 8 - 1;
+}
+
+/*
+ * Join stack slot states across all possible FP offsets tracked in @reg.
+ * When a register holds multiple possible FP-derived offsets (off_cnt > 1),
+ * this merges the arg_track from each corresponding stack slot rather than
+ * falling back to imprecise.
+ */
+static struct arg_track fill_from_stack(struct bpf_insn *insn,
+					struct arg_track *at_out, int reg,
+					struct arg_track *at_stack_out,
+					int depth)
+{
+	int frame = at_out[reg].frame;
+	struct arg_track imp = {
+		.mask = frame >= 0 ? BIT(frame) : (1u << (depth + 1)) - 1,
+		.frame = ARG_IMPRECISE
+	};
+	struct arg_track result = { .frame = ARG_NONE };
+	int cnt, i;
+
+	if (reg == BPF_REG_FP) {
+		int slot = fp_off_to_slot(insn->off);
+
+		return slot >= 0 ? at_stack_out[slot] : imp;
+	}
+	cnt = at_out[reg].off_cnt;
+	if (cnt == 0)
+		return imp;
+
+	for (i = 0; i < cnt; i++) {
+		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
+		int slot = fp_off_to_slot(fp_off);
+
+		if (slot < 0)
+			return imp;
+		result = __arg_track_join(result, at_stack_out[slot]);
+	}
+	return result;
+}
+
+/*
+ * Spill @val to all possible stack slots indicated by the FP offsets in @reg.
+ * For an 8-byte store, each candidate slot gets @val; for sub-8-byte stores
+ * the slot is cleared to ARG_NONE.
+ */
+static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
+			   int reg, struct arg_track *at_stack_out,
+			   struct arg_track *val, u32 sz)
+{
+	struct arg_track none = { .frame = ARG_NONE };
+	int cnt, i;
+
+	if (reg == BPF_REG_FP) {
+		int slot = fp_off_to_slot(insn->off);
+
+		if (slot >= 0)
+			at_stack_out[slot] = sz == 8 ? *val : none;
+		else
+			clear_overlapping_stack_slots(at_stack_out, insn->off, sz);
+		return;
+	}
+	cnt = at_out[reg].off_cnt;
+	if (cnt == 0) {
+		clear_overlapping_stack_slots(at_stack_out, OFF_IMPRECISE, sz);
+		return;
+	}
+	for (i = 0; i < cnt; i++) {
+		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
+		int slot = fp_off_to_slot(fp_off);
+
+		if (slot >= 0)
+			at_stack_out[slot] = sz == 8 ? *val : none;
+		else
+			clear_overlapping_stack_slots(at_stack_out, fp_off, sz);
+	}
+}
+
+/*
+ * Clear stack slots overlapping all possible FP offsets in @reg.
+ */
+static void clear_stack_for_all_offs(struct bpf_insn *insn,
+				     struct arg_track *at_out, int reg,
+				     struct arg_track *at_stack_out, u32 sz)
+{
+	int cnt, i;
+
+	if (reg == BPF_REG_FP) {
+		clear_overlapping_stack_slots(at_stack_out, insn->off, sz);
+		return;
+	}
+	cnt = at_out[reg].off_cnt;
+	if (cnt == 0) {
+		clear_overlapping_stack_slots(at_stack_out, OFF_IMPRECISE, sz);
+		return;
+	}
+	for (i = 0; i < cnt; i++) {
+		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
+
+		clear_overlapping_stack_slots(at_stack_out, fp_off, sz);
+	}
+}
+
+static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, int idx,
+			  struct arg_track *at_in, struct arg_track *at_stack_in,
+			  struct arg_track *at_out, struct arg_track *at_stack_out)
+{
+	bool printed = false;
+	int i;
+
+	if (!(env->log.level & BPF_LOG_LEVEL2))
+		return;
+	for (i = 0; i < MAX_BPF_REG; i++) {
+		if (arg_track_eq(&at_out[i], &at_in[i]))
+			continue;
+		if (!printed) {
+			verbose(env, "%3d: ", idx);
+			bpf_verbose_insn(env, insn);
+			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
+			printed = true;
+		}
+		verbose(env, "\tr%d: ", i); verbose_arg_track(env, &at_in[i]);
+		verbose(env, " -> "); verbose_arg_track(env, &at_out[i]);
+	}
+	for (i = 0; i < MAX_ARG_SPILL_SLOTS; i++) {
+		if (arg_track_eq(&at_stack_out[i], &at_stack_in[i]))
+			continue;
+		if (!printed) {
+			verbose(env, "%3d: ", idx);
+			bpf_verbose_insn(env, insn);
+			bpf_vlog_reset(&env->log, env->log.end_pos - 1);
+			printed = true;
+		}
+		verbose(env, "\tfp%+d: ", -(i + 1) * 8); verbose_arg_track(env, &at_stack_in[i]);
+		verbose(env, " -> "); verbose_arg_track(env, &at_stack_out[i]);
+	}
+	if (printed)
+		verbose(env, "\n");
+}
+
+/*
+ * Pure dataflow transfer function for arg_track state.
+ * Updates at_out[] based on how the instruction modifies registers.
+ * Tracks spill/fill, but not other memory accesses.
+ */
+static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   int insn_idx,
+			   struct arg_track *at_out, struct arg_track *at_stack_out,
+			   struct func_instance *instance,
+			   u32 *callsites)
+{
+	int depth = instance->callchain.curframe;
+	u8 class = BPF_CLASS(insn->code);
+	u8 code = BPF_OP(insn->code);
+	struct arg_track *dst = &at_out[insn->dst_reg];
+	struct arg_track *src = &at_out[insn->src_reg];
+	struct arg_track none = { .frame = ARG_NONE };
+	int r;
+
+	if (class == BPF_ALU64 && BPF_SRC(insn->code) == BPF_K) {
+		if (code == BPF_MOV) {
+			*dst = none;
+		} else if (dst->frame >= 0) {
+			if (code == BPF_ADD)
+				arg_padd(dst, insn->imm);
+			else if (code == BPF_SUB)
+				arg_padd(dst, -(s64)insn->imm);
+			else
+				/* Any other 64-bit alu on the pointer makes it imprecise */
+				dst->off_cnt = 0;
+		} /* else if dst->frame is imprecise it stays so */
+	} else if (class == BPF_ALU64 && BPF_SRC(insn->code) == BPF_X) {
+		if (code == BPF_MOV) {
+			if (insn->off == 0) {
+				*dst = *src;
+			} else {
+				/* addr_space_cast destroys a pointer */
+				*dst = none;
+			}
+		} else {
+			arg_track_alu64(dst, src);
+		}
+	} else if (class == BPF_ALU) {
+		/*
+		 * 32-bit alu destroys the pointer.
+		 * If src was a pointer it cannot leak into dst
+		 */
+		*dst = none;
+	} else if (class == BPF_JMP && code == BPF_CALL) {
+		/*
+		 * at_stack_out[slot] is not cleared by the helper and subprog calls.
+		 * The fill_from_stack() may return the stale spill — which is an FP-derived arg_track
+		 * (the value that was originally spilled there). The loaded register then carries
+		 * a phantom FP-derived identity that doesn't correspond to what's actually in the slot.
+		 * This phantom FP pointer propagates forward, and wherever it's subsequently used
+		 * (as a helper argument, another store, etc.), it sets stack liveness bits.
+		 * Those bits correspond to stack accesses that don't actually happen.
+		 * So the effect is over-reporting stack liveness — marking slots as live that aren't
+		 * actually accessed. The verifier preserves more state than necessary across calls,
+		 * which is conservative.
+		 *
+		 * helpers can scratch stack slots, but they won't make a valid pointer out of it.
+		 * subprogs are allowed to write into parent slots, but they cannot write
+		 * _any_ FP-derived pointer into it (either their own or parent's FP).
+		 */
+		for (r = BPF_REG_0; r <= BPF_REG_5; r++)
+			at_out[r] = none;
+	} else if (class == BPF_LDX) {
+		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
+		bool src_is_local_fp = insn->src_reg == BPF_REG_FP || src->frame == depth ||
+				       (src->frame == ARG_IMPRECISE && (src->mask & BIT(depth)));
+
+		/*
+		 * Reload from callee stack: if src is current-frame FP-derived
+		 * and the load is an 8-byte BPF_MEM, try to restore the spill
+		 * identity.  For imprecise sources fill_from_stack() returns
+		 * ARG_IMPRECISE (off_cnt == 0).
+		 */
+		if (src_is_local_fp && BPF_MODE(insn->code) == BPF_MEM && sz == 8) {
+			*dst = fill_from_stack(insn, at_out, insn->src_reg, at_stack_out, depth);
+		} else if (src->frame >= 0 && src->frame < depth &&
+			   BPF_MODE(insn->code) == BPF_MEM && sz == 8) {
+			struct arg_track *parent_stack =
+				env->callsite_at_stack[callsites[src->frame]];
+
+			*dst = fill_from_stack(insn, at_out, insn->src_reg,
+					       parent_stack, src->frame);
+		} else if (src->frame == ARG_IMPRECISE &&
+			   !(src->mask & BIT(depth)) && src->mask &&
+			   BPF_MODE(insn->code) == BPF_MEM && sz == 8) {
+			/*
+			 * Imprecise src with only parent-frame bits:
+			 * conservative fallback.
+			 */
+			*dst = *src;
+		} else {
+			*dst = none;
+		}
+	} else if (class == BPF_LD && BPF_MODE(insn->code) == BPF_IMM) {
+		*dst = none;
+	} else if (class == BPF_STX) {
+		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
+		bool dst_is_local_fp;
+
+		/* Track spills to current-frame FP-derived callee stack */
+		dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+		if (dst_is_local_fp && BPF_MODE(insn->code) == BPF_MEM)
+			spill_to_stack(insn, at_out, insn->dst_reg,
+				       at_stack_out, src, sz);
+
+		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
+			if (dst_is_local_fp && insn->imm != BPF_LOAD_ACQ)
+				clear_stack_for_all_offs(insn, at_out, insn->dst_reg,
+							 at_stack_out, sz);
+
+			if (insn->imm == BPF_CMPXCHG)
+				at_out[BPF_REG_0] = none;
+			else if (insn->imm == BPF_LOAD_ACQ)
+				*dst = none;
+			else if (insn->imm & BPF_FETCH)
+				*src = none;
+		}
+	} else if (class == BPF_ST && BPF_MODE(insn->code) == BPF_MEM) {
+		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
+		bool dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+
+		/* BPF_ST to FP-derived dst: clear overlapping stack slots */
+		if (dst_is_local_fp)
+			clear_stack_for_all_offs(insn, at_out, insn->dst_reg,
+						 at_stack_out, sz);
+	}
+}
+
+/*
+ * Record access_bytes from helper/kfunc or load/store insn.
+ *   access_bytes > 0:      stack read
+ *   access_bytes < 0:      stack write
+ *   access_bytes == S64_MIN: unknown   — conservative, mark [0..slot] as read
+ *   access_bytes == 0:      no access
+ *
+ */
+static int record_stack_access_off(struct bpf_verifier_env *env,
+				   struct func_instance *instance, s64 fp_off,
+				   s64 access_bytes, u32 frame, u32 insn_idx)
+{
+	s32 slot_hi, slot_lo;
+	spis_t mask;
+
+	if (fp_off >= 0)
+		/*
+		 * out of bounds stack access doesn't contribute
+		 * into actual stack liveness. It will be rejected
+		 * by the main verifier pass later.
+		 */
+		return 0;
+	if (access_bytes == S64_MIN) {
+		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 */
+		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
+		mask = SPIS_ZERO;
+		spis_or_range(&mask, 0, slot_hi);
+		return mark_stack_read(instance, frame, insn_idx, mask);
+	}
+	if (access_bytes > 0) {
+		/* Mark any touched slot as use */
+		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
+		slot_lo = max_t(s32, (-fp_off - access_bytes) / STACK_SLOT_SZ, 0);
+		mask = SPIS_ZERO;
+		spis_or_range(&mask, slot_lo, slot_hi);
+		return mark_stack_read(instance, frame, insn_idx, mask);
+	} else if (access_bytes < 0) {
+		/* Mark only fully covered slots as def */
+		access_bytes = -access_bytes;
+		slot_hi = (-fp_off) / STACK_SLOT_SZ - 1;
+		slot_lo = max_t(s32, (-fp_off - access_bytes + STACK_SLOT_SZ - 1) / STACK_SLOT_SZ, 0);
+		if (slot_lo <= slot_hi) {
+			mask = SPIS_ZERO;
+			spis_or_range(&mask, slot_lo, slot_hi);
+			bpf_mark_stack_write(env, frame, mask);
+		}
+	}
+	return 0;
+}
+
+/*
+ * 'arg' is FP-derived argument to helper/kfunc or load/store that
+ * reads (positive) or writes (negative) 'access_bytes' into 'use' or 'def'.
+ */
+static int record_stack_access(struct bpf_verifier_env *env,
+			       struct func_instance *instance,
+			       const struct arg_track *arg,
+			       s64 access_bytes, u32 frame, u32 insn_idx)
+{
+	int i, err;
+
+	if (access_bytes == 0)
+		return 0;
+	if (arg->off_cnt == 0) {
+		if (access_bytes > 0)
+			return mark_stack_read(instance, frame, insn_idx, SPIS_ALL);
+		return 0;
+	}
+	if (access_bytes != S64_MIN && access_bytes < 0 && arg->off_cnt != 1)
+		/* multi-offset write cannot set stack_def */
+		return 0;
+
+	for (i = 0; i < arg->off_cnt; i++) {
+		err = record_stack_access_off(env, instance, arg->off[i], access_bytes, frame, insn_idx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/*
+ * When a pointer is ARG_IMPRECISE, conservatively mark every frame in
+ * the bitmask as fully used.
+ */
+static int record_imprecise(struct func_instance *instance, u32 mask, u32 insn_idx)
+{
+	int depth = instance->callchain.curframe;
+	int f, err;
+
+	for (f = 0; mask; f++, mask >>= 1) {
+		if (!(mask & 1))
+			continue;
+		if (f <= depth) {
+			err = mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+/* Record load/store access for a given 'at' state of 'insn'. */
+static int record_load_store_access(struct bpf_verifier_env *env,
+				    struct func_instance *instance,
+				    struct arg_track *at, int insn_idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	int depth = instance->callchain.curframe;
+	s32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	u8 class = BPF_CLASS(insn->code);
+	struct arg_track resolved, *ptr;
+	int oi;
+
+	switch (class) {
+	case BPF_LDX:
+		ptr = &at[insn->src_reg];
+		break;
+	case BPF_STX:
+		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
+			if (insn->imm == BPF_STORE_REL)
+				sz = -sz;
+			if (insn->imm == BPF_LOAD_ACQ)
+				ptr = &at[insn->src_reg];
+			else
+				ptr = &at[insn->dst_reg];
+		} else {
+			ptr = &at[insn->dst_reg];
+			sz = -sz;
+		}
+		break;
+	case BPF_ST:
+		ptr = &at[insn->dst_reg];
+		sz = -sz;
+		break;
+	default:
+		return 0;
+	}
+
+	/* Resolve offsets: fold insn->off into arg_track */
+	if (ptr->off_cnt > 0) {
+		resolved.off_cnt = ptr->off_cnt;
+		resolved.frame = ptr->frame;
+		for (oi = 0; oi < ptr->off_cnt; oi++) {
+			resolved.off[oi] = arg_add(ptr->off[oi], insn->off);
+			if (resolved.off[oi] == OFF_IMPRECISE) {
+				resolved.off_cnt = 0;
+				break;
+			}
+		}
+		ptr = &resolved;
+	}
+
+	if (ptr->frame >= 0 && ptr->frame <= depth)
+		return record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
+	if (ptr->frame == ARG_IMPRECISE)
+		return record_imprecise(instance, ptr->mask, insn_idx);
+	/* ARG_NONE: not derived from any frame pointer, skip */
+	return 0;
+}
+
+/* Record stack access for a given 'at' state of helper/kfunc 'insn' */
+static int record_call_access(struct bpf_verifier_env *env,
+			      struct func_instance *instance,
+			      struct arg_track *at,
+			      int insn_idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	int depth = instance->callchain.curframe;
+	struct bpf_call_summary cs;
+	int r, err = 0, num_params = 5;
+
+	if (bpf_pseudo_call(insn))
+		return 0;
+
+	if (bpf_get_call_summary(env, insn, &cs))
+		num_params = cs.num_params;
+
+	for (r = BPF_REG_1; r < BPF_REG_1 + num_params; r++) {
+		int frame = at[r].frame;
+		s64 bytes;
+
+		if (!arg_is_fp(&at[r]))
+			continue;
+
+		if (bpf_helper_call(insn)) {
+			bytes = bpf_helper_stack_access_bytes(env, insn, r - 1, insn_idx);
+		} else if (bpf_pseudo_kfunc_call(insn)) {
+			bytes = bpf_kfunc_stack_access_bytes(env, insn, r - 1, insn_idx);
+		} else {
+			for (int f = 0; f <= depth; f++) {
+				err = mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+				if (err)
+					return err;
+			}
+			return 0;
+		}
+		if (bytes == 0)
+			continue;
+
+		if (frame >= 0 && frame <= depth)
+			err = record_stack_access(env, instance, &at[r], bytes, frame, insn_idx);
+		else if (frame == ARG_IMPRECISE)
+			err = record_imprecise(instance, at[r].mask, insn_idx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/*
+ * For a calls_callback helper, find the callback subprog and determine
+ * which caller register maps to which callback register for FP passthrough.
+ */
+static int find_callback_subprog(struct bpf_verifier_env *env,
+				 struct bpf_insn *insn, int insn_idx,
+				 int *caller_reg, int *callee_reg)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+	int cb_reg = -1;
+
+	*caller_reg = -1;
+	*callee_reg = -1;
+
+	if (!bpf_helper_call(insn))
+		return -1;
+	switch (insn->imm) {
+	case BPF_FUNC_loop:
+		/* bpf_loop(nr, cb, ctx, flags): cb=R2, R3->cb R2 */
+		cb_reg = BPF_REG_2;
+		*caller_reg = BPF_REG_3;
+		*callee_reg = BPF_REG_2;
+		break;
+	case BPF_FUNC_for_each_map_elem:
+		/* for_each_map_elem(map, cb, ctx, flags): cb=R2, R3->cb R4 */
+		cb_reg = BPF_REG_2;
+		*caller_reg = BPF_REG_3;
+		*callee_reg = BPF_REG_4;
+		break;
+	case BPF_FUNC_find_vma:
+		/* find_vma(task, addr, cb, ctx, flags): cb=R3, R4->cb R3 */
+		cb_reg = BPF_REG_3;
+		*caller_reg = BPF_REG_4;
+		*callee_reg = BPF_REG_3;
+		break;
+	case BPF_FUNC_user_ringbuf_drain:
+		/* user_ringbuf_drain(map, cb, ctx, flags): cb=R2, R3->cb R2 */
+		cb_reg = BPF_REG_2;
+		*caller_reg = BPF_REG_3;
+		*callee_reg = BPF_REG_2;
+		break;
+	default:
+		return -1;
+	}
+
+	if (!(aux->const_reg_subprog_mask & BIT(cb_reg)))
+		return -2;
+
+	return aux->const_reg_vals[cb_reg];
+}
+
+/* Per-subprog intermediate state kept alive across analysis phases */
+struct subprog_at_info {
+	struct arg_track (*at_in)[MAX_BPF_REG];
+	int len;
+};
+
+static void print_subprog_arg_access(struct bpf_verifier_env *env,
+				     int subprog,
+				     struct subprog_at_info *info,
+				     struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS])
+{
+	struct bpf_insn *insns = env->prog->insnsi;
+	int start = env->subprog_info[subprog].start;
+	int len = info->len;
+	int i, r;
+
+	if (!(env->log.level & BPF_LOG_LEVEL2))
+		return;
+
+	verbose(env, "subprog#%d %s:\n", subprog,
+		env->prog->aux->func_info
+		? btf_name_by_offset(env->prog->aux->btf,
+				     btf_type_by_id(env->prog->aux->btf,
+						    env->prog->aux->func_info[subprog].type_id)->name_off)
+		: "");
+	for (i = 0; i < len; i++) {
+		int idx = start + i;
+		bool has_extra = false;
+		u8 cls = BPF_CLASS(insns[idx].code);
+		bool is_ldx_stx_call = cls == BPF_LDX || cls == BPF_STX ||
+				       insns[idx].code == (BPF_JMP | BPF_CALL);
+
+		verbose(env, "%3d: ", idx);
+		bpf_verbose_insn(env, &insns[idx]);
+
+		/* Collect what needs printing */
+		if (is_ldx_stx_call &&
+		    arg_is_visited(&info->at_in[i][0])) {
+			for (r = 0; r < MAX_BPF_REG - 1; r++)
+				if (arg_is_fp(&info->at_in[i][r]))
+					has_extra = true;
+		}
+		if (is_ldx_stx_call) {
+			for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
+				if (arg_is_fp(&at_stack_in[i][r]))
+					has_extra = true;
+		}
+
+		if (!has_extra) {
+			if (bpf_is_ldimm64(&insns[idx]))
+				i++;
+			continue;
+		}
+
+		bpf_vlog_reset(&env->log, env->log.end_pos - 1);
+		verbose(env, " //");
+
+		if (is_ldx_stx_call && info->at_in &&
+		    arg_is_visited(&info->at_in[i][0])) {
+			for (r = 0; r < MAX_BPF_REG - 1; r++) {
+				if (!arg_is_fp(&info->at_in[i][r]))
+					continue;
+				verbose(env, " r%d=", r);
+				verbose_arg_track(env, &info->at_in[i][r]);
+			}
+		}
+
+		if (is_ldx_stx_call) {
+			for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++) {
+				if (!arg_is_fp(&at_stack_in[i][r]))
+					continue;
+				verbose(env, " fp%+d=", -(r + 1) * 8);
+				verbose_arg_track(env, &at_stack_in[i][r]);
+			}
+		}
+
+		verbose(env, "\n");
+		if (bpf_is_ldimm64(&insns[idx]))
+			i++;
+	}
+}
+
+/*
+ * Compute arg tracking dataflow for a single subprog.
+ * Runs forward fixed-point with arg_track_xfer(), then records
+ * memory accesses in a single linear pass over converged state.
+ *
+ * @callee_entry: pre-populated entry state for R1-R5
+ *                NULL for main (subprog 0).
+ * @info:         stores at_in, len for debug printing.
+ */
+static int compute_subprog_args(struct bpf_verifier_env *env,
+				struct subprog_at_info *info,
+				struct arg_track *callee_entry,
+				struct func_instance *instance,
+				u32 *callsites)
+{
+	int subprog = instance->subprog;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int depth = instance->callchain.curframe;
+	int start = env->subprog_info[subprog].start;
+	int po_start = env->subprog_info[subprog].postorder_start;
+	int end = env->subprog_info[subprog + 1].start;
+	int po_end = env->subprog_info[subprog + 1].postorder_start;
+	int len = end - start;
+	struct arg_track (*at_in)[MAX_BPF_REG] = NULL;
+	struct arg_track at_out[MAX_BPF_REG];
+	struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS] = NULL;
+	struct arg_track *at_stack_out = NULL;
+	struct arg_track unvisited = { .frame = ARG_UNVISITED };
+	struct arg_track none = { .frame = ARG_NONE };
+	bool changed;
+	int i, p, r, err = -ENOMEM;
+
+	at_in = kvmalloc_objs(*at_in, len, GFP_KERNEL_ACCOUNT);
+	if (!at_in)
+		goto err_free;
+
+	at_stack_in = kvmalloc_objs(*at_stack_in, len, GFP_KERNEL_ACCOUNT);
+	if (!at_stack_in)
+		goto err_free;
+
+	at_stack_out = kvmalloc_objs(*at_stack_out, MAX_ARG_SPILL_SLOTS, GFP_KERNEL_ACCOUNT);
+	if (!at_stack_out)
+		goto err_free;
+
+	for (i = 0; i < len; i++) {
+		for (r = 0; r < MAX_BPF_REG; r++)
+			at_in[i][r] = unvisited;
+		for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
+			at_stack_in[i][r] = unvisited;
+	}
+
+	for (r = 0; r < MAX_BPF_REG; r++)
+		at_in[0][r] = none;
+
+	/* Entry: R10 is always precisely the current frame's FP */
+	at_in[0][BPF_REG_FP] = arg_single(depth, 0);
+
+	/* R1-R5: from caller or ARG_NONE for main */
+	if (callee_entry) {
+		for (r = BPF_REG_1; r <= BPF_REG_5; r++)
+			at_in[0][r] = callee_entry[r];
+	}
+
+	/* Entry: all stack slots are ARG_NONE */
+	for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
+		at_stack_in[0][r] = none;
+
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "subprog#%d: analyzing (depth %d)...\n", subprog, depth);
+
+	/* Forward fixed-point iteration in reverse post order */
+redo:
+	changed = false;
+	for (p = po_end - 1; p >= po_start; p--) {
+		int idx = env->cfg.insn_postorder[p];
+		int i = idx - start;
+		struct bpf_insn *insn = &insns[idx];
+		struct bpf_iarray *succ;
+
+		if (!arg_is_visited(&at_in[i][0]) && !arg_is_visited(&at_in[i][1]))
+			continue;
+
+		memcpy(at_out, at_in[i], sizeof(at_out));
+		memcpy(at_stack_out, at_stack_in[i], MAX_ARG_SPILL_SLOTS * sizeof(*at_stack_out));
+
+		arg_track_xfer(env, insn, idx, at_out, at_stack_out, instance, callsites);
+		arg_track_log(env, insn, idx, at_in[i], at_stack_in[i], at_out, at_stack_out);
+
+		/* Propagate to successors within this subprogram */
+		succ = bpf_insn_successors(env, idx);
+		for (int s = 0; s < succ->cnt; s++) {
+			int target = succ->items[s];
+			int ti;
+
+			/* Filter: stay within the subprogram's range */
+			if (target < start || target >= end)
+				continue;
+			ti = target - start;
+
+			for (r = 0; r < MAX_BPF_REG; r++)
+				changed |= arg_track_join(env, idx, target, r,
+							  &at_in[ti][r], at_out[r]);
+
+			for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
+				changed |= arg_track_join(env, idx, target, -r - 1,
+							  &at_stack_in[ti][r], at_stack_out[r]);
+		}
+	}
+	if (changed)
+		goto redo;
+
+	/* Record memory accesses using converged at_in (RPO skips dead code) */
+	for (p = po_end - 1; p >= po_start; p--) {
+		int idx = env->cfg.insn_postorder[p];
+		int i = idx - start;
+		struct bpf_insn *insn = &insns[idx];
+
+		reset_stack_write_marks(env, instance);
+		err = record_load_store_access(env, instance, at_in[i], idx);
+		if (err)
+			goto err_free;
+
+		if (insn->code == (BPF_JMP | BPF_CALL)) {
+			err = record_call_access(env, instance, at_in[i], idx);
+			if (err)
+				goto err_free;
+		}
+
+		if (bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) {
+			kvfree(env->callsite_at_stack[idx]);
+			env->callsite_at_stack[idx] =
+				kvmalloc_objs(*env->callsite_at_stack[idx],
+					      MAX_ARG_SPILL_SLOTS, GFP_KERNEL_ACCOUNT);
+			if (!env->callsite_at_stack[idx])
+				goto err_free;
+			memcpy(env->callsite_at_stack[idx],
+			       at_stack_in[i], sizeof(struct arg_track) * MAX_ARG_SPILL_SLOTS);
+		}
+		err = commit_stack_write_marks(env, instance, idx);
+		if (err)
+			goto err_free;
+	}
+
+	info->at_in = at_in;
+	at_in = NULL;
+	info->len = len;
+	print_subprog_arg_access(env, subprog, info, at_stack_in);
+	err = 0;
+
+err_free:
+	kvfree(at_stack_out);
+	kvfree(at_stack_in);
+	kvfree(at_in);
+	return err;
+}
+
+/*
+ * Recursively analyze a subprog with specific 'entry_args'.
+ * Each callee is analyzed with the exact args from its call site.
+ *
+ * Args are recomputed for each call because the dataflow result at_in[]
+ * depends on the entry args and frame depth. Consider: A->C->D and B->C->D
+ * Callsites in A and B pass different args into C, so C is recomputed.
+ * Then within C the same callsite passes different args into D.
+ */
+static int analyze_subprog(struct bpf_verifier_env *env,
+			   struct arg_track *entry_args,
+			   struct subprog_at_info *info,
+			   struct func_instance *instance,
+			   u32 *callsites)
+{
+	int subprog = instance->subprog;
+	int depth = instance->callchain.curframe;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int start = env->subprog_info[subprog].start;
+	int po_start = env->subprog_info[subprog].postorder_start;
+	int po_end = env->subprog_info[subprog + 1].postorder_start;
+	int j, err;
+
+	/* Free prior analysis if this subprog was already visited */
+	kvfree(info[subprog].at_in);
+	info[subprog].at_in = NULL;
+
+	err = compute_subprog_args(env, &info[subprog], entry_args, instance, callsites);
+	if (err)
+		return err;
+
+	/* For each reachable call site in the subprog, recurse into callees */
+	for (int p = po_start; p < po_end; p++) {
+		int idx = env->cfg.insn_postorder[p];
+		struct arg_track callee_args[BPF_REG_5 + 1];
+		struct arg_track none = { .frame = ARG_NONE };
+		struct bpf_insn *insn = &insns[idx];
+		struct func_instance *callee_instance;
+		int callee, target;
+		int caller_reg, cb_callee_reg;
+
+		j = idx - start; /* relative index within this subprog */
+
+		if (bpf_pseudo_call(insn)) {
+			target = idx + insn->imm + 1;
+			callee = bpf_find_subprog(env, target);
+			if (callee < 0)
+				continue;
+
+			/* Build entry args: R1-R5 from at_in at call site */
+			for (int r = BPF_REG_1; r <= BPF_REG_5; r++)
+				callee_args[r] = info[subprog].at_in[j][r];
+		} else if (bpf_calls_callback(env, idx)) {
+			callee = find_callback_subprog(env, insn, idx, &caller_reg, &cb_callee_reg);
+			if (callee == -2) {
+				/*
+				 * same bpf_loop() calls two different callbacks and passes
+				 * stack pointer to them
+				 */
+				if (info[subprog].at_in[j][caller_reg].frame == ARG_NONE)
+					continue;
+				for (int f = 0; f <= depth; f++) {
+					err = mark_stack_read(instance, f, idx, SPIS_ALL);
+					if (err)
+						return err;
+				}
+				continue;
+			}
+			if (callee < 0)
+				continue;
+
+			for (int r = BPF_REG_1; r <= BPF_REG_5; r++)
+				callee_args[r] = none;
+			callee_args[cb_callee_reg] = info[subprog].at_in[j][caller_reg];
+		} else {
+			continue;
+		}
+
+		if (depth == MAX_CALL_FRAMES - 1)
+			return -EINVAL;
+
+		callee_instance = call_instance(env, instance, idx, callee);
+		if (IS_ERR(callee_instance))
+			return PTR_ERR(callee_instance);
+		callsites[depth] = idx;
+		err = analyze_subprog(env, callee_args, info, callee_instance, callsites);
+		if (err)
+			return err;
+	}
+
+	return update_instance(env, instance);
+}
+
+int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
+{
+	u32 callsites[MAX_CALL_FRAMES] = {};
+	int insn_cnt = env->prog->len;
+	struct func_instance *instance;
+	struct subprog_at_info *info;
+	int k, err = 0;
+
+	info = kvzalloc_objs(*info, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
+	if (!info)
+		return -ENOMEM;
+
+	env->callsite_at_stack = kvzalloc_objs(*env->callsite_at_stack, insn_cnt,
+					       GFP_KERNEL_ACCOUNT);
+	if (!env->callsite_at_stack) {
+		kvfree(info);
+		return -ENOMEM;
+	}
+
+	instance = call_instance(env, NULL, 0, 0);
+	if (IS_ERR(instance)) {
+		err = PTR_ERR(instance);
+		goto out;
+	}
+	err = analyze_subprog(env, NULL, info, instance, callsites);
+	if (err)
+		goto out;
+
+	/*
+	 * Subprogs and callbacks that don't receive FP-derived arguments
+	 * cannot access ancestor stack frames, so they were skipped during
+	 * the recursive walk above.  Async callbacks (timer, workqueue) are
+	 * also not reachable from the main program's call graph.  Analyze
+	 * all unvisited subprogs as independent roots at depth 0.
+	 *
+	 * Use reverse topological order (callers before callees) so that
+	 * each subprog is analyzed before its callees, allowing the
+	 * recursive walk inside analyze_subprog() to naturally
+	 * reach nested callees that also lack FP-derived args.
+	 */
+	for (k = env->subprog_cnt - 1; k >= 0; k--) {
+		int sub = env->subprog_topo_order[k];
+
+		if (info[sub].at_in && !bpf_subprog_is_global(env, sub))
+			continue;
+		instance = call_instance(env, NULL, 0, sub);
+		if (IS_ERR(instance)) {
+			err = PTR_ERR(instance);
+			goto out;
+		}
+		err = analyze_subprog(env, NULL, info, instance, callsites);
+		if (err)
+			goto out;
+	}
+
+out:
+	for (k = 0; k < insn_cnt; k++)
+		kvfree(env->callsite_at_stack[k]);
+	kvfree(env->callsite_at_stack);
+	env->callsite_at_stack = NULL;
+	for (k = 0; k < env->subprog_cnt; k++)
+		kvfree(info[k].at_in);
+	kvfree(info);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0731e99aa541..4e8a6813af4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20256,6 +20256,15 @@ static int clean_live_states(struct bpf_verifier_env *env, int insn,
 	struct list_head *pos, *head;
 	int err;
 
+	/* keep cleaning the current state as registers/stack become dead */
+	err = clean_verifier_state(env, cur);
+	if (err)
+		return err;
+
+	/*
+	 * can simply return here, since cached states will also be clean,
+	 * but keep old logic for the sake of dynamic liveness.
+	 */
 	head = explored_state(env, insn);
 	list_for_each(pos, head) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -20267,8 +20276,6 @@ static int clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.cleaned)
 			/* all regs in this state in all frames were already marked */
 			continue;
-		if (incomplete_read_marks(env, &sl->state))
-			continue;
 		err = clean_verifier_state(env, &sl->state);
 		if (err)
 			return err;
@@ -26301,6 +26308,11 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; ++i)
 		compute_insn_live_regs(env, &insns[i], &state[i]);
 
+	/* Forward pass: resolve stack access through FP-derived pointers */
+	err = bpf_compute_subprog_arg_access(env);
+	if (err)
+		goto out;
+
 	changed = true;
 	while (changed) {
 		changed = false;

-- 
2.53.0
