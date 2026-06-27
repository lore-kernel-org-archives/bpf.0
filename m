Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F7194AE6
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782572641; cv=none; b=lB/PIkaduKD8Aq98DCMwVxNzhDbunsHMIUohU6Bqq4o2D5ZTMpl8au97hMsQGSzPeN4STcdAiT1O2z2Sy99Fzc66dSY2qou2oWGofqASmHQVAK3gbwoLHCRA/vC/C7SLAF3DBD5Rzzcxg18IiRipWeQD8UFWSpH9G0qd7UzXYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782572641; c=relaxed/simple;
	bh=lmu9CJHNiPt+Ruzai4mrh9pRF2OpojDn7lcvS4148Xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHfT8z1hfHVCmBjw/EWCpErsnvKOrZWe+dy6ZjQgq0C15577c87yWP8jVDiV6xYOtHSmtIjPQyyM5Z9QTYTlH/6Ah8SNCxHNhzXdemtfoAJWELHmBVFqQkdon/K/auFAq3Lf6w2E1kebmqe6h0aLfyIXqyNY0f3B6Ddv/9PwrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyhnVxJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyhnVxJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948E1F000E9;
	Sat, 27 Jun 2026 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782572638;
	bh=lnzXHyc+jG3tLr2lf5VGe0BjSm78ms3mWLZOT4OfJrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fyhnVxJcPJwd6fLTws/Sf4JFButGoXdxXSst7uPkCMC49whb1fQ/cTK1TqeLMbXI1
	 FSyrlO9N/Yiiev36FIT+1Gz7YPSKsRvGQAVK/Xf7f22+ouvZhhES64HJPdifL6cRyl
	 +3NfrxqAj0c6oYrTq/1DpjGXS2biBbOmZHt6lIndXNOWk4y59l19x3fBuzD6e1PFMk
	 vIqMxaUSESAl1h6PAk6iIlWbX+fhYiJahCjbeC5pNKWlIzf0nEBUsNqLor1C4KusXg
	 8zbQ2Le8Lr7nRCsLicB+7kIHdO5gm1rwmca3U3vuYVWCwEXtWUkqdhdQJ29xW/EA/Z
	 +wjYAyAOZ5HPw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 03/12] libbpf: Add bpf_sdt_notes section
 parser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <5834001015dba4c202cbd141c4c8723e4983b196.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <5834001015dba4c202cbd141c4c8723e4983b196.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:03:57 +0000
Message-Id: <20260627150358.2948E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Integer overflow in `sdt_calc_nargs` bypasses bounds checks, leadi=
ng to an out-of-bounds memory read when parsing SDT notes.
- [High] Missing bounds check on the ELF relocation symbol index leads to a=
n out-of-bounds read in the symbol table.
- [Medium] Memory leak when parsing multiple `.bpf_sdt_notes` ELF sections.
--

commit f001c05c32f475aab765178535ef62a015937785
Author: Xu Kuohai <xukuohai@huawei.com>

libbpf: Add bpf_sdt_notes section parser

This commit parses the bpf_sdt_notes section to get the probe call site
index in the bpf prog, and argument registers for each probe.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7162146280a80..327c9d412fe89 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3892,6 +3909,254 @@ static int cmp_progs(const void *_a, const void *=
_b)
> +static int sdt_calc_nargs(struct sdt_sym *syms, int sym_idx, size_t sym_=
cnt, size_t last_off)
> +{
> +	size_t off =3D syms[sym_idx].off;
> +	size_t next_off =3D (sym_idx + 1 < sym_cnt) ? syms[sym_idx + 1].off : l=
ast_off;
> +
> +	if (next_off > last_off)
> +		return -EINVAL;
> +
> +	if (off + 8 > next_off)

[Severity: High]
Does this code allow an integer overflow if off is close to UINT64_MAX?

If off (which comes from the ELF symbol's st_value) is large enough
(e.g., UINT64_MAX - 7), off + 8 will wrap around to a small value,
bypassing this bounds check. This can later result in an out-of-bounds
memory read when memcpy() is called with data + off in
bpf_object__collect_sdt_notes().

> +		return -EINVAL;
> +
> +	if ((next_off - off - 8) % sizeof(struct bpf_insn))
> +		return -EINVAL;

[ ... ]

> +static int sdt_find_sec_idx(struct bpf_object *obj, Elf_Data *sdt_relo,
> +			    size_t sdt_entry_off)
> +{
> +	int i;
> +	Elf64_Sym *tgt;
> +	Elf64_Rel *rel =3D sdt_relo->d_buf;
> +	Elf64_Sym *elf_syms =3D obj->efile.symbols->d_buf;
> +
> +	for (i =3D 0; i < sdt_relo->d_size / sizeof(Elf64_Rel); i++, rel++) {
> +		if (rel->r_offset !=3D sdt_entry_off)
> +			continue;
> +		if (ELF64_R_TYPE(rel->r_info) !=3D R_BPF_64_ABS64)
> +			continue;
> +
> +		tgt =3D &elf_syms[ELF64_R_SYM(rel->r_info)];

[Severity: High]
Could this array access go out of bounds?

ELF64_R_SYM(rel->r_info) extracts the symbol index directly from the ELF
relocation entry, but there doesn't appear to be a check to ensure this
index is less than the total number of symbols in the table. A maliciously
crafted ELF could provide a large index and trigger an out-of-bounds memory
read.

> +		return tgt->st_shndx;
> +	}
> +
> +	return -1;
> +}

[ ... ]

> @@ -4034,6 +4299,13 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>  				memcpy(obj->jumptables_data, data->d_buf, data->d_size);
>  				obj->jumptables_data_sz =3D data->d_size;
>  				obj->efile.jumptables_data_shndx =3D idx;
> +			} else if (strcmp(name, SDT_NOTES_SEC) =3D=3D 0) {
> +				obj->sdt_notes_data =3D malloc(data->d_size);

[Severity: Medium]
Can this code leak memory if there are multiple ELF sections named
".bpf_sdt_notes"?

If a malformed ELF file contains multiple sections with the name
SDT_NOTES_SEC, malloc() will unconditionally allocate memory and overwrite
obj->sdt_notes_data, leaking the previously allocated buffer.

> +				if (!obj->sdt_notes_data)
> +					return -ENOMEM;
> +				memcpy(obj->sdt_notes_data, data->d_buf, data->d_size);
> +				obj->sdt_notes_data_sz =3D data->d_size;
> +				obj->efile.sdt_notes_shndx =3D idx;
>  			} else {
>  				pr_info("elf: skipping unrecognized data section(%d) %s\n",
>  					idx, name);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D3
