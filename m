Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A03128CF
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698414; cv=none; b=NhEosgPfWhPoKA1iMjQrYSOoPJIvyn0JAffo52OWQEzFiEclBupGD00amdCcp0LogPGo2tiPPon7iiLydAhVPI9Hxs0afimODXEwIbCHJdYJ9YX2FUTlQaM4e6C8aXRlnheMH4lKVdPCE6l08rhSQsHGip+XC3uChf9EvzLnBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698414; c=relaxed/simple;
	bh=mTzvte6npjkIUVcSdBqe+7CLSYvMChSK3sWwR8n2wkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esJBKE/UQZxvIX3k+iRNe/VUQKu+sQOHU/lWSKaCprenaoMGlFuXmi/oCI9MHeLQMBetdul4qQPzv1gsATZSMPCOngHZqj38p436MTB9QkUzQZffwN7VcxFBO/rdr8SP0tPKh7bwl+ywN1H/6bem/lEdR7o1e6fvqg9SWo94g6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHHXJU4N; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHHXJU4N"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c25b90264so1941058c88.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698409; x=1776303209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6J2wlRIi8H9H2f0LXbbzWUomlu2LeIHOFzLBfBPAhQ=;
        b=eHHXJU4NGUNkzJUrYn9/Imc3qyj/3Tl5y4tFVG0IF/tY5WjHMoTIHEYT+Jc9a5qUQl
         wGfDuqRqpJ4okC5bl3blqW/196HiS9mvRxHikwPb7E04VMTCTCjN7zV323BVXzEu0X7n
         hSH+iXhnsWdX9JMKhOYLIlwFWP6oiSBRV9axgWeWF1z/szVzibZyZxVvAFi/5ZVtEwqU
         qOfTFGyxXrrrWv9X0QUPmzGeXG2pq1qaIY6uILwWIPQ4IJeAr7OCHK8XLkJSt8LTD0R4
         O85aKsFNgwcW4EmqOi0cxOk1Qh5jygo0/rbzc4vXu7lZN0xpdivIFRveInD3Z8JsBKEz
         0iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698409; x=1776303209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6J2wlRIi8H9H2f0LXbbzWUomlu2LeIHOFzLBfBPAhQ=;
        b=YYhmyKRj+V9wSqSYN0A1r23St5sUdgs/kkfGLCNipQPed1DYy3PksMyMIvrr3WVF70
         hRG15K+on3V7+g2el8OUYM/F9Q9MHmQWUAv34PjD5MkNtoFB/m+RZwnC6AYLazxuvf7R
         +LxkotH09Tp2IO94/cVMYF0PN/EWBXoduUgYACiGeAWOfbfyEeMBFTKK2mXK/WSS0nBp
         EQcW7H7L9lyoJIUUwXZ3O/n2qfaGAuDSrybZgUDXQ5INI63512MM9ITojsRMpTDlF008
         2W9WtY05bi3jIuv++yu9KZTgd8wmLf+9uu16oYxT/8BNAkA9UmF+f+SgHlcraSgBC+jY
         hAqg==
X-Gm-Message-State: AOJu0YxJW4BGph2ADD8i4NbHpF8UNrG+MgOGbGpTE/rqHzcmIGWqTGO5
	wRYyI6EJgDj7RL3HeG2SxmKwY+lPncir95oCfsmpJcy5mq40Sq53C/Epf8SMk0EV
X-Gm-Gg: AeBDievJtFc7Gf4qVs0ABpaW21m7gp0zB0Bxa9KLgOXLdB6JMNpE4HSWcMrybs6Bnka
	WLLwGX9cSqb+Tmh9BMwKOiMgbpXbEBQHCtRJGPjcfN4UeTxKQ6UYfdDJ50aiLO3dq8Uy49xNScB
	Pbuda5uY20/H8WAr5CQVKuFQ3uPnDrjExNTJfiS1d+C/AztpqQMIN29M+6nR9pa6v22LLKnNKM8
	kXz4ZHSmlOtUHEcmMkEwJuBZ+D6DM76c+4iNpa+dIw4ytaXO7GpkAMFm1CMFmHfaRsrjbzprPf/
	kJD/5LxMl3DsnLALz2NCBWcIzJV2yFjVpKxj1VhSQIFApYailNWkYUYMP0QjdJbYKqPEh/3tAWW
	ApUDykEkfNjCSZVM74Bwsu9AbBTKoXJ/pfiPwjTOFD1d3HO5DE19DAlVPF8YoT2ma6NvJT5Hbf1
	btLBO7rRS4bgWrayZvnoYtRIB8z6pVzfV2mxJdD1qlW4SO87mjHd2k2iRLHmFOkILEDI97OASEm
	NK3woPWChOTnQ==
