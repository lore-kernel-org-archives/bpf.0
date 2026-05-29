Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD9373BEE
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074110; cv=none; b=oCbO8SD1ktbVjiOvqBReBdOUWBaw8MabqyVAo6R0rTBiq9PvlkdOxOu2LsfPN/WGbPKlWesrTzD4I7zM9pl9AYEcjS3k/y78qE9FPAuzwTav//9EVBYuC5ee7x65mxXjD5g+Vdnt7XJvqhnOs3alXMnl8/k/VEHmvm0fN76AkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074110; c=relaxed/simple;
	bh=RkhcjID7DhkNuXMeVDrj13Zqa2G4oM94EhCfedSnXu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kea0Kqzt/WoXrckOOeGcgyTFk539C/bKFbb8GGAeeo7wdKXwmydSj1ciSJL5x6wcgb8yrrAXKMIxVbhmojeKqD2qGdO1QYHep21a08jKQVvgmgFxgbXDFKoTGbC2Cp8D0jsu6fHakJYw+znvVCZDsEOYFol9KwODzoYfyfFONxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+3EYNs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+3EYNs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487161F00893;
	Fri, 29 May 2026 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780074109;
	bh=aggCJ7VCMhomARyX3cg6nhCsEC2gJJaMv5MiDdF5zTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+3EYNs3QUEipQA0kFssfPeklfPl5gIx/aHzJI+uQmwbIzGhhuqFuW6CstlrLXimE
	 xZTCVUJGOuHFzFR/q240TKA+NQ0h6NX0KSYkIobySkdiNmAJm44JXaGb5S1fElO+4u
	 ntz1bGK8Toui0wteh5lyBUNgJz3PMCtAonCz/mlaMYm/TO9DBUqEdkWz54KzKROQjN
	 YSvf0sCgSIE2iPBSJu3M/dhk05KI9WLT9vMolaOd4r70TyxowTrEc4SUDG3mU0qJNL
	 VV0GfnoxfK8TPkPDoUaN/9680+6gCqbvyG9TjIrLWsO/zSA71+M5uLpO0zbnrKXqNz
	 NTZQ0iepBIq/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Skip endianness swap when loader
 generation failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529162829.315921-1-daniel@iogearbox.net>
References: <20260529162829.315921-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:01:48 +0000
Message-Id: <20260529170149.487161F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The calculation of total instruction size `insn_cnt * sizeof(s=
truct bpf_insn)` is evaluated as a `size_t` but implicitly truncated when p=
assed to `add_data()`, which expects a 32-bit `__u32` size, leading to an u=
ndersized allocation and a critical heap buffer overflow.
- [Critical] Calculations for total blob sizes such as `func_info_tot_sz =
=3D load_attr->func_info_cnt * load_attr->func_info_rec_size` suffer from 3=
2-bit integer wrapping, leading to undersized allocations and heap buffer o=
verflows.
- [Critical] The `roundup(size, 8)` macro call inside `add_data()` overflow=
s for large sizes close to `UINT32_MAX`, leading to a bypass of the size va=
lidation and a massive out-of-bounds `memcpy`.
--

commit 3d03d412315397f92ae3ab0965da7090253b5cf8
Author: Daniel Borkmann <daniel@iogearbox.net>

libbpf: Skip endianness swap when loader generation failed

The commit fixes a bug in bpf_gen__prog_load() where program instructions a=
nd
info blobs are byte-swapped for cross-endian targets. It prevents byte-swap=
ping
if loader generation has already failed and gen->error is set, which otherw=
ise
causes NULL pointer dereferences when calculating blob offsets on a stale
buffer.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9478b8f78f260..d9b38b9077eb6 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -1026,99 +1026,99 @@ static void info_blob_bswap(struct bpf_gen *gen, =
int func_info, int line_info,
>=20
> [ ... ]
>=20
>  void bpf_gen__prog_load(struct bpf_gen *gen,
>  			enum bpf_prog_type prog_type, const char *prog_name,
>  			const char *license, struct bpf_insn *insns, size_t insn_cnt,
>  			struct bpf_prog_load_opts *load_attr, int prog_idx)
>  {
>  	int func_info_tot_sz =3D load_attr->func_info_cnt *
>  			       load_attr->func_info_rec_size;

[Severity: Critical]
This is a pre-existing issue, but does this calculation suffer from 32-bit
integer wrapping?

Values like func_info_cnt and func_info_rec_size are 32-bit unsigned intege=
rs.
If they are controlled by a user, their product could exceed 32 bits and wr=
ap
to a small value. Later code iterates over the unabridged func_info_cnt whi=
ch
could lead to an undersized allocation and a massive out-of-bounds read and
write.

>  	int line_info_tot_sz =3D load_attr->line_info_cnt *
>  			       load_attr->line_info_rec_size;
>  	int core_relo_tot_sz =3D gen->core_relo_cnt *
>  			       sizeof(struct bpf_core_relo);
>=20
> [ ... ]
>=20
>  	/* add license string to blob of bytes */
>  	license_off =3D add_data(gen, license, strlen(license) + 1);
>  	/* add insns to blob of bytes */
>  	insns_off =3D add_data(gen, insns, insn_cnt * sizeof(struct bpf_insn));

[Severity: Critical]
This is a pre-existing issue, but can the insn_cnt * sizeof(struct bpf_insn)
evaluation be implicitly truncated?

The result is evaluated as a size_t, but add_data() expects a 32-bit __u32
size parameter. If insn_cnt is maliciously large, the value could exceed the
32-bit maximum and be implicitly truncated. add_data() would allocate an
undersized buffer, while later code like bpf_insn_bswap() operates using the
original 64-bit insn_cnt, leading to a heap buffer overflow.

>  	pr_debug("gen: prog_load: prog_idx %d type %d insn off %d insns_cnt %zd=
 license off %d\n",
>  		 prog_idx, prog_type, insns_off, insn_cnt, license_off);
> =20
>  	/* convert blob insns to target endianness */
> -	if (gen->swapped_endian) {
> +	if (gen->swapped_endian && !gen->error) {
>  		struct bpf_insn *insn =3D gen->data_start + insns_off;
>  		int i;
>=20
> [ ... ]
>=20
>  	attr.func_info_rec_size =3D tgt_endian(load_attr->func_info_rec_size);
>  	attr.func_info_cnt =3D tgt_endian(load_attr->func_info_cnt);
>  	func_info =3D add_data(gen, load_attr->func_info, func_info_tot_sz);

[Severity: Critical]
This is a pre-existing issue, but does add_data() bypass size validation for
sizes close to UINT32_MAX?

Looking at add_data() in this file:

static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
{
	__u32 size8 =3D roundup(size, 8);
...
	if (realloc_data_buf(gen, size8))
		return 0;
...
	if (data) {
		memcpy(gen->data_cur, data, size);

If a user provides a size near UINT32_MAX (for example via the func_info_to=
t_sz
calculation), the roundup(size, 8) macro adds 7 and overflows the 32-bit
boundary, resulting in size8 becoming 0. The internal realloc_data_buf()
bypasses its size > INT32_MAX validation, and the subsequent memcpy() uses
the unrounded huge size, resulting in a massive out-of-bounds copy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529162829.3159=
21-1-daniel@iogearbox.net?part=3D1
