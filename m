Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE9427FA3
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130773; cv=none; b=Garmpsht9YqTMB8kDzI9SaSiXbHIfA1d3IMYPJTOhANEKQ3ZwmuTt9FuDQ4hVgLk8D5Ma7wTsCWwGZg9ZfVTNknfZoACD45L6CC7X40Qa69i569+1MHG7Lk0ZOGCeXwBD4herHc7uH0RSQ/Y2dL/5sUPJQKVRqvwOVHylWgnrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130773; c=relaxed/simple;
	bh=vTFzmSNv7XMXuJlNO3zSwVtvIHg1TIspXKd65sFsDog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VL6YBCZ+XQ9bedmGda5Ahfcnd/J4yGwS6Rmj/PQ3CuQqJ4hQcVbEb1cFXddRqhM9w7KRNAYyYD55s4BORVOhheeFE6NPARt4CH1LhCdBrWG+tzceNOkCbmJGrsJPONMXa4wMk38hBsyQ/CRYmxhN7AzwGbmCSkARbRG/piwP/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJP1HI5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJP1HI5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CAD1F000E9;
	Wed, 19 Aug 2026 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130770;
	bh=YvfFmNuc8Ff+iuDiAYzJiIgeaAZr1FScRAmWCtBjwZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJP1HI5QDPHWoUL8vHDcFhvOvsZxPy3WpgBoqfsBt/IEElTuF+4JUaLDRfJ7tmFOr
	 Mgt7wXyF3VUYlSpO3Sz1mNBfczmsd8+WpWBZWI02LqNlZUApg8DETVN1uO0a1PfzjG
	 28C7cufXWb4dTQSCnW4iA58Ib3lnklRXB8kqJNr7ukCzW1oa2al4Pp0/OxtNE5x7Hg
	 8PfD2OXqEDbN+6AJUSW8GaQLU3mWyNOwu6ulbvkuRoHGn1T2FvjGAnrOfpUB8lh4mr
	 VDEnoFZ8mZ7Pne2jCMERyP3CVroI6Hzvsek/r2mFFOzkqJf6zWHneu8hpJxRdKCg91
	 /XPmf16CqUKPw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel
 module BTF loading via bpf_object_open_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819090426.267-2-zhaofuyu@vivo.com>
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-2-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:12:50 +0000
Message-Id: <20260819091250.76CAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Premature loop termination in load_module_btfs when kernel conta=
ins multiple BTF objects for the same module.
- [Low] API design prevents users from explicitly skipping all kernel modul=
e BTFs without providing a dummy name.
--

--- Patch [1]: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel=
 module BTF loading via bpf_object_open_opts ---
commit 627a7f9dbb55055d6c4d1331859084b6d2f56792
Author: Fuyu Zhao <zhaofuyu@vivo.com>

libbpf: support selective kernel module BTF loading via bpf_object_open_opts

Add kmod_btf_names and kmod_btf_names_cnt fields to bpf_object_open_opts
to support selective kernel module BTF loading. This allows libbpf to
load only specified module BTFs and skip others.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..957415341caf1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5851,6 +5858,121 @@ int bpf_core_add_cands(struct bpf_core_cand *loca=
l_cand,
>  	return 0;
>  }

[ ... ]

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
> +	}

[Severity: Low]
If a user wants to optimize BPF object loading by skipping all module BTFs
(for instance, when only vmlinux BTF is needed), setting kmod_btf_names to =
NULL
falls back to the default behavior of loading all modules, but providing a
valid pointer with kmod_btf_names_cnt =3D 0 returns -EINVAL.

Does this API design force users to allocate and pass a dummy module name j=
ust
to skip loading module BTFs entirely?

> +
> +	obj->kmod_btfs =3D calloc(1, sizeof(*obj->kmod_btfs));

[ ... ]

> +static bool all_needed_kmod_btfs_loaded(const struct bpf_object *obj)
> +{
> +	return obj->kmod_btfs &&
> +	       obj->kmod_btfs->nr_names > 0 &&
> +	       obj->kmod_btfs->nr_names =3D=3D obj->btf_module_cnt;
> +}

[Severity: Medium]
If a kernel module is unloaded but its BTF object is kept alive by an open =
file
descriptor, and the module is then reloaded, the kernel will contain multip=
le
BTF objects with the same module name.

Because btf_module_cnt increments for every loaded BTF object, but nr_names
tracks the number of unique requested module names, can duplicate BTF objec=
ts
inflate btf_module_cnt?

If a user requests BTFs for multiple modules via kmod_btf_names, would this
condition evaluate to true prematurely and skip the remaining requested mod=
ules?

> +
>  static int load_module_btfs(struct bpf_object *obj)
>  {

[ ... ]

> @@ -5939,6 +6066,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  			break;
>  		}
>  		obj->btf_module_cnt++;
> +
> +		if (all_needed_kmod_btfs_loaded(obj))
> +			break;
>  	}
> =20
>  	if (err) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819090426.267-=
1-zhaofuyu@vivo.com?part=3D1
