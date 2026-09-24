Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB243F4A3
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292698; cv=none; b=i+sJVVgAnWwZ+j997xOnhIkv90/cITrHcnf9kXt6W8G78TG1TbclWEcykK5NOHwvbfXGa2tzOR/kAnux+lGwyWYym4a+yRE527kKsiPke4sYXpTCqSac7UZyGOsj3cndtV28RHxHdfk8M/I4NCxUz1MbduIyCp+zk+fy0ZgFFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292698; c=relaxed/simple;
	bh=5Ud0xfjH2QMQqQ/byxRvlmLrBLkz781DVMGT0e3qED8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4hM4sLfjNJ5WwVqsn9js06eAL51dbkiyNoYZQ67Mec4Hypxjlb9J/7nblRewHSgQFuemo6gl5DcX2cX7/58ld9NqLbiwylHYd03IQ1DQy9owLWSJEU7UXVs0z9zYBgz8aiY+RxlTAoQvlc9+jIk7Ln77+qFdoGQ5ksrOeIzQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQHJrxdA; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQHJrxdA"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b18f811cso289026a91.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292697; x=1790897497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wa4Ei4X88Cm9hS3l40N9Yc3JMeOuOwqROe4al/tfbbU=;
        b=PQHJrxdAFgkBP3VhJdOeIY5sal5KOxbm56cjrS82aV/NxKFPwk3abEnZZOTpkJ0Bi9
         Wb76nxJytUlWwwyWBf/wM9jskhzLCAvP2AV455JLcVFyFuYLH+rvGTFi9/WGJ0BgEWS0
         p1si1vDpZDN5OCPpeuxYFrJ0ZJJflxk55v4ugxBjUbSqlZDrQ4IBTAz67bB9tt5BnAK0
         cqp2PrM/hlCNtz+Nil08oHIhO0TUKI6CCYHxC+02NBNeoplxqCBRAtl+kPsvSNcu00Ic
         NnkWRBdni/hJWi8/uoahjgCuABa0u59QwW9bV4C+ujEElTiLu5TTE67duW655Y2aYSyG
         yjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292697; x=1790897497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wa4Ei4X88Cm9hS3l40N9Yc3JMeOuOwqROe4al/tfbbU=;
        b=jE/N50w1ZaKdKFU/gCsms6qT16pbR36s/4L64m98erupCfnA1pI+RpMp/+LNv97v9a
         3psA7zHSuWTzjpIB5syJ6Kf6GI8NCxv6SKMJXQydw1kshAk8wY6J1vExpQI/D0CpnXOg
         Mlfib1JP+Vh/eif0B5ENKPRPWnAYyD8r0prAu5S8Vum9qJ3ae7FPiPs6CIpCLQwGjJyH
         caDqU88uo5d5eCc9R8qbGPoDeiLT3n5VENviHbZfKSE0TFt1k4Cscr68tO+VUgFS420a
         PcuVxA2ExKvXCbHY4uGzUyZXmX9qSBWW8RUTEgLTyobBXrJPdChBIcQsDl/VdI3SfpdL
         wveA==
X-Gm-Message-State: AFuF++lgdAYJb5Sv0RKk7uLIWxjnnD4+GT7gn/RXRhCOR2Km16CevZ3V
	N5uzI1HrDkETJ7OUqyqlb0cskEHyeNNZ6qMuaN/Ydv/I0EF4T+1r9IhQU09w4g==