X-Received: by 2002:a05:7022:b81:b0:127:9c10:446c with SMTP id a92af1059eb24-12bfb6ec4e0mr12628654c88.7.1775698409026;
        Wed, 08 Apr 2026 18:33:29 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 04/14] bpf: make liveness.c track stack with 4-byte granularity
Date: Wed,  8 Apr 2026 18:33:06 -0700
Message-ID: <20260408-patch-set-v1-4-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert liveness bitmask type from u64 to spis_t, doubling the number
of trackable stack slots from 64 to 128 to support 4-byte granularity.

Each 8-byte SPI now maps to two consecutive 4-byte sub-slots in the
bitmask: spi*2 for the LSB (lower-addressed) half and spi*2+1 for the
MSB (higher-addressed) half. Three helpers encode this mapping:
  - spis_single_slot(spi):   sets both halves (full 8-byte slot)
  - spis_lsb_half_slot(spi): sets only spi*2
  - spis_msb_half_slot(spi): sets only spi*2+1

In verifier.c, check_stack_write_fixed_off() now reports 4-byte
aligned writes of 4-byte writes as half-slot marks and 8-byte aligned
8-byte writes as lsb + msb slots. Similar logic applied in
check_stack_read_fixed_off().

Queries (is_live_before) are not yet migrated to half-slot
granularity.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   4 +-
 kernel/bpf/liveness.c        | 122 ++++++++++++++++++++++++++++---------------
 kernel/bpf/verifier.c        |  51 +++++++++++-------
 3 files changed, 113 insertions(+), 64 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 64361cb49073935f0c218f1c4d7807cf113f8aa3..e1b004081b69de389a872fa33595d29aa7758960 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1248,8 +1248,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_update_live_stack(struct bpf_verifier_env *env);
-int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frameno, u32 insn_idx, u64 mask);
-void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frameno, u64 mask);
+int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frameno, u32 insn_idx, spis_t mask);
+void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frameno, spis_t mask);
 int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx);
 int bpf_commit_stack_write_marks(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 998986853c61babd446e3a562c7664f7e9459de9..9e36ea5f2eec88587749b316bebdfc92dfa33e8d 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -93,10 +93,10 @@ struct callchain {
 };
 
 struct per_frame_masks {
-	u64 may_read;		/* stack slots that may be read by this instruction */
-	u64 must_write;		/* stack slots written by this instruction */
-	u64 must_write_acc;	/* stack slots written by this instruction and its successors */
-	u64 live_before;	/* stack slots that may be read by this insn and its successors */
+	spis_t may_read;	/* stack slots that may be read by this instruction */
+	spis_t must_write;	/* stack slots written by this instruction */
+	spis_t must_write_acc;	/* stack slots written by this instruction and its successors */
+	spis_t live_before;	/* stack slots that may be read by this insn and its successors */
 };
 
 /*
@@ -131,7 +131,7 @@ struct bpf_liveness {
 	 * Below fields are used to accumulate stack write marks for instruction at
 	 * @write_insn_idx before submitting the marks to @cur_instance.
 	 */
-	u64 write_masks_acc[MAX_CALL_FRAMES];
+	spis_t write_masks_acc[MAX_CALL_FRAMES];
 	u32 write_insn_idx;
 };
 
@@ -299,23 +299,24 @@ static int ensure_cur_instance(struct bpf_verifier_env *env)
 
 /* Accumulate may_read masks for @frame at @insn_idx */
 static int mark_stack_read(struct bpf_verifier_env *env,
-			   struct func_instance *instance, u32 frame, u32 insn_idx, u64 mask)
+			   struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
 {
 	struct per_frame_masks *masks;
-	u64 new_may_read;
+	spis_t new_may_read;
 
 	masks = alloc_frame_masks(env, instance, frame, insn_idx);
 	if (IS_ERR(masks))
 		return PTR_ERR(masks);
-	new_may_read = masks->may_read | mask;
-	if (new_may_read != masks->may_read &&
-	    ((new_may_read | masks->live_before) != masks->live_before))
+	new_may_read = spis_or(masks->may_read, mask);
+	if (!spis_equal(new_may_read, masks->may_read) &&
+	    !spis_equal(spis_or(new_may_read, masks->live_before),
+				masks->live_before))
 		instance->updated = true;
-	masks->may_read |= mask;
+	masks->may_read = spis_or(masks->may_read, mask);
 	return 0;
 }
 
