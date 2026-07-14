Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C763E1680
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011727; cv=none; b=eGqyY/M9rJnAUVI8h+ibcc9/XIIDsOxIMuN+c1GnbLzxuHhcosMLt4dNB5OhJYxlA93XwFKoqBD2T9Taf7TFpm9kS4/+7kNzn99VfBg0BrSmz9fQ/3NLlEQ5T9QAaFkuvjZb5cS1lHIcINl8BJlzFCxZXchuZnJpwF5mwDbk8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011727; c=relaxed/simple;
	bh=NJ8VYfB8Jr5+sg1VMglKWIejQlRsy56IfKkfUaf39dU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pDk8f/Xk+/INU+jsqui+JAdrbq9PtCznmh8JXT4Ga3qtWIDpdNedrni0yUjC/wta8iYbfkD5ImP7+wXqIyBgi0bPYOQuczafH7HcitrMn4TZ2hFYInyPfOynf6LHAue3DR0KhF5AYdRm25YKRmPBsg2G+EkyrkwEkdcNAUs+Bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Er57vmrK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Er57vmrK"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1377707a91.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784011725; x=1784616525; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ekJ6euKjcodMZqS6RtCgnihmtB9IxwOQ6iil8jfqkrc=;
        b=Er57vmrKymvXXhz56y48gdhAupzThGT6qQszoAc9gHjsl3Hc2h+pgeD/QjhoER8xT1
         7NwerSpBe6TYwbiASIgBeF//NMRFQZuD3qqW2G2dAObMPo5G27FGwdIcIV3r8XeZJ4TE
         kRScjrlkWv1qk7AsNCIP7mtNF4No0KXaU5DF4/5cA6vwADFBhz2YNHz/aWfja3Q6qJ5Y
         qk9R69m90dXBWOlF/xyDwBncmT0ASAcT1NaFgOVP7jrRbP6YQu/QBnetvAcwhZo1CYjD
         mxGEdNP3nYQIiMYfnv/j7Lz0L6TX+hvPL1dFqRxkAZkswUSVDDkgMXEnGNPOMHLr5+oU
         Mxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011725; x=1784616525;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekJ6euKjcodMZqS6RtCgnihmtB9IxwOQ6iil8jfqkrc=;
        b=sRoynear1Ka7V3LwxvZ4/SdKizHbQ04DTOX9SiuHXJhYD1pEg7VvlFA1w5bNLuoSGz
         OeYZMqottmNVoqyHYkPxf22rkVq1bGvlEN9fvqmJPNfLRfCTumNUylyJx+CZRz2XLVNv
         m+r4I/3jnCJODG5hi7/gX5ABSAd348OBVRQZK3lv0Ito/THDZejMaT+0fK2j4tO13tiK
         MdGM1PTJ8smOh55xYDi6nksGIS8+ljk6FBvlMmPaK24MvTDRAW/wmwOTVrGa9mdKmd+I
         PXNdHnIMIPREqQ2k/J0VCGyp/30kn22My01/frq1wvidlyvAV7Zgmgx/wNP5ko9Bk2oW
         AH1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqkJMhN/4Yt2V6vX1EQft2O2+aGisYcj7em8svVe4gfoxbQBivsRDORJDXcjaaA3QCRehI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLz9gGLlZZT2fT0d3CW9jKl2HVQ6e9HxPhgOGbfx7/41D7931t
	wagzYlMQp2evWqx2K52ZD08Vsv247eW9jpR/CFNq6zBMsSRxnFdQCJwxOcUmzYbGAck=
X-Gm-Gg: AfdE7cmmxf1WAvQ+pculeOGp6I22OD5J5FUpA3nY1To5Yr9P7CwdvFWHfdcdfb0X/AC
	M/1HRY0GXkQWGRxFWwLp6bP71rutjXnKuTk7x+ndK4GlMjkirajb0fGrSyYRv4nCvt+8E/2AYIn
	7L1Zd6OdM7V5K1p2Mo8Y1f5Uw5nloEs4QL32bBobZiHdWW2/RjeOiP8fODgeU8bfpO5HCJkbirs
	biA9uo23pjg1he8tTHA0ZMm8BVH23nCujr1du98RfhH8HXIa4SIYbvKUEzhqhbukpX0J+0VoiE3
	d5+nCkjbhG4DkKjrN9BYI7+cCJJ+Q1V72FNYHmtzkwRkosHHQEY4vRA4Dd9XM82KisXjEwvZTTl
	uAG3KbzODBfb3uS6rgrg96V9mRHDSMJlAoNJp18xAc27ytdqrzCoKjrBIoCAlaaGytEvUcoDs3n
	JWnuV36EqJvSKLbN1ftvaqAU0VYGA5O9yyvY5edy1dmQ==
X-Received: by 2002:a17:90b:4a4a:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38e1ae31638mr1112432a91.16.1784011725467;
        Mon, 13 Jul 2026 23:48:45 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e173084c9sm966663a91.13.2026.07.13.23.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 02:48:44 -0400
