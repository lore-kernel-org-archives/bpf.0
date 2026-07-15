Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E0313E24
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097658; cv=none; b=Lzm2hMOzoS+mo5UhFR2qAcMHQqbssBywfEAFjxIo1y8lw+E22Z9rwA3jwLAMjjjaf6+AXMVYs3s3LyKjlyM78dCHmEDnRYS7BHHNgZW5kVqaeLj0UnpyqvSIHWNniaXjsMT0iYjpzEu/yoKZ8SdBCrmD4bYCxhMOwD3mB12542g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097658; c=relaxed/simple;
	bh=Kk4NWVMEdFLEKDY8CezwCvHz7ZwMW6AqS6vsWY7E16g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+C98Cd88x8OKrL+eP7uKP+LRrqFD0Cd1FSom2gZYqlDQk7pZexbECdLVln87lehtY0N3OY4+1uc7ibK4tVGLfBEDsybGuj6v1Mr346wPzkMPv1A9JhOWR1PbESAq75PeFgq3KZY59UlVI9RGJRghju2l3GM6CEtcFa0NDJkdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODPx1d7o; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODPx1d7o"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb4d532e65so1968287a34.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097656; x=1784702456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tkzec5xr9LbROU4VDjYygo3xBUWzxkeSZ74K5HvHcg=;
        b=ODPx1d7oqEUvIJ8j6cTxSIUZSa6QqCIk3PT6UL8uHyLCd9OcimMu2NNdI4Smuj82eP
         VccKpdJZ2v9ijOCrfVLggq7fohf5xtje6nqkuTYrqa8ECLCeOhXsnKTMWrAtfEzw8KPD
         oTiRk0HIihJbVro7wvdoQLoQlmDYDmJ3IP0p7YEwLy2kUKv38h+WKkLI923AAoUbywev
         nBNLz3w1stgwGgLaN79dCgPUbtNogjvWkOSlKDt5RNlMmHRPxOZQIJPqrZMzVvrZzCxv
         NlTc4bu92DL/k2y8HA2+IJY6GeG13pLRMdT33bswhbg1yRMp58ltto4JBUhCmW4RgPEm
         cDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097656; x=1784702456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8tkzec5xr9LbROU4VDjYygo3xBUWzxkeSZ74K5HvHcg=;
        b=J9mAJrBNWm+iPFuca0JZjH9g2cUBD5TrjXUkVi5jjZO5p8Xqj1vNmdmlKDMPvYyIBB
         tceq1tw+Baur6bSJdBfeE//56KSI4vAr8lsd3jY26AgaY/0IbiLeL0u75rCx/e9oNfxb
         eVuy/LU8AbZ0Yhep16Kk7nSINTxsGoXN8VJloYBls5G9tQJQ+NPVP7VOUpPJZYPGzBXH
         +QzXsQGOE0zK6NUAzJg83JXkHByq9rbV5LcmA3FM+MoYQmFqjKjz3tj3wkauTxLjiIkA
         Xdb1snnrn67w0WMW2TluRM7zvNIT/NIGQKbCSMEP0631w/ZyP2PCJfRjewrjLHtvdpGW
         +WUw==
X-Gm-Message-State: AOJu0YxLbyVRZEc/mwkdn9BAXB/+Pc7bRYv692YJHzhnP3sO4xSd5ZoC
	uu5KYxC4uPDH1eLUmDhmpuHzKF2ILhvY1LohlyqrzW/CETjPucHHZAA1a6g7RA==
X-Gm-Gg: AfdE7clES3NwyrMIsKxCElCVF5lsSbb3RizZW5x0IxKoqumm/ZyEJdLDGhWR++DJymp
	2pmB2XyRqys9bp9Bq3EGJufhZEmxSJBzvD6YlIIjsPeAGEIeHmzYFX5JaMQJCBVhSnEqRiFsns1
	vqfeG6xOA5SZ4THn6+12FZPeNbKXeivVlXMMEmcR/jePn4h74t6PS3C9FeWIcYf/hqTbIS9ic+w
	inf3YmGRdFKg0tuhmTTF4qcUQ4Rj0noelw0K2JgMMmW4YOrcg04Kk/PwQcMVUGWLbCL8R9g/vqg
	qPXVZtVdKvaiob1D+uq3Zu0sBgx7fjkyAhmtHOZcwWCqmRfZ3CIEa9gS7A6tHSaLhhTpwgRoI4J
	Yf5vREVgPDMvW0mTc01nq7cPbGUzGQ65NMWiWqW4a1yWJoaHMYpnguzTP+q0UejwckpTjlGCWcR
	Wps+TBj2+2yI18
