Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392732F84F
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770682271; cv=none; b=tRjf1PonF56RKgSu0mBK7Zhid20TqOSt7KY082PXG7K4QffWC3RMgejyXWRNjfLk0gkLNYgz2Ebn8NRo+Ls57M4ZAMcypoajo8UGO0qxKaBhXn73ztxo9RrVZakbppzy/5/wALogbQAZpbaDLoGNHH6EnsywHxyJY/VFSv8vzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770682271; c=relaxed/simple;
	bh=+mUhiCB7dUdoF6psJh6iLKB7p1XQk/h2AXFI1/NOysg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lLoTv4j1nZ18hmq2PwuEIVTViQRQZYZ31OTAX+mXa/SCiFfEgGagg1Ud/nUQFyRoqF//pozJIO95knfG//3Sh16Mn/eigFpfKmXHW+oIbQUPFumva474bmfNuA4ZttOBeFLss2i34OkfTene5MFRjaZD9EjR3v2aLZYwUKoF/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wpdpFT5a; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wpdpFT5a"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb1c4679ebso83296885a.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 16:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770682269; x=1771287069; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3NQCZKJP+1t0i2NEISFrM+aZTtVrW497nncpviUxys=;
        b=wpdpFT5a/34br8vTpsx8+WVy2DwWAIihubVsKK/2r2g1ObPjarWMQUOZJCME9w+2V+
         SHxB30Fcg2WsEiizA+gkyv139NqRJ6P0JvT5LuTqUPw5sDS4A+6afdsy6eILHJ7Z2h7v
         uC3xrTCGh1sYEL1+XUzezjVV0tBbOGsjlUz35jYm7ETeQR5x3tEUGPteJp8FAceWVwxX
         5p53dvxgpK0DBRbiN2ffPdTeQGYE8DOmnTRPrK63KSd79m1iEbwmbdmr0rcqssKAbxvh
         A2QbSmr+cMhCC1kwwCOuB17r4FBOiQ7VqLKhw7L/rwB/miGgeSe7EHoDr4bLJ9h+EG4N
         dQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770682269; x=1771287069;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3NQCZKJP+1t0i2NEISFrM+aZTtVrW497nncpviUxys=;
        b=Br8wJ8vSm7+YixE37K3E+g2ycBDYMZIsp8nzCKe3uxZkNN72cNENVHrEqOcXTwa4g3
         Iqjoo0FSjBzMoLk2LdupF4AEHqxkcd52OlqMHxuAy06WzH08BxkamKJsuqjNr3nazJ02
         Gt1fZHa7zO+Gb4o2oX3qWCFMD78NeDB4saZcIDL2/ojXf8LS0XvETdg2BF177AgLz+xo
         2EysBULuDHo1wCHw/7vIQlYLyNJPslNGkWtqm9YII7H7JQdHTrIOHJy4hlYwLUlvuSiy
         zH+ER4TB+H/At0UeSdr+fUuo5tmkprzGO/gdGeQ5zU9r0EkmVke+zouHvJs2HLq3UrzM
         Aqvw==
X-Forwarded-Encrypted: i=1; AJvYcCV+ej7pLhFC5SvQqPJlzMmhbOl/ngpWbbWdWg+jh2h84RvUtlqEXymrj2696nt2DrLVjis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNQNTazF7bBqYy+q9apXUkt1Y2R+eV/zUc7QCFNJosYzU10JG
	NH/GR+FaFuPXWcygwz2gdFFRc5byoeoZlUowqNSc2P/tv/KOJTEcY2E7z4TGv2n/QRY=
X-Gm-Gg: AZuq6aKyAkcmrg/7phZRqkfHtqTH3jWaQA4gkQwFnNpEdBeiMGt1y0pZNzdQ4k8TbDj
	EalKLGJw2UiGJvQALijxOcc202OOLIQeSA9/Z3TYh1ny0iONmxDiQK+yAJVSM1GFbdayj/GU+zh
	enQ00qmJie12lf6tr25T218lhyzTsWCNvVn1cYm6UQU7DJ4owfvBaE0c5CK0MtXMLX+Xu6mUBwd
	hpZGM5NnX/tWEmwJ4DX6OmjRfb7SEumG+rBJDJ7OtghZcIZLtr6JZw6VQvigeyONA4UTyNR6UpX
	8W2+KthTATr9ucJG2oV3gn53Y29lTyM0MIHRa06H/KjNGihHPxNQNlkpYm73PRpVzwhD0bLh2xM
	FN95Z3P6P29K9ZcFLzxyeA+a9AOIDRwz8XxUwVr1XJWWR7gzwdm81wyu704ZvbAd+fstguyo56g
	z8UYox9UaabKY=
X-Received: by 2002:a05:620a:1729:b0:8c9:fc46:236a with SMTP id af79cd13be357-8cb1f740740mr39706885a.87.1770682269103;
        Mon, 09 Feb 2026 16:11:09 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a15a4dsm899107485a.25.2026.02.09.16.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:11:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 19:11:07 -0500
Message-Id: <DGAUH7XDYUV0.1J1I31HIRDODC@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2] libbpf: Add gating for arena globals
 relocation feature
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260209234850.2750149-1-emil@etsalapatis.com>
In-Reply-To: <20260209234850.2750149-1-emil@etsalapatis.com>

