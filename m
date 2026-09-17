Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFE275870
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608650; cv=none; b=kgQ6P3Dfz3aP8soTSFpZ+KWhynSBVu759XownDRu8JNsx4d6a1wFD0ZGJ1+LmRQ0q9LnSgFwD1benbQdVfzj1RGGi4LmuCy1X6IP9YJRkv8QyVjledhFgRR86go238do87WGd0394x3oJX8mRXdl+UPnzGJrkyUDgrgInVbbtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608650; c=relaxed/simple;
	bh=X1nSIe7Y4ask8b/QHlPzTo/qSFGzfRKxtZvFMd7Catg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PuQrPqI/URAf11L6gmsG9FbZP9dhVLv/lcyBFljskDB/4KYAnDgJTQ8BHK0sYWXKZo+fDmtcZQjWi3nGThCrGlT/xQgPjUeBpzA/pfGrF8F55s4JR+VQsV7PLhER8wfSYs4laZhw7TDfP4WP+NXqbVqXFE4ilSiUI80e9kehNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR+G09xV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR+G09xV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2263A1F000FF;
	Thu, 17 Sep 2026 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608649;
	bh=rdRQ5Ss1DzOpBRFWSb14oBYh2yEInsreG/p4sSYBZ+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QR+G09xVpMNhcaUvXHuCwdCz26UqYZdJttNyKpVGSuq2lC+KibaP2GtgTXiK0fkrP
	 HSfslP3jV0TUFraQDYxzMR4O2cQXI1bQQn5ugOVCxsB/yJcw/Y9D47y8MlZ4xuOvP7
	 i13tdnr86iHGDIFWDZuyaSQvppETopH+4OSfooAp3hxiVpPhb1cnyWj3FWwb50s8JM
	 +/4cFic0SNusVo+DzY5Mzn8tJNM4mrgojhp/AIY/PBT4G+svbLXM3Me/MAvA4QP8d/
	 9NuAlGmFM+T/DvVE8vsYhfw5X4t9PtUa6tqN0iKHxzO+Q6cl0jHEmo+Qc+66U2rY+D
	 9PKXqt5OTLdAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/4] libbpf: Render decl_tags in btf_dump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917012037.1396254-3-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
 <20260917012037.1396254-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 01:30:48 +0000
Message-Id: <20260917013049.2263A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] libbpf: btf_dump_cmp_decl_tags violates strict weak ordering in =
qsort
- [Medium] libbpf: duplicate tags and memory leak on btf_dump_resize error =
paths
--

commit 869ac84b9144d9ee48198dbc0d57c9510a6f9d98
Author: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: libbpf: Render decl_tags in btf_dump

This commit adds support for rendering BTF_KIND_DECL_TAG in btf_dump.
It builds an array of decl tags sorted by target ID and tag ID, which
are then emitted at every declaration.

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -202,9 +202,15 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
> +static int btf_dump_cmp_decl_tags(const void *a, const void *b)
> +{
> +	const struct decl_tag_desc *x =3D a, *y =3D b;
> +
> +	if (x->target_id !=3D y->target_id)
> +		return x->target_id < y->target_id ? -1 : 1;
> +	return x->tag_id < y->tag_id ? -1 : 1;

[Severity: Medium]
Does this comparator satisfy the strict weak ordering requirement for qsort?

If two elements have the same tag_id, this returns 1 instead of 0. Depending
on the libc implementation, returning 1 when comparing an element to itself
or to a duplicate could break antisymmetry and potentially lead to out of
bounds accesses or infinite loops.

> +}

[ ... ]

> @@ -258,8 +258,18 @@ static int btf_dump_resize(struct btf_dump *d)
>  		err =3D btf_dump_mark_referenced(d, t);
>  		if (err)
>  			return err;

[Severity: Medium]
Do we need to roll back d->decl_tags_cnt or free resources here?

If this loop encounters an error and returns early, it leaves the previously
pushed decl_tags in the array, but d->last_id isn't updated.

If a user handles the error and resumes using the btf_dump object, won't it
re-push those same tags on the next call, causing duplicates and memory lea=
ks?

> +
> +		if (btf_is_decl_tag(t)) {
> +			err =3D btf_dump_push_decl_tag(d, i, t);
> +			if (err)
> +				return err;

[Severity: Medium]
Similarly, does returning early here lead to the same duplicate tag entries
on retry, since d->decl_tags_cnt is not rolled back on error?

> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917012037.1396=
254-1-ihor.solodrai@linux.dev?part=3D2
