Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2D25228D
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050724; cv=none; b=t08AxMngbR+GprPX70hYk+HaEMQMr7YJyTPbjkILPrK6vcWIpCsGumQR9GvGTrpm4eZvn1DS8ZmwcpmKLTYVgasXxGcYP79tnTRMRbETL4G4Xrw5o5U8x+HUsBKOv+sb5gHM81pcs9McaZdBXndCuxjByskh/Cfq8A1BWm95MKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050724; c=relaxed/simple;
	bh=n9otxYLLiVUCiF0NwBWC80h7o2RKMS08s81YRFvEbGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnXG2aVIN94QUf3KWN/M26h8QqMC9pD7DBu/qaby669ktKT6XDw3iZoDGvU8j9UDuSystAtwaRXr9Tl1CZ0UseQ87WrQ0AXhrTDo+cK8VQJDWCv4jxqguE01Cod45lLrSDltiObvfOQ2w8/q2oa+A1SC4VE9XveNQOQ2wq2xPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBULXGrH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBULXGrH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ca70925c25so1207615ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783050713; x=1783655513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=irOx4um9SxVnPfyQhReoF+nfX6PSfywyMAlSD0zArHg=;
        b=EBULXGrHQOdatlJZ2pVyQERbi8gAUzgYotR+3WB1dxaFC1KToZ7iOHiykVXOw7fUhe
         SNCYWjJlMpS5FkvHeIWxRio51Z7wNhXENlSoRDmnxxL3tzOr2pGt+Rts7r8yB/LxQNjK
         0O8QofLWBTzwuLO1njRW2JylNnZW1bOAWUw54ieXrOM9CRiIWIbaLCz+wE9t2Gj858sV
         hwg4Yi0C13YC5Jq1q1ZLVgVoPPx9MzybPvdBMTXdd5GE+kGGGb4DDeRPPTTk9svanW52
         wtTKzvonds3q4vZKbLVZcg+ugH35Cbu2X2Lpo8jbu768RAoRFXdZ2h8Pugxaj5xk2jtB
         dtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783050713; x=1783655513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=irOx4um9SxVnPfyQhReoF+nfX6PSfywyMAlSD0zArHg=;
        b=PzTRdDiMvdCbv49ubh37imjNkZ69myjdDwIT74lWKRREqnZxYK0hpSbkk/5kmns+Xm
         vD8o2EpokaxRgXcf+M9f8T0YeHuw23BoaufD1MzRou2LoyDqzP+e+wtlbHi+Pb3fOu+4
         NmrRkcl9JAd92C5hC22hTV2aC/N5iS38daNJSqY96nYgTi/AinA6MLtVkR2G7KCSglUf
         taQRyn+KrHpyCUQcG/MFBZ1uqyuHBjRXPE6a49jXzWI+k+dTec8bSGaOuOe0brSiMNip
         6KmQBSq33U/y2Ptz53M6FMvO9m6L/cvMgavaE32m+l9PuhhKz229wADjIeCPSMuhmiwY
         YyEA==
X-Gm-Message-State: AOJu0YyDXyOHer5yvsdgYyK8czJ6w3pOGgtnRPX8bSBDn6wsFQ1jAAJ0
	WL86CR4FEX1Vyk8oUYk2A7DwZLn3FBTBB5n2JxdqAUuhGkgRByVAl3X6KsA4RoFdAuWoEG9N
