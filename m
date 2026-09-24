Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102847D452
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267526; cv=none; b=KtpxJsQEGiivJ2jx45iEwKrJc59Tw0h9xr5Aj9OVKB8XM/tXk90mFsT5zSoWoRtRg3nTzhhDVplt9ng8cxQhovPTho571iBALDpaMXB9n4gMmN+cA44/1bareIVfn2XXS1YxQnexRzZjfvHdNRKzpBh9XIfh87S/+qdZ28NBSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267526; c=relaxed/simple;
	bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVYA5A3+9qiQzY0QMi+iQ8ZhNkuB7ZxgVgdluPZZ5GeWNX6jqtAjTzsmS8AsIXrLy2VsttT7Y81gzjSiN32AlDGUVcOxQlfgxQhyT8emIvzdPQD3q/Y9YEko8vTxxAJrDskw+NSvEMhAm/xC8trwdI7ksZ3PG5DEmhwpXxGFcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M05o+QLk; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M05o+QLk"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so1339f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267523; x=1790872323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=M05o+QLkj+o4y8SOK0q0D8tf/tJHNn3HyB4oncLySyaRpIEr7knLDbpa4vUxq83DOu
         f32G9mUq70Pa9jUfaEameolLcOyLCLN05VthT5EfJrHQ/k+aBxtGQo93brc/H+fdzoxD
         oHmjSIchRvZrL2F8ni+Gp0p03pwlrBxV2w2qPxyknRKehbWssPD89+usXJT6AUZ+Aplb
         uSRI36PSlCaxUKcrYMUjnziDk4hjW0OGOMpjFhF5gYU69v3ILSFMaRwPE2ZpyPJ0jE00
         MmpaGb+oEdiqkR+DvwzEmZgm5NSejOSuD0E9xWsRRg9m9rd0qNTZ237NlBGR3xZVZLA2
         XeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267523; x=1790872323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=2gkxQpzfu/6OwjydKlAP/6wd2O58QikrL1G1s0aiWslRBI6Ywo+NubXlnuOAVkr+BJ
         AuggSJMJy6aUeifvnLPNPesRyy1Q8mAEd+DHz3sO0VKztVlyrvxC22U9djrlhUBn3g4S
         ACbeXcVzcjjocZ543DHhChjy6vlTYsmWC7ItLBBX2UxbHbm0mGDFSUHWVcdTC9AVMcIN
         CDiX4XGhGyq5zXd+N1us3IABhLCDjrcPtUpD5UwPSEMDou7iVpdxKlLDpqI3fSrp6oRR
         12t7T7YratMwLevUd5GO66J7TDyDu3J4YXrhwtxuanKsxicaxmM8ucYrcLB6M1xZATSV
         HOBQ==
X-Gm-Message-State: AFuF++mA4ON5LPndrbXeP/3FHR6esG6qBllWmPd55a15AVyhFO0xV03Z
	n4hWW/EKRdUxOr5KFhQdpmIaTqTjCio2MZ4PY650uwMevSJzTQmaNQS8Bs702CkK
X-Gm-Gg: AYBFou1Aq4d9PjtqAf2KIMwFre5PLC11CtoUauBF6+iEr35LeTBsZ5sHDqHbQm3DgLJ
	j9cPaSRYVWiSx2SqVz6P9w6UmwTWjC3rNgaO1rlJ1zQbcAKL3yi0A/m7d6PD67piO5FlpVXEvyZ
	sOUwUb7uQOsBGkLi3Mu9zkFojk6lw3yDpP+FMhWsizdLPRFO0fPbERDkNxL7VBYY0cybJ5YSkkx
	6brkSl2Gl+lQC6JUb/MlutNvJ/0Vj7ZfPTTSCCHFP552Jtch3l+EZ7PDD9SlQjb2+CIZyJvN3CZ
	X3Vr5ha8Si55y2suv7l7BZzgA2tppiQpceSj7vaHGjuCm1W4eSdv288acQFIua9nqwp0tJP6iYp
	r60zcYkytruqoJQ6CWxs67K8vvvzucqqH5mb0YEikJt12vG7REMleCNsecM/QSMT7X13lh2THUg
	1Oj3bE7WBnmG4MWY1lS6/IlXcP0nA+1SDr9y8N5Y9IxYo+0QC2yszmPJWf6fJHQQatzwmCqSZQ7
	mFV0jaWBDtu4+hEqc0yU5EpKKETcQ8A6jH9B32H6Pe2djwNl9xyM+PDP95ezFr6kiaHytXVXPQp
	n6xFDrTT9PWdUTZup+qumLjcm97DJWyy19h+bg==
X-Received: by 2002:a5d:5c03:0:b0:488:6561:b324 with SMTP id ffacd0b85a97d-488716b28d0mr6366357f8f.9.1790267522827;
        Thu, 24 Sep 2026 09:32:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6456f8sm197084f8f.26.2026.09.24.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 09/18] selftests/bpf: Cover the tail call caller stack depth limit
Date: Thu, 24 Sep 2026 18:31:23 +0200
Message-ID: <20260924163144.1945455-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=memxor@gmail.com; h=from:subject; bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7+uXD7dMUv7Xvfn+/0PMKyw/Xn994PiN4EArk8npy /ruKP826ihlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBESsoZGX4fePJoo2unVYrb 6uyERxfmdP+rYvylduJ+so/q17IDslcY/srPy/uyliHkZcgznmf83iydJTvyAs/cWhrctHmViMq 5VDYA
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

