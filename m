Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473F185B48
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990787; cv=none; b=HSYwX4d2cBrkEZU+ZDevX6RTqKdjE29IrbBwiy9SN9FIV0E86iYQIBcNBbTo0m4kxq716XPjHCqgPmQz5k1cM0IW/TLctK6+nLVp/75T6/J4KkRFmTr+0K4avxq+gURrNbYWsCc8hagkKlS3uhNbTWNk1zREIwaF438U3ev6jNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990787; c=relaxed/simple;
	bh=EBRBCj+jx/8xsk2Agc6aCHGqXOLDS5pEJ9I9/nTgo8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aa4D6MT5j6mVCftz9HvP4jF9lF67PQCv9+FJ2H3257M8ExodymwRH67ZS40aDs85vRUmEkc/51yncWw6NqrEjlPyqkxgKNDFSTHftqhYQE39O0zdIYiEutvhzCTpv4PQRRBKvAdBQM6gNC1J4/OaH5BtGKnu5RsLo4FoZ+PJNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1eCCUTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1eCCUTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D488B1F000E9;
	Thu,  6 Aug 2026 04:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785990786;
	bh=iIqO3+jPcqINpZ6idOWp9OUbjLFA4tw6I+4RshVxvvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1eCCUTiBl3bxrPTzhHHYx57zxESpphvsP1PtZHtc32aCgwCQu7rH3KitxhKIV2Qo
	 f7L1wQXUq38QbpW4jg6w90iLvoBJrWHwah5HAaT8TEc756OeXoE8GvByYlM4p79DPR
	 rs00O344otiG543ORII2L6qZG5VOao2Ba3x74sj2CSMsk7k4rnfNiVhwwTdUs/ot++
	 JF0jhhLztKYMFMtOJ5lDVIaraM0o2hhe/h1WUdIP6GZoWMsAs57pcMyCka4F0F6mqi
	 zcMV/7w3Co5PsfiYtskW9+DRlaujrMvkDg5eQp9gtNvzx8kNmTuXgT7zqbSa/Hk1s/
	 +Gn9FIXe/etLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: support selective kernel
 module BTF loading via .kmod_btfs section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806042042.3239428-2-zhaofuyu@vivo.com>
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
 <20260806042042.3239428-2-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 04:33:05 +0000
Message-Id: <20260806043305.D488B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Transient stack pointer overwrites persistent hashmap key in is_=
kmod_btf_needed(), breaking hashmap integrity on bucket collisions.
- [Medium] Memory allocation failure for `obj->kmod_btfs->data` silently re=
turns success (0), masking the error and corrupting intended behavior.
- [Medium] Processing multiple `.kmod_btfs` sections overwrites previous al=
locations without freeing them.
--

--- Patch [1]: [RFC PATCH bpf-next 1/2] libbpf: support selective kernel mo=
dule BTF loading via .kmod_btfs section ---
commit 5306ac18160e3a8c2a0f3dd2eda202169f998df6
Author: Fuyu Zhao <zhaofuyu@vivo.com>

libbpf: support selective kernel module BTF loading via .kmod_btfs section

Add support for a new ELF section ".kmod_btfs" that allows BPF programs
to declare which kernel modules need BTF loading. This avoids loading
all module BTFs and speeds up program load when only a subset of modules
is needed.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa825..5cefe82e4a679 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -901,6 +916,68 @@ bpf_object__init_prog(struct bpf_object *obj, struct=
 bpf_program *prog,
>  	return -ENOMEM;
>  }
> =20
> +static size_t mod_name_hash_fn(long key, void *ctx)
> +{
> +	return str_hash((char *)key);
> +}
> +
> +static bool mod_name_equal_fn(long key1, long key2, void *ctx)
> +{
> +	return strcmp((char *)key1, (char *)key2) =3D=3D 0;
> +}
> +
> +static int
> +bpf_object__collect_kmod_btf_names(struct bpf_object *obj, Elf_Data *sec=
_data,
> +				   const char *sec_name)
> +{
> +	int module_cnt, i, err =3D 0;
> +
> +	if (sec_data->d_size % KMOD_NAME_LEN !=3D 0) {
> +		pr_warn("sec '%s': size %zu should be multiple of %d\n",
> +			sec_name, sec_data->d_size, KMOD_NAME_LEN);
> +		return -EINVAL;
> +	}
> +
> +	module_cnt =3D sec_data->d_size / KMOD_NAME_LEN;
> +	obj->kmod_btfs =3D calloc(1, sizeof(*obj->kmod_btfs));

[Severity: Medium]
If a crafted ELF file contains multiple .kmod_btfs sections, could this cal=
loc
overwrite a previously allocated obj->kmod_btfs and cause a memory leak of
the hashmap and data arrays?

> +	if (!obj->kmod_btfs)
> +		return -ENOMEM;
> +
> +	obj->kmod_btfs->data =3D calloc(module_cnt, KMOD_NAME_LEN);
> +	if (!obj->kmod_btfs->data)
> +		goto err_out;

[Severity: Medium]
Does this error path silently return success?

Because err is initialized to 0, this goto err_out will return 0 instead of
-ENOMEM. This causes obj->kmod_btfs to be freed in the cleanup path while
the function signals success, making load_module_btfs() fall back to loading
all module BTFs.

> +	memcpy(obj->kmod_btfs->data, sec_data->d_buf, sec_data->d_size);

[ ... ]

> @@ -5803,6 +5884,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local=
_cand,
>  	return 0;
>  }
> =20
> +static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
> +{
> +	uintptr_t val;
> +
> +	if (!hashmap__find(obj->kmod_btfs->hashmap, name, &val))
> +		return false;
> +
> +	if (val =3D=3D KMODS_BTF_LOADED)
> +		return false;
> +
> +	hashmap__set(obj->kmod_btfs->hashmap, name, KMODS_BTF_LOADED, NULL, NUL=
L);

[Severity: Medium]
Can this hashmap__set() corrupt the hashmap by storing a transient stack
pointer as the key?

Looking at load_module_btfs(), name is a local stack array passed to
is_kmod_btf_needed() on every iteration:

load_module_btfs() {
    char name[64];
    ...
        if (obj->kmod_btfs && obj->kmod_btfs->hashmap &&
            !is_kmod_btf_needed(obj, name)) {
    ...
}

Since hashmap__set() only stores the pointer address, all entries will
share the same pointer to the local name array. If a bucket collision
occurs, strcmp(key1, key2) will evaluate to 0 since both point to the
same stack address, falsely matching existing entries and skipping the
requested module.

> +	obj->kmod_btfs->nr_loaded++;
> +	return true;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806042042.3239=
428-1-zhaofuyu@vivo.com?part=3D1
