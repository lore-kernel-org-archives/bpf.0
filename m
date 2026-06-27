Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959D930BBB8
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579959; cv=none; b=ccteH9MRcofQBJW/F/BSGbquff9U2P9cY4GpG81pPNVdUyaDCobO8Rl7BFOIxYCyTSAnsutAhqaxrHhf3vzUMl0LxLQ3Ooer3VmLmPeItf+mqeYLP56SZCxJTPNDSZWan8G0KipPPtKMB+IW5IjilTMrvu0GZkgPRIshx0q5mH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579959; c=relaxed/simple;
	bh=KLV/eUTqGwx5pHJSdQ7mjWnmV2ADvmyc5YJrlo4FDek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rup2/G4/iUzSPbZlCRudz28eiTDV6CVyzJuyi0gueqdfys8Z0opBdV6bosg4EQW9PasFF03rSDXWBKJt5symAbB2Ju5Spo7YGne8+xj4U1JXKQyj3kKHJTrtAr1tuQskyHqEZp8Nacs379s9Kpd2cCjwmd6YHrciTy7toUVtbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM61JX7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM61JX7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E381F000E9;
	Sat, 27 Jun 2026 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579957;
	bh=sbhTeX51IRUBMFNt8VpeJqw8dWIBt5y/SGrx0f5lJLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JM61JX7l0z1zFCqb1T+uAguOswC3PcWYapCtpQColeWC+amM/FuqRGwRrX6kE9+F0
	 PsA9fcSd2eLYD+wa24tEV82HvY82qh6QIxZKlfP+fzmtrRNHTqZt3aw2xQNtO+bUht
	 3PQhwFeL57leONveh/ZKey+TwTG7+ahWFkBIWESxNThVrUUoV8QAWXQ/gpjB4q+eaB
	 BbvGn4m6Q3HQBwx15/oEFKc6DxQZt11hQkRv0F81KYtfSpv2u0sjinNwDjnm5Jdgei
	 +pRIk468j6yzd5mSNxewCi2/OQTiEGVB26Diywh8hbg3ul6yjTxrIKnQMze663UycC
	 e13m9WtyRcPeg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 01/12] libbpf: Prepare bpf SDT probe
 section for the linker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <addc1860d60c2eee409f187805b6cfbc5382e82a.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <addc1860d60c2eee409f187805b6cfbc5382e82a.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 17:05:56 +0000
Message-Id: <20260627170557.03E381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Cross-endian linking corrupts target-endian addresses in `.bpf_sdt=
_notes`.
- [High] Unaligned memory access via direct pointer cast of `.bpf_sdt_notes=
` relocations causes undefined behavior.
- [Medium] Blind assumption of 64-bit relocation type for `.bpf_sdt_notes` =
can cause memory corruption.
- [Medium] Redundant symbol validation bypass allows malicious global symbo=
ls in `.bpf_sdt_notes`.

Pre-existing issues:
- [High] Missing bounds check for ELF relocation offsets allows out-of-boun=
ds heap memory access.
--

commit c10bd6264b90c8115e40b5bcf69e608dd418c585
Author: Xu Kuohai <xukuohai@huawei.com>

libbpf: Prepare bpf SDT probe section for the linker

This patch prepares the BPF linker to handle the .bpf_sdt_notes section,
treating it similarly to jumptables. It bypasses section-type checks for
SDT symbols and relocates 64-bit absolute addresses inside each entry.

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 04cd303fb5a87..ed7a587a61ca4 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
[ ... ]
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290af..3a72276244c72 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -2028,6 +2028,8 @@ static int linker_append_elf_sym(struct bpf_linker =
*linker, struct src_obj *obj,
> =20
>  		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) =3D=3D 0)
>  			goto add_sym;
> +		if (strcmp(src_sec->sec_name, SDT_NOTES_SEC) =3D=3D 0)
> +			goto add_sym;

[Severity: Medium]
Could this bypass of global symbol resolution cause issues? If a symbol in
the SDT notes section has STB_GLOBAL binding, it will hit this branch and
skip the deduplication and resolution logic entirely.=20

For STB_LOCAL symbols, this check appears to be redundant because of the
subsequent check for STB_LOCAL binding.

>  	}
> =20
>  	if (sym_bind =3D=3D STB_LOCAL)
[ ... ]
> @@ -2274,6 +2276,13 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
>  						insn->imm +=3D sec->dst_off / sizeof(struct bpf_insn);
>  					else
>  						insn->imm +=3D sec->dst_off;
> +				} else if (strcmp(src_linked_sec->sec_name, SDT_NOTES_SEC) =3D=3D 0)=
 {
> +					/* .bpf_sdt_notes contains R_BPF_64_ABS64 relocations
> +					 * referencing code section symbols. Adjust the 64-bit
> +					 * address by dst_off.
> +					 */
> +					__u64 *addr =3D dst_linked_sec->raw_data + dst_rel->r_offset;

[Severity: High]
This is a pre-existing issue, but does this lack a bounds check for the
relocation offset? The code uses the r_offset from the relocation to index
into raw_data. If a malformed ELF provides an r_offset that exceeds the
section size, it could result in an out-of-bounds heap memory access.

[Severity: High]
Can this direct pointer cast result in unaligned memory access? The r_offset
value might not be naturally aligned, which could lead to undefined
behavior or crashes on strict-alignment architectures when dereferencing the
cast pointer.

> +					*addr +=3D sec->dst_off;

[Severity: High]
Does this perform host-endian arithmetic on target-endian data without
conversion? The data section is not byte-swapped to native endianness, so
modifying the address using native host-endian addition could corrupt the
relocated address during cross-compiling.

[Severity: Medium]
Is it safe to blindly assume the relocation type is 64-bit? If an ELF object
contains a 32-bit relocation type targeting this section, unconditionally
reading and writing 64 bits without verifying the relocation type from
the relocation info could corrupt adjacent data.

>  				} else {
>  					pr_warn("relocation against STT_SECTION in non-exec section is not =
supported!\n");
>  					return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D1
