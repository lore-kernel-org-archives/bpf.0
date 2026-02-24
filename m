Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782139A7EF
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961311; cv=none; b=GlRhC8mxi2no1vwMRTGrjMg+ASqx5NMe96aRvX4GOk/V7LzbbfN3BpIEX3XoOn5dase2U2cy1qOhDGH1yOzkqAJdd+02S69ZpBnSQhZnzEWYndawS2WL2RnM2I2jAdG2UFzEBevagUq+cgyfJs0wWrdPItnxmZfObl5ufeYvkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961311; c=relaxed/simple;
	bh=mW1Gti/LnvUNQEXn9bmLffU4ZbbaM+tsjGbgVrTxoAc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fv0yfLfdqsXj+C01mXeYYo+LYCL1GJ39i8BRM32Pxm6ygHYGB3uyhvaq3FQWP1wSMsK6mKDvXmSUPP77wQ8U/9C++ZXaTLcLYv1VoMM4+WTv8ZBEtH6spwkHtNAt3IIySWFe4o2H5rFx6XT1PjuJGZFIHCTNE9oVJa4Jhbr7oK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWX/JPDG; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWX/JPDG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdb17511aaso694583eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771961309; x=1772566109; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWBPiMKwMPHCmvlXmg6kJUbZD+MWWXOX+DMb1ZNCxWU=;
        b=PWX/JPDGwOgPkEjEyN1pIQOW/ouwpJwuvGeoIH3MZjaJ9oTmjLuNSn+A8G27CztWod
         lSA5qIcFZGFEfAViwg9Ov4Q1f4zDVfyQndSgGAy99mharK5hQsfO5l/Y0n3yD25u77oX
         GYTQfJk6TGBgTRLBKUbOzL+pSqvXLiCjmznYg4cUH/Hf3NmEfoGXVHICqLZRJSkOKACv
         1taBeVCY8PRPbm8DDrqIFJMIHxA5RqGx8iMMK/yAC4Bip30ck6M3qvAPA+wJIEoDMTF3
         qbPkR6YbIcQztytclWkt6q4XrXPkmefj4M59LBeOjHjw1uUapG5ReEb5EyPOGKz1L+hL
         C6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961309; x=1772566109;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWBPiMKwMPHCmvlXmg6kJUbZD+MWWXOX+DMb1ZNCxWU=;
        b=PnD+zvesaZYh332+HZVnCLjLvJIL91r2EyLtyrPEjFZimOIByyaqwv0efvabnqb56y
         Ab+GikQ8qwYWTKQPuOPILk8usKi1lGx9+YGxyolz9WNymjkedZ03yrQbSyadzWsspgTv
         AOUZ2E9eDApsQSjoS8zWu6P021R77+l9wXvvKLrhA1PrJRz4AfHe080aRo1t2ApgkQmp
         6BTzuydW+12DVdXEZfY0RmTmZB5JsrYSf/g1VwWaOwlpklk3rNmBE1gBN8ED9zathjgN
         QsY/1NIEKww8BVIRFdPoBXpfFFJL9RciQzMgtbAn7H+mvDMyfuaZcVnmSOgBNGMuvgUD
         D81g==
X-Forwarded-Encrypted: i=1; AJvYcCWqGNFfATdqF6e8SIYRsPjx7KxKQIT2uvJ4LKtq0F7gLT2ZYxi9yayiaFEWM2Yz9RKNzoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7+TAA0LaxGD1DlDiod9P90Xx/Qvp48zkBJb1JaxGH2I8+Cw8
	C0DRCAwmkzSBL91HAwGH8HBzJvqQICcOx4pgdhT/xUvQ07UV6fU6NuxF
X-Gm-Gg: ATEYQzwHVWoUCSI8o4tK5z8cgxrdK1i5KuIFhDdVOdR02HGFbP0x460SaKurQtebw0C
	w3U0yNOXfxIEIuaz3AW3SYZz8pBK9clTbmqFocFOiwGTUEeePoLGjR09x7uZnNDqU25gqCX5xMt
	obYOL4trc28vLa5vz/7AEs6tC9S400UmLZ1mF+MCOveppNdarWylNaakvYl3lA9lHfkgEYyxAlo
	dx/qdpYA5QdPgijg0b5Q8rKXoWmwwJXrZJSAH4v1G2Hp+j/kh6pG6Ew88wdSMUc9o7vkdS3AOLN
	DbCdTg4sluAB/SN5rmFvUL7+nmuuVENK3m/UWEGTfkzRqsUjPTrmRL8ImFj7LxzG1p3SYM/x908
	f7+wJ/ugzmNPrMAZx5JgNV1qPJwdw3C94XakKfAtYap2ejdsZCM11TIUhhaVlhw7TQRkXFQu4w4
	62IX33zz++jjBFDNMCRa2/Gw8IaPWC6oJOk5NV46gZZS8KnZfnWNE3SsntESShBd+BYZKlKDp3A
	MSrbw==
X-Received: by 2002:a05:7300:e80e:b0:2b0:4c56:be16 with SMTP id 5a478bee46e88-2bd7bd52906mr4751496eec.29.1771961308727;
        Tue, 24 Feb 2026 11:28:28 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc164e3sm7325496eec.25.2026.02.24.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:28:28 -0800 (PST)
Message-ID: <83cf0430bf164c46abe56d2ec6565ca57ead1663.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 24 Feb 2026 11:28:26 -0800
In-Reply-To: <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
	 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 11:18 -0800, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Add bpf_program__clone() API that loads a single BPF program from a
> prepared BPF object into the kernel, returning a file descriptor owned
> by the caller.
>=20
> After bpf_object__prepare(), callers can use bpf_program__clone() to
> load individual programs with custom bpf_prog_load_opts, instead of
> loading all programs at once via bpf_object__load(). Non-zero fields in
> opts override the defaults derived from the program and object
> internals; passing NULL opts populates everything automatically.
>=20
> Internally, bpf_program__clone() resolves BTF-based attach targets
> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> func/line info, fd_array, license, and kern_version from the
> prepared object before calling bpf_prog_load().
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 82 insertions(+)
>=20
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

It seems 'fd_array_cnt' is not copied, should it be?

> +	OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->token_fd)=
;
> +	if (attr.token_fd)
> +		attr.prog_flags |=3D BPF_F_TOKEN_FD;

Nit: should this be 'if (OPTS_GET(opts, token_fd, 0) && attr.token_fd)' ?

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

Just curious why did you decide not to inherit logging properties from
the original program?
Unless overridden, the original program would point to the buffer
specified for the object in bpf_object_open_opts->kernel_log_buf, right?

> +
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
