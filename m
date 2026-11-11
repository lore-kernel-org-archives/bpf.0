Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409245;
	b=yPAeE2dT6U9vCCqh7gf6gVVLqZdDRkPbLUuyg5GvevT10s8LnYc8EJpJECtk9bHy+N07
	 FWQ15rzh8iNRWO7xLhJ8LDmq71Zn93VGGr6eoOxjq1+g9ga9cZpsO/pyC4k7i5VBryGpW
	 qhkzo+1o6kpxmoMcvtVC9uACAiYbL4sEDOCv5uJ7+FGAW7U/IZzRZXhHz7YWmrdWubydA
	 VKfzVtEmV/2qLhJPgMhbK6+qIeJNOiYzEaJwHXLs3r8If4AciOmfDDmXnszm5uCmRkkZz
	 m+RIzbbRck+zWXJJgeSN3y7WBca73TSkU7P/6eeAJoJ9winjYbG0Rh2Bu2NvrqFPS6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1BusrvtlUeQShABlnJe5VFQ9CjVopb1WAkwVEf1KyXg=;
	b=UnIt0QM22818RuhfeKVy0GRXI7mCUW3azDl7rBTA7S1qvsCdpt02YvcOvlIHGPnCSKKG
	 gIIXDzYoScVpm/ClaitH4aFzC/6CTqVuU4dOX0CoIh7wkDjNTuSEDx9pkuiqcqEpfo/Gr
	 t8UlwdT6WnIKDdWcGcJMtbUMLLKkmeHd8R9JeSbBbAS3kJmj+nz3Ku3UxHiH02Bfzfkww
	 5knvhEnnIekUUC5ActwjoNBrsRXq1AusE6/FjrueDUMXA8lS+nIU9UUak276B73K8KB8g
	 Ks1A4TdM2q/MwxDN3oOTBx0mfp2LBX7FHvPlX+QSp9YU9Cd28tP0o0qtTlQlRFqUuNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3N8i+qD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4840606B20B
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3N8i+qD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4996E1F00A05;
	Wed, 11 Nov 2026 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409245;
	bh=1BusrvtlUeQShABlnJe5VFQ9CjVopb1WAkwVEf1KyXg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=U3N8i+qDmEcIr30GcPJC/sjCyPQ/LdvlkgwjOYuDxqxJmyJcRpUAsC+oWNs5AzoJG
	 cF3gJiRhgeDylPagPApYV02vOOuDRoBoXmpZGJnNHNLgswFflJG563ECR31ja7i4mD
	 XobFyMjTeXEnW9BRV2noDGWQWrGzUm/+ZGdw8CU0cJcRiTTut9H8HgvSWsClgtNHyN
	 kqFcz1lXkQ3+3vXKGDeFONp/UDJhuVJP2LyZt+WqkJ9eKIiYYpJoXthD7E12bzXHf/
	 ZALrTOEDRlEp86mniy5bN4ScqRov1X3Bk2G5SpDDfKaQMLlUTdNDC84kAe/jT2IQws
	 1/q8geC+575SA==
Message-ID: <sashiko-outbox-209209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 09/29] bpf: Register cleanup destructors for
 more types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <552b16f22843843822ccf014138e390ac72909ab.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <552b16f22843843822ccf014138e390ac72909ab.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 15:00:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: btf_find_dtor() misses nf_conn destructors when
  CONFIG_NF_CONNTRACK=3Dm
--

commit ddb65cf317bc73659c05f7b86c4aa44d5480e3c1
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Register cleanup destructors for more types

This commit registers BPF_DTOR_CLEANUP destructors and void (*)(void *)
wrappers for open-coded iterators and referenced types across the kernel
so that stack unwinding on bpf_throw() can release held references.

> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index c2df7c9482812..9d9d4e97ca4e5 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
[ ... ]
> @@ -537,12 +553,34 @@ static const struct btf_kfunc_id_set nf_conntrack_k=
func_set =3D {
>  	.set   =3D &nf_ct_kfunc_set,
>  };
> =20
> +BTF_ID_LIST(nf_ct_dtor_ids)
> +BTF_ID(func, bpf_ct_release_dtor)
> +BTF_ID(func, bpf_ct_release)
> +BTF_ID(func, bpf_ct_free_dtor)
> +BTF_ID(func, bpf_ct_insert_entry)
> +
>  int register_nf_conntrack_bpf(void)
>  {
> +	/* The only kfunc that takes an allocated entry off a program is bpf_ct=
_insert_entry() */
> +	const struct btf_id_dtor_kfunc nf_ct_dtors[] =3D {
> +		{
> +			.btf_id         =3D btf_nf_conn_ids[0],
> +			.kfunc_btf_id   =3D nf_ct_dtor_ids[0],
> +			.release_btf_id =3D nf_ct_dtor_ids[1],
> +			.flags          =3D BPF_DTOR_CLEANUP,
> +		},
> +		{
> +			.btf_id         =3D btf_nf_conn_ids[1],
> +			.kfunc_btf_id   =3D nf_ct_dtor_ids[2],
> +			.release_btf_id =3D nf_ct_dtor_ids[3],
> +			.flags          =3D BPF_DTOR_CLEANUP,
> +		},
> +	};
>  	int ret;
> =20
>  	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &nf_conntrack_kfun=
c_set);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &nf_c=
onntrack_kfunc_set);
> +	ret =3D ret ?: register_btf_id_dtor_kfuncs(nf_ct_dtors, ARRAY_SIZE(nf_c=
t_dtors), THIS_MODULE);

[Severity: Medium]
Can btf_find_dtor() find nf_ct_dtors when CONFIG_NF_CONNTRACK=3Dm?

tc_cls_act_func_proto() in net/core/filter.c executes
BTF_TYPE_EMIT(struct nf_conn___init), so both struct nf_conn
(btf_nf_conn_ids[0]) and struct nf_conn___init (btf_nf_conn_ids[1]) are
emitted into vmlinux base BTF and have BTF IDs below nf_conntrack's module
btf->start_id.  However, register_btf_id_dtor_kfuncs() stores nf_ct_dtors in
nf_conntrack's module dtor_kfunc_tab via THIS_MODULE.

When resource_registry() looks up the destructor, btf_find_dtor() walks to
base_btf before searching the module's table:

kernel/bpf/btf.c:btf_find_dtor() {
	...
	while (btf_id < btf->start_id)
		btf =3D btf->base_btf;
	dtor =3D btf_dtor_tab_find(btf, btf_id);
	if (dtor || !btf_is_module(btf)) {
		*btfp =3D btf;
		return dtor;
	}
	...
}

Because btf_id < btf->start_id, btf_find_dtor() skips nf_conntrack's
dtor_kfunc_tab, searches vmlinux's table where nf_ct_dtors was not
registered, and returns NULL.  As a result, the verifier rejects any XDP or
sched_cls program that calls bpf_throw() while holding a conntrack reference
when CONFIG_NF_CONNTRACK=3Dm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D9
