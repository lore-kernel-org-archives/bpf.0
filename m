Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD01340A6A
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214416; cv=none; b=KDbkWF0S7As3B25QSJUDN3PnfLrNnAMIURmqXR1gwhIkMWkOc+Kdn938adnuhRKTpYfJupUegFKHkQTEDDxATggg6tHosjeKHl8CSFXzkdFn/vj0Klyjv6leLF4nkYNCzrR4FyelMeg9h9mbmKTA450kMHa+0WKRjoTI7hiHxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214416; c=relaxed/simple;
	bh=CbH0GQGnrqtdv+IXNXwA+lMpTJgcvOCY20p6I9jjt2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LY6sKAzBkLyM9N9oVfm/oz9vF0WSwN6ah9mYwtGxBN3AMf4Yyvv9m+I7RVZZCShn1vtkxGtCM4JbD9BCOgXklxLzQd/HPLKg3r93Yrw4DBLazM25TnYkowik+6TWzUGF/snIGmfgs6As5OY3mjjtUCtKErwb62TQzLuq4s3MANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuv4Hmr4; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuv4Hmr4"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65dead17c24so3671281d50.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214412; x=1779819212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0yAWHTYUvXRF9uWUqsfdJogZ4AYkoOMfCE+mxoxLKA=;
        b=Zuv4Hmr4pluZhDh4pnJA1IIVWXSWfw+GPIXOIPHErZgKRq2PAvSuj6JHJWohBNk/mO
         loCTjvNTcqpAgbKhJEaM5m+IVYxVlj7gR/APuMcCuO6mPWY/PEkXKYIHoosX4LzKzwch
         Zk0AXQ/QxFIyxyCZoeSeD8TBFeLhkO0AN9Uo3hd7Po3Sp/F0nlo4wkOGCHyqoeSO/21h
         847DouI+zyzE0SAbrbJPGNNjlmwpRlAaWzbmB5ndXR5AtocvxHr1jq8CeBCENcff4kLe
         0ejTL5E0bRpGXthZs6EEhw4X71H2nGp7F9qrf31wNETyf8zHhf49kiabRI3e/+Ji3hJO
         ux7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214412; x=1779819212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0yAWHTYUvXRF9uWUqsfdJogZ4AYkoOMfCE+mxoxLKA=;
        b=UfsHHHCYXWeOTyNySDs40bUn2taY45XbI9OPh8Gv+wokrAVKPnfkxGp6ZPsw2LwCuL
         +h2buwZTNtEfb2eCtveWM1YfFJM44902YJnk752rMzHSEgvMSVB58Q/rPoqTTi6fG+eQ
         4d/g3qVvmkaHiWHzPJpjFKmwUygOrkD2UwrYXGozVBfjuz2uw8AzScMq2oCz6L7WTMwl
         0o0T1Z7h6dZZAYR8KDmrceu18pzLyo0twZePVuRaNb9Sa2HGYiQ6WAqoIctgUeRh5rox
         Z2X2KDlrxLlL4+Qc1g6VXi+1YDkYu+594V8wZLfQQGqMgUDipv1RSdhglwwa2X2Cf7Ed
         32gw==
X-Gm-Message-State: AOJu0YxeLc0kynCknYuPG4gEx3uU96YnaX3x+qZgPVuuVrNrZVmWijIe
	PcsqkC40IUYbZxuIm613GnA/swP8WKZeXKfu9UgCY+y59thxmVJLyjGn9mEDxbiS
X-Gm-Gg: Acq92OEx1bSZ1r5AIfS2cslP4++5HffdRauvaBLkFdxG6OA4CsGCXizGjqmm32NxTGq
	6i62a7DveniKOEMZDkH5rXwa7ut4nwQWyXr01F168eySqEyeOMaReRJD5o/h61301/9jHM1Q4z5
	fdVfR/Q11y6Uq/nM79T6A3IgTJn8k3G/enD4zLTdSb9TlM2pz/056fZcCVQFP3M5uzTTcrVTocE
	xGNZ/7Vi1zkRYSyEyf3IKPc3sgvuvVAgJfKJo2vLwR/A/SsQ4Eqx2XC0cut+CRaltMUvgj+inYO
	V+Y0ArD9ar8Kmvx9pwXrrQBe9PLx6+viSYTf9oVqJsAt1Fthh3xkHzJ9/yl9ub397RbWqWi0DRG
	DJbxgBes+Yo7qAIpZk74D5rz33fia/xJoakxob3vSA3zxyUFMrPWRMOH55o996GGm3XQl+gws3s
	58th84iuliVyxbL9mKY3Rpg3nEPLY=
