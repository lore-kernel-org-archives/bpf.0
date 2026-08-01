Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA23B0AE8
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570417; cv=none; b=ru5OKwQ2QAfxGMatA0Hj+HupW/pCQSQ+Akwja8mmFC13AQ/iZUi8zlgrofTo+VrdWujmJDW1IjW6AjxSKCuzFaOqmn4+wduniHv+kq+8s1S1D6flb/Rf/B1UtYoDeZq1kLUpIcTXGMB+8XOCW45wMxvkv82hRN70+GQuuLQqO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570417; c=relaxed/simple;
	bh=NPNzu2b558DMETvcB2Nv5gutAF6fnWDH7nKGV1lr6QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itDCaZVpLJMffryfDTqrlm3VK2W74jyfbPG6VsCLMJeim9QN43zAi2uBEfjLDkldBEJGbJDN9/YGhLC9mAWXa/1me+HfeZUQFF+p39yF5AaPv0nuoegk1lL7bXsi39apsquxzk7bShnOWWhfAsS3VQS+mzTE7EIrX9qnkhy5AIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbsvvkB3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbsvvkB3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1635425a91.3
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570415; x=1786175215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dNwHicW0Nhf1/b5JeCXNjvtk1pjP98QA1gRKTXP3OkA=;
        b=YbsvvkB38kvIdpManQSZcBkDOz4ywmxIJMtsxrsa9ZrpTJX7oz3GY97+DfQMmoinPb
         pRadofDkrNtPvLgrlXgMnfYzkjGkbpJ4xpxSZsEfRdlGDX+k85i9g6wEXSRUj/hHKtqW
         vsZ9iETUDXGmU4mpCRPP3TwUkXR/W5bCbSUtSTvTLeX5SqhhhL/zIIsGIeg9JL2vz+v/
         aOAKBYq5Fz6pbpcsWlUDQrCX82Sy98HGzem4sXHIm8rOpiOsOGQlXgJSaVj8TRMJL7f+
         dFidH/UAnywRt2Hl88RUbxhYP5Ep/EvJCmYpTP3UYONQXm0z6Uo09hgL5kZvW27HpSzt
         FgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570415; x=1786175215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNwHicW0Nhf1/b5JeCXNjvtk1pjP98QA1gRKTXP3OkA=;
        b=qsqluOlkwW8VuYqx+UXOF/5euyXuavSiS9dW4yZL9fOnEcS9AY/QVvngro/88PnaAR
         nj1x/E5UdACtrrZgt96kVEmsaz7gRrPyp25MrB0py7IDRcB1vavuzJhiHK6eT//QWsJW
         vk+EC/LNmJinYCfvfT19/87734DcSLxF501q4sG+5rC9UxGz5GhtGWkSXVKk3IH85Q35
         7Urdxh9lcHcjbokCdtzVa/VfMf/li/TTSJ2iBt4qbzQb/lVJxdtx4DhZnMGVBEC3lkbk
         WAk+GxzYT8BKX83QG01Whm3+9OOsvW4LM3UuBZZC2xSRq39kHx/9ZbOOhhff8AqcIeDU
         uMgA==
X-Gm-Message-State: AOJu0YzFzRy7a7osLrxkmHjrVUSDx5F5Mras+I6OzbHIRUkyAhUeOz0b
	YG39Oc36Ton5Jy9BcSSlR1dxgXn7ObLowpOz4U44OZAvFqoCdjnS3M+s0IT/4A==
X-Gm-Gg: AR+sD10WEvk4kkZqfdTXAwfWjlstEF+Tjic/PvKuH1d8wXaraXl4KrV/rNDitucZBKH
	dLf0AgEBHnUNi9jXj4vLDTrUbgZW96gOk5wgg39yoKyg+n37ghJGezAlOj6hpnkkVqMbcVIdJA4
	D885wP/22mLL8XLgXs7DDov8AcmzMXSqZksSMQThjWY/8orkylZEJUkc7/fjlQ5W48pEnhR+hY4
	eobDnRTI6Q9AVBaGAMYClroZQZLQM6uaTqzA4Lm0DijYNefCM3dzq/6YIczxtxfSqmaa/KoZmuG
	mB+tEez3+HbZ8Yn6lVcZGhdV32Egz66An88UTd3RGkUuHeB+bkQZPI2K+7ivFN1/aYgwZCts7XP
	jcjkvGa31NX5p6nG0mjziVuzDjlxBxsm8iK8vcFbiqCnq5b/pGV7w8UPyVdgmMB3smpvu65ZMER
	qd0EzlJkMV22CeGPFDQvB16oTjU8ygtqNoTTbYMuOMfHHcqyDGTRK6JB9qBLQdX+Q=
X-Received: by 2002:a17:90a:dfc4:b0:38e:7268:220d with SMTP id 98e67ed59e1d1-38fbc4cb98amr2558884a91.20.1785570415400;
        Sat, 01 Aug 2026 00:46:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30e381esm1620318a91.15.2026.08.01.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:54 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 12/18] bpf: Classify kfunc mem_size args from BTF without register state
Date: Sat,  1 Aug 2026 00:46:27 -0700
Message-ID: <20260801074633.1595644-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() already makes sure a scalar value is passed to a
scalar kfunc argument. Drop the check in is_kfunc_arg_mem_size() and
is_kfunc_arg_const_mem_size() to further decouple
get_kfunc_ptr_arg_type() from register state (a prerequisite for
generating a helper-like prototype from kfunc's BTF).

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8ce9b8c99e1..789d4e729457 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10785,26 +10785,24 @@ static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta)
 }
 
 static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+				  const struct btf_param *arg)
 {
 	const struct btf_type *t;
 
 	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+	if (!btf_type_is_scalar(t))
 		return false;
 
 	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
 static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
-					const struct btf_param *arg,
-					const struct bpf_reg_state *reg)
+					const struct btf_param *arg)
 {
 	const struct btf_type *t;
 
 	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+	if (!btf_type_is_scalar(t))
 		return false;
 
 	return btf_param_match_suffix(btf, arg, "__szk");
@@ -11338,7 +11336,7 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 }
 
 static enum kfunc_ptr_arg_type
-get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *caller,
+get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
@@ -11352,8 +11350,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
 		return KF_ARG_PTR_TO_CTX;
 
 	if (arg + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1], get_func_arg_reg(caller, regs, arg + 1)) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1], get_func_arg_reg(caller, regs, arg + 1))))
+	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
 		arg_mem_size = true;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -12084,7 +12082,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			}
 
 			if (is_kfunc_arg_constant(meta->btf, &args[i]) ||
-			    is_kfunc_arg_const_mem_size(meta->btf, &args[i], reg)) {
+			    is_kfunc_arg_const_mem_size(meta->btf, &args[i])) {
 				ret = process_const_arg(env, reg, argno, meta);
 				if (ret < 0)
 					return ret;
@@ -12129,7 +12127,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, caller, regs, meta, t, ref_t, ref_tname,
+		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
-- 
2.52.0

