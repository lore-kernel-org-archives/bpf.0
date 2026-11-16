Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810553;
	b=0xMSAE3krKaoKHNG63+zWxiD+iv+uUGBCG2m6ZtRlq4BfOvuKTGgqhUtSndMiq1yQByz
	 syy2UJSWIk77Wy+1u7PPR46oKxsPpPwtdywUHU4Zj5bIak2gznTYsS3THMyurcxOg4RLI
	 /9JN0NnJNc8CODeZ2P5hgfEvT5ap9gsYr/NrFnB16ceCijtl3G8sVNTMC42D3riIot/Tl
	 0X/8ES+45stsXXnyMhFf8PBX8xJCedsa81rzNKhnws9CaqEHPjdBDdwDZiqKfQtSUOBmW
	 /7qA3TgBZyYwXkW5pozearYWYqeYQ5NhCy/ZL0n8X6huXpmsqQJNQSRzY2QeNzmiKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LTAVHE6/GL0wGVtmbeT8xVN8zwKKeUHOOlCbteemRPc=;
	b=C/a4Aw/fbTaBYR8HCZKWZ4hsf97i9VoMohlVgw1xYeFxZ4VpBjbJAmgs2698ZyEIOOe1
	 S73giF68DTPYwrSziy45/o+qkP7rugbs38/Dn++QT7n8L7fYMAqLygVviqeOSgG7MT7g3
	 3F2x9Va/V65L+wbH/lEnNRyzipBn3qQATNsyvZYw9WhxSJXMjF0VSpVZK7aBIlGC9WLSj
	 ZjKdfXNgNPwiMfKQp3oGJ/OHtuNWvxY9PhrhpO1MOs6vzB8OJF/gzNKC+VYulrBhgLtPn
	 TJ4lVGX4+KIa1BRn7R3tcryRiZHKDqVFAbACKZfpefefUFNgYkA13tlwgCbHSRpWZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4URsPtr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA086606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4URsPtr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AE91F000C4;
	Mon, 16 Nov 2026 06:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794810553;
	bh=LTAVHE6/GL0wGVtmbeT8xVN8zwKKeUHOOlCbteemRPc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f4URsPtrdaJEjswVz5W5942jRfiE1c5FCm93EzEwUvtecek1Y0hEbEFG8jkGfBMXd
	 O3RLD2aegVW1ofEhDrNlNRjsjO6GI3BiDQadkMBnmSM28ynp0UVsHV+7gMBMZ5cR/H
	 M7CN3diljzzgGYea3szQhP5gzaSLCh0W6cwWvyNsnFcGinjrL1kpYfewAE7VJA30ZC
	 04Mtg43P6XLKh/nRlokQrxBqPkFc8HzlXxTNrNC8WbsZfYYDkquvszhNbeRhp26r8J
	 Z/St0ppk5ppJEbejzp2RPuf6n6pyF5/LBYVTObn8JS2PaCCkjjsixybhX+lagI8EAK
	 RuVsrGqPVSjjA==
Message-ID: <sashiko-outbox-216279@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 02/21] bpf: Fail the load when there is no
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-3-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:29:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [Critical] bpf: kernel map pointer leak in bpf_prog_calc_tag() [1]
- [Medium] bpf: unjoined spills in compute_subprog_args() cause false
  FM_MUST_WRITE [2]
--

commit 7ed141586457177ae6d6a4df96dc2819c9dd9563
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Fail the load when there is no memory

This commit adds __GFP_RETRY_MAYFAIL | __GFP_NOWARN to BPF verifier and
program load allocations so that hitting a memory cgroup limit returns
-ENOMEM instead of invoking the OOM killer.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b407b2393ac3e..09abfed83109c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -309,7 +309,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
>  	bool was_ld_map;
>  	u32 i;
> =20
> -	dst =3D __vmalloc(size, GFP_KERNEL_ACCOUNT);
> +	dst =3D __vmalloc(size, BPF_VERIFIER_GFP);
>  	if (!dst)
>  		return -ENOMEM;

[Severity: Critical]
This problem wasn't introduced by this patch, but can bpf_prog_calc_tag()
leak kernel map pointers [1] when hashing subprograms that use
BPF_PSEUDO_MAP_IDX or BPF_PSEUDO_MAP_IDX_VALUE?

check_and_resolve_insns() replaces the immediate fields of those pseudo map
instructions with kernel map pointers while keeping their original src_reg,
and jit_subprogs() later calls bpf_prog_calc_tag() on each subprogram.
Because the loop right below only zeroes dst[i].imm for BPF_PSEUDO_MAP_FD
and BPF_PSEUDO_MAP_VALUE:

kernel/bpf/core.c:bpf_prog_calc_tag() {
	...
	for (i =3D 0, was_ld_map =3D false; i < fp->len; i++) {
		dst[i] =3D fp->insnsi[i];
		if (!was_ld_map &&
		    dst[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
		    (dst[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
		     dst[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
			was_ld_map =3D true;
			dst[i].imm =3D 0;
	...
}

the resolved kernel map pointers for BPF_PSEUDO_MAP_IDX and
BPF_PSEUDO_MAP_IDX_VALUE are hashed directly into the subprogram digest
exposed via bpf_prog_info, allowing userspace to recover kernel map
addresses and making subprogram tags non-deterministic across reloads.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 2c771b936d654..053b3875cde69 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -2190,7 +2190,7 @@ static noinline_for_stack int compute_subprog_args(=
struct bpf_verifier_env *env,
>  			struct spill_snapshot *snap;
> =20
>  			kvfree(env->callsite_at_stack[idx]);
> -			env->callsite_at_stack[idx] =3D kvmalloc_flex(*snap, at, nslots, GFP_=
KERNEL_ACCOUNT);
> +			env->callsite_at_stack[idx] =3D kvmalloc_flex(*snap, at, nslots, BPF_=
VERIFIER_GFP);
>  			snap =3D env->callsite_at_stack[idx];
>  			if (!snap) {
>  				err =3D -ENOMEM;

[Severity: Medium]
This problem wasn't introduced by this patch, but can snapshotting
at_stack_in into env->callsite_at_stack[idx] without joining spilled slots
with ARG_NONE [2] cause a callee to falsely mark a caller's stack slot
with FM_MUST_WRITE?

arg_track_xfer() only updates local stack slots on stores or calls, leaving
ancestor frame snapshots in env->callsite_at_stack unchanged:

kernel/bpf/liveness.c:arg_track_deref() {
	...
	if (ptr->frame >=3D 0 && ptr->frame < depth) {
		struct spill_snapshot *parent =3D env->callsite_at_stack[callsites[ptr->f=
rame]];

		return fill_from_stack(insn, at_out, reg, parent->at, parent->slots, ptr-=
>frame);
	}
	...
}

If a caller spills a frame pointer to its stack and passes a frame pointer
to a callee that overwrites that spill slot with a non-frame pointer (such
as a map value pointer), loads it back, and stores through it,
fill_from_stack() still returns the original single-offset spill from
parent->at.  record_stack_access_off() then sets FM_MUST_WRITE on the
originally spilled caller slot, killing FM_LIVE_BEFORE at callee entry so
clean_verifier_state() poisons the live slot with STACK_POISON and rejects
valid programs.

[1] https://sashiko.dev/#/bug/linux-3631fcb7-6cc6-4103-b924-aa236118faf7
[2] https://sashiko.dev/#/bug/linux-770fd7fa-a8be-43e6-aced-6a3500427b32

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D2