Message-Id: <DJY3DJSWEMPW.3ODE44OQVL7J3@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 13/15] libbpf: Support attaching struct_ops
 to a cgroup
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-14-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-14-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to a cgroup
> through a BPF link.
>
> Also extend struct bpf_prog_query_opts with a type_id field so a
> BPF_STRUCT_OPS query on a cgroup can select the struct_ops type to
> enumerate.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/bpf.c      |  2 ++
>  tools/lib/bpf/bpf.h      |  3 +-
>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  3 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 96819c082c77..a9de7f107cf7 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -934,6 +934,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>  	case BPF_CGROUP_GETSOCKOPT:
>  	case BPF_CGROUP_SETSOCKOPT:
>  	case BPF_LSM_CGROUP:
> +	case BPF_STRUCT_OPS:
>  		relative_fd =3D OPTS_GET(opts, cgroup.relative_fd, 0);
>  		relative_id =3D OPTS_GET(opts, cgroup.relative_id, 0);
>  		if (relative_fd && relative_id)
> @@ -1056,6 +1057,7 @@ int bpf_prog_query_opts(int target, enum bpf_attach=
_type type,
>  	attr.query.attach_type		=3D type;
>  	attr.query.query_flags		=3D OPTS_GET(opts, query_flags, 0);
>  	attr.query.count		=3D OPTS_GET(opts, count, 0);
> +	attr.query.type_id		=3D OPTS_GET(opts, type_id, 0);
>  	attr.query.prog_ids		=3D ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
>  	attr.query.link_ids		=3D ptr_to_u64(OPTS_GET(opts, link_ids, NULL));
>  	attr.query.prog_attach_flags	=3D ptr_to_u64(OPTS_GET(opts, prog_attach_=
flags, NULL));
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 7534a593edae..490e8cb4ba53 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -637,9 +637,10 @@ struct bpf_prog_query_opts {
>  	__u32 *link_ids;
>  	__u32 *link_attach_flags;
>  	__u64 revision;
> +	__u32 type_id;
>  	size_t :0;
>  };
> -#define bpf_prog_query_opts__last_field revision
> +#define bpf_prog_query_opts__last_field type_id
> =20
>  /**
>   * @brief **bpf_prog_query_opts()** queries the BPF programs and BPF lin=
ks
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7162146280a8..50a83b9217e4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -14104,6 +14104,70 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
>  	return &link->link;
>  }
> =20
> +struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map, =
int cgroup_fd,
> +					     const struct bpf_cgroup_opts *opts)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
> +	struct bpf_link_struct_ops *link;
> +	__u32 relative_id, zero =3D 0;
> +	int err, fd, relative_fd;
> +
> +	if (!OPTS_VALID(opts, bpf_cgroup_opts))
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	if (!bpf_map__is_struct_ops(map)) {
> +		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	if (map->fd < 0) {
> +		pr_warn("map '%s': can't attach BPF map without FD (was it created?)\n=
", map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	if (!(map->def.map_flags & BPF_F_LINK)) {
> +		pr_warn("map '%s': can't attach to cgroup without BPF_F_LINK\n", map->=
name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	relative_id =3D OPTS_GET(opts, relative_id, 0);
> +	relative_fd =3D OPTS_GET(opts, relative_fd, 0);
> +
> +	if (relative_fd && relative_id) {
> +		pr_warn("map '%s': relative_fd and relative_id cannot be set at the sa=
me time\n",
> +			map->name);
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	link_create_opts.cgroup.expected_revision =3D OPTS_GET(opts, expected_r=
evision, 0);
> +	link_create_opts.cgroup.relative_fd =3D relative_fd;
> +	link_create_opts.cgroup.relative_id =3D relative_id;
> +	link_create_opts.flags =3D OPTS_GET(opts, flags, 0);
> +
> +	link =3D calloc(1, sizeof(*link));
> +	if (!link)
> +		return libbpf_err_ptr(-ENOMEM);
> +
> +	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
> +	if (err && err !=3D -EBUSY) {
> +		free(link);
> +		return libbpf_err_ptr(err);
> +	}
> +
> +	link->link.detach =3D bpf_link__detach_struct_ops;
> +
> +	fd =3D bpf_link_create(map->fd, cgroup_fd, BPF_STRUCT_OPS, &link_create=
_opts);
> +	if (fd < 0) {
> +		free(link);
> +		return libbpf_err_ptr(fd);
> +	}
> +
> +	link->link.fd =3D fd;
> +	link->map_fd =3D map->fd;
> +
> +	return &link->link;
> +}
> +
>  /*
>   * Swap the back struct_ops of a link with a new struct_ops map.
>   */
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..0e5f4e9bba41 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -960,6 +960,9 @@ bpf_program__attach_cgroup_opts(const struct bpf_prog=
ram *prog, int cgroup_fd,
>  struct bpf_map;
> =20
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> +LIBBPF_API struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf=
_map *map,
> +							int cgroup_fd,
> +							const struct bpf_cgroup_opts *opts);
>  LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
> =20
>  struct bpf_iter_attach_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b731df19ae69..5131fdb979b7 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -461,4 +461,5 @@ LIBBPF_1.8.0 {
>  		bpf_program__attach_tracing_multi;
>  		bpf_program__clone;
>  		btf__new_empty_opts;
> +		bpf_map__attach_cgroup_opts;
>  } LIBBPF_1.7.0;

