Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8724A6CE1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269072; cv=none; b=bAdZ8dW4rIVK/DiXLPKBJ9n9nzFyxzdLvpFuyMFQgSMZxE6kD4f5uplW8+HkkEFZkSPV/5nnmEh4Qb3SN3KOqfVUZmjsOjISqWzwEDhZazB5JaKsrlFE2OjBL0+mXqc7z4rrLStggBeQ5uQ+0FpZeRDhhnoi6k1AGsNfqnpWTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269072; c=relaxed/simple;
	bh=foU+CDWPTxrIDmAptT6W0rSXfoIaYoSwKuhhy6sD3CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE3yKWsCsZ5UvNngWxKLERGlQmcmXeFCmVLrjVPGFsHsAuNPDJGDK47GCSyMDkdrvVjU5p/Dd3AWEQXoWDdz21fD0xSSSI8pAfdEO3/Yjj2L4gi8v0abZURrDIanceh0YzCaXNmTggvYOVfgzLOG2xXQyCatKnYkgaI+OjuNoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlhQK1dS; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlhQK1dS"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so7966f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269069; x=1790873869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sWmpLznRtcIWm40i+Rexqi80TIZQ2nTaJhLPtJ4C1qA=;
        b=DlhQK1dSz30wwVsxeh0whNR21JOAXMsaEWIRvySrtV7kkle9nVE/VmCj677TKo+pwe
         68gEsKUKvH0pwGk+Qq46JlTzwITI8dYffVTcKMv+ufXMhN35yDSLeB5Ib1alssx2PyLK
         gU4yK7oPnMA1JQXfUEvJxEeHewKT8diRCAiYh/77i/mB29Jxc/HuCOd0Vc0Py4auXwMA
         BBrJKZHsbVWMFhiEhQgEJBHsYCVarJqecRkTigPWLZhb3MCIvPw4DCZN6JJXqwIzDYnK
         dbHsQLKlqcbNDLqVwPesGWXriUwpZWnEHZ2ZM407g2/1rAFfFgQ+wnNbYRybnwaYxg2v
         hsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269069; x=1790873869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sWmpLznRtcIWm40i+Rexqi80TIZQ2nTaJhLPtJ4C1qA=;
        b=cgJN7DmUySn1zryaLfVe7AD2vRQd522A7+PT9wKFSD4hE7LrjvjYUshgM4mmSoBQpR
         YpSa107VwB80i/F/pIwP10rvQnSF65XaZ+CEXJgeVg181FZ5iwykH+AX92GVa4KAm1DU
         bxrUdIFbo8rOwNYuhGS4G8jQtjZ9TgokBK98Pv2q04HwJ7AueP5x0rLDgw2fy7l2Wk8j
         wtIGERAKBHy8TfumsA5umoIBH/MlzipjKeB6pLamCzj9kGWcw7H/78mMbTE4CvN4GD+D
         Kd/WvRjqCTv/SUYZeO5StDS/1REwONTVbo2yLOp+VoygbKFJObuqmYPUi7YMoQKVQ7+i
         Qmmw==
X-Gm-Message-State: AFuF++nMt23tlGrJp37HYudE3KbdvJWCJCOJr2kaFb1m3IM5Vy9j+eeP
	vxXfIRirn13he6Xb3o1/MgWdWHB7y8p6DS/lQf2g2nY1mtuofry37zSZ3fQsTGlQ
X-Gm-Gg: AYBFou0bD4Rzu+cDLabP+LN+3pMyOQTf7aLaoVWDAmWRN3pGYDb0Xe3JkSn8k2fjqWj
	7St3/fwFh+t9Q+FigUEr627/jNGgRyg1lfksHyI25c7Q7eWs0SkCkFKxgRwB88aYAJZiS7gvCRr
	a9BKBSrFLWiT0z/i3Y3T/a6gyaJfe5J8UDZbDxcZt9jfeKwDiWrmf7dsJSiwYd35+VvvZdYsXh4
	dGbSiSsUJfIN+iYWwt7P94JopcRkb+Ivs4DpdBZQ+Zs912dSFHwrQBYQ95CZwV0da7+x3lLgf6f
	VpB5PaiKA8n+aW3EhbYNq5Wog2vE0i+A9d9UQC4i7uSRXYjJfWfvMHr8hSzGPX70M9BxWDD7zpp
	fC3lDd8ygtzVx5Iy5vKIku76P1FgpPAta01HgPsog3wSgx+vwLDRiuvNJfvYUOJ3jPIpuAgTwek
	cuo5TpiY1nlesSaarCYtgONn/bRfEsv9+TtCNETFBzGdd9k6Z6/qPYCbWOeUEpv0fljTHrV8HQc
	c7yM/ICj8dM3cC4Hj9CBQdpXBdyM9bCIKOPwCYzHBCUQQ/YlbMDtiEj06NuTMyoY5Du0r3+K8Uu
	V/Rq4Z8TuDndqsmLtLiJgnUoPM8b8wN7gyEnlw==