X-Received: by 2002:a53:c043:0:10b0:654:5120:60aa with SMTP id 956f58d0204a3-65e228060a4mr16888047d50.45.1779214411475;
        Tue, 19 May 2026 11:13:31 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:51::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbd101asm8138986d50.19.2026.05.19.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan all call frames
Date: Tue, 19 May 2026 11:13:08 -0700
Message-ID: <20260519181314.2731658-11-ameryhung@gmail.com>
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

When checking whether a referenced dynptr can be overwritten,
destroy_if_dynptr_stack_slot only counted sibling dynptrs in the
current call frame. If a clone sharing the same virtual ref parent
existed in a different frame (e.g., passed to a subprog), it would
not be counted, causing the verifier to incorrectly reject the
overwrite with "cannot overwrite referenced dynptr".

Fix by extracting the counting into dynptr_ref_cnt() which uses
bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across
all call frames.

Fixes: 017f5c4ef73c ("bpf: Allow overwriting referenced dynptr when refcnt > 1")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 52 +++++++++++--------
 .../selftests/bpf/progs/wakeup_source_fail.c  |  2 +-
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b7984c42ca14..97eb8033d732 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -786,10 +786,29 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
 		__mark_reg_unknown(env, reg);
 }
 
+static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
+{
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	int ref_cnt = 0;
+
+	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, 1 << STACK_DYNPTR, ({
+		if (!stack || stack->slot_type[0] != STACK_DYNPTR)
+			continue;
+		if (!stack->spilled_ptr.dynptr.first_slot)
+			continue;
+		if (stack->spilled_ptr.parent_id == v_parent_id)
+			ref_cnt++;
+	}));
+
+	return ref_cnt;
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
-	int i, err = 0;
+	int err = 0;
 
 	/* We always ensure that STACK_DYNPTR is never set partially,
 	 * hence just checking for slot_type[0] is enough. This is
@@ -803,28 +822,15 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
 		spi = spi + 1;
 
-	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type)) {
-		int v_parent_id = state->stack[spi].spilled_ptr.parent_id;
-		int ref_cnt = 0;
-
-		/*
-		 * A referenced dynptr can be overwritten only if there is at
-		 * least one other dynptr sharing the same virtual ref parent,
-		 * ensuring the reference can still be properly released.
-		 */
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-			if (state->stack[i].slot_type[0] != STACK_DYNPTR)
-				continue;
-			if (!state->stack[i].spilled_ptr.dynptr.first_slot)
-				continue;
-			if (state->stack[i].spilled_ptr.parent_id == v_parent_id)
-				ref_cnt++;
-		}
-
-		if (ref_cnt <= 1) {
-			verbose(env, "cannot overwrite referenced dynptr\n");
-			return -EINVAL;
-		}
+	/*
+	 * A referenced dynptr can be overwritten only if there is at
+	 * least one other dynptr sharing the same virtual ref parent,
+	 * ensuring the reference can still be properly released.
+	 */
+	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
+	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
+		verbose(env, "cannot overwrite referenced dynptr\n");
+		return -EINVAL;
 	}
 
 	/* Invalidate the dynptr and any derived slices */
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
index b8bbb61d4d4e..d4d0f1610853 100644
--- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
@@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
 }
 
 SEC("syscall")
-__failure __msg("type=scalar expected=fp")
+__failure __msg("release kfunc bpf_wakeup_sources_read_unlock expects referenced PTR_TO_BTF_ID passed to R1")
 int wakeup_source_unlock_no_lock(void *ctx)
 {
 	struct bpf_ws_lock *lock = (void *)0x1;
-- 
2.53.0-Meta

