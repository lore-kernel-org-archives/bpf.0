Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997452;
	b=B3uzhGaiD1NqIG66ulbV2HAsNwEQxFEw89+PH7EEzVV27FdMbIpm+SjBg04YD53d15B0
	 ug9xHHF2D6tCab6PwO4Nf4bTGIWL/evOJDZDdvaxX3U2m8a6ccXdaNJTgEa5uRvnxpAO0
	 LKkmBKJ71EwBVJnCD4s8rh/Lp/bTU2ojJuScxeItcwNRZnvndSj3mcdLwlUfFQj7pJOZA
	 9y2HHJg9bZQvQjrEjZqhB4N+/p9TaeYd+c9pY8L4tqSJcJaPb0uqRGtZyv/gWuFe5yDz3
	 diL08Q2mU4qRda06gKgj61tjucvPztPVr7VINpxMiG/aqP+nDxOSAmFihUa0m3rIONA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EY1CCjAh40VkNUX0mBVh+0Prbt7Y9Tl2VacOxDd/B3I=;
	b=0zLC4n3RKA3Sud+Tag5WvXsztAIhcW9mEzieZyt3SxFTtmjb7Pqwp6IZ++msdmL2W3lk
	 nmaHBPF97xn4Ux7VdG/izmSXWCE1NtopwzaWXmNEOyfUzx4ZsOzR3WhTuPhxP1Uqoe6LC
	 VBQ2V/dmUrNwf7QRU9qUbmymTgY07Xahzlnq9nnYivm3mHbLUHVwIHxlm7wd8t4oYrJIg
	 ly75H+M5D7m/XabY7EhVlzMyvwRKJwHew6FiMBTooU3LkbBe25c7ivpItHL386+kQBaWL
	 M+VX+6LGyg9IjxXhF0zzbG+ATm/LZ8N/D6DHBrArcH2ZmL7ANHsBtJPreJQ/qvapEIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn8Ii9OC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597F606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn8Ii9OC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9281F0089F;
	Fri,  6 Nov 2026 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997451;
	bh=EY1CCjAh40VkNUX0mBVh+0Prbt7Y9Tl2VacOxDd/B3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tn8Ii9OC28HSFgrPQyObOpoc7rx9w42kkD+iwBH6/CWr2QvgnnT1q6g/XKACxYwvh
	 K3NpRfDV4pK8fsmYs5KvswX6V2GejC9g0tkh8Hrn4/ny4hACrgcXDd3hRgMfvR1rk4
	 lGduxj8zMJ17D8t9yMizayOhwQs4QkGfD5OiYmsLAvTZVqEhgJy+ThkDXzUHmhDcUr
	 dNPBn7iVir4TmZhwNBGofVgvhWGqtFKnVFlX1R/Txtr/3yfT+LjmJlnNOUBmVfUCMv
	 4VhmuuqR+iqZ+mCQMKG4b/5bI4xDqwak2UUcLvhESmLCOOpYEQFN+gnuXpIjc5v3ze
	 mvNdEaPYrGjuA==
Message-ID: <sashiko-outbox-202238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/7] bpf: Add
 bpf_btf_get_struct_member_info() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106-lskel-struct-ops-v1-1-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
 <20261106-lskel-struct-ops-v1-1-a4486ffc79cb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:37:30 +0000
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
- [Medium] bpf: 32-bit return value truncation in
  bpf_btf_get_struct_member_info()
--

commit 053d54c272170ad0de7a256a743bef2e2fac76d1
Author: Siddharth Nayyar <sidnayyar@google.com>

bpf: Add bpf_btf_get_struct_member_info() helper

This commit adds the bpf_btf_get_struct_member_info() helper for
BPF_PROG_TYPE_SYSCALL programs to query struct member byte offsets and
indices or struct sizes from vmlinux or module BTF.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 228b93d4f8c94..8d9188dda34e0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -9682,6 +9682,79 @@ const struct bpf_func_proto bpf_btf_find_by_name_k=
ind_proto =3D {
>  	.arg4_type	=3D ARG_ANYTHING,
>  };
> =20
> +BPF_CALL_4(bpf_btf_get_struct_member_info, u32, btf_id, int, btf_obj_fd,
> +	   const char *, name, int, name_sz)
> +{
> +	const struct btf_member *member;
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	long ret =3D -EINVAL;
> +	u32 i;

[ ... ]

> +	for_each_member(i, t, member) {
> +		const char *mname =3D btf_name_by_offset(btf, member->name_off);
> +
> +		if (!mname || !*mname)
> +			continue;
> +		if (!strcmp(mname, name)) {
> +			u32 moff;
> +
> +			if (__btf_member_bitfield_size(t, member)) {
> +				ret =3D -EOPNOTSUPP;
> +				goto out;
> +			}
> +			moff =3D __btf_member_bit_offset(t, member) / 8;
> +			ret =3D moff | (((u64)i) << 32);
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	btf_put(btf);
> +	return ret;
> +}

[Severity: Medium]
Does storing the 64-bit return value in long ret truncate the upper 32
bits on 32-bit architectures?

Because long is 32 bits wide on 32-bit kernels, assigning
moff | (((u64)i) << 32) to ret discards the member index i in the upper
32 bits before returning, breaking callers such as struct_ops light
skeletons when querying any member at index i > 0.  Declaring ret as s64
would preserve both negative error codes and the full 64-bit value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lskel-stru=
ct-ops-v1-0-a4486ffc79cb@google.com?part=3D1
