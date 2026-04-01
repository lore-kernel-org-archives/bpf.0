Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87180E56A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046512; cv=none; b=bR5VXGy/ZGGeosLRxy6VsmaJwdAxZcjvYdqB2asFpn8mupXT0V8kAdv7zGInYllDHB0AjCOQ0tN7uJiE/sUUWDYpQMo0MwpKHs1l7QLf+TK9PulRtwVxgLax48eXkUoISJkCokgyYNXuLx3yYhP93YPqHdkl2QVocOKF5up5XVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046512; c=relaxed/simple;
	bh=pHXaA4TRkerCes8xwbidiOtyvg5MWGqYVLMO9rOw/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUszJvQHb0v9TKWW1QTAn2ttr1m27eNQyT+oIvkiujxLAjLmc5v8sEYjDdp+ousteh0rWitty0eS5Xq28QDD2lsE05Bi5e3anthYffdiJ3aHEgRzkL7Wi2XUf8qeJ0/xIBda5IdHwgJJtKMCbG8xSPxyI4JxHAKAb0ny5u7tdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpoxzPjs; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpoxzPjs"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-46701f2077cso719311b6e.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046510; x=1775651310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+qpvKmDM+0CiBkwD7sz00oOIbxhplbERdAEFMRUTWs=;
        b=CpoxzPjs/t5cX2F+Xlu0eUo25TdgX9WUtmkebZyv5yFyhCSYw4GZs/8rTDAEGbQWkj
         YJnx6nuFMt1kYa2bOXWvMT5YhCS1+Nbg6TI+uPZcsl9187w/fqb95uwf4sQhLp0kBiQr
         r7vYhE+MB1JfUZQWFaIPfNnEyb62xAfF/CwU6iiHTT61xRXUGhkWVyCUsPBU02rGJtbf
         aW5lZTQtGDKzGe/sH4kOWrgtCFV5Z8f1ptZ1A+9I6ISbBSPJTBwBmmBGpbdhvv1UnTrP
         mjqx2bP9/23XEqiQ1sslDnDhh70VAzxPDGHyxIJa7/Ftun5WSgI1OUYW8RbaayRl2CGa
         l7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046510; x=1775651310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+qpvKmDM+0CiBkwD7sz00oOIbxhplbERdAEFMRUTWs=;
        b=A+Ex6pQVBlGhVwtxXdPemIvVOhkG/9NRLucmg+b5tPNmA279oW5PH5TI8A8jh6avbN
         PF6WaGgmLi1bQtxtzcEB5NZYh26Y1FkbrwgFkDcr1DMAqG/Aql7D5YUIhHODmkE7+u+B
         0J91lyrekWIjIVjQmg2DLOgfxTe4QpsUPoGgR68EvmZxYnuB+hxQZ88Li/vtDgRJFnIt
         nkCY7Xv3yZqBKKtnuViv0dnbtz+tdhhYq+ApcWBEf3FY7Gb6pbqmXpOVVtV8lTmR3Zgv
         TVh9YkubLNP85leany+XEENT2e9ibMp7D9gC9ZRab2CzHHjM5R9RarS+O7Zd45ohUf7u
         O0Ww==
X-Gm-Message-State: AOJu0Yxoe56dGCz5rG76EEGya0G13uxjbbNqrQj5QR8BJNuUVeLoEad8
	5CNvBW3SnzGzNz5dWSFPbj4ZjwLc3F65vlJVZ1R9hhoTO53EHhSOAeAM5GSPqtnHwC4=
X-Gm-Gg: ATEYQzzl0xyNaji1P4coXCekGF77IHl9YfjKqhii2m7MbQoQW2sLx8oGfmSUs/KKvcT
	6ZdfLjE+hVdd2J3+GKUWqMRNzN0S04tBvOSafH7EJ77hxrLefhcbkfysPWsAxIU1DvcDFfXXfKU
	whUabMuzbq7YDZiUAjOo+R5ZS26zYHwEhopEeKY/V6FVim4wbQrUZ/FD9YHjSrb4TcbCkgrnaGN
	rsnRPmXS7KBb12CvwbF+xqVIvmyP1cH4xEmGdyYseO6rVqZt8kXcQxVNInEQAll77lsKjC1AFFs
	Qk+5lmj3AtbZRVob9+ISh/0KzQk0kzFv8jrUQK67PoRtf0++Lmt6L7p4Fzm/1yq+d3TgFsSpFaf
	stx+Rza7uxbZNGVopenk9QKiDaKcrBEVPWh6FuFacZXAbniKSy3JEE9/QRac2lA9lpE+4Nt9vLt
	4qQ8DDUAz0bb2IWiZIiGYgTrn5RvEjgo0KUc9ChbjHW/WBcGnC5LCh5Q==
X-Received: by 2002:a05:6808:15a6:b0:467:2be4:9e33 with SMTP id 5614622812f47-46ae012ffebmr1572087b6e.6.1775046510057;
        Wed, 01 Apr 2026 05:28:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa0364216sm8252226b6e.9.2026.04.01.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/7] selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
Date: Wed,  1 Apr 2026 14:28:14 +0200
Message-ID: <20260401122818.2240807-6-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401122818.2240807-1-memxor@gmail.com>
References: <20260401122818.2240807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; h=from:subject; bh=pHXaA4TRkerCes8xwbidiOtyvg5MWGqYVLMO9rOw/Tk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs372n3c8aVsbIh76Tvii15/vcpUJT30ly8YneCjikuOXJ euugjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzEp4zhf0ho11lxuQ+t9ul/mn6sXn Nia8Tsg221rbP3/lxz+PKq0o0M/71vMnRcEry5NtJtesnfhBkqFg0rL77Ll/5vH1PqIxC8jAUA
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

