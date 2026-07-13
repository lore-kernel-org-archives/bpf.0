Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675742A7BC
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949753; cv=none; b=S+H9edZJynFrxbXf/gWnaMG178PeCdRpAPTaFxZzf2EMitPV//vIZRxGxHBWoYxeWMhZlycDWVCWujRTpUYUYSRCnB+tEEPO0SKOeunYiEXrE16jBFuc/78P52TN+VcPvAIiGOAb3AC3mcpLs2c9WujvftvYFL8JHPRbZ3M5yXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949753; c=relaxed/simple;
	bh=R+AkNxKKgWcb3aoPQz7bxZ2YXMJ1hV66OOAf1FBAOsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1t6MTShJu9ENO6HW0oJL4/FyP5qX3IoNXSrgbfrHXl2ZVVNV0IAvLhl856cIA4wbO70QCYeDh4uAmaX9kJC4+3dIW4Ixo2iavhcGoNEXl9pTm15eZk56qXFEiCRzKofM0Bv9kKUjQm8b7dHC4c76pw2gVU41LeDkzXgXsVCNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7HyVe8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7HyVe8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F191F000E9;
	Mon, 13 Jul 2026 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949751;
	bh=Qr3QU4L1Te809HuGU7oXNuelthlUg1Edkk7zPqbA5wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y7HyVe8Vr+P2+dguDNon0HIosiQfbNzrI7sPM1iJhM6ULPhI4LjZ9Y/EFT53Xq4K3
	 dk8uhfjVSQWwFpFvSAs3FV3dN0Taug2NsPiyJO9myiKGVZkOpyPz7GNZnGIph/dIRt
	 yh0iZVN8+osgWnkcW2DxVrjXGLd5gxe60qOGOnjguuiwue9ag4GSTLQ89FtKDWv6ro
	 kdUhPXZ3M2E69yghDCY90mhkXZdcIfzKovESgHg2TMRgv6Mce1l4b/ualVFqVYqDdE
	 ZWNE71ADY+80r3q/h+pxycdikcIiY2LDpjbVNWCbidciiX0zeEcrnsIFsFV01E2Tlv
	 O5WEyUeoQ2vxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: reject linker STT_SECTION symbols with
 out-of-range st_shndx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <178394859382.2.942623981274846749@digiscrypt.com>
References: <178394859382.2.942623981274846749@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:35:51 +0000
Message-Id: <20260713133551.61F191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on relocation `r_offset` allows arbitrary=
 out-of-bounds heap read/write during ELF linking.
- [High] A NULL pointer dereference occurs in `linker_append_elf_sym` when =
resolving global symbols with reserved section indices (e.g., `SHN_ABS`).
- [High] Integer overflow in `sym_idx` bounds check on 32-bit systems allow=
s massive out-of-bounds heap read and information leak.
--

--- Patch [1]: [PATCH] libbpf: reject linker STT_SECTION symbols with out-o=
f-range st_shndx ---
commit a15a7b75755bef67d993d3117ac49d59af2c299e
Author: Naveed Khan <naveed@digiscrypt.com>

libbpf: reject linker STT_SECTION symbols with out-of-range st_shndx

This patch adds a bounds check in linker_sanity_check_elf_symtab() to
ensure that STT_SECTION symbols do not have an out-of-range st_shndx.
This prevents out-of-bounds reads when processing relocations against
such symbols.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290af..8a93faa41d903 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -973,7 +973,7 @@ static int linker_sanity_check_elf_symtab(struct src_=
obj *obj, struct src_sec *s
>  			return -EINVAL;
>  		}
>  		if (sym_type =3D=3D STT_SECTION) {
> -			if (sym->st_value !=3D 0)
> +			if (sym->st_value !=3D 0 || sym->st_shndx >=3D obj->sec_cnt)
>  				return -EINVAL;
>  			continue;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but can we experience a NULL
pointer dereference in linker_append_elf_sym() when resolving global symbols
with reserved section indices like SHN_ABS?

When resolving a global symbol, we update the destination symbol:

tools/lib/bpf/linker.c:linker_append_elf_sym() {
    ...
		dst_sym->st_shndx =3D dst_sec->sec_idx;
		dst_sym->st_value =3D src_sec->dst_off + sym->st_value;
		dst_sym->st_size =3D sym->st_size;
    ...
}

If the symbol uses a reserved section index, could src_sec and dst_sec be
NULL, causing a crash here?


[Severity: Critical]
This is a pre-existing issue, but does linker_sanity_check_elf_relos() miss=
 a
bounds check on the relocation offset against the section size?

tools/lib/bpf/linker.c:linker_sanity_check_elf_relos() {
    ...
		if (link_sec->shdr->sh_flags & SHF_EXECINSTR) {
			if (relo->r_offset % sizeof(struct bpf_insn) !=3D 0) {
    ...
}

Without validating r_offset against the section size, when
linker_append_elf_relos() processes relocations, could it lead to an
out-of-bounds heap read and write?

tools/lib/bpf/linker.c:linker_append_elf_relos() {
    ...
					insn =3D dst_linked_sec->raw_data + dst_rel->r_offset;
					if (insn->code =3D=3D (BPF_JMP | BPF_CALL))
						insn->imm +=3D sec->dst_off / sizeof(struct bpf_insn);
					else
						insn->imm +=3D sec->dst_off;
    ...
}


[Severity: High]
This is a pre-existing issue, but can the symbol index bounds check overflow
on 32-bit systems?

tools/lib/bpf/linker.c:linker_sanity_check_elf_relos() {
    ...
		if (!sym_idx || sym_idx * sizeof(Elf64_Sym) >=3D sym_sec->shdr->sh_size) {
    ...
}

If sym_idx is maliciously crafted (e.g., 0xaaaaaaab), could the multiplicat=
ion
wrap around and bypass the check?

Later in linker_append_elf_relos(), the unchecked index is used to access
the symbol map:

tools/lib/bpf/linker.c:linker_append_elf_relos() {
    ...
			dst_sym_idx =3D obj->sym_map[src_sym_idx];
    ...
}

Could this lead to an out-of-bounds heap read being leaked into the relocat=
ed
output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178394859382.2.9426=
23981274846749@digiscrypt.com?part=3D1
