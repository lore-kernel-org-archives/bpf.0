Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EA4C2278
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542914; cv=none; b=HqVG/DIF2W66eKw9vE6ENBZ4yBSEmuhLdowtZofa9wZyk1BbNOiqUurYRbKBAnqwVC8IaXDdRsoyuLhxBySLBlNclPRtBPx0Ix6EDjv0oOhrXtWss3bRkraiYCHdIxKmktwPJRnYN3ffc+rUog5ESMZf8mm+XiJjl3wbV/JI4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542914; c=relaxed/simple;
	bh=7I7PY6FLb+WcxvFgzzrhGEKBrVznS13bxg1q65qMQd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meEWTH++eHzT0kGwkBmYpvZUAK6rzE5EOelOwiVAYMRkegH+JpXfj1F/26k66rsgO7Fn7BK2QSAERQqbmuslGbJzNt8kkEYIcsYQZXP5S0EqTjoMR5i7QFkKVcowPjOeqNof85X0IzlkwSFSOpoi2VCMRgSI6Ge3Hu3NSVnnerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp46pYGF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp46pYGF"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1846668a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542901; x=1792147701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rYsTaK38qdgRuq3B8+VLJ9OW5NbfT905Ovm6tmYc1Fs=;
        b=Fp46pYGFx91tNWD1iAzND/fGpTwDTPKG0fGJ1R1aGTNyJTkUAROoKj7mlmXKY+6KuN
         6jnIKRh+9Az908HF3HFmjHLkucRkODypE2YPkvEFL5ayY7Z0DyU6IvVBJia6IBL21rgn
         XUAKQROqIYNMKHD+ATm98Evp+tae/SEKLHnjj1BMmmRuVmIcoY7oiCmesdBQj+fqAm5P
         wWQKJJkBRbnZLUylgtZwy0efE7nlA2tssSbJZngwcwD8Wk2qzybAHgBJ7+D3CKWvNaIm
         80Q0ZqfXoESqqF63Uzztkw/IK+EhDWdIVh5VMGT1n9FtWOQFZ+910iE6sLxszAtNGMtE
         Esmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542901; x=1792147701;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rYsTaK38qdgRuq3B8+VLJ9OW5NbfT905Ovm6tmYc1Fs=;
        b=fuPNbXEr8ekMIpdMHazD1P/KiUI6T2ytECMFXPIC+ufuxGLMgaiC6QsNJuPSkzsPOx
         36bxntw4Xb8uWpHJ1DvQlbE5O3NfV0N+pssUJxcZ6CQhibAtzspAwm2ecpZFQRSf6m7V
         DGP576psj0wzjCzgIsGQRVQtPtZ2GIK51t14CnHHAdDir1WQUYU0hC2SmgYExA6cgTR2
         m+vViUnftAsiLfQ10qt7FtI/Jxnaj10VD4hAn+mpDiUi1ymN/9l2aWZ+ES6Eso0JsCEi
         JWeVdoUrHdWGri6NYKRLF+D03cG9yqDntswRjkzw4qV8Nm+d+YcT1dsDI5sJigd5BnW6
         o0WQ==
X-Gm-Message-State: AFq9FYLHhdDtcQ5iSrMejRS1Ncn0zLlK+rbej6XPWsQC4yj0aI1V5ekd
	SXgUUfpwEbu4ORb8t9tnSdbiNjpGj265KwKnnOzFn0ZAGQOxh9TRo7M3npQh0hOD
X-Gm-Gg: AYBFou2KL49SoQsXAY1bmFBvbRBI3gC75jgraG0cg+cveDBDRyzAuzMUt72Ik8TDm3+
	xky7+7igVhHUQ8Ilt0/tjAigyt/3gb4h29J3Iq6ykwRoDnxuhbplNrGSzxfmQgldVTIdr4r1889
	yXX8PochQcYHY0qiLAbTFEBvm/mIp09WbRf/1vxBZd/FMRcCHjG5utxFKgD5UTjwaNbKx74y0H0
	PLEiQT6eUWE47RLx5jmtQJWuBQ77bICR3aqJS1+eetcIAWMFhFTyoIBHlYiWp3baLIEC+QbZH+W
	JtjpoXUV9cx3rBXNTIlkMRcjb2Vh3uD6Hh56KRQnReE6D1LXEBjd6FVS9HO4GJiiLmg27iy3FWK
	d+oT9UwxoS0CozNhx+Q1JYtKAVqntIG4uY6jL12TzsfitOtF4nrPu8ObBSJ7dZWDvm+Dray8mSj
	C6DhHx4ziyP3PPcOArnrhnJd98/HJB67u8PplFp3lq4cXqHj22vIe8Z1Ga+mt99p44Mrm8Ddng+
	8nnAxt6Dq5Uivo=
