Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC823E334
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707697; cv=none; b=lbwj+yN0gZOmW/9KI+mz5tSGUV37x0bwzWIQb/Z+HhdYHaHPf49qP+Bg6W0uwsSKGZQRJUX/MDdb3hncQXXy+vaDzp9VXX2cfq58oTRC9n7evHDJZvIcAYoveGnUqWbPwwvhaMvo4ZiGLUDacwUxjYWJ3qtF/QUt0IYs9YldD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707697; c=relaxed/simple;
	bh=0IreOCXH8zyryysOISFmjQSOLuztBZADNJnagNVPLcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9hjWUHmP+dmhD0/do2pS48KeGBdFD7opSre6eTfVxTcTeP/ld7fRI6zcH/+b2+zTtdWNTEkp3ca4RzD/rPOOPW67wm3l/UCLBoj9picf2XfGWoa/iohfLoa9mwe1+ZSD0vgPdP6R3wK33Q/maX9Gwu2oZjqBeGNnyWjLFy01fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZYIMT/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZYIMT/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6DA1F000FF;
	Fri, 18 Sep 2026 05:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707696;
	bh=MuQJEO9vd+1NoYWAMfgTNp5B3mfxLUyPdIcg/O0QH2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZYIMT/aFdRoFqUkW18SsWZzYfNpzq9Wgt9tFfaiCCa3htQXCzCZLbfT2ds5itdcy
	 Y8FQ8wW6CiyBvtVWOWTrh5dmxwFhjH4G6+PNW9odXXlGTdRcD9j6Gjrl97/eo3FeS7
	 G8IQ7ur02xbCL/D6s3kqHkkkDMnh/F9K7bHKMB+SoonwBbUJdVkjNjV9v3lU1fcCTB
	 qbN9RPP6wob2mNZkAGRFXtG+sKNECetD/q+Bgy1y63QVT1WsL5nExNXl0csPH8f3Pj
	 BOpQF2YWOVam0+Rjcezl2WPDaJ545z6QVG9DTCu2buxqepwFgNJ3wlrHqlBfdXb1Iy
	 0znbyuTXjpuAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 17/20] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044327.3292986-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044327.3292986-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:01:35 +0000
Message-Id: <20260918050136.2A6DA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf/linker: NULL pointer deref in linker_append_elf_relos()
- [Medium] bpf/linker: unaligned memory access in data relocations
- [Low] bpf/linker: multi-line comment style violation
--

commit 2eadf13e135621b2e34d8946fe67664cd72e0e3d
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Let the static linker carry .bpf_cleanup relocations

This commit updates the BPF static linker to support .bpf_cleanup relocatio=
ns.
It specifically adds handling for R_BPF_64_NODYLD32 and R_BPF_64_ABS32 to
process compiler-emitted exception cleanup tables.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290af..e5c06023cb5b1 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c

[ ... ]

> @@ -2274,6 +2275,22 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
>  						insn->imm +=3D sec->dst_off / sizeof(struct bpf_insn);
>  					else
>  						insn->imm +=3D sec->dst_off;
> +				} else if (sym_type =3D=3D R_BPF_64_NODYLD32 ||
> +					   sym_type =3D=3D R_BPF_64_ABS32) {
> +					__u32 *val;
> +
> +					/* Two spellings of the one thing: LLVM

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem multi-line comment
style? The preferred kernel style is to have the opening /* on its own line
rather than putting text on the same line as the marker.

> +					 * emits NODYLD32 for a .long against a
> +					 * section symbol, GNU as emits ABS32
> +					 * (bpf_reloc_type_lookup() maps
> +					 * BFD_RELOC_32 to it), and the value
> +					 * they describe is the same.
> +					 */
> +					val =3D dst_linked_sec->raw_data + dst_rel->r_offset;

[Severity: High]
Could this lead to a NULL pointer dereference? Looking at
linker_sanity_check_elf_relos(), SHT_NOBITS sections are explicitly allowed
as relocatable sections.

For SHT_NOBITS sections (like .bss), extend_sec() typically skips allocating
raw_data, leaving it as NULL. If we process a relocation against such a
section here, we might compute val =3D NULL + dst_rel->r_offset and then
dereference it on the next line when handling sec->dst_off.

[Severity: Medium]
Is it also possible to hit an unaligned memory access here?

While executable sections enforce alignment checks in
linker_sanity_check_elf_relos(), there doesn't seem to be an equivalent
alignment check for data section offsets. If an ELF provides an unaligned
r_offset, the direct dereference of the unaligned val pointer might
cause a crash on architectures with strict memory alignment requirements.

> +					if (linker->swapped_endian)
> +						*val =3D bswap_32(bswap_32(*val) + sec->dst_off);
> +					else
> +						*val +=3D sec->dst_off;
>  				} else {
>  					pr_warn("relocation against STT_SECTION in non-exec section is not =
supported!\n");
>  					return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D17
