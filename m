Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DA840BCDB
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346034; cv=none; b=kg3iVMmViv578PlzE6PJzXkrJwSOlMtOMpEW+xnQi/L+CkwPgvbZVb+LZOXtli0bI5P2EcrYU/16l0SjLAp3VpWz4l1opC+llAQjemh6xPHmMC/x08xSavqudy630gdN2gUnRRKWGx9BtmZ9McKZxGEpnxV44XLa4eKapkjt83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346034; c=relaxed/simple;
	bh=YtbCdn/V5NFzAT5C0uDkl1O+nMo/wiXH4OaYGduPgBQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kWya+77hArW4Z1qeEr4n4jSqSwtu0ZrX0lWT517sO4Bx56PoLXjOW4DBAjlf4Gps1yvffJ2A/oKmjnB0moWaCv/pr8qazineuHYtOnH7mWwwT3scjQgdf6MfGqD1D85wjukBCuSVeji4DN4ck0HnU3UY1ES7m0lnfFgYOcVLKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUihJCXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUihJCXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD60F1F000E9;
	Fri, 21 Aug 2026 21:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787346032;
	bh=xp/Yk2FcDC6EffNkXYzlcYbNlyAuBxgASVaVaAOnRIM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jUihJCXoI/AlhNnea1g8cGqsiqUrbShZ2Jb8M/M2248I9nb5XMbbNeGp1nz2kxHbH
	 D1Yf5fBlCwCS1Ssev1LeGwUsVpEHBCFg30KLltHYYTYtklbaYkvZ93hR2vN8K7gbvj
	 xUyeIoc/lsMc9G1MgVduLD3uriz1VQzAHfcW7k0oopzTjQObFLQP/ibiASuKqStXlU
	 lGQFD9KXzEVuFZipgpIIo/EGmse36YUxXftFrbYS/xg1iHFqbPTW6KzC5sgxvGoYy5
	 o3Aqx5RwvcMPpMofh6DMOm0AdIbAINb0Q7CGqFy1suqpE//RJRQHzC3PknlaRkrLR2
	 ieP+EVu6wVJ/A==
Content-Type: multipart/mixed; boundary="===============2575258006610227616=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a181212ec47fdfcbe52fde90fa8a3c6511f1d4497e98adf330d9f741f42aec37@mail.kernel.org>
In-Reply-To: <20260821201316.1059129-3-vineet.gupta@linux.dev>
References: <20260821201316.1059129-3-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: report placeholder tests as SKIP, not OK
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 21:00:32 +0000 (UTC)

--===============2575258006610227616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 5eacf1b43252..88b0bfba83bb 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -106,6 +106,11 @@
>   * __description     Text to be used for display and as an additional filter
>   *                   alias, while the original program name stays matchable.
>   *
> + * __skip            Report the test as SKIP with the given reason instead of
> + *                   running it. For placeholder programs that stand in for a
> + *                   feature the toolchain or JIT cannot provide, so a run does
> + *                   not report OK for coverage it never executed.
> + *
>   * __log_level       Log level to use for the program, numeric value expected.
>   *
>   * __flag            Adds one flag use for the program, the following values are valid:
> @@ -139,6 +144,7 @@
>  #define __failure		__test_tag("test_expect_failure")
>  #define __success		__test_tag("test_expect_success")
>  #define __description(desc)	__test_tag("test_description=" desc)
> +#define __skip(reason)		__test_tag("test_skip=" reason)
>  #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)

[ ... ]

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

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 07807757b518..794a7dfb0579 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -70,6 +70,7 @@ struct test_spec {
>  	int arch_mask;
>  	int load_mask;
>  	int linear_sz;
> +	const char *skip_reason;
>  	bool auxiliary;
>  	bool valid;
>  };
> @@ -456,6 +457,8 @@ static int parse_test_spec(struct test_loader *tester,
>  			continue;
>  		if ((val = str_has_pfx(s, "test_description="))) {
>  			description = val;
> +		} else if ((val = str_has_pfx(s, "test_skip="))) {
> +			spec->skip_reason = val;
>  		} else if (strcmp(s, "test_expect_failure") == 0) {
>  			spec->priv.expect_failure = true;
>  			spec->mode_mask |= PRIV;
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

The commit converts 13 placeholder programs to use the new __skip()
annotation, but two feature-gated placeholders with the identical
pattern were not converted. Were these intentionally excluded?

The preceding commit b1831d82fe2c states "Eleven of the thirteen
feature-gated placeholder programs are called dummy_test", but grep
finds fifteen such programs.

tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c has a
compile-time gate at line 8:

  #if defined(__clang_major__) && __clang_major__ >= 23

with its #else arm at lines 166-172 supplying the same __success
placeholder pattern that this commit converts everywhere else:

  #else

  SEC("socket")
  __description("verifier_aggregate_ret: needs LLVM 23, dummy test")
  __success
  int dummy_test(void)

Similarly, tools/testing/selftests/bpf/progs/verifier_percpu_addr.c has
a gate at line 7:

  #if defined(__TARGET_ARCH_x86)

with its #else placeholder at lines 60-66:

  #else

  SEC("raw_tp")
  __description("percpu addr dummy")
  __success
  int dummy_test(void)

Both reach the modified test_loader.c code path via
prog_tests/verifier.c (test_verifier_aggregate_ret and
test_verifier_percpu_addr), so __skip() would work for them.

The gates fire today, so the placeholders are what actually gets built
and reported:
- verifier_aggregate_ret.c: any toolchain older than clang 23
- verifier_percpu_addr.c: every non-x86 build (arm64, s390x, riscv64,
  loongarch)

On those builds these two tests still report OK for coverage that never
executed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32523960074
--===============2575258006610227616==--