X-Received: by 2002:a17:90b:1d4f:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3ab3a79d9f8mr1409545a91.45.1791542900540;
        Fri, 09 Oct 2026 03:48:20 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 04/51] bpf: track may_write flags in liveness
Date: Fri,  9 Oct 2026 03:47:22 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-4-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Track stack slots that instructions may modify, in order to account
for such writes when constructing SCEV expressions.

Consume the may_write flag in arg_access_info separately from reads and
definite writes. Include partially covered slots and all candidate
offsets; imprecise writes mark whole candidate frames. Possible writes
do not kill liveness.

Merge analyzed instances as:

  may_write(dst)  |= may_write(src)
  must_write(dst) &= must_write(src)

For each ancestor frame f, summarize callee writes at the callsite:

  may_write(callsite, f) |= OR_{i in callee} may_write(i, f)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c                              | 207 ++++++++++++++-------
 .../selftests/bpf/progs/verifier_live_stack.c      |  38 ++--
 2 files changed, 168 insertions(+), 77 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index d4089a488784..e18d5d86c301 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -23,6 +23,7 @@ enum {
 	FM_MAY_READ,	/* stack slots that may be read by this instruction */
 	FM_MUST_WRITE,	/* stack slots written by this instruction */
 	FM_LIVE_BEFORE,	/* stack slots that may be read by this insn and its successors */
+	FM_MAY_WRITE,	/* stack slots that may be written by this instruction */
 	FM_MASK_CNT,
 };
 
@@ -262,6 +263,12 @@ static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_
 	return mark_stack_range(instance, frame, insn_idx, FM_MUST_WRITE, lo, hi);
 }
 
