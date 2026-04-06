Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5A3976A1
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504658; cv=none; b=jQuElsjGmZ3Ay9tRADLBsM84VzRBO/wlIneGCDPLJNNAK3NNVxOLdEONR1GZkPcpUWcwvoZPD9eC6VxP0ytlRObu1DlOhWQiXEbxlBqTJaSQrK/iOj+oEHh2lqQsx+qqsRn+tjpNvgjvb+aGj+LNQkPAzezrkRs8ypaEmbZBLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504658; c=relaxed/simple;
	bh=pHXaA4TRkerCes8xwbidiOtyvg5MWGqYVLMO9rOw/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8Pnbj3L+X4L6ITmRqc7pqXvbdMxY4HOp0CuWsA26hDhpWKijzHEfR1NyQ5n4pqwZ+8yrRS+tlNVNaX3s/uAfeZbnMft5ZkgGOv7HZAZ8CVzh3nrwBnW/BySeTbJT3iimBOOv3Qj86VcrsI7FSelEc9ctFrqY/mS3Q8nksrTpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6uH9nNo; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6uH9nNo"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-470145d7e07so1340347b6e.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504656; x=1776109456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+qpvKmDM+0CiBkwD7sz00oOIbxhplbERdAEFMRUTWs=;
        b=r6uH9nNoLkx3xItheySyZTn7qkbF3gutAonAXO3e5WR8++pWNoqKjQ1TXOR6Cr9sQr
         Lq8qBM4cPQA6nkoh+0ZlXFtC8b5corpgXM/2gSDV7AIzt00iZAWPSHDIQ2wPdLBBa3Uh
         JI+mYScRq59dtD0tAy1bb6JK8RKMpxdGQ0+sb+e8hlV419X6Uz6Z8TZ2H2GpoFpP5/LD
         xH7wiVqizaQX0llRGnJ9pLVFAQRZkQfcs/LohqM3FpYMcLc7O6LXcLdbSal1kJYHNpe9
         q3yVc2JZmJFhNofTmCnOjD4IQcU4nKublFzo5XFNAZVJdhFOfliMybK9M8uTXmf0OqPE
         SUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504656; x=1776109456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+qpvKmDM+0CiBkwD7sz00oOIbxhplbERdAEFMRUTWs=;
        b=jpmnw570DVKcQYBhNbcSnca/9Obah1zitOvLqHjVvvjPqwS+uDLCE8GioGSHnujTyY
         KLNw7NIqQtm1U5q7z3/fxFOgzHq4TUANk5tX2cS/vNJh9TFVN5D1nNloMvakKV4TUuzZ
         7vPbSwKsROYGYrM2W7+CGLUgAAVy1MkuI+E+j3DmDqXXWBV3HSpus4P95i8j4VfJO2/6
         CqwYeHUC4cmr/GoJN7yXJFGXt5LYrF7lUvADgxA5S4nTTYvI2XXCXO6JbmATFGeCQrq+
         17VCMQ25AnLNkQwhy9Vg/M+72rss/kAUzJM19YOiCmFcM8rlvmGuiAgLWSI9orA3hcqo
         v1vg==
X-Gm-Message-State: AOJu0YxZYGAVQw4kRAsK5GzJRsnApXInVjVE92Yzwo+XOtrOOInnUn3k
	obhgjQlDkvknBnZGGGwE89K7MfKYGPVEL2r4/ulUnpLuxKzGfAQ5xPmnoCr2BGnrzaw=
X-Gm-Gg: AeBDievO5cn98UC+pfAWy2W3DDbj6kKubqMOiPcXKvZRfg3a6e0wwBX8FuHNuiXrzMF
	g15yYO3BP+8Bb7Z9bEi/VUVhddNL948Zw2AK4ZSMx9/zDztG8fIyy5msyExN/OkTJGX+cl/Ipxx
	eB6RvPqrLTEfmppmJtuUarTb8L8xfhhcEA1qs194XVwod6SWJPYctCm1OcO8d2ltLdMe0tXxzY6
	wYgJoVFRmLvGVYi7o/HnR9+mg3xIGc8AzG11ZNuQKhU5SxHwQm/a8/+UZeEBMskFtRjKjAxgnj4
	+mcrz5VJyR2XbbeHbeR2LOQRUGmsztYAoLFsz63IDc7BWvRbz61PaNc/nDNUsnZGz6XvXRXiGDj
	pXZhm9DTGX+ovjwOyP4Bh0lrV8PYi/PQbgeDmqDy3DOccmARTznVdYEC//rfng9prJ1/raPOZRF
	541wzYCpyQEcnEzty/8mDalJxh2cCbj/dH1zT+1VSdi5YCF2MiI192fnY=
