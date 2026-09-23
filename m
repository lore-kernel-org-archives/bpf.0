Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134545616C1
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190710; cv=none; b=mhpXtnySZUQewI+FB8XGZjo4B+rK/x6zCEiwe9wDVkMElCmcHgdDsvEi/oqhzjDbnja/C2fhHSakp8jidzanvRB3yA5A3k1kJlQM4uIOM1zw9f9pm+G7/NL4XmLK9/6LunDpbkqOqUVN7QKgWDqGpIs3lkG60j4my+U/aUElh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190710; c=relaxed/simple;
	bh=GNQNv+dk6aQu7efskS5lpDfr/ED1A4ZFNlEScnqiYIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2xpign3cWX5L+5cpTecuyQ8KuiVAcNE9DxVlDPIWUPP1pojbmjB8RZinO4pxq+PzYg69uTsBv3Ss+LOyOSB2OuXcKEDve6fPh8E1B6n3hFpkasUC/kMagxQQxRQLAs5CirW8GtX6so7NKbEBAc5MJ+K8Im1+WWLIDvuJRAxnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAFpS1zJ; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAFpS1zJ"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so4401835e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190704; x=1790795504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AA7O79bnVALDMSCu7RrTuwUTNoN+ys8B5rUB090rsF4=;
        b=bAFpS1zJkx+e6Cr5+9YK9d+nFxPs/rmGYhjoqaFeIhaGM+Mjlumcq7MRU44GxIyRh+
         SWHikWe6PqjXbaw/fm88Y0DjJBCqxZe7QGbfI97Ic10SivqYkRElAsXWC6oGUKdpt/ih
         L93LGqB6OlFWgIzfCyR7x3+Zazm7x5L0+gdYnN3KZzQHfehrPBTmJDJrinHiK2RjyaOQ
         8j7LDm3R97dtssa9w7NPIw6Z9Z+tcUQE7smhxOzGfJLJ5DZpwTtLiLs5iLLDWFzaiI2v
         MmDFkReo2Is2wegHPAjR9IKz8nBo7AxpIto0wUjSfcRDx/TfcsUuIFGUtRtdqCmZbOUN
         SLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190704; x=1790795504;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AA7O79bnVALDMSCu7RrTuwUTNoN+ys8B5rUB090rsF4=;
        b=dBSVu1OcPrJybobiIq9rovYYD34RDEiznVEBEuJmex76UhzV9DCQ7lHEwQV9m8TZR+
         z27T6uYA3q+PhjPRdXt34lXO2zYK/9uzsR5N/zsz+JKXZ8HuS3Gc7dBUEVId921Czu2E
         GsheDByCbkBVIurr2R9PAPVobmlHrCuRlXRd9tY60sSHL1aKoKHIGl5N5mGJEqHojTif
         py50KRcRcOU1fa2HoI3TWjIYaWwzOjBbgj1yzX98CPQB0gWoEeRl8N0kdMbsQHBxyw1e
         8eUIoPow0dSie6ebPkasd7WHSJ3I6B6B+d/j8DyVGzi8QnTPVMkumwFp74Wx5g4pl+eJ
         MrXA==
X-Gm-Message-State: AFuF++lZ7ob79okXfVEWFp9WVi4qb9EmdnM8LBHaruUopjS9ySzk7Fmx
	ZAXHNIvbazb1C6a7HdgDTVd11sn0jX6ACM+U3umCBSsUVvftmfsw+eOgbmVcH8zj
X-Gm-Gg: AYBFou2hfEG8b5byhK1jsmXzbrP3WebCgyRR/Qn0JVacl6xy+5XXI4HOBzcfKyvf4HN
	HaDxf5hWqBEl6nzrGxLCwyPA/xhawVxT3Pe8px+d0bMrDtoTEg3pXqMXtPQLYOAD1TwGmQ7Nu53
	AOMWO1hDWb0E2wa2YR4gu8wKJ19y5BfiTcWuGjldGq4FG/3ktnex5FnkVzfqD2xVHK6phvWieto
	p8b7rFhF+ycV5r12lF/eh0oEjtdn36SMF7gHup3zyKbQqW4EB8OJJijKPfp29Oj5pzS/MHpZ2Rl
	u6NVz/00UZ2tjqlmZcW65thuvKeYLlpXXYTa/w64XlfU0ijdaUHtudyZNFJsMAEAWVhE47ZiTyi
	MJ2dlL8NKAjsovbn+6Sb5jCDbhgihN2W6+NaxhsgRvRKwsMNyqdfuTd3wDgoF0NUurioQY7zuY3
	Ahm1QqbBkqFcJOgGxdbTkTk8oXa9SrhrufwnI+y4VIG26OwSuQHtVMJEd8AqwrXDSYz4c3hSrCY
	qZWa+dF828ULnT65wtRXsvSLgq0OaHBMWO7fhPD3XCHddPX3uxg26XWGOixeg6/WtOXh8PA9o9R
	cVGHOo5F5qVXQSh7kK8JLkHTdesSWA9FsbnVhQ==
X-Received: by 2002:a05:600c:4754:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49fe66d1663mr2898685e9.12.1790190703519;
        Wed, 23 Sep 2026 12:11:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4d12sm6928545e9.4.2026.09.23.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 01/18] bpf: Add accessors for verifier stack slots
