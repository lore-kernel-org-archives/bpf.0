Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96A496D5E
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406953; cv=none; b=T0uueMAIl5hM0jWtkGPARvWHJVvIIr2Yrk4XvlhtdTPlmjD16ISdyinqYihrMNoO2BVgljM/Y9Bi5UX2WSDxk0rzS+A69qIhbpve9SFK46ZbhJd0/rEUZpPM2b3LigdGyOi5IQ/9mqZdRqPQq982+24ineR3medJRWCT82svgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406953; c=relaxed/simple;
	bh=Mt0VRc0NSK9CcNDxqmfEusvInKgDpvLZmHyXZH1kCJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q56Ml4kYrotcm971HmqcdDPq7QxvU7o/1j3BTkuGpy6TykG5sniTKSH7yYgDxBeCYnx7b1wRFOHxA7icigrE01fBhVC3s+GdFgEm5gCmVO8ZvpM3m3OULVt9sYkoKsdMQFgrsbuMIhRkHDQHAwzDgEYjhPdHEnA1HWOwSgeCS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVtPQ/Ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVtPQ/Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6921F000FF;
	Mon, 14 Sep 2026 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789406952;
	bh=xO5iwcxc+CkDxp/rkwLWEMlaWON3a7bVcW/UT3Nb8no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVtPQ/CeTG4WFvsd5ch1xChJWUgMm9ZzWTSOn+4zY4AhL3fnzer1C31DqYlqFv55M
	 /ZE6NEKl1wn0Cs3+OTpncnb2pjA6jnv8D7KuxK9mUxkd6xv9dJ2krjHYzgNdrLpB1+
	 E4PTzmqfbMvpuye9wOBV2VBR6x5UCsQtFN/FGsbPFqll4+HDjBtN5kN+56m7SJPAPs
	 PVXTP0HsZBfYGd+zlZxWlW+dCRBD9J7PcI+UrZ0mgGRUqNoDdpXHGykOmJqadvdR/H
	 cvdMZzPPQqc+oZ0KP81TZ2mAxmnGFd1W9HBJNYvxZFy95MyXtwOVSDcWOhYunh1NBP
	 +p6e7kk9+t4Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 06/11] bpf: Clear insn array jitted pointers on
 map reuse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260914170326.249953-7-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
 <20260914170326.249953-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:29:11 +0000
Message-Id: <20260914172911.DC6921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing release semantics in `bpf_insn_array_release` can allow st=
ale JIT pointers to overwrite the re-initialized array due to CPU store reo=
rdering.
--

commit 9b6ea61f193d20b96c453fda13952db5c1dc1506
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Clear insn array jitted pointers on map reuse

This commit fixes a bug where stale JIT pointers and jitted offsets are lef=
t in
an instruction array map when it is reused. It clears these fields during m=
ap
initialization in bpf_insn_array_init().

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index a2f84afe6f7c6..5874abd1f7438 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -199,12 +199,16 @@ int bpf_insn_array_init(struct bpf_map *map, const =
struct bpf_prog *prog)
>  		return -EBUSY;
> =20
>  	/*
> -	 * Reset all the map indexes to the original values.  This is needed,
> -	 * e.g., when a replay of verification with different log level should
> -	 * be performed.
> +	 * Reset the map to its pre-verification state. The xlated and jitted
> +	 * offsets and the jitted target pointers are recomputed by the verifier
> +	 * and the JIT for this program, so any values left by a previous owner
> +	 * must be cleared here.
>  	 */
> -	for (i =3D 0; i < map->max_entries; i++)
> +	for (i =3D 0; i < map->max_entries; i++) {
>  		values[i].xlated_off =3D values[i].orig_off;
> +		values[i].jitted_off =3D 0;
> +		insn_array->ips[i] =3D 0;
> +	}
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while looking at how the map=
 is
reused, I noticed a potential missing release semantics issue in
bpf_insn_array_release():

kernel/bpf/bpf_insn_array.c:bpf_insn_array_release() {
	struct bpf_insn_array *insn_array =3D cast_insn_array(map);

	atomic_set(&insn_array->used, 0);
}

Is it possible that without release semantics (like atomic_set_release), pr=
ior
stores to the map can be reordered after this flag is set?

If two threads concurrently load a BPF program using the same
BPF_MAP_TYPE_INSN_ARRAY map:

Thread 1 JITs the program and writes to ips via bpf_prog_update_insn_ptrs(),
but fails a late verification check like bpf_check_tail_call(). It then
releases the map by setting used =3D 0 via the relaxed atomic_set().

Thread 2 acquires the map using atomic_xchg() and zeroes ips during
initialization, as added in this patch.

Could CPU reordering on weakly-ordered architectures allow Thread 1's delay=
ed
JIT stores to overwrite the zeros with stale pointers, causing Thread 2 to
subsequently use those stale pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914170326.2499=
53-1-daniel@iogearbox.net?part=3D6