X-Received: by 2002:a05:6808:138e:b0:467:4939:9674 with SMTP id 5614622812f47-46ef57f02a1mr7575054b6e.7.1775504656009;
        Mon, 06 Apr 2026 12:44:16 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47471f0ef63sm315584b6e.12.2026.04.06.12.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 5/7] selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
Date: Mon,  6 Apr 2026 21:43:59 +0200
Message-ID: <20260406194403.1649608-6-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406194403.1649608-1-memxor@gmail.com>
References: <20260406194403.1649608-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; h=from:subject; bh=pHXaA4TRkerCes8xwbidiOtyvg5MWGqYVLMO9rOw/Tk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMKD9vT7mcNK2PkQ99JX5Ta833uUqGp7yS5+ERvBRxS3PJk vXVQRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbSYs7I8OhphdnpSZwpk2wjb2TbKZ 9RuHJ51lxhs9WpC8TWukoEzWZk2LMlWK/ios+FPcYnrkz2WX9A9fLD6UVMe7o0bjqFfA+qZQIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Ensure that global subprogs and tail calls can only accept an unmodified
PTR_TO_CTX for syscall programs. For all other program types, fixed or
variable offsets on PTR_TO_CTX is rejected when passed into an argument
of any call instruction type, through the unified logic of
check_func_arg_reg_off.

Finally, add a positive example of a case that should succeed with all
our previous changes.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_global_subprogs.c      | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 2250fc31574d..1e08aff7532e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -357,6 +357,100 @@ int arg_tag_ctx_syscall(void *ctx)
 	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx) + tp_whatever(ctx);
 }
 
+__weak int syscall_array_bpf_for(void *ctx __arg_ctx)
+{
+	int *arr = ctx;
+	int i;
+
+	bpf_for(i, 0, 100)
+		arr[i] *= i;
+
+	return 0;
+}
+
+SEC("?syscall")
+__success __log_level(2)
+int arg_tag_ctx_syscall_bpf_for(void *ctx)
+{
+	return syscall_array_bpf_for(ctx);
+}
+
+SEC("syscall")
+__auxiliary
+int syscall_tailcall_target(void *ctx)
+{
+	return syscall_array_bpf_for(ctx);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, int (void *));
+} syscall_prog_array SEC(".maps") = {
+	.values = {
+		[0] = (void *)&syscall_tailcall_target,
+	},
+};
+
+SEC("?syscall")
+__success __log_level(2)
+int arg_tag_ctx_syscall_tailcall(void *ctx)
+{
+	bpf_tail_call(ctx, &syscall_prog_array, 0);
+	return 0;
+}
+
+SEC("?syscall")
+__failure __log_level(2)
+__msg("dereference of modified ctx ptr R1 off=8 disallowed")
+int arg_tag_ctx_syscall_tailcall_fixed_off_bad(void *ctx)
+{
+	char *p = ctx;
+
+	p += 8;
+	bpf_tail_call(p, &syscall_prog_array, 0);
+	return 0;
+}
+
+SEC("?syscall")
+__failure __log_level(2)
+__msg("variable ctx access var_off=(0x0; 0x4) disallowed")
+int arg_tag_ctx_syscall_tailcall_var_off_bad(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 4;
+	p += off;
+	bpf_tail_call(p, &syscall_prog_array, 0);
+	return 0;
+}
+
+SEC("?syscall")
+__failure __log_level(2)
+__msg("dereference of modified ctx ptr R1 off=8 disallowed")
+int arg_tag_ctx_syscall_fixed_off_bad(void *ctx)
+{
+	char *p = ctx;
+
+	p += 8;
+	return subprog_ctx_tag(p);
+}
+
+SEC("?syscall")
+__failure __log_level(2)
+__msg("variable ctx access var_off=(0x0; 0x4) disallowed")
+int arg_tag_ctx_syscall_var_off_bad(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 4;
+	p += off;
+	return subprog_ctx_tag(p);
+}
+
 __weak int subprog_dynptr(struct bpf_dynptr *dptr)
 {
 	long *d, t, buf[1] = {};
-- 
2.52.0