X-Gm-Gg: AYBFou3lah1NVnsf3TWKFtzbMxiU3VoDF305XHM6sIUa6CxmbRDKCJNz0Wlo7zrOVcf
	FveJ/QLSxNh4R8w2XES2vclBs19j15fdADEGWe7YJartLV8nVwviVrvl8KmV0LbFZjsVbz26wzh
	UObhVa/HSW04jROhDPbWbaFyG6s/T6ThsHGeOVkLLCelrB1G1VaEokumzaLNssL7zhm8k73+u2F
	+zeBgZSpJsuAVEsDJOIsaOk6e4xECn+MVlUp3nzqJDLSPkNot3Znzfvx8KC3fZYiuqO3tY+aoI0
	cFh/wbUjPbgnEj1fcn4bf0tZQ22k9mCJ5yrqIhSVKg82+xborw4YDEEP5i/FVzbaTR1UgkEJPDn
	baLe9qLSAvp3NkGWlOuE1JklwP0QNRrDjBngzKwKU+oaSu72Amz/zYyUTNiLiuNaNLa9uSMH6F8
	aJfq4XgEPEGVd4hSqZAr8Er6OquRprMTyFUlAzZ5hwIytIm91pib/mY3DrQkLAcpzjzcKHhavrj
	pBHUBZl1nYAGXqRtZrnHWoYylsbQeuOVL3bEB7YShWqe7PUqL85/ttXZM+a9PutQoda2iFOIaco
	CXYR4j2Hfp5lmiYmVwepVfzNXSSnCH40EsIsznq9kprv
X-Received: by 2002:a17:90b:1b06:b0:3a0:8133:69a0 with SMTP id 98e67ed59e1d1-3a098b93cb8mr3463649a91.14.1790292696634;
        Thu, 24 Sep 2026 16:31:36 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f111csm7168407a91.2.2026.09.24.16.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/8] bpf, x86: Fix timed may_goto with private stack
Date: Thu, 24 Sep 2026 23:31:23 +0000
Message-ID: <20260924233130.1213812-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

arch_bpf_timed_may_goto() computes the address of count and timestamp
as rbp + offset. When the prog uses private stack the JIT maps r10 to r9
and nothing is reserved under rbp, so bpf_check_timed_may_goto() reads
and writes the timestamp in the kernel stack, where
arch_bpf_timed_may_goto() has just saved r0-r5 or further down.
The following loop in fentry prog with r0-r5 set to zero:

  1: may_goto +2
     r6 += 1
     goto 1b

leaves r3 with ktime in it when the prog has 64 bytes of stack and
ends after 65535 iterations when it has 128.

Add the frame pointer to the offset in the JIT, where rbp vs r9 is
known, and pass the pointer in AX.

arm64 and powerpc JITs keep the address of private stack in BPF_REG_FP
and are not affected.

Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c       | 12 ++++++++++++
 arch/x86/net/bpf_timed_may_goto.S | 10 ++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e2e531dd1e0b..6c7a0578760e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2961,6 +2961,18 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				ip += emit_kfunc_arg_moves(fm, outgoing_arg_base -
 							   outgoing_rsp, &prog);
 			}
+			if (func == (u8 *)arch_bpf_timed_may_goto) {
+				u32 fp = priv_frame_ptr ? X86_REG_R9 : BPF_REG_FP;
+
+				/*
+				 * AX has the offset of count and timestamp
+				 * in the stack. Turn it into a pointer.
+				 * add r10, rbp or add r10, r9
+				 */
+				maybe_emit_mod(&prog, BPF_REG_AX, fp, true);
+				EMIT2(0x01, add_2reg(0xC0, BPF_REG_AX, fp));
+				ip += 3;
+			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
 				ip += 2;
diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
index 54c690cae190..6c6e03f725a3 100644
--- a/arch/x86/net/bpf_timed_may_goto.S
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -11,12 +11,6 @@
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	ANNOTATE_NOENDBR
 
-	/*
-	 * r10 passes us stack depth, load the pointer to count and timestamp
-	 * into r10 by adding it to BPF frame pointer.
-	 */
-	leaq (%rbp, %r10, 1), %r10
-
 	/* Setup frame. */
 	pushq %rbp
 	movq %rsp, %rbp
@@ -30,8 +24,8 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	pushq %r8
 
 	/*
-	 * r10 has the pointer to count and timestamp, pass it as first
-	 * argument.
+	 * r10 has the pointer to count and timestamp. JIT added the frame
+	 * pointer to the offset. Pass it as first argument.
 	 */
 	movq %r10, %rdi
 
-- 
2.55.0

