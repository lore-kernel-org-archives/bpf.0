Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252330E831
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123067; cv=none; b=iL2J6QhTwJ4ffmFoZElReTzaH4B3yiJ8nqsnBKLlBTUQWpJfv2GQx5R6EBkAym8TINY2viX8gLrkTGWe7Y6TJKI5V8JN55Gptqo+dw3kRPm04I0nH1y42vWyYDQpSp7wQeuYx+SIaVi8d8T7T2Kas5cPsDO28WexJJXbmmEmamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123067; c=relaxed/simple;
	bh=T4w52N1oKnlqRxDWMdTsJvOZwtxtk/1a9qr+iQMOFCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AspZajZ5FArsvJC55TxBvCugrjlaQkhOfEuRVIroXDHNrZrhpKA6V1epghZE3ot0bgzAbwu5q+RDK5jPngOhmAWQa2AQjCUFYyXOnSvDDhFue02UplSAhK6qDrM+kE3YuE91iiV/lFCDCwvvcDH35ObRKI+QZmUlENEGD0LKzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO8SeEQi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO8SeEQi"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so4520749a91.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776123065; x=1776727865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srjBZ8tIjAgBrrcHKFSwWNynqgJLIbOZQsjbF1QxNVI=;
        b=oO8SeEQixzaX1qw9DDhjQNbV9/HMtXtQ9wPsitMVogOwGXSUBIbt7QFgQWi5a4euD7
         /1Tfn7vShRHatmL1E3syPAqg/vJ4ZzfWiMhzf5saomzoKzBnV7oWvXvOF5tSmj6YaW4A
         41N6wxb8fDfsqSBxyLTn5EQ+lY5GY1wZ14mVgGQJCOa2CMcfnSPaGbRU5oD33sKLXVL/
         RawJdaSrd0tj/HNDHQHsEpU6fkAIHpyiyvmlA8Eh0YQQJG6N9jzA5Ba81le8BykF9XeQ
         ou7ng1jsgftgmtMPDCDwo8J1UjHwiI+4fAWIHjs8fq2iwIWjjJu+vLD9O7vbpDlZykLj
         tnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776123065; x=1776727865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=srjBZ8tIjAgBrrcHKFSwWNynqgJLIbOZQsjbF1QxNVI=;
        b=cAHNqHjckOH2eGrgLyVNEQY+O6h4/T17SMe3X9T8hAGx+WixE1EI3/7pNAT93vUWUz
         R0yBwrqFPtBOKwXb3ycQhs8WrgwCBMVeJQSM8HRO7ArTnX0f9l3RN237IpxUkkqCjinP
         qzknPZWfWOP8qgc98ovSR0CXBf42CwUGa2L5x6IlMegn6EP6CRqCFMztCSbiqM8x+yFq
         GiK40/6CSyUyKYDZNGq8wGdr088wK65VxDKS+IBME2wwc+1bgeXk+2Mbw09T8wdLAPX8
         ETLCdtcyFR8gZUcG5Q7rDFKV4E09mDV4Sc2TxJtBx4H1w3TjxSbM7SFF5j7ivreCDbAt
         CrXw==
X-Gm-Message-State: AOJu0Yxbjgs88VFXiGk8t86zdyZVJBvELtKSCbdp27amXfNn4uKukoHL
	0q62TCnE/ZJpcr5wBOfdJ+5wP6+TCiQ5UKeaDOqsBUCjeI+3x63WMUuJgsgZ0A==
X-Gm-Gg: AeBDiesYxYMhGtKSoGH5qXYUjrQ8hxm5Gy+LKsEYB+OoBwa5XmYemuj9VVAOscVn0bC
	Kk4KxYAKy3q/4SXkKpVFNtkN+zcLRDT3sX4GNPBEf201VSlv5CCtzwQu5c9jjlfz+6O9CmWgv1S
	W3Q1/uOZTbW1TBK9x/BF0/kknnc1ROUeE5vUwvn83lvGQHaWDR6AAZsYxy6Tb95ah7Ys+2bmGrU
	YNovKiIr4ZrIYPM/bN61c9PxDeJPNwtER085ra/KAXAcfOBQNCB5LsTElEbay0Y4BMeZTNP+5CZ
	vAw10ph6X7hpCIhbTB91W6NtWpF4ag7LZ0SMwjhSAh+TJnOUC7G8aDLn4nengzVUe04JS36iwiI
	T/40dyd1mXormOoKg6w9SljhI7g+hdTDTqrAOIM0ddUg8Be1tLrRqUt3IIe6BU2tscZ/WMqc2d8
	jY8WArk8ykdea+XDn0kdID3KQ7NpmX4d1EHGe7UKVpSvvfwOeU0Ox2XlHxkusIFRd0pB8=
X-Received: by 2002:a17:90b:3ccd:b0:35b:9ab6:1d4b with SMTP id 98e67ed59e1d1-35e42846246mr15483304a91.20.1776123065089;
        Mon, 13 Apr 2026 16:31:05 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc2bc5575sm584349a91.3.2026.04.13.16.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:31:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 1/2] bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX
