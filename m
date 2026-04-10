Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2A3A7F67
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854582; cv=none; b=SGB0Wsk7Ty01uzDkuQ0jF7hINCO/tlOKMf+qlAfZUPm9K6Eug5t1ANO3a5ny48PQ7/w5C0vBIhD0E+SOfRxybf48HOgcpL3m2u4uDZU6X9L33LwV9Z39Wb2TNMw4UDqEFcHALZQ3IUeSf0w7cUpzX8AQcTHNvYRFfzzrsAQGi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854582; c=relaxed/simple;
	bh=Gbv7Lki15tP5ydK3K6UAS4Dq5ai1ldxjvoZr2xJF9gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PurDw3I+Hmhsn2LwT0QGUfIR/KfD6BpM66tr39b9X6qfm7tQfgWLg+KX9ocV+fnoKxOFerodvgFfeLQWa439V8m+vG1gqke/1DNXSFKA73ymSp21rL/3kwlQYeOedgKWqojybBnaLqTuW5rGzpo4nnPbm2W0kYvGAAa7UgToeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCSziWnF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCSziWnF"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-827270d50d4so2331741b3a.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854581; x=1776459381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1qefpn3iC425NMiOKwLGTzQhOe+e7GA4HlVwbz2IkE=;
        b=rCSziWnFvOHFs2nTYbokfAg+FNHBgQoiYb7R3AiSEmHwrV5VygOWPU7I0q5nPQAOBn
         qvkt3XDGZQg3r4OZ5INg3raHcdNxV8J5Mumph7ENVBSRR6dQgsGmcA0bGSJTwzxdYko6
         2zn5CHmzD6wdabL6SJaAiuK/UVZP8o0omVXSNwud5pUJL1KA426NYKtJOkD6LSVzcya6
         2ZGnfGF0rA4bbcy8cxRreVzOdCqoY7TCpMlgjqd4poYzpmstsax5kKZk3aEHbd+9C2eY
         sqUPc0o+6MSHoyU30uLDUqin8z83+Xxqp1p56HgDjgvrFY/d2A60CR/AlSfg2DULTz2k
         Mhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854581; x=1776459381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1qefpn3iC425NMiOKwLGTzQhOe+e7GA4HlVwbz2IkE=;
        b=FpKKd8gQYwBLux3bprtdLE/Crc25m+oXKzZTevkjxk9mWk/wMx8yG+5/bomqvljkmK
         CcriBsXPQOxpLd/13zK8WMfcSFAfQO7hWCR9jwgjkn4fPxZTfT/sJjk/EZ2CbuwfhF38
         y2kgH4b+nTMa7rHAMsZ4fDcj/N/Xr9k9UNIvDrYQr0wtyEgqmhu6K9rku0uSKrvFv/oY
         e4+zwPslXQpoMUpq7uSHGASV0z7O/YiLjTzTPzVXXZ5s3+cpxe4WeyQcl/3Ys95bvffL
         EFiMy50MrkX+1J/MK1w3wC2WNaA6tJIEadfJZOc5ZlKlbO0XIdzNy6e9QCVaa0btzY/Q
         kY1Q==
X-Gm-Message-State: AOJu0YyJtGk5aWyuqaE0ruZ2tsk/yvBu0CerYUs+VuHXpybv+HYSRC8W
	mRe1O88Gb2jKv7AWRdUfLQuT4lYnf2N4QfIW0b/i9JRwenEzJb2GVKim9GQEey6w
X-Gm-Gg: AeBDiesAU17KWJak5uDCxujVNItrF/72zunNKy+2036GGrcWQDZypP4sdVAKrrYXt0N
	eMmn/DAXEX8YSIYAxki0JU+7+ZPtV4DzMGNhb0lp1vHdkL6FQHqfxU9L4xmUAriT8P1UjVNvMEU
	Hn5UEq0qgw/foxLtRnuvLiVxwev1ZCyu9wsEVl8zab7kcfXWqd6SAxqOfWal46kna9Hbk5KW2Sk
	GIq5R0XIG+NPtE7wZtQfch+lijgbhpkBDHemdF1WhOBtt17XNoXJxJXEgAhWjwkbp4PcrqnYuLo
	TYLMmMLcwJxsr7X2Rrh6VoMNz3+Yt+ZiFKuQ0nvU3+GRsiL4X8scKO03Pzo8tdj7ubhJ0UX8/MA
	dw2T6OA3HZll3Zssp3nL6vrrPQCaskryO6zhGyzOZz0I5WJtHu9GVmsaOwZObslxrTu5z1phWnR
	MZSPRDXOSmPRnPg9R01qtTdQwvMByFdBbrLAIGssjRTrP7mUfT8VzHqVA5fSuvatfG3i8=
