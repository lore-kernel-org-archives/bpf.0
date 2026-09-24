Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E54AA1D4
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269080; cv=none; b=JErtpwvPb0GHtnTqfP8ZSsU3IIMBrWXCrKOQml5+44+87TEDdQY7idYqJ4w3Mg5gd/PWC1/iGGT2R9hkXJSZsDXpoUh6KImUOM18hnRVw70EuiOGARC1QB5ExhufKxSymbSTGFUvtRxiTtQG3Jxa5lqcGX/gKMAJfonB9068r/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269080; c=relaxed/simple;
	bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feacbPTbEvP+gTzjWo+wQmkbXgFTDhmIUBm6ueiUtwG7J6YeilLMEJ0FdyZcukWGp6e22igi2WGb31grP62CGOuCoiqDWAV+wODgLTAMm+0uNTXr4wNICAl5p0e2ZEpaVa17/0LkGO+EcwIypx7KGURwnY9bSwhuWgqwKNpoda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by/eGGzC; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by/eGGzC"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484349b1961so6767f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269078; x=1790873878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=by/eGGzCcnELf2pnN+d06BpPfzaUEg7ozWxQ98M2tmrU8cW/GbgRNGrxUCgkyt5Yef
         PhCvDXLWbAxfANqR2cSpCaVnACD82FiDQHtEL8y5Lv0JNJzwTFJJB2LoaYVSGdIyPfAl
         24ghCq9AeljleFWWY4qrPhHQ9xcI5GDAqxbrjVMcEW42JoCk0kvGPFV9wEx5Yyqd6XQK
         gccw1yeztW3zEHboS8qbQsxTzQxArKHDNWpX6EcWR3c6w1qMKQDQ/ewUnAKH4G2boNTA
         BHpi7aMyWR9cd69GlY9KeLa6K0IjyVwJw9+NDWLxvpTSJeRxFpR8bvZwRoUYa46AH3lb
         FB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269078; x=1790873878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=wWzZgpXT65PuOUdJINRBz+oU32RDASY+LrGcd67KnPL7+dHwq6xfqqMfmPvdSZjqin
         NlSZ3aNcXEM14y8BhacsXA3+oJhGBSIi6AshIrCE8dKKsak1dAqp4Y6O+rGlXVJfuVrA
         MZgcNaOE3kGGCSH/s/salDgrc1rNbUdIL4SlB6dBxoSSNMHc8kS7wfk6l6ffGUjCLM7X
         Z4rgFMrp7KHKF/U676wU1VLrYOyoLGB4hwaiZQYdD3bXOLjOSDGF72gfvcWPF7gxfFTB
         zqPCM/k4jllXfWNHssaSg0MTT2Rntk/k4N6uf6FYmzxSEDVZ8g7g6+Ej56t4eheGxDzv
         jpdQ==
X-Gm-Message-State: AFuF++nCTWlRGIv/Ai3s+BsxpHhygyk/MlQlldmN/detWlXRKdX9IBPC
	p7ODHj9s0jUbUm0Nc48LakvqLhNQULGUJkREgqPrAU9CIuB0ZFW1W6++1GwuTOFh
X-Gm-Gg: AYBFou0vCIedyVCgs8qaX5hgv4NqzItf4aGBu7sPWxUIOw1k5Q9CovVpjPNfIa1oy5e
	kgmG0hbQ/232IcdDBU94UjwDZSjIBEZAjg3dLFhAARHm8ZU65U4SfQ9TDjaG+xSQJThcUARoUcc
	PsEffonoHEjv5BM+UaKM3leEvV1wG7B+F68xYT33k9JaR9ZbB2k/zxdGPqBFD+XQMyLddsZopqI
	rpnKLSpT1OgxPeFDqxZeZwOZrxiLjhnmMW3sQZ+NfApgmywP1Okqj5ejYT5S56axB9HyPLIZb4D
	R+gLNREob00AeVzO7xqb1L3XH5G4mLowUomkI4BSJCd2D5G96kAe3ihdXkcRhUCI9xZqmYUDEAf
	dDcX8mc86pNO/emp3ajzQLg70n/2BmJH6tjtyAaHWDTeO2PL6x1NdiGqGFGHjpQ0pdG6HzrmRR/
	v8z4bvt61SDzLAZ2VOcI3HB87BgC4XWFWGLwc44Coyw+4yMrQspJt9WKVFbC5Z6seJETSHCrirA
	xjUQh6Fampun0uV3xWUtiFt+WucIuWPguC0WzWPhvU5E1YColzMHlpqU8RUxKsSKe7Pm7Dx4Q+0
	5j/meRmuMMBmlTmAIDlF77dRR1vEXPjUSNwskQ==
X-Received: by 2002:a5d:5e0f:0:b0:488:76f5:ca0 with SMTP id ffacd0b85a97d-48876f50d6amr1590606f8f.39.1790269077530;
        Thu, 24 Sep 2026 09:57:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm284195f8f.36.2026.09.24.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:57 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 09/18] selftests/bpf: Cover the tail call caller stack depth limit
Date: Thu, 24 Sep 2026 18:57:10 +0200
Message-ID: <20260924165740.2146806-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=memxor@gmail.com; h=from:subject; bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraOHLh1smKf/r3nz//yHmFZYfr78+cPxGcKCVyeT0Z X13lH8bdZSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAiOxkYGW4vOKMlc2v2luOK xyL69AqSNjk3bLsowXRWKohnF4v4CX5Ghm/Nj08d7c46deji7bSNLO2WD99dWFdeUqZxJOek8p/ tPzgB
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A tail call from a subprog only unwinds that subprog's frame, so the
verifier refuses tail calls once the frames of the callers add up to
256 bytes or more. Nothing exercised that rule. Add a pair of tests
with a caller using 240 and 256 bytes of stack respectively, the
latter expecting the "tail_calls are not allowed when call stack of
previous frames is 256 bytes" rejection.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_tailcall.c   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
index b4acce60fb9b..51687da97225 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -28,4 +28,61 @@ __naked void invalid_map_for_tail_call(void)
 	: __clobber_all);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+__used __naked
+static int subprog_tail_call(void)
+{
+	asm volatile ("			\
+	r2 = %[jmp_table] ll;		\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+/*
+ * A tail call unwinds only the frame of the subprog doing it, so the
+ * frames of its callers stay on the stack. With up to 33 tail calls in
+ * a chain the verifier caps the stack those frames may add up to at
+ * 256 bytes.
+ */
+SEC("tc")
+__description("tail call from subprog with 240 bytes of caller stack")
+__success
+__naked void tail_call_caller_stack_ok(void)
+{
+	asm volatile ("			\
+	r2 = 42;			\
+	*(u64 *)(r10 - 240) = r2;	\
+	call subprog_tail_call;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("tail call from subprog with 256 bytes of caller stack")
+__failure
+__msg("tail_calls are not allowed when call stack of previous frames is 256 bytes. Too large")
+__naked void tail_call_caller_stack_too_large(void)
+{
+	asm volatile ("			\
+	r2 = 42;			\
+	*(u64 *)(r10 - 256) = r2;	\
+	call subprog_tail_call;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

