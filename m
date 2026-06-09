Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37B33B6C4
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781038284; cv=none; b=gLsyqIXQNBQV98FosHydW0EHvLuhmWTncWioLVm2+90ZchgbWDfkJoI6KpUQ4WI2LwesADTcVamdoFereKnfn8eOygYrOUhqjtQCMvfsin/aoVDqpHwaJiqLWiWgJ3173J/bfUcWrpjRYLFQGHPviRuudb5wnqMdwhsU5DlYbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781038284; c=relaxed/simple;
	bh=ZqqOar3K2NP3xPOKyP+HDYf9pHbvxNdM1Q38Vg/gm8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oHMPD4ATxL82nUuy7h7SU+1KGMwubEtEVcWEF/jjEifpL/6Y/D5XhrOuHS+YlKMiqzFSGtU2p8CfjdyrK3/QsAq7GcTnCtWQFzsCWgQ3etwaZC4XrRvbIGGkqRGm1bXevQUpF9RVcC54FJlS+hhiPee7FXiHwqnoU6aEp0FoAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvCnBFnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvCnBFnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BB31F00893;
	Tue,  9 Jun 2026 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781038283;
	bh=o9o4M5P/iW5fwftLFXK3d+C4QdqYKStpo+GxEIAqQZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvCnBFnWmF0yT8lG8LSdBcUYZ38z0WpikVQrtmACTJMZS8kODCF0IPUkRL0eKbJFS
	 QFFSObNXwHwLB15JrfaYSb5cZ+z3jv/fpntEgMSt1kmwmrTM5kxUtLh069LxXOk9Lf
	 7VuxAQRCUTBaUSJGe+G4cfmFjU9FVIF29EOAt7RulAh79K2A1H36ZkT2i+Kxnml1pb
	 ruKn4Am5Hx6JL0HzzdlWw4e/y4ZdubveOLJEMNwfye2xPef0PD2cOJi4tzpc3cBOGD
	 4opquiEdDiHWEPdW0rGC/emFtDbu0nW9ABVsK1eSfa1zhYPToYaf6GtXQUF3POUvmI
	 bb0/CqW2oSu6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Exercise kptr map update
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609202548.3571690-5-memxor@gmail.com>
References: <20260609202548.3571690-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 20:51:22 +0000
Message-Id: <20260609205122.E8BB31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added selftests (`test_array_map_update_kptr` and `test_=
hash_map_update_kptr`) codify a preexisting bug where `bpf_map_update_elem`=
 fails to free kptrs in hash and array maps. The tests assert that the kptr=
 refcount remains elevated (`check_refs(3)`) after the update, incorrectly =
locking in the broken BTF field lifecycle behavior.
--

commit ca10a096e58e2f06a9a6605b1b8ff02a49d2d192
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Exercise kptr map update lifetime

This commit adds focused map_kptr coverage for BPF-side map updates that
touch values containing referenced kptrs. The test stashes refcounted objec=
ts
in array and hash maps, then updates them from BPF to verify the refcount
behavior during map teardown.

> diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing=
/selftests/bpf/progs/map_kptr.c
> index e708ffbe1f610..3fbefc568e0a6 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr.c
[ ... ]
> @@ -500,11 +499,95 @@ int count_ref(void *ctx)
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

[Severity: High]
This is a pre-existing issue, but does this test codify a bug where
bpf_map_update_elem() fails to free kptrs in hash and array maps?

When a map element is overwritten with an empty value, shouldn't the kptr
reference count drop? According to the BTF field lifecycle guidelines, map
updates that overwrite existing values with copy_map_value() must call
bpf_obj_free_fields() to release resources held by the old value.

However, it appears array_map_update_elem() in kernel/bpf/arraymap.c calls
bpf_obj_cancel_fields():

kernel/bpf/arraymap.c:array_map_update_elem() {
    ...
    copy_map_value(map, val, value);
    bpf_obj_cancel_fields(map, val);
    ...
}

And free_htab_elem() in kernel/bpf/hashtab.c calls
check_and_cancel_fields() before pushing to the freelist:

kernel/bpf/hashtab.c:free_htab_elem() {
    ...
    check_and_cancel_fields(htab, l);
    pcpu_freelist_push(&htab->freelist, &l->fnode);
    ...
}

Both of these paths skip kptr cleanup.

By asserting that the refcount remains unchanged at 3 after the update in
test_array_map_update_kptr() and test_hash_map_update_kptr(), the tests app=
ear
to incorrectly lock in the broken BTF field lifecycle behavior where array
kptrs leak and preallocated hash map kptrs are resurrected when reallocated.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609202548.3571=
690-1-memxor@gmail.com?part=3D4
