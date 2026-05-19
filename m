Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643233F8A1
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214401; cv=none; b=sxh1Olk65wvzYEzXYLftWvQglRZ6RHZNdqTWOtUnj3pMXwfhU4jP0H/CfGoCt1inje333gVe7OOfkyR+6pnts0MucIpJaeW5XvTr/aOqeQjYmviKlyikSy36lLpufOJw5EOtRg18jXq6GyEytiYRz8jk4HoA1OnhVBRcaOo0BzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214401; c=relaxed/simple;
	bh=0zmmE9owoJmpjX5rkdO8Vz4Y4T7Hn5V0BRd4YzX7FcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHi3LnFUhMNFXj5v+9besjRBoLOvMLpUsmk349O4tVmyfB6rQO0udnNWy5YskxKa2NPUbto2xELFwgiOLM2jbevywmYbEXLlGvI2JYYs4HIINPIYeZn6b6XrjGVS2WZaJ/jEuOnwb7PJYaSxT+jj7bS+S67sMXqFYrl+lT+6dy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpFzbuLG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpFzbuLG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7b37d84a6b3so33144017b3.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214397; x=1779819197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aXd2hCKEAmm1cF4JsLY+ElpPbpclBdFYzFFzCGJ0EA=;
        b=NpFzbuLGGf+gDopIWEG4vabApCiYe4fLwld3h8LEy0bpINRnq/GfreKAA+1QS9UjYm
         DtqvkXXwgx5cQXXjZwDDzPC5axcy3J/AQiSuLbd/CgZmEwfWewQk6tltAq1+2GIXYEHV
         D+yLRXuvVbvDNRBtBs/+u1Jug7QZO4iMFkC8hNJs2CxqPBDSa2xHewd6spPzTegGbm26
         9ReaqAwjsHIljzu3znO1Vo7tg5MfAh7ly/z1VSlDZn6m36Mu4CE7nBFTck1djS/wrge/
         VA644z3N/Ck1QcteGK8g3HP0pS1QT8CreZzDBYoGu6JabUVh6qkFcnD45o67NUuTy8jg
         rRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214397; x=1779819197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3aXd2hCKEAmm1cF4JsLY+ElpPbpclBdFYzFFzCGJ0EA=;
        b=qou9TuChHRxNRT27dlyKEG18pjYX/roPdpvOgeGHpkkzO5lWe6XOttB3i3iOXi7iIM
         r7FdRoHde8ZOfK6IYGDnKmp8yj+zvnUveuwhNbwhN2/VBmGa8WcfUXNt72u0AMcCOou6
         FGozoZ6ZM+/cxYdRTW3BdjGIUldM2wcXtsxGLE0kNDORfBvZkk50D7pjFg/MGu5+e7Aj
         1r386AUyjowLyByH22QuRlugZDk10DdZkAsCcgUSFDAGcSRlJN/bZg4WGn4ddl0/LzKu
         gVzornA07zQXZwowcLNCPnQ/SMZvBQ/Embph9M66k6NYIXZwwX38tT4fSpy0H3TOETnI
         IQjg==
X-Gm-Message-State: AOJu0YzcCkaR0wN2qtDpXQkBonxNfenjxWjdUZC5vuTK+U1yg1zUyGDJ
	4Djbo3rgaxvvDG4RLYH505sX0C9rKY6HNCZCBkjgYdWl3S+LO5Lrx46qQBOqgw==
X-Gm-Gg: Acq92OGoD8F0ZMjeEQSqVPbg57dCva1ySLH1Z9/aYbcvxOaX8shU7smW1KTfKsAJy+B
	zrCyO1vNDATW5e3b5iWTy3T4Z80QN8w0RZXUNyr+2M9NYg3dXges4itTNkg3iy1+4ydIAQam57+
	C30v+divicBoBEHC4CRnKBcgIerPN6ox5BIxbMiQPSNj9vPwvnutNpIcxlqG8yn1XVz0x3OB8bV
	rCnGmqDOOYas9picAZnK7h8sVZZ8XMxB5V94FYnTdNmosOv19gMJANwYe895+TSje3AW9EeggKg
	QN3JiPdiHT/JMzV6cgJj0WXXWvg8B6o/bRgEYfWTFRB6JhKRfhUER/Jo1side/Fh18ErpD5aAm6
	ZXEGdIkwVQVfZhCQzoiW3o5FJjd3w0Vms/OkLLAOL6+QiWQqkEu8kA4OS/g7CshCkkqMpbQ6vzI
	AeP1Q9qcg3QX0RbA==
