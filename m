Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE11D54FA
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102764; cv=none; b=NHYNfU0y/kcckKRKMCebIHK+J9sZttsNPiufAwc+/Exq+o51BkZ9+HH2ZLquyAjA0NN7XFUoQx0OPk+Cx24LYmNYPkT4d3XgDJaxXQSM+4jCxESvsiRzC8F346hQiSQ0OnkR8Yd6kizahDxyHUFj9MND4NjxhOlNwPTqdOBCHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102764; c=relaxed/simple;
	bh=8UNaS0FCcz9i9GFv6Kkb8U+3nWyOqZNO1C2UDTbwHGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hanf847dwd8m5WsMFmSDycYZ6LtvVlOUYP49kYfpPPZ9vASvc1ecP77wilq5xhr2+3+9umVy42zJ6a0zLfTj1/PgwiNNyrb+i0s/t5njDKNqX7Ud+OUeKo22dirKkuORlte3dhUGJ8hLWzPDZvX34WUwtM7cA+UKq04SYd4iREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn8loLg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn8loLg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CEE1F00893;
	Sat, 30 May 2026 00:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102762;
	bh=8UivfDfWA1F+si0uv97N7hlBjJ1IwZiOxL1ScCxQiMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nn8loLg0wSmLvc3YtDr9sIOx6o35EdrKpBEsVWja2MYrQzu06HyyJvSMjuW1U3kAJ
	 OXtt+BUWx3czY0UnLSixvZZKaDy5rZqgBUNzrw9wXhr5BTimH623GodYcfzh7BrbY1
	 S3z6OcN+eZG4tQblqP+nIVL4OHNF7FP4QqhUXTwEoQZaP+sIN2+xyHnOe995KlrcN2
	 +u3e1S0RsSkjndvJm+5INRNQzVzG9zd1TPrUY2yHkssYc1USRMNqfCmZV7raFfdeCx
	 6SsmIRxUNwU//yyf4rID3QMWpxchrywgLv0ZnZwkwHZNVtj5dntpGEf1VERCqKwk+K
	 bY7UGgUeiWn6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/5] verifier: parse BTF type tags for
 function arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530002259.4505-3-emil@etsalapatis.com>
References: <20260530002259.4505-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:59:21 +0000
Message-Id: <20260530005922.90CEE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] btf_scan_type_tags incorrectly rejects valid BPF programs containi=
ng unrecognized type tags (e.g., __user, __rcu) by returning -EOPNOTSUPP.
- [High] btf_scan_type_tags fails to discover valid type tags if they are s=
eparated from the pointer by other BTF modifiers (like CONST, VOLATILE, or =
TYPEDEF).
--

commit c938604636d812339744a9ba91c4659c3d79392c
Author: Emil Tsalapatis <emil@etsalapatis.com>

verifier: parse BTF type tags for function arguments

This patch extracts BTF decl tag parsing into a new function and
introduces type tag parsing for function arguments, specifically
looking for the arena type tag on pointers.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 17d4ab0a82068..c6a930aca67ec 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +static int btf_scan_type_tags(struct bpf_verifier_env *env,
> +			      const struct btf *btf, u32 type_id,
> +			      u32 *tags)
> +{
> +	const struct btf_type *t;
> +
> +	/* Find the first pointer type in the chain. */
> +	t =3D btf_type_skip_modifiers(btf, type_id, NULL);
> +	if (!t || !btf_type_is_ptr(t))
> +		return 0;
> +
> +	/* We got a pointer, get all associated type tags. */
> +	t =3D btf_type_by_id(btf, t->type);
> +	while (t && btf_type_is_type_tag(t)) {

[Severity: High]
Does this loop terminate prematurely if the type tag is preceded by other
modifiers like CONST, VOLATILE, or TYPEDEF?

If the target type of the pointer is structured as:
PTR -> CONST -> TYPE_TAG("arena") -> INT

It appears btf_type_is_type_tag(t) would evaluate to false at the CONST
modifier, causing the loop to exit and valid arena tags to be missed
entirely.

> +		const char *tag =3D __btf_name_by_offset(btf, t->name_off);
> +
> +		if (strcmp(tag, "arena") =3D=3D 0) {
> +			*tags |=3D ARG_TAG_ARENA;
> +		} else {
> +			bpf_log(&env->log, "function signature member has unsupported type ta=
g '%s'\n",
> +				tag);
> +			return -EOPNOTSUPP;
> +		}

[Severity: High]
Will this unconditionally reject valid BPF programs that contain
unrecognized type tags like __user or __rcu?

Prior to this change, standard kernel type tags on pointer arguments were
naturally skipped by the verifier. Returning -EOPNOTSUPP here for anything
other than arena seems like it might cause a backward compatibility
regression for existing global subprograms that accept standard tagged
pointers.

> +
> +		t =3D btf_type_by_id(btf, t->type);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530002259.4505=
-1-emil@etsalapatis.com?part=3D2
