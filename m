Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845E36AB46
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212626; cv=none; b=hnfltO1qq8MPoYGv2RTE/iCJ9/QHTXm2yQ0XhkA9oRTJxIH6H723Y4HQvwaMx+FApQTomxTYwv/X772Zk73ip4UVpiKmbhIu3SV9S5Vj2k6T2ge9LLPD8iuvzMB6uwZkBwebbL2f6ImDZWfK2J04/Sd2ZrHWZuvhvzqrv2/WBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212626; c=relaxed/simple;
	bh=TWVg6QAE+J5ptxjajaWe374aQTPceWC1sEoRIQZE8wk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GX8Mx1z7yfgBMQ0M3mbPIXPrE4w9ppeN2rZi2ORtEuhckZU3SrmZPoTaTh1VE7+EQlSnD42Kwdzerxn6ALbM+jaUWCnEcugrX30ZWw0XOtAW4tQ51u4MM+g+Y2Obm9aeswuVx4csg1EzS5bP89cfOjKIks9xz4H2DRgfVqRUASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz8dUxyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz8dUxyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6751F00A3A;
	Tue, 23 Jun 2026 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782212625;
	bh=PVW3ni49BPH4q44GIU5je4PH7rPUSSVrA92YVOvmOCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wz8dUxybbYEEoq8TGj1Kz+Jkxf3y2A7vWH6cj7dGhlouOxK/Jfs99EUaizKeQxP7D
	 3AfTCyyuteSSI59rQ8rNbwt7mP4pWzgw7NcN6Xoe7sVQA/fh/J8OsbOz48LJ741wP5
	 zbyrzOacL9956g6bQwoRja8V85LagKdmNQk9AUvbNgqVsAb4i+4wLXFWUp7Vsychdp
	 E+cCEv29ToFu/YQaBuMV7ET+MevDLzaDpX0yiak3euJGr18USBtz4qzRXVrnBidI13
	 vgSJko4uLPD/0//E2TpzHGKyS4kSRXrnLe3QwvIdFnPQBMngJ8KIvn5vvkio1Sj70n
	 ccOHSNs88Axbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Mask pseudo pointer values in
 verifier logs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-1-a190ebb8f3e2@mails.tsinghua.edu.cn>
References: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
 <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-1-a190ebb8f3e2@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 11:03:43 +0000
Message-Id: <20260623110345.0A6751F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Translated BPF program dump (BPF_OBJ_GET_INFO_BY_FD) leaks physica=
l kernel addresses from BPF_PSEUDO_BTF_ID instructions to users without CAP=
_PERFMON.
--

commit 302eadb037a969e2a3c9dbab8e1a08cf49f16888
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Mask pseudo pointer values in verifier logs

This commit updates print_bpf_insn() to mask additional pointer-bearing
pseudo sources like BPF_PSEUDO_BTF_ID in verifier logs when pointer leaks
are not allowed.

> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index f8a3c7eb451e4..0391b3bc00734 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -323,7 +323,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  			 */
>  			u64 imm =3D ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;
>  			bool is_ptr =3D insn->src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> -				      insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE;
> +				      insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +				      insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX ||
> +				      insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE ||
> +				      insn->src_reg =3D=3D BPF_PSEUDO_BTF_ID;

[Severity: High]
This isn't a bug introduced by this patch, but does the kernel still leak
physical addresses from BPF_PSEUDO_BTF_ID instructions when a user without
CAP_PERFMON calls BPF_OBJ_GET_INFO_BY_FD to dump the translated program?

In kernel/bpf/verifier.c:convert_pseudo_ld_imm64(), the verifier clears
the src_reg for non-func pseudo loads after resolving the address:

	if (insn->src_reg =3D=3D BPF_PSEUDO_FUNC)
		continue;
	insn->src_reg =3D 0;

Later, when dumping the instructions in
kernel/bpf/syscall.c:bpf_insn_prepare_dump():

	imm =3D ((u64)insns[i + 1].imm << 32) | (u32)insns[i].imm;
	map =3D bpf_map_from_imm(prog, imm, &off, &type);
	if (map) {
		insns[i].src_reg =3D type;
		insns[i].imm =3D map->id;
		insns[i + 1].imm =3D off;
		continue;
	}

Because BPF_PSEUDO_BTF_ID resolves to a kernel symbol rather than a map,
bpf_map_from_imm() returns NULL. Since src_reg was zeroed by the verifier,
this code has no way to distinguish the leaked physical kernel address from
a normal 64-bit constant.

Could this allow users to retrieve raw kernel pointers, since there is no
fallback bpf_dump_raw_ok(f_cred) check here?

>  			char tmp[64];
> =20
>  			if (is_ptr && !allow_ptr_leaks)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-f01-13-pse=
udo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn?part=3D1
