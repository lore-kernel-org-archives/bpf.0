Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6036CDF2
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837041; cv=none; b=jEib4I5FVLMbIAkfH8amKM2iEoU4oQzKmGiEYsL16DOZzLcfhJYgqdh6LLhoMx1XElNXLXk/K2pGWLlc9Mjhv3FgOxZewMBBwezRw2iksULy/xeRzrH9NxmqDQ+lN4m9Jv120mNxea9Ir3+dbxOXQ2xvVAbULMOtVj0OiBZP5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837041; c=relaxed/simple;
	bh=hvxvSXy9zxObibYYOn645R5UnPTSLLug4hs/arQVoUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RnXddbz3Men29VoZuWAVXEAI93MNOHorNa+jmwkTNz3tBmqZ32z1YqcO8piExuCDLIh25G2dFUSLI4vN5+MVijVWuyjXkxowleUtHotCQb2SNkfYDb29y/mLDfFyu2Pap+Ob/o87AZMTB0zh/GnapD2AX9tVzzeGY0EqFT0wJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNc4NYML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNc4NYML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3B51F000FF;
	Sat, 19 Sep 2026 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789837038;
	bh=cTLeGTS8SlD8XFUjNMy1WAiOBWiYPXUavk1UEmj4ymQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNc4NYML8US+Duj1O5yowd8iYPE9gNmA4clgIOJUN1ecccQjURtACN7Gk4LKIEYYX
	 hNctJ0J91PI4BJmdgqejB1ZULN2WRx4OJOUT9PA24u3Aeq1BwbBZ9gDJ67Cg3X3rYP
	 ZjKpV4wnjPFc1P8y1IMrPNNm1GZgmekx5nvBBeilOrJxViKL+ixllAjmrg8tq99uqL
	 Xw+N2ZtWs3l6QGV2dVnd74wprz1pBgH/SSiHB2ngPgTif4ikXSOWTMRDf3gXNE0zas
	 vrtiAjz9V2Y6uhg8BIXVuOQtiTHt4WuPmjXBoAP98rvZMeKHmOk3auldeSOsOn21Sq
	 2wJMvtNPvUSog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Return -EINVAL from btf__align_of()
 for unknown type ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhinav Madake" <abhinavmadake@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919164229.95154-1-abhinavmadake@gmail.com>
References: <20260919164229.95154-1-abhinavmadake@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 16:57:18 +0000
Message-Id: <20260919165718.9C3B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: btf__align_of() negative error breaks btf_dump.c
--

commit d6024f50b48c7fc7873ce247e9f420706729d50a
Author: Abhinav Madake <abhinavmadake@gmail.com>

libbpf: Return -EINVAL from btf__align_of() for unknown type ID

btf__align_of() passes the result of btf__type_by_id() straight to
btf_kind() without checking for NULL, so an unknown type ID
dereferences a NULL pointer instead of returning an error like the
other btf__*() lookups do.

BTF parsed from raw data cannot trigger this, since btf_sanity_check()
rejects dangling references. BTF built with the btf__add_*() API can:
those only check the ID range, so a forward reference to a type that
was never added, followed by btf__align_of() on it (directly, or
through the recursive struct/array/typedef cases), crashes.

Check for NULL and return -EINVAL, matching btf__type_by_id().

Link: https://github.com/libbpf/libbpf/issues/983

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 908bd344229d5..d15bc09ac53de 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -986,8 +986,12 @@ __s64 btf__resolve_size(const struct btf *btf, __u32=
 type_id)
>  int btf__align_of(const struct btf *btf, __u32 id)
>  {
>  	const struct btf_type *t =3D btf__type_by_id(btf, id);
> -	__u16 kind =3D btf_kind(t);
> +	__u16 kind;
> =20
> +	if (!t)
> +		return libbpf_err(-EINVAL);

[Severity: Medium]
Will this negative return value break callers in tools/lib/bpf/btf_dump.c
that expect 0 on error?

When btf_dump.c processes invalid BTF types, this -EINVAL return bypasses
checks for 0, leading to modulo operations with a negative number promoted
to a large unsigned integer.

In ptr_is_aligned(), the negative alignment bypasses the check for 0:

tools/lib/bpf/btf_dump.c:ptr_is_aligned() {
	int alignment =3D btf__align_of(btf, type_id);

	if (alignment =3D=3D 0)
		return false;

	return ((uintptr_t)data) % alignment =3D=3D 0;
}

In btf_is_struct_packed(), the error bypasses the false-check (which
expects 0), causing an invalid modulo operation with 8 * -22 promoted
to unsigned:

tools/lib/bpf/btf_dump.c:btf_is_struct_packed() {
    ...
		align =3D btf__align_of(btf, m->type);
		bit_sz =3D btf_member_bitfield_size(t, i);
		if (align && bit_sz =3D=3D 0 && m->offset % (8 * align) !=3D 0)
			return true;
    ...
}

Should the callers in btf_dump.c be updated to handle negative return
values?

> +
> +	kind =3D btf_kind(t);
>  	switch (kind) {
>  	case BTF_KIND_INT:
>  	case BTF_KIND_ENUM:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919164229.9515=
4-1-abhinavmadake@gmail.com?part=3D1
