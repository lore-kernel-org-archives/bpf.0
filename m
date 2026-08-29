Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AED1D4606
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787976434; cv=none; b=A0XOuN+Uj6j+6B0vVgXP+m8k7KEMbdvuFQgsDy99ZRQQkS/ACnoRDyKQ9/iiiLMUr9jES8OIuF4iVGQgI2/4/GWhp6gq6wQg1u//Z47BdI3Tjx+sI1LEq4an9Cjhp7M2sG6vQWg43fXd4iXBCeY+evmc6tZ7fkOP4TJJoqIG/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787976434; c=relaxed/simple;
	bh=fwt953LZ3HS5ZgiyF5opFa1l5sbgq3OhQWXKMbz3Idc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=edTAtXBfSCNQBUSz7p/nDG3QM2z+MFzAcoKAdwROnqktVEARtefR2zNHfxMG6KR5cQ2q+4dRlhaEm9OmHdtojQ91x3jmueD/HIhTBlCnpOLtWm/Wnk3PY8veoIJb3qaUo4OLVHW4/m6CFiccJhhb5/pdAXPjk7qpiH1aujkrVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKaBDKYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKaBDKYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B511F000E9;
	Sat, 29 Aug 2026 04:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787976432;
	bh=h7Hanr9/3fRDI5Xf5y9AIvdgWEpQiyFnnsEs5pLm0S8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKaBDKYID46t5RaL3L2tqfy1YIFwzXuumATB+HOT1AOFnUn/KCAXE84JPa6CvR3+Z
	 +3hpBitzUlLjyDMhQwTLaKb+hOEChmCPM4vJtvVBrl1Myz7ZEd0wlzVfl0h7dRfe/v
	 g0TlQ0DVutzzTM231nDXhrwF5ExAeQIQk+Rl5yTgciCtvg8k+0CIm4jRnXTbajpQBJ
	 JxrbTCmtqQsIchh0wVI7OzZlgUMg2hprs2Rl1b85q87SCXf1ZtJxJ0GaEgZBSHTgbs
	 utijYwBhUj9FjGnlaSyqHMC/AvV86ODMUfbKzOwN5zBE3IZEPfrQARO0c/LApuh2ib
	 dlzYINVxBX/cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 2/2] bpf: Invalidate dynptr clones in every call
 frame on release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260829033701.2365648-1-xyx2021@mail.ustc.edu.cn>
References: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
 <20260829033701.2365648-1-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 04:07:12 +0000
Message-Id: <20260829040712.B1B511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dynptr slices belonging to a cross-frame clone are not invalid=
ated if the subprogram containing the clone returns before the original dyn=
ptr is released, leading to a Use-After-Free on ringbuf memory.
--

commit f98ee666f54971a2824f38f254185708f60a777a
Author: Amery Hung <ameryhung@gmail.com>
Date:   Sat Aug 29 03:37:01 2026 +0000

    bpf: Invalidate dynptr clones in every call frame on release

This commit modifies unmark_stack_slots_dynptr to iterate over all active
call frames rather than just the current frame when invalidating dynptr clo=
nes.
It also adds a cross-frame clone regression test.

Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 62fa2895a9205..fa88e7a35f901 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -1026,22 +1026,31 @@ static int unmark_stack_slots_dynptr(struct bpf_v=
erifier_env *env, struct bpf_re
>  	WARN_ON_ONCE(release_reference(env, ref_obj_id));
>  	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
> =20
> -	/* Invalidate any dynptr clones */
> -	for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> -		if (state->stack[i].spilled_ptr.ref_obj_id !=3D ref_obj_id)
> +	/* Invalidate any dynptr clones, including those in other frames.
> +	 * Do not turn a failing release_reference() into -EINVAL: that
> +	 * rejects legitimate cross-frame single releases on 6.6/6.12/6.13.
> +	 */
> +	for (frm =3D 0; frm <=3D env->cur_state->curframe; frm++) {

[Severity: Critical]
This isn't a bug introduced by this patch, but does this loop restriction f=
ail
to invalidate slices belonging to clones in frames that have already return=
ed?

If a subprogram (Frame 1) clones a ringbuf dynptr, the clone receives a uni=
que
clone->id but shares the original ref_obj_id X. If Frame 1 then creates a s=
lice
from this clone via bpf_dynptr_slice_rdwr, the slice sets dynptr_id =3D clo=
ne->id
but leaves ref_obj_id =3D 0.

If Frame 1 spills this slice pointer to the caller's (Frame 0) stack and
returns, the clone goes out of scope without an explicit release. When Fram=
e 0
later releases the original dynptr:

release_reference(X) executes, but does not clear the spilled slice because=
 the
slice's ref_obj_id is 0.=20

unmark_stack_slots_dynptr then executes, but since the subprogram returned,
curframe is 0. The loop only checks Frame 0 and fails to find the clone bec=
ause
Frame 1's stack is already gone.

Since it never discovers clone->id, invalidate_slices_of_dynptr(clone->id) =
is
never called. Does this leave the spilled slice on Frame 0's stack fully va=
lid,
allowing an unprivileged BPF program to read or write freed ringbuf memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829032754.2324=
760-1-xyx2021@mail.ustc.edu.cn?part=3D2
