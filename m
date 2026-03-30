Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2253CA481
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875424; cv=none; b=KuJPBe2FzuX7Mu/CngbArRZYoUacIXJmjJFKf0bcoolc2vupyLeXNwq9rxvUurqB7GkamMl+GVcMlumVJpeWaXSRrapV6YopmXD0JiruP1sstYX/AgDwTUc8A945T7P4hEHWBZee4ccA5E7tmPtQVEIibmbi+JoeLK5vpdlDhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875424; c=relaxed/simple;
	bh=g0oZREsmGiODs7/YG+QTv4JP9p/mr7Bg51WLVfEgLpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tt0NtrkRnZVReENTsh2nj5pzLc9kU4ElxUQMeFHcM8Qf3uB2jSUlp3ELVzbkyO2jNp7YU+Dpg/dHjl421hUuVf3zaPLaaq8S8moz1ms++owenNgdwRZkbyK35K5jSysZHT90qF8T2SHKEVHeh7URyN5iLfj14ml9eDeKRiKLMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIn7eEOQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIn7eEOQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4873ce69ba9so9670575e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774875421; x=1775480221; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7/MeUh61MXZTylrwqC1wsXNYnHs1momA84SMjXKVBY=;
        b=pIn7eEOQkxYs3CWSRhPlJ1vT2wPZYg82hf2Opp31GS+N2XtUaxFViHtiZsVJBdVxr7
         SNfk6RQnFdHpab2X/B5koT1njIc8JbmllIOzZDCnI45aBE2+wsQA37WNIZUkx5nWzbQn
         LkTseCyC5LAXvYh1DHkGG/JDSKhuoauX3YsKnLnW3NLgMhrWQy/RYZTDxPRq/XpaXCLU
         8trLJwdH13MdyRjewde99QmKoywihuGp0TlQI1Srlpvkrvd9nKB3V3c5oGxdY0dq9nKD
         P1r5TqnE8qAhi5NgkgIhzOAi3BHpw+je0UoLjmhdS2GueUafkLTPmY0lQHVwDh2xOHI3
         a4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875421; x=1775480221;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7/MeUh61MXZTylrwqC1wsXNYnHs1momA84SMjXKVBY=;
        b=oOgopl4xEf7j/uD9YbUmtbdmzHCMmHzJ/CrOsbd66bLi1LAYQYMTS/lVskuo3dCQV0
         IM8RQSs0U70DWX84dTs1vU8NiUZRb/XwcV+0pxL5C8XbLrm6jtZ8xkljzCjVIokDF8wf
         3qxX+VJqB0iTDX7ZjsQ72YYjUuhndcJWXPzKix4L8jyDOasIn5uZjPKS4cCykZF7odib
         9gUaTi6wITT/b6Tgp1bnsSMb6q1og5vgIUFyHV/DYVIsEg5aP55Q2x2ELuQjV8y6Es4a
         LM2CPbG8w6WFIKHBvJd9Xj5mRUyGRoeCiI1yh8/3l7rNv5Dvj0yd0KKwy3Ddq0NHx4sP
         izGg==
X-Forwarded-Encrypted: i=1; AJvYcCXjB8mWl26BQLphLCUsYyRLGTtfgWM+oycx7kqZf+ww4dfG5xQuAwrMkxapl77gUCXLAKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxJ91IR/UlnlF8MYX+d9JnJTR1uH5x42HF+vvKPt5WaB9YYU7
	XUoIX8WgoedDiFSg74g+bxtmMOUKxgxCw3Lb/T97E+W7Cx1BIAd5wHT0
X-Gm-Gg: ATEYQzyNLl9QnG+DYWaw7ufy7abkMKWBSfrB14aPmpz2EYO2otC7wCTEW2sbAALtrG4
	ICpUuHc7r+iadhw86+HAUx9dZy013oPFpcnCPH3bAfRJEk1Wt5Gi/kfPsJF0KnTI35PWcXlD4fh
	md4NL8nWqU8eoDeg3tx8zwK8DI0MRRerYelW4W0snDtdlyfRVGz5wW+jEVsLj7obHiuN1p2JCOh
	YKqwC/vppnx4Dw+d4P1XRDtBkD3QJtjEgk64ugqNO7qiC3x1o2G+U9sHGhYPXjiJBj8TThv5a05
	D5SYVaxfazYTpYGMk0+dj2G7rFbIHuxmSrrkVXSafRcWmSgwENTHAE/hg76U39CmQNoZ4FizjuV
	r8Txpb4x1fhRJm7+9bmi59iVdOWTZEqTTThKulYA/vB39jZT9H9pFU3N5FACchzfmw4iv6vWmvf
	oWvu8xzM38yX1QL9M=
X-Received: by 2002:a05:600c:4685:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-48727ef67f8mr219539535e9.21.1774875420831;
        Mon, 30 Mar 2026 05:57:00 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:4b08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873881c195sm52375115e9.9.2026.03.30.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:57:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 3/3] libbpf: Wire up verifier warning
 display logic
In-Reply-To: <20260329212534.3270005-4-memxor@gmail.com>
References: <20260329212534.3270005-1-memxor@gmail.com>
 <20260329212534.3270005-4-memxor@gmail.com>
Date: Mon, 30 Mar 2026 13:56:59 +0100
Message-ID: <87ldf9h3vo.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Wire up the flushing of all accumulated messages in a program's stderr
> stream after verification is complete. An example is shown below of a
> warning printed now about usage of deprecated kfuncs.
>
> $ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl -v
> ...
> libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': VERIFIER WARNINGS:
> WARNING: kfunc_implicit_args.c:40 calls deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
> WARNING: Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
> WARNING: For older kernels, choose the kfunc using bpf_ksym_exists(bpf_kfunc_implicit_arg_legacy).
> ...
>
> Note that test_progs overrides the default logging function, hence -v is
> necessary. By default these messages would be printed for the user.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..f308bacd083f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7826,6 +7826,27 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  
>  static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
>  
> +static void bpf_object_load_prog_emit_stderr(struct bpf_program *prog, int prog_fd)

nit: Not sure if this function name is a good choice: it does not take
bpf object and does not load the program, I'd rather name it
bpf_program_emit_verifier_stderr().

The implementation looks correct.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

> +{
> +	char chunk[256];
> +	bool emitted = false;
> +	int ret;
> +
> +	while ((ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, chunk,
> +					   sizeof(chunk), NULL)) > 0) {
> +		if (!emitted) {
> +			pr_warn("prog '%s': VERIFIER WARNINGS:\n", prog->name);
> +			emitted = true;
> +		}
> +		libbpf_print(LIBBPF_WARN, "%.*s", ret, chunk);
> +	}
> +
> +	if (ret < 0) {
> +		pr_debug("prog '%s': failed to read BPF stderr stream: %s\n",
> +			 prog->name, errstr(ret));
> +	}
> +}
> +
>  static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
>  				struct bpf_insn *insns, int insns_cnt,
>  				const char *license, __u32 kern_version, int *prog_fd)
> @@ -7950,6 +7971,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>  				 prog->name, log_buf);
>  		}
>  
> +		bpf_object_load_prog_emit_stderr(prog, ret);
> +
>  		if (obj->has_rodata && kernel_supports(obj, FEAT_PROG_BIND_MAP)) {
>  			struct bpf_map *map;
>  			int i;
> -- 
> 2.52.0