Date: Wed, 23 Sep 2026 21:11:08 +0200
Message-ID: <20260923191139.2816206-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=38865; i=memxor@gmail.com; h=from:subject; bh=GNQNv+dk6aQu7efskS5lpDfr/ED1A4ZFNlEScnqiYIk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4mfT2E2tLOENfjkT5BKW9fi9F6mIzn3J9W0HK4vKj cBK58iOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATER2J8M/W863ZX0OsnvuF/o5 7cq6LttfXTavNSzh57xpGTYvlTXVGRnuNXc+Fy18ydoxxXvRDF+7Ktm0GYI2x1+na7+3degO1WA CAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The verifier indexes a frame's stack state directly through
state->stack[spi] and computes the number of tracked slots as
allocated_stack / BPF_REG_SIZE in every file that touches stack slots.
Route all of these through two helpers, bpf_stack_slot() and
bpf_stack_nr_slots(), so the layout of the per-frame stack state is
visible in one place and can change without touching every user.
Both take a const frame: the slot accessor returns the slot through the
frame's stack pointer, so read-only code such as the state printer can
use it without giving up its qualifiers. Functions that look up the
same slot repeatedly now fetch it once.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  25 ++++--
 kernel/bpf/backtrack.c       |  14 +--
 kernel/bpf/diagnostics.c     |   6 +-
 kernel/bpf/log.c             |  13 +--
 kernel/bpf/states.c          |  84 +++++++++---------
 kernel/bpf/verifier.c        | 163 +++++++++++++++++++----------------
 6 files changed, 166 insertions(+), 139 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92f528c45605..36e0c6b97533 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -529,12 +529,27 @@ struct bpf_verifier_state {
 	u32 may_goto_depth;
 };
 
+/* Number of BPF_REG_SIZE stack slots tracked for the frame so far. */
+static inline u32 bpf_stack_nr_slots(const struct bpf_func_state *frame)
+{
+	return frame->allocated_stack / BPF_REG_SIZE;
+}
+
+/*
+ * Stack slot @spi of @frame, covering bytes [fp - (spi + 1) * 8, fp - spi * 8).
+ * The caller must ensure spi < bpf_stack_nr_slots(frame), see grow_stack_state().
+ */
+static inline struct bpf_stack_state *bpf_stack_slot(const struct bpf_func_state *frame, u32 spi)
+{
+	return &frame->stack[spi];
+}
+
 static inline struct bpf_reg_state *
 bpf_get_spilled_reg(int slot, struct bpf_func_state *frame, u32 mask)
 {
-	if (slot < frame->allocated_stack / BPF_REG_SIZE &&
-	    (1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & mask)
-		return &frame->stack[slot].spilled_ptr;
+	if (slot < bpf_stack_nr_slots(frame) &&
+	    (1 << bpf_stack_slot(frame, slot)->slot_type[BPF_REG_SIZE - 1]) & mask)
+		return &bpf_stack_slot(frame, slot)->spilled_ptr;
 	return NULL;
 }
 
@@ -550,7 +565,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled register. */
 #define bpf_for_each_spilled_reg(iter, frame, reg, mask)			\
 	for (iter = 0, reg = bpf_get_spilled_reg(iter, frame, mask);		\
-	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
+	     iter < bpf_stack_nr_slots(frame);				\
 	     iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
 
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack arg. */
@@ -575,7 +590,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 			bpf_for_each_spilled_reg(___j, __state, __reg, __mask) { \
 				if (!__reg)                              \
 					continue;                        \
-				__stack = &__state->stack[___j];         \
+				__stack = bpf_stack_slot(__state, ___j); \
 				(void)(__expr);                          \
 			}                                                \
 			__stack = NULL;                                  \
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 507a366dffa4..4bec7b94796b 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -707,10 +707,10 @@ void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 						i, j);
 				}
 			}
