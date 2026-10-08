Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B23BB671
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447257; cv=none; b=tv6JZX2tjUiYp2hblB6TvgGGmeesgYLKt087RZ2OCI0Z2Uj8PcuQyiWvag8GRWa04IrXWSuNbEf6Eyyjd/qqgASL/q5ltSyI6Y9U7nXYfeQhNYe+IM4z7NhoiZq857MSuweHN3LVEMv3un7wsA9ptd50TocjEAGzcDzrY42X1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447257; c=relaxed/simple;
	bh=ZonP8+hnTohDhvC/ITWdcfQv2uZdLOCR2oD5PXlON/k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=vDPi+WNiQ8+iIODHwEqiqYF64Yi9zYqHJ6R2TfXru2LstS0UzpKHMW6gOwnmXbbr7FSFAjxz8tvvzMse1cKPQYxy4yQs+zDfWvPQc1fWqJWZEebLZiy7ecZMTQdyZku8A6HWaMix6XIsBeiikvExXTj0roUgcmEec5QAVUuCOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2EnjQcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2EnjQcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667621F000FF;
	Thu,  8 Oct 2026 08:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447255;
	bh=18/MQjpHgTPTuJlyGeAyz8olBmJZs1hpNi1ukmFmQn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2EnjQcCI54SMtcbCWue4MdJ/qZYR8GF5rKkmE6fHabqiTHA18JFK2gEXo+UPGEEz
	 vgTp6Q3exlvavpvb/O4uUSoZqvgu8wg5KBsxu2+6/ypJUPxVbxEalc4zTfcWqgeOTP
	 LpVlLRles1g8JFybxqojosNcHqeIBFRKiaZnL7iXHwV2pn/uS7bLYanjW4TClLVl7O
	 Bv6RroWbQspPwrIayuXyGIXAviFguFpxiisoHhs+2/jB89Lvhnc45UH98TFSeGE0f7
	 sX/jNAyatd7rq0+FUo2hPAtLEloNy/+Hm0zpkoXtjrdXvRpmM7sBlpz9wg0enN3tO1
	 7FawUYFa3YVyQ==
Message-ID: <sashiko-outbox-163810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 19/23] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008075136.3008537-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075136.3008537-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:14:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] libbpf: OOB array access in linker_append_elf_relos via malforme=
d ELF symbol
--

commit c7a7a96d1dd021ce6e4bcaa13fd9ec618fb1f8cf
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Let the static linker carry .bpf_cleanup relocations

Each field of a .bpf_cleanup record is a byte offset into a code section: a
32-bit relocation against that section's symbol, with the offset as the
implicit addend. The patch updates the linker to handle R_BPF_64_NODYLD32
and R_BPF_64_ABS32 relocations against non-executable sections.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index f3f71c452f007..c607f51e3cb46 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c

[ ... ]

> @@ -2297,6 +2299,39 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
>  					if (linker->swapped_endian)
>  						off =3D bswap_64(off);
>  					memcpy(ptr, &off, sizeof(off));
> +				} else if ((sym_type =3D=3D R_BPF_64_NODYLD32 ||
> +					    sym_type =3D=3D R_BPF_64_ABS32) &&
> +					   (sec->shdr->sh_flags & SHF_EXECINSTR)) {

[Severity: Medium]
Could this result in an out-of-bounds memory access?

If an ELF file contains a malformed STT_SECTION symbol with an st_shndx
value >=3D SHN_LORESERVE (such as SHN_ABS), it bypasses the bounds check ag=
ainst
obj->sec_cnt in linker_sanity_check_elf_symtab():

    if (sym->st_shndx < SHN_LORESERVE && sym->st_shndx >=3D obj->sec_cnt) {=
 ... }

When processing relocations against this symbol, linker_append_elf_relos()
indexes the obj->secs array using this out-of-bounds st_shndx:

    struct src_sec *sec =3D &obj->secs[src_sym->st_shndx];

The newly added relocation handling branch for R_BPF_64_NODYLD32 and
R_BPF_64_ABS32 then directly dereferences the out-of-bounds sec->shdr and
sec->dst_off pointers. Can this lead to an out-of-bounds read and a
segmentation fault when linking an untrusted ELF file?

> +					/*
> +					 * A byte offset into a code section,
> +					 * stored in place. LLVM spells this
> +					 * relocation NODYLD32 and GNU as
> +					 * spells it ABS32; being bytes, the
> +					 * section's new start goes in as it
> +					 * is, not scaled the way a call's
> +					 * instruction index is above.
> +					 *
> +					 * r_offset is checked only for an
> +					 * executable section, and SHT_NOBITS
> +					 * has no raw_data, so bound it here --
> +					 * subtracting, so it cannot wrap.
> +					 */
> +					if (!dst_linked_sec->raw_data ||
> +					    dst_linked_sec->sec_sz < (int)sizeof(*val) ||
> +					    dst_rel->r_offset % sizeof(*val) ||
> +					    dst_rel->r_offset >
> +					    (size_t)dst_linked_sec->sec_sz - sizeof(*val)) {
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
>  				} else {
>  					pr_warn("relocation against STT_SECTION in non-exec section is not =
supported!\n");
>  					return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008074959.2993=
751-1-yonghong.song@linux.dev?part=3D19
