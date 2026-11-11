Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431265;
	b=MwoVdMFBq9ZhLfsrAL4QYXzYUgXuBz+d7AjhM/GyK7940u2sJNPrlScIha2BFG1TkTvo
	 qmhyA9b+JXdKhGCuTT/VOofUtwUU9X1rn0Gkq97wA2C0f/r671qbpeV0Xtta75DdZRK3B
	 5vKEuOLskNjDLKZ+CM/ADAPY0KyAHhfkjrlwDAYiaWjKvl+cqaxT2XTfpbpRwCFXU0RlB
	 ieY4tTlEYKPk9c+m7fVQ8vcJmV2cjrUmheDAKMCEDcIVeh34ltcNdlMZYWEYDcdo+sr8B
	 CYgYhkFYfJV1DOdK+KCJGJjdn67ReeOuP6Rq6UYQbcY9kGbrlkrYidaG4KKHr7cf9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431265;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=iHRfaUMaF9+HPopnCYvBfWB4pSV60uRmTbsTXs8MRao=;
	b=ZZK3aLZU3SnO0PLNOOqgQ06yZyCgxKyshjI0JK8CgSvsI+ruJVOkFAo7nXDKsxu+2Yqr
	 Rjg2YzfVK3JSo3rhRAauWrSx8W0a1t5DokKhTrD6FITwRUT8pagTrCdAiXPjsRbqlXg4S
	 OoF2u6lc0e+GnnMiLrvt2y0A6URdUpVar7tJeFqPxLD1OFntTTqCpJw9qyplGtOiPavzV
	 F8c0r3NEzuK2dckblKqEY0cxl7WYVX+iLWRaEwXzWGKxHcg/6PZd2+KtEmYeUpMWqEbGI
	 hiEjVKomsYXz0lUggN7kW/VmAEVknppatjJ4n+xdY3Twxv72Ts4gVR9zrcyyJ+ItWHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjXFBRZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB0606A321;
	Wed, 11 Nov 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjXFBRZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D251F00A05;
	Wed, 11 Nov 2026 21:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431265;
	bh=iHRfaUMaF9+HPopnCYvBfWB4pSV60uRmTbsTXs8MRao=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NjXFBRZPSz2s/OchCd97iODi1xMLRzQXfq+TyxSt6n4qMD0oTZi0ISzTIvpCgK79W
	 OJfYlLbNOwHFPDZLJfAjEOVg3am++IeNuzYxsxQKUi9lEWiReabYasEyvmRCdcT2gi
	 CgSbJBL/M39d7TEZPk9DIgu8R8iIMNzMZDC4I+/u2DTLglBE/UjQpvzXg+iX1ftoGI
	 c9v6emhTfbffmdrXgfeZKmuxKcXUzcjfddkn5wVP/RF3WYBYax4SRwEUuYwEo9A65S
	 ZvApQ+qb+0B4qj0xBzH6YzqXwZZqqTfivrT42Sera508UHcBqIBA8iWh18cCpJAl75
	 +6slKWtFNwXXA==
Content-Type: multipart/mixed; boundary="===============1657072974706563692=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c7755fa3015ba1f5aa28207ec05173315ebcae0e662b07d78a084c8aeeb2e26a@mail.kernel.org>
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-1-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-1-9d8f6b952ad2@sentinelone.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Avoid per-CPU private stack in preemptible tracing progs
From: bot+bpf-ci@kernel.org
To: mikeba@sentinelone.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,jp.kobryn@linux.dev,linux-trace-kernel@vger.kernel.org,linux-kernel@vger.kernel.org,mikeba@sentinelone.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 21:07:44 +0000 (UTC)

--===============1657072974706563692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Avoid per-CPU private stack in preemptible tracing progs

TL;DR: Selftest nits only: renamed "No private stack" tests in
verifier_private_stack.c keep old "private_stack" function names, and one
comment still describes the old mixed case.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> --- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c

[ ... ]

>  SEC("raw_tp")
> -__description("Private stack, run, exception in main prog")
> +__description("No private stack, run, exception in main prog")
>  __success __retval(1)
>  __arch_x86_64
> -__jited("	movq	%rdi, -0x200(%r9)")
> -__jited("	movl	$0x1, %edi")
> -__jited("	pushq	%r9")
> -__jited("...")
> -__jited("	callq")
> +__jited("	subq	$0x200, %rsp")
>  __naked void private_stack_run_exception_main_prog(void)
>  {

this isn't a bug, but would it be clearer to rename
private_stack_run_exception_main_prog() to match its new "No private stack"
description?

The same applies to private_stack_run_exception_sub_prog() and
private_stack_subprog_throw().  Elsewhere in this file the function name
follows the description, for example no_private_stack_kprobe(), and
private_stack_returns() was renamed to big_stack_returns() in
verifier_unwind.c when its description changed.

[ ... ]

>  /* Only the frame of the main prog counts, and it has nothing pushed at the call */
>  SEC("raw_tp")
> -__description("Private stack, run, exception in subprog, no private stack in main prog")
> +__description("No private stack, run, exception in subprog with a large stack")
>  __success __retval(3)

Also, the comment above no_private_stack_run_exception_sub_prog() still
describes the old mixed case, a main prog with nothing pushed at the call.
Now that neither frame has a private stack, should it be dropped or reworded?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43092697553
--===============1657072974706563692==--
