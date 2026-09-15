Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256F32ABCA;
	Tue, 15 Sep 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434950; cv=none; b=n5pmJeXA3GWagKO3J8RbW1VL/KXkeKWDDeajssdyMSMKJDWRJAjZn5oeLc9FG1mqTOrlTaWn5rCoGxtqgLWy10TJCKB+1u3g5DrhWLiWjN4lj0kyvLrQOBEMlAIkEc1/OJS9oW4n0i4+9wTOImH2xQUSaSCVuR18lVw2KkZZcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434950; c=relaxed/simple;
	bh=M6UZ4nkQXKWjmgCELjX8YqXnH6hl1ZT4P+zjm8mWddY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EdIBU6ubwfTEKmHEQ3WwTHdkCgJuo1nkN5KZXDl7yQ73PA89aHh9P4SX/3R9lpxCz9v7nqy1VqG8YDvoHRxfpVYrL+ar88RkmIrYp1KGMBhfbQi+sWrbECeZpqMrdi+M99mN5r3zq6D1mKZCMbQI9PZs+rUTUrGYZHQu8HgtrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEm2GFMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEm2GFMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA401F000FF;
	Tue, 15 Sep 2026 01:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789434949;
	bh=OarrLH16syLJAovCuR0kGOue/L2rDMdZ+vfPBEjOaeY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AEm2GFMsRU2yRAkMzCZQ8JlS7MwjfmyFdgaMS6y0atza97U9e/90phj+lWE1OZPzn
	 sx2lh5Rpqr1LN4rLLnpNuCtGjIEk/qgGMvv6r/usjuVs7Zp0+9eX/WaMzOM03Px8jf
	 PRiSXKWqEKtBAxmmg8IeHoOgHnF6v3EvwgPtK/K6NgbEp9Eipa0lJ/bQeeKqGxvfrp
	 GtnE55xI5YWHKLfe7z/r/9SOBQi55asDL60+1Fzzm+TU6h5igFJmBaxmxO2026qeQn
	 YNTO97WRlTUD78YboKBCaxiPii8O2ZVTeY+K+cznD6asciQd4p0HIu6SFQw00V+7oH
	 9MSlfxoi6Px/Q==
Content-Type: multipart/mixed; boundary="===============0161519070531051856=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d03c668fa32e27b030d7dbb90e39ac6142970c5d204ec30ed9b3ab82a37d157b@mail.kernel.org>
In-Reply-To: <b6782cd33f9ccc6265b0b2140cf1f68d@kernel.org>
References: <b6782cd33f9ccc6265b0b2140cf1f68d@kernel.org>
Subject: Re: [PATCH bpf v2] bpf: Keep generic __uninit kfunc arguments live
From: bot+bpf-ci@kernel.org
To: tj@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,ameryhung@gmail.com,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 01:15:48 +0000 (UTC)

--===============0161519070531051856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep generic __uninit kfunc arguments live
>
> Stack liveness models a kfunc's __uninit pointer argument as a pure write:
> whatever the buffer holds before the call is dead, and 2cb27158adb3 ("bpf:
> poison dead stack slots") poisons those slots at every checkpoint the path
> visits before the call. Argument validation disagrees. Only dynptr arguments
> honor __uninit. A generic fixed-size buffer goes through check_mem_reg(),
> whose read pass requires every byte readable. The two rules meet at the call
> and the poisoned buffer is rejected with "slot poisoned by dead code
> elimination", even when the program initialized it.
>
> Every kfunc with a generic __uninit output argument is affected,
> bpf_ksock_create() through err__uninit and sched_ext's scx_bpf_cid_topo()
> through its output struct. The rejection needs the buffer's slots to be
> allocated and dead at a checkpoint, for example on the second iteration of a
> loop around the call. Before e566701b9b0c ("bpf: Check fixed-size mem args
> of helpers and kfuncs the same way") kfunc arguments could read poisoned
> slots, so the call passed, but the slots stayed poisoned and the program's
> next read of the buffer was rejected instead.
>
> Restrict the liveness write-only exception to dynptr arguments, where
> validation accepts uninitialized output. A generic __uninit buffer stays
> live and is never poisoned, and validation keeps requiring it to be
> initialized. Add a selftest with a scalar output buffer and a checkpoint
> between its initialization and the call.
>
> v2: Rebased on bpf/master.

This isn't a bug, but could the 'v2: Rebased on bpf/master.' note move
below the --- line so it stays out of the git log?

> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> Cc: stable@vger.kernel.org # v7.1+

This isn't a bug, but since this targets bpf, would it be worth dropping
the Cc: stable trailer and instead noting the v7.1+ backport request
under the --- line, as bpf_devel_QA.rst asks?

> Signed-off-by: Tejun Heo <tj@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddba53eaa3331..310a3c6339a98 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13588,7 +13588,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
>  	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
>  	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
>  		return -size;
> -	if (is_kfunc_arg_uninit(btf, &args[arg]))
> +	/* only dynptr validation accepts an uninitialized __uninit argument */
> +	if (is_kfunc_arg_dynptr(btf, &args[arg]) && is_kfunc_arg_uninit(btf, &args[arg]))
>  		return -size;
>  	return size;
>  }

Amery Hung raised a design concern on v1 about whether restricting the
liveness exception to dynptrs is the right fix.

The reviewer suggests that the underlying issue is that generic argument
validation doesn't honor __uninit, and that generic __uninit arguments
should behave like helper output buffers: generate MEM_UNINIT | MEM_WRITE,
validate as write-only, and mark the written range initialized after the
kfunc call. With that approach, bpf_kfunc_stack_access_bytes() could
continue returning -size for generic __uninit arguments.

The current change instead makes their previous contents live and requires
callers to initialize an argument explicitly declared uninitialized.

Was this comment considered for v2?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34913753963
--===============0161519070531051856==--
