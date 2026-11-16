Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811149;
	b=BSuRKZXCcYgFenLlfeypuGHb4RBj54oxK7pbtQTxZU0iDjxUevX0nkYC/WSRTfoXC+Jy
	 u7vEUr01vx//wrUMsWq8MCD0L22J9E6I4fdbmJelpcZ4ycASVwJr1DjdPS1JD5nf3ALJt
	 MyjbPhIVamn2Msw2f+lTGMFEQUzhb2RREsf5rtn2kpNjU0P9RbPxe9zi58iBAdlGCJCq7
	 Jgak1U/IGBR5OnztBOozfYvqDtgYh6S1pv7bX8nB+2VA1BqkZPDQOkexDsWFOfyQ02nC/
	 pI5ivwdWo9sp5VN5wsJXm+Yy2jtvMylsVC9AXC9OEcZ+gv7BF04dY3hI5ee6eo/Xb9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811149;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=pvyMXpfJBKkCEmnUGv/1R5dDhXVIwxw3CIwYywFoWe0=;
	b=5hA78aTcATcDioABcxDcvoAJRDv/910U/YFlKINxzmOepznfh9EOfWWsrAn41ILXI0O8
	 5Cc+LSebf8cfptBkbb0kUGuDR+ctQDk4v5HuR18dj6H0XYGsqRPa6haxLfzWff7PFgWnj
	 ll1pIjqoQb+K2rwsKXL6YE8pWjVIhx+plj3hWD1N11NKJWMm8dJ7E88AB8HnSJL1RbObZ
	 RMaVp+Hrx6NlTpp0EtStnoYYWcUZPVWwqBl0//dYaecqs0WIBSIfJMxiBu4BJ6XH+im69
	 qD3stMDy0QQ6fp17xWy1dXMDVRYkYMS+uV4iQ8uSqpbtIDTQJVEI6iwkYj6WZNpHtWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdfHgI1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2F606A32A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdfHgI1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11301F000C5;
	Mon, 16 Nov 2026 06:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811149;
	bh=pvyMXpfJBKkCEmnUGv/1R5dDhXVIwxw3CIwYywFoWe0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RdfHgI1w9gZBc2SkeoL9b/aLZ3iFmY3Eix6fjc9TeCQNeb5uNbUKYODgFOkXgIUZi
	 X7V53RehD6YBOoybZJPpll+oISZo7mOlTZMAlCkPvjUR8L4WW33iVGXDFr1vFYZHWE
	 y76L7hRNJVtN4un2dn+jA2P2gvo3nyA0ALd420wBmojlylX+jokuaw3J/62ny4A/ya
	 LS3zHgup57GkT42zOqvXqLw2ejrN0dyFJ6Ma6AuiAWmNyuR6nTRPKQWtdRnSrbAAB8
	 dDQEaotEmgvSzgQMo90cCAnWTzFY2h//jAxIBuQHTJ457nIiETkZVoU0tmkPU6c6ok
	 1cncbLgoy4xcg==
Content-Type: multipart/mixed; boundary="===============3417982811272472308=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <aac6d679ff6c1ba3bd7c127c0c7597649e719366ba8fb14bde8a2e01e149a2f6@mail.kernel.org>
In-Reply-To: <20261116055638.4171529-21-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-21-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 20/21] selftests/bpf: Test programs above the old limits
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 06:39:08 +0000 (UTC)

--===============3417982811272472308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test programs above the old limits

TL;DR: Test issue: live_recursion expects "in a tracing program", which may
fail on archs without private stack support (s390x, riscv64, loongarch); it
may need the x86_64/arm64 arch gating.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_no_limits.c b/tools/testing/selftests/bpf/progs/verifier_no_limits.c
> --- a/tools/testing/selftests/bpf/progs/verifier_no_limits.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_no_limits.c

[ ... ]

> +void dead_recursion(void) SEC("?raw_tp") __success;
> +RECURSION(dead_recursion, 7)
> +
> +void live_recursion(void) SEC("?raw_tp") __failure __msg("in a tracing program");
> +RECURSION(live_recursion, 6)

Will live_recursion pass on architectures other than x86_64 and arm64?

check_recursion() only prints "in a tracing program" when
bpf_enable_priv_stack() returns something other than NO_PRIV_STACK:

    if ((bpf_enable_priv_stack(env->prog) != NO_PRIV_STACK ||
         env->prog->type == BPF_PROG_TYPE_KPROBE) &&
        !env->prog->aux->priv_stack_requested) {
            verbose(env, "recursive %s() in a tracing program\n", ...);

For a raw_tp program that needs bpf_jit_supports_private_stack(), which
only x86, arm64 and powerpc override.  Elsewhere the load falls through to:

    verbose(env, "JIT does not support recursive calls\n");
    return -EOPNOTSUPP;

so the __msg("in a tracing program") check would fail on s390x, riscv64 and
loongarch.  The test runs there, since test_verifier_no_limits() uses
RUN_JITED() and DENYLIST.s390x does not list verifier_no_limits.

The existing global_func3_recursion_in_tracing_prog test, and the FAR_PAD
tests added to verifier_unwind.c by this patch, are gated with __arch_x86_64
__arch_arm64.  Should live_recursion be gated the same way?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43815411838
--===============3417982811272472308==--
