Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37B347BDC
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625799; cv=none; b=mWseM75nBVg5THZucrkMlj9w7K2vRdT3rvM7s9QEBn57jp+u08LPQBA/00jCbc6Do2LyZNpT2cSXgisGyVS95K6Njfh/0jWRIzolADqI6BuehX8iRArb4LVnTXDDlMYBDF2+8RQJHh0rxjiuJ1IubeWTUk6RFYbVrZw5CgJQh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625799; c=relaxed/simple;
	bh=GpMNDZk3ZU1Oc0BZcei0O2B53Oh1BX2yanEVZJKIJgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h7SX8LzAtBkBvKq/WF7MluRCS9V7frBU3DxgN8mHDQLJIIuAOfQjpJPGyT4O+jP6jGqtWDKRHqb7Cyx14MKJv/J6wbUNOFXRRy8eEYSoMGCXFlLiTvvt3eXeDowDcLIGUKhHMmweD7B+4Bb8PXOFKygHWhYT91EB78NJFk6piJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmSz33+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmSz33+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3A91F000FF;
	Thu, 17 Sep 2026 06:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625798;
	bh=/rN+uUYee3UYb161DnLt4923EVdnpNnaQqVuk8BbPFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmSz33+mF7EHiWAq0wfrvMhYE5cZ70cOCsAi0iJdZl6g3/rNp3sDkZ3eENtotLNZ+
	 w+8qLApNeI/V3hngJM9QfIvt+HyWVogBFbSSHokhFfMeb4ahjAmIj9RYrYp28mn3LU
	 EaMFfYdP6YuiWpzr8Btx57sfm2Y9c01Rk4aBqwUk3QA4ZeiSoODFtu9JNkqZ2Ok8HV
	 KZqarmLXgcxdV1IBBw4jQxNXmUmHAq2mI6CfcLfOH4bDYih+6YY2MJqT1pOGKL4Gyx
	 qxNh950PGOE8y4r03jAzdbjLwGaDQSnX+n5yMCN6B57+UDwqJklboOSoE1S2KBz/qa
	 4+HZdaKn4vxjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 17/20] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917055812.3934611-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055812.3934611-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:16:37 +0000
Message-Id: <20260917061637.CF3A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] libbpf: unaligned memory access in linker for 32-bit relocations
--

commit 408d36d153c1766697801912b5eb3e8087995ef9
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Let the static linker carry .bpf_cleanup relocations

This commit allows the BPF static linker to process 32-bit relocations
against non-executable sections by handling R_BPF_64_NODYLD32 and
R_BPF_64_ABS32 relocation types. It updates the 32-bit values directly in
the raw data of the relocated section.

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
> +					 * emits NODYLD32 for a .long against a
> +					 * section symbol, GNU as emits ABS32
> +					 * (bpf_reloc_type_lookup() maps
> +					 * BFD_RELOC_32 to it), and the value
> +					 * they describe is the same.
> +					 */
> +					val =3D dst_linked_sec->raw_data + dst_rel->r_offset;
> +					if (linker->swapped_endian)
> +						*val =3D bswap_32(bswap_32(*val) + sec->dst_off);
> +					else
> +						*val +=3D sec->dst_off;

[Severity: Medium]
Can this lead to an unaligned memory access crash?

The static linker processes these 32-bit relocations against non-executable
sections by casting the relocated offset to a 32-bit integer pointer and
directly dereferencing it.

If a user supplies a malformed BPF object file with an unaligned relocation
offset, this could result in undefined behavior and a crash (SIGBUS) on
host architectures with strict alignment requirements.

Should linker_sanity_check_elf_relos() be updated to ensure the relocation
offset is a multiple of 4 for non-executable sections, similar to how it
checks alignment for SHF_EXECINSTR sections?

tools/lib/bpf/linker.c:linker_sanity_check_elf_relos() {
		if (link_sec->shdr->sh_flags & SHF_EXECINSTR) {
			if (relo->r_offset % sizeof(struct bpf_insn) !=3D 0) {
				pr_warn("ELF relo #%d in section #%zu points to missing symbol #%zu in =
%s\n",
					i, sec->sec_idx, sym_idx, obj->filename);
				return -EINVAL;
			}
		}
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917055645.3926=
444-1-yonghong.song@linux.dev?part=3D17
