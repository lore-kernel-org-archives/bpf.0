Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A23E3C56
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846788; cv=none; b=eNUWBMppxgLFdhTs9rwgqHYZ/EXvyUlNWKKe5uFBischd9LFEpnLVB3CusKn+tFAsox2hpyW+oh7myPkK5reqY3ATAc+N5q9MuCKZzR1p/oWwc7wvd/6jN1Zl5k2WvCRicU15B7rwpbYnWCuAg0GPFoIqtgCszLkemUe73Hn+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846788; c=relaxed/simple;
	bh=0rK5t7o7XZcW8rDEyeqeNAEm3GwDSgP3maLLdMbe0NA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7MDZuPUy0B/m1Zy65mdodl1EAJVe0Aad5bLzpe19ZOAM9c+qYFviMQX2P43KEmayvvyYwl2GqhLsenqzy+2Vq0QzF+catiWnrEf193Iqc5nVXMNY8AXT90DKZWWQkZ2C/tEVxLQLkIhBQU1EoNV+nr8wqHbU5VPEmk1fenGmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi7M6Yhq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi7M6Yhq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b47b95a77so2518147f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773846783; x=1774451583; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qN5ci2rCYIxTdPvL1PJMLihjsz36M4qZI3QGvy1fsXQ=;
        b=hi7M6Yhq5/PiqUJubDgFIyuyjROqcFv/Z2LKtgEl9NACgyxQzjlSi8P3ZboLVUAk+a
         avv3UjCfgVsG03ub+RJeVf/3U0KkWIl+Bn0dmJMarmEe/2sJgAeCfz1pF/sRPo9FADEw
         qdyUdcsF/ZXzUfjp+fbjRrHCM+7EjMvb/fLzq+OADAoSdAfY7H5QUBs/XdGEUYdarhqJ
         yXcL4zPCbZWIUhZ15K537bXkHPSHgntTkM+PsRruIh2j7DL3JJnHOTe678pTyxi8LfV6
         mLSVTp+lSewu/q6fZsYo0S+DV/lcTof21U6QOksdKEArWYu6JVdOVdN7TzTLnAEPkcRF
         bASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846783; x=1774451583;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN5ci2rCYIxTdPvL1PJMLihjsz36M4qZI3QGvy1fsXQ=;
        b=LdZ4vfvF6/UE/moS+myKUpoNdYSG45KIpLV2wXZedrBqkGNEVf9bbhwDyw1Gin3YC5
         7eWTt7XsrQYZ45hfHv+ru8G7fV7Wcl811K+3asKRqgZAJGSxLg3V4SiWX/gvOLuOj6JT
         uN1439K4ooDQoyb6qZft9aWjElPf7uk+G6+UsRH7e0jcV0XKKp+gmvs5cxRiJUO2Q95R
         n1Co25qiKG+o5GWbZMjoCPBIg+XSnRO3zxzjGJ0S1FAzyc4ttB2dBiYdwyaUt8MPM0o7
         Vpk1SVn3FD4NEiB4WsQ7ID03QQRlMH+OadrrcjAB6JeTJX1kFHgO6uHvefLtg2Fx92GC
         e8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXVSHdUDiqcxz40e+z/HRrEi/zFWjNQilo9jJzoONXYLBiVWm5jqm/eraa3GeFeupyLmws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVbrNAZz+JZX/PIXXR8ABt5dY/hw/o/uCzTSUvaK8GfQazHuD
	PD/Xbpu0B8ugQ7JcEtSDUNG+hwe+uKIo2oFe9QKfTNQQY90EppB1u37v
X-Gm-Gg: ATEYQzyaiNhTEekoAeAK7HfCQHbht5c9LWBI++zO55dMU6vfd4OcLZLpdEEaJiO7O/a
	dc9gFh7tB8dRBC3P8urJLHn1NrWjpyhezqekJMsCVy5k01JL0eEp7XiwwaGnkV4WiibERkEikx4
	99ABP4BdXQj4j2lnsJ8HcZ4bJ9ZxnW6yQL8ut0kDySm8EyAuswJ0kCH3qdvdN/Zq+ZYOBE3saEK
	tTSF9DU9GIhFv6lJZCXDJVSUVv+dg1XMLjhQekiPgHej6Yx+/qvWx7qiOFRgJxI/O+yFFIOyj00
	XwNv8MGz1u2WA6Tsb/B6Go/D5j0QXe/1TU8LrndpPvJs3gPFl/u7uvIc5NTYSXUEN/heyH9EZ/m
	lHkfbJkpjLm7v5wslYOVShJ0mE1qezjdIB5QHxVkCIo3hQ5Z+8QVC1nZCLs2gz17/q/r5JjtrNE
	2qGrNvniJoBXc00mv4eCAC3GAPB5Yk1PyiAeAibH41tnHH
