Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF53B14C7
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570425; cv=none; b=iXbkRYrGnOBg1iACvCVmwFUBVtll/DTC7tfcerKsbd3MFQjuDellAiD/WPjgioGiGF+k28513os2xyBM+VySgRthdrvDnrbCMQLcQWJcEw3FwCAwTeRxTWIQw+5H8brFKoGwfcyp96ekVNoTj5d8IeQKdO6EALYi7HtnVWAv3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570425; c=relaxed/simple;
	bh=ZySS57QqbHW3bQmQfU1iiWvB5qrhl71shftT5Btuyr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YusMiJ3N4O8PovBXd1ZO/BVZtAA9smbJtPe9VOaOJ7Qw/rvEuUu/4Yl648XfxUCfPvw0zov25+k0QNArW4EpdDSKkg29Dzxzf0vY2uE3dvubBFIAFeoSZRMzcrSgM138+T6TPA9URxudmVR4ruYBkh69JvJTwO1syCpBwcF+9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2LWDulh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2LWDulh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848643382fcso1668265b3a.1
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570423; x=1786175223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cxu2dOSv4Uy/FS3JwPLX2VK8+semk1q4BKIbBa//uxk=;
        b=Z2LWDulhiGfJb/D0ojg4KTPUhxVHFqVyJFvpPlXztgbw7Fn45pAhNo/ktq9u8H7eMo
         0aGatm+B8AeUiAaqye4arEvJDWEuU5LFLGYmfPiW08nkzBWFgdc91CQu0c5azmFndcWv
         AwuKpLo4RSBqwfBq5HoD3i6avicN4PneyvF3CFkCDTK2IzcY9iQYMjbT0lS4lwfuqFb/
         ESHaur35uQC3dYlinL7aDI4FOtvyQdNJ/TtawoJyZubnV4wBcMXc29hPg9SSyC+Phv+a
         FzSeewG9NMlIlHqeQEhfbKQZofzJxvjwQkNohATPsjguPP1zvRf6XT3t0UTLRzKP6cu2
         w0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570423; x=1786175223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxu2dOSv4Uy/FS3JwPLX2VK8+semk1q4BKIbBa//uxk=;
        b=UVUr0/FEVJOXcFUuC7ZItPsrog86OYWi7ZhvvD/cBJnvae73gfRfdE8tQuhDTLgToa
         md0g9hf/cRpvW0hv11jq6k1T2X95dz7N+gEgybcJz4IxG2ziD+/WRB8SUYbABAhzc/r3
         D4SDO6BRcUUAdNoLMMmYgpC7VJMsRMpUISIAJbNsesrdi7AndLXGgjqsKrH/JPgv7o14
         2rjXqLymMv1K4mtY0qhMH9PbFoo0ZB405pykmNmFjmx+KP23O1WRAQheL18LbPxPT1qw
         jaEPADViVIAWxzonZoLrPrxMGLXjmi20a93Jpx4Xab8EUSmoZt+u3YacYFVUzW670nUC
         2hjQ==
X-Gm-Message-State: AOJu0Yx4O1WkWrITiOeGAgeGtzfqyd92KTC9bv0XnCusFUugCUfHzfyU
	9S7o6E1HKi5E+K/i06z/ye21e3pqeHWHddkXnga/nkafO4/nKllr0NX15I9N7Q==
X-Gm-Gg: AR+sD122oIqoweqRD+9Nx6f4YdK7im3QyS0dm8oTaY7A8rY6N3Nwvg3FpOFk3lWjk+n
	yEqjnParcCNLOPM4hzDU11MwtC4pan1IbKmYtFWjbUkNMDL6wgoATcW9km+1sxRMNoCjIkC0bi4
	SuAxDodgx9SSkjH2JH1Bkpo+j/nE4YVZc9nuX0eZYvdtgXDkk6yNDh/WZxJZYZVbccW5iHNCC9H
	swYgNdNBgNAEW/2JVJPzgNGPokqXNTQUxLStX7PGQ2b78NKC+a5dZoBALeC4ELsdCvGrPzFKd8x
	fK/EsEyM75GtE7ndJq7K/WcsgkJ8Ar227JCeHScmUSlN1Jy0zGQW9vtaQ2zyoBXF0I6Wtsdf2Js
	GMUXTpbEslJEnF81rpKuKj6T1b6dwOIFAhSr07rfYQS7X+JhCnyu6HaIA0DXHsvDiOHoIRI1nqV
	SAhGkZlAHp1Hmeks9ve+nZ3UWW5ytqE6JPy4hgthtG+EdCyJHPZGowDcJJfqgh
X-Received: by 2002:a05:6a00:2e89:b0:84a:6726:62f9 with SMTP id d2e1a72fcca58-84ee4790f99mr2012441b3a.9.1785570423055;
        Sat, 01 Aug 2026 00:47:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd35a6asm1437634b3a.12.2026.08.01.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:47:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 17/18] bpf: Classify scalar kfunc arguments from BTF
Date: Sat,  1 Aug 2026 00:46:32 -0700
Message-ID: <20260801074633.1595644-18-ameryhung@gmail.com>
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

Add kfunc scalar argument types, classify them in get_kfunc_arg_type()
along side with pointer arguments and move scalar type verification
into the main switch in check_kfunc_args(). This keeps BTF-based
classification separate from register validation for every argument,
paving the way for generating the kfunc argument prototype at add-call
time. No functional change intended.