On Mon Feb 9, 2026 at 6:48 PM EST, Emil Tsalapatis wrote:
> Add feature gating for the arena globals relocation introduced in
> commit c1f61171d44b. The commit depends on a previous commit in the
> same patchset that is absent from older kernels (12a1fe6e12db,
> "bpf/verifier: Do not limit maximum direct offset into arena map").
> Without this commit, arena globals relocation with arenas >=3D 512MiB
> fails to load and breaks libbpf's backwards compatibility.
>
> Introduce a libbpf feature to check whether the running kernel includes
> patch 12a1fe6e12db, and only relocate arena globals if it does.
>
> CHANGELOG
> ---------
>
> v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@etsal=
apatis.com/)
>
> - Reworked test to use simpler array-based program (Andrii)
>
> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena"=
)
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

This patch does not properly parse the verifier log for kernels without
12a1fe6e12db. Will fix and respin.

>  tools/lib/bpf/features.c        | 92 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          |  7 ++-
>  tools/lib/bpf/libbpf_internal.h |  2 +
>  3 files changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..b1a088dd83ac 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,95 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>  	return probe_fd(prog_fd);
>  }
> =20
> +static int probe_kern_arena_global_reloc(int token_fd)
> +{
> +	const size_t bufsz =3D 1024;
> +	int btf_fd, prog_fd, map;
> +	char log_buf[bufsz];
> +	int ret;
> +	static const char strs[] =3D "\0f\0";
> +	const __u32 types[] =3D {
> +		/* [1] FUNC_PROTO `void(void)` */
> +		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), 0),
> +		/* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
> +		BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOB=
AL), 1),
> +	};
> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
> +		.token_fd =3D token_fd,
> +		.map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
> +		.token_fd =3D token_fd,
> +		.prog_flags =3D BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
> +		.log_buf =3D log_buf,
> +		.log_size =3D bufsz,
> +	);
> +	struct bpf_insn insns[] =3D {
> +		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
> +		BPF_EXIT_INSN(),
> +	};
> +	const struct bpf_func_info_min func_infos[] =3D {
> +		{ 0, 2 }, /* main prog -> FUNC 'f' */
> +	};
> +	int insn_cnt =3D ARRAY_SIZE(insns);
> +
> +	btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), strs, siz=
eof(strs), token_fd);
> +	if (btf_fd < 0)
> +		return 0; /* BTF not supported at all */
> +
> +	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &m=
ap_opts);
> +	if (map < 0) {
> +		ret =3D -errno;
> +		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
> +			__func__, errstr(ret));
> +		close(btf_fd);
> +		return ret;
> +	}
> +	insns[0].imm =3D map;
> +
> +	prog_opts.prog_btf_fd =3D btf_fd;
> +	prog_opts.func_info =3D &func_infos;
> +	prog_opts.func_info_cnt =3D ARRAY_SIZE(func_infos);
> +	prog_opts.func_info_rec_size =3D sizeof(func_infos[0]);
> +
> +	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc", "GPL",=
 insns, insn_cnt, &prog_opts);
> +
> +	ret =3D -errno;
> +	close(map);
> +	close(btf_fd);
> +
> +	if (prog_fd >=3D 0) {
> +		pr_warn("Error in %s(): Program loading unexpectedly succeeded.\n",
> +			__func__);
> +		close(prog_fd);
> +		return -EINVAL;
> +	}
> +
> +	/* Be conservative and NULL terminate the buffer to ensure strstr termi=
nates. */
> +	log_buf[bufsz - 1] =3D '\0';
> +
> +	/*
> +	 * Feature is allowed if we're not failing with the error message "dire=
ct value
> +	 * offset of %u is not allowed that was removed in 12a1fe6e12db
> +	 * ("bpf/verifier: Do not limit maximum direct offset into arena map").
> +	 * Instead, we should be failing with the message "invalid access to ma=
p value
> +	 * pointer". Ensure we match with one of the two and we're not failing =
with a
> +	 * different, unexpected message.
> +	 */
> +	if (strstr(log_buf, "direct value offset of"))
> +		return 0;
> +
> +	if (strstr(log_buf, "invalid access to map value pointer") =3D=3D NULL)=
 {
> +		pr_warn("Error in %s(): Program unexpectedly failed with message: %s.\=
n",
> +			__func__, log_buf);
> +		return ret;
> +	}
> +
> +	/* Feature is on. */
> +
> +	return 1;
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
> =20
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +670,9 @@ static struct kern_feature_desc {
>  	[FEAT_BTF_QMARK_DATASEC] =3D {
>  		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
>  	},
> +	[FEAT_ARENA_GLOBAL_RELOC] =3D {
> +		"Relocatable arena globals support", probe_kern_arena_global_reloc,
> +	},
>  };
> =20
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..0aeb740a5f47 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object *=
obj, struct bpf_map *map,
>  	memcpy(obj->arena_data, data, data_sz);
>  	obj->arena_data_sz =3D data_sz;
> =20
> -	/* place globals at the end of the arena */
> -	obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> +	/* place globals at the end of the arena (if supported) */
> +	if (kernel_supports(obj, FEAT_ARENA_GLOBAL_RELOC))
> +		obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> +	else
> +		obj->arena_data_off =3D 0;
> =20
>  	/* make bpf_map__init_value() work for ARENA maps */
>  	map->mmaped =3D obj->arena_data;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..e0223a6e4c95 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>  	FEAT_ARG_CTX_TAG,
>  	/* Kernel supports '?' at the front of datasec names */
>  	FEAT_BTF_QMARK_DATASEC,
> +	/* Kernel supports relocating arena globals to end of the arena */
> +	FEAT_ARENA_GLOBAL_RELOC,
>  	__FEAT_CNT,
>  };
> =20

