Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57946219FD
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860120; cv=none; b=JpR1mn9Q3QLkf/wrYgHntetPpIr1YyWe86U+GPH/eCBQtjVPv/9tCUuZZABwIy8Okb/0eoUDydtjNu/CGSUIh5SUHyPX9uYIPVymjmVzv6r+I6v1Mog9x7bqkI3VGrXs5vn7nAq5q0M1tMYb5jp/u7buiKkFsuW2GcTOoUa5AD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860120; c=relaxed/simple;
	bh=GHTLOU+UturVnXWqznP7XGhe+z5qTqbuF3Oi5pXMPtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwseRCNdSGbSEZhOrHuLZ25G9QeDhOADoeoKm/5KM1S5l62pRVociHCzApfj04r8G9n1EOKtLgeOUZxfWLeU7QtNEgV+eNG2T9D5WEs+8tyPMmkmEQ3Kjivb1J/MYWVHsYksDjkzdvpNdh5G99dgpwnDSOh0BlmdGCGQ51EKF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUj0aAZk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUj0aAZk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dcd6a3da83so10867045ad.3
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860118; x=1710464918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/Ky9JSsSw/fwjp77rJRTfxTbp5gTCgpDOKXnfDwZbE=;
        b=EUj0aAZkz1I8V/XaIfqXJjArhVDWjfAR/JtI45csTn7yqkRIca3iIvDnqzrHjBuh1W
         THEYtFPwKN4dDr4EnLCkZaPqCdn92t4p1QHDDij5+qrMr5pwQ71PuNwnzuFgC6I32e9i
         dNajNNZ6eG5B/Z5YfCahENH9RSwaH0sfhgU2S/xFHQ85gN2EEJwBqBkHbs3sv2UXVUiO
         QVnLGY09dhkxIOIrV+uKIdlPPFmAvE190MTv6I1ZDi2oBITWUZmLq0lJlMBX9mEXJ+y6
         gyFHQRDfPmbAMaOxkeDUTrCZT7lexjZhRCqu1uLKukF2Glx6QmRs7tCrIJblWkXDGTRF
         iGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860118; x=1710464918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/Ky9JSsSw/fwjp77rJRTfxTbp5gTCgpDOKXnfDwZbE=;
        b=S2RuB3LgLsGp1zBcML9M5Z680w0S5x/8/kDLFa0YDS8PfZhVCX9OCXJDTrgxijqB4o
         oZFp9Hq5EvAT7JZ2Po4KBVBwonWZHRBiNJ5Lo8xbqjGDkLRf48EEyHhBOp0TFXGzNgJm
         SKNWQjORR69SaJWX/BLXVvFjWdJG/3DULrfelmltQ9p7tyg0Qa0Qt7c5HeNOh+1z8UND
         EKzBlfV6/WGbcQL4Xr6FXuMyyyCUkOqlLGPqqh3HsbQlwgjhV4bPvlOzxGW0A1KDF1i8
         GqPMKAEcX69GXFSszXnbaT3ChEyJAwhQ+dIH11o6frprNnDEqhMd60H1iA5j856ZFhpH
         5vKg==
X-Gm-Message-State: AOJu0YyZMfV4lDkqSgUau5NA3YXQduISMydFolmU2RWBID1MWXJLDLgg
	Q/F2WHqtd/vna2f8klyM0O1WBhEvQ1tHScqY94E67mFr0jn/OXYixrrXeKuF
X-Google-Smtp-Source: AGHT+IGO75KVoJnmF8Czhd7kDBIez3STkTR4G49ROAwNxjtpUbXCXj/gJTN8EOuqXfjmJ6LnuAHjUQ==
X-Received: by 2002:a17:903:1248:b0:1dc:3517:1486 with SMTP id u8-20020a170903124800b001dc35171486mr11827107plh.49.1709860117510;
        Thu, 07 Mar 2024 17:08:37 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001d8aa88f59esm15239094plx.110.2024.03.07.17.08.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 06/14] bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
Date: Thu,  7 Mar 2024 17:08:04 -0800
Message-Id: <20240308010812.89848-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

In global bpf functions recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.

Note, when the verifier sees:

__weak void foo(struct bar *p)

it recognizes 'p' as PTR_TO_MEM and 'struct bar' has to be a struct with scalars.
Hence the only way to use arena pointers in global functions is to tag them with "arg:arena".

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/btf.c      | 19 +++++++++++++++----
 kernel/bpf/verifier.c | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d0c836ba009d..08ad265cb195 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -712,6 +712,7 @@ enum bpf_arg_type {
 	 * on eBPF program stack
 	 */
 	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) */
+	ARG_PTR_TO_ARENA,
 
 	ARG_CONST_SIZE,		/* number of bytes accessed from memory */
 	ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 170d017e8e4a..90c4a32d89ff 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7111,10 +7111,11 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 }
 
 enum btf_arg_tag {
-	ARG_TAG_CTX = 0x1,
-	ARG_TAG_NONNULL = 0x2,
-	ARG_TAG_TRUSTED = 0x4,
-	ARG_TAG_NULLABLE = 0x8,
+	ARG_TAG_CTX	 = BIT_ULL(0),
+	ARG_TAG_NONNULL  = BIT_ULL(1),
+	ARG_TAG_TRUSTED  = BIT_ULL(2),
+	ARG_TAG_NULLABLE = BIT_ULL(3),
+	ARG_TAG_ARENA	 = BIT_ULL(4),
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -7226,6 +7227,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				tags |= ARG_TAG_NONNULL;
 			} else if (strcmp(tag, "nullable") == 0) {
 				tags |= ARG_TAG_NULLABLE;
+			} else if (strcmp(tag, "arena") == 0) {
+				tags |= ARG_TAG_ARENA;
 			} else {
 				bpf_log(log, "arg#%d has unsupported set of tags\n", i);
 				return -EOPNOTSUPP;
@@ -7280,6 +7283,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].btf_id = kern_type_id;
 			continue;
 		}
+		if (tags & ARG_TAG_ARENA) {
+			if (tags & ~ARG_TAG_ARENA) {
+				bpf_log(log, "arg#%d arena cannot be combined with any other tags\n", i);
+				return -EINVAL;
+			}
+			sub->args[i].arg_type = ARG_PTR_TO_ARENA;
+			continue;
+		}
 		if (is_global) { /* generic user data pointer */
 			u32 mem_size;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1358e20d315a..d64f7a9b60e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9379,6 +9379,18 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
 				return -EINVAL;
 			}
+		} else if (base_type(arg->arg_type) == ARG_PTR_TO_ARENA) {
+			/*
+			 * Can pass any value and the kernel won't crash, but
+			 * only PTR_TO_ARENA or SCALAR make sense. Everything
+			 * else is a bug in the bpf program. Point it out to
+			 * the user at the verification time instead of
+			 * run-time debug nightmare.
+			 */
+			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
+				bpf_log(log, "R%d is not a pointer to arena or scalar.\n", regno);
+				return -EINVAL;
+			}
 		} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
 			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
 			if (ret)
@@ -20448,6 +20460,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				reg->btf = bpf_get_btf_vmlinux(); /* can't fail at this point */
 				reg->btf_id = arg->btf_id;
 				reg->id = ++env->id_gen;
+			} else if (base_type(arg->arg_type) == ARG_PTR_TO_ARENA) {
+				/* caller can pass either PTR_TO_ARENA or SCALAR */
+				mark_reg_unknown(env, regs, i);
 			} else {
 				WARN_ONCE(1, "BUG: unhandled arg#%d type %d\n",
 					  i - BPF_REG_1, arg->arg_type);
-- 
2.43.0

