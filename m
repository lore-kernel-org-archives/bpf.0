Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E281EEA3C
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778815416; cv=none; b=SBGNVY0DkXePCiiaN1nUawI5G2C98QPTfzJpkp7OPenBte7ZM6wLchlB0Foq/xzj68xVKSI4NI59xr/k+3ZeC1H19JGlbHInTC8kse7XN9PxZjwByO5oocUoR9NmYpgJ1BmLyyOfHQPZ3DTKvHYHWVL1sC7e1V9QNlP7MJ2byMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778815416; c=relaxed/simple;
	bh=BD4f86QQLnEjAXXVIPExgvSUEMdZwOV2t4WyFbQkx7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=crAGh9J/1DiG3S9nrB2N4mD5/Esm6ws//kAtlt1HRw/DqXloT8OaCpvM6ghLWuPNbTPL6ZvDnjfOvg5r8fycbcpcBUwAZybchmEz/JpP9YqCRtCGK+LoyYyn8u7DqmsHj12Szz8ilMAhad0onCONRAMPvFhb8guw4WnI5jvk0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg+UStfu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg+UStfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FE4C2BCB0;
	Fri, 15 May 2026 03:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778815415;
	bh=BD4f86QQLnEjAXXVIPExgvSUEMdZwOV2t4WyFbQkx7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Pg+UStfumNhGeHdoh5PRyiAInJRrDUg8NT8fM4OKnSn7AnMgnHj/9SThhARGJFE7A
	 VrjPwH+X+67WO91AOu96y44vJ5UpKlz90fAAnOBvpgMYAQPWlpCd9xQed21uKkSLHL
	 xeXVljsevsUSIB0RmF6QkovNiZbLfAYZaRBVA5J57ieiRBUsGIil/aVsohGVMSzV/m
	 Tfa8GP+MhY0p/Bi7Uo4TgXSqRzmcwo9DaugNY+/mjD6ydMlpYHbQGc+vfRsHcfeDfB
	 xU92+99IlK2lvffcvkmNsorOlpykBPrv6/d0/2uzLG/Y6VKxfr5/NNQcnSEOp9seNc
	 LoR5Nz0Fl1OBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 15/25] bpf: Reject stack arguments if tail
 call reachable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045109.2392108-1-yonghong.song@linux.dev>
References: <20260513045109.2392108-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 03:23:35 +0000
Message-Id: <20260515032335.C4FE4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Order-dependent verification allows invalid programs combining tai=
l calls and stack arguments to bypass checks.
- [High] Exception and async callbacks bypass the new stack argument and ta=
il call restriction.
--

commit 807349b213e40b7418c45dc1ae2cee5695bf101d
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments if tail call reachable

This patch updates the BPF verifier to reject programs that combine tail ca=
lls
with stack arguments, as tail calls are deprecated. It hooks into the call
depth traversal to fail verification if stack arguments are present in a
call chain that can reach a tail call.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a363811aec7a0..47df3f40a71cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5267,14 +5267,23 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>  	 * this info will be utilized by JIT so that we will be preserving the
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
> -	if (tail_call_reachable)
> +	if (tail_call_reachable) {
>  		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
>  			if (subprog[tmp].is_exception_cb) {
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> +			if (subprog[tmp].stack_arg_cnt) {

Can this check be bypassed depending on the order of subprogram calls?

If a main program calls subprogram A (which uses stack args) and then
subprogram B (which has a tail call), it seems subprogram A might be
evaluated first when tail_call_reachable is false, bypassing this check.

When subprogram B is evaluated, it sets tail_call_reachable to true,
which propagates to the main program.

When the main program finishes, only the main program's stack_arg_cnt is
checked, allowing the program to pass verification.

If the calls were reversed, subprogram A would inherit the true state and
be correctly rejected.

Does this sequence allow invalid programs to bypass the safety check?

> +				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
> +				return -EINVAL;
> +			}
>  			subprog[tmp].tail_call_reachable =3D true;
>  		}
> +	} else if (!idx && subprog[0].has_tail_call && subprog[0].stack_arg_cnt=
) {

Does this fallback check miss exception and async callbacks?

By explicitly checking !idx and subprog[0], it appears to assume the main
program is the only call graph root.

Since exception and async callbacks are verified independently as their own
root programs (where idx > 0), would a callback that contains a tail call,
uses stack arguments, and makes no BPF-to-BPF calls bypass both the primary
tail_call_reachable check and this fallback check?

> +		verbose(env, "tail_calls are not allowed in programs with stack args\n=
");
> +		return -EINVAL;
> +	}
> +
>  	if (subprog[0].tail_call_reachable)
>  		env->prog->aux->tail_call_reachable =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D15
