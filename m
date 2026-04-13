Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4C397E75
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117497; cv=none; b=eLmch6BR/HmkW8B4VbqJ8FPdwJL27tSSEXDa+lWXlsGD+1HgVgHd+Ef2xFS2uXb8LtgVAs0YdAu2iav+u1+BKqJydexMLK3nfduYWj4+1kPzZOY3B1cPM67wQz/ji60SubJKrouyoZAcpyvd3+fdjbkewKKLYmriqy3nv3W5Xwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117497; c=relaxed/simple;
	bh=wYHC7RU1wJ4NMVV+P/lrx826hm/FuRaQbcmrMVK2KyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZ7CKW6nFhV6HXp4gMeUW+9Bzsr3FuzBiDKCri7zQBqPbY4P/JINxFa/XdF/4ETYoGNjFajF62nAx6GZEOh5DVWGlVY1ecrGZ3WjM9NNpqz3A5AlUdDBwdVeSlZn51oO/UK6KD2RzUVT9QiEKkhijFraUimFAI8mtuNZemaVvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDyG0Cti; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDyG0Cti"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2d3a9e149so13796445ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776117496; x=1776722296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgAYPPnnm7Od9pi7Y2v5C0MP3An3S6YKVUsQKTDWopA=;
        b=VDyG0CtiXYxgqv/Owob6fOr/fiIPcH3d/vkI+6c/Fqo3RECiZUu750W4saxKXKsYG2
         DCiwdgDduHUIk5mrYzyGInnlY+7vpvLU5cgbWpz0h2KIkb6K52JhEiS3kbEcUMT9hHxL
         qqIhFTUIl5EOS0eSpmI/ZU2eHlYZS1R3Bgl75NV449N3hh8mru45XaGYrPs9PTe7mWH6
         a3Lme40A1aizcBCYNwkA6ndFgAzFm4ySmfAM3XR4or6C2hFWOHD3Nm2WEAUoISLFMb/E
         FGnN2n/kjKWUqCssVvl8zpznYH5SQRFehf1Os8kWiyJZecyHNIZOnnEVvcma+EHarcCo
         zOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117496; x=1776722296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgAYPPnnm7Od9pi7Y2v5C0MP3An3S6YKVUsQKTDWopA=;
        b=AL3LaSektk3QoIrcvVsYK8hatHEBL5oLsgC7Sl4KPNZWk1ryiW+8Q5N28YpWIEV1pu
         7bQQ3dXW2bQZJ0m3dVEzi+fZzGJ6xYzN/1uX5iD2osIcL/GLaYbqaVAEEgsiwFXq55Qx
         idEe5cm5BIlAZDsELBpAu4Am/aUlSsl9U1HnwmTt6ntNmBTjtYRVIQ+tTY0G+cUwINCS
         eQqE/VYk1MLyewz5MSXNMx8ae344ae5gEbshXRWwjilt/eKP3mlI2ZaEwt4aatICNCcl
         7Ad85mI5xVGwllqjdra6RVqjLpx3uLiw5TSozB0VNj/OmZwxsCHJIf4sxFSmj2kSUljM
         RSww==
X-Gm-Message-State: AOJu0Yzu3rbWJWrorvLsflqFb0swl8T2tK3P+QNIC7nIIxCU7aSBFGZx
	Stqq4DOkzrDxMbun3QSjERGZml3PgFpIohjQRZrg5qJUgtGvRkZNxXFiNZMrvg==
X-Gm-Gg: AeBDieukLY3gyy2fq/j6RT8GyvTpE19lh2g3/98JuNhIZFiyXxZUv7+zDgpHI9r+0bL
	9F3Pb7RUn/osdmzi2bS/1FeJq3M29FlWvWtMAB3mb6Tda3lq6U2cDFmVN32CL+/iLBgEjPr9V0m
	RXzyj1o7zBZyAiQuL7IBDPXGtR2bcWM3lzqO9vbj/mwD/G3vwXMHWk/pVolfb04V6+8nmLLRCFd
	VTWwoiXiOaNZiQZsGuMN9W/Q18YA4CvfNUyBf5c98pKvlOkM5/aohQCmzoSPV+HPE9xFtfBkgQ4
	qxt7axeo1g8IYN/A3R+3niQUctJABo3cE61FAGYjSzA4dBEofFCStcNiab7vJvfsqSsDZksGaqO
	nymJcOYer/wuqC7tUsWKUKwtZOEmH6puFC/e1Qwe3Xq9jylTKhknrVf/YTpk6xBAZO96auAZA27
	12U2gUdRD4oACZ21EdeZu3uuUUWiuvhoPqRTyw6goIgAdFziTQvHM4SYG4TQ3PNf44ruc=
