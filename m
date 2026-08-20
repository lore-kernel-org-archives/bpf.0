Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF73876BE
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787270306; cv=none; b=F9jufWkKRxBZODWqNdJmtmq6LnyqEEplSfLVYM882ycKdU+ZmV8xwmadQ/wF28Aem2mBviaTLkTTIx4Nf/nJHTwKfmBi6WDd/PBFjyr4sAri/k7YBZj90FlYscwepN0TPS9xJ5s5GoK5bfCMvKSfDz5g7s1hpDbrqA5vyOVWjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787270306; c=relaxed/simple;
	bh=OyDrBOxQvKRhxukCfiSfq2aSkIosUJyssEBLxAKEljs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+3ieX6np/rzODTVnf6DGa0KGzero/4dPEivN3a5ifQIWSAQhyz/FbY7AAYGQpeedT/s9rjpfe76OcGJlSHE4IZ6ktlOLDpeoDoWepq4cdIYPCT+3T1iNANKzM6nbDg8o4IukVm6aVpvTZsVk8DnUqE97N+2AN3x6FuO9cqMtTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7Pkc0eD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7Pkc0eD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf27856f9cso4252865ad.2
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787270304; x=1787875104; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TI1rQvwktw92uz/ySxNewgv2NVJCnxlAJKHLK2Zbxo0=;
        b=O7Pkc0eDFHQ1UrmQsC7xEKUR+sEGkEI+3HKVGTP+PNiXQQSfNElu9Yi2Q59d7NO8tG
         qnti0OmCgcMTOM6dpLMfpvRKA44SnuTteJJNnYmwWXKx4akcpA5aqomlKJzeHxcTUBlT
         vE7oGwwV8qsiH6kCESlUH+5amw2gKC7N+ZiyNIDgvh7Zfew6NkyMARskQrtEjAN/36IW
         cBGhdvtLrp5yEqgKB1736riXvHw7ESyFSQ0XnvU4jizTB4aNeui2NRi3Ol0UEhpxDDeB
         KaN2bGpRJ1RGzNv33wxZV0Zg0VA6AGA2bUUZ7naG0KzUTEkncz/zaTrHLKz2oHkuaLrh
         wFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787270304; x=1787875104;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TI1rQvwktw92uz/ySxNewgv2NVJCnxlAJKHLK2Zbxo0=;
        b=ja2lt0mCB32/ZPkPJtSzi/SIC7j7/u8B3geqTn5g5Soi4ieswvHFiM5LVS8ZcxEmjB
         q/I98zJXs+wxTCgvMnTHUHCgRYz9jcqvLgUzMgRC3fk2xF1QwTM9LlBXfDWJj0hQKpPn
         voLj/eV5gcVfjvyuXcK28GDuiaHDLoIkfS4oeJcHUKqUyrfJ8U9LGgO2Cmdc+/wrlAfD
         tQlkbzkKPXqpjA75zs4gFqjvRl0TQzQooDpKACOuwE5LML4Y6Jx5QfRHx3TRYeweYCML
         1VBwzJDgiDviaSymDJlNm3EXfDt3NtFOxTOjdypGgZrffNYml59fh5WfCCS6Svems2NG
         /mJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUxoTGK05n4M2yepv5Dmt7GyqsDDsv1XWppd8aB/09ypGMiN55WT8TCU2+CkVCxCdAhrc=@vger.kernel.org
X-Gm-Message-State: AFuF++l6Exn+xgCQVFF1/BnBO69oXE/nwFi6/Pb4UBCsDtIVzyd9tO3P
	EnbCgBJs9tG7K/OGowatQU2QRqUnxr6Q/h5F+iU+smYy2sdv1KXKj7WD
X-Gm-Gg: AR+sD13bSNyLvcwp2NKgGdJJDu7WhTKrJQSMacj0ve5tzqDI1xsI4RO24c3iL3W711K
	0TW0TQE9zIm5e/WxTUFpQfBKrgASSNy5luZn3moqOBj1PGduw7HAEK3Ss1f981XmZjSOltcMcaB
	3b2f2uH6rm16HnGLmQWAFsYJILeXj7NUWlWvjo8QB5u/fPM3D/l7ySEawwz3fxLe5zevaJtOVZ8
	CQ9Isgajvu3t71lqVYbROLpaK1mi27HBdl3ASWy5RRPNGttdS5g671IJ1l4GR39kvk6epJqLyw0
	8euky2n59Q5SstPt2kBXwIv6TI//9jd3GCowQ6euqb8WkTpH+f0LPU047xwkavFDWwNGjhP5Gmc
	1ZKtKlGqq7Ac1xvbbKFtutECdM+fr2HTumlvznbWsm0LUzMoLJ9azp9t6pEyXNYAQ3+m6h1AH1g
	ZqaMirjrKymlY6S4j9qZWYDSHnTwoId1EHslIU0a62Nbla2vmovuc0cTxsA0Rua5hcPfp01CGAW
	rUR57m+hbi3mY2JS8m8Sa+uzn4Eg5ki2U40L7h6TA/ueA==
X-Received: by 2002:a17:90b:558b:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-395c33371a9mr4208667a91.2.1787270304374;
        Thu, 20 Aug 2026 16:58:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad6060asm33729048c88.6.2026.08.20.16.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:58:23 -0700 (PDT)
Message-ID: <5efea1c6d5feb9bfc4ffe3eedde9ab98c2613776.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel
 module BTF loading via bpf_object_open_opts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Fuyu Zhao <zhaofuyu@vivo.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, 	martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, 	emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 20 Aug 2026 16:58:21 -0700