-int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frame, u32 insn_idx, u64 mask)
+int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frame, u32 insn_idx, spis_t mask)
 {
 	int err;
 
@@ -332,7 +333,7 @@ static void reset_stack_write_marks(struct bpf_verifier_env *env,
 
 	liveness->write_insn_idx = insn_idx;
 	for (i = 0; i <= instance->callchain.curframe; i++)
-		liveness->write_masks_acc[i] = 0;
+		liveness->write_masks_acc[i] = SPIS_ZERO;
 }
 
 int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx)
@@ -348,18 +349,18 @@ int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx)
 	return 0;
 }
 
-void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frame, u64 mask)
+void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frame, spis_t mask)
 {
-	env->liveness->write_masks_acc[frame] |= mask;
+	env->liveness->write_masks_acc[frame] = spis_or(env->liveness->write_masks_acc[frame], mask);
 }
 
 static int commit_stack_write_marks(struct bpf_verifier_env *env,
 				    struct func_instance *instance)
 {
 	struct bpf_liveness *liveness = env->liveness;
-	u32 idx, frame, curframe, old_must_write;
+	u32 idx, frame, curframe;
 	struct per_frame_masks *masks;
-	u64 mask;
+	spis_t mask, old_must_write, dropped;
 
 	if (!instance)
 		return 0;
@@ -369,7 +370,7 @@ static int commit_stack_write_marks(struct bpf_verifier_env *env,
 	for (frame = 0; frame <= curframe; frame++) {
 		mask = liveness->write_masks_acc[frame];
 		/* avoid allocating frames for zero masks */
-		if (mask == 0 && !instance->must_write_set[idx])
+		if (spis_is_zero(mask) && !instance->must_write_set[idx])
 			continue;
 		masks = alloc_frame_masks(env, instance, frame, liveness->write_insn_idx);
 		if (IS_ERR(masks))
@@ -380,12 +381,14 @@ static int commit_stack_write_marks(struct bpf_verifier_env *env,
 		 * to @mask. Otherwise take intersection with the previous value.
 		 */
 		if (instance->must_write_set[idx])
-			mask &= old_must_write;
-		if (old_must_write != mask) {
+			mask = spis_and(mask, old_must_write);
+		if (!spis_equal(old_must_write, mask)) {
 			masks->must_write = mask;
 			instance->updated = true;
 		}
-		if (old_must_write & ~mask)
+		/* dropped = old_must_write & ~mask */
+		dropped = spis_and(old_must_write, spis_not(mask));
+		if (!spis_is_zero(dropped))
 			instance->must_write_dropped = true;
 	}
 	instance->must_write_set[idx] = true;
@@ -415,22 +418,52 @@ static char *fmt_callchain(struct bpf_verifier_env *env, struct callchain *callc
 	return env->tmp_str_buf;
 }
 
+/*
+ * When both halves of an 8-byte SPI are set, print as "-8","-16",...
+ * When only one half is set, print as "-4h","-8h",...
+ */
+static void bpf_fmt_spis_mask(char *buf, ssize_t buf_sz, spis_t spis)
+{
+	bool first = true;
+	int spi, n;
+
+	buf[0] = '\0';
+
+	for (spi = 0; spi < STACK_SLOTS / 2 && buf_sz > 0; spi++) {
+		bool lo = spis_test_bit(spis, spi * 2);
+		bool hi = spis_test_bit(spis, spi * 2 + 1);
+
+		if (!lo && !hi)
+			continue;
+		n = snprintf(buf, buf_sz, "%s%d%s",
+			     first ? "" : ",",
+			     -(spi + 1) * BPF_REG_SIZE + (lo && !hi ? BPF_HALF_REG_SIZE : 0),
+			     lo && hi ? "" : "h");
+		first = false;
+		buf += n;
+		buf_sz -= n;
+	}
+}
+
 static void log_mask_change(struct bpf_verifier_env *env, struct callchain *callchain,
-			    char *pfx, u32 frame, u32 insn_idx, u64 old, u64 new)
+			    char *pfx, u32 frame, u32 insn_idx,
+			    spis_t old, spis_t new)
 {
-	u64 changed_bits = old ^ new;
-	u64 new_ones = new & changed_bits;
-	u64 new_zeros = ~new & changed_bits;
+	spis_t changed_bits, new_ones, new_zeros;
+
+	changed_bits = spis_xor(old, new);
+	new_ones = spis_and(new, changed_bits);
+	new_zeros = spis_and(spis_not(new), changed_bits);
 
-	if (!changed_bits)
+	if (spis_is_zero(changed_bits))
 		return;
 	bpf_log(&env->log, "%s frame %d insn %d ", fmt_callchain(env, callchain), frame, insn_idx);
-	if (new_ones) {
-		bpf_fmt_stack_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_ones);
+	if (!spis_is_zero(new_ones)) {
+		bpf_fmt_spis_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_ones);
 		bpf_log(&env->log, "+%s %s ", pfx, env->tmp_str_buf);
 	}
-	if (new_zeros) {
-		bpf_fmt_stack_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_zeros);
+	if (!spis_is_zero(new_zeros)) {
+		bpf_fmt_spis_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_zeros);
 		bpf_log(&env->log, "-%s %s", pfx, env->tmp_str_buf);
 	}
 	bpf_log(&env->log, "\n");
@@ -562,7 +595,7 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 			       struct func_instance *instance, u32 frame, u32 insn_idx)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	u64 new_before, new_after, must_write_acc;
+	spis_t new_before, new_after, must_write_acc;
 	struct per_frame_masks *insn, *succ_insn;
 	struct bpf_iarray *succ;
 	u32 s;
@@ -574,28 +607,30 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 
 	changed = false;
 	insn = get_frame_masks(instance, frame, insn_idx);
-	new_before = 0;
-	new_after = 0;
+	new_before = SPIS_ZERO;
+	new_after = SPIS_ZERO;
 	/*
 	 * New "must_write_acc" is an intersection of all "must_write_acc"
 	 * of successors plus all "must_write" slots of instruction itself.
 	 */
-	must_write_acc = U64_MAX;
+	must_write_acc = SPIS_ALL;
 	for (s = 0; s < succ->cnt; ++s) {
 		succ_insn = get_frame_masks(instance, frame, succ->items[s]);
-		new_after |= succ_insn->live_before;
-		must_write_acc &= succ_insn->must_write_acc;
+		new_after = spis_or(new_after, succ_insn->live_before);
+		must_write_acc = spis_and(must_write_acc, succ_insn->must_write_acc);
 	}
-	must_write_acc |= insn->must_write;
+	must_write_acc = spis_or(must_write_acc, insn->must_write);
 	/*
 	 * New "live_before" is a union of all "live_before" of successors
 	 * minus slots written by instruction plus slots read by instruction.
+	 * new_before = (new_after & ~insn->must_write) | insn->may_read
 	 */
-	new_before = (new_after & ~insn->must_write) | insn->may_read;
-	changed |= new_before != insn->live_before;
-	changed |= must_write_acc != insn->must_write_acc;
+	new_before = spis_or(spis_and(new_after, spis_not(insn->must_write)),
+			     insn->may_read);
+	changed |= !spis_equal(new_before, insn->live_before);
+	changed |= !spis_equal(must_write_acc, insn->must_write_acc);
 	if (unlikely(env->log.level & BPF_LOG_LEVEL2) &&
-	    (insn->may_read || insn->must_write ||
+	    (!spis_is_zero(insn->may_read) || !spis_is_zero(insn->must_write) ||
 	     insn_idx == callchain_subprog_start(&instance->callchain) ||
 	     aux[insn_idx].prune_point)) {
 		log_mask_change(env, &instance->callchain, "live",
@@ -631,7 +666,7 @@ static int update_instance(struct bpf_verifier_env *env, struct func_instance *i
 
 			for (i = 0; i < instance->insn_cnt; i++) {
 				insn = get_frame_masks(instance, frame, this_subprog_start + i);
-				insn->must_write_acc = 0;
+				insn->must_write_acc = SPIS_ZERO;
 			}
 		}
 	}
@@ -702,7 +737,8 @@ static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 fra
 	struct per_frame_masks *masks;
 
 	masks = get_frame_masks(instance, frameno, insn_idx);
-	return masks && (masks->live_before & BIT(spi));
+	return masks && (spis_test_bit(masks->live_before, spi * 2) ||
+			 spis_test_bit(masks->live_before, spi * 2 + 1));
 }
 
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c1da28de869cbb395dee7d7f700d90113af9f433..6e852d461289197276cb50b54fc6cf307de04962 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -828,7 +828,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
-	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
+	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
+	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - 1));
 
 	return 0;
 }