+static int mark_stack_may_write(struct func_instance *instance, u32 frame, u32 insn_idx,
+				s32 lo, s32 hi)
+{
+	return mark_stack_range(instance, frame, insn_idx, FM_MAY_WRITE, lo, hi);
+}
+
 /*
  * Mark every half-slot of @frame as possibly read by @insn_idx. This widens
  * the masks to the program's stack budget: a full read recorded at a narrower
@@ -277,9 +284,16 @@ static int mark_stack_read_all(struct bpf_verifier_env *env, struct func_instanc
 			       env->stack_limit / BPF_HALF_REG_SIZE - 1);
 }
 
-/* Accumulate @src, a mask @src_words wide, into may_read of @frame at @insn_idx */
-static int mark_stack_read_mask(struct func_instance *instance, u32 frame, u32 insn_idx,
-				const unsigned long *src, u32 src_words)
+static int mark_stack_may_write_all(struct bpf_verifier_env *env, struct func_instance *instance,
+				    u32 frame, u32 insn_idx)
+{
+	return mark_stack_may_write(instance, frame, insn_idx, 0,
+				    env->stack_limit / BPF_HALF_REG_SIZE - 1);
+}
+
+/* Accumulate @src, a mask @src_words wide, into @kind mask of @frame at @insn_idx */
+static int mark_stack_mask(struct func_instance *instance, u32 frame, u32 insn_idx, u32 kind,
+			   const unsigned long *src, u32 src_words)
 {
 	u32 nbits = src_words * BITS_PER_LONG;
 	struct frame_masks *fm;
@@ -292,7 +306,7 @@ static int mark_stack_read_mask(struct func_instance *instance, u32 frame, u32 i
 	fm = widen_frame_masks(instance, frame, BITS_TO_LONGS(last + 1));
 	if (!fm)
 		return -ENOMEM;
-	dst = rel_mask(fm, relative_idx(instance, insn_idx), FM_MAY_READ);
+	dst = rel_mask(fm, relative_idx(instance, insn_idx), kind);
 	/* @src has no bits set past @last, hence none past @fm->words either */
 	src_words = min(src_words, fm->words);
 	for (w = 0; w < src_words; w++)
@@ -300,6 +314,12 @@ static int mark_stack_read_mask(struct func_instance *instance, u32 frame, u32 i
 	return 0;
 }
 
+static int mark_stack_read_mask(struct func_instance *instance, u32 frame, u32 insn_idx,
+				const unsigned long *src, u32 src_words)
+{
+	return mark_stack_mask(instance, frame, insn_idx, FM_MAY_READ, src, src_words);
+}
+
 int bpf_jmp_offset(struct bpf_insn *insn)
 {
 	u8 code = insn->code;
@@ -624,16 +644,41 @@ static char *fmt_spis_mask(struct bpf_verifier_env *env, int frame, bool first,
 	return env->tmp_str_buf;
 }
 
+/* Print mask @kind of the instruction at relative index @i for every frame, if any bit is set. */
+static bool print_mask(struct bpf_verifier_env *env, struct func_instance *instance, int i,
+		       const char *name, u32 kind)
+{
+	struct frame_masks *fm;
+	bool printed = false;
+	unsigned long *mask;
+	int frame;
+	u64 pos;
+
+	pos = env->log.end_pos;
+	verbose(env, "%s", name);
+	for (frame = instance->depth; frame >= 0; --frame) {
+		fm = instance->frames[frame];
+		if (!fm)
+			continue;
+		mask = rel_mask(fm, i, kind);
+		if (bitmap_empty(mask, frame_mask_bits(fm)))
+			continue;
+		verbose(env, "%s", fmt_spis_mask(env, frame, !printed, mask, fm->words));
+		printed = true;
+	}
+	if (!printed)
+		bpf_vlog_reset(&env->log, pos);
+	return printed;
+}
+
 static void print_instance(struct bpf_verifier_env *env, struct func_instance *instance)
 {
 	int start = env->subprog_info[instance->subprog].start;
 	struct bpf_insn *insns = env->prog->insnsi;
-	struct frame_masks *fm;
-	unsigned long *mask;
 	int len = instance->insn_cnt;
-	int insn_idx, frame, i;
-	bool has_use, has_def;
 	u64 pos, insn_pos;
+	int insn_idx, i;
+	bool printed;
 
 	if (!(env->log.level & BPF_LOG_LEVEL2))
 		return;
@@ -642,41 +687,17 @@ static void print_instance(struct bpf_verifier_env *env, struct func_instance *i
 	verbose(env, "%s:\n", fmt_instance(env, instance));
 	for (i = 0; i < len; i++) {
 		insn_idx = start + i;
-		has_use = false;
-		has_def = false;
 		pos = env->log.end_pos;
 		verbose(env, "%3d: ", insn_idx);
 		bpf_verbose_insn(env, &insns[insn_idx]);
 		insn_pos = env->log.end_pos;
 		verbose(env, "%*c;", bpf_vlog_alignment(insn_pos - pos), ' ');
-		pos = env->log.end_pos;
-		verbose(env, " use: ");
-		for (frame = instance->depth; frame >= 0; --frame) {
-			fm = instance->frames[frame];
-			if (!fm)
-				continue;
-			mask = rel_mask(fm, i, FM_MAY_READ);
-			if (bitmap_empty(mask, frame_mask_bits(fm)))
-				continue;
-			verbose(env, "%s", fmt_spis_mask(env, frame, !has_use, mask, fm->words));
-			has_use = true;
-		}
-		if (!has_use)
-			bpf_vlog_reset(&env->log, pos);
-		pos = env->log.end_pos;
-		verbose(env, " def: ");
-		for (frame = instance->depth; frame >= 0; --frame) {
-			fm = instance->frames[frame];
-			if (!fm)
-				continue;
-			mask = rel_mask(fm, i, FM_MUST_WRITE);
-			if (bitmap_empty(mask, frame_mask_bits(fm)))
-				continue;
-			verbose(env, "%s", fmt_spis_mask(env, frame, !has_def, mask, fm->words));
-			has_def = true;
-		}
-		if (!has_def)
-			bpf_vlog_reset(&env->log, has_use ? pos : insn_pos);
+		printed = false;
+		printed |= print_mask(env, instance, i, " use: ", FM_MAY_READ);
+		printed |= print_mask(env, instance, i, " def: ", FM_MUST_WRITE);
+		printed |= print_mask(env, instance, i, " may_def: ", FM_MAY_WRITE);
+		if (!printed)
+			bpf_vlog_reset(&env->log, insn_pos);
 		verbose(env, "\n");
 		if (bpf_is_ldimm64(&insns[insn_idx]))
 			i++;
@@ -1437,12 +1458,14 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 }
 
 /*
- * Record reads for every touched half-slot. A definite
+ * Record possible reads and writes for every touched half-slot. A definite
  * write requires full coverage, a known size, and a single possible offset.
  */
-static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
-				   struct arg_access_info info, u32 frame, u32 insn_idx)
+static int record_stack_access_off(struct func_instance *instance, const struct arg_track *arg,
+				   s64 off_idx, struct arg_access_info info,
+				   u32 frame, u32 insn_idx)
 {
+	s64 fp_off = arg->off[off_idx];
 	s32 slot_hi, slot_lo;
 	int err;
 
@@ -1454,20 +1477,25 @@ static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
 		 */
 		return 0;
 
-	if (info.may_read && info.size == U32_MAX) {
-		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 */
-		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
-		return mark_stack_read(instance, frame, insn_idx, 0, slot_hi);
-	}
+	/*
+	 * Read and may_write marks include partially covered slots.
+	 * An unknown access size may reach from fp_off to the frame top.
+	 */
+	slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
+	slot_lo = info.size == U32_MAX
+		  ? 0
+		  : max_t(s32, (-fp_off - info.size) / STACK_SLOT_SZ, 0);
 	if (info.may_read) {
-		/* Mark any touched slot as use */
-		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
-		slot_lo = max_t(s32, (-fp_off - info.size) / STACK_SLOT_SZ, 0);
 		err = mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi);
 		if (err)
 			return err;
 	}
-	if (info.must_write && info.size != U32_MAX) {
+	if (info.may_write) {
+		err = mark_stack_may_write(instance, frame, insn_idx, slot_lo, slot_hi);
+		if (err)
+			return err;
+	}
+	if (info.must_write && info.size != U32_MAX && arg->off_cnt == 1) {
 		/* Mark only fully covered slots as def */
 		slot_hi = (-fp_off) / STACK_SLOT_SZ - 1;
 		slot_lo = max_t(s32, (-fp_off - info.size + STACK_SLOT_SZ - 1) / STACK_SLOT_SZ, 0);
@@ -1492,26 +1520,24 @@ static int record_stack_access(struct bpf_verifier_env *env,
 			if (err)
 				return err;
 		}
+		if (info.may_write) {
+			err = mark_stack_may_write_all(env, instance, frame, insn_idx);
+			if (err)
+				return err;
+		}
 		return 0;
 	}
-	if (info.size != U32_MAX && info.must_write && arg->off_cnt != 1)
-		/* multi-offset write cannot set stack_def */
-		return 0;
-
 	for (i = 0; i < arg->off_cnt; i++) {
-		err = record_stack_access_off(instance, arg->off[i], info, frame, insn_idx);
+		err = record_stack_access_off(instance, arg, i, info, frame, insn_idx);
 		if (err)
 			return err;
 	}
 	return 0;
 }
 
-/*
- * When a pointer is ARG_IMPRECISE, conservatively mark every frame in
- * the bitmask as fully used.
- */
+/* Record possible effects on every candidate frame of an imprecise pointer. */
 static int record_imprecise(struct bpf_verifier_env *env, struct func_instance *instance,
-			    u32 mask, u32 insn_idx)
+			    struct arg_access_info info, u32 mask, u32 insn_idx)
 {
 	int depth = instance->depth;
 	int f, err;
@@ -1520,9 +1546,16 @@ static int record_imprecise(struct bpf_verifier_env *env, struct func_instance *
 		if (!(mask & 1))
 			continue;
 		if (f <= depth) {
-			err = mark_stack_read_all(env, instance, f, insn_idx);
-			if (err)
-				return err;
+			if (info.may_read) {
+				err = mark_stack_read_all(env, instance, f, insn_idx);
+				if (err)
+					return err;
+			}
+			if (info.may_write) {
+				err = mark_stack_may_write_all(env, instance, f, insn_idx);
+				if (err)
+					return err;
+			}
 		}
 	}
 	return 0;
@@ -1599,7 +1632,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	if (ptr->frame >= 0 && ptr->frame <= depth)
 		return record_stack_access(env, instance, ptr, info, ptr->frame, insn_idx);
 	if (ptr->frame == ARG_IMPRECISE)
-		return record_imprecise(env, instance, ptr->mask, insn_idx);
+		return record_imprecise(env, instance, info, ptr->mask, insn_idx);
 	/* ARG_NONE: not derived from any frame pointer, skip */
 	return 0;
 }
@@ -1627,6 +1660,9 @@ static int record_arg_access(struct bpf_verifier_env *env,
 			err = mark_stack_read_all(env, instance, f, insn_idx);
 			if (err)
 				return err;
+			err = mark_stack_may_write_all(env, instance, f, insn_idx);
+			if (err)
+				return err;
 		}
 		return 0;
 	}
@@ -1636,7 +1672,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 	if (frame >= 0 && frame <= depth)
 		err = record_stack_access(env, instance, at, info, frame, insn_idx);
 	else if (frame == ARG_IMPRECISE)
-		err = record_imprecise(env, instance, at->mask, insn_idx);
+		err = record_imprecise(env, instance, info, at->mask, insn_idx);
 	return err;
 }
 
@@ -1996,6 +2032,7 @@ static bool has_fp_args(struct arg_track *args)
 /*
  * Merge a freshly analyzed instance into the original.
  * may_read: union (any pass might read the slot).
+ * may_write: union (slots written on ANY pass).
  * must_write: intersection (only slots written on ALL passes are guaranteed).
  * live_before is recomputed by a subsequent update_instance() on @dst.
  *
@@ -2034,18 +2071,50 @@ static int merge_instances(struct func_instance *dst, struct func_instance *src)
 		for (i = 0; i < dst->insn_cnt; i++) {
 			unsigned long *dst_read = rel_mask(d, i, FM_MAY_READ);
 			unsigned long *dst_write = rel_mask(d, i, FM_MUST_WRITE);
+			unsigned long *dst_may_write = rel_mask(d, i, FM_MAY_WRITE);
 			unsigned long *src_read = rel_mask(s, i, FM_MAY_READ);
 			unsigned long *src_write = rel_mask(s, i, FM_MUST_WRITE);
+			unsigned long *src_may_write = rel_mask(s, i, FM_MAY_WRITE);
 
 			for (w = 0; w < d->words; w++) {
 				dst_read[w] |= w < s->words ? src_read[w] : 0;
 				dst_write[w] &= w < s->words ? src_write[w] : 0;
+				dst_may_write[w] |= w < s->words ? src_may_write[w] : 0;
 			}
 		}
 	}
 	return 0;
 }
 
+/*
+ * Fold a fully analyzed callee instance writes to upper frames as
+ * may_write marks at callsite in caller's frames.
+ */
+static int merge_may_write(struct func_instance *caller, struct func_instance *callee)
+{
+	DECLARE_BITMAP(acc, FRAME_HALF_SPIS);
+	u32 call_idx = callee->callsite;
+	struct frame_masks *fm;
+	u32 f, i, nbits;
+	int err;
+
+	for (f = 0; f < callee->depth; f++) {
+		fm = callee->frames[f];
+		if (!fm)
+			continue;
+		nbits = frame_mask_bits(fm);
+		bitmap_zero(acc, nbits);
+		for (i = 0; i < callee->insn_cnt; i++)
+			bitmap_or(acc, acc, rel_mask(fm, i, FM_MAY_WRITE), nbits);
+		if (bitmap_empty(acc, nbits))
+			continue;
+		err = mark_stack_mask(caller, f, call_idx, FM_MAY_WRITE, acc, fm->words);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static struct func_instance *fresh_instance(struct func_instance *src)
 {
 	struct func_instance *f;
@@ -2161,6 +2230,9 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 					err = mark_stack_read_all(env, instance, f, idx);
 					if (err)
 						goto out_free;
+					err = mark_stack_may_write_all(env, instance, f, idx);
+					if (err)
+						goto out_free;
 				}
 				continue;
 			}
@@ -2213,6 +2285,11 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 					goto out_free;
 			}
 		}
