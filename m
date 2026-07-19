Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69373A4274
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476165; cv=none; b=FAqyJtJcixoWRCi5Y2Yo2OswGcuTn35uxQ0U1eK6nJtGaz6i74wfa3fhwXpbWOAp0plZzlnsKFuwqeyFnGUuapCy+10KZpoMwDaRHFdDB9cJ/AD85VFCVISceasFqRFDWoJgTC0L2A71gh1rPGentvuKxCNWMw2IxKrT5cJM51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476165; c=relaxed/simple;
	bh=Fs14eUuelzY2C4kynuOOnCYXUKD0+Hmcj/fOAzpK8Xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QxfZA1SPuWIrxN+y2V0Dm9egDNN36UygpxpkA840vBH/IN7frY+vQsurT4BwMb6L57gtUwDCSmmS3DUbHT3VjhJ+MeGoMEvp6wBHeQ85v4VRnFxj1o9iInM/HbYaf8KQ99fCgFNdMl4MrjB9sBZEzaznuZ6/Sjb7F+mz8Xf8QRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XebhEvkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XebhEvkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3C31F000E9;
	Sun, 19 Jul 2026 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784476164;
	bh=LLBA1/aoBYhigciH2CtmpXnW4c18Unze0i5dWIgV3WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XebhEvkqJd/SnpQfJMcjXztknqgWMnCpEHT+Gow8imPRPRYm5VAW3jjjkONaSbJh7
	 Pw9em+qzMRx8z8N8USqJMZvJzsYfxOBtdwJbJ7fzGp6jqTmiB2ft9i6XqeUO7+Akk+
	 ZuV+s/heTzWn+5X55QE1ezKCBUYbf4P/Ei8PgfnCam9gswo8hE3BdNI+YbN15BByN8
	 bjWJke9FNGbsD3a8Py08qeKwZOGRydBO8FyaHXdTmAgJnErHoPBzJbFJb2EtrV13R4
	 UfjzvJuaq98Qu9uM2pdhOl8FvMSYAQXTfV9PgZcVqn+Ghboz1UYSsaU2jFWr1EE7WV
	 7IeEFR0ify8sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Preserve unique-field state across
 nested structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719153634.2908692-3-memxor@gmail.com>
References: <20260719153634.2908692-1-memxor@gmail.com>
 <20260719153634.2908692-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 15:49:23 +0000
Message-Id: <20260719154924.5C3C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiple BPF_REFCOUNT fields in a BTF struct bypass the seen_mask =
uniqueness check because is_unique =3D false, allowing them to trigger a re=
achable WARN_ON_ONCE() in btf_parse_fields().
--

--- Patch [2]: [PATCH bpf-next v2 2/5] bpf: Preserve unique-field state acr=
oss nested structs ---
commit f8de1a7879c048283531a81778eac42891723a9d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Preserve unique-field state across nested structs

btf_find_struct_field() initializes a fresh seen mask for every recursive
descent. This commit passes a shared seen mask pointer through the entire
field traversal to ensure unique special fields in different levels of the
same aggregate properly see one another.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e7d4e9ba24e26..c577f00e9d885 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -3947,10 +3947,12 @@ static int btf_find_field(const struct btf *btf, =
const struct btf_type *t,
>  			  u32 field_mask, struct btf_field_info *info,
>  			  int info_cnt)
>  {
> +	u32 seen_mask =3D 0;
> +
>  	if (__btf_type_is_struct(t))
> -		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0);
> +		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0, &s=
een_mask);

[Severity: High]
This is a pre-existing issue, but since this patch improves the uniqueness
tracking via seen_mask, should BPF_REFCOUNT also be treated as a unique fie=
ld?

In btf_get_field_type(), BPF_REFCOUNT is currently defined with
is_unique =3D false:

    { BPF_REFCOUNT, "bpf_refcount", false },

Because it bypasses the uniqueness validation, a user could load a BTF stru=
ct
containing multiple bpf_refcount fields. If this happens, does it eventually
reach btf_parse_fields() and intentionally trigger the WARN_ON_ONCE there?

    case BPF_REFCOUNT:
        WARN_ON_ONCE(rec->refcount_off >=3D 0);
        /* Cache offset for faster lookup at runtime */
        rec->refcount_off =3D rec->fields[i].offset;
        break;

Could a crafted user BTF cause a kernel panic here if panic_on_warn is
enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719153634.2908=
692-1-memxor@gmail.com?part=3D2
