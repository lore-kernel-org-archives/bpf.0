Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AA3515CB
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783301; cv=none; b=ATMqVi6oZZtY36+Pavj55FuSm8UGPOvyq8/DTayh0Wf3UtHMJYW7d8HFoXLGUEFxi5WuWN5hg9tk5/RkAeb3Y8PD4jkvn9AKJ8ViBTywsggYuSOsJjrD21Z/NR5J6PzPstGlgp6i+zQo09BYIOoGB4UA02cuR8LbCBGAcTCB0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783301; c=relaxed/simple;
	bh=9EqWJPOKacaN2U/v6mYQcC5LN7ZQt5T8ZTNdpEYD0GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuCTLD1lFB2GJgn7jR/zWpmAoHrYreA0F0qCzD82enyCGkb7tReSiC0f0P/Mjh7OJ0Oxiokzln4ZamtzRzSzzKeqfqXlvBpCtF5qfwE47iMfBZ/X0KEQJ7i6ycB7KYkuPBx90MgkJVCc1lxDczP7qtWVARUulGosKzcGWXn2wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMUs0M51; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMUs0M51"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso2560175ad.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783299; x=1785388099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZymZVgy8nAkDj90hAeYcVpa35LYrvWNE/3bae27YNC8=;
        b=RMUs0M5142dbbRDfpA0BFg73TU7iTtmm2gyUpjMUf9muA7k4FiZ1mrCE7thGM6UFUc
         wMFBkNSTBbgnXwO1XSEzXHxOOPMZytXpAyEBDtPqMZ8r9PMqjhrZlSXNlmGnmwO6NW9V
         +RzWajyaiW46kBiBW+RrPxa79UG9EFMB2ZQyKP/Q3GlOyUfm/TJuS0bYbtEDQfgozFw+
         p8FINTHa3Hj1zmiVPzwKlLt6G9FKqm6kRpum6+xHR1qOFAYGkoWRClSUtq5Oa2I9nCfW
         rNWjqJbXMYJ4lSKfUGs3TvygAl9JtWCGNnyTYPFDNVgVr+j6acDuyWG7QpMOU965OxBW
         u5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783299; x=1785388099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZymZVgy8nAkDj90hAeYcVpa35LYrvWNE/3bae27YNC8=;
        b=q0H1IYqkIUUd7zCginH0a8RUrLOI/G370I1U96LP3NMAtPyRC8aGi6mRCGYbs4gmWD
         rQzYNYSney2Hfy9go9NoBlGtx7cXB5ilWbaAUPJ3BSPdUmfFuBVTp/lo+nTggrm78LfC
         0esQQSCixYl8kDEpgQDXnQzHaoDNAxU6F7jdI7pbi41iO9BNomhvLdLVss5SbG73QzFc
         H7c8C2omGgOdBzWwv55K5zuG/OJta9B6KJygf9WPuI6gif7ushluKDQWSt8qbQs/QWyJ
         GPpLmcUfr9Sye7Zz1yzfFPOlVtOdFLJIo7mmtolWJ84Zn9OL+OXHaXJaBLi6jYXnSO8S
         X2Eg==
X-Gm-Message-State: AOJu0Yxa83rd5dqTfHB6j5urcnGxnW8uWiLhxw9dZLyVq0uqSnL25QiM
	f7x8dnSab4WhECDVN4269HiPvygDvWTDfBJCyprhyD9AFoKlbXiHOcKbiZU1DA==
X-Gm-Gg: AR+sD1318k+Py+21n83gNouCicohxSs/JrWDolXo9RprbO+aGh04dnNHFIN4Cequz1e
	x3aeGtHMdDZx6ysrMsCbKeiTj6t0uVdvt+5OLUZTkUEVBOebSEKUfz8OHDLCGBouomNv4n2um3x
	b1WC/eCvJc8tHZvK3gTgsG1aGixdAGPIkXaEtafsPZiM2qg592I/8A6ZFygLmygAfXC7yrWlUEA
	727BrEMmpmXt2JiEggtwfDgZbMW2VWzaL/WZOuIDQ6RdLymE0rVJcR6s2IK1k8wjcCzIXHKUn+h
	GYBZKhRmwB+7+zNERsHM53hvHU4kvmRN7lMzvdpAaob69viHEoAufIFbtBJEL4nyZtK9hvgw95x
	R0uIgy4pRXxY3Bb8TongWXtOGjMgwVRPd2y8kJuG97ARuQ+gQfHLpHfpKY9kdJkYBNdZ0
X-Received: by 2002:a17:903:244a:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2cfa6b7d4c0mr20794705ad.2.1784783299237;
        Wed, 22 Jul 2026 22:08:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd849asm25900295ad.28.2026.07.22.22.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/18] bpf: Express ARG_CONST_SIZE_OR_ZERO as ARG_CONST_SIZE | SCALAR_MAYBE_ZERO
Date: Wed, 22 Jul 2026 22:07:56 -0700
Message-ID: <20260723050806.1158442-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
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
index d9542127dfdf..a7b3bb56c70b 100644
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
index be5d93c0da81..5e09b95458ba 100644
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
@@ -8500,13 +8498,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

