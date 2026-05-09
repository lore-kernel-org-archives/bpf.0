Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3315B0EC
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290928; cv=none; b=EQhC2e1D9+gBHblmgsqdkiVC7FdkLH0kWKiRkp3D6PSouBW9keGIgSdKS378vJpqo5/rezF1EwoQ8Vf2OfnE0vdPR4Yld0lcsqh+nRAOQS2JO0YEL4zNnHlVNV3qlEuhKeF6evrj/v2te14DiKz2EM9bIuTSU7iv+o7FIUAK1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290928; c=relaxed/simple;
	bh=UlQvFmwoLr/CHDN8VP5pHyeX75dJgfSNEVhI+qxlVvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kcYjPlKahr5SVPxsMZ4mgSrz9wGlPjQjZmyA+37rEdpG1/l0agku99hVuZXter5Fztk6fKpYPJsrPxEYcVTttEmFLWb2pReFMepNbhWJzunXI98zU98A5kp8UbMl5XCalNtJES7isZ5CL2ouSqOEYx0lSzynjBwAbQca+n8klaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWAzdtx3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWAzdtx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D2DC2BCB0;
	Sat,  9 May 2026 01:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778290928;
	bh=UlQvFmwoLr/CHDN8VP5pHyeX75dJgfSNEVhI+qxlVvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tWAzdtx340dPs0YbLTnFdwiaR2rH6MgdUjO2wrwwHZQUihEMNg+sLCWbamUaPgkkX
	 UTP6yn20wlEvvAzWpcGfxqkFZRAiUZXPz5U3TaMQCZamZjl6IVJLu0bl7tGi9OfacL
	 /3t9YNdHpmKz2eNKuA8Fb5qiNNO3ns40uhd3ZGSoztN/KpHFSX3HH2dUOosgLrYGXL
	 GQYwO956XPZMdk9T71gVBT6xtsL95wJcF2vA1nDVr+nP3Gvk821g64q3i6RvLm4YIn
	 oImY4fF9CcjdR1L5RhG32KKcXPN3gWz/uCxCCt8P9zme+FoheYiB8J1JEJwMwKCmys
	 RAy70NcE19TVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/23] bpf: Reject stack arguments if tail
 call reachable
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213054.1131645-1-yonghong.song@linux.dev>
References: <20260507213054.1131645-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 01:42:06 +0000
Message-Id: <20260509014207.A6D2DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Order-dependent DFS logic and incomplete fallback checks allow byp=
assing the stack arguments restriction and cause false rejections.
--

commit d6cf15a73bfea82a8d40934257b79e361027a9b1
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments if tail call reachable

Tail calls are deprecated and will be replaced by indirect calls
in the future. Reject programs that combine tail calls with stack
arguments rather than adding complexity for a deprecated feature.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b6d07f7a52cdf..95fe21d05c100 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -5270,14 +5275,23 @@ static int check_max_stack_depth_subprog(struct b=
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
> +			if (subprog_has_stack_args(&subprog[tmp])) {
> +				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
> +				return -EINVAL;
> +			}

Does this create an order dependence where the verifier might falsely reject
valid programs?

If the main program calls a subprogram with a tail call, the
tail_call_reachable flag becomes true. If the main program subsequently cal=
ls
an independent subprogram that uses stack arguments, the flag can leak into
that branch, causing the program to be rejected. Would reversing the call
order cause the same program to pass?

>  			subprog[tmp].tail_call_reachable =3D true;
>  		}
> +	} else if (!idx && subprog[0].has_tail_call && subprog_has_stack_args(&=
subprog[0])) {
> +		verbose(env, "tail_calls are not allowed in programs with stack args\n=
");
> +		return -EINVAL;
> +	}

Does this fallback check miss nested stack arguments?

If the main program directly contains a tail call, the tail_call_reachable
variable remains false. If it then calls a wrapper function that passes >5
arguments to another subprogram, won't the nested stack arguments be missed
because the fallback only checks subprog[0]?

Can this also bypass restrictions for callback roots?

Since the fallback hardcodes !idx and subprog[0], if an exception callback
(which is verified with idx > 0) contains a direct tail call and uses outgo=
ing
stack arguments, it bypasses the main check loop because tail_call_reachable
is false. Will it also bypass this fallback block because !idx is false?

Could we decouple this restriction from the call graph traversal and global=
ly
check env->subprog_info for the presence of both features in the program
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D14