+
+		/* Summarize callee's writes to ancestor frames onto the callsite */
+		err = merge_may_write(instance, callee_instance);
+		if (err)
+			goto out_free;
 	}
 
 	if (prev_instance) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 16b2b1e57534..3ba21430bb75 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -61,7 +61,11 @@ __naked void read_write_join(void)
 SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#0 must_write_not_same_slot (d0,cs0):")
-__msg("6: (7b) *(u64 *)(r2 +0) = r0{{$}}")
+/*
+ * 'r2 += r1' adds a scalar, so the offset is lost (off_cnt == 0): no def,
+ * but the write conservatively marks the whole frame as may_def.
+ */
+__msg("6: (7b) *(u64 *)(r2 +0) = r0         ; may_def: fp0-8..-{{(512|2048)}}")
 __msg("Live regs before insn:")
 __naked void must_write_not_same_slot(void)
 {
@@ -106,9 +110,9 @@ __naked void must_write_not_same_type(void)
 
 SEC("socket")
 __log_level(2)
-/* Callee writes fp[0]-8: stack_use at call site has slots 0,1 live */
+/* Callee writes fp[0]-8: the def is summarized as may_def at the call site */
 __msg("stack use/def subprog#0 caller_stack_write (d0,cs0):")
-__msg("2: (85) call pc+1{{$}}")
+__msg("2: (85) call pc+1                    ; may_def: fp0-8")
 __msg("stack use/def subprog#1 write_first_param (d1,cs2):")
 __msg("4: (7a) *(u64 *)(r1 +0) = 7          ; def: fp0-8")
 __naked void caller_stack_write(void)
@@ -804,9 +808,9 @@ void __kfunc_btf_root(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24{{$}}")
-__msg(" 9: (85) call bpf_iter_num_next{{.*}}         ; use: fp0-24{{$}}")
-__msg("14: (85) call bpf_iter_num_destroy{{.*}}      ; use: fp0-24{{$}}")
+__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 may_def: fp0-24{{$}}")
+__msg(" 9: (85) call bpf_iter_num_next{{.*}}         ; use: fp0-24 may_def: fp0-24{{$}}")
+__msg("14: (85) call bpf_iter_num_destroy{{.*}}      ; use: fp0-24 may_def: fp0-24{{$}}")
 __naked void kfunc_iter_stack_liveness(void)
 {
 	asm volatile (
@@ -1008,7 +1012,8 @@ __naked void four_byte_read_upper_half(void)
 SEC("socket")
 __log_level(2)
 __msg("0: (7a) *(u64 *)(r10 -8) = 0         ; def: fp0-8")
-__msg("1: (6a) *(u16 *)(r10 -4) = 0{{$}}")
+/* 2-byte write only partially covers the upper half: may_def, but no def. */
+__msg("1: (6a) *(u16 *)(r10 -4) = 0         ; may_def: fp0-4h")
 __msg("2: (61) r0 = *(u32 *)(r10 -4)        ; use: fp0-4h")
 __naked void two_byte_write_no_kill(void)
 {
@@ -1355,9 +1360,12 @@ __naked void fp_spill_loses_precision_kills_liveness(void)
  */
 SEC("socket")
 __log_level(2)
-/* fp-8 live at call (callee conditionally writes → slot not killed) */
+/*
+ * fp-8 live at call: callee conditionally writes it, so the slot is not killed
+ * (no def), but the conditional write surfaces as may_def at the call site.
+ */
 __msg("1: (7b) *(u64 *)(r10 -8) = r1        ; def: fp0-8")
-__msg("4: (85) call pc+2{{$}}")
+__msg("4: (85) call pc+2                    ; may_def: fp0-8")
 __msg("5: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
 __naked void conditional_stx_in_subprog(void)
 {
@@ -2386,7 +2394,12 @@ __msg("subprog#2 write_first_read_second:")
 __msg("17: (7a) *(u64 *)(r1 +0) = 42{{$}}")
 __msg("18: (79) r0 = *(u64 *)(r2 +0) // r1=fp0-8 r2=fp0-16{{$}}")
 __msg("stack use/def subprog#2 write_first_read_second (d2,cs15):")
-__msg("17: (7a) *(u64 *)(r1 +0) = 42{{$}}")
+/*
+ * Shared across two callsites with swapped args (r1 is fp-8 on one pass,
+ * fp-16 on the other): must_write intersects to empty (no def), may_write
+ * unions to both slots.
+ */
+__msg("17: (7a) *(u64 *)(r1 +0) = 42         ; may_def: fp0-8 fp0-16")
 __msg("18: (79) r0 = *(u64 *)(r2 +0)         ; use: fp0-8 fp0-16")
 __naked void shared_instance_must_write_overwrite(void)
 {
@@ -2848,8 +2861,9 @@ static __used __naked void imprecise_dst_spill_join_sub(void)
 SEC("socket")
 __log_level(2)
 __msg("0: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
-__msg("1: (73) *(u8 *)(r10 -1) = r0{{$}}")
-__msg("2: (6b) *(u16 *)(r10 -4) = r0{{$}}")
+/* narrow stores define nothing, but they may write the half-slot they touch */
+__msg("1: (73) *(u8 *)(r10 -1) = r0         ; may_def: fp0-4h")
+__msg("2: (6b) *(u16 *)(r10 -4) = r0        ; may_def: fp0-4h")
 __msg("3: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
 __naked void narrow_store_defines_nothing(void)
 {

-- 
2.53.0
