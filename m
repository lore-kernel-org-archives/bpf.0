Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC21EE7C6
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776398881; cv=none; b=BkAjy/1xg8cGcFlLpTTBPFDe/jZyI42zRbYN8nVqAxzEkGsvQsaTcf15UX6GwxDu1wHFGlalchDbxvXsyq+kC3kiEcXNff5Q2Y2mK+E9Xn2ERMr/c2KLOrCKXZ5tXkIaMlkm99HMipGGj3b41uPp21Y5aAGwty14YvOpzIMemAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776398881; c=relaxed/simple;
	bh=IrDYmuGwN/+bfVNXOCy5MywtddbDKdG3kKV7d4ZYCLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ewpuA2fzsiTDmTDDYypdyJ9UwII654e7JFHtzGJLtHg+maoFbQ2dYAR3ZWamQoqxx8USZIUoYeu777LQ063AxgqhzJv3y6vU43N6+f9n+VHaHWy1lCYt/0+NOO3OJ3mZxe4Ze1di7lnhTatdCmtJiSHVnTNIMmlFqFaOZxJlzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAwBUVBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAwBUVBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5345C19425;
	Fri, 17 Apr 2026 04:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776398880;
	bh=IrDYmuGwN/+bfVNXOCy5MywtddbDKdG3kKV7d4ZYCLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cAwBUVBwCfcxRF4WNXY9CCTbPtWnOihzZFCqwGeZVOJG1sN0vmN5PG9AKqFSIdlLq
	 INFPP8JH2Rw5fZDOlEeAyLixHGRN+Z9/I9OoxUFfxphthj6iyTvB+7JPE/oMKmZzPV
	 PBnhanFMKdAJGdGorUO25t+KKCmb9QDvqQ+k4xrcq3B8juPDNlu6NbVKsECQc+T1BL
	 gOhXexSexGk1zR/JXx7SXZ5ie6teDaPAcZKaeJtu362SjFbRBydUaatWECuiruWuzv
	 Juz+e8T/RS3t0OwzXw2lGH7c34UYybRsqA5HTIl6dc6TkkD9QpOQoL/GtZbV+kdfBo
	 MAZVPMn9dAQfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Reject stack arguments if tail
 call reachable
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034749.2630580-1-yonghong.song@linux.dev>
References: <20260417034749.2630580-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:08:00 +0000
Message-Id: <20260417040800.A5345C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] False negative allowing tail calls and stack arguments togethe=
r, leading to JIT memory corruption
- [High] State leak in verifier DFS causing false positive rejections of va=
lid BPF programs
--

commit df24720ae892549300f1910df635621a3875dbdf
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments if tail call reachable

This commit updates the verifier to reject BPF programs if they contain both
tail calls and stack arguments. This is enforced during the maximum stack
depth check traversal.

> Tailcalls are been deprecated. So reject stack arguments
> if tail call is in the way.

This isn't a bug, but there is a grammatical error here. "are been" should
likely be "have been".

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7a65b532e84a8..739c3127520c3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5662,6 +5662,11 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> +			if (subprog[tmp].incoming_stack_arg_depth ||
> +			    subprog[tmp].outgoing_stack_arg_depth) {
> +				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
> +				return -EINVAL;
> +			}

Looking at the earlier parts of check_max_stack_depth_subprog(), the local
variable tail_call_reachable only appears to be set to true when jumping
into a callee that has a tail call:

    if (subprog[idx].has_tail_call)
        tail_call_reachable =3D true;

If the main program (subprog[0]) natively contains a tail call,
tail_call_reachable would remain false, causing this entire check block to
be skipped.

Does this logic successfully catch the case where the main program itself
contains a tail call and also uses stack arguments?

If this escapes the verifier, the JIT might emit prologue tail call
instructions (pushing 24 bytes on x86) while calculating stack argument
offsets assuming no tail call pushes, overwriting the BPF program stack.

Could this regression lead to memory corruption in the JIT?

When the traversal pops a frame to return to the caller and jumps back to
continue_func, the tail_call_reachable variable is not reset to false:

    /* pop caller idx from callee */
    idx =3D dinfo[idx].caller;
    ...
    goto continue_func;

If the verifier traverses a subprogram with a tail call, returns, and then
traverses a completely unrelated sibling subprogram that uses stack
arguments, it seems it would incorrectly evaluate tail_call_reachable as
true and reject the valid sibling.

Is there a state leak in this DFS traversal that could cause false positive
rejections of valid BPF programs?

>  			subprog[tmp].tail_call_reachable =3D true;
>  		}
>  	if (subprog[0].tail_call_reachable)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D10
