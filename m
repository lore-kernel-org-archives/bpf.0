Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A4330D26
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867532; cv=none; b=HTzm2z5/Y+NcHBUdEPHoF1rHAsUsajt1ByjipPQ6eM9kSunxuwxadD3YyV+ldPCMQXLR8ckm3xLmPCqViTspcuh33VRaOe+c+AKtk83bpw179BpFN3RnoSdqeBwkXoB8BMffXOGzHBR6yW7dqa0RxeMgp+nbyRMccwWwM8hAXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867532; c=relaxed/simple;
	bh=MdTRE9EIe83+qXWRSsf2wB6+DHcBMMM1JWTF3pEP2b0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eDzX3nDP/M5Bk4M30k/jAnKRm8CjciTIr09DfzyUQ2P/ZCLlIHtYPmi/M0OGMYlatojPMw1PxiHOqy8HKsaOi6HKH991ji+glpA0ksg3MAPn4ct1ddaccJCkGsr6aLM2A4SzU60crO06YHhEwQCPDQKWAcglVZg5Rx/ZVVY/GjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=JlobwVE7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="JlobwVE7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb513e860cso487057585a.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771867529; x=1772472329; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjCjaIjYluzr4kk81VkWhaTO8xAFfvTfXnVphtl0r5s=;
        b=JlobwVE7xn9FdRi7Z5CnXCT/8G4wfE1qHDh2mCpNmmWHpJbedByFuD2+SIWjDMdZCP
         GJCnbkKzaKbHOR8TvrOvt1NEJ6rlE/hV3gtC6xuGVQCM/kbmfiscI9T2M+NS3nSCta2x
         O7Tp67UUEcFs+lLMnmi2n5hNBmca8yz9UvXqWaTW5gAk9sEPdHqGULFHR3H4DwNrJkzp
         FIfrZcF9xCBWDKFBNtBAI/0wtF6ocYunra/t0MqqUm+UpJZE72Bezyu75cl0SCyikpu0
         cuGYMNe+2TFWAMIILwUP34N2hSI7Ar5Q147icjOzGgb19gd4j69cDsyGU15zJg19gMX8
         ickQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867529; x=1772472329;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjCjaIjYluzr4kk81VkWhaTO8xAFfvTfXnVphtl0r5s=;
        b=SVF4OScZzdpHmW2A0X4VVDEth6fjW4ZitSUYAYMUhMOUuq0+2IRYpfIxrgmJPz7hCu
         F7VtQ0bK4uLvD9nKz74V+e/3ZkW5B4PgCmfJRlTRW7f85K0FX5fRmuxoRO2FoVCpbcn6
         9gKNAb70wD6R+e0ecckBL6e4DsUbCbckJ9QAAM+Ul9ZzobUR8XTTCtz9XBQ54xNvPeV+
         KY9lu37IcMrzSUH9EroarZUIFzAMhWdYNL9UNPr9CnEr+S+c427e7JkKBG7Byyf1uYkk
         GqfLgR7b2lRJbI2f0LHaAsvLkYBfMFLttnR+9qSBboNbudKt1aOTsKOUZPSfa3o9sqgP
         41bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW15BIQ7XhGaHrdAiMR+VldVZKoh0vBH7zVYDfRIox/dvP3PFq53KYrDmvUFuYwnMK/RzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Dro3NbiM5uMaYYhE/cnrQMQMV2oUxdclhs3kr5pd9h5aTzUv
	vzH2NFd1ULWY/tlMbQQIz/Zj+2mCr+f/YF+x12HvHI3rYDzyhjWZb1sFlHvzLEffkgk=