In-Reply-To: <20260819090426.267-2-zhaofuyu@vivo.com>
References: <20260819090426.267-1-zhaofuyu@vivo.com>
	 <20260819090426.267-2-zhaofuyu@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:

Overall the logic seem to be fine for me, please find a few comments below.

...

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa82..37934ca49dd7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -779,6 +779,13 @@ struct bpf_object {
>  	char *token_path;
>  	int token_fd;
> =20
> +	/* kernel module BTFs to load, as specified via bpf_object_open_opts */
> +	struct {
> +		char **names;
> +		size_t nr_names;
> +		struct hashmap *names_map;

We already have a strset type, please use it instead of a direct
hashmap reference. This would remove the need for `names` field
and simplify the bpf_object__init_kmod_btfs() function.

Also, do you expect `nr_names` to be high?
If not, wouldn't plain array search be simpler/faster here?

> +	} *kmod_btfs;

Why indirection?

Also, I agree with the bot here, prior fields use "module" in the name,
so something like "btf_module_names" or similar is a better fit.
Same for publicly visible 'opts' name.

...

> +static int bpf_object__init_kmod_btfs(struct bpf_object *obj,
> +				      const struct bpf_object_open_opts *opts)
> +{
> +	const char **kmod_btf_names;
> +	size_t i, kmod_btf_names_cnt;
> +	int err;
> +
> +	kmod_btf_names =3D OPTS_GET(opts, kmod_btf_names, NULL);
> +	if (!kmod_btf_names)
> +		return 0;
> +
> +	kmod_btf_names_cnt =3D OPTS_GET(opts, kmod_btf_names_cnt, 0);
> +	if (!kmod_btf_names_cnt) {
> +		pr_warn("kmod_btf_names_cnt must be set when kmod_btf_names is provide=
d\n");
> +		return -EINVAL;

I kinda agree with the bot here, why disallow an empty filter here?

> +	}
> +
> +	obj->kmod_btfs =3D calloc(1, sizeof(*obj->kmod_btfs));
> +	if (!obj->kmod_btfs)
> +		return -ENOMEM;
> +
> +	obj->kmod_btfs->names =3D calloc(kmod_btf_names_cnt, sizeof(char *));
> +	if (!obj->kmod_btfs->names) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	obj->kmod_btfs->names_map =3D hashmap__new(mod_name_hash_fn,
> +						 mod_name_equal_fn, NULL);
> +	if (IS_ERR(obj->kmod_btfs->names_map)) {
> +		err =3D PTR_ERR(obj->kmod_btfs->names_map);
> +		obj->kmod_btfs->names_map =3D NULL;
> +		goto err_out;
> +	}
> +
> +	for (i =3D 0; i < kmod_btf_names_cnt; i++) {
> +		size_t idx =3D obj->kmod_btfs->nr_names;
> +
> +		if (!kmod_btf_names[i] || !kmod_btf_names[i][0]) {
> +			pr_warn("invalid kernel module BTF name at index %zu\n", i);
> +			err =3D -EINVAL;
> +			goto err_out;
> +		}
> +
> +		obj->kmod_btfs->names[idx] =3D strdup(kmod_btf_names[i]);
> +		if (!obj->kmod_btfs->names[idx]) {
> +			err =3D -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		err =3D hashmap__add(obj->kmod_btfs->names_map,
> +				   obj->kmod_btfs->names[idx], 0);
> +		if (err) {
> +			zfree(&obj->kmod_btfs->names[idx]);
> +			if (err =3D=3D -EEXIST) {
> +				pr_warn("duplicate kmod BTF name '%s' ignored\n",
> +					kmod_btf_names[i]);

Nit: I'd downgrade this to debug level, if at all.

> +				continue;
> +			}
> +			goto err_out;
> +		}
> +		obj->kmod_btfs->nr_names++;
> +	}
> +	return 0;
> +
> +err_out:
> +	bpf_object__free_kmod_btfs(obj);
> +	return err;
> +}

...

> @@ -8515,6 +8645,7 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
>  	err =3D err ? : bpf_object__init_maps(obj, opts);
>  	err =3D err ? : bpf_object_init_progs(obj, opts);
>  	err =3D err ? : bpf_object__collect_relos(obj);
> +	err =3D err ? : bpf_object__init_kmod_btfs(obj, opts);

Nit: all other options are collected before bpf_object__elf_init()
     call just above.

>  	if (err)
>  		goto out;
> =20

...

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..2f8ff6d2d3df 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -224,10 +224,24 @@ struct bpf_object_open_opts {
>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>  	 */
>  	const char *bpf_token_path;
> +	/*
> +	 * Optional list of kernel module names whose BTFs should be loaded.
> +	 * kmod_btf_names_cnt specifies the number of entries in
> +	 * kmod_btf_names.
> +	 *
> +	 * If kmod_btf_names is NULL, all module BTFs are loaded, preserving
> +	 * the default behavior. Otherwise, only the specified module BTFs
> +	 * are loaded.
> +	 *
> +	 * kmod_btf_names_cnt must be non-zero when kmod_btf_names is
> +	 * non-NULL; otherwise -EINVAL is returned.

Nit: please add a complete list of behaviors this affects, e.g. CO-RE,
     fentry/fexit resolution, etc.

> +	 */
> +	const char **kmod_btf_names;
> +	size_t kmod_btf_names_cnt;
> =20
>  	size_t :0;
>  };
> -#define bpf_object_open_opts__last_field bpf_token_path
> +#define bpf_object_open_opts__last_field kmod_btf_names_cnt
> =20
>  /**
>   * @brief **bpf_object__open()** creates a bpf_object by opening
