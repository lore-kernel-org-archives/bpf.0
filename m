Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB827603F
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781423415; cv=none; b=S2iZUHp6I8l2M/n7Ulh6X8XJ7P0jfRtfuJCeaNim9Ia5MNO3PFjR51ywx07baR/LXWSv4yLBYGK99rzC9BUceMwwhSntIAEdz83w+3kN6oAPlFJyILVelcpHCejfQEFaciJm0YU8YYtOrnNTpBNiAwqUEzbdUfLXkhBrcbSeLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781423415; c=relaxed/simple;
	bh=HUQ2imWxti0ytEa+bDT2q3Sxf40aaSrbY5EN157SJgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EiYSPm1z3wkE+YlO58HwQXGia08aneE6Fe4S+1tc8Eap6c/FH9EKneDbMuNrDSgz4+7NCp8vPfiVpOdQXbrzkWh1CiOWjW35gI3s+d9Tsnw64u8XPVjvMWzuiGA8ZzBodaHD2qotyYYHf/OigV+U4MRHBntlL+5U3uuldINU8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJgndK7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJgndK7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FD81F000E9;
	Sun, 14 Jun 2026 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781423413;
	bh=+UCEJjT3/En/2z5Bx7WQBRD88r/P3WKXDK2lTHfg+bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJgndK7YWWAgSA9Whjcxq5Q00MMdw2xiRRu+kgrQt+ssvnT8fWfMy4PhC4UaSSQvs
	 IVPxtfX5emw5jWhu8O0YUPzIjKCtytDMpNW2IkfdalJZKDxI68nFn/HGHPNeZ97nzn
	 DI9IM/JZUgtDh8nBzwjZZ+a+0wnaBTHHL5bd5RnPkriFJwHZAQ9EwW0Iys2eK7Ng7y
	 gpJTJ34ktlhnqv69WnR8kCATDQDUju5sNEd9fVIfU+M80VvPQHWVbuNS3rc5AdGS3f
	 Lwu0HOL4mCQ31FWf/7F4HZUKDjwIKjqTqjcKYcDvYUEPAxJEfODLEvYSUalLemBBVL
	 07e9RIe79I+dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] libbpf: Reject out-of-range linker relocation
 offsets
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260614053927.160566-2-sammiee5311@gmail.com>
References: <20260614053927.160566-2-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 07:50:13 +0000
Message-Id: <20260614075013.75FD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `sec_sz` field in `struct dst_sec` is declared as an `int`=
 instead of `size_t`, which causes large section sizes to truncate into neg=
ative values and leads to severe heap buffer underflows.
- [High] Static linker permits an out-of-bounds read when processing reloca=
tions against STT_SECTION symbols with a large st_shndx (e.g. SHN_ABS).
- [High] Processing relocations for an executable SHT_NOBITS section causes=
 a NULL pointer dereference.
- [High] extend_sec() fails to properly handle realloc() returning NULL, le=
ading to a NULL pointer dereference in memcpy().
--

commit 3c2b5b3ea26336642319803cdebc730e9790c0e6
Author: HyeongJun An <sammiee5311@gmail.com>

libbpf: Reject out-of-range linker relocation offsets

The static linker sanity-checks relocation sections before appending them,
but for executable target sections it only verifies that r_offset is
BPF-instruction aligned. It does not verify that the offset is inside the
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
This is a pre-existing issue, but can this lead to an out-of-bounds read?

tools/lib/bpf/linker.c:linker_append_elf_relos() {
    ...
	struct src_sec *sec =3D &obj->secs[src_sym->st_shndx];
    ...
}

In linker_sanity_check_elf_symtab(), the bounds check against obj->sec_cnt =
is
skipped if sym->st_shndx >=3D SHN_LORESERVE (such as SHN_ABS). However,
STT_SECTION symbols might still use these reserved indices. Does this array
access use the unvalidated 16-bit integer as an array index, potentially
causing a heap out-of-bounds read?

[Severity: High]
This isn't a bug introduced by this patch, but could this cause a NULL poin=
ter
dereference?

tools/lib/bpf/linker.c:linker_append_elf_relos() {
    ...
	insn =3D dst_linked_sec->raw_data + dst_rel->r_offset;
	if (insn->code =3D=3D (BPF_JMP | BPF_CALL))
    ...
}

For ELF sections of type SHT_NOBITS, extend_sec() does not allocate
dst->raw_data, leaving it as NULL. Since an SHT_NOBITS section can still ca=
rry
the SHF_EXECINSTR flag, does evaluating this pointer and reading insn->code
cause a crash when applying relocations to an SHT_NOBITS executable section?

[Severity: High]
This is a pre-existing issue, but does this correctly handle memory allocat=
ion
failures?

tools/lib/bpf/linker.c:extend_sec() {
    ...
	if (!tmp && dst_align_sz > 0)
		return -ENOMEM;
	dst->raw_data =3D tmp;
    ...
}

For the very first object added, dst->sec_sz is 0, making dst_align_sz 0. If
realloc() fails and returns NULL, the error check is bypassed. Since
dst->raw_data is then set to NULL, does the subsequent memcpy() crash when
attempting to copy data to address 0x0?

[Severity: Critical]
This is a pre-existing issue, but does using an int for sec_sz truncate lar=
ge
section sizes into negative values?

tools/lib/bpf/linker.c:struct dst_sec {
    ...
	/* final output section size */
	int sec_sz;
    ...
};

tools/lib/bpf/linker.c:extend_sec() {
    ...
	dst_align_sz =3D (dst->sec_sz + dst_align - 1) / dst_align * dst_align;
    ...
	memcpy(dst->raw_data + dst_align_sz, src->data->d_buf, src->shdr->sh_size);
    ...
}

If a malformed ELF file specifies a very large section size, dst->sec_sz can
truncate to a negative value. When a second object file is linked, the
alignment calculation promotes the negative int to an unsigned 64-bit size_=
t,
wrapping around to a massive size.

Does this cause realloc() to allocate a small buffer while the subsequent
memcpy() writes the new section data behind the newly allocated heap chunk,
leading to a heap buffer underflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614053927.1605=
66-1-sammiee5311@gmail.com?part=3D1
