Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46D30FC03
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783514; cv=none; b=MywP798dVzjrcblnZMwo2SKUeFxTBxc6cp6eGa6tOfmYZ2LP+JccDvVPciYKB3Kh4rDM0jhP8Q/VwGG9LYNd7Lsictuajs9HvF2El+paeAKxLhA7n79t0bLvftQNC0Afxsw9rWL8Esy/RIBDoNjO4rtk/VNlog5Bakp1v5pcKdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783514; c=relaxed/simple;
	bh=XR1N095y4RgYKbcJlAolJl4VhIt9g0SSq3m+MRQJmbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAPxVW9Q++7GEpO0PPMV8OqDO6gTjJSbsfXMnzk0E8LaFxX+h5hwhS7YVODJvDRGWspyNvMK/N5NCanYtq6i41xaXN0+IIfmPn9PCAGbz4r2LZLt31r34sysnVsShWO63s/+gvT1fhHjlwuzilmvnOHQP2XhCJHLoTv9//MbEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwEBen1q; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwEBen1q"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1fcce8f8so1173370c88.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783512; x=1776388312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhsfNpv3bQg69FAW7BaEfQeJOGDuuI6+WY/m+XZlpJ4=;
        b=pwEBen1qzgfrhrWlkH8nLEAOCvaNCCqWb1abdKe500he22MMr8dxl9oWoCQzXEVVhx
         D6FsqeI/b4INVUxqYH2xSg42dal527TwfvI6qLT0eC0cSlAoBzH8dueMeTs4QZq8W/ck
         RfcY0uMF1FQszfPDix4cktcrrkK41OH5GK+u2ckVCYX3pO8TIsrvBiUro29ElWWF6CdH
         wuPpbWK0l80rTR7LnAGgjkkvf6r05YlKDgiV56ZKpFQkLOv1EZGPok6fqewglWkRZeOP
         RYMEh1XoLxQQ3EZFRPTfBqgWMWpCGwwOE87FSnlSonduR9LHHXc/nQnzhdbpaKPdlgW9
         brgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783512; x=1776388312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhsfNpv3bQg69FAW7BaEfQeJOGDuuI6+WY/m+XZlpJ4=;
        b=qUs2kbRlcIQ0J0mIIrcuo2Rn3s58Izla3tGHaUu+x0vAymEiuGsHgXrf6X+vsw/lp4
         J+ugfFgIliXn3FN5qfOy70ro02SQZ2gXPB3O4VGkK1EiQlmKK649pFOhC1YgaC3EH21Q
         8/N9Vmq8llqBBnhX/lxLcuvos7BZ7LsOGPgd7J9PqHxukL0pfUfocVMU8lthQfLBHXxT
         /zK3OUYstqFMuwosD3cE5gJJaarpLqlkOU84zHrz1I81Qy5FC/pNxiLqfUA4iHcW7bD9
         q9pWfpxOzJa9zWrfpsKRj0bxqBub9YpB0tQJ5wH+I0QB0+0C07J5lkM+yAQPjSlOxcya
         WRBA==
X-Gm-Message-State: AOJu0YxQCXJdmIyf2Btc1zVaK/gwRMvPs8jL34MXu+nn4PxrSq5feNS6
	rJUgS/t4FRQu07I2IJsTW7sHA6jzRNtaPFbIl1pbo1Su44Ht8/VBg6X++LzC+2l5
X-Gm-Gg: AeBDieuvG+BWvoFHXdUC2xUlXx5iVmOQ7WjRn1I4290t95lsF5F1UpoM7D3QF6MhjU1
	SSDtLzg0qkuxvcnoc9Q8VJnR6k25ZNT4Jh848X90jlXZopFfZ6dn5vSSZVky73lzCWtsDqQrRko
	nnPDm6F+OsgD5W25jDFFspAQdfWTsh3xNvnEnP4pK4hi4TLXbRdxNKpJOH17W0LQqxwPCcY52bK
	77+I10lwA+rX0Y5hvaDFtJvsPg7oJX4mz3tU0owBKKA6TTMuiulXM2QhmNIsKcBDH7kTfyW5eyj
	SjXQ3kBnVP/1M2OBSzUnMS+Qymu/O9FpU5CKUXbSxwaV+W/e8wsPuXRDJfoKEby1gEAb/nl3FZj
	SRg0mql7dNw0TExWXYFtRMNcfluBc8URknr1NFZSSurEMZq5COAJ2RZjrrV/E+BcNg995+Z24Mn
	8zaZQ+xhUIOXqsIUgiqRavUBnBZGcDRQilRI1dH1Fcrzp3fG0DeGfsGOQDyyOTLAbgDMVmofjwp
	CD7huOW6Wlpc1v0dA==
