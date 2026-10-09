Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45B4E1C61;
	Fri,  9 Oct 2026 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547317; cv=none; b=LM/0DzwF6XKXiMX/omMRE7ANLnfpIwPdmNbYJIW2WM1gR9uFmwEO0NB7R1QQMCrNJXuimLJNiuanYRrMf8/e9FdcteR7IK8GraE6BKh2H4n1Uqe+8IbEby2jN07/Biaxi5YCcCaeg0fZQ3tRnqh6GvZiNy8RgpfUenX4mzXLMb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547317; c=relaxed/simple;
	bh=kWMME6oo51ZWLhEEuLGEHk+ALABso4VacarviwVxuqY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VNS3jl7H5QWiQ7c4ArOGchbwyaCr0VsTvvZnhtlOY1ZOCnnKXePVdOPsglVI0om+pXcZFbfr0uvrHGBiZYgcufhg8fgDZAKMNTvOBmoO4CyAg7DgX5d2hoq1V2I1JTeWKWXIq0PyOZ2VisVo0HZ6AehRWhB9KRsQwsZ6Rybkduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j09YlFAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j09YlFAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395991F000FF;
	Fri,  9 Oct 2026 12:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547308;
	bh=msJ9U2+D0K9Sksl3SMcYGQxyJraA87PnSs7nZTVG3YY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j09YlFAxrRT0GGDlIiQ7eYkU5IFm+0Xq5WR2oOu+w6GDIpIuI3ULE9S5ahQER7Ww6
	 PpzVOlUAX5fSqWKA/6AIuStDY0oJaGQFGAH6JbtJy1K2V2Mk2rDgvQwrnftUZv11Ij
	 08Nf/eWVFlEu8nMSUjdFuPDapWXGoye0OB9a5HvjP1yLd9iQfMagyBO8wfRhC8xGeS
	 E3vku2a4PDULBWCq/vMmxSSSDEnCb95JQqA4Vzy5Of87pMZyNnhw/kS9duvCYxcPEo
	 fsiXhtWXPGy2JityHWMCbSmjHAN88gD1BXVes8ZSD+MNDf5O2zTtRuvBWU0Yf59GEn
	 6k1dcnxSX+nlg==
Message-ID: <sashiko-outbox-165464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 4/7] btf: Preserve string relocation maps
 for split BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261009112324.1442319-5-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
 <20261009112324.1442319-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:01:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] btf: memory corruption and invalid string offsets with split base =
BTF
- [High] bpf: heap buffer overflow in btf_relocate_map_distilled_base() on =
split BTF
- [Medium] libbpf: NULL pointer dereference in btf_relocate() when btf has =
no base
- [Low] bpf: btf_relocate_rewrite_strs prints empty string in warning
--

commit 5e8ac630aea03f4aa4b3a237792c60ad3c7a0956
Author: Alan Maguire <alan.maguire@oracle.com>

btf: Preserve string relocation maps for split BTF

Make btf_relocate() optionally return the string-offset map it builds
while relocating a BTF relative to a distilled base. A subsequent split
BTF object can use that map to rebase references to base strings.

Also account for the accumulated base string offset when assigning a
new BTF base. This is required when the base is itself split.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 592b71a838410..22dd123450c3e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1936,7 +1936,7 @@ void btf_set_base_btf(struct btf *btf, const struct=
 btf *base_btf)
>  {
>  	btf->base_btf =3D (struct btf *)base_btf;
>  	btf->start_id =3D btf_nr_types(base_btf);
> -	btf->start_str_off =3D base_btf->hdr.str_len;
> +	btf->start_str_off =3D base_btf->start_str_off + base_btf->hdr.str_len;
>  }

[Severity: High]
Since this allows using a split BTF as the base, will it cause out-of-bounds
heap writes in tools/lib/bpf/btf_relocate.c:btf_relocate_map_distilled_base=
()?

When relocating against a split base BTF, the function allocates an array
using only the local string section length of the target base BTF:

	base_name_cnt =3D calloc(r->base_str_len, sizeof(*base_name_cnt));

It then iterates over all types in the BTF hierarchy, indexing into this
array using the absolute name_off of inherited types:

	if (base_name_cnt[base_t->name_off] < 255)
		base_name_cnt[base_t->name_off]++;

Because the absolute name_off can span up to the total accumulated string
length (up to millions of bytes for vmlinux), this index can far exceed
the local string length and corrupt the heap.

Additionally, in btf_relocate_rewrite_strs(), local string offsets are
incremented using only the local string section length:

	*str_off +=3D r->base_str_len - r->dist_str_len;

Does this need to account for base_btf->start_str_off as well, to prevent
the rewritten offsets from incorrectly pointing into the base BTF's bounds?

[ ... ]

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 512b3962f75f8..d2ff6f5d6d5b6 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -6640,7 +6640,7 @@ void btf_set_base_btf(struct btf *btf, const struct=
 btf *base_btf)
> =20
>  int btf__relocate(struct btf *btf, const struct btf *base_btf)
>  {
> -	int err =3D btf_relocate(btf, base_btf, NULL);
> +	int err =3D btf_relocate(btf, base_btf, NULL, NULL);

[Severity: Medium]
If a user calls btf__relocate() with a root BTF (which has no base BTF),
will this cause a NULL pointer dereference?

Inside btf_relocate(), r.dist_base_btf is populated using btf__base_btf(btf=
),
which returns NULL for a root BTF. However, the function proceeds to
dereference it without checking:

	r.str_map =3D calloc(btf_header(r.dist_base_btf)->str_len,
			   sizeof(*r.str_map));

Since btf_header(NULL) returns a near-NULL pointer, accessing str_len will
trigger a page fault and crash the caller.

[ ... ]

> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index df5fa4bd87d69..e55dd75f6c950 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -441,7 +441,8 @@ static int btf_relocate_rewrite_strs(struct btf_reloc=
ate *r, __u32 i)
>  /* If successful, output of relocation is updated BTF with base BTF poin=
ting
>   * at base_btf, and type ids, strings adjusted accordingly.
>   */
> -int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id=
_map)
> +int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id=
_map,
> +		 __u32 **str_map)
>  {

[Severity: Low]
When strings fail to map in btf_relocate_rewrite_strs() during relocation,
does the warning message print an empty string instead of the actual unmapp=
ed
string?

	off =3D r->str_map[*str_off];
	if (!off) {
		pr_warn("string '%s' [offset %u] is not mapped to base BTF\n",
			btf__str_by_offset(r->btf, off), *str_off);

Since off is guaranteed to be 0 here, and offset 0 in BTF always corresponds
to the empty string, the warning will always print "string '' [offset X]".

Should this use *str_off to retrieve and print the correct unmapped string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112324.1442=
319-1-alan.maguire@oracle.com?part=3D4