X-Received: by 2002:a05:6820:151b:b0:6a1:50e7:5c13 with SMTP id 006d021491bc7-6a3da09072amr1005735eaf.62.1784097655747;
        Tue, 14 Jul 2026 23:40:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643abdsm18519682fac.11.2026.07.14.23.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:40:55 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/7] bpf: Pass argno to callees in check_func_arg() instead of argno_from_reg(regno)
Date: Tue, 14 Jul 2026 23:40:43 -0700
Message-ID: <20260715064047.1793790-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_func_arg() only ever handles register arguments (the caller
loops over the first MAX_BPF_FUNC_REG_ARGS arguments), so a single
argno_t built from the register number identifies the argument for
every callee. Remove the duplicated argno_from_reg() calls to
simplify check_func_arg().

'regno' is still kept for the few places that need the raw register
number directly (register reads, verbose R%d messages) and for
referring to the neighbouring size/memory argument in the
ARG_CONST_SIZE{,_OR_ZERO} cases.

No functional change intended.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1a41f99a9133..529ad0b4fcbd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8275,7 +8275,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
-	argno_t argno = argno_from_arg(arg + 1);
+	argno_t argno = argno_from_reg(regno);
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	u32 key_size;
@@ -8320,11 +8320,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
-	err = check_reg_type(env, reg, argno_from_reg(regno), arg_type, arg_btf_id, meta);
+	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta);
 	if (err)
 		return err;
 
-	err = check_func_arg_reg_off(env, reg, argno_from_reg(regno), arg_type);
+	err = check_func_arg_reg_off(env, reg, argno, arg_type);
 	if (err)
 		return err;
 
@@ -8381,7 +8381,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EFAULT;
 		}
 		key_size = meta->map.ptr->key_size;
-		err = check_helper_mem_access(env, reg, argno_from_reg(regno), key_size, BPF_READ, false, NULL);
+		err = check_helper_mem_access(env, reg, argno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
 		if (can_elide_value_nullness(meta->map.ptr)) {
@@ -8407,7 +8407,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verifier_bug(env, "invalid map_ptr to access map->value");
 			return -EFAULT;
 		}
-		err = check_helper_mem_access(env, reg, argno_from_reg(regno), meta->map.ptr->value_size,
+		err = check_helper_mem_access(env, reg, argno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta);
 		break;
@@ -8425,11 +8425,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		if (meta->func_id == BPF_FUNC_spin_lock) {
-			err = process_spin_lock(env, reg, argno_from_reg(regno), PROCESS_SPIN_LOCK);
+			err = process_spin_lock(env, reg, argno, PROCESS_SPIN_LOCK);
 			if (err)
 				return err;
 		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			err = process_spin_lock(env, reg, argno_from_reg(regno), 0);
+			err = process_spin_lock(env, reg, argno, 0);
 			if (err)
 				return err;
 		} else {
@@ -8438,7 +8438,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_helper(env, reg, argno_from_reg(regno), meta);
+		err = process_timer_helper(env, reg, argno, meta);
 		if (err)
 			return err;
 		break;
@@ -8450,7 +8450,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * next is_mem_size argument below.
 		 */
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, reg, argno_from_reg(regno), fn->arg_size[arg],
+			err = check_helper_mem_access(env, reg, argno, fn->arg_size[arg],
 						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 						      false, meta);
 			if (err)
@@ -8460,21 +8460,19 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_CONST_SIZE:
-		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg, argno_from_reg(regno - 1),
-					 argno_from_reg(regno),
-					 fn->arg_type[arg - 1] & MEM_WRITE ?
-					 BPF_WRITE : BPF_READ,
+		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
+					 argno_from_reg(regno - 1), argno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					 false, meta);
 		break;
 	case ARG_CONST_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg, argno_from_reg(regno - 1),
-					 argno_from_reg(regno),
-					 fn->arg_type[arg - 1] & MEM_WRITE ?
-					 BPF_WRITE : BPF_READ,
+		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
+					 argno_from_reg(regno - 1), argno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, &meta->ref_obj,
+		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, &meta->ref_obj,
 					  &meta->dynptr);
 		if (err)
 			return err;
@@ -8492,7 +8490,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	case ARG_PTR_TO_CONST_STR:
 	{
-		err = check_arg_const_str(env, reg, argno_from_reg(regno));
+		err = check_arg_const_str(env, reg, argno);
 		if (err)
 			return err;
 		break;
-- 
2.52.0

