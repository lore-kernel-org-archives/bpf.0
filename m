Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22980391505
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607735; cv=none; b=Dbs+V0dLF8pElWgpDGX0YRFZtPEdajdG9iHACz7uhavDEF13ofuUoCkiAUvVhDu6rFYf+4cz8cZebFVjDOubrIdxTQKq2VhtI7bWdhD/HaHmMwtcHn/H0aRmuKrn2I1l7hcHHtEQkSlEPJPDSNfX21LbHF5bb4c6ahxuU/NbM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607735; c=relaxed/simple;
	bh=8ckIdohhacHIraLHt2XVf1t5FrJuR2rhIPMD4h+NS4g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DerHvJW6L3kgpBr+SZLai8Pl0P3GYVRTXOMBhJXte/JIZ0mAN/0GsGA9YIkir0kHJHtwhi1BKqUFqtD/E2ZhnkQBPrdh8R4dAMv4oVailcCQLHJPVBDUYtS+xOd9TvAxsf1IOmeDh9ojgQbF+gfDd1up60ri5divdyHOAIfvo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN4g3jml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN4g3jml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9AB1F000E9;
	Mon, 24 Aug 2026 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787607733;
	bh=Li28rOc8tcdSGBxH+YTBy1uSfvPxFdjr/Kd3/A7QfNY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HN4g3jmljQxAfzGnqlMZS+BbxvSTaA6FEbq/fLmLfDOscl5jSivxM4sSQTVX6Gwpn
	 +SIC+LA53rq0etuihSyFvkf5mW9ggRXA7s6osgZm3zERcAtIVV3QyLhErwRLG97jP/
	 iICFOMEHNV9p13wYNG51NBhjQ5QTJ+Ow3zBUTHDnkkUq0Dcn7JWZnr6Najdo67eVQT
	 AhneDBimljWOK5XJWnMhs1Kth3OZmS555+JTJYL3umZugQGzTfXfYKhIm532gwO4OA
	 wvlZNtYwnDHt5j4OPL1FSK4qYMMvFCF8qo82qEjtHJaGgn7vuFqK5uyxtqV4wbzq9A
	 CP40wa0jwmNUg==
Content-Type: multipart/mixed; boundary="===============7154996866721288548=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f1de7701b1f8968bc1c017f017c8ea4e2e759c6545ffb6ca8249d51c613ee44d@mail.kernel.org>
In-Reply-To: <20260824210142.3933580-3-vineet.gupta@linux.dev>
References: <20260824210142.3933580-3-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: report placeholder tests as SKIP, not OK
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: vineet.gupta@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 21:42:13 +0000 (UTC)

--===============7154996866721288548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> index 41340877dc9d..e58ea69e3854 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -436,6 +436,7 @@ void kfunc_root(void)
>
>  SEC("socket")
>  __description("cpuv4 is not supported by compiler or jit, use a dummy test")
> +__skip("cpuv4 is not supported by compiler or jit")
>  __success
>  int dummy_test(void)
>  {

This isn't a bug, but since the SKIP line is already labelled with the
__description text, would it read better for __skip(reason) to supply a
distinct message rather than repeating the same wording? Looking at all
15 converted placeholders (arena_kfunc.c, stack_arg_fail.c,
stack_arg_precision.c, verifier_aggregate_ret.c, verifier_bswap.c,
verifier_gotol.c, verifier_ldsx.c, verifier_load_acquire.c,
verifier_movsx.c, verifier_percpu_addr.c, verifier_private_stack.c,
verifier_sdiv.c, verifier_stack_arg.c, verifier_stack_arg_order.c,
verifier_store_release.c), each has __skip() repeating the adjacent
__description() nearly verbatim, differing only by a trailing clause like
", use a dummy test" or ", dummy test". This means each file now stores
the reason twice and the two strings can drift apart independently.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 07807757b518..794a7dfb0579 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -1327,6 +1330,12 @@ void run_subtest(struct test_loader *tester,
>  	if (!test__start_subtest_with_desc(subspec->name, subspec->description))
>  		return;
>
> +	if (spec->skip_reason) {
> +		printf("%s:SKIP: %s\n", __func__, spec->skip_reason);
> +		test__skip();
> +		return;
> +	}
> +
>  	if ((get_current_arch() & spec->arch_mask) == 0) {
>  		test__skip();
>  		return;

This isn't a bug, but is the extra reason line reachable in a normal
(non -v) run? Since test__start_subtest_with_desc() has already called
stdio_hijack_init(), this printf() goes into subtest_state->log_buf.
Looking at dump_test_log() in test_progs.c, the log_buf is only emitted
when verbose() || force_log || subtest_failed is true, which would be
false for a skipped subtest in a default run. Meanwhile the SKIP verdict
itself is printed by print_subtest_name() using the __description text,
so in the default output only the subtest name appears next to :SKIP.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32778075708
--===============7154996866721288548==--
