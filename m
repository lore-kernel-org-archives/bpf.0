Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFE36BCC3
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820306; cv=none; b=MRrNqp8IDDQbu206gLAyXKhLpvqsPhLtQcAu/kOJ+7d36oQOtDBJ8qS1tdmzc6b2XNHiOKu5AsyD1Wr4N0whbhD0XLTlbD4oNCMcgiyxnUYbAbir9MxIEOfQHtUpxhvEm4oX8Un+AkUA0e96T6p6tvhDT+K/mGXfd8WgiHeUxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820306; c=relaxed/simple;
	bh=wQYkThJNpe1Fw+ggWVkXwUeWhxnbOaJZUxgaR/LTBuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDBwz8eo2lxdBsi1mmIdvt4juChPqeWKiBnmOGNbNGGOZo4FMdfNsNUSZx7fgk2yQ48/2FXKlwJ1QYlX+wbjlTMs/zDmJzpT5Fwig787HkvYKcrcI79o55nmpHqyA93ol2J0w+Lq1eX/7vDOcaUA6DhBX9uw8hEye3nr1kIEXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6Wa2760; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Wa2760"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d73d6976adso5407440a34.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773820303; x=1774425103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXtcYZ+wA7k8W3RhwLgDRXtYdHuUNRulmFcIOgrevZA=;
        b=Y6Wa2760XKhHlX65T+rk/QnHzmRtnCIuhp5qauQayY55o73QaFqP4NblcbzvTb0yS0
         oTWelGNciAlUWQBRp90LoV7iVcaaufVJIyqrZ27YFG2FHvNtGG1RDOKYgdMCy8PEpHr9
         gE2XsCazlq8V49MvGHxWX1vnk+G45f1DeNmB9BCmh3KXSvPfiolM1TZdyrTsBB8aUXnl
         qXsiRujMGor9uzzNndy6teABJ1mzN4Xnl3FA688LFx+EehN2zo8W5IXKCXZc6Dm9P1Rf
         lKLIoreMayEQY3WWZ2amyobNAb27O+cZnCxO62vEeTEiRy0bDzAl6f8ekmQnr6eI1m3g
         IA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820303; x=1774425103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXtcYZ+wA7k8W3RhwLgDRXtYdHuUNRulmFcIOgrevZA=;
        b=i4xGE8pJCg6xFRcRWvOKyclkc+WOp4CpDIfB35BSPQUBwcZzpibVfH3X4RgFGQA4xZ
         Ft08UJNpM9kRRTqxiduZ+m0IvxwTsZ+y+FwzMvbnEucYJOnHi9Pj8/suGILzPBLEHw5C
         y8B6DpfblnFLReBKmz/x9+1/zpIHn2Q7hqWp7Ub8o6CjM6a2z2448u2Lxvs9l7nz7Jlr
         9s+g+pAuqiINlvOXLsWLE5M2OxLH59dMNirsoSgZMIZaQaMvy9hiuFoM2FdnKnoI2JLW
         NGViDgZwkpCZBwkhrDP6ndi+SQJdNDWLL7FmshpjrvZ/XHCOj8UfZdnfGlimzMH2z2Op
         vXlg==
X-Gm-Message-State: AOJu0Ywzy8Z1Y86iAqSqMtWj3zv+n+TI2kVJQ9L1f3uHPLeqJIBAG35N
	ugpjq0hNQAwpkL4j9705e6+i7a+SPaeC3ilBwA9o3NK+YW22zvWyou/Bz7KJK+W4nQw=
X-Gm-Gg: ATEYQzzNhlyY0DIThHcCAKvfFIzxuj3681/gnYwCuXK0Sy2PPLj7hrPVsvf+fJUhIdz
	5b54iuriskWdOQ5yii4GDMZLGbQp8aVDglpz3ViCcvHujDKd0bwQ4fE/2RO63eM2Gcr6awlGiw9
	YfnKTANQmUvwKa9g0CFPnnvgzCQT7eQpCubpihq/m52CDnQFFE6S01TX2WMBM5mhyQEz0z+GajM
	cwGDtUzDF03jwG4pGGndWE0SnGTJtKwdacAm5oAAEUa+J5dMSvoeogyVE/fWNLgeAVrIGpCzMOu
	LyOuk3H4rbf9tK6zILOukAS4acZLt3p0WIvydMwYzgR1sCa0qOwD4stgbOcTV/90neRxHQKDACI
	iqzm8tPMpiBWfbt21DKXodjjOT5jMsTVb2iCqQOfmFdvzHlKOOh74RGGARdMHTXebh66FhiGbRn
	0IpBzbg6kvibAvmfn1mgkXGlIkX6y2KW/hZyRkn8H9559J
X-Received: by 2002:a05:6830:210d:b0:7d7:556e:d69b with SMTP id 46e09a7af769-7d7ca7ad326mr1600308a34.32.1773820303229;
        Wed, 18 Mar 2026 00:51:43 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b837f0sm1549982a34.21.2026.03.18.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:51:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
Date: Wed, 18 Mar 2026 00:51:33 -0700
Message-ID: <20260318075133.1031781-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318075133.1031781-1-memxor@gmail.com>
References: <20260318075133.1031781-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130; h=from:subject; bh=wQYkThJNpe1Fw+ggWVkXwUeWhxnbOaJZUxgaR/LTBuo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpullsSxFojVLTIcpgh0mTgwpij5Of03/hYvQ7rCJw 9K/+YOaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabpZbAAKCRBM4MiGSL8Ryt9vD/ 9jyJEawxVxYO28n7vfFQWUAUGQ+Mn/DRhEJ2XLnx6/ONH/VTSwCi6luR8YNBWDRGMTqAeF6nU0MUZx geJs1U9mrPWR7RXKJ6djvF11dOGxesKmAWhIT6Fm5j6Dd6Pbt/5fZhHQjIUR5jwdUF87CWjbmBXVnO +q9Pp1oyjCNvZp/F1VUGlzx7IDQpNhxY1A48ZiCvokGWE8EolYCEjQAkjEvfPiRoYmqdPrSeDhvjba mw5o7eBWPk7LDeqFvmIBXT2MAwoahFIjBvZMyJuencclqFxtNkfB4Z0O9/K04NjMHdzHPntDUIqrEU P2t95CkQMY4ONbe97zjY+qfEf7pf4tQAcH4DEmmh0mVHcD60wIdyf8wnuSr8D495DqWl7WTK/YziRN 6p+ITomt10hl4qnPUFi64VzuUMdTS5nPjHY2CdzIy3CMCiBnSEviDZbAwJIiicZ33fytFUkvkVmCia leo0w16R9C2583riT7hIF5txFgG3cUVCQheFHI6TkfMvudD4UoUTPqmAzSjxYJNNof9YMhsfvxLvW+ PgFTBP49/7eT/0nYjlhoWAg3ufHSMhN/G7/gRbylPTZFzsZoa/IsanJIW8Q2qzDzrUs3ONw74gdTZB eZ2k7NwmOc6+3gN3W6Yb4OHpb13xa0IxKJjr3O5FFJDmEYiMy8orc0RsLgCA==
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

