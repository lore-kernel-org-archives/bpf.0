Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AA1474CC
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429841; cv=none; b=KVgDttmIXTYCYf+VdPcsdabx0Fo8QIUAVra22RkVLWUIG8l8hJXXWIqZy/O7c0bHzGw7y++f7WGifQS56ULQKBgzVMICNb0MJMz3Mut5BJ5w0+wt/a6AcUsCANpjAwyhI80T87PHKuR9ZTvw/yEJqTduJsd4Qc4mZnMyV73SV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429841; c=relaxed/simple;
	bh=UKsruCv2TVmF50NVK8hrX3wfqQOBi0WHGTfMZjTf1Ow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OhFRpEuDm04ia6BW2aSC8f6Jo7MF0G/Kpb2bWFJ7qZjkTNJ3M5jgtEiw6iNJQF7chSDX3bam+kuuTfr+lYd/hPUTUsKM0Yq+wpc5y5mVQOMKjRco1YcNeFkXJMWcdFN+JlVvRE1JMB5Y2T4ZCGtiIBDq3yW5fP30RjiNcWvYmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNGW3h54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNGW3h54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7461F000E9;
	Sun, 14 Jun 2026 09:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781429840;
	bh=ac4u5C/T5uA2ipwspS3WRty9BpIsFL8KkR8Mq+sJmcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GNGW3h54o1LOOsC78yHCMzWN/idV8Tb4oW7/gvd1jyVsQ5DPbDdiM8A5ii3bvS9EF
	 rw+0TeCdWJ5Ecc7iCQpaxwVos/bVJQ1Df1Govncx7irNDr5ERswcDwkb+5VB+3yLRF
	 zj878+GlSJXcMNxASMJd7pdKFHI337H6mj3FdpT/+QvkDM9UYlVy0JAwGAOg7uH8It
	 vJtJaTE8FbGJo9ND83xdvarEAfKWODORHmDXL8OdbW1Y9sHIOx5iTPddJdvgC2fa5y
	 sK37vXlXTINzt5qnWq4NaTnAdimPD9Kv+Cs3Exp5gCjUD68mBTG6VGwF+ifQ/wRXsl
	 BvWQkbRBXjrZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] libbpf: Reject out-of-range linker
 relocation offsets
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260614092616.165337-2-sammiee5311@gmail.com>
References: <20260614092616.165337-2-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 09:37:19 +0000
Message-Id: <20260614093719.DE7461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on st_shndx for STT_SECTION symbols bypassing=
 validation with reserved indices causes an out-of-bounds array access.
- [High] Relocations against SHT_NOBITS sections marked with SHF_EXECINSTR =
lead to a NULL pointer dereference.
- [High] Integer overflow in symbol index validation leads to an out-of-bou=
nds heap read on 32-bit platforms.
--

commit d6f111169154c451a99d6d0abcb52570ad19f6c1
Author: HyeongJun An <sammiee5311@gmail.com>

libbpf: Reject out-of-range linker relocation offsets

The static linker sanity-checks relocation sections before appending them,
but for executable target sections it only verifies that r_offset is
BPF-instruction aligned.  It does not verify that the offset is inside the
relocated section.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290af..3eb23da167d29 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1048,6 +1048,12 @@ static int linker_sanity_check_elf_relos(struct sr=
c_obj *obj, struct src_sec *se
>  			return -EINVAL;
>  		}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but can the symbol index validat=
ion
overflow on 32-bit platforms?

In linker_sanity_check_elf_relos(), the size check just above this line
multiplies by sizeof(Elf64_Sym):

    if (!sym_idx || sym_idx * sizeof(Elf64_Sym) >=3D sym_sec->shdr->sh_size=
) {

If an exceptionally large sym_idx is provided (like 0x15555556), the
multiplication can overflow a 32-bit size_t, bypassing the bounds check.

Later in linker_append_elf_relos(), this unvalidated index is used to access
the obj->sym_map array:

    dst_sym_idx =3D obj->sym_map[src_sym_idx];

Could this result in an out-of-bounds heap read?

> +		if (relo->r_offset >=3D link_sec->shdr->sh_size) {
> +			pr_warn("ELF relo #%d in section #%zu has invalid offset %zu in %s\n",
> +				i, sec->sec_idx, (size_t)relo->r_offset, obj->filename);
> +			return -EINVAL;
> +		}
> +
>  		if (link_sec->shdr->sh_flags & SHF_EXECINSTR) {
>  			if (relo->r_offset % sizeof(struct bpf_insn) !=3D 0) {
>  				pr_warn("ELF relo #%d in section #%zu points to missing symbol #%zu =
in %s\n",

[Severity: High]
This is a pre-existing issue, but could reserved indices for STT_SECTION
symbols bypass validation and cause an out-of-bounds array access?

In linker_sanity_check_elf_symtab(), the bounds check is skipped if the ind=
ex
is reserved:

    if (sym->st_shndx < SHN_LORESERVE && sym->st_shndx >=3D obj->sec_cnt) {

Later in linker_append_elf_relos(), relocations against STT_SECTION symbols
use this unchecked index directly:

    struct src_sec *sec =3D &obj->secs[src_sym->st_shndx];

If an attacker provides an ELF with a reserved index like SHN_ABS, could th=
is
read past the allocated obj->secs array and leak heap memory when sec->dst_=
off
is added to the instruction?


[Severity: High]
This is a pre-existing issue, but could relocations against SHT_NOBITS sect=
ions
lead to a NULL pointer dereference?

Currently, linker_sanity_check_elf() does not validate the SHF_EXECINSTR fl=
ag
for SHT_NOBITS sections. In extend_sec(), SHT_NOBITS sections skip allocati=
ng
dst->raw_data, leaving it as NULL.

When linker_append_elf_relos() processes a relocation for such a section,
it computes an address from raw_data:

    insn =3D dst_linked_sec->raw_data + dst_rel->r_offset;
    if (insn->code =3D=3D (BPF_JMP | BPF_CALL))

Since raw_data is NULL, would this result in a direct NULL pointer derefere=
nce?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614092616.1653=
37-1-sammiee5311@gmail.com?part=3D1