X-Gm-Gg: AfdE7cnQP7gvl5yKqILgulb3Y0JtWKPr4DXy4nbF1f0U0tuySkNhGoh0p1QPoN2d+3/
	aheIESAawdVdXzNfsG6sA2JiHGJcXurq2R3qwNYMDwg4xmNh4lDjQ9yJ+a8rCGlSzcJ7Im4gZx9
	9+NQrEouwm/dFh54RiFw21uVdCmZBHkMMuYTAztxyyeuOnlzS7mhqlkj14nKi+4SYCLORkgoBt8
	/xaUnLDGswMrXDfBGK4wde/hYDYe9ExhNNb0BuGJEnKvnWY8C/UUxuetPJgNOM9cwegx0G1tMVZ
	eGsWIIynkde5nuZriuCykFmuBU04LbvLnECO2vqCp7esHw4yVfe/s05URPFxo6sGfitIAKn5jjN
	GxbvZGCpus5miugtJJslx6KssEQvjCrHMm2rAUfLqnM4h49zm3z0CxUuQBROswznvvsIf7VQ0HF
	ZpaWIgrw3sVDnXawFuz7d2Wja+ruDCrRbC5qjcYFQ/qd47JrAw3dgBtbNrby7QZyUDZBqlQKdyg
	0Yw8tsso6jj3eOXSscUuK3+iQ==
X-Received: by 2002:a17:903:2411:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2ca911de5d0mr82443825ad.23.1783050712813;
        Thu, 02 Jul 2026 20:51:52 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm22506479c88.10.2026.07.02.20.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 20:51:52 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	mmullins@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf] bpf: Reject negative const offsets for buffer pointers
Date: Thu,  2 Jul 2026 20:51:37 -0700
Message-ID: <20260703035137.109608-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
accesses, but it currently accepts a constant negative offset produced by
pointer arithmetic.

For example, a raw tracepoint writable program can load ctx[0] as a
PTR_TO_TP_BUFFER, move it by -8, and then read from the adjusted pointer.
The register is still tracked as tp_buffer(imm=-8), but the access is
before the tracepoint writable buffer base and should be rejected.

Check the signed effective buffer offset before updating max_tp_access or
other buffer max access accounting. Reject negative effective offsets and
use the checked end offset for max access accounting.

Add a verifier test that rejects a raw tracepoint writable program using a
negative constant offset.

Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c                         | 41 ++++++++++++++++---
 .../bpf/progs/verifier_raw_tp_writable.c      | 16 ++++++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21a365d436a5..421ca118fcbf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,14 +5326,18 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 argno_t argno, int off, int size)
+				 argno_t argno, int off, int size,
+				 u32 *access_end)
 {
+	s64 start, var_off;
+
 	if (off < 0) {
 		verbose(env,
 			"%s invalid %s buffer access: off=%d, size=%d\n",
 			reg_arg_name(env, argno), buf_info, off, size);
 		return -EACCES;
 	}
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	var_off = (s64)reg->var_off.value;
+	if (check_add_overflow(var_off, (s64)off, &start)) {
+		verbose(env,
+			"%s invalid %s buffer access: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, var_off);
+		return -EACCES;
+	}
+
+	if (start < 0) {
+		verbose(env,
+			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, var_off);
+		return -EACCES;
+	}
+
+	if (start > U32_MAX || size < 0 ||
+	    check_add_overflow((u32)start, (u32)size, access_end)) {
+		verbose(env,
+			"%s invalid %s buffer access: off=%lld, size=%d\n",
+			reg_arg_name(env, argno), buf_info, start, size);
+		return -EACCES;
+	}
+
 	return 0;
 }
 
@@ -5351,13 +5378,15 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  argno_t argno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size,
+				    &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
+	env->prog->aux->max_tp_access = max(access_end,
 					    env->prog->aux->max_tp_access);
 
 	return 0;
@@ -5370,13 +5399,15 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, argno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, argno, off, size,
+				    &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c b/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
index 14a0172e2141..4055a6443bc2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
@@ -47,4 +47,20 @@ l0_%=:	/* shift the buffer pointer to a variable location */\
 	: __clobber_all);
 }
 
+SEC("raw_tracepoint.w")
+__description("raw_tracepoint_writable: reject negative const offset")
+__failure
+__msg("invalid negative tracepoint buffer offset")
+__naked void tracepoint_writable_reject_negative_const_offset(void)
+{
+	asm volatile ("					\
+	r6 = *(u64 *)(r1 + 0);				\
+	r6 += -8;					\
+	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