@@ -845,7 +846,8 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 
-	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
+	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
+	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - 1));
 }
 
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
@@ -963,7 +965,8 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 
-	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
+	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
+	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - 1));
 
 	return 0;
 }
@@ -1090,7 +1093,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_ITER;
 
-		bpf_mark_stack_write(env, state->frameno, BIT(spi - i));
+		bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - i));
 		mark_stack_slot_scratched(env, spi - i);
 	}
 
@@ -1119,7 +1122,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_INVALID;
 
-		bpf_mark_stack_write(env, state->frameno, BIT(spi - i));
+		bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - i));
 		mark_stack_slot_scratched(env, spi - i);
 	}
 
@@ -1209,7 +1212,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	slot = &state->stack[spi];
 	st = &slot->spilled_ptr;
 
-	bpf_mark_stack_write(env, reg->frameno, BIT(spi));
+	bpf_mark_stack_write(env, reg->frameno, spis_single_slot(spi));
 	__mark_reg_known_zero(st);
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
 	st->ref_obj_id = id;
@@ -1265,7 +1268,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 	__mark_reg_not_init(env, st);
 
-	bpf_mark_stack_write(env, reg->frameno, BIT(spi));
+	bpf_mark_stack_write(env, reg->frameno, spis_single_slot(spi));
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
 		slot->slot_type[i] = STACK_INVALID;
