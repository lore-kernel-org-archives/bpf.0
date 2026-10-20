Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539790;
	b=UiAvKaf9+dt+6Exf6AxAiopBl8BMtlEIx8CTixA2MAv6HyPHRGIPGiyYDPGqohs7m7nV
	 k6wMNmLP7WrSaRGcZ8n/5MAFU4ifRGl5xwW50+paoP/dt2EypeoFhC1mFFZlC5iGtNOts
	 Sx4QfuiwNmWSHQVq/KytY6pFbaWsX0Vljn0YEBOyyatdWYyo3NPivt+6vsZe6PXYRQtcE
	 SwoZIdDYxkJKTbtQTYNVWnRpcH88v3L+HHYRrB2pN90KVFYdEao4RpV4mHEEjdVVz5vun
	 6/BYLRfSItt4ainle5+0M4gdDMXqTChCvFU/+sC4ShbW8GroFNbo1Pkc664YJx3aY/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539790;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jCX56DEdLRkETwAbOPNVf6AbN1fTNUWcvGlNh/WZLBI=;
	b=gxyKkaN8DteVOwEJOyJDKS0txh+50gz8FOtWFBJKQHr8qSuo9vglwuxvKb1B5yRhgox2
	 BmNsobpzU8gyS9AtfIeskyOyqOIP3ab+f9E9mWA9EWdLrFiuHES9pIL3rb0UhD5ugryqt
	 vGqVH0WDw5NMzt/wnFC7lp1N24h7MvV/JhjJbKAmbj7VQcG788e0cjVjI+vHK7enQhzjW
	 LAMUiIqTTE69Qe6y/h/PM/l1foqKfcq55cHYkNtP0HCreBXGaXslyHg5X1cKORN0lP2PI
	 oc/43MMfvr5n/+IqN2gKfkhjUk/tkLMRU2lmv3yn5Jw66VVe2NWJqwQuzBnxeNxjSzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e38qL+Ga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA3606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e38qL+Ga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F441F000C9;
	Tue, 20 Oct 2026 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792539789;
	bh=jCX56DEdLRkETwAbOPNVf6AbN1fTNUWcvGlNh/WZLBI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e38qL+Ga2COx/S0w5YTTq0p02fSv3REvM6/ZEof3eG/fuvQaqtkObQSm7F6v9vikM
	 27YDReVJhWVRaLNY38uxQsVWyGG4dbDlt+0BesthXw1NijrZwOCbr2YItOTSrLZkU7
	 Umqr4QyjYiDzShiYqnho8Qe6ErA3cVZotLyj+TyaFFy5KCfAQyFdD8QJj3SItrfmTS
	 qjecMfwlGRWneNC1yFVL/eRdHmGpwIxEljekgcv5s2jVS6HYHzvtOJ0yRLBBCpEnEI
	 tiapPeaKB7mTawACNMMB7FQS1Mg2THsxDF7lfuU+SOpNfuxGeTWf4uFDt01LL5L4pp
	 eHGbW/drx2R9A==
Content-Type: multipart/mixed; boundary="===============5221256935164056351=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1cc7789274018beba70932ec8806130f1ff07eed56b62e0afbed41385630e4b7@mail.kernel.org>
In-Reply-To: <20261020231942.2568163-3-alexei.starovoitov@gmail.com>
References: <20261020231942.2568163-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Reject unwind_goto and unwind_exit in offloaded progs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 23:43:09 +0000 (UTC)

--===============5221256935164056351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject unwind_goto and unwind_exit in offloaded progs

TL;DR: Code looks correct; only the commit message is questioned: "nobody
looks at jit_required" holds just with CONFIG_BPF_JIT_ALWAYS_ON=y, otherwise
offloaded progs were already rejected, so the changelog should name the
configuration.

> bpf: Reject unwind_goto and unwind_exit in offloaded progs
>
> A prog with unwind_goto or unwind_exit has to be JITed by a JIT that
> supports them. The driver JITs an offloaded prog, and nobody looks at
> jit_required there.
>
> nfp rejects unwind_goto in nfp_verify_insn(). netdevsim takes everything.
> Nothing runs such a prog, but it's not jited for bpf_insn_prepare_dump(),
> which takes unwind_goto for BPF_CALL_ARGS and shows it as a call.
>
> Fixes: a2d274771321 ("bpf: Add unwind_goto and unwind_exit insns")
> [ ... ]
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This isn't a bug in the code, but is the statement "nobody looks at
jit_required there" accurate for all configurations?

bpf_prog_alloc_no_stats() sets jit_required from the config option:

    fp->jit_required = IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON);

so with CONFIG_BPF_JIT_ALWAYS_ON=y the flag is always 1 and carries no
information.

Without CONFIG_BPF_JIT_ALWAYS_ON, bpf_fixup_call_args() is still called from
bpf_check() for offloaded progs.  Its jit_requested branch is skipped for
them:

    if (env->prog->jit_requested && !bpf_prog_is_offloaded(env->prog->aux))

but the #ifndef CONFIG_BPF_JIT_ALWAYS_ON block still runs:

    if (prog->jit_required) {
        verbose(env, "program requires BPF JIT compiler but it is not available\n");
        return -EINVAL;
    }

check_unwind_insns() sets jit_required = 1 before bpf_fixup_call_args() runs,
so without ALWAYS_ON an offloaded prog with unwind_goto or unwind_exit was
already rejected, with -EINVAL.  In that configuration this patch only
changes the errno and message to -ENOTSUPP and "JIT does not support
unwinding".

The code change itself looks correct, and the gap it closes is only
reachable with CONFIG_BPF_JIT_ALWAYS_ON=y.

Could the changelog say which configuration is affected, for example
"nobody looks at jit_required there when CONFIG_BPF_JIT_ALWAYS_ON is set (it
is then always 1)", or note that without ALWAYS_ON bpf_fixup_call_args()
already rejects the prog with a different error?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39515082332
--===============5221256935164056351==--
