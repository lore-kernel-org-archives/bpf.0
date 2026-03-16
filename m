Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10537AA6D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705568; cv=none; b=WyYoLBSyIRBhSZqQAJTNg1eu9vongM/84vPQcD2boJwBEQHCGoV7ETMLgQgM/Y1QgQpVVC4obvZImmoHnLe0qofq6jLyxZi11InLKAgoeZJLCKiFQPBQyViV4LT7oQIlyDdwIS4V8v3e7FxmxcM2eShl9+smXpVWvKtVSsav3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705568; c=relaxed/simple;
	bh=5J66tsqfN0dFzYI9JDGlx1uCRPUcQrwG1l30iSWodSA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gDburHmh6pM7bBtUHtWKYtXZKz23X/j2doVNa8tGAvUVHDhlJYhCUoXeRXd0pbM5yAwQCbGIAXFpW77W0G7BY4rxg/p81CUEnwidjCfsploEX10IEzuoTLwYaqws2a5VocydHofVj+1/LJibCi4fxXR1JSXbcTyJWbpB0BhY8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=yju+L1I3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="yju+L1I3"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd78a4ce8dso736431185a.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773705566; x=1774310366; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiL+O3D9v4o4KKOA1yswmkmXXXbRU2SUJDjwWqInU3U=;
        b=yju+L1I3OnMBJlPhlWJmRec1IMwHgqkxDB44Jq0Ulh/eyaprxcbvymksZBG+mvRngh
         +5FSW0R0vTHVUG7hjMiw4UiSUbsaYAeUlmEeS29W1sLjn1X3oNI4p/OcVM+GqvHd6lX/
         64ZSdfnEkVpPSpQBjwqsIuVtmJDMVFt/8zX4/rLRlEs7zslSLVi5Ddu7HOkjcyzefQTj
         G7dAnh0NmHaMxARkNg3lIDflDw/mMGfONH+xRD3r2WXjzohwu5UDga/2cCrmHTl6E2LC
         k5qNYgPA7S9XP+rOBr41C4H4+PhDI2zjfEqkC9xXprsCkYqUfxtE7yrWM9lgkP0POjm/
         fqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773705566; x=1774310366;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiL+O3D9v4o4KKOA1yswmkmXXXbRU2SUJDjwWqInU3U=;
        b=TddixnJjz1xh2ygq/4Ou+glbXJlpZfO7/N/YtTmSQmJKbHLBDoQduBeL2Cxjo9/x2o
         R4p08nkh4J+zr15KaJqqsQavjD5tm+Gj/VCJ+1UJA7sad1xU59uHydp+mqYcYgQysdyn
         2lp3HLLwsEWEc7IsizozHYXp6G3hCPV/l4VmtxKdYGezZOTB7M5Ukc8duoq85TxcbYYy
         Ggd9Z65AEcuoUGUx3/dgoN3F3ZwhALEvdltqnucNUtZNj1a+Px/Vee9kLC3FHzk8oN0p
         g4yv3K51Vq6twM37bJEgQSz/2gc3nfJ/ksr7vOA0nJOu2rv6m3dG1yMsBMEmN4EwtVJb
         y/bA==
X-Forwarded-Encrypted: i=1; AJvYcCW8p7pj7BR6aMlT7rONaSdnKesez0etJn3qMoDYd1YaFFt/lwpWy2TgJZ4PwxNCC5F6mEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0p2fFL92dNcs160X40cdTS6EbYOb4Dnjg/i8DoOVnnYOhFqu
	22UH9hKQc1nqNJi6ajnMpdsMo5EkF1Z0OODR0o1lL9/HZc+ZjhrrXsG8yBGV3lC7Qpk=
X-Gm-Gg: ATEYQzzZre0kf1xspBzyudMBks5e/hkmxjgkCAqfjs1WFwzqjhXRxjFSyrxddBzaW6T
	QyQWISD6kOOCLoJ/MifMvrlwW42vf+pRhztclWw1mQUGqOBj/z/+VV04K+0jz6pdybfv3kGjuB5
	DVNkYvP5Y+Ig9e+huc62Nt2rTpcw7ku+iaRHjQ7qnaZVT6DNfwqsirstyPcEiIxF36NZy5ujBOV
	ti6/tZWX1COEFofKzl8Fq9Ihdg8ib3yWCcZaX6Nnbe9CofGPaXCSz/8mzfe6M6eTyE4mvx0/DXZ
	oQv9CvbrjagfxZKWhFmFmkRyRg1dyuZNvpFd70QxqxcTzDTX350U10CbswKztgL1bW1SGjc1hAn
	ADrDRFL0HiiF0BlUCofk3FQvA6sE5nUbz11OgmkA2qvtj72P4U6brgqVgmNKrl1DQEijO56Xo0G
	Fz81c/t0an0qYPgHuJRBhbTB4=
X-Received: by 2002:a05:620a:5584:b0:8cd:b641:b730 with SMTP id af79cd13be357-8cdb641ba78mr1544021585a.66.1773705565782;
        Mon, 16 Mar 2026 16:59:25 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda210daa1sm1342450085a.26.2026.03.16.16.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 16:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 19:59:19 -0400
Message-Id: <DH4M59BX1H28.1ARH281EFIDWO@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Introduce bpf_program__clone()
X-Mailer: aerc 0.20.1
References: <20260316-veristat_prepare-v3-0-94e5691e0494@meta.com>
 <20260316-veristat_prepare-v3-1-94e5691e0494@meta.com>
In-Reply-To: <20260316-veristat_prepare-v3-1-94e5691e0494@meta.com>

