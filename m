Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98C342509
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309927; cv=none; b=edNvSDBrikR/c3aAQMWf3ndejvMdc+RH+Li+uczfy8n6owFZ78P2+mhgwT7DS+XjEfkXODJTlK8S7CcEThGdIRQ6Bedm1tBKziJo/qqU+Rg6PuyNq9IuKFYqBrDUnCuCYcmPh/3dw+CkJuzj6Qv2WTeRzIHKsuvobXQI+0cl+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309927; c=relaxed/simple;
	bh=C9rR1gGt5IvOg0x1G7t8bNYJfXK7zctHlizf74Cv1cA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DyuHyZ4KmwCnacafdvyQB39DRy50R0LtzNTwo0NZFqI2zRvskg5/jHdu1eFpTUmz63I9Fo0kwNNcuZx0niDjYPLlTHRlzJYuYHZP24uIDlYRPIXARxhFU1cEpifViK6zCOYNTUF7CBpfFvqbE+mtyui6IFTP03if+bxWCrpePj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4vn8QZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4vn8QZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C691F00893;
	Mon,  1 Jun 2026 10:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780309926;
	bh=Pdre14cli+B85C7iVUonb+Cs5k6QwgswTL5evLgtMzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j4vn8QZ+4fImQR8AoBIgntnjU4jOChPWhRhHP/D0BLypzY3uQQs6X4Df1FWhw9DIx
	 yqd533y44P+dG6obMsE+741jxtJQnLdmh9E715I5/3MsVzB4/NELQ47IwJCHOxVw+y
	 m7WqVfRNGD0R7bws9CWqHZ8HLwuzNIRSq/fBbFgfyoQmtOaI4kph8Hc3r8tadmNiGD
	 ofQrANNo5kE/9Dm6oVTcenvpzKhFngItISb3qVYjNAtDuODer+evxzTmR+FuWkp5/5
	 ZXeOaICrDp5mrK1Ode7/AEnu+Sq8+yh8X5YcnsgW7kVQnDejtzP4vzzt6aGwl+ulrC
	 TLZGvl/R52DhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] libbpf: Reject non-exclusive metadata maps
 in the signed loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601100307.386243-1-daniel@iogearbox.net>
References: <20260601100307.386243-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 10:32:05 +0000
Message-Id: <20260601103206.23C691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The BPF map exclusivity feature (`excl_prog_sha`) can be bypas=
sed via `ARRAY_OF_MAPS`, allowing a malicious BPF program to mutate a froze=
n exclusive metadata map and defeating the signed loader's TOCTOU defense.

Pre-existing issues:
- [High] Concurrent bpf_map_get_info_by_fd() calls on a frozen array map tr=
igger an unprotected data race and undefined behavior due to overlapping me=
mcpy().
--

commit c6a3102cfade62f836db60603418dd29d86695ef
Author: KP Singh <kpsingh@kernel.org>
Date:   Mon Jun 1 10:03:04 2026 +0000

    libbpf: Reject non-exclusive metadata maps in the signed loader
   =20
    The loader verifies map->sha against the metadata hash in its
    instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is
    called on the frozen map.
   =20
    While the map is frozen, the /signed loader/ must also ensure the map
    is exclusive, as, without exclusivity (which a hostile host could just
    omit when loading the loader), another BPF program with map access can
    mutate the contents afterwards, so the check passes on stale data.
   =20
    With the extra check as part of the signed loader, it now refuses to
    move on with map->sha validation if the host set it up wrongly.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1c6863ce89e0c..6191c0c51fea3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -296,6 +296,7 @@ struct bpf_map_owner {
> =20
>  struct bpf_map {
>  	u8 sha[SHA256_DIGEST_SIZE];
> +	u32 excl;

[Severity: High]
This is a pre-existing issue, but does concurrent execution of
bpf_map_get_info_by_fd() on a frozen array map trigger an unprotected
data race and undefined behavior?

In bpf_map_get_info_by_fd(), map->sha is passed directly as the hash_buf
without holding any locks:

kernel/bpf/syscall.c:bpf_map_get_info_by_fd() {
    ...
    err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha);
    ...
}

For array maps, array_map_get_hash() uses sha256() to write directly to
hash_buf, meaning concurrent calls could race while writing to map->sha.

Additionally, array_map_get_hash() finishes with this copy:

kernel/bpf/arraymap.c:array_map_get_hash() {
    ...
    memcpy(array->map.sha, hash_buf, sizeof(array->map.sha));
    ...
}

Because hash_buf is exactly map->sha, this evaluates to
memcpy(map->sha, map->sha, 32). Can this overlapping memcpy() cause
undefined behavior?

[ ... ]

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 3702c5944bc02..66a02039da8ce 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -586,6 +586,23 @@ static void emit_signature_match(struct bpf_gen *gen)
>  	__s64 off;
>  	int i;
> =20
> +	/*
> +	 * Reject if the metadata map is not exclusive. Without exclusivity
> +	 * the cached map->sha[] verified above can be stale: another BPF
> +	 * program with map access could have mutated the contents between
> +	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +	 */
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +					 0, 0, 0, 0));
> +	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, SHA256_DIGEST_LENGTH=
));
> +	off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
> +	if (is_simm16(off)) {
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, off));

[Severity: Critical]
Does this exclusivity check fully prevent TOCTOU attacks, or can the
exclusivity be bypassed via an array of maps?

If an attacker creates an exclusive metadata map and inserts it into an
array of maps, bpf_map_meta_equal() appears to ignore excl and
excl_prog_sha during validation:

kernel/bpf/map_in_map.c:bpf_map_meta_equal() {
    return meta0->map_type =3D=3D meta1->map_type &&
           meta0->key_size =3D=3D meta1->key_size &&
           meta0->value_size =3D=3D meta1->value_size &&
           meta0->map_flags =3D=3D meta1->map_flags &&
           btf_record_equal(meta0->record, meta1->record);
}

After freezing the inner metadata map and passing it to the signed loader
to pass this check, couldn't a malicious BPF program bind to the outer
map and mutate the inner map?

When the malicious program calls bpf_map_update_elem() on the inner map,
it routes to array_map_update_elem(), which does not enforce map->frozen
or map->excl_prog_sha at runtime.

Does this allow a BPF program to successfully overwrite the frozen
metadata map's contents after its hash was verified, defeating the signed
loader's exclusivity defense?

> +	} else {
> +		gen->error =3D -ERANGE;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601100307.3862=
43-1-daniel@iogearbox.net?part=3D1