KF_ARG_MEM_SIZE and KF_ARG_CONST_MEM_SIZE now are reachable. Therefore,
remove the fallthrough from KF_ARG_PTR_TO_MEM case and adjust the
register indexing.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 141 +++++++++++-------
 .../testing/selftests/bpf/progs/dynptr_fail.c |   2 +-
 2 files changed, 92 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e3759f7ba68..f9e32dbd9358 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11073,6 +11073,9 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 enum kfunc_ptr_arg_type {
 	KF_ARG_CONST_MEM_SIZE,
 	KF_ARG_MEM_SIZE,
+	KF_ARG_CONST,
+	KF_ARG_CONST_ALLOC_SIZE_OR_ZERO,
+	KF_ARG_ANYTHING,
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
 	KF_ARG_PTR_TO_REFCOUNTED_KPTR, /* Refcounted local kptr */
@@ -11348,13 +11351,39 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 }
 
 static int
-get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-		       const struct btf_type *t, const struct btf_type *ref_t,
-		       const char *ref_tname, const struct btf_param *args,
-		       int arg, int nargs, argno_t argno)
+get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+		   const struct btf_param *args, int arg, int nargs)
 {
+	const struct btf_type *t, *ref_t = NULL;
+	argno_t argno = argno_from_arg(arg + 1);
+	const char *ref_tname = NULL;
 	int arg_type;
 
+	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
+
+	/* Scalar arguments are classified from their BTF suffix/name alone. */
+	if (btf_type_is_scalar(t)) {
+		if (is_kfunc_arg_constant(meta->btf, &args[arg]))
+			return KF_ARG_CONST;
+		if (is_kfunc_arg_const_mem_size(meta->btf, &args[arg]))
+			return KF_ARG_CONST_MEM_SIZE;
+		if (is_kfunc_arg_mem_size(meta->btf, &args[arg]))
+			return KF_ARG_MEM_SIZE;
+		if (is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdonly_buf_size") ||
+		    is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdwr_buf_size"))
+			return KF_ARG_CONST_ALLOC_SIZE_OR_ZERO;
+		return KF_ARG_ANYTHING;
+	}
+
+	if (!btf_type_is_ptr(t)) {
+		verbose(env, "Unrecognized %s type %s\n",
+			reg_arg_name(env, argno), btf_type_str(t));
+		return -EINVAL;
+	}
+
+	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
+	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
+
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -12043,7 +12072,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
 		u32 ref_id, type_size;
-		bool is_ret_buf_sz = false;
 		int kf_arg_type;
 
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
@@ -12067,39 +12095,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
-		if (btf_type_is_scalar(t)) {
-			if (reg->type != SCALAR_VALUE) {
-				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-
-			if (is_kfunc_arg_constant(meta->btf, &args[i]) ||
-			    is_kfunc_arg_const_mem_size(meta->btf, &args[i])) {
-				ret = process_const_arg(env, reg, argno, meta);
-				if (ret < 0)
-					return ret;
-			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
-				meta->r0_rdonly = true;
-				is_ret_buf_sz = true;
-			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
-				is_ret_buf_sz = true;
-			}
-
-			if (is_ret_buf_sz) {
-				ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
-				if (ret < 0)
-					return ret;
-			}
-			continue;
-		}
-
-		if (!btf_type_is_ptr(t)) {
-			verbose(env, "Unrecognized %s type %s\n",
-				reg_arg_name(env, argno), btf_type_str(t));
-			return -EINVAL;
-		}
-
-		if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
+		if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
@@ -12116,11 +12112,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
-		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
-		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		if (btf_type_is_ptr(t)) {
+			ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		}
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
-						     args, i, nargs, argno);
+		kf_arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12134,6 +12131,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		}
 
 		switch (base_type(kf_arg_type)) {
+		case KF_ARG_CONST:
+		case KF_ARG_CONST_MEM_SIZE:
+		case KF_ARG_MEM_SIZE:
+		case KF_ARG_ANYTHING:
+		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 		case KF_ARG_CONST_MAP_PTR:
@@ -12174,6 +12176,34 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			return ret;
 
 		switch (base_type(kf_arg_type)) {
+		case KF_ARG_CONST:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+
+			ret = process_const_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_ANYTHING:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			break;
+		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+
+			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size"))
+				meta->r0_rdonly = true;
+			ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
@@ -12407,22 +12437,33 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE, meta);
 				if (ret < 0)
 					return ret;
-				break;
 			}
-			fallthrough;
+			break;
 		case KF_ARG_CONST_MEM_SIZE:
+			ret = process_const_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
+			fallthrough;
 		case KF_ARG_MEM_SIZE:
 		{
-			struct bpf_reg_state *buff_reg = reg;
-			struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
-			argno_t next_argno = argno_from_arg(i + 2);
+			struct bpf_reg_state *buff_reg = get_func_arg_reg(caller, regs, i - 1);
+			struct bpf_reg_state *size_reg = reg;
+			argno_t buff_argno = argno_from_arg(i);
 
-			ret = check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno,
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+
+			if (bpf_register_is_null(buff_reg))
+				break;
+
+			ret = check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
 						 BPF_READ | BPF_WRITE, true, meta);
 			if (ret < 0) {
-				verbose(env, "%s and ", reg_arg_name(env, argno));
+				verbose(env, "%s and ", reg_arg_name(env, buff_argno));
 				verbose(env, "%s memory, len pair leads to invalid memory access\n",
-					reg_arg_name(env, next_argno));
+					reg_arg_name(env, argno));
 				return ret;
 			}
 			break;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 94489ac64da8..340bd7db79f0 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1589,7 +1589,7 @@ int xdp_invalid_ctx(void *ctx)
 __u32 hdr_size = sizeof(struct ethhdr);
 /* Can't pass in variable-sized len to bpf_dynptr_slice */
 SEC("?tc")
-__failure __msg("unbounded memory access")
+__failure __msg("must be a known constant")
 int dynptr_slice_var_len1(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
-- 
2.52.0

