Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB84657DA
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486580; cv=none; b=Wun2J1owUK9cQ0j65BF4NreBCS12LyRDTZA4AdhHVX0AgvQCZXdO2ElMuV+i9OZRumB9rrPeat8jAK+bpCw3yhYHhpVADB72khp0dK9l4TBdgstDNkzDnhg6NiXRqqZCKlTgFVb6xdWaDFG0+6JOBS1mLkcoK185I5sO6/DIiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486580; c=relaxed/simple;
	bh=lO4gWdUfNSlgqj3M4Wbw1iVslN0N200DrBNdbVkJWv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0Cm+unl8HH6P1S9/fwnUBxckxMgF+tKnzqCR2FkMfpeglun59b6ODywB2ZwYNA8PlaulWvK8QJi1cjXIipTnl+SZqLxjQBOwwFlozGRKaEA8mkRFI7OlOJ5JalpBnmtyjmEwT1O3ix8LGcztYGWwbwO+PuZAHxvEmRnaw4YP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ96i+AH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ96i+AH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FA41F00893;
	Wed,  3 Jun 2026 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486577;
	bh=Ugb7GZoRxRsSyguiKXw/+4dS8WfDpn6E1AoVgX2rEig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZ96i+AHSuARmcBBMTiYINuH0Lnfnwgn7CI+MafLFM/91cxf5SQHJwQq8d1Dg9seY
	 +3vML3URgeep1hZAAUmObOILgxeF50lEuYkXtORnJiYKwMt8aITNstEYhsmDioHHOY
	 88LYVqyoUjE4QDdogJ3zU4Aidd1gcz8KHuqdY9zpjsZSl+MKan+Mj6EGOsjguMYq4G
	 tpEzUvaBt5jHfke6PjjpovvZx/vWs64RUeIYqUVexNddXShfL65hy57JNOILrx5mKf
	 uk01qJTnR1hXn22Ve6A+eXBFYlgVWt37NYCV8j62nr+iDVseBbpRLbnFEDb5ZKK5oh
	 C0CLpmyr+qi7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 bpf-next 19/29] libbpf: Add btf_type_is_traceable_func
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603110554.29590-20-jolsa@kernel.org>
References: <20260603110554.29590-20-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:36:16 +0000
Message-Id: <20260603113617.49FA41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] btf_get_type_size() fails to handle union types, leading to the =
incorrect rejection of functions with valid union arguments.
--

commit 3f5d4e8440eaf929ad94e8774deb7fce495d30c8
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add btf_type_is_traceable_func function

This commit adds the btf_type_is_traceable_func function to libbpf to
perform the same checks as the kernel's btf_distill_func_proto, preventing
attachment on unsupported functions. It exports this function via
libbpf_internal.h for use in benchmark tests.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ab2071fdd3e8b..c659865ec2def 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +static int btf_get_type_size(const struct btf *btf, __u32 type_id,
> +			     const struct btf_type **ret_type)
> +{
> +	const struct btf_type *t;
> +	int i;
> +
> +	*ret_type =3D btf__type_by_id(btf, 0);
> +	if (!type_id)
> +		return 0;
> +	t =3D btf__type_by_id(btf, type_id);
> +	for (i =3D 0; i < MAX_RESOLVE_DEPTH && t && btf_type_is_modifier(t); i+=
+)
> +		t =3D btf__type_by_id(btf, t->type);
> +	if (!t || i =3D=3D MAX_RESOLVE_DEPTH)
> +		return -EINVAL;
> +	*ret_type =3D t;
> +	if (btf_is_ptr(t))
> +		return btf__pointer_size(btf);
> +	if (btf_is_int(t) || btf_is_any_enum(t) || btf_is_struct(t))
> +		return t->size;

[Severity: Medium]
Will this return -EINVAL for union types?

Unlike the kernel where btf_type_is_struct() covers both structs and unions,
libbpf's btf_is_struct() strictly checks for BTF_KIND_STRUCT. Because
btf_is_union(t) is missing from this condition, union types fall through and
return -EINVAL.

> +	return -EINVAL;
> +}
> +
> +bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_=
type *t)
> +{

[ ... ]

> +	for (i =3D 0; i < nargs; i++) {
> +		/* No support for variable args. */
> +		if (i =3D=3D nargs - 1 && args[i].type =3D=3D 0)
> +			return false;
> +		ret =3D btf_get_type_size(btf, args[i].type, &t);
> +		/* No support of struct argument size greater than 16 bytes. */
> +		if (ret < 0 || ret > 16)

Because of the behavior above, will this regression incorrectly reject any
valid union arguments up to 16 bytes since btf_get_type_size() will return a
negative value? Should btf_get_type_size() check btf_is_union() to match the
kernel's actual tracing attachment rules?

> +			return false;
> +		/* No support for void argument. */
> +		if (ret =3D=3D 0)
> +			return false;
> +	}
> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110554.2959=
0-20-jolsa@kernel.org?part=3D1
