Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411405;
	b=Xz62dUkh5d/lfDPSr9A9OEVW7H2NGQAbQss0mbHc3aOC3/yFXPGpWHHWiDxlM/Z7/etV
	 yfesm/futFLIkgugLztWR2DaygUo9tPUn58zz0+SoiYp3KvKvNpiC8skg7gJQ4BC1T4HN
	 XkJHZLXHPJXQzEABhtuTBp2MMjJHpZJrCXfeanUhvz0vF56q1enl6HZzYhiFLFFSuddr0
	 VyuSbnJG/V1+T/fd67JECPRAxZSxEmZv3Acs+OfDrabbWf4Ctyi9vIX8HsF1e4qlWBkLL
	 1V6zUC2hxu98DLWTFQyt19uqDKr/irewVcC6qIu1kGbm/aaE56JKN8E3+x4j3DgdFWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411405;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5ZEXguI78NypJpH9q83OSt4iLK81RIIPU3vwPO6f84I=;
	b=s34wQdWiBY1TAyJnpFSN/Nk5E3JVe3DqP1QzI5cvjP8G3bh0Yj3Wl374V1qHlclfVlT0
	 PYQQrUlEK8W9pWEPVPmW3CjwXoM+DOuWvmj9Ph48U4WvOAXBHP2MK9DRT7kwTSrprMaL3
	 cXcuGahPZh7WLfddJ5evUzzfu9dUvZuqM5y2oXfTo/qsFoezU5nq1Uv5JnTZW1xFI3lgu
	 hd2kN5fCSbbzKTLOk/VWAj+BeWahiV/30Hdx3TTEbO7DevB/QiOJv8YOsm01uuzNOXqRd
	 tRVN+Tn6KBFOVcYub4gYnQMlApSTXD5NT8wUJE5czqBv5TDMdQTiG8WHN0GiKhys2hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGKqKcB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6652606A896
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGKqKcB4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947AC1F00A06;
	Wed, 11 Nov 2026 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411405;
	bh=5ZEXguI78NypJpH9q83OSt4iLK81RIIPU3vwPO6f84I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AGKqKcB4S0Zl6KDAMXDDLUqRFmkdbVJoAkGP6pbrDkAiwUFgrM4XvA+Oaq8hz6IBc
	 jVYvYTOwK1jTNlLxBsFDUyIJz036IRn6F8vpOa5MrFgw5NW4tjuQZPCwLDAzEZLLrF
	 C2plKpgioJd8RcKAjBTNGUAlN86ZV4QNnRvcyyJ/XE7ISJbu+Latq0SVkLcMIrCBkz
	 3mXol0f8SUbOPK4TGr2LZ4USLIuAAd2x3AUegyoHxbE74JyQ7tYYCjIKYQsx44111X
	 K2y79aD3Crxjup4x7Vl3ACQ90URCI5YZjXYQcxddxBXgMe0SPwEsDYzZwFp9fLXf70
	 eklyV1UGrlMYQ==
Message-ID: <sashiko-outbox-209228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 08/29] bpf: Add flags and release kfuncs to
 the dtor registry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <ffc489a9770015068f1fe344435515d9265600be.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <ffc489a9770015068f1fe344435515d9265600be.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 15:36:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: global state corruption in
  register_btf_id_dtor_kfuncs() [1]
--

commit 296a6e3ce795b555a37d881e7098d3e3144bc374
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add flags and release kfuncs to the dtor registry

This commit adds flags and release_btf_id fields to struct btf_id_dtor_kfunc
so the unwinder can look up and validate cleanup destructors alongside map
kptr destructors.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 228b93d4f8c94..6359c5e343bd4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -10217,6 +10280,22 @@ static int btf_check_dtor_kfuncs(struct btf *btf=
, const struct btf_id_dtor_kfunc
>  	for (i =3D 0; i < cnt; i++) {
>  		dtor_btf_id =3D btf_relocate_id(btf, dtors[i].kfunc_btf_id);
> =20
> +		if (!dtors[i].flags) {
> +			pr_err("no flags for the destructor of btf_id %u\n", dtors[i].btf_id);
> +			return -EINVAL;
> +		}
> +		if ((dtors[i].flags & BPF_DTOR_CLEANUP) && !dtors[i].release_btf_id) {
> +			pr_err("no release kfunc for the cleanup destructor of btf_id %u\n",
> +			       dtors[i].btf_id);
> +			return -EINVAL;
> +		}
> +		if (dtors[i].release_btf_id &&
> +		    btf_check_release_kfunc(btf, btf_relocate_id(btf, dtors[i].release=
_btf_id))) {
> +			pr_err("btf_id %u is not a release kfunc for the destructor of btf_id=
 %u\n",
> +			       dtors[i].release_btf_id, dtors[i].btf_id);
> +			return -EINVAL;
> +		}
> +
>  		dtor_func =3D btf_type_by_id(btf, dtor_btf_id);
>  		if (!dtor_func || !btf_type_is_func(dtor_func))
>  			return -EINVAL;
> @@ -10311,8 +10390,12 @@ int register_btf_id_dtor_kfuncs(const struct btf=
_id_dtor_kfunc *dtors, u32 add_c
> =20
>  	/* remap BTF ids based on BTF relocation (if any) */
>  	for (i =3D tab_cnt; i < tab_cnt + add_cnt; i++) {
> -		tab->dtors[i].btf_id =3D btf_relocate_id(btf, tab->dtors[i].btf_id);
> -		tab->dtors[i].kfunc_btf_id =3D btf_relocate_id(btf, tab->dtors[i].kfun=
c_btf_id);
> +		struct btf_id_dtor_kfunc *dtor =3D &tab->dtors[i];
> +
> +		dtor->btf_id =3D btf_relocate_id(btf, dtor->btf_id);
> +		dtor->kfunc_btf_id =3D btf_relocate_id(btf, dtor->kfunc_btf_id);
> +		if (dtor->release_btf_id)
> +			dtor->release_btf_id =3D btf_relocate_id(btf, dtor->release_btf_id);
>  	}
> =20
>  	tab->cnt +=3D add_cnt;

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failed call to
register_btf_id_dtor_kfuncs() wipe out all previously registered destructors
in the shared vmlinux BTF [1]?

Multiple initcalls append entries to the global vmlinux BTF's dtor_kfunc_tab
via krealloc().  However, if a later registration fails in
btf_check_dtor_kfuncs(), exceeds BTF_DTOR_KFUNC_MAX_CNT, or fails krealloc(=
),
the error path unconditionally frees the entire table:

kernel/bpf/btf.c:register_btf_id_dtor_kfuncs() {
	...
end:
	if (ret)
		btf_free_dtor_kfunc_tab(btf);
	btf_put(btf);
	return ret;
}

Because the error paths in register_btf_id_dtor_kfuncs() run before the new
entries are appended to btf->dtor_kfunc_tab, dropping the
btf_free_dtor_kfunc_tab(btf) call on error would leave existing vmlinux
entries intact (while module BTFs still free their table in btf_free() if
module init fails).

[1] https://sashiko.dev/#/bug/linux-5f5fa9b2-fc98-4120-b5d5-adb2695404ab

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D8