X-Received: by 2002:a17:902:fb04:b0:2b2:5070:79 with SMTP id d9443c01a7336-2b2c73475c2mr123244785ad.18.1776117495655;
        Mon, 13 Apr 2026 14:58:15 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm62421215ad.40.2026.04.13.14.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:58:15 -0700 (PDT)
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
Date: Mon, 13 Apr 2026 14:58:02 -0700
Message-ID: <20260413-stacklive-fixes-v2-1-ff91c4f8d273@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com>
References: <20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com>
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
avoid having two ways to express imprecise offset. Only
'offset-imprecise {frame=N, cnt=0}' remains.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 110 ++++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1fb4c511db5a..23d19147f123 100644
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
@@ -863,16 +839,15 @@ static void arg_track_alu64(struct arg_track *dst, const struct arg_track *src)
 	*dst = arg_join_imprecise(*dst, *src);
 }
 
-static s16 arg_add(s16 off, s64 delta)
+static bool arg_add(s16 off, s64 delta, s16 *out)
 {
 	s64 res;
 
-	if (off == OFF_IMPRECISE)
-		return OFF_IMPRECISE;
 	res = (s64)off + delta;
-	if (res < S16_MIN + 1 || res > S16_MAX)
-		return OFF_IMPRECISE;
-	return res;
+	if (res < S16_MIN || res > S16_MAX)
+		return true;
+	*out = res;
+	return false;
 }
 
 static void arg_padd(struct arg_track *at, s64 delta)
@@ -882,9 +857,9 @@ static void arg_padd(struct arg_track *at, s64 delta)
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
@@ -899,8 +874,6 @@ static void arg_padd(struct arg_track *at, s64 delta)
  */
 static int fp_off_to_slot(s16 off)
 {
-	if (off == OFF_IMPRECISE)
-		return -1;
 	if (off >= 0 || off < -(int)(MAX_ARG_SPILL_SLOTS * 8))
 		return -1;
 	if (off % 8)
@@ -930,9 +903,11 @@ static struct arg_track fill_from_stack(struct bpf_insn *insn,
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
@@ -968,9 +943,12 @@ static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
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
@@ -980,6 +958,32 @@ static void spill_to_stack(struct bpf_insn *insn, struct arg_track *at_out,
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
@@ -990,18 +994,22 @@ static void clear_stack_for_all_offs(struct bpf_insn *insn,
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
 
@@ -1042,6 +1050,12 @@ static void arg_track_log(struct bpf_verifier_env *env, struct bpf_insn *insn, i
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
@@ -1111,8 +1125,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			at_out[r] = none;
 	} else if (class == BPF_LDX) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool src_is_local_fp = insn->src_reg == BPF_REG_FP || src->frame == depth ||
-				       (src->frame == ARG_IMPRECISE && (src->mask & BIT(depth)));
+		bool src_is_local_fp = can_be_local_fp(depth, insn->src_reg, src);
 
 		/*
 		 * Reload from callee stack: if src is current-frame FP-derived
@@ -1147,7 +1160,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		bool dst_is_local_fp;
 
 		/* Track spills to current-frame FP-derived callee stack */
-		dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+		dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
 		if (dst_is_local_fp && BPF_MODE(insn->code) == BPF_MEM)
 			spill_to_stack(insn, at_out, insn->dst_reg,
 				       at_stack_out, src, sz);
@@ -1166,7 +1179,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	} else if (class == BPF_ST && BPF_MODE(insn->code) == BPF_MEM) {
 		u32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
-		bool dst_is_local_fp = insn->dst_reg == BPF_REG_FP || dst->frame == depth;
+		bool dst_is_local_fp = can_be_local_fp(depth, insn->dst_reg, dst);
 
 		/* BPF_ST to FP-derived dst: clear overlapping stack slots */
 		if (dst_is_local_fp)
@@ -1316,8 +1329,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
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
