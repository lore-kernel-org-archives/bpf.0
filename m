Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DF360EE9
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781905617; cv=none; b=ZIhkfclgWU9ZkHB4hEfVBkmmWk+Gd0tRGs/z4clJC2mWpGsel/qdh3oyuB0DUfp5fn4tBoy0zPwcNvgJRWyZl8d30ZG9Y4jXYa+zHXvHbv1Ge2h28jy5owYtXszI1Q4CCtzTowkX15U3TEACV8RXi3zGuTJMbIM7nqYy3mziZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781905617; c=relaxed/simple;
	bh=m+pd8aY+g6NFV3hyIWXIOQgu+1bUiDnEXOabj7I/26s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PKlwT+XlfgL5idRmhcjC5N63R+9nEZU3QYFFSK01d/BjsS0U9Wd6XsDrUlQkWg6Opyc1qIboGM15vpn8H45Z42pKoj7iGgtKRQmBZcq34Nepqi8XRVOg2vbbxtiOmE2ROU8pcg3lFNmKj//taro08EK2/tW4XlKhraiEhzpqMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdtzaze+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdtzaze+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8E71F000E9;
	Fri, 19 Jun 2026 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781905616;
	bh=TBx+nuOWSkLajkWRTzPaUemlOv6y2m7zigc6r7KeJhA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jdtzaze+6OrcJbAANYHIMR0RicqYgrjOiAhviGRkivAHO/F5m2bLZXBMz68qwQH55
	 yhKeGTlJ4C64F4my8vtpVQiIKedGhoIksLsszlTGvpiu/pViikq8hhLTibFT2shFUx
	 N2qbMGy0ODboB2pESlaVcvEFgXs0EQ1Ryhiv8GwRT2681dSz8ZOh9/m5nRBoC9pgeZ
	 awBfbiRflJxjuv+F5Oeau50iY1cddfNnDYdPUDW0m1KDhtuoUCz/oS8yQSrIPYTYMg
	 yolE3PL4sU5SzPv+bhokpdK0hfidMbw5ZUsXwVVBcS8/jBXCogZUtSbWH4zq5E0a7e
	 oBh2HgvaPmZqg==
Content-Type: multipart/mixed; boundary="===============8987436315808732563=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8db1d6bf81b3964db585fb2bc6e5ce39e7532102a033d892e4f19913096d1526@mail.kernel.org>
In-Reply-To: <20260619205934.1312876-10-memxor@gmail.com>
References: <20260619205934.1312876-10-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/17] bpf: Report Memory Safety bounds errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 21:46:56 +0000 (UTC)

--===============8987436315808732563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index d6e858cd39f2..fea7731d431c 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -124,6 +124,13 @@ enum bpf_diag_invalid_deref_kind {
>  	BPF_DIAG_DEREF_INVALID_PTR,
>  };
>
> +enum bpf_diag_mem_bounds_kind {
> +	BPF_DIAG_MEM_NEGATIVE_MIN,
> +	BPF_DIAG_MEM_MIN_OUT_OF_RANGE,
> +	BPF_DIAG_MEM_UNBOUNDED,
> +	BPF_DIAG_MEM_MAX_OUT_OF_RANGE,
> +};
> +

This isn't a bug, but Eduard Zingerman suggested in his review of v1
that the enum might not be necessary. His comment was: "Nit: here as
well, I'm not sure the 'enum' pays for itself." This is a minor
stylistic concern, but it was not addressed in v2.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c5f24528071..af04709c5178 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3896,9 +3915,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>  					if (type == STACK_POISON) {
>  						verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
>  							off, i, size);
> +						return -EFAULT;
>  					} else {
>  						verbose(env, "invalid read from stack off %d+%d size %d\n",
>  							off, i, size);
> +						bpf_diag_report_stack_read_uninit(env, off, i,
> +										  size);
>  					}
>  					return -EACCES;
>  				}

[ ... ]

> @@ -3951,9 +3973,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>  			if (type == STACK_POISON) {
>  				verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
>  					off, i, size);
> +				return -EFAULT;
>  			} else {
>  				verbose(env, "invalid read from stack off %d+%d size %d\n",
>  					off, i, size);
> +				bpf_diag_report_stack_read_uninit(env, off, i,
> +								  size);
>  			}
>  			return -EACCES;
>  		}

The STACK_POISON case now returns -EFAULT instead of falling through to
the existing -EACCES. This appears to be an undocumented behavioral
change unrelated to the diagnostic feature.

The commit message states this patch augments failures "while preserving
the existing terse verifier messages for compatibility," and no
diagnostic report is emitted in the STACK_POISON branch (the new
bpf_diag_report_stack_read_uninit() call is added only in the else
branch).

This return code change has a concrete consequence. In do_check(),
error_recoverable_with_nospec(err) && state->speculative decides whether
a failed instruction on a speculative path can be salvaged by inserting
a nospec barrier.

error_recoverable_with_nospec() returns true for -EPERM/-EACCES/-EINVAL
but not for -EFAULT. So a poisoned-slot read that occurs on a
speculative path used to be recoverable (return -EACCES, insert nospec,
accept) and is now treated as fatal (return -EFAULT, reject).

A program that previously verified could now be rejected.

This also makes check_stack_read_fixed_off inconsistent with
check_stack_range_initialized(), which handles the identical "slot
poisoned by dead code elimination" condition and still returns -EACCES.

Should the STACK_POISON case continue returning -EACCES to preserve the
existing error recovery behavior?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27848712882
--===============8987436315808732563==--