X-Received: by 2002:a05:7300:730f:b0:2c5:b23e:48ac with SMTP id 5a478bee46e88-2d5873adf4bmr819586eec.2.1775783511792;
        Thu, 09 Apr 2026 18:11:51 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 04/13] bpf: make liveness.c track stack with 4-byte granularity
Date: Thu,  9 Apr 2026 18:11:23 -0700
Message-ID: <20260409-patch-set-v2-4-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
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
bitmask: spi*2 half and spi*2+1 half. In verifier.c,
check_stack_write_fixed_off() now reports 4-byte aligned writes of
4-byte writes as half-slot marks and 8-byte aligned 8-byte writes as
two slots. Similar logic applied in check_stack_read_fixed_off().

Queries (is_live_before) are not yet migrated to half-slot
granularity.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   4 +-
 kernel/bpf/liveness.c        | 122 ++++++++++++++++++++++++++++---------------
 kernel/bpf/verifier.c        |  55 +++++++++++--------
 3 files changed, 115 insertions(+), 66 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 124828c9a916..fac9bf403c5d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1218,8 +1218,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
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
index 998986853c61..9e36ea5f2eec 100644
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
index cd2a56308e59..ee3945a919e3 100644
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
@@ -3846,7 +3849,8 @@ static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg
 	int err, i;
 
 	for (i = 0; i < nr_slots; i++) {
-		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi - i));
+		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx,
+					  spis_single_slot(spi - i));
 		if (err)
 			return err;
 		mark_stack_slot_scratched(env, spi - i);
@@ -5398,17 +5402,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	if (!(off % BPF_REG_SIZE) && size == BPF_REG_SIZE) {
-		/* only mark the slot as written if all 8 bytes were written
-		 * otherwise read propagation may incorrectly stop too soon
-		 * when stack slots are partially written.
-		 * This heuristic means that read propagation will be
-		 * conservative, since it will add reg_live_read marks
-		 * to stack slots all the way to first state when programs
-		 * writes+reads less than 8 bytes
-		 */
-		bpf_mark_stack_write(env, state->frameno, BIT(spi));
-	}
+	if (!(off % BPF_REG_SIZE) && size == BPF_REG_SIZE)
+		/* 8-byte aligned, 8-byte write */
+		bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
+	else if (!(off % BPF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
+		/* 8-byte aligned, 4-byte write */
+		bpf_mark_stack_write(env, state->frameno, spis_one_bit(spi * 2 + 1));
+	else if (!(off % BPF_HALF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
+		/* 4-byte aligned, 4-byte write */
+		bpf_mark_stack_write(env, state->frameno, spis_one_bit(spi * 2));
 
 	check_fastcall_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
@@ -5666,6 +5668,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
 	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
+	spis_t mask;
 	int err;
 
 	stype = reg_state->stack[spi].slot_type;
@@ -5673,7 +5676,16 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 	mark_stack_slot_scratched(env, spi);
 	check_fastcall_stack_contract(env, state, env->insn_idx, off);
-	err = bpf_mark_stack_read(env, reg_state->frameno, env->insn_idx, BIT(spi));
+	if (!(off % BPF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
+		/* 8-byte aligned, 4-byte read */
+		mask = spis_one_bit(spi * 2 + 1);
+	else if (!(off % BPF_HALF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
+		/* 4-byte aligned, 4-byte read */
+		mask = spis_one_bit(spi * 2);
+	else
+		mask = spis_single_slot(spi);
+
+	err = bpf_mark_stack_read(env, reg_state->frameno, env->insn_idx, mask);
 	if (err)
 		return err;
 
@@ -8470,7 +8482,8 @@ static int check_stack_range_initialized(
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