On Mon Mar 16, 2026 at 5:49 PM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add bpf_program__clone() API that loads a single BPF program from a
> prepared BPF object into the kernel, returning a file descriptor owned
> by the caller.
>
> After bpf_object__prepare(), callers can use bpf_program__clone() to
> load individual programs with custom bpf_prog_load_opts, instead of
> loading all programs at once via bpf_object__load(). Non-zero fields in
> opts override the defaults derived from the program and object
> internals; passing NULL opts populates everything automatically.
>
> Internally, bpf_program__clone() resolves BTF-based attach targets
> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> func/line info, fd_array, license, and kern_version from the
> prepared object before calling bpf_prog_load().
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

The bot's suggestion is technically right, but unrelated to the=20
correctness of the patch. It's implicitly assumed in the code currently
that the provided arguments can be fixed up by bpf_prepare_load_fn (that's=
=20
what fixup functions are for). Adding a mention that "as with the regular
code path, fields may be overriden by bpf_prepare_load_fn" couldn't
hurt, but is imo optional:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/libbpf.c   | 61 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   | 17 ++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 79 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad20..0f6b9e773c52 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9802,6 +9802,67 @@ __u32 bpf_program__line_info_cnt(const struct bpf_=
program *prog)
>  	return prog->line_info_cnt;
>  }
> =20
> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_l=
oad_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, attr);
> +	struct bpf_object *obj;
> +	int err, fd;
> +
> +	if (!prog)
> +		return libbpf_err(-EINVAL);
> +
> +	if (!OPTS_VALID(opts, bpf_prog_load_opts))
> +		return libbpf_err(-EINVAL);
> +
> +	obj =3D prog->obj;
> +	if (obj->state < OBJ_PREPARED)
> +		return libbpf_err(-EINVAL);
> +
> +	/* Copy caller opts, fall back to prog/object defaults */
> +	attr.expected_attach_type =3D
> +		OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_type;
> +	attr.attach_btf_id =3D OPTS_GET(opts, attach_btf_id, 0) ?: prog->attach=
_btf_id;
> +	attr.attach_btf_obj_fd =3D OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog=
->attach_btf_obj_fd;
> +	attr.attach_prog_fd =3D OPTS_GET(opts, attach_prog_fd, 0) ?: prog->atta=
ch_prog_fd;
> +	attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags;
> +	attr.prog_ifindex =3D OPTS_GET(opts, prog_ifindex, 0) ?: prog->prog_ifi=
ndex;
> +	attr.kern_version =3D OPTS_GET(opts, kern_version, 0) ?: obj->kern_vers=
ion;
> +	attr.fd_array =3D OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
> +	attr.fd_array_cnt =3D OPTS_GET(opts, fd_array_cnt, 0) ?: obj->fd_array_=
cnt;
> +	attr.token_fd =3D OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
> +	if (attr.token_fd)
> +		attr.prog_flags |=3D BPF_F_TOKEN_FD;
> +
> +	/* BTF func/line info */
> +	if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> +		attr.prog_btf_fd =3D OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->bt=
f);
> +		attr.func_info =3D OPTS_GET(opts, func_info, NULL) ?: prog->func_info;
> +		attr.func_info_cnt =3D OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_=
info_cnt;
> +		attr.func_info_rec_size =3D
> +			OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size;
> +		attr.line_info =3D OPTS_GET(opts, line_info, NULL) ?: prog->line_info;
> +		attr.line_info_cnt =3D OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_=
info_cnt;
> +		attr.line_info_rec_size =3D
> +			OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size;
> +	}
> +
> +	attr.log_buf =3D OPTS_GET(opts, log_buf, NULL);
> +	attr.log_size =3D OPTS_GET(opts, log_size, 0);
> +	attr.log_level =3D OPTS_GET(opts, log_level, 0);
> +
> +	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
> +	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> +		err =3D prog->sec_def->prog_prepare_load_fn(prog, &attr, prog->sec_def=
->cookie);
> +		if (err)
> +			return libbpf_err(err);
> +	}
> +
> +	fd =3D bpf_prog_load(prog->type, prog->name, obj->license, prog->insns,=
 prog->insns_cnt,
> +			   &attr);
> +
> +	return libbpf_err(fd);
> +}
> +
>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
>  	.sec =3D (char *)sec_pfx,						    \
>  	.prog_type =3D BPF_PROG_TYPE_##ptype,				    \
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index dfc37a615578..0be34852350f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(const =
char *sec,
>   */
>  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> =20
> +/**
> + * @brief **bpf_program__clone()** loads a single BPF program from a pre=
pared
> + * BPF object into the kernel, returning its file descriptor.
> + *
> + * The BPF object must have been previously prepared with
> + * **bpf_object__prepare()**. If @opts is provided, any non-zero field
> + * overrides the defaults derived from the program/object internals.
> + * If @opts is NULL, all fields are populated automatically.
> + *
> + * The returned FD is owned by the caller and must be closed with close(=
).
> + *
> + * @param prog BPF program from a prepared object
> + * @param opts Optional load options; non-zero fields override defaults
> + * @return program FD (>=3D 0) on success; negative error code on failur=
e
> + */
> +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct=
 bpf_prog_load_opts *opts);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d18fbcea7578..e727a54e373a 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
>  		bpf_map__set_exclusive_program;
>  		bpf_map__exclusive_program;
>  		bpf_prog_assoc_struct_ops;
> +		bpf_program__clone;
>  		bpf_program__assoc_struct_ops;
>  		btf__permute;
>  } LIBBPF_1.6.0;