X-Received: by 2002:a05:6a00:f99:b0:823:9c6:1985 with SMTP id d2e1a72fcca58-82f0c288c79mr5161415b3a.16.1775854580704;
        Fri, 10 Apr 2026 13:56:20 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v4 05/14] bpf: 4-byte precise clean_verifier_state
Date: Fri, 10 Apr 2026 13:55:56 -0700
Message-ID: <20260410-patch-set-v4-5-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Migrate clean_verifier_state() and its liveness queries from 8-byte
SPI granularity to 4-byte half-slot granularity.

In __clean_func_state(), each SPI is cleaned in two independent
halves:
  - half_spi 2*i   (lo): slot_type[0..3]
  - half_spi 2*i+1 (hi): slot_type[4..7]

Slot types STACK_DYNPTR, STACK_ITER and STACK_IRQ_FLAG are never
cleaned, as their slot type markers are required by
destroy_if_dynptr_stack_slot(), is_iter_reg_valid_uninit() and
is_irq_flag_reg_valid_uninit() for correctness.

When only the hi half is dead, spilled_ptr metadata is destroyed and
the lo half's STACK_SPILL bytes are downgraded to STACK_MISC or
STACK_ZERO. When only the lo half is dead, spilled_ptr is preserved
because the hi half may still need it for state comparison.

Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 14 ++++----
 kernel/bpf/verifier.c | 94 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 9e36ea5f2eec..e2697cd9ae27 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -732,13 +732,12 @@ int bpf_update_live_stack(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 spi)
+static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi)
 {
 	struct per_frame_masks *masks;
 
 	masks = get_frame_masks(instance, frameno, insn_idx);
-	return masks && (spis_test_bit(masks->live_before, spi * 2) ||
-			 spis_test_bit(masks->live_before, spi * 2 + 1));
+	return masks && spis_test_bit(masks->live_before, half_spi);
 }
 
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
@@ -759,7 +758,7 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 	return 0;
 }
 
-bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi)
+bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_spi)
 {
 	/*
 	 * Slot is alive if it is read before q->st->insn_idx in current func instance,
@@ -773,15 +772,16 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi)
 	bool alive;
 
 	curframe_instance = q->instances[q->curframe];
-	if (is_live_before(curframe_instance, q->insn_idx, frameno, spi))
+	alive = is_live_before(curframe_instance, q->insn_idx, frameno, half_spi);
+	if (alive)
 		return true;
 
 	for (i = frameno; i < q->curframe; i++) {
 		callsite = curframe_instance->callchain.callsites[i];
 		instance = q->instances[i];
 		alive = bpf_calls_callback(env, callsite)
-			? is_live_before(instance, callsite, frameno, spi)
-			: is_live_before(instance, callsite + 1, frameno, spi);
+			? is_live_before(instance, callsite, frameno, half_spi)
+			: is_live_before(instance, callsite + 1, frameno, half_spi);
 		if (alive)
 			return true;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee3945a919e3..0731e99aa541 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20059,11 +20059,10 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	return check_ids(old_id, cur_id, idmap);
 }
 
-static void clean_func_state(struct bpf_verifier_env *env,
-			     struct bpf_func_state *st,
-			     u32 ip)
+static void __clean_func_state(struct bpf_verifier_env *env,
+			       struct bpf_func_state *st,
+			       u16 live_regs, int frame)
 {
-	u16 live_regs = env->insn_aux_data[ip].live_regs_before;
 	int i, j;
 
 	for (i = 0; i < BPF_REG_FP; i++) {
@@ -20075,26 +20074,83 @@ static void clean_func_state(struct bpf_verifier_env *env,
 			__mark_reg_not_init(env, &st->regs[i]);
 	}
 
+	/*
+	 * Clean dead 4-byte halves within each SPI independently.
+	 * half_spi 2*i   → lower half: slot_type[0..3] (closer to FP)
+	 * half_spi 2*i+1 → upper half: slot_type[4..7] (farther from FP)
+	 */
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
-		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
-			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
-			for (j = 0; j < BPF_REG_SIZE; j++)
+		bool lo_live = bpf_stack_slot_alive(env, frame, i * 2);
+		bool hi_live = bpf_stack_slot_alive(env, frame, i * 2 + 1);
+
+		if (!hi_live || !lo_live) {
+			int start = !lo_live ? 0 : BPF_REG_SIZE / 2;
+			int end = !hi_live ? BPF_REG_SIZE : BPF_REG_SIZE / 2;
+			u8 stype = st->stack[i].slot_type[7];
+
+			/*
+			 * Don't clear special slots.
+			 * destroy_if_dynptr_stack_slot() needs STACK_DYNPTR to
+			 * detect overwrites and invalidate associated data slices.
+			 * is_iter_reg_valid_uninit() and is_irq_flag_reg_valid_uninit()
+			 * check for their respective slot types to detect double-create.
+			 */
+			if (stype == STACK_DYNPTR || stype == STACK_ITER ||
+			    stype == STACK_IRQ_FLAG)
+				continue;
+
+			/*
+			 * Only destroy spilled_ptr when hi half is dead.
+			 * If hi half is still live with STACK_SPILL, the
+			 * spilled_ptr metadata is needed for correct state
+			 * comparison in stacksafe().
+			 * is_spilled_reg() is using slot_type[7], but
+			 * is_spilled_scalar_after() check either slot_type[0] or [4]
+			 */
+			if (!hi_live) {
+				struct bpf_reg_state *spill = &st->stack[i].spilled_ptr;
+
+				if (lo_live && stype == STACK_SPILL) {
+					u8 val = STACK_MISC;
+
+					/*
+					 * 8 byte spill of scalar 0 where half slot is dead
+					 * should become STACK_ZERO in lo 4 bytes.
+					 */
+					if (register_is_null(spill))
+						val = STACK_ZERO;
+					for (j = 0; j < 4; j++) {
+						u8 *t = &st->stack[i].slot_type[j];
+
+						if (*t == STACK_SPILL)
+							*t = val;
+					}
+				}
+				__mark_reg_not_init(env, spill);
+			}
+			for (j = start; j < end; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
 		}
 	}
 }
 
-static void clean_verifier_state(struct bpf_verifier_env *env,
+static int clean_verifier_state(struct bpf_verifier_env *env,
 				 struct bpf_verifier_state *st)
 {
-	int i, ip;
+	int i, err;
 
-	bpf_live_stack_query_init(env, st);
-	st->cleaned = true;
+	if (env->cur_state != st)
+		st->cleaned = true;
+	err = bpf_live_stack_query_init(env, st);
+	if (err)
+		return err;
 	for (i = 0; i <= st->curframe; i++) {
-		ip = frame_insn_idx(st, i);
-		clean_func_state(env, st->frame[i], ip);
+		u32 ip = frame_insn_idx(st, i);
+		u16 live_regs = env->insn_aux_data[ip].live_regs_before;
+
+		__clean_func_state(env, st->frame[i], live_regs, i);
 	}
+	return 0;
 }
 
 /* the parentage chains form a tree.
@@ -20193,11 +20249,12 @@ static void clear_singular_ids(struct bpf_verifier_env *env,
 	}));
 }
 
-static void clean_live_states(struct bpf_verifier_env *env, int insn,
+static int clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
 	struct bpf_verifier_state_list *sl;
 	struct list_head *pos, *head;
+	int err;
 
 	head = explored_state(env, insn);
 	list_for_each(pos, head) {
@@ -20212,8 +20269,11 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			continue;
 		if (incomplete_read_marks(env, &sl->state))
 			continue;
-		clean_verifier_state(env, &sl->state);
+		err = clean_verifier_state(env, &sl->state);
+		if (err)
+			return err;
 	}
+	return 0;
 }
 
 static bool regs_exact(const struct bpf_reg_state *rold,
@@ -20916,7 +20976,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	    env->insn_processed - env->prev_insn_processed >= 8)
 		add_new_state = true;
 
-	clean_live_states(env, insn_idx, cur);
+	err = clean_live_states(env, insn_idx, cur);
+	if (err)
+		return err;
 
 	loop = false;
 	head = explored_state(env, insn_idx);

-- 
2.53.0
