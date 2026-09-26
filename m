Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9B231842
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433452; cv=none; b=Y6yM8heKTBeuWx6Peo649I8O7mSCPZi9I8hF7Tfaob6xeOri9FM4EzwZD56YdYu5sMh0o+IFQF9FTt05MrmjBqz4eMQf6emONdb4aDwr3YV/sDA1PWmpg2ylkGwWX8EKabyRjqUE2SsD3nGF/sBpg60Latl20vsfTRRF+EvJ1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433452; c=relaxed/simple;
	bh=+GwI1NcAAsChkLp9/QJ3LH52ZSmUpo1hTGSJ2eIBUpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UUhjCkLywi/VKCw7ddTxP48n80VAmRzSMFbOrMaVQKS3bx+nHutmwRDHmJZQyPsE2vJprMaT7VerNkvVjQMx9kVVSOED/o2D1ENYjWqosjmqEGaKGfxEcemFK7zWZXP7RHloSQvxTYLhOYW6g63ydSPxkDpl0SmXdkfaE/JzvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBCheQai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBCheQai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D5A1F000FF;
	Sat, 26 Sep 2026 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433451;
	bh=RK2COtFlpv/yXKCM+EIOv8w433Bu689wHWSpo78QoZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBCheQaiwxSV0Rzzido3b7KB0YmbpjefOTf5yAZEw9K9ijnwJrCyYndftVqNLylKl
	 3Rs8Tn6zRBqL5IUT7VUUoynBeDnU+kjU3r5BI8TJSQ2P2uPv4g/x6t0TyoxgyvOOls
	 wJXLaG3NKxajIi8PSzlFm1YBc94lpRAcNy7wj85s16f9wWhE9mp6Mj6aDOHOH7Pf7a
	 Gj4/lngtApVuH8H1ni6RR3NEF4V+u3Wxhs25UwXP283N8IB7LObD5BRHX7HQcYJ04S
	 YZR+gMT3xlnqX5WjIXDurrN8Y2AMgzhgsjYckjq5p9QDOhUIH3TBcGmy4toC7/gVhy
	 FNhTc6Rh6fZrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 15/36] bpf: varying offset access support for
 PTR_TO_BTF_ID pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-15-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-15-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:37:30 +0000
Message-Id: <20260926143731.11D5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: varying offset accesses to nested flexible arrays are incor=
rectly rejected
--

commit 9dc337511b42c543566061ccac0810b0e6e74dae
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: varying offset access support for PTR_TO_BTF_ID pointers

This commit relaxes the verifier requirements for reads like p->arr[i].fiel=
d=20
where p is a PTR_TO_BTF_ID, allowing i to be a non-constant value. It=20
introduces bounds checking based on the access register's min and max bound=
s,=20
along with alignment checks.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -7846,6 +7905,54 @@ int btf_struct_access(struct bpf_verifier_log *log,
>  	} while (t);
> =20
>  	return -EINVAL;
> +
> +check_variable_offset:
> +	if (min_off =3D=3D max_off)
> +		return ret;
> +
> +	/* Find an offset at which access would go to a flexible array tail (if=
 any). */
> +	t =3D btf_type_skip_modifiers(btf, reg->btf_id, NULL);
> +	member =3D find_flex_member(btf, t);
> +	flex_off =3D member ? __btf_member_bit_offset(t, member) / 8 : S64_MAX;

[Severity: Medium]
Does this code handle flexible arrays embedded within nested structs?

When a BPF program attempts a variable-offset access (for example,
ptr->nested_struct.flex_array[i]) on a PTR_TO_BTF_ID, find_flex_member()
is called strictly on the top-level struct type ID.

Because find_flex_member() does not recursively evaluate nested structs,
it returns NULL in this case. This causes flex_off to evaluate to S64_MAX,
which later makes the array bounds check fail since the flexible array
has a size of 0, resulting in -EINVAL being returned.

Can this be updated so the verifier doesn't incorrectly reject valid progra=
ms
performing varying-offset accesses to nested flexible arrays?

> +
> +	/*
> +	 * If this is a varying offset access, the step recorded within a regis=
ter
> +	 * should correspond to one of the arrays visited while walking.
> +	 */
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D15