X-Received: by 2002:a05:600c:1e88:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-486f441bc30mr66826945e9.6.1773846783409;
        Wed, 18 Mar 2026 08:13:03 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaffbbdsm146448875e9.15.2026.03.18.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:13:02 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, Dan Schatzberg
 <dschatzberg@meta.com>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Test modified syscall
 ctx for ARG_PTR_TO_CTX
In-Reply-To: <20260318103526.2590079-4-memxor@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
 <20260318103526.2590079-4-memxor@gmail.com>
Date: Wed, 18 Mar 2026 15:13:02 +0000
Message-ID: <875x6tkw75.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Ensure that global subprogs and tail calls can only accept an unmodified
> PTR_TO_CTX for syscall programs. For all other program types, fixed or
> variable offsets on PTR_TO_CTX is rejected when passed into an argument
> of any call instruction type, through the unified logic of
> check_func_arg_reg_off.
>
> Finally, add a positive example of a case that should succeed with all
> our previous changes.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../bpf/progs/verifier_global_subprogs.c      | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index 2250fc31574d..1e08aff7532e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -357,6 +357,100 @@ int arg_tag_ctx_syscall(void *ctx)
>  	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx) + tp_whatever(ctx);
>  }
>  
> +__weak int syscall_array_bpf_for(void *ctx __arg_ctx)
> +{
> +	int *arr = ctx;
> +	int i;
> +
> +	bpf_for(i, 0, 100)
> +		arr[i] *= i;
> +
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__success __log_level(2)
> +int arg_tag_ctx_syscall_bpf_for(void *ctx)
> +{
> +	return syscall_array_bpf_for(ctx);
> +}
> +
> +SEC("syscall")
> +__auxiliary
> +int syscall_tailcall_target(void *ctx)
> +{
> +	return syscall_array_bpf_for(ctx);
> +}
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__array(values, int (void *));
> +} syscall_prog_array SEC(".maps") = {
> +	.values = {
> +		[0] = (void *)&syscall_tailcall_target,
> +	},
> +};
> +
> +SEC("?syscall")
> +__success __log_level(2)
> +int arg_tag_ctx_syscall_tailcall(void *ctx)
> +{
> +	bpf_tail_call(ctx, &syscall_prog_array, 0);
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__failure __log_level(2)
> +__msg("dereference of modified ctx ptr R1 off=8 disallowed")
> +int arg_tag_ctx_syscall_tailcall_fixed_off_bad(void *ctx)
> +{
> +	char *p = ctx;
> +
> +	p += 8;
> +	bpf_tail_call(p, &syscall_prog_array, 0);
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__failure __log_level(2)
> +__msg("variable ctx access var_off=(0x0; 0x4) disallowed")
> +int arg_tag_ctx_syscall_tailcall_var_off_bad(void *ctx)
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off &= 4;
> +	p += off;
> +	bpf_tail_call(p, &syscall_prog_array, 0);
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__failure __log_level(2)
> +__msg("dereference of modified ctx ptr R1 off=8 disallowed")
> +int arg_tag_ctx_syscall_fixed_off_bad(void *ctx)
> +{
> +	char *p = ctx;
> +
> +	p += 8;
> +	return subprog_ctx_tag(p);
> +}
> +
> +SEC("?syscall")
> +__failure __log_level(2)
> +__msg("variable ctx access var_off=(0x0; 0x4) disallowed")
> +int arg_tag_ctx_syscall_var_off_bad(void *ctx)
Test cases for subprog_ctx_tag() and bpf_tail_call() are duplicated,
even verifier error messages are the same. I don't see a better way to
avoid it though (macros as in prev patch look worse).
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off &= 4;
> +	p += off;
> +	return subprog_ctx_tag(p);
> +}
> +
>  __weak int subprog_dynptr(struct bpf_dynptr *dptr)
>  {
>  	long *d, t, buf[1] = {};
> -- 
> 2.52.0