X-Gm-Gg: AZuq6aJOhilNtTsEpxrCqumsRE98+0NAdz7NP+mWc9FXrRmiTIBUMtDj71LIKHse1k9
	pgmpyY/nVJGFaUu7WJV9s//yihFS9oAJJB843XWJB+73JKJj9WMj2VWo5NJnFp8iF0huCcioZkM
	bSGJhvhSGhWBhQ1+6tH7fZBY20P99oyQsRTSPleDkfL2eFh4mzIl3ShdJLr7HX54kIDc1Vs8SXH
	yjDODaH8wG6BmsUp3SuM6OFNkcVM4hAg1yDRDd48SZ5RV78jqP4ixr103anF3k3eZS9oJAFZ3Eo
	LK4W3Z0vHam3Geko/PQKRrZpYtXkQDicb1IRSc4o3ByyIM1DKd6dAa/mLiMeYxZpD2DL1cLjVUh
	TF8d2tILh37n4mI9EdQzXb94Qydwxj5BW5AqEaguYXvXiVswzDjkRniJsDSggn9A3WZb6UlHboy
	IBf7xylYWsIRcV7f+zDd5/0t4=
X-Received: by 2002:a05:620a:254b:b0:8b2:f191:2b3a with SMTP id af79cd13be357-8cb8ca65f09mr1161805385a.53.1771867528615;
        Mon, 23 Feb 2026 09:25:28 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0460c9sm881963385a.5.2026.02.23.09.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 12:25:27 -0500
Message-Id: <DGMIM8SH2Q43.1I9LNNV1X34KB@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
In-Reply-To: <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>

On Fri Feb 20, 2026 at 2:18 PM EST, Mykyta Yatsenko wrote:
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
> ---
>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 82 insertions(+)
>

The code looks in order, one issue below.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..4b084bda3f47 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bpf_=
program *prog)
>  	return prog->line_info_cnt;
>  }
> =20
> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_l=
oad_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, attr);
> +	struct bpf_prog_load_opts *pattr =3D &attr;
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
> +	OPTS_SET(pattr, expected_attach_type,
> +		 OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_type=
);
> +	OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) ?: prog=
->attach_btf_id);
> +	OPTS_SET(pattr, attach_btf_obj_fd,
> +		 OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf_obj_fd);
> +	OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0) ?: pr=
og->attach_prog_fd);
> +	OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: prog->prog=
_flags);
> +	OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?: prog->=
prog_ifindex);
> +	OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?: obj->k=
ern_version);
> +	OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj->fd_arr=
ay);
> +	OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->token_fd)=
;
> +	if (attr.token_fd)
> +		attr.prog_flags |=3D BPF_F_TOKEN_FD;
> +
> +	/* BTF func/line info */
> +	if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> +		OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd=
(obj->btf));
> +		OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NULL) ?: prog->fu=
nc_info);
> +		OPTS_SET(pattr, func_info_cnt,
> +			 OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_info_cnt);
> +		OPTS_SET(pattr, func_info_rec_size,
> +			 OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size);
> +		OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NULL) ?: prog->li=
ne_info);
> +		OPTS_SET(pattr, line_info_cnt,
> +			 OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_info_cnt);
> +		OPTS_SET(pattr, line_info_rec_size,
> +			 OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size);
> +	}
> +
> +	OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
> +	OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
> +	OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
> +

Can we make it so that cloning  prepared but not loaded programs does
not load them? The name of the method itself implies the new instance is
identical to the old one, which is not the case - we're currently
loading the cloned program even if the original is not loaded. I don't=20
see why for OBJ_PREPARED progrmas this shouldn't be explicitly done by the=
=20
caller with bpf_prog_load() instead.

If we do make it so that the cloned program's obj->state is identical to th=
e
original's let's also add a test that checks that.

> +	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
> +	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> +		err =3D prog->sec_def->prog_prepare_load_fn(prog, pattr, prog->sec_def=
->cookie);
> +		if (err)
> +			return libbpf_err(err);
> +	}
> +
> +	fd =3D bpf_prog_load(prog->type, prog->name, obj->license, prog->insns,=
 prog->insns_cnt,
> +			   pattr);
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

