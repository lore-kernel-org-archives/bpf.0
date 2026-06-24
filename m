Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B862ED154
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291845; cv=none; b=QnizoS/6oLblvYz9dAsdmEvUzP1PWo1PdTqC76hYGX5WRggk8Yfj0UMyuyXD1UtDWMZ7JdQEgpaIqnu4z9V23zrGEjOYWbxd6pJs8qKCCKueWUTqiZeIC7qN0LnYvINOi4hmlVmF87p2cZEer3AcBnOaB9tJuA9hT9UEHlsyp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291845; c=relaxed/simple;
	bh=Wu9WJJZgyI+rfQ8W+6h9KKgmRT/hflLU3cB0GJPuMu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVnGGlEVEzxQr+hrpxYYu2oSXa9413zv3qf0Zb6RF5/T+6VinOp7xPpZSAgvmKxqv7v8YsyLc2BACfanxR5PpYRSerakW7lgZuDN72+qPHYXM5ew+Jb+yA6nATAmPOAHakp9DIzOqSeyBMIiNiIm0SXGmEp09d2PHRtw8hTRt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2QMZvip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2QMZvip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99091F000E9;
	Wed, 24 Jun 2026 09:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782291844;
	bh=cc6aBqva9lfN+E1PZlkV1O08y5UXWm5b2m7y84dSCrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U2QMZvip6wGXQxgefDUKy12xQNypTD7R9bGsNVYT889qvnu4zCelal2VOcvK6OUkL
	 er0V+Yaqx2785TlfqBrnJycvccGX1Us+kiSTju83U6uLU1jkznhPScRnoFGhiHxWeI
	 7bzmfnIy/bF3CO/hy8TOtAc32d+tH8gw775LTFMR/kTgbaRIPSp3SOtGIfYKnKSq37
	 c1zXkpGgUX3SEfbtEeHGuwJUHIkM77cMjCOQz75ATc9MePVzPDgTps65vzYJ5pBxlH
	 9jTPv5ctlK60TOvci//ySxoP8nm13rQEGowNLTg/pVhL4R5RU+BnjhzdFh57J8UL/N
	 O1J/HcHGYWW5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Keep fastcall spills for helper stack
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624-f01-12-fastcall-helper-stack-read-v1-1-e0a86085ef77@mails.tsinghua.edu.cn>
References: <20260624-f01-12-fastcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn>
 <20260624-f01-12-fastcall-helper-stack-read-v1-1-e0a86085ef77@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:04:03 +0000
Message-Id: <20260624090403.E99091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] check_stack_read_fixed_off passes the wrong execution frame to che=
ck_fastcall_stack_contract
- [High] fastcall_stack_off minimum bound logic leaves longer fastcall patt=
erns unprotected
--

commit 8cfed53d5c0d5c6188360232f775d8b94b125599
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Keep fastcall spills for helper stack reads

The fastcall spill/fill rewrite is only sound while the stack slots used by
the pattern are not accessed outside the pattern. Direct stack loads and
stores already call check_fastcall_stack_contract() to enforce this.

Helper and kfunc memory-argument checks can validate PTR_TO_STACK reads
through check_stack_range_initialized() without applying the same contract.
When such a read overlaps a fastcall spill slot,
bpf_remove_fastcall_spills_fills() can still remove the spill/fill pair.
It can then shrink the subprogram stack depth even though a helper or kfunc
reads that stack address.

Apply check_fastcall_stack_contract() from check_stack_range_initialized()
after the concrete stack range is known. Zero-sized accesses do not read or
write memory, so leave the fastcall optimization unchanged for those.

Fixes: 5b5f51bff1b66 ("bpf: no_caller_saved_registers attribute for helper =
calls")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f7..592da530bdc5a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6874,6 +6874,10 @@ static int check_stack_range_initialized(
>  		max_off =3D reg->smax_value + off;
>  	}
> =20
> +	if (access_size)
> +		check_fastcall_stack_contract(env, state, env->insn_idx,
> +					      min_off);
> +

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this change I
noticed a pre-existing issue in check_stack_read_fixed_off() with how it
passes execution frames to check_fastcall_stack_contract().

In check_stack_read_fixed_off():

	struct bpf_verifier_state *vstate =3D env->cur_state;
	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
	...
	check_fastcall_stack_contract(env, state, env->insn_idx, off);

Here, the local state variable evaluates to the current execution frame
(the callee), instead of reg_state which is the frame where the stack memory
actually resides (and can be the caller).

If a BPF subprogram is passed a pointer to its caller's stack and reads a
stack slot that overlaps with a fastcall spill slot in the caller, couldn't
the fastcall bounds be checked against the wrong subprogram's metadata?

Could this cause the verifier to fail to disable the fastcall rewrite for
the caller, resulting in uninitialized stack memory reads when
bpf_remove_fastcall_spills_fills() removes the caller's spill instructions?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential problem in
mark_fastcall_pattern_for_call() with how it tracks fastcall stack boundari=
es:

	subprog->fastcall_stack_off =3D min(subprog->fastcall_stack_off, off);

Because off is a negative stack offset that moves closer to 0 for longer
patterns, using min() incorrectly shrinks the protected stack region to the
upper bound of the shortest fastcall pattern.

If a BPF subprogram contains multiple fastcall helper patterns of different
lengths (for example, Call A with 1 spill ending at offset -24, and Call B
with 2 spills ending at offset -16), couldn't this expose the upper spill
slots of any longer fastcall patterns?

If a program performs a direct memory access to the highest spill slot (-16)
of the longer pattern outside of the fastcall block, the verifier might
mistakenly preserve the fastcall optimization, removing the spills and
causing uninitialized memory reads at runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-f01-12-fas=
tcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn?part=3D1