X-Received: by 2002:a05:600c:4e49:b0:49d:29ab:540b with SMTP id 5b1f17b1804b1-49fe66cec31mr51362275e9.15.1790269068778;
        Thu, 24 Sep 2026 09:57:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6ca26fsm3319225e9.0.2026.09.24.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 04/18] bpf: Track backtracking stack slots with bitmaps
Date: Thu, 24 Sep 2026 18:57:05 +0200
Message-ID: <20260924165740.2146806-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9878; i=memxor@gmail.com; h=from:subject; bh=foU+CDWPTxrIDmAptT6W0rSXfoIaYoSwKuhhy6sD3CE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraH72Lum+LWxNk84Iu2ausn0kJsAxp0W/4fmzox5HG dNnflfoKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ6zzIydMc9dgq2TZSSi1k+ Ob0mfBdX0jNxPb9lvkXdRc2fX8bZMzIsVBbeftSpY++02lusU9QzDk5OX6i/a76gi/+tD5oXHha yAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Precision backtracking keeps the stack slots that still need a precise
mark in one u64 per frame, which ties it to frames of at most 64 slots.
Turn the per-frame masks into bitmaps sized by MAX_BPF_STACK_SLOTS and
use the bitmap helpers for setting, clearing, testing and iterating
them. The formatting helper takes a bitmap and the leftover-slot bug
reports print the formatted slot list instead of a hex mask.

mark_reg_stack_read() collected zero spills in a u64 of its own before
handing it to the backtracker; it now counts them and revisits the
range to mark each slot, which drops the only remaining mask-typed
entry point.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 13 +++-----
 kernel/bpf/backtrack.c       | 65 ++++++++++++++++++++++--------------
 kernel/bpf/verifier.c        | 15 ++++++---
 3 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7d5da5b38e0e..781dc5ca1fe2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -900,7 +900,7 @@ struct backtrack_state {
 	struct bpf_verifier_env *env;
 	u32 frame;
 	u32 reg_masks[MAX_CALL_FRAMES];
-	u64 stack_masks[MAX_CALL_FRAMES];
+	unsigned long stack_masks[MAX_CALL_FRAMES][BITS_TO_LONGS(MAX_BPF_STACK_SLOTS)];
 	u8 stack_arg_masks[MAX_CALL_FRAMES];
 };
 
@@ -1367,12 +1367,7 @@ static inline void bpf_bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u
 
 static inline void bpf_bt_set_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
 {
-	bt->stack_masks[frame] |= 1ull << slot;
-}
-
-static inline void bpf_bt_set_frame_slot_mask(struct backtrack_state *bt, u32 frame, u64 mask)
-{
-	bt->stack_masks[frame] |= mask;
+	__set_bit(slot, bt->stack_masks[frame]);
 }
 
 static inline void bt_set_frame_stack_arg_slot(struct backtrack_state *bt, u32 frame, u32 slot)
@@ -1387,7 +1382,7 @@ static inline bool bt_is_frame_reg_set(struct backtrack_state *bt, u32 frame, u3
 
 static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
 {
-	return bt->stack_masks[frame] & (1ull << slot);
+	return test_bit(slot, bt->stack_masks[frame]);
 }
 
 bool bpf_map_is_rdonly(const struct bpf_map *map);
@@ -1588,7 +1583,7 @@ struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *en
 const char *bpf_subprog_name(const struct bpf_verifier_env *env, int subprog);
 int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
-void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, const unsigned long *stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
 /* Kinds of member a by-value struct or union may be composed of. */
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 06630acd0d1f..0e38b9575328 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -129,13 +129,26 @@ static inline void bt_reset(struct backtrack_state *bt)
 	bt->env = env;
 }
 
-static inline u32 bt_empty(struct backtrack_state *bt)
+static inline bool bt_frame_stack_empty(struct backtrack_state *bt, u32 frame)
 {
-	u64 mask = 0;
+	return bitmap_empty(bt->stack_masks[frame], MAX_BPF_STACK_SLOTS);
+}
+
+static inline bool bt_stack_empty(struct backtrack_state *bt)
+{
+	return bt_frame_stack_empty(bt, bt->frame);
+}
+
+static inline bool bt_empty(struct backtrack_state *bt)
+{
+	u32 mask = 0;
 	int i;
 
-	for (i = 0; i <= bt->frame; i++)
-		mask |= bt->reg_masks[i] | bt->stack_masks[i] | bt->stack_arg_masks[i];
+	for (i = 0; i <= bt->frame; i++) {
+		mask |= bt->reg_masks[i] | bt->stack_arg_masks[i];
+		if (!bt_frame_stack_empty(bt, i))
+			return false;
+	}
 
 	return mask == 0;
 }
@@ -187,7 +200,7 @@ static inline void bt_clear_reg(struct backtrack_state *bt, u32 reg)
 
 static inline void bt_clear_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
 {
-	bt->stack_masks[frame] &= ~(1ull << slot);
+	__clear_bit(slot, bt->stack_masks[frame]);
 }
 
 static inline u32 bt_frame_reg_mask(struct backtrack_state *bt, u32 frame)
@@ -200,14 +213,14 @@ static inline u32 bt_reg_mask(struct backtrack_state *bt)
 	return bt->reg_masks[bt->frame];
 }
 
