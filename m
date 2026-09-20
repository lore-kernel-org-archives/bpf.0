Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF5282F26
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789884027; cv=none; b=V3sqS5wFaCvrC+2W7JNZPa/XcrCpTN3HA6Qwimrb/TMZ0h49ktFfhEwnMibv/4D+44T7QK1qtFgauAsf6jL7HIKsXX0Iu/GaR5dbn2oH5PwZQQmj1Pl1x9YTu+o3No29SUkV0gRdJ0RLys+DKHCjPnDALN2N6w+W+GVEVKhnIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789884027; c=relaxed/simple;
	bh=LWQAhvdwNCeZeKmArNgW++YcZlobSZbfK+Tic9Yy/Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YA2fIyWUFEK5lpSoLwhNDiUdJOFL2FMX/ds0fGaTwbqhUDdPQEUJQUCWhx+kmtI/fysjOMv2WQV/5njRYNuQAg6bdbMIhZ6I3vP5CPyPqUjydHCubjphqZjr428akHHE5mKqYFJ0Gsvq++ra7P5HuUrtbkMWR1G2GJvGfCtyTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpX+pZoY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpX+pZoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6349C1F000FF;
	Sun, 20 Sep 2026 06:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789884026;
	bh=SucpYcMUpzyBqdJIlRy1ziUID0qocl8VNuXILR05zsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SpX+pZoYUh++DS9BG0ZCNKJPFAlwXAxLpj/koGRexNEup8RT7QKN+gXHRA414IUFT
	 pYBEsfZQBs5Vn/nVsRC8Ati24cb5wHSNQF91nV45sUJWtwSLRpGOQi8IOQ79X4eUTd
	 n2nsR9x/98m9ux2SrGUSPGy56fqLeEKfFSY21zHxlhcV7nyiX/F6TvdVM1qcJ3a/5w
	 ImSIL0TFT8GVzFD+j1DT5mD0dsl8Rxp5Wd8nh7zLo1WerPQZ6pfL8koHHsSgvD5inr
	 KS/PFJf1Wde0OVATzrCGlBeQRczXRNbi1ZmEtRsMF4VLftRRLTf/gimdIsveWeIdWt
	 BDM6SumuIi+rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 17/20] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920054353.872669-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054353.872669-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:00:25 +0000
Message-Id: <20260920060026.6349C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] libbpf: integer overflow in relocation bounds check allows out-of-=
bounds heap access
- [Low] libbpf: incompatible pointer cast to __u32 * violates strict aliasi=
ng
- [Low] bpf: newly added multi-line comments violate the BPF kernel comment=
 style
--

commit c31e91765bc81fed1c51952c88d0792cd3b4c2bd
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Let the static linker carry .bpf_cleanup relocations

This commit updates the static linker to accept and properly handle
R_BPF_64_NODYLD32 and R_BPF_64_ABS32 relocations against STT_SECTION
symbols in non-executable sections. This enables linking of objects
that contain compiler-emitted exception cleanup tables.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290af..fac7390bd109d 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c

[ ... ]

> @@ -2274,6 +2275,39 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
>  						insn->imm +=3D sec->dst_off / sizeof(struct bpf_insn);
>  					else
>  						insn->imm +=3D sec->dst_off;
> +				} else if (sym_type =3D=3D R_BPF_64_NODYLD32 ||
> +					   sym_type =3D=3D R_BPF_64_ABS32) {
> +					__u32 *val;
> +
> +					/* Two spellings of the one thing: LLVM
> +					 * emits NODYLD32 for a .long against a

[Severity: Low]
Does this multi-line comment format violate the BPF subsystem guidelines? T=
he
BPF guidelines specify that multi-line comments must have the opening /* on
its own line, with the text starting on the next line.

> +					 * section symbol, GNU as emits ABS32
> +					 * (bpf_reloc_type_lookup() maps
> +					 * BFD_RELOC_32 to it), and the value
> +					 * they describe is the same.
> +					 */
> +
> +					/* An SHT_NOBITS section has no
> +					 * raw_data, and r_offset is sanity

[Severity: Low]
This isn't a functional issue, but this comment also places text on the same
line as the opening /*.

> +					 * checked only for sections holding
> +					 * instructions. Check both here
> +					 * before writing.
> +					 */
> +					if (!dst_linked_sec->raw_data ||
> +					    dst_rel->r_offset % sizeof(*val) ||
> +					    dst_rel->r_offset + sizeof(*val) >
> +					    (size_t)dst_linked_sec->sec_sz) {

[Severity: High]
Can this bounds check bypass validation due to an integer overflow?

If a malicious BPF ELF object provides an oversized r_offset (for example,
0xFFFFFFFFFFFFFFFC), adding sizeof(*val) could wrap around to 0. This bypas=
ses
the check against dst_linked_sec->sec_sz and allows out-of-bounds heap memo=
ry
access.

> +						pr_warn("ELF relo #%d in section #%zu points outside the data of s=
ection '%s' in %s\n",
> +							j, src_sec->sec_idx,
> +							dst_linked_sec->sec_name,
> +							obj->filename);
> +						return -EINVAL;
> +					}
> +					val =3D dst_linked_sec->raw_data + dst_rel->r_offset;
> +					if (linker->swapped_endian)
> +						*val =3D bswap_32(bswap_32(*val) + sec->dst_off);
> +					else
> +						*val +=3D sec->dst_off;

[Severity: Low]
Does casting the raw byte buffer to a __u32 pointer violate strict aliasing
rules?

The tools/ build assumes strict aliasing, and accessing generic byte buffers
this way can lead to compiler misoptimization. Would it be safer to use mem=
cpy
or unaligned access macros here?

>  				} else {
>  					pr_warn("relocation against STT_SECTION in non-exec section is not =
supported!\n");
>  					return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920054225.8645=
35-1-yonghong.song@linux.dev?part=3D17
