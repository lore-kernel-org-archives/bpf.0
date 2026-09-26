Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DA54704D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790399840; cv=none; b=ZMNoaEtUUpnY3XP8SXomwt0ybhFpS6OecWIRGZ3+9M7QchwfVNq58NJtqU5ukL/3kXSLGc8l2qbcOGuSM3P/KGHdg4vZabXhZqVn3/C0t6Cv1MDCyNmJm7Uo3kQRCsK9PKiPocPN8ZjJby6zlvP45+t1Kt9qlkcl0MUCMfWpL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790399840; c=relaxed/simple;
	bh=KkuGQqDXinLFklgPkspPaziI85Ma4abVQgjVHJk2WX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lmsOD4kIDGAgoMJLSbxC3b/YuNiCd2uhJNbH2/S6yduREFVSmsr8+EPznULw6XU9d+oYyHEPekgIiIotUcldqX2TAKxZRtyDzhqcW8yMh/lhX8oAXeS3b4aF8Mg7qV7/iY2Km6mXBMr3a6gfCSF3VSirTUdUZOO49oEHdrE4Bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czG+fBCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czG+fBCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E4B1F00893;
	Sat, 26 Sep 2026 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790399839;
	bh=r8Lu3AVK1Joko0T8xeT/7qxnWtirVh4dxeW+0YCYeT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czG+fBCO90z3MZTjrDXxrcrYpVoxpotB4/JVRtaNjvnu2PFvPdiZAPWjnhWoY5HZS
	 Eb8AwnKWYgl02Q+GDAlMrvT4qnyv8OBXPvqotBFud9BpXoS4ycm/C0YuSL/xOrzj2Z
	 WlSzeldzYxLhEfSKEXOaJZxa20PqsVJGCaLXjBV60tiK8Rrw4ZGhOfFE1b8ta7wPUl
	 x5CP48zku/FT3wzsyVzwprJqjb0WhZJMyrtzkveCbImwCTlTXJMpkqAV6uhWtkNH8X
	 b+aaXuaCGLiMhVQnCQ6B38DuUBB/ZJom8LsEfVJgwIp8yURHv19cWHqCJ2SOs/d1Ii
	 jSNkw8sObVrvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 08/21] bpf: Refuse a landing pad that does
 not resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926050047.2216836-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050047.2216836-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:17:18 +0000
Message-Id: <20260926051719.48E4B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: bpf_unwind bypasses resource leak checks when no landing =
pad is present
- [High] bpf: bpf_unwind_resume creates invalid ghost paths by returning to=
 caller's normal path
- [Medium] bpf: Speculative branches to landing pads bypass nospec recovery
--

commit 3aafeed4814ca53533c421881eb0f30857cc42a0
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Refuse a landing pad that does not resume

This commit restricts exception landing pads in BPF to only support cleanup
pads that resume via bpf_unwind_resume(). It adds checks in the verifier
to ensure that instructions are not reached both inside and outside a pad,
and it refuses unsupported program exits within a pad.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19197,6 +19202,7 @@ static int process_bpf_unwind(struct bpf_verifier=
_env *env, int *insn_idx)
>  	int pad =3D bpf_exc_pad_of_call(env, *insn_idx);
> =20
>  	if (pad < 0)
>  		return PROCESS_BPF_EXIT;

[Severity: Critical]
Does this early return in process_bpf_unwind() bypass resource leak checks?

If a program acquires a resource like a bpf_spin_lock and throws an
exception where there is no landing pad, it appears this directs the verifi=
er
to pop the state without calling check_resource_leak(), allowing the
program to leak the lock at runtime.

[ ... ]

> @@ -19450,6 +19461,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
>  				 */
>  				mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
>  				mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
> +				cur_func(env)->in_pad =3D false;
>  				return process_bpf_exit_full(env, do_print_state, false);

[Severity: High]
Could passing false to process_bpf_exit_full() here instruct the verifier to
continue at the callsite's normal return path instead of unwinding to the
caller's landing pad?

Because push_cleanup_pad_branch() eagerly pushed the caller's landing pad
with the pre-call state, returning to the normal success path might merge
the post-cleanup state incorrectly and cause a divergence between verifier
control flow and runtime execution.

>  			}

[ ... ]

> @@ -19578,6 +19590,12 @@ static int do_check(struct bpf_verifier_env *env)
>  			}
>  		}
> =20
> +		if (unlikely(env->cleanup_info_cnt)) {
> +			err =3D bpf_exc_check_insn(env, insn);
> +			if (err)
> +				return err;

[Severity: Medium]
When do_check() returns an error from bpf_exc_check_insn() due to a
speculative visit to a landing pad, does it bypass the subsequent
error_recoverable_with_nospec() check entirely?

If the verifier speculatively explores a dead branch targeting a landing pa=
d,
this might cause the verifier to fatally abort instead of properly recoveri=
ng
by inserting a speculation barrier.

> +		}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926050006.2213=
110-1-yonghong.song@linux.dev?part=3D8
