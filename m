Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB996364EB7
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830139; cv=none; b=AhEvSwkTbqTJP8HqUTD1K2id/kOaxwsetKZLwQMHnRG+pGemlbt/6pmvn8tKH7YHuZ1zA1h8sRT8I8bK49TxVOFewl6ER0rh9qtF2e2trRStD/hSD9+HNW7MlrCfdxGCZ8aylNp9O7z9EF4Ze9WmxGFHr+8nO5aQQq3LjPYreII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830139; c=relaxed/simple;
	bh=wQYkThJNpe1Fw+ggWVkXwUeWhxnbOaJZUxgaR/LTBuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOqUDkOh7/aBq4NYdQfIVXMQ3VJPx2F2fzseGYpd3tIrYzDNuNQavUXJmxEAhuhnNXU+k/j4Nrkwb908J7J942I9J2HzX2e0eBYwNYe0AkYvyKTptSUzb276yAx6UgXoudps5AiQw/N1Pofr/TT/jvlos/hTfEJJ2ir5b+HCX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFT6+Kxx; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFT6+Kxx"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-46703fb602fso2394402b6e.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773830136; x=1774434936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXtcYZ+wA7k8W3RhwLgDRXtYdHuUNRulmFcIOgrevZA=;
        b=MFT6+Kxx4zWML4RfQRPeFkRTBPTXA8KLudE1r7Z5QmYh4MPvErv/bq5VsgTaFuDELh
         uSxU+qKuZlXd0VYNK3k81PI4fbiIm4M9ugUk30Wir2Lbe+uFrwXS6H3LQV0uoYt5eGZ6
         qAv4n69ehk3BPKcjz1FKP48c283Zvw+NZ7pJ13n1Si1CR4xG2t6VdiX/XfHM2VLwxHjY
         P4I1r0xOut07VDetoFG9hj4t60bwFFfyZSgEH+O1ctJ43rQN7vnf6LtqohSY+WD0QiuF
         8weDYN+u6c+x4uFxLiadifP1U3DsRENbSVYV/h2Z6VOl7wxJl8pOLsKVOSCCQ9CLR8Ya
         Aeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773830136; x=1774434936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXtcYZ+wA7k8W3RhwLgDRXtYdHuUNRulmFcIOgrevZA=;
        b=A+wgOdFaZAzf8YPu2PTxutJSXSOa0RFO3OVKfYLTz2GhlEQZa5YLAmqFh5hsS3uRhw
         3oup62i0F73S+aWlVIz2CMf3vd+iPaJ9gE+yXFCsammmtETQQAKZFQtxu+AKHapEgeeD
         mdvjiArRPviM7t4JWMOhZJwF7KaOUuYw6PrxBxIpvhqhe3IsbCJj08QdbUtSy4ZxQSDQ
         oOEUzUp4u5npdie5+/ZQm7WwFtpTUVwdlvA0xGVQjA2bhAYTWWQQm7ULVUNQxJaIv2df
         MEr/o1P3qSIXeYQptxdSjw3Cm0BPcjeCQmJsLRj/b7Gcs82vrhP6BqppjVThHl0aSJt8
         2RgQ==
X-Gm-Message-State: AOJu0YzT7z55sfova9GhyxTJ1d2Y0hcslpMnF+EhcIPkS3ndRrvftfSs
	1oNGReEB2mhzT23kmiAdoJ/UKkd4Jp752kRBqmE/CZbC9jKlVIlqckJHE+dy45txe7I=
X-Gm-Gg: ATEYQzzbeBqwi2yG4rPb8ePTkhKuBbYL1Lz3WYMkzWqUq+FDirreVFETOzTHfJyQWLm
	OV3F35iZlq4Oo29VCFjcdeCPXZoG0zjRpDjfEJN4VT/GcWfQ5Z5I0H6HpNsh3GNw3xubmOHBWWs
	NLh5mp1fKTOi6nVUP5KEa+CmUk4Onafr7BnOA2esTfhWlVSAsf1TJ0pTxq85fzHH1mBsaBRJXQ+
	M2SzYMfmLLFGH9ss41KqTQb3IJiMsETNGAkmKz1E5/8BDxfNlP7QUVwOsFQ7loP+EhgcWxldzDR
	x7UeJF5MiCld6l2CRIctfiDv4LDwmCatgvNKBnk2KvCMG3yX7JgQz/JjYnQ2b8kQhPTojbYJypt
	eh8YWquEXyXbz9x70dG9OfawBEL5TOrDbClv/9EIDkGHXNdHFPUwEx+jbr5/m9MG0oC7mB36WJO
	d+qzy5JQdI4+IXisVQC8f2bCWq/z3RGaX9DNMqpqlKzodq
X-Received: by 2002:a05:6808:1395:b0:45f:481c:e258 with SMTP id 5614622812f47-467ba10a8famr1482166b6e.16.1773830136195;
        Wed, 18 Mar 2026 03:35:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2c30b0fsm2245820fac.10.2026.03.18.03.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:35:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
Date: Wed, 18 Mar 2026 03:35:26 -0700
Message-ID: <20260318103526.2590079-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318103526.2590079-1-memxor@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130; h=from:subject; bh=wQYkThJNpe1Fw+ggWVkXwUeWhxnbOaJZUxgaR/LTBuo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpun/lSxFojVLTIcpgh0mTgwpij5Of03/hYvQ7rCJw 9K/+YOaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabp/5QAKCRBM4MiGSL8RyiDkEA Cz1EUduK1QS2e7MezKzUE3nKOjb/UBHFmkNxqhjADuN1FN6bqHbw0zGWaX6fBaqQugcmikBpJvTFGa mJqC2uYWj+04b2Nh7AKCVP+FA4/HO3HdSrOqIPN1d9XkNt/nWhZwmADE2JqGrNMioYMwsTAZi0vq6b 17Hv0YsIuBHJOpJw8WcO0S3YNoso/Dpt9aKevRb/xhH5VZjEwoWqQnxuVMW073z1pUWlUZHKCGqma5 Fnr4iPLau5k/nEVVRzENTutzx3jwIfkqVJtYtzsZNVi87ozra34yt4B1aX17UTFmv0RLh1VbxGvZWV 0CpYRpN2+zMRvc9YNQVDQRuqeBMiAyiioilMfMl5TE+wRVhSQDGVhQhBFfGnuJJr2D6UAc94xi68uk +LonZ7vSbpScXz5vdclRnij8WwauzyZa8Q/+dxgNmPG9Q8HnhJXDhBYGGX+BTGT6ezupihLjx3AzmA KqRt/cqn9eMuD8T5o5LoVfShuoRZbaEPJGyFqx1IeB6fjpP4OrjBVtHm7IXqIRg9igqKkRcbJJbzco rQI0cpb2t+F6zeasL4SNiicRDyti1cifFywpD7+3V6shcsDVt+3tq21N4tgD9JtEIeoP8nQiCMq3mh auCSmztBQ5pL0wHItnfwoKRfRznXbA65qTmzEEHbrntb0ih0uo0OgTKrKD6w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that global subprogs and tail calls can only accept an unmodified
PTR_TO_CTX for syscall programs. For all other program types, fixed or
variable offsets on PTR_TO_CTX is rejected when passed into an argument
of any call instruction type, through the unified logic of
check_func_arg_reg_off.

Finally, add a positive example of a case that should succeed with all
our previous changes.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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

