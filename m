Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985B2BE02C
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920105; cv=none; b=EWhTEUI03wiu9EL31aoE6bu4WhrDTQYKEYSfXI5idR9UTMEf0MsI6A1N8EOl/mQ0aYzbnSOZ2rg8Ap8w2aZ+9p+S1+7Lhtt52h9/gl6cpstgCz3bx9pylB/WbXR6jBfNxCq1Ucj1SWTjWzmV3kyN4mhEAik27DAD5uYSHzHz4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920105; c=relaxed/simple;
	bh=TBD72ZEvOFPtcgZ5rmYsYqiGzqDgl7YyPmqcQwYMoOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKMgkQd415kf3/hpa6ezNM7oZOvZmx0ny1PewJbGUKVLlZ5/Z4LkVYBm466wzELLGlX8YKpu7jAincAR3yK03Omru/nIi2CSisQN5jIGb1jE1sO/xWTFpR/PnUku6Cpka5ziBctHE19fAVlpnATwhr5zW+y/LvAo7pYDEKqLPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NreEZxhY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NreEZxhY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cee9b74ee1so7023765ad.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920103; x=1785524903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8m7ZE+8SaCc8NmIPI46I/FUo+b2Crk527bnEkYCNrnE=;
        b=NreEZxhYR7bW5EEqKNjmBhbHpOz5mHIiS5FnRnstpf1nL947KovMAWNpA9z3qA/sX4
         S4n6VhRZqc5BDV/Gyv4gbjIHjR3qR8MlNbA63Odg4s2oBS7K4pBGpokeMk/eGYZg7dOV
         O5eY3S9UnPcXByJfWUcw5u0ZGpilhw2VjbeoBUS06sqf9iZK/wKL0Pz6cszXa9Hr8TNn
         KsEvfBULFdewhDaYf9oPlEKdWlLX3dpy3axxoZMuCmN1VJkT+1AM6Ou0qGNOu/A9X+Mt
         hwpYO2WvvRPE7gdKIfz6KZV7+QXciDETwGS5Cxi43rBaBbDvE1CAE++Z98hROcRwrUXW
         blXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920103; x=1785524903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8m7ZE+8SaCc8NmIPI46I/FUo+b2Crk527bnEkYCNrnE=;
        b=eSYJMelbEc84mXfIpHLBA/tXj1q0OHOZFllqWl0FN/0PNGLXald1PqjZclRBBYYajr
         m/G10ZRhtTWIb/EpXg4VBbBLs6dLuHqud2SrXVPh9loBoOvms1MfXJN+K5uW4XkFlJDj
         gTtZND2dQPu0p7qh79LDGFoleTwUSniXoXGO1BXCFMJHuwDJs1X6iumW9pOcycRMhQAI
         SUYBuzoxuDBKXCzy7wj28XEsxb7vILiJ6cs2HDWd9rWszA1dWwLr9QBzkp/aEfJZq6iY
         xZOqYuxwH0/5MVh0d3s90fCctPuh755IZfLyCbKPHoMvdjusX9RdE6IEFM/7dfCTx8JJ
         ss+w==
X-Gm-Message-State: AOJu0Yw+vQvjJ69T1iMd0FGvRMHbO3R8SyUpuA9QijpNauI6rMVS11//
	uu8v7Q3pl7NcBoVwg9hCXWII7iOq4W+xe7PoaN9ATalGR3ztgYjUNm4MpNSzkA==
X-Gm-Gg: AR+sD131/yQUzO9dW3vRzQ0eOz2IKr09Xx736pTm7aBgbz3qiZoreZG6aZAIaWrUZx0
	+Fd428yYHK2JjNWk53Zb6zepqJNMVatbwYwtL8ymrp1EBnql7u0s4wyGSchD2WwdZ/oA/wVUqSe
	6HuyxROO+v9d+P/F/NTztQmTF5qW74pXQjUDQN4KEJfeNi7BCDXcZAoF18vZqPi/pJc/hAUAqeU
	Uo+Omn4PyiG+m0Q/InqlCGeFDwxG3CsoAt/tRn6Ff6QCmNmUBNqOSoOXV3UQX+ECUIz/sqJJ5eo
	yaSdlTlWm2mOn6LiLJUTfakUs4adyltp/l+CAS4fQxRjNE9NG9esNOFqfmy8y4leN8XRUOi+YUr
	k5yICP1mghgjNLCM7PV/JM8K0A2qT9dAE76oJWY2tXkfzxgbfxQj0ajqlXLQvsLeXFI6t
