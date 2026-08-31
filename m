Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6B4BAA10
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185028; cv=none; b=eTlwLHnevjzFJzDA+oBkclwlueNM3z61w4AOM81G7pOD/Rd0IJ1YpI5UyXxx1vJl7u3ZY0aAKcrKZKbI5vGXqX/JCu7kw+Z9z8ECycslwTZOm/E0JxjCOAeHEIiFWkQ/rX0vMBy77ja+sRLJ0dvFgRCyfpcLjGVH3RdjOiH2ZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185028; c=relaxed/simple;
	bh=eFhC3QMpBOSgWIE58z30vWOddqzMB2K9V8O55mnpMM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o4moSJdVf5BfY5+sroyiQbtxAC0YdlA0HbPpMYaU6MWSFp/REp8Q637/PTYTwaNfAW9GfLOD1IHBr9x17XzcfDUgG9pAml3ctfESgrP920u7mmKiG4TG74Y+KZAz4RPBi5UJk3P51TV3Zb7Io0ILUgShAD0S1Kb5rDPt1ajk+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2nySG5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2nySG5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1FF1F00A3F;
	Mon, 31 Aug 2026 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185027;
	bh=KL8pF6u+tzdTME51A4m9CI/mf5USPTA/QV3Rl14LolA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2nySG5ZFgSgVZlewcxmRxLp68BOv88flZ/GN8j19qOb4Y3PZ26jgG+6NKDlbVGdG
	 C4YkP+/BgV+iZrjcXU1nCM0Wtrgb5RHtBh9N6AUIg4LU+wjF3wK87Lvz/huKB5Ok1b
	 xgJYLMi9GVjWI++9TjsVm3cwKCFzM+RDgkMhmd5Esth/AttuC/E67jJ6KmpKvBRXd+
	 OJpfR3Ud2tY7fte+rrGZnx1RdMt5qMNgkopqa1pc6SbIA1x9iRHF2aBG82fnYe7wGS
	 Hd5Zd9HtaJHhcBIp4T8VuwxVdelXVQD0zuVqvEB6DGRj+Y7twdgt2xFw0KYrg0XT4D
	 23zcy7neQ6INg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] libbpf: Also reset {insn,data}_cur on
 realloc failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831133314.4125787-44-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-44-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:03:46 +0000
Message-Id: <20260831140347.5A1FF1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `gen->error` check in `bpf_gen__finish()` leads to a NULL =
pointer dereference in `compute_sha_update_offsets()` if a previous allocat=
ion failed.
- [High] Missing `gen->error` check in `bpf_gen__prog_load()` leads to a NU=
LL pointer dereference during endianness swapping after an allocation failu=
re.
--

commit d36df279d8dfc0fe65a516d12685c54faba8d9da
Author: Daniel Borkmann <daniel@iogearbox.net>

libbpf: Also reset {insn,data}_cur on realloc failure

realloc_insn_buf() as well as realloc_data_buf() free and NULL
gen->insn_start / gen->data_start on -ENOMEM but leave gen->insn_cur /
gen->data_cur pointing into the old, freed buffer. Just reset the
cursors to NULL alongside the base pointers so the freed state is
coherent.

Link: https://lore.kernel.org/r/20260529094119.307264-3-daniel@iogearbox.net

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cd5c2543f54d8..8722ecc023819 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -63,6 +63,7 @@ static int realloc_insn_buf(struct bpf_gen *gen, __u32 =
size)
>  		gen->error =3D -ENOMEM;
>  		free(gen->insn_start);
>  		gen->insn_start =3D NULL;
> +		gen->insn_cur =3D NULL;
>  		return -ENOMEM;
>  	}

[Severity: High]
This is a pre-existing issue, but missing a gen->error check in
bpf_gen__finish() leads to a NULL pointer dereference in
compute_sha_update_offsets() if this allocation fails.

If a buffer allocation fails here, gen->error is set and gen->insn_start is
freed and set to NULL. The libbpf loader relies on bpf_gen__finish() to ret=
urn
the error at the end of the operation, but it unconditionally calls
compute_sha_update_offsets() before checking gen->error:

tools/lib/bpf/gen_loader.c:bpf_gen__finish() {
    ...
	if (OPTS_GET(gen->opts, gen_hash, false))
		compute_sha_update_offsets(gen);

	pr_debug("gen: finish %s\n", errstr(gen->error));
	if (!gen->error) {
    ...
}

Which then directly dereferences the NULL gen->insn_start:

tools/lib/bpf/gen_loader.c:compute_sha_update_offsets() {
    ...
	for (i =3D 0; i < SHA256_DWORD_SIZE; i++) {
		struct bpf_insn *insn =3D
			(struct bpf_insn *)(gen->insn_start + gen->hash_insn_offset[i]);
		sha_dw =3D tgt_endian(sha[i]);
		insn[0].imm =3D (__u32)sha_dw;
    ...
}

Should bpf_gen__finish() check gen->error before calling
compute_sha_update_offsets()?

[ ... ]

> @@ -86,6 +87,7 @@ static int realloc_data_buf(struct bpf_gen *gen, __u32 =
size)
>  		gen->error =3D -ENOMEM;
>  		free(gen->data_start);
>  		gen->data_start =3D NULL;
> +		gen->data_cur =3D NULL;
>  		return -ENOMEM;
>  	}

[Severity: High]
This is a pre-existing issue, but missing a gen->error check in
bpf_gen__prog_load() leads to a NULL pointer dereference during endianness
swapping if this allocation fails.

bpf_gen__prog_load() dynamically allocates buffers by calling add_data(), w=
hich
eventually calls realloc_data_buf(). If this allocation fails, gen->error is
set to -ENOMEM, gen->data_start is set to NULL, and add_data() returns 0.

However, bpf_gen__prog_load() ignores gen->error and continues execution.
If gen->swapped_endian is true, it attempts to iterate over instructions
stored in gen->data_start, directly dereferencing the NULL pointer:

tools/lib/bpf/gen_loader.c:bpf_gen__prog_load() {
    ...
	insns_off =3D add_data(gen, insns, insn_cnt * sizeof(struct bpf_insn));
    ...
	/* convert blob insns to target endianness */
	if (gen->swapped_endian) {
		struct bpf_insn *insn =3D gen->data_start + insns_off;
		int i;

		for (i =3D 0; i < insn_cnt; i++, insn++)
			bpf_insn_bswap(insn);
	}
    ...
}

Similarly, the info_blob_bswap() helper function also dereferences the
NULL gen->data_start buffer:

tools/lib/bpf/gen_loader.c:info_blob_bswap() {
	struct bpf_func_info *fi =3D gen->data_start + func_info;
    ...
	for (i =3D 0; i < load_attr->func_info_cnt; i++)
		bpf_func_info_bswap(fi++);
    ...
}

Should bpf_gen__prog_load() check gen->error and abort early?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-44-sashal@kernel.org?part=3D1
