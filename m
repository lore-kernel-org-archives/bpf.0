Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874B2E7635
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698415; cv=none; b=DTPfYdw7q7pUq9I75JSl28xr4H9qJTd1P//uxJF8Wz2N0zPytQd9EXn8OydM4hizioItrPTyR5pKQBieWWK9AS8KBoEZnQ/IuEZ7KObYjxDUTc6CnnUWADTIIgKNOHZB1HuLFNHUj8dYrrFF6Tcr7lW3eOWITpqkMCg2aQ1l7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698415; c=relaxed/simple;
	bh=eDlXRi2c5PfeEIS1bP/vf8rI3hi5sQfUhINB+PWin0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVMSyasrs6M6Tn6szxmWA4d0WKLMCjfUAUgIP4dKIRXGQ3OoBYR8+BrmRpo5eX13kNgWMLP5DScoFOLRUG2AB9LqQwolwYDeepOi8bGFZgApekbTJAvO+mUichc6c9EbmP31bD8zunjBHpzL1EPoyrbEuCNZsp2ie86vp1hhrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arixOK3Z; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arixOK3Z"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so276950c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698410; x=1776303210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6+ZksMm94dK0/Qff8YOUOuJra6Twe7R8hGNBZH1YTU=;
        b=arixOK3Z4vx/g7HNGi1Tn4kSEjmX5mvusKwqb7SuGmRy+Cf/kfT52d/zf6guQLBBhQ
         nYuxY4/SaaLDxya3n/s1CDrm0I3bUSKdHtnu58lDP8jpCLzolg/cFWF6Yz2U61NvuIUj
         C7EndfEoAAmvmdtsZsgJ95+WkoVlodL2ilpN7eG7FoCCJn/DdiaR+geGKJk5In579RZw
         9DOp4Aw8k/KpHJqX0i0Vzn8uJcjx+N4eh4Lt80dmZOViR3pGiJ6xEmcQrJGfOSrLI+Fb
         /CtSSbKgdMN3Tf3byv8nsgQMxbK4RP89O4lqH3F1ZoakEMs+h+qSCYdxMjfmqhcaacop
         jqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698410; x=1776303210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6+ZksMm94dK0/Qff8YOUOuJra6Twe7R8hGNBZH1YTU=;
        b=lBMmv2UcLv8WxPfZxXmQc/6NPIOYMgqPX1Am+KvQFHXtOjcnWijXQAjT4RBS/ETGIj
         9AINxvXSILQusQ2oieMo2ysQAN4tifFiwotNcNJDwgFr9JuKi0Y3Xzh+5MLd4nS8KoBI
         llk2sHMcuBpCsgYdmH+xdbN+RNe90zD1c2bI1fmdBCYz7lKjMDJwt0uWtcxPT3bDD5LM
         k75+07FMnHmdUMpj+MaHYXeDjFjreBoYcqBWSLztIOd0y2sxEtLAFMYDGnHH3RmvZnUT
         7UEdarc5ynu1LFMTjWyfLqq/euPNZO8AX6xb7lPN9OtaGcPBaRdATSB9eJQrCgffJHUg
         UpXg==
X-Gm-Message-State: AOJu0YwPkBGaKHSjHdgtlBT/htxtiOefYqgZn2EDAk+JhpRq+gVjcY+F
	V5ix5sXLviBLigOcUMuIBqsiu0SsJtfP6JHVvCnuPFD3NM6j6vUXkFLm1tFWWFR0
X-Gm-Gg: AeBDievDoj2LoAQVZbN3oSsud5psF2QCGVbmfL7Z/Xs5nnIM14aJ+d5zTb/4yqBQD9p
	9cDm+alJto5ogwvaskmAfX8QKlrpz/WL5AMU4uPQjhwHVQ/1S766OW4NgrxO3NSw/EN6b/rSYE2
	GyyxH3IdI/4rXZcZJCh6J6eSYdH5v+Bv3ic7psAJkLGPrLjuZbtklwaRVJthVxczlf3o05Cure9
	pSQQEzC59jDDVRkALNEPUD6956nSgsPG0deirdjh3VecE/Nz+zk4gRdEv6z9FqrKD73hW6am3aL
	6Arqyar+CyrZ35V9/VhmWiZ2+w56SX7nB/1B3j02TMQIIAk8hNCsJ6HHVNN9ZodbO8Grf9REVQG
	7ChOb1ae4CSeVCOWcFqu6CwesoFp7b4Jpz2cirTJ64uHstmx8nxO/Oc5KClEeyJXlHUttWKgNUN
	WjHOXCF+cz7U4YZQPC3sPYwQsxSivx9D9d9JpooBEg9M0Q1kIeznchG+YtBJd3fUyv94coXhVEe
	cq9nSnVAPmaRg==
X-Received: by 2002:a05:7022:6990:b0:128:d715:b717 with SMTP id a92af1059eb24-12c28bc138cmr974758c88.13.1775698410376;
        Wed, 08 Apr 2026 18:33:30 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:30 -0700 (PDT)
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
Subject: [PATCH bpf-next 05/14] bpf: 4-byte precise clean_verifier_state
Date: Wed,  8 Apr 2026 18:33:07 -0700
Message-ID: <20260408-patch-set-v1-5-1a666e860d42@gmail.com>
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
 kernel/bpf/liveness.c | 14 +++++-----
 kernel/bpf/verifier.c | 77 +++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 9e36ea5f2eec88587749b316bebdfc92dfa33e8d..e2697cd9ae27f95970a7a495a362c371d27922ed 100644
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
index 6e852d461289197276cb50b54fc6cf307de04962..f971c89c77fc000a1e7b2d38fd8ed784cfb562ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20068,11 +20068,10 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
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
@@ -20084,10 +20083,61 @@ static void clean_func_state(struct bpf_verifier_env *env,
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
+			 * Don't clearn special slots.
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
@@ -20096,13 +20146,16 @@ static void clean_func_state(struct bpf_verifier_env *env,
 static void clean_verifier_state(struct bpf_verifier_env *env,
 				 struct bpf_verifier_state *st)
 {
-	int i, ip;
+	int i;
 
-	bpf_live_stack_query_init(env, st);
-	st->cleaned = true;
+	if (env->cur_state != st)
+		st->cleaned = true;
+	bpf_live_stack_query_init(env, st); // TODO: return err
 	for (i = 0; i <= st->curframe; i++) {
-		ip = frame_insn_idx(st, i);
-		clean_func_state(env, st->frame[i], ip);
+		u32 ip = frame_insn_idx(st, i);
+		u16 live_regs = env->insn_aux_data[ip].live_regs_before;
+
+		__clean_func_state(env, st->frame[i], live_regs, i);
 	}
 }
 

-- 
2.53.0
