Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5F3F660B
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779282; cv=none; b=gw7TM28hGJjMIBrUdgVDnpRAaIkRdE4PfaX/mQ83iZVCWMzpnL2paMJ07EtskYKwLMBVw66kS39YY4e9ocJOCks0qo0BlE3BrZ83G6HcQMZdea//7GxcFkcObE/uVOBkEpmbMFD+diqoxPTuWZo6avXs+j/aQmTQyNki6d6+DaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779282; c=relaxed/simple;
	bh=xwSfB1tr4xfJtz8wRTY+T//f2zXdT2LL7Occ5OWGG2s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m0jwDVCnnuWI7UUiqGFkKzkqsd+0INcUPU0JRDdt0VlO/OVXND3Z9cjLnQ3hgGe78nsTc0zNGrCJm02K+ZQ13H1scb5qtrH3ryb9NjvrI4/94I9urlA9thoYkvYWkzS4P2FWs9UaU0+fIrwbjwW24W7G/g6pjABFZhpuXNsdUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmMFVysK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmMFVysK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8261F00A3D;
	Sat, 15 Aug 2026 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779281;
	bh=KpiYwbGOEJ/hPUtkDBFxyxO8EKT7ksIY3t2opY+96to=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CmMFVysKn8tIncfV9ZQ0QGDxlI1UtnD+zNJ8LSvgtxk2+o7u/2S9/UKioZLCs1aLa
	 OtGFojffrQcD+8cbqiTSyM1S57c3xwJZpDyZ5wWx0XxjjCbfp8+Yhrxmc+Jp6ZeqgS
	 PNJDA7Do+zj5jss2imfW8TFqYXyXrqgBiius/ofbHnCRr8wD8hMJOvwd7hlosEMWi4
	 7AaSq3TRcuOn9dOj+BiLx4LpBO65z+OcI/K/NSunZSJyibCqKP+Yy0tB/oikltMKIh
	 oQH4vZIbe1wFdES0MJIbnYIjLc340JW6Zrfu0dXAmpQOopOdMO7LevmC6pHw2LBYOb
	 97xmah/VFyO9A==
Content-Type: multipart/mixed; boundary="===============7863268154606667789=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0dc914070f578da387c3dd7216691e7d90fedd1f0a029da6c197e9be098861f@mail.kernel.org>
In-Reply-To: <20260815064612.378577-3-memxor@gmail.com>
References: <20260815064612.378577-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 02/14] bpf: Add source and instruction diagnostic context
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:34:40 +0000 (UTC)

--===============7863268154606667789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 04cadd987169..ffa5626411ac 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4147,8 +4147,16 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>  }
>
>  const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off);
> -void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
> -			     const char **filep, const char **linep, int *nump);
> +struct bpf_linfo_source {
> +	const char *file;
> +	const char *line;
> +	u32 file_name_off;
> +	int line_num;
> +	int line_col;
> +};
> +
> +void bpf_get_linfo_source(struct btf *btf, const struct bpf_line_info *linfo,
> +			  struct bpf_linfo_source *src);
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
>  			   const char **linep, int *nump);
>  struct bpf_prog *bpf_prog_find_from_stack(void);

[ ... ]

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index e75753552a4d..815aa7938b50 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -14,6 +63,138 @@ bool bpf_diag_enabled(const struct bpf_verifier_env *env)
>
>  static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
>
> +int bpf_diag_init(struct bpf_verifier_env *env)
> +{

[ ... ]

> +static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char *first_prefix,
> +					const char *next_prefix, const char *text)
> +{

[ ... ]

> +static void disasm_print(void *private_data, const char *fmt, ...) __printf(2, 3);
> +
> +static void disasm_print(void *private_data, const char *fmt, ...)
> +{

[ ... ]

> @@ -45,3 +399,139 @@ static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
>  	verbose(env, "%pV", &vaf);
>  	va_end(args);
>  }
> +
> +static void diag_format_source_text(char *buf, size_t size, const char *line, int width)
> +{

[ ... ]

> +static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
> +			    const char *fmt, ...)
> +{
                                        ^^^^

Could bpf_diag_source() be annotated __printf(4, 5)? It is a printf-style
variadic function that forwards its format string and varargs to
bpf_diag_vfmt() -> vsnprintf(), but unlike the other printf-like helpers in
this file (diag_write and disasm_print, which both carry __printf(2, 3)
annotations), bpf_diag_source() has no format attribute.

Two consequences:

At W=1, scripts/Makefile.warn enables -Wmissing-format-attribute. GCC flags
bpf_diag_source() with "function might be a candidate for 'gnu_printf' format
attribute" because it does

    va_start(args, fmt);
    msg = bpf_diag_vfmt(env, fmt, args);

and bpf_diag_vfmt() is declared __printf(2, 0), which is exactly the pattern
the warning targets.

At the call sites, none of the format strings can be validated. Later commits
in this series add call sites with formats like "R%d is not readable", "owned
resource (id=%u)", "%s changed from %s to %s", and "%s %s; depth is now %u",
but the compiler cannot check the argument counts or types match the format
specifiers.

> +	struct diag_fmt_mark mark;
> +	struct bpf_diag *diag;
> +	const char *msg;
> +	va_list args;
> +	int ret;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============7863268154606667789==--