@@ -3856,7 +3859,8 @@ static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg
 	int err, i;
 
 	for (i = 0; i < nr_slots; i++) {
-		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi - i));
+		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx,
+					  spis_single_slot(spi - i));
 		if (err)
 			return err;
 		mark_stack_slot_scratched(env, spi - i);
@@ -5409,15 +5413,14 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		return err;
 
 	if (!(off % BPF_REG_SIZE) && size == BPF_REG_SIZE) {
-		/* only mark the slot as written if all 8 bytes were written
-		 * otherwise read propagation may incorrectly stop too soon
-		 * when stack slots are partially written.
-		 * This heuristic means that read propagation will be
-		 * conservative, since it will add reg_live_read marks
-		 * to stack slots all the way to first state when programs
-		 * writes+reads less than 8 bytes
-		 */
-		bpf_mark_stack_write(env, state->frameno, BIT(spi));
+		/* 8-byte aligned, 8-byte write */
+		bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
+	} else if (!(off % BPF_REG_SIZE) && size == BPF_HALF_REG_SIZE) {
+		/* 8-byte aligned, 4-byte write */
+		bpf_mark_stack_write(env, state->frameno, spis_lsb_half_slot(spi));
+	} else if (!(off % BPF_HALF_REG_SIZE) && size == BPF_HALF_REG_SIZE) {
+		/* 4-byte aligned, 4-byte write */
+		bpf_mark_stack_write(env, state->frameno, spis_msb_half_slot(spi));
 	}
 
 	check_fastcall_stack_contract(env, state, insn_idx, off);
@@ -5676,6 +5679,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
 	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
+	spis_t mask;
 	int err;
 
 	stype = reg_state->stack[spi].slot_type;
@@ -5683,7 +5687,15 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 	mark_stack_slot_scratched(env, spi);
 	check_fastcall_stack_contract(env, state, env->insn_idx, off);
-	err = bpf_mark_stack_read(env, reg_state->frameno, env->insn_idx, BIT(spi));
+	if (!(off % BPF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
+		/* 8-byte aligned, 4-byte read */
+		mask = spis_lsb_half_slot(spi);
+	else if (!(off % BPF_HALF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
+		/* 4-byte aligned, 4-byte read */
+		mask = spis_msb_half_slot(spi);
+	else
+		mask = spis_single_slot(spi);
+	err = bpf_mark_stack_read(env, reg_state->frameno, env->insn_idx, mask);
 	if (err)
 		return err;
 
@@ -8480,7 +8492,8 @@ static int check_stack_range_initialized(
 		/* reading any byte out of 8-byte 'spill_slot' will cause
 		 * the whole slot to be marked as 'read'
 		 */
-		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi));
+		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx,
+					  spis_single_slot(spi));
 		if (err)
 			return err;
 		/* We do not call bpf_mark_stack_write(), as we can not

-- 
2.53.0
