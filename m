Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538A31D72E
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776457; cv=none; b=LCRdJ1tMJwsofYedKBOpv8Y1jlvFviUF68AD+CAYEohNGnpbleDcB1vt4gkQsuFlwuhDDKtiCNhphRNKwcsCtrZFhYd/AVx7n3cIVPgxxIz//CeOnb7Sj9SpMcukHrM+4kx8EZz37sETOub4KiN4RXG9JaEs7yohwbE3i3k/hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776457; c=relaxed/simple;
	bh=01HbZbM0zdprc8yChmYCINd1bxq2utHQM3xlU28okE4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jwn1ERPS1L+MJFdCCgd9UMSKOjc22VoUMIuLffgCjJF5ZVVZEF8LD9Lulgp+aFmIa4irE30csBIFTisUSdiJyet2fa8L0z/r65kMGS5K6hcgXQ5UqWIWpsIATfI86CxDnNcmTIAtghq8imlYhhpkmPpzZu3M7fKujezYoknoV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=w2qy0i3k; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="w2qy0i3k"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb4136d865so812895685a.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773776454; x=1774381254; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8JvZGOFobEOl6mYh4wi1K3TVvcutoHt66zqpjOWO94=;
        b=w2qy0i3kZuhwbNN/mTcqHGWlt6tLcNcxPGivMzEKU1biQCqzlYiXsihhglvObB/Snp
         5OZE1SWa9aKRcz8aVi7RnOQknQ1JyfI5xQz2HrgO2gxpsMr/XNkwjFBaxmEdmbFr4uGh
         C2gI+nayneEWsXmblMUEbsXhnP+jlUz2kxi67qOwIGR5MOXm+DvAdHc0rbszFT1rumPf
         tcUYg242NiHeHDb1xy8a/qwuGUmqo4cN/dvUG6N1s3Vi7MEaD1LeAY33DdX1CswIJZic
         1HWl4t4J1WlnoVkDdDheD6Jbp8Fz0Akd+3SApHlWPzbt0seD7WN7EE02kKFJV6TgrvN4
         ucjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773776454; x=1774381254;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8JvZGOFobEOl6mYh4wi1K3TVvcutoHt66zqpjOWO94=;
        b=mn+vRpNW5a8M++PKorcAtBjOhCDh9lROfYFg6QiUgPPdGRkfWHOgCzRC9rkVkLIMQh
         fBgzbOQz0cxpdpaI1h8zxPZ6MFiALW1lRTu7sRYSiNkuWEbH4FnAzhS6hpJhWBHgtxlM
         0oVZS2f2WuEn+cHQMQDwvB9VXHuo5eSADzrcoZChI5wNZ9ZWao7RgUORoKWolb8F5Kaz
         UT4UPlT15Ywc1FfXteUZPLn3EO4hiVE4YVE0UUr5YgJVsMGStXFIa2XTXL/avOdjCC5h
         ZSIVp2/Fi7S9cSAL7cCyHm3hA3xUdJRUKUTJFPCugqpzg2zgG8H2jTN3SU/xWJj/zQRV
         4LHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCzVy/B/wtvNZXu5TrXSac2wDDONzKXfrA92obR7swRxA0rb2Tj2V5HEGRv8kRILZYdIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGFg2D79Roe4/uYt3WUL/GUTxoLdxnBqhYtZyxO2yP6DRNz6V
	Wt9EAECu63pFOWCAggfpgSL6G65DIdQyVNZbnVgbtBzCKESsV9ZCPfEQyy9aCSJaqr8=
X-Gm-Gg: ATEYQzxD/dEPCO4ubiJsZmqgwlIOdYTpn1JXLgpbP/BRUcbdrb9ieIcVk5O7nx0kjbS
	fxXlHe9DhSDxl8gfHEUFllvtZ0RqPq9gAl6O0uwY9xFnENK351RvTJ9baINN2Mwo4AGBTFEwO61
	gWHsHs+D2CrcbgEBqwZtv/OYRW9kXurWACAvMBhuW/rNKcdXN+YhgmR+osVIN9Lvia1j5NVXtfg
	dQEhw3iSp14G+1oSk/uWRl8kyHlxlXUhOf9jdJXqvzUJ9Wpvy6Gm/cDGiTn5GC88pK7qlx1C7ME
	WQPkDGtiY52fiwIAQzALdpqEeGCZ/lfU41KYRsGx4tCzAS035KQID6CwUrNQ5nuqr1v0M2E3gQQ
	Udl5I2TngpjSfVgCULE1ujLXyg8btOBXbjexqDu2SfAQzLJeH4TPhxgfl3moG0NJrmfQHsDxWaK
	acmMFwPs6NIHAMlzMoV9giPtw=
X-Received: by 2002:a05:620a:4547:b0:8cd:95eb:faf8 with SMTP id af79cd13be357-8cfad32e5c5mr120565885a.61.1773776453923;
        Tue, 17 Mar 2026 12:40:53 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad161f17sm62823985a.30.2026.03.17.12.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 12:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 15:40:52 -0400
Message-Id: <DH5B9WYNX00J.8R01FVFXM4YR@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v4 1/3] libbpf: Introduce bpf_program__clone()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
 <20260317-veristat_prepare-v4-1-74193d4cc9d9@meta.com>
In-Reply-To: <20260317-veristat_prepare-v4-1-74193d4cc9d9@meta.com>

On Tue Mar 17, 2026 at 1:39 PM EDT, Mykyta Yatsenko wrote:
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
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Overriding the prepare_load_fn() callback's results with user-provided
ones is a valid choice design-wise.

> ---
>  tools/lib/bpf/libbpf.c   | 78 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   | 17 +++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 96 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad20..1eaa7527d4da 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9802,6 +9802,84 @@ __u32 bpf_program__line_info_cnt(const struct bpf_=
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
> +	/*
> +	 * Caller-provided opts take priority; fall back to
> +	 * prog/object defaults when the caller leaves them zero.
> +	 */
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
> +	/*
> +	 * Fields below may be mutated by prog_prepare_load_fn:
> +	 * Seed them from prog/obj defaults here;
> +	 * Later override with caller-provided opts.
> +	 */
> +	attr.expected_attach_type =3D prog->expected_attach_type;
> +	attr.attach_btf_id =3D prog->attach_btf_id;
> +	attr.attach_btf_obj_fd =3D prog->attach_btf_obj_fd;
> +
> +	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> +		err =3D prog->sec_def->prog_prepare_load_fn(prog, &attr, prog->sec_def=
->cookie);
> +		if (err)
> +			return libbpf_err(err);
> +	}
> +
> +	/* Re-apply caller overrides for output fields */
> +	if (OPTS_GET(opts, expected_attach_type, 0))
> +		attr.expected_attach_type =3D
> +			OPTS_GET(opts, expected_attach_type, 0);
> +	if (OPTS_GET(opts, attach_btf_id, 0))
> +		attr.attach_btf_id =3D OPTS_GET(opts, attach_btf_id, 0);
> +	if (OPTS_GET(opts, attach_btf_obj_fd, 0))
> +		attr.attach_btf_obj_fd =3D
> +			OPTS_GET(opts, attach_btf_obj_fd, 0);
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