Date: Mon, 13 Apr 2026 16:30:52 -0700
Message-ID: <20260413-stacklive-fixes-v2-1-398e126e5cf3@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-stacklive-fixes-v2-0-398e126e5cf3@gmail.com>
References: <20260413-stacklive-fixes-v2-0-398e126e5cf3@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

BPF_STX through ARG_IMPRECISE dst should be recognized as a local
spill and join at_stack with the written value. For example,
consider the following situation:

   // r1 = ARG_IMPRECISE{mask=BIT(0)|BIT(1)}
   *(u64 *)(r1 + 0) = r8

Here the analysis should produce an equivalent of

  at_stack[*] = join(old, r8)

BPF_ST through multi-offset or imprecise dst should join at_stack with
none instead of overwriting the slots. For example, consider the
following situation:

   // r1 = ARG_IMPRECISE{mask=BIT(0)|BIT(1)}
   *(u64 *)(r1 + 0) = 0

Here the analysis should produce an equivalent of

  at_stack[*r1] = join(old, none).

Move the definition of the clear_overlapping_stack_slots() in order to
have __arg_track_join() visible. Remove the OFF_IMPRECISE constant to
avoid having two ways to express imprecise offset.
Only 'offset-imprecise {frame=N, cnt=0}' remains.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 114 +++++++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1fb4c511db5a..332e6e003f27 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -574,7 +574,7 @@ static int print_instances(struct bpf_verifier_env *env)
  *
  *   precise {frame=N, off=V}      -- known absolute frame index and byte offset
  *        |
- *   offset-imprecise {frame=N, off=OFF_IMPRECISE}
+ *   offset-imprecise {frame=N, cnt=0}
  *        |                        -- known frame identity, unknown offset
  *   fully-imprecise {frame=ARG_IMPRECISE, mask=bitmask}
  *                                 -- unknown frame identity; .mask is a
@@ -607,8 +607,6 @@ enum arg_track_state {
 	ARG_IMPRECISE	= -3,	/* lost identity; .mask is arg bitmask */
 };
 
-#define OFF_IMPRECISE	S16_MIN	/* arg identity known but offset unknown */
-
 /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes each) */
 #define MAX_ARG_SPILL_SLOTS 64
 
@@ -622,28 +620,6 @@ static bool arg_is_fp(const struct arg_track *at)
 	return at->frame >= 0 || at->frame == ARG_IMPRECISE;
 }
 
-/*
- * Clear all tracked callee stack slots overlapping the byte range
- * [off, off+sz-1] where off is a negative FP-relative offset.
- */
-static void clear_overlapping_stack_slots(struct arg_track *at_stack, s16 off, u32 sz)
-{
-	struct arg_track none = { .frame = ARG_NONE };
-
-	if (off == OFF_IMPRECISE) {
-		for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++)
-			at_stack[i] = none;
-		return;
-	}
-	for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++) {
-		int slot_start = -((i + 1) * 8);
-		int slot_end = slot_start + 8;
-
-		if (slot_start < off + (int)sz && slot_end > off)
-			at_stack[i] = none;
-	}
-}
-
 static void verbose_arg_track(struct bpf_verifier_env *env, struct arg_track *at)
 {
 	int i;
@@ -863,16 +839,13 @@ static void arg_track_alu64(struct arg_track *dst, const struct arg_track *src)
 	*dst = arg_join_imprecise(*dst, *src);
 }
 
-static s16 arg_add(s16 off, s64 delta)
+static bool arg_add(s16 off, s64 delta, s16 *out)
 {
-	s64 res;
-
-	if (off == OFF_IMPRECISE)
-		return OFF_IMPRECISE;
-	res = (s64)off + delta;
-	if (res < S16_MIN + 1 || res > S16_MAX)
-		return OFF_IMPRECISE;
-	return res;
+	s16 d = delta;
+
+	if (d != delta)
+		return true;
+	return check_add_overflow(off, d, out);
 }
 
 static void arg_padd(struct arg_track *at, s64 delta)
