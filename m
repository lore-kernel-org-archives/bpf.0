Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC32DB7BD
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286660; cv=none; b=pHMRfZeoYNRj64sdN1A5AkRy6MOVcGhjesnQhlQxweKKxpLNvqu+FpmtuxrZlIirEiNzKKiwph1UMExAcT6w0DTFfh7Kc7NR/lKGwgpu2IdhjQQlIdtrpKKoW0VKbKHdjDqrRbFDG0DvARuBKYhUDFz4n/5F6coc/KH/TJ00Wv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286660; c=relaxed/simple;
	bh=4LqOXfd2gX3pZC2thL56rvvZvKwWtoJHwhhQI+NsXA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ilXSer/7JCv+xA2KTYWUxL6Rsr7tEJalVve1csY7pIGjCGzqXm+53RXf9a4+/i2TeblCb5sHhbf7RL0dHVvMN45jM7ozdJ0T4x+ny+7cfbZ3XM5kjRWAoEpHEJFircNq6uiQCaitJXujo41xWUxXluHqGuVseBMrjd0RFhZqS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC6ezMR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC6ezMR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F361F000E9;
	Wed, 24 Jun 2026 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782286658;
	bh=DLKnrU75jc6eX/8gODbcELeKdSpw1OVyEeYSsJbL+lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QC6ezMR/WRm8ZzMgp6pthDcs0DacLdZLvIIXxEhGnsMkFETGmhp/5T48QXiuKRO0Y
	 mEbJGYg7Tg+i483L0sKqn+X12j1qnWPrnrFMSrOA08NmQu2btr/iPgyos/gZ8hwxxz
	 a6VX1x80P6g/gihmLYdeKoGyevaRUEnXdJiFi3S3WCJqMHgBkGznBd0R2+Q7VjG11U
	 O6fw7EC9RQlTR3ok/Q2j22DfM7KS8WOkAXuWkrH0/FNTJAlCxeDNhJYyz1RxKhR38X
	 0w0ZXREpCIXDgZmD3MT3zJY0uCiTBxkO1Izm4XhAjgYDSl82knpX+JRR+g0HzS1Skj
	 T5uIX7CeuyOSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Avoid eliding lookup NULLness for inner
 map templates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624072031.735846-1-sun.jian.kdev@gmail.com>
References: <20260624072031.735846-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 07:37:38 +0000
Message-Id: <20260624073738.86F361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch relies on the `BPF_F_INNER_MAP` flag to prevent unsa=
fe NULL-check elision for inner map templates. However, this fix is fundame=
ntally incomplete because `BPF_MAP_TYPE_PERCPU_ARRAY` explicitly rejects th=
e `BPF_F_INNER_MAP` flag during creation. This leaves per-CPU arrays vulner=
able to out-of-bounds memory accesses and NULL pointer dereferences.
--

commit 3ab30507af620d9da556d3b2d80a1f172474785b
Author: Sun Jian <sun.jian.kdev@gmail.com>

bpf: Avoid eliding lookup NULLness for inner map templates

This commit prevents the verifier from eliding NULLness checks for array ma=
ps
used as inner map templates. It achieves this by requiring that the
BPF_F_INNER_MAP flag is not set on the map before clearing the PTR_MAYBE_NU=
LL
flag from the register.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f7..a32704bb5e058 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10577,6 +10577,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
> =20
>  		if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
>  		    can_elide_value_nullness(meta.map.ptr->map_type) &&
> +		    !(meta.map.ptr->map_flags & BPF_F_INNER_MAP) &&

[Severity: Critical]
This isn't a bug introduced by this patch, but does this check completely
prevent NULL-check elision for all inner map templates?

Looking at can_elide_value_nullness(), it allows both BPF_MAP_TYPE_ARRAY
and BPF_MAP_TYPE_PERCPU_ARRAY.

However, in array_map_alloc_check(), the BPF_F_INNER_MAP flag is
explicitly rejected for per-CPU arrays:

kernel/bpf/arraymap.c:array_map_alloc_check() {
    if (attr->map_type !=3D BPF_MAP_TYPE_ARRAY &&
        attr->map_flags & (BPF_F_MMAPABLE | BPF_F_INNER_MAP))
        return -EINVAL;
    ...
}

Since BPF_MAP_TYPE_PERCPU_ARRAY can never have the BPF_F_INNER_MAP flag
set, won't this allow the verifier to still incorrectly elide NULLness
checks for per-CPU arrays used as inner map templates?

If a per-CPU array with a large max_entries is used as an inner map
template, and a concrete map with a smaller max_entries is inserted at
runtime (which is possible because percpu_array_map_ops.map_meta_equal uses
bpf_map_meta_equal() which ignores max_entries checks), couldn't this
lead to an out-of-bounds access or NULL pointer dereference?

Additionally, since percpu_array_map_gen_lookup() also relies on
BPF_F_INNER_MAP to skip JIT inlining, will it inline the lookup with the
template's excessively large bounds hardcoded, resulting in out-of-bounds
heap reads on the concrete inner map?

>  		    meta.const_map_key >=3D 0 &&
>  		    meta.const_map_key < meta.map.ptr->max_entries)
>  			ret_flag &=3D ~PTR_MAYBE_NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624072031.7358=
46-1-sun.jian.kdev@gmail.com?part=3D1
