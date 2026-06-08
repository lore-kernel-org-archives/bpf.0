Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6941F30BB
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936842; cv=none; b=WYJ7KVRbtNeBXKiwkGBN1cki3bo/l9yLPGEoRB4060IZElRzZmQs3FxZzALSOeFYoqPr1q+b2M4hcwEuZ9fyUtzU6vDBrk11dwWBR5InVbwoP0Yalqom2LVcMSK4KlQ+5ODr0SiV0ici2OvSGoUe7wOO+61aMPgZr/+wZSvaoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936842; c=relaxed/simple;
	bh=82Rmi6TJq3q0TO79OeD+weQj3RxVI1Vdg2ZKILv4dro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IU1KpZnPUcFimI1DTWBhwQqmur9aKyEFujMMXSVVcOcHDGqJT8Xe2oS8YA7roxGjqRtO+usnjRtJAgW2EG2auL9esvkR7hhBnGPs8oj+SS3mMp2sSegus9r0PwQH9OkDh9aObOWef8qeiy8y3EiuljSplLdTquoIFEqbOInPK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdpk1MVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdpk1MVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272F91F00893;
	Mon,  8 Jun 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936841;
	bh=KmFbWDaGyObUAm0tkkta7VsZQbXs2HGOYaxou+NEJIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pdpk1MVmMPL1nIGd6BXG5Z1s+rOIQC8Tczwtbdpu3pCfBDkTM3ue9n7bMA9Zo9wsZ
	 Be/RH0plnTE32rr24Ji7BuqEWLs/gNv6Iw6LKl117g/QZyfTQrTb+HSzCi6lJTobaw
	 UC4g6OR3xSTiQA9AlmqLcE3zzHe9fXC+/vCoBF+mC9ELqow38MlN47rWx4uxwtyDi5
	 F3MvN6ooxQTT1PVcruJUnh/ACdCl9CYd7lOhjmbgVHvG+nwYQm9HuUiOSUXWRfWJxC
	 +wqTsVlBNFuhDSBuuA/BPEbEpedFq/cgnpCOMzcM7jMz30nm5FGFcLoFv3kcjtEw6Y
	 LNRbaEZ4eT3zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 5/5] selftests/bpf: Exercise kptr map update
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608144841.1732406-6-memxor@gmail.com>
References: <20260608144841.1732406-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:40:40 +0000
Message-Id: <20260608164041.272F91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The newly added selftests incorrectly assert that map updates =
preserve old kptr references, codifying severe preexisting kernel bugs wher=
e bpf_obj_free_fields() is missing during map updates. This leads to leaked=
 kptrs and cross-key uninitialized memory corruption in hash maps.
--

commit 4d2aa8d889c01038cf4926ada20dda3564090fb2
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Exercise kptr map update lifetime

Add focused map_kptr coverage for BPF-side map updates that touch values
containing referenced kptrs. The new syscall programs stash the testmod
refcounted object in various maps, then update the same map from BPF.

> diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing=
/selftests/bpf/progs/map_kptr.c
> index e708ffbe1f610..3fbefc568e0a6 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr.c

[ ... ]

> +SEC("syscall")
> +int test_array_map_update_kptr(void *ctx)
> +{
> +	struct map_value init =3D {}, *v;
> +	int key =3D 0, ret;
> +
> +	v =3D bpf_map_lookup_elem(&array_map, &key);
> +	if (!v)
> +		return 1;
> +	ret =3D stash_ref_ptr(v);
> +	if (ret)
> +		return ret;
> +	ret =3D check_refs(3);
> +	if (ret)
> +		return ret;
> +	ret =3D bpf_map_update_elem(&array_map, &key, &init, BPF_EXIST);
> +	if (ret)
> +		return 4;
> +	return check_refs(3);
> +}
> +
> +#define DEFINE_HASH_UPDATE_KPTR_TEST(name, map)			\
> +SEC("syscall")							\
> +int name(void *ctx)						\
> +{								\
> +	struct map_value init =3D {}, *v;				\
> +	int key =3D 0, ret;					\
> +								\
> +	ret =3D bpf_map_update_elem(&map, &key, &init, BPF_NOEXIST); \
> +	if (ret)						\
> +		return 1;					\
> +	v =3D bpf_map_lookup_elem(&map, &key);			\
> +	if (!v)							\
> +		return 2;					\
> +	ret =3D stash_ref_ptr(v);					\
> +	if (ret)						\
> +		return ret;					\
> +	ret =3D check_refs(3);					\
> +	if (ret)						\
> +		return ret;					\
> +	ret =3D bpf_map_update_elem(&map, &key, &init, BPF_EXIST); \
> +	if (ret)						\
> +		return 4;					\
> +	return check_refs(3);					\
> +}

[Severity: Critical]
This is a pre-existing issue, but does this selftest actually codify an
existing memory leak and uninitialized memory corruption in the kernel?

Looking at array_map_update_elem() and htab_map_update_elem() in the kernel,
they incorrectly use bpf_obj_cancel_fields() instead of
bpf_obj_free_fields() when overwriting elements. Because
bpf_obj_cancel_fields() explicitly skips BPF_KPTR_REF, the old kptr
references are never freed.

For hash maps specifically, htab_map_update_elem() allocates a new element
(l_new), and copy_map_value() explicitly skips copying special BTF fields
like kptrs. This means l_new receives uninitialized garbage memory for its
kptr field before being inserted into the map. Meanwhile, the old element is
placed in the freelist without its kptr being freed, leaking the reference.

By asserting check_refs(3) after the map update, is the test just measuring
this leak and ignoring the uninitialized garbage now present in the map,
rather than confirming that the kptr was gracefully preserved?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144841.1732=
406-1-memxor@gmail.com?part=3D5
