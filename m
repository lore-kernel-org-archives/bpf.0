Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266B1C5F39
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720930; cv=none; b=q90C1cwBhXNXqHTccn+t+yXZEnahEoFCgicHMtBP/HzIzNVrGBtE2+S64ssGg28m2UOHpnQCahSBAwYgm4joRu5ahDUfKzWee8/t6YdsCV/dEtLHVvyLJ8hczg1maHPXcGepnRMwX5EfQZMaJ+3SsBISqf3LnR/YJdqWCwdI9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720930; c=relaxed/simple;
	bh=kjUIJPECu2AqX1T1xJsKoZPmmhTY+coBP6Jp9kzv5P4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNYsvu/a96O23iuqVkjkzOYesK/vOJ+tt1Y0quVbaRqmYLBoyWLZ7SjXim/DHj6pyrqBJSWTbbtsKELldB10j79jD7Ul8sfJElCJtxocAguJ8wJh0i8xl11NdK0UqNNCphh3GFTahC8cwxI2edQHFzYjg33gkv8ROapBNKEAy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLnD7OPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLnD7OPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F569C19425;
	Thu, 14 May 2026 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720930;
	bh=kjUIJPECu2AqX1T1xJsKoZPmmhTY+coBP6Jp9kzv5P4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rLnD7OPl/6yH+PRXMgGfE/yU2dnyU3DcoEybQupJeMDnuDJbRJvulHS0ZWf2IaFn0
	 xOx2PgChEkEowkOOFxOgZS2+Zz+1ryp2QSw6miiX2ozEqB9lR9CtSKFHy3a3x7QzLO
	 hbOAdOfGClX/R1gTEawnLwXclH8w4m362QEs+nO3hxhE19s0Z2luU8oEpIBiUljwER
	 U6LJq7h0rWA5JJed1suKySJuc0ZLKfKzqRQ58fi74DL9QeI9nzzJ7C9mkN8B4ahG5a
	 dN7gOwwdlQ33BzAXKGD2vxE9vCSoosGeX/1jEvQkpSt69xapuwomlOs72qho/GosyT
	 64mY5vWcN9OcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v14 7/8] libbpf: Add syscall common attributes
 support for map_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512153157.28382-8-leon.hwang@linux.dev>
References: <20260512153157.28382-8-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:08:49 +0000
Message-Id: <20260514010850.0F569C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing OPTS_VALID() check for the nested `log_opts` structure i=
n `bpf_map_create` breaks ABI forward compatibility guarantees.
--

commit a5ab21cbf48e1fc2cdb0af0f1ff743e2633f6ae8
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add syscall common attributes support for map_create

The commit introduces struct bpf_log_opts and adds a log_opts field to
bpf_map_create_opts to allow users to retrieve detailed error messages when
map creation fails.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9d8740761b7a8..483c02cf21d1f 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> @@ -242,7 +245,18 @@ int bpf_map_create(enum bpf_map_type map_type,
>  	attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL)=
);
>  	attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, 0);
> =20
> -	fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +	log_opts =3D OPTS_GET(opts, log_opts, NULL);

Does this code need to validate log_opts with OPTS_VALID(log_opts, bpf_log_=
opts)?

Libbpf relies on the OPTS_VALID() macro to enforce ABI forward compatibility
by verifying that any unrecognized trailing fields in extended option struc=
ts
are explicitly zeroed. While bpf_map_create() correctly validates the outer
bpf_map_create_opts structure, it seems the nested log_opts structure is
accessed without similar validation.

If a newer application populates unsupported fields in struct bpf_log_opts
with non-zero values, could an older libbpf silently ignore them instead of
safely rejecting the request with -EINVAL?

> +	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
> +		memset(&attr_common, 0, attr_common_sz);
> +		attr_common.log_buf =3D ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
> +		attr_common.log_size =3D OPTS_GET(log_opts, size, 0);
> +		attr_common.log_level =3D OPTS_GET(log_opts, level, 0);
> +		fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &attr_common, at=
tr_common_sz);
> +		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
> +	} else {
> +		fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +		OPTS_SET(log_opts, true_size, 0);
> +	}
>  	return libbpf_err_errno(fd);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512153157.2838=
2-1-leon.hwang@linux.dev?part=3D7