X-Received: by 2002:a17:902:f606:b0:2ca:5a42:d8c5 with SMTP id d9443c01a7336-2cfa74df87dmr93431105ad.46.1784920103280;
        Fri, 24 Jul 2026 12:08:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm56701035ad.22.2026.07.24.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/18] bpf: Express ARG_CONST_SIZE_OR_ZERO as ARG_CONST_SIZE | SCALAR_MAYBE_ZERO
Date: Fri, 24 Jul 2026 12:08:02 -0700
Message-ID: <20260724190813.1458271-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SCALAR_MAYBE_ZERO as an alias of PTR_MAYBE_NULL for scalar size
arguments, and define ARG_CONST_SIZE_OR_ZERO as ARG_CONST_SIZE |
SCALAR_MAYBE_ZERO instead of a distinct base type. This lets
check_func_arg() handle both with a single ARG_CONST_SIZE case, and the
redundant compatible_reg_types[] entry is dropped.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   |  4 +++-
 kernel/bpf/verifier.c | 12 ++----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e066f44a9c05..1d537ec557ec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -748,6 +748,7 @@ extern const struct bpf_map_ops bpf_map_offload_ops;
 enum bpf_type_flag {
 	/* PTR may be NULL. */
 	PTR_MAYBE_NULL		= BIT(0 + BPF_BASE_TYPE_BITS),
+	SCALAR_MAYBE_ZERO	= PTR_MAYBE_NULL,
 
 	/* MEM is read-only. When applied on bpf_arg, it indicates the arg is
 	 * compatible with both mutable and immutable memory.
@@ -889,7 +890,6 @@ enum bpf_arg_type {
 	ARG_PTR_TO_ARENA,
 
 	ARG_CONST_SIZE,		/* number of bytes accessed from memory */
-	ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
 
 	ARG_PTR_TO_CTX,		/* pointer to context */
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
@@ -922,6 +922,8 @@ enum bpf_arg_type {
 	ARG_PTR_TO_UNINIT_MEM		= MEM_UNINIT | MEM_WRITE | ARG_PTR_TO_MEM,
 	/* Pointer to valid memory of size known at compile time. */
 	ARG_PTR_TO_FIXED_SIZE_MEM	= MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
+	/* Number of bytes accessed from memory, or 0. */
+	ARG_CONST_SIZE_OR_ZERO		= SCALAR_MAYBE_ZERO | ARG_CONST_SIZE,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4606294e444a..cd77aacad34f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7724,8 +7724,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
-	return type == ARG_CONST_SIZE ||
-	       type == ARG_CONST_SIZE_OR_ZERO;
+	return base_type(type) == ARG_CONST_SIZE;
 }
 
 static bool arg_type_is_raw_mem(enum bpf_arg_type type)
@@ -7872,7 +7871,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &mem_types,
 	[ARG_PTR_TO_MAP_VALUE]		= &mem_types,
 	[ARG_CONST_SIZE]		= &scalar_types,
-	[ARG_CONST_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
 	[ARG_PTR_TO_CTX]		= &context_types,
@@ -8494,13 +8492,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
 					 argno_from_reg(regno - 1), argno,
 					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
-					 false, meta);
-		break;
-	case ARG_CONST_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
-					 argno_from_reg(regno - 1), argno,
-					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
-					 true, meta);
+					 arg_type & SCALAR_MAYBE_ZERO, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, &meta->ref_obj,
-- 
2.52.0