-			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-				if (!bpf_is_spilled_reg(&func->stack[j]))
+			for (j = 0; j < bpf_stack_nr_slots(func); j++) {
+				if (!bpf_is_spilled_reg(bpf_stack_slot(func, j)))
 					continue;
-				reg = &func->stack[j].spilled_ptr;
+				reg = &bpf_stack_slot(func, j)->spilled_ptr;
 				if (reg->type != SCALAR_VALUE || reg->precise)
 					continue;
 				reg->precise = true;
@@ -946,16 +946,16 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 
 			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
 			for_each_set_bit(i, mask, 64) {
-				if (verifier_bug_if(i >= func->allocated_stack / BPF_REG_SIZE,
+				if (verifier_bug_if(i >= bpf_stack_nr_slots(func),
 						    env, "stack slot %d, total slots %d",
-						    i, func->allocated_stack / BPF_REG_SIZE))
+						    i, bpf_stack_nr_slots(func)))
 					return -EFAULT;
 
-				if (!bpf_is_spilled_scalar_reg(&func->stack[i])) {
+				if (!bpf_is_spilled_scalar_reg(bpf_stack_slot(func, i))) {
 					bt_clear_frame_slot(bt, fr, i);
 					continue;
 				}
-				reg = &func->stack[i].spilled_ptr;
+				reg = &bpf_stack_slot(func, i)->spilled_ptr;
 				if (reg->precise) {
 					bt_clear_frame_slot(bt, fr, i);
 				} else {
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 5ecfa86ed49f..a8ed6130c137 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1600,9 +1600,9 @@ static struct bpf_reg_state *target_to_reg(struct bpf_verifier_env *env,
 			return NULL;
 		return &state->stack_arg_regs[target->stack_arg];
 	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
-		if (target->spi >= state->allocated_stack / BPF_REG_SIZE)
+		if (target->spi >= bpf_stack_nr_slots(state))
 			return NULL;
-		return &state->stack[target->spi].spilled_ptr;
+		return &bpf_stack_slot(state, target->spi)->spilled_ptr;
 	default:
 		return NULL;
 	}
@@ -1618,7 +1618,7 @@ static bool reg_to_target(struct bpf_verifier_env *env, const struct bpf_reg_sta
 	for (frame = 0; frame <= vstate->curframe; frame++) {
 		struct bpf_func_state *state = vstate->frame[frame];
 		unsigned long start, end;
-		u32 nslots = state->allocated_stack / BPF_REG_SIZE;
+		u32 nslots = bpf_stack_nr_slots(state);
 		int spi;
 
 		start = (unsigned long)state->regs;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index fb032dfdc0de..d850a7863d2e 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -716,7 +716,8 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		verbose(env, "=");
 		print_reg_state(env, state, reg);
 	}
-	for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+	for (i = 0; i < bpf_stack_nr_slots(state); i++) {
+		struct bpf_stack_state *slot = bpf_stack_slot(state, i);
 		char types_buf[BPF_REG_SIZE + 1];
 		const char *sep = "";
 		bool valid = false;
@@ -727,7 +728,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			continue;
 
 		for (j = 0; j < BPF_REG_SIZE; j++) {
-			slot_type = state->stack[i].slot_type[j];
+			slot_type = slot->slot_type[j];
 			if (slot_type != STACK_INVALID && slot_type != STACK_POISON)
 				valid = true;
 			types_buf[j] = slot_type_char[slot_type];
@@ -736,12 +737,12 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		if (!valid)
 			continue;
 
-		reg = &state->stack[i].spilled_ptr;
-		switch (state->stack[i].slot_type[BPF_REG_SIZE - 1]) {
+		reg = &slot->spilled_ptr;
+		switch (slot->slot_type[BPF_REG_SIZE - 1]) {
 		case STACK_SPILL:
 			/* print MISC/ZERO/INVALID slots above subreg spill */
 			for (j = 0; j < BPF_REG_SIZE; j++)
-				if (state->stack[i].slot_type[j] == STACK_SPILL)
+				if (slot->slot_type[j] == STACK_SPILL)
 					break;
 			types_buf[j] = '\0';
 
@@ -751,7 +752,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		case STACK_DYNPTR:
 			/* skip to main dynptr slot */
 			i += BPF_DYNPTR_NR_SLOTS - 1;
-			reg = &state->stack[i].spilled_ptr;
+			reg = &bpf_stack_slot(state, i)->spilled_ptr;
 
 			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
 			verbose(env, "=dynptr_%s(", dynptr_type_str(reg->dynptr.type));
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..38795cf35247 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -415,14 +415,14 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 	 * half_spi 2*i   → lower half: slot_type[0..3] (closer to FP)
 	 * half_spi 2*i+1 → upper half: slot_type[4..7] (farther from FP)
 	 */
-	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
+	for (i = 0; i < bpf_stack_nr_slots(st); i++) {
 		bool lo_live = bpf_stack_slot_alive(env, frame, i * 2);
 		bool hi_live = bpf_stack_slot_alive(env, frame, i * 2 + 1);
 
 		if (!hi_live || !lo_live) {
 			int start = !lo_live ? 0 : BPF_REG_SIZE / 2;
 			int end = !hi_live ? BPF_REG_SIZE : BPF_REG_SIZE / 2;
-			u8 stype = st->stack[i].slot_type[7];
+			u8 stype = bpf_stack_slot(st, i)->slot_type[7];
 
 			/*
 			 * Don't clear special slots.
@@ -442,7 +442,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 			 * rejecting as non-scalar register fills.
 			 */
 			if (!hi_live) {
-				struct bpf_reg_state *spill = &st->stack[i].spilled_ptr;
+				struct bpf_reg_state *spill = &bpf_stack_slot(st, i)->spilled_ptr;
 
 				if (lo_live && stype == STACK_SPILL) {
 					if (spill->type != SCALAR_VALUE)
@@ -454,7 +454,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 					if (bpf_register_is_null(spill))
 						continue;
 					for (j = 0; j < 4; j++) {
-						u8 *t = &st->stack[i].slot_type[j];
+						u8 *t = &bpf_stack_slot(st, i)->slot_type[j];
 
 						if (*t == STACK_SPILL)
 							*t = STACK_MISC;
@@ -463,7 +463,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				bpf_mark_reg_not_init(env, spill);
 			}
 			for (j = start; j < end; j++)
-				st->stack[i].slot_type[j] = STACK_POISON;
+				bpf_stack_slot(st, i)->slot_type[j] = STACK_POISON;
 		}
 	}
 }
@@ -707,37 +707,38 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	 * didn't use them
 	 */
 	for (i = 0; i < old->allocated_stack; i++) {
+		struct bpf_stack_state *old_slot, *cur_slot;
 		struct bpf_reg_state *old_reg, *cur_reg;
 		int im = i % BPF_REG_SIZE;
+		u8 old_type;
 
 		spi = i / BPF_REG_SIZE;
+		old_slot = bpf_stack_slot(old, spi);
+		old_type = old_slot->slot_type[im];
+		cur_slot = i < cur->allocated_stack ? bpf_stack_slot(cur, spi) : NULL;
 
 		if (exact == EXACT) {
-			u8 old_type = old->stack[spi].slot_type[i % BPF_REG_SIZE];
-			u8 cur_type = i < cur->allocated_stack ?
-				      cur->stack[spi].slot_type[i % BPF_REG_SIZE] : STACK_INVALID;
+			u8 cur_type = cur_slot ? cur_slot->slot_type[im] : STACK_INVALID;
 
 			/* STACK_INVALID and STACK_POISON are equivalent for pruning */
 			if (old_type == STACK_POISON)
 				old_type = STACK_INVALID;
 			if (cur_type == STACK_POISON)
 				cur_type = STACK_INVALID;
-			if (i >= cur->allocated_stack || old_type != cur_type)
+			if (!cur_slot || old_type != cur_type)
 				return false;
 		}
 
-		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID ||
-		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_POISON)
+		if (old_type == STACK_INVALID || old_type == STACK_POISON)
 			continue;
 
-		if (env->allow_uninit_stack &&
-		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
+		if (env->allow_uninit_stack && old_type == STACK_MISC)
 			continue;
 
 		/* explored stack has more populated slots than current stack
 		 * and these slots were used
 		 */
-		if (i >= cur->allocated_stack)
+		if (!cur_slot)
 			return false;
 
 		/*
@@ -747,8 +748,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		 * regsafe() to ensure scalar ids are compared.
 		 */
 		if (im == 0 || im == 4) {
-			old_reg = scalar_reg_for_stack(env, &old->stack[spi], im);
-			cur_reg = scalar_reg_for_stack(env, &cur->stack[spi], im);
+			old_reg = scalar_reg_for_stack(env, old_slot, im);
+			cur_reg = scalar_reg_for_stack(env, cur_slot, im);
 			if (old_reg && cur_reg) {
 				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
 					return false;
@@ -761,21 +762,19 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		 * it will be safe with zero-initialized stack.
 		 * The opposite is not true
 		 */
-		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC &&
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_ZERO)
+		if (old_type == STACK_MISC && cur_slot->slot_type[im] == STACK_ZERO)
 			continue;
-		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+		if (old_type != cur_slot->slot_type[im])
 			/* Ex: old explored (safe) state has STACK_SPILL in
 			 * this stack slot, but current has STACK_MISC ->
 			 * this verifier states are not equivalent,
 			 * return false to continue verification of this path
 			 */
 			return false;
-		if (i % BPF_REG_SIZE != BPF_REG_SIZE - 1)
+		if (im != BPF_REG_SIZE - 1)
 			continue;
 		/* Both old and cur are having same slot_type */
-		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
+		switch (old_type) {
 		case STACK_SPILL:
 			/* when explored and current stack slot are both storing
 			 * spilled registers, check that stored pointers types
@@ -787,13 +786,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * such verifier states are not equivalent.
 			 * return false to continue verification of this path
 			 */
-			if (!regsafe(env, &old->stack[spi].spilled_ptr,
-				     &cur->stack[spi].spilled_ptr, idmap, exact))
+			if (!regsafe(env, &old_slot->spilled_ptr, &cur_slot->spilled_ptr,
+				     idmap, exact))
 				return false;
 			break;
 		case STACK_DYNPTR:
-			old_reg = &old->stack[spi].spilled_ptr;
-			cur_reg = &cur->stack[spi].spilled_ptr;
+			old_reg = &old_slot->spilled_ptr;
+			cur_reg = &cur_slot->spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
 			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
@@ -801,8 +800,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 				return false;
 			break;
 		case STACK_ITER:
-			old_reg = &old->stack[spi].spilled_ptr;
-			cur_reg = &cur->stack[spi].spilled_ptr;
+			old_reg = &old_slot->spilled_ptr;
+			cur_reg = &cur_slot->spilled_ptr;
 			/* iter.depth is not compared between states as it
 			 * doesn't matter for correctness and would otherwise
 			 * prevent convergence; we maintain it only to prevent
@@ -818,8 +817,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 				return false;
 			break;
 		case STACK_IRQ_FLAG:
-			old_reg = &old->stack[spi].spilled_ptr;
-			cur_reg = &cur->stack[spi].spilled_ptr;
+			old_reg = &old_slot->spilled_ptr;
+			cur_reg = &cur_slot->spilled_ptr;
 			if (!check_ids(old_reg->id, cur_reg->id, idmap) ||
 			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
 				return false;
@@ -1043,10 +1042,10 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			first = false;
 		}
 
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-			if (!bpf_is_spilled_reg(&state->stack[i]))
+		for (i = 0; i < bpf_stack_nr_slots(state); i++) {
+			if (!bpf_is_spilled_reg(bpf_stack_slot(state, i)))
 				continue;
-			state_reg = &state->stack[i].spilled_ptr;
+			state_reg = &bpf_stack_slot(state, i)->spilled_ptr;
 			if (state_reg->type != SCALAR_VALUE ||
 			    !state_reg->precise)
 				continue;
@@ -1192,15 +1191,15 @@ static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf
 
 	for (fr = old->curframe; fr >= 0; fr--) {
 		state = old->frame[fr];
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-			if (state->stack[i].slot_type[0] != STACK_ITER)
+		for (i = 0; i < bpf_stack_nr_slots(state); i++) {
+			if (bpf_stack_slot(state, i)->slot_type[0] != STACK_ITER)
 				continue;
 
-			slot = &state->stack[i].spilled_ptr;
+			slot = &bpf_stack_slot(state, i)->spilled_ptr;
 			if (slot->iter.state != BPF_ITER_STATE_ACTIVE)
 				continue;
 
-			cur_slot = &cur->frame[fr]->stack[i].spilled_ptr;
+			cur_slot = &bpf_stack_slot(cur->frame[fr], i)->spilled_ptr;
 			if (cur_slot->iter.depth != slot->iter.depth)
 				return true;
 		}
@@ -1222,10 +1221,10 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 				continue;
 			reg->precise = false;
 		}
-		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-			if (!bpf_is_spilled_reg(&func->stack[j]))
+		for (j = 0; j < bpf_stack_nr_slots(func); j++) {
+			if (!bpf_is_spilled_reg(bpf_stack_slot(func, j)))
 				continue;
-			reg = &func->stack[j].spilled_ptr;
+			reg = &bpf_stack_slot(func, j)->spilled_ptr;
 			if (reg->type != SCALAR_VALUE)
 				continue;
 			reg->precise = false;
@@ -1328,7 +1327,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					struct bpf_func_state *cur_frame;
+					struct bpf_func_state *cur_frame, *iter_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
 
@@ -1342,7 +1341,8 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					 * no need for extra (re-)validations
 					 */
 					spi = bpf_get_spi(iter_reg->var_off.value);
-					iter_state = &bpf_func(env, iter_reg)->stack[spi].spilled_ptr;
+					iter_frame = bpf_func(env, iter_reg);
+					iter_state = &bpf_stack_slot(iter_frame, spi)->spilled_ptr;
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
 						loop = true;
 						goto hit;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7c9e2d8965d..058d128a369a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -598,16 +598,17 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn)
 
 static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
 {
-       int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
+	int allocated_slots = bpf_stack_nr_slots(state);
 
-       /* We need to check that slots between [spi - nr_slots + 1, spi] are
-	* within [0, allocated_stack).
-	*
-	* Please note that the spi grows downwards. For example, a dynptr
-	* takes the size of two stack slots; the first slot will be at
-	* spi and the second slot will be at spi - 1.
-	*/
-       return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
+	/*
+	 * We need to check that slots between [spi - nr_slots + 1, spi] are
+	 * within [0, allocated_stack).
+	 *
+	 * Please note that the spi grows downwards. For example, a dynptr
+	 * takes the size of two stack slots; the first slot will be at
+	 * spi and the second slot will be at spi - 1.
+	 */
+	return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
 }
 
 static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -751,8 +752,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		return err;
 
 	for (i = 0; i < BPF_REG_SIZE; i++) {
-		state->stack[spi].slot_type[i] = STACK_DYNPTR;
-		state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
+		bpf_stack_slot(state, spi)->slot_type[i] = STACK_DYNPTR;
+		bpf_stack_slot(state, spi - 1)->slot_type[i] = STACK_DYNPTR;
 	}
 
 	type = arg_to_dynptr_type(arg_type);
@@ -785,8 +786,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		parent_id = dynptr->parent_id;
 	}
 
-	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
-			       &state->stack[spi - 1].spilled_ptr, type, parent_id);
+	mark_dynptr_stack_regs(env, &bpf_stack_slot(state, spi)->spilled_ptr,
+			       &bpf_stack_slot(state, spi - 1)->spilled_ptr, type, parent_id);
 
 	return 0;
 }
@@ -818,7 +819,7 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	 * all clones and derived slices. For non-referenced dynptr, only
 	 * the dynptr and slices derived from it will be invalidated.
 	 */
-	reg = &state->stack[spi].spilled_ptr;
+	reg = &bpf_stack_slot(state, spi)->spilled_ptr;
 	return release_reference(env, dynptr_type_referenced(reg->dynptr.type)
 				      ? reg->parent_id
 				      : reg->id);
@@ -857,6 +858,7 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
+	struct bpf_stack_state *slot = bpf_stack_slot(state, spi);
 	int err = 0;
 
 	/* We always ensure that STACK_DYNPTR is never set partially,
@@ -864,20 +866,22 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	 * different for STACK_SPILL, where it may be only set for
 	 * 1 byte, so code has to use is_spilled_reg.
 	 */
-	if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
+	if (slot->slot_type[0] != STACK_DYNPTR)
 		return 0;
 
 	/* Reposition spi to first slot */
-	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
+	if (!slot->spilled_ptr.dynptr.first_slot) {
 		spi = spi + 1;
+		slot = bpf_stack_slot(state, spi);
+	}
 
 	/*
 	 * A referenced dynptr can be overwritten only if there is at
 	 * least one other dynptr sharing the same virtual ref parent,
 	 * ensuring the reference can still be properly released.
 	 */
-	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
-	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
+	if (dynptr_type_referenced(slot->spilled_ptr.dynptr.type) &&
+	    dynptr_ref_cnt(env, slot->spilled_ptr.parent_id) <= 1) {
 		verbose(env, "cannot overwrite referenced dynptr\n");
 		bpf_diag_res(
 			env, env->insn_idx, "referenced dynptr overwrite",
@@ -887,7 +891,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	}
 
 	/* Invalidate the dynptr and any derived slices */
-	err = release_reference(env, state->stack[spi].spilled_ptr.id);
+	err = release_reference(env, slot->spilled_ptr.id);
 	if (!err) {
 		mark_stack_slot_scratched(env, spi);
 		mark_stack_slot_scratched(env, spi - 1);
@@ -927,6 +931,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
+	struct bpf_stack_state *slot;
 	int i, spi;
 
 	/* This already represents first slot of initialized bpf_dynptr.
@@ -941,12 +946,13 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return false;
-	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
+	slot = bpf_stack_slot(state, spi);
+	if (!slot->spilled_ptr.dynptr.first_slot)
 		return false;
 
 	for (i = 0; i < BPF_REG_SIZE; i++) {
-		if (state->stack[spi].slot_type[i] != STACK_DYNPTR ||
-		    state->stack[spi - 1].slot_type[i] != STACK_DYNPTR)
+		if (slot->slot_type[i] != STACK_DYNPTR ||
+		    bpf_stack_slot(state, spi - 1)->slot_type[i] != STACK_DYNPTR)
 			return false;
 	}
 
@@ -965,7 +971,7 @@ static enum bpf_dynptr_type dynptr_reg_type(struct bpf_verifier_env *env, struct
 	if (spi < 0)
 		return BPF_DYNPTR_TYPE_INVALID;
 	state = bpf_func(env, reg);
-	return state->stack[spi].spilled_ptr.dynptr.type;
+	return bpf_stack_slot(state, spi)->spilled_ptr.dynptr.type;
 }
 
 static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -1005,7 +1011,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		return id;
 
 	for (i = 0; i < nr_slots; i++) {
-		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		__mark_reg_known_zero(st);
@@ -1042,7 +1048,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		return spi;
 
 	for (i = 0; i < nr_slots; i++) {
-		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		if (i == 0)
@@ -1076,7 +1082,7 @@ static bool is_iter_reg_valid_uninit(struct bpf_verifier_env *env,
 		return false;
 
 	for (i = 0; i < nr_slots; i++) {
-		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			if (slot->slot_type[j] == STACK_ITER)
@@ -1097,7 +1103,7 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 		return -EINVAL;
 
 	for (i = 0; i < nr_slots; i++) {
-		struct bpf_stack_state *slot = &state->stack[spi - i];
+		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		if (st->type & PTR_UNTRUSTED)
@@ -1139,7 +1145,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	if (id < 0)
 		return id;
 
-	slot = &state->stack[spi];
+	slot = bpf_stack_slot(state, spi);
 	st = &slot->spilled_ptr;
 
 	__mark_reg_known_zero(st);
@@ -1166,7 +1172,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 	if (spi < 0)
 		return spi;
 
-	slot = &state->stack[spi];
+	slot = bpf_stack_slot(state, spi);
 	st = &slot->spilled_ptr;
 
 	if (st->irq.kfunc_class != kfunc_class) {
@@ -1235,7 +1241,7 @@ static bool is_irq_flag_reg_valid_uninit(struct bpf_verifier_env *env, struct bp
 	if (spi < 0)
 		return false;
 
-	slot = &state->stack[spi];
+	slot = bpf_stack_slot(state, spi);
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
 		if (slot->slot_type[i] == STACK_IRQ_FLAG)
@@ -1254,7 +1260,7 @@ static int is_irq_flag_reg_valid_init(struct bpf_verifier_env *env, struct bpf_r
 	if (spi < 0)
 		return -EINVAL;
 
-	slot = &state->stack[spi];
+	slot = bpf_stack_slot(state, spi);
 	st = &slot->spilled_ptr;
 
 	if (!st->id)
@@ -1401,7 +1407,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 
 static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_state *src)
 {
-	size_t n = src->allocated_stack / BPF_REG_SIZE;
+	size_t n = bpf_stack_nr_slots(src);
 
 	dst->stack = copy_array(dst->stack, src->stack, n, sizeof(struct bpf_stack_state),
 				GFP_KERNEL_ACCOUNT);
@@ -1440,7 +1446,7 @@ static int resize_reference_state(struct bpf_verifier_state *state, size_t n)
  */
 static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
-	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n;
+	size_t old_n = bpf_stack_nr_slots(state), n;
 
 	/* The stack size is always a multiple of BPF_REG_SIZE. */
 	size = round_up(size, BPF_REG_SIZE);
@@ -3523,17 +3529,18 @@ static void save_register_state(struct bpf_verifier_env *env,
 				int spi, struct bpf_reg_state *reg,
 				int size)
 {
+	struct bpf_stack_state *slot = bpf_stack_slot(state, spi);
 	int i;
 
-	bpf_diag_mod_begin(env, &state->stack[spi].spilled_ptr, reg, BPF_DIAG_MOD_SPILL);
-	state->stack[spi].spilled_ptr = *reg;
+	bpf_diag_mod_begin(env, &slot->spilled_ptr, reg, BPF_DIAG_MOD_SPILL);
+	slot->spilled_ptr = *reg;
 
 	for (i = BPF_REG_SIZE; i > BPF_REG_SIZE - size; i--)
-		state->stack[spi].slot_type[i - 1] = STACK_SPILL;
+		slot->slot_type[i - 1] = STACK_SPILL;
 
 	/* size < 8 bytes spill */
 	for (; i; i--)
-		mark_stack_slot_misc(env, &state->stack[spi].slot_type[i - 1]);
+		mark_stack_slot_misc(env, &slot->slot_type[i - 1]);
 
 	bpf_diag_mod_end(env);
 }
@@ -3575,14 +3582,15 @@ static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
 
 static void scrub_special_slot(struct bpf_func_state *state, int spi)
 {
+	struct bpf_stack_state *slot = bpf_stack_slot(state, spi);
 	int i;
 
 	/* regular write of data into stack destroys any spilled ptr */
-	state->stack[spi].spilled_ptr.type = NOT_INIT;
+	slot->spilled_ptr.type = NOT_INIT;
 	/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
-	if (is_stack_slot_special(&state->stack[spi]))
+	if (is_stack_slot_special(slot))
 		for (i = 0; i < BPF_REG_SIZE; i++)
-			scrub_spilled_slot(&state->stack[spi].slot_type[i]);
+			scrub_spilled_slot(&slot->slot_type[i]);
 }
 
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
@@ -3600,13 +3608,14 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = NULL;
 	int insn_flags = INSN_F_STACK_ACCESS;
 	int hist_spi = spi, hist_frame = state->frameno;
+	struct bpf_stack_state *ss = bpf_stack_slot(state, spi);
 
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
 	if (!env->allow_ptr_leaks &&
-	    bpf_is_spilled_reg(&state->stack[spi]) &&
-	    !bpf_is_spilled_scalar_reg(&state->stack[spi]) &&
+	    bpf_is_spilled_reg(ss) &&
+	    !bpf_is_spilled_scalar_reg(ss) &&
 	    size != BPF_REG_SIZE) {
 		const char *reason;
 
@@ -3628,7 +3637,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		bool sanitize = reg && is_pointer_regtype(reg->type);
 
 		for (i = 0; i < size; i++) {
-			u8 type = state->stack[spi].slot_type[(slot - i) %
+			u8 type = ss->slot_type[(slot - i) %
 							      BPF_REG_SIZE];
 
 			if (type != STACK_MISC && type != STACK_ZERO) {
@@ -3657,7 +3666,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (!reg_value_fits)
-			state->stack[spi].spilled_ptr.id = 0;
+			ss->spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
@@ -3681,8 +3690,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	} else {
 		u8 type = STACK_MISC;
 
-		if (bpf_is_spilled_reg(&state->stack[spi]))
-			bpf_diag_record_scrub(env, &state->stack[spi].spilled_ptr,
+		if (bpf_is_spilled_reg(ss))
+			bpf_diag_record_scrub(env, &ss->spilled_ptr,
 					      BPF_DIAG_MOD_WRITE);
 		scrub_special_slot(state, spi);
 
@@ -3703,7 +3712,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 		/* Mark slots affected by this stack write. */
 		for (i = 0; i < size; i++)
-			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] = type;
+			ss->slot_type[(slot - i) % BPF_REG_SIZE] = type;
 		insn_flags = 0; /* not a register spill */
 	}
 
@@ -3774,7 +3783,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
-		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
+		stype = &bpf_stack_slot(state, spi)->slot_type[slot % BPF_REG_SIZE];
 		mark_stack_slot_scratched(env, spi);
 
 		if (!env->allow_ptr_leaks && *stype != STACK_MISC && *stype != STACK_ZERO) {
@@ -3798,8 +3807,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		 * maintain the spill type.
 		 */
 		if (writing_zero && *stype == STACK_SPILL &&
-		    bpf_is_spilled_scalar_reg(&state->stack[spi])) {
-			struct bpf_reg_state *spill_reg = &state->stack[spi].spilled_ptr;
+		    bpf_is_spilled_scalar_reg(bpf_stack_slot(state, spi))) {
+			struct bpf_reg_state *spill_reg = &bpf_stack_slot(state, spi)->spilled_ptr;
 
 			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
 				zero_used = true;
@@ -3879,13 +3888,13 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		mark_stack_slot_scratched(env, spi);
-		stype = ptr_state->stack[spi].slot_type;
+		stype = bpf_stack_slot(ptr_state, spi)->slot_type;
 		if (stype[slot % BPF_REG_SIZE] == STACK_ZERO) {
 			zeros++;
 			continue;
 		}
 		if (stype[slot % BPF_REG_SIZE] == STACK_SPILL &&
-		    bpf_register_is_null(&ptr_state->stack[spi].spilled_ptr)) {
+		    bpf_register_is_null(&bpf_stack_slot(ptr_state, spi)->spilled_ptr)) {
 			zero_spill_mask |= 1ull << spi;
 			zeros++;
 			continue;
@@ -3946,9 +3955,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	int err;
 	int insn_flags = INSN_F_STACK_ACCESS;
 	int hist_spi = spi, hist_frame = reg_state->frameno;
+	struct bpf_stack_state *ss = bpf_stack_slot(reg_state, spi);
 
-	stype = reg_state->stack[spi].slot_type;
-	reg = &reg_state->stack[spi].spilled_ptr;
+	stype = ss->slot_type;
+	reg = &ss->spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
 	check_fastcall_stack_contract(env, state, env->insn_idx, off);
@@ -3959,7 +3969,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	if (dst_regno >= 0)
 		bpf_diag_mod_begin(env, &state->regs[dst_regno], reg, BPF_DIAG_MOD_WRITE);
 
-	if (bpf_is_spilled_reg(&reg_state->stack[spi])) {
+	if (bpf_is_spilled_reg(ss)) {
 		u8 spill_size = 1;
 
 		for (i = BPF_REG_SIZE - 1; i > 0 && stype[i - 1] == STACK_SPILL; i--)
@@ -7048,6 +7058,7 @@ static int check_stack_range_initialized(
 	}
 
 	for (i = min_off; i < max_off + access_size; i++) {
+		struct bpf_stack_state *ss;
 		u8 *stype;
 
 		slot = -i - 1;
@@ -7057,7 +7068,8 @@ static int check_stack_range_initialized(
 			return -EFAULT;
 		}
 
-		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
+		ss = bpf_stack_slot(state, spi);
+		stype = &ss->slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
 		if ((*stype == STACK_ZERO) ||
@@ -7069,13 +7081,13 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-		if (bpf_is_spilled_reg(&state->stack[spi]) &&
-		    (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
+		if (bpf_is_spilled_reg(ss) &&
+		    (ss->spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
 			if (clobber) {
-				__mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
+				__mark_reg_unknown(env, &ss->spilled_ptr);
 				for (j = 0; j < BPF_REG_SIZE; j++)
-					scrub_spilled_slot(&state->stack[spi].slot_type[j]);
+					scrub_spilled_slot(&ss->slot_type[j]);
 			}
 			goto mark;
 		}
@@ -7805,7 +7817,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 			mark_stack_slots_scratched(env, spi, BPF_DYNPTR_NR_SLOTS);
 
-			reg = &state->stack[spi].spilled_ptr;
+			reg = &bpf_stack_slot(state, spi)->spilled_ptr;
 		}
 
 		meta->dynptr.type = reg->dynptr.type;
@@ -7938,7 +7950,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
-		update_ref_obj(&meta->ref_obj, &state->stack[spi].spilled_ptr);
+		update_ref_obj(&meta->ref_obj, &bpf_stack_slot(state, spi)->spilled_ptr);
 
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
@@ -8015,16 +8027,15 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 					&fold->regs[i],
 					&fcur->regs[i]);
 
-		num_slots = min(fold->allocated_stack / BPF_REG_SIZE,
-				fcur->allocated_stack / BPF_REG_SIZE);
+		num_slots = min(bpf_stack_nr_slots(fold), bpf_stack_nr_slots(fcur));
 		for (i = 0; i < num_slots; i++) {
-			if (!bpf_is_spilled_reg(&fold->stack[i]) ||
-			    !bpf_is_spilled_reg(&fcur->stack[i]))
+			if (!bpf_is_spilled_reg(bpf_stack_slot(fold, i)) ||
+			    !bpf_is_spilled_reg(bpf_stack_slot(fcur, i)))
 				continue;
 
 			maybe_widen_reg(env,
-					&fold->stack[i].spilled_ptr,
-					&fcur->stack[i].spilled_ptr);
+					&bpf_stack_slot(fold, i)->spilled_ptr,
+					&bpf_stack_slot(fcur, i)->spilled_ptr);
 		}
 	}
 	return 0;
@@ -8036,7 +8047,7 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
 	int iter_frameno = meta->iter.frameno;
 	int iter_spi = meta->iter.spi;
 
-	return &cur_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+	return &bpf_stack_slot(cur_st->frame[iter_frameno], iter_spi)->spilled_ptr;
 }
 
 /* process_iter_next_call() is called when verifier gets to iterator's next
@@ -8841,7 +8852,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	slot = -stack_off - 1;
 	spi = slot / BPF_REG_SIZE;
 	off = slot % BPF_REG_SIZE;
-	stype = state->stack[spi].slot_type;
+	stype = bpf_stack_slot(state, spi)->slot_type;
 
 	/* First handle precisely tracked STACK_ZERO */
 	for (i = off; i >= 0 && stype[i] == STACK_ZERO; i--)
@@ -8852,14 +8863,14 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	}
 
 	/* Check that stack contains a scalar spill of expected size */
-	if (!bpf_is_spilled_scalar_reg(&state->stack[spi]))
+	if (!bpf_is_spilled_scalar_reg(bpf_stack_slot(state, spi)))
 		return -EOPNOTSUPP;
 	for (i = off; i >= 0 && stype[i] == STACK_SPILL; i--)
 		spill_size++;
 	if (spill_size != key_size)
 		return -EOPNOTSUPP;
 
-	reg = &state->stack[spi].spilled_ptr;
+	reg = &bpf_stack_slot(state, spi)->spilled_ptr;
 	if (!tnum_is_const(reg->var_off))
 		/* Stack value not statically known */
 		return -EOPNOTSUPP;
@@ -17322,10 +17333,10 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 			reg = &func->regs[j];
 			__collect_linked_regs(linked_regs, reg, id, i, j, true);
 		}
-		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-			if (!bpf_is_spilled_reg(&func->stack[j]))
+		for (j = 0; j < bpf_stack_nr_slots(func); j++) {
+			if (!bpf_is_spilled_reg(bpf_stack_slot(func, j)))
 				continue;
-			reg = &func->stack[j].spilled_ptr;
+			reg = &bpf_stack_slot(func, j)->spilled_ptr;
 			__collect_linked_regs(linked_regs, reg, id, i, j, false);
 		}
 	}
@@ -17345,7 +17356,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 	for (i = 0; i < linked_regs->cnt; ++i) {
 		e = &linked_regs->entries[i];
 		reg = e->is_reg ? &vstate->frame[e->frameno]->regs[e->regno]
-				: &vstate->frame[e->frameno]->stack[e->spi].spilled_ptr;
+				: &bpf_stack_slot(vstate->frame[e->frameno], e->spi)->spilled_ptr;
 		if (reg->type != SCALAR_VALUE || reg == known_reg)
 			continue;
 		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
-- 
2.53.0

