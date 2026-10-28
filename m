Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148373;
	b=WK+F3/rXID2gN/5lD6NS11N3OJnSOPxa2uG6kjkH+/t+4C8Hsw5+VprSY5N9juFsRAyy
	 Ocagrq4NgsMPJpuHGhzHasEHrly/XnXUyDE+bCs1DFxkZfUvyXHc4DDyesYbj9WfoPNjB
	 KtkpM1Z1048xuC9deKTz+7WZW00BSFCieyAJpTmDD+f4BV56uV+YdmCLZcMXGdGmTZHK1
	 5b92IjY6SkaoWsYj1i4KGHomMWKhV8cUhJrheShhABXSNJkcvkJw00F97YdXWqhIpSbJR
	 fCKMhEZht6hHxly9oX7Hfvz1knD/FtxYAgQlHA4jqyLBvcsyZd8ZZ6vPIE5pwGX4XZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148373;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JpxKlsBs0nplsqNGjdVZnc+DN8e3WyN47qn9gI+PJkk=;
	b=JW19zBxhBeLA/18HDFgpFiRI0wq22khJ6z8swyyqCHTYeayb7W3UL4J0ZK9fBL9oDSij
	 EdRfQeKqs8eTVtCELX2ygceFh2+jrMdfrYE76MAMg7zciBTL5dtEb9m0TVTUsnZewrPIH
	 6ffBxqidvcGZNwatW5OsCvNSHi3ijHBu0ZsGSagvCV6SNnZvuMqqcQ/G111K28fe2cos3
	 y686x0HoalUMzMk58SSZ7ISiCpvPNiRJclTBYHrrVfJ5PJx3pf5/ie/c5J0M4P/lO/P6z
	 //2XCcDPYh3Eg6ru3X8n3QcotJSxCtm+tUZ5jFTw8BKFJ6Gh827zRb+WuTPyvGpzDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1L9K0bO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4D606A31D;
	Wed, 28 Oct 2026 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1L9K0bO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA461F01825;
	Wed, 28 Oct 2026 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148372;
	bh=JpxKlsBs0nplsqNGjdVZnc+DN8e3WyN47qn9gI+PJkk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b1L9K0bOIu+jh5sLGAqI6UsuxIEynRrv7QhLaLTt510Uo3zD/h2QydcZUHjgmf9CW
	 ODird2lswcOPewGC0mgFv0fb+etPOy0lQMGiixXovQSZ01Urm/I6mXX/UCA0aAa/9E
	 jR7SBpaapsx1+CL+9aAHL2GshVkJ3ly0kDTw5x9Mk8+m9EAbZ2tpMpLq4Q4GdvZGNL
	 bKDKWREvcIbbzAhxpHr1eBCs7cNDqpANWniAmYAzEmOblS3smOghVPnA6VyVFXu1/N
	 dlYHZGujoRlhEItLFdWD8DmauFWv7/EnzFhhMNrFySDr+L12RVmy5nBdcTUCn80UwW
	 FSxMUgGbEk+Og==
Content-Type: multipart/mixed; boundary="===============8209792634814655665=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <804b7fd3c3bf40a5edf65903d90514263e61fc6fa2ef513d35913fe8ed9acad8@mail.kernel.org>
In-Reply-To: <20261028000411.4010967-2-vineet.gupta@linux.dev>
References: <20261028000411.4010967-2-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v1 1/7] selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jose.marchesi@oracle.com,david.faust@oss.qualcomm.com,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 00:46:12 +0000 (UTC)

--===============8209792634814655665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX

TL;DR: Nit only: the new __skip() reason in the callx selftests omits riscv64,
though riscv64 is supported, so a riscv64 build with a GCC lacking callx
prints a misleading skip message.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h

[ ... ]

> @@ -295,6 +295,13 @@
>  #define CAN_USE_LOAD_ACQ_STORE_REL
>  #endif
>
> +/* clang always emits callx, gcc only when it defines __BPF_FEATURE_CALLX */
> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
> +     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) &&		\
> +	(defined(__clang__) || defined(__BPF_FEATURE_CALLX))
> +#define CAN_USE_CALLX
> +#endif
> +

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
> --- a/tools/testing/selftests/bpf/progs/verifier_callx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx.c

[ ... ]

> @@ -1075,6 +1073,7 @@ int callx_c_ops_on_stack(void *ctx)
>  #else
>
>  SEC("socket")
> +__skip("callx needs x86/arm64 JIT and compiler support")
>  __success
>  int dummy(void *ctx)
>  {

this isn't a bug, but the skip reason leaves out riscv64, even though the
CAN_USE_CALLX macro above accepts it.

The same string is added to the dummy() program in
verifier_callx_rodata.c.  The riscv64 JIT implements bpf_jit_supports_callx(),
and commit 530dfafc6107 ("selftests/bpf: Enable callx related testcases for
RV64") turned these tests on for RV64.

On a riscv64 build with a bpf-gcc that does not define __BPF_FEATURE_CALLX,
the arch supports callx and only the compiler lacks it, yet run_subtest()
prints:

  run_subtest:SKIP: callx needs x86/arm64 JIT and compiler support

That reads as though riscv64 itself were unsupported.

Could the reason say x86/arm64/riscv64, or leave the arch list out (for
example "toolchain or JIT can't do callx", as the new comment in
callx_rodata_lskel.c does)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40608355234
--===============8209792634814655665==--