X-Received: by 2002:a05:690c:e3e8:b0:7bd:a6ea:c508 with SMTP id 00721157ae682-7c95c7ede98mr216896037b3.24.1779214397379;
        Tue, 19 May 2026 11:13:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c9bd9sm40743897b3.4.2026.05.19.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 01/14] bpf: Simplify mark_stack_slot_obj_read() and callers
Date: Tue, 19 May 2026 11:12:59 -0700
Message-ID: <20260519181314.2731658-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename mark_stack_slot_obj_read() as mark_stack_slots_scratched() and
directly call it from functions processing iter, dynptr and irq_flag.
Commit 6762e3a0bce5 ("bpf: simplify liveness to use (callsite, depth)
keyed func_instances") has removed the dynamic liveness component in
mark_stack_slot_obj_read(). The function effectively only marks stack
slots as scratched and always succeed. Therefore, return void, drop the
unused bpf_reg_state argument and rename it to
mark_stack_slots_scratched() to reflect what it does now.

In addition, to prepare for unifying dynptr handling, dynptr_get_spi()
will be moved out of mark_dynptr_read(). As mark_dynptr_read() would join
mark_iter_read() as a thin wrapper of mark_stack_slots_scratched(), just
open code these helpers.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 69 +++++++++++++------------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dd79b735a69..9daa5555db39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3007,50 +3007,13 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 	return ret;
 }
 
-static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				    int spi, int nr_slots)
+static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
+				       int spi, int nr_slots)
 {
 	int i;
 
 	for (i = 0; i < nr_slots; i++)
 		mark_stack_slot_scratched(env, spi - i);
-	return 0;
-}
-
-static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	int spi;
-
-	/* For CONST_PTR_TO_DYNPTR, it must have already been done by
-	 * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
-	 * check_kfunc_call.
-	 */
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return 0;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	/* Caller ensures dynptr is valid and initialized, which means spi is in
-	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
-	 * read.
-	 */
-	return mark_stack_slot_obj_read(env, reg, spi, BPF_DYNPTR_NR_SLOTS);
-}
-
-static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			  int spi, int nr_slots)
-{
-	return mark_stack_slot_obj_read(env, reg, spi, nr_slots);
-}
-
-static int mark_irq_flag_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	int spi;
-
-	spi = irq_flag_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return mark_stack_slot_obj_read(env, reg, spi, 1);
 }
 
 /* This function is supposed to be used by the following 32-bit optimization
@@ -7256,7 +7219,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	int err;
+	int spi, err = 0;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
 		verbose(env,
@@ -7318,7 +7281,17 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			return -EINVAL;
 		}
 
-		err = mark_dynptr_read(env, reg);
+		if (reg->type != CONST_PTR_TO_DYNPTR) {
+			spi = dynptr_get_spi(env, reg);
+			if (spi < 0)
+				return spi;
+
+			/*
+			 * For CONST_PTR_TO_DYNPTR, reg is already scratched by check_reg_arg
+			 * in check_helper_call and mark_btf_func_reg_size in check_kfunc_call.
+			 */
+			mark_stack_slots_scratched(env, spi, BPF_DYNPTR_NR_SLOTS);
+		}
 	}
 	return err;
 }
@@ -7428,9 +7401,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (spi < 0)
 			return spi;
 
-		err = mark_iter_read(env, reg, spi, nr_slots);
-		if (err)
-			return err;
+		mark_stack_slots_scratched(env, spi, nr_slots);
 
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
@@ -11360,7 +11331,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	int err, kfunc_class = IRQ_NATIVE_KFUNC;
+	int err, spi, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
@@ -11401,9 +11372,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 			return err;
 		}
 
-		err = mark_irq_flag_read(env, reg);
-		if (err)
-			return err;
+		spi = irq_flag_get_spi(env, reg);
+		if (spi < 0)
+			return spi;
+
+		mark_stack_slots_scratched(env, spi, 1);
 
 		err = unmark_stack_slot_irq_flag(env, reg, kfunc_class);
 		if (err)
-- 
2.53.0-Meta