@@ -882,9 +855,9 @@ static void arg_padd(struct arg_track *at, s64 delta)
 	if (at->off_cnt == 0)
 		return;
 	for (i = 0; i < at->off_cnt; i++) {
-		s16 new_off = arg_add(at->off[i], delta);
+		s16 new_off;
 
-		if (new_off == OFF_IMPRECISE) {
+		if (arg_add(at->off[i], delta, &new_off)) {
 			at->off_cnt = 0;
 			return;
 		}
@@ -899,8 +872,6 @@ static void arg_padd(struct arg_track *at, s64 delta)
  */
 static int fp_off_to_slot(s16 off)
 {
-	if (off == OFF_IMPRECISE)
-		return -1;
 	if (off >= 0 || off < -(int)(MAX_ARG_SPILL_SLOTS * 8))
 		return -1;
 	if (off % 8)
@@ -930,9 +901,11 @@ static struct arg_track fill_from_stack(struct bpf_insn *insn,
 		return imp;
 
 	for (i = 0; i < cnt; i++) {
-		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
-		int slot = fp_off_to_slot(fp_off);
+		s16 fp_off, slot;
 
+		if (arg_add(at_out[reg].off[i], insn->off, &fp_off))
+			return imp;
+		slot = fp_off_to_slot(fp_off);
 		if (slot < 0)
 			return imp;
 		result = __arg_track_join(result, at_stack_out[slot]);
@@ -968,9 +941,12 @@ static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
 		return;
 	}
 	for (i = 0; i < cnt; i++) {
-		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
-		int slot = fp_off_to_slot(fp_off);
+		s16 fp_off;
+		int slot;
 
+		if (arg_add(at_out[reg].off[i], insn->off, &fp_off))
+			continue;
+		slot = fp_off_to_slot(fp_off);
 		if (slot < 0)
 			continue;
 		if (cnt == 1)
@@ -980,6 +956,32 @@ static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
 	}
 }
 
+/*
+ * Clear all tracked callee stack slots overlapping the byte range
+ * [off, off+sz-1] where off is a negative FP-relative offset.
+ */
+static void clear_overlapping_stack_slots(struct arg_track *at_stack, s16 off, u32 sz, int cnt)
+{
+	struct arg_track none = { .frame = ARG_NONE };
+
+	if (cnt == 0) {
+		for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++)
+			at_stack[i] = __arg_track_join(at_stack[i], none);
+		return;
+	}
+	for (int i = 0; i < MAX_ARG_SPILL_SLOTS; i++) {
+		int slot_start = -((i + 1) * 8);
+		int slot_end = slot_start + 8;
+
+		if (slot_start < off + (int)sz && slot_end > off) {
+			if (cnt == 1)
+				at_stack[i] = none;
+			else
+				at_stack[i] = __arg_track_join(at_stack[i], none);
+		}
+	}
+}
+
 /*
  * Clear stack slots overlapping all possible FP offsets in @reg.
  */
@@ -990,18 +992,22 @@ static void clear_stack_for_all_offs(struct bpf_insn *insn,
 	int cnt, i;
 
 	if (reg == BPF_REG_FP) {
-		clear_overlapping_stack_slots(at_stack_out, insn->off, sz);
+		clear_overlapping_stack_slots(at_stack_out, insn->off, sz, 1);
 		return;
 	}
 	cnt = at_out[reg].off_cnt;
 	if (cnt == 0) {
-		clear_overlapping_stack_slots(at_stack_out, OFF_IMPRECISE, sz);
+		clear_overlapping_stack_slots(at_stack_out, 0, sz, cnt);
 		return;
 	}
 	for (i = 0; i < cnt; i++) {
-		s16 fp_off = arg_add(at_out[reg].off[i], insn->off);
+		s16 fp_off;
 
-		clear_overlapping_stack_slots(at_stack_out, fp_off, sz);
+		if (arg_add(at_out[reg].off[i], insn->off, &fp_off)) {
+			clear_overlapping_stack_slots(at_stack_out, 0, sz, 0);
+			break;
+		}
+		clear_overlapping_stack_slots(at_stack_out, fp_off, sz, cnt);
 	}
 }
 
@@ -1042,6 +1048,12 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
 		verbose(env, "\n");
 }
 
+static bool can_be_local_fp(int depth, int regno, struct arg_track *at)
+{
+	return regno == BPF_REG_FP || at->frame == depth ||
+	       (at->frame == ARG_IMPRECISE && (at->mask & BIT(depth)));
+}
+
 /*
  * Pure dataflow transfer function for arg_track state.
  * Updates at_out[] based on how the instruction modifies registers.
@@ -1111,8 +1123,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			at_out[r] = none;
 	} else if (class == BPF_LDX) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool src_is_local_fp = insn->src_reg == BPF_REG_FP || src->frame == depth ||
-				       (src->frame == ARG_IMPRECISE && (src->mask & BIT(depth)));
+		bool src_is_local_fp = can_be_local_fp(depth, insn->src_reg, src);
 
 		/*
 		 * Reload from callee stack: if src is current-frame FP-derived
@@ -1147,7 +1158,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		bool dst_is_local_fp;
 
 		/* Track spills to current-frame FP-derived callee stack */
-		dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+		dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
 		if (dst_is_local_fp && BPF_MODE(insn->code) == BPF_MEM)
 			spill_to_stack(insn, at_out, insn->dst_reg,
 				       at_stack_out, src, sz);
@@ -1166,7 +1177,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	} else if (class == BPF_ST && BPF_MODE(insn->code) == BPF_MEM) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+		bool dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
 
 		/* BPF_ST to FP-derived dst: clear overlapping stack slots */
 		if (dst_is_local_fp)
@@ -1316,8 +1327,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 		resolved.off_cnt = ptr->off_cnt;
 		resolved.frame = ptr->frame;
 		for (oi = 0; oi < ptr->off_cnt; oi++) {
-			resolved.off[oi] = arg_add(ptr->off[oi], insn->off);
-			if (resolved.off[oi] == OFF_IMPRECISE) {
+			if (arg_add(ptr->off[oi], insn->off, &resolved.off[oi])) {
 				resolved.off_cnt = 0;
 				break;
 			}

-- 
2.53.0