-static inline u64 bt_frame_stack_mask(struct backtrack_state *bt, u32 frame)
+static inline unsigned long *bt_frame_stack_mask(struct backtrack_state *bt, u32 frame)
 {
 	return bt->stack_masks[frame];
 }
 
-static inline u64 bt_stack_mask(struct backtrack_state *bt)
+static inline unsigned long *bt_stack_mask(struct backtrack_state *bt)
 {
-	return bt->stack_masks[bt->frame];
+	return bt_frame_stack_mask(bt, bt->frame);
 }
 
 static inline u8 bt_stack_arg_mask(struct backtrack_state *bt)
@@ -239,17 +252,16 @@ static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
 			break;
 	}
 }
-/* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
-void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
+
+/* format stack slots bitmask, e.g., "-8,-24,-40" for slots 0, 2 and 4 */
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, const unsigned long *stack_mask)
 {
-	DECLARE_BITMAP(mask, 64);
 	bool first = true;
 	int i, n;
 
 	buf[0] = '\0';
 
-	bitmap_from_u64(mask, stack_mask);
-	for_each_set_bit(i, mask, 64) {
+	for_each_set_bit(i, stack_mask, MAX_BPF_STACK_SLOTS) {
 		n = snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i + 1) * 8);
 		first = false;
 		buf += n;
@@ -461,10 +473,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				/* we are now tracking register spills correctly,
 				 * so any instance of leftover slots is a bug
 				 */
-				if (bt_stack_mask(bt) != 0) {
-					verifier_bug(env,
-						     "static subprog leftover stack slots %llx",
-						     bt_stack_mask(bt));
+				if (!bt_stack_empty(bt)) {
+					bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+							   bt_stack_mask(bt));
+					verifier_bug(env, "static subprog leftover stack slots %s",
+						     env->tmp_str_buf);
 					return -EFAULT;
 				}
 				/* propagate r1-r5 to the caller */
@@ -497,9 +510,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					     bt_reg_mask(bt));
 				return -EFAULT;
 			}
-			if (bt_stack_mask(bt) != 0) {
-				verifier_bug(env, "callback leftover stack slots %llx",
-					     bt_stack_mask(bt));
+			if (!bt_stack_empty(bt)) {
+				bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+						   bt_stack_mask(bt));
+				verifier_bug(env, "callback leftover stack slots %s",
+					     env->tmp_str_buf);
 				return -EFAULT;
 			}
 			/* clear r1-r5 in callback subprog's mask */
@@ -881,7 +896,7 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 			if (st->curframe == 0 &&
 			    st->frame[0]->subprogno > 0 &&
 			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
-			    bt_stack_mask(bt) == 0 &&
+			    bt_stack_empty(bt) &&
 			    (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) == 0) {
 				bitmap_from_u64(mask, bt_reg_mask(bt));
 				for_each_set_bit(i, mask, 32) {
@@ -895,8 +910,9 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 				return 0;
 			}
 
-			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %llx",
-				     st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
+			bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
+			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %s",
+				     st->frame[0]->subprogno, bt_reg_mask(bt), env->tmp_str_buf);
 			return -EFAULT;
 		}
 
@@ -957,8 +973,7 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 				}
 			}
 
-			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
-			for_each_set_bit(i, mask, 64) {
+			for_each_set_bit(i, bt_frame_stack_mask(bt, fr), MAX_BPF_STACK_SLOTS) {
 				if (verifier_bug_if(i >= bpf_stack_nr_slots(func),
 						    env, "stack slot %d, total slots %d",
 						    i, bpf_stack_nr_slots(func)))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401540bf6586..2b87cb9beea0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3934,10 +3934,9 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	u64 zero_spill_mask = 0;
 	int i, slot, spi;
 	u8 *stype;
-	int zeros = 0;
+	int zeros = 0, zero_spills = 0;
 
 	for (i = min_off; i < max_off; i++) {
 		slot = -i - 1;
@@ -3950,7 +3949,7 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 		}
 		if (stype[slot % BPF_REG_SIZE] == STACK_SPILL &&
 		    bpf_register_is_null(&bpf_stack_slot(ptr_state, spi)->spilled_ptr)) {
-			zero_spill_mask |= 1ull << spi;
+			zero_spills++;
 			zeros++;
 			continue;
 		}
@@ -3961,8 +3960,14 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 		 * so the whole register == const_zero.
 		 */
 		__mark_reg_const_zero(env, &state->regs[dst_regno]);
-		if (zero_spill_mask) {
-			bpf_bt_set_frame_slot_mask(&env->bt, ptr_state->frameno, zero_spill_mask);
+		if (zero_spills) {
+			for (i = min_off; i < max_off; i++) {
+				slot = -i - 1;
+				spi = slot / BPF_REG_SIZE;
+				stype = bpf_stack_slot(ptr_state, spi)->slot_type;
+				if (stype[slot % BPF_REG_SIZE] == STACK_SPILL)
+					bpf_bt_set_frame_slot(&env->bt, ptr_state->frameno, spi);
+			}
 			return mark_chain_precision_batch(env, env->cur_state);
 		}
 	} else {
-- 
2.53.0

