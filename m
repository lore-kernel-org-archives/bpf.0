Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729182D1911
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480386; cv=none; b=cwXDur+E4hLxithtFl9UGoPfMRp2rw7pLiZacpxVsYWNAYDr3c3I17YF4NfY/uIW3J6Ra4iGX6lwldCEZWhKdEGuOjxllRC2/Uw2Tjt7MXP2KDy08Iak+ETVFdAOAK77RrgAz5WXMU0vLrydndZtIB3pruKoJxpruAk/tjLPi2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480386; c=relaxed/simple;
	bh=Y4fbnHxgnPpfHZegkZrM7NaMfGQBvPkJP3E2gR7Mu2w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g+1e5VcCC8AdvjPlHP72Dao9yGbMbu8gIh+W79mmjkY8++SERtBEzJmOD/QYLyi8jJ6tlk72zhXwHs9Th7zkrRdZ0u8JXmgb3RczLJ/bbTc/8+nx3GvQ3reKUbcHIZfvs8cLVRhDDynWWrt81v3zJrHuoNSXbSxIQH5I6etiREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw+SCCKP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw+SCCKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BACC2BCB0;
	Mon, 11 May 2026 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778480386;
	bh=Y4fbnHxgnPpfHZegkZrM7NaMfGQBvPkJP3E2gR7Mu2w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hw+SCCKPlqyqHUXxHN8WMZh+Pf51oKo+LQsEmnH+CxbFgYVII0Guj7rdFdCUBNipN
	 rHStCxjjeaUq3395usE6jaybykgyC38tQXi+WTGXVKq3eVLsbOeg4G4DLRk4iEBtaq
	 aIBKB9Q5cg64A3kNCPX9w+6h1Ir6WulSdnBi8JPBiqRp9IhjRy33CXVUDIs3qvABOb
	 xbSQTkiq9qcm4VHYAzxzgkwEjw2bpwzu49plPG3WWeM/krpca3KY4GhlxyBSBltnVR
	 w/CSOP32P2rogptA5ARexznJF8OQytKjU/EPIQmq+V1l32rlb5O5kUUuRrS2XN2rLS
	 xnG9ONu18evrA==
Content-Type: multipart/mixed; boundary="===============1352431935289811826=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <67190ccd5d895a0070fd876109ee9fd9d0ce3db42324ba07d942b5e25278d6fb@mail.kernel.org>
In-Reply-To: <20260511053452.1892038-1-yonghong.song@linux.dev>
References: <20260511053452.1892038-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 20/24] selftests/bpf: Add verifier tests for stack argument validation
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 06:19:45 +0000 (UTC)

--===============1352431935289811826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index a96b25ebff23..ee3d929fac8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -91,6 +91,8 @@
>  #include "verifier_sockmap_mutate.skel.h"
>  #include "verifier_spill_fill.skel.h"
>  #include "verifier_spin_lock.skel.h"
> +#include "verifier_stack_arg.skel.h"
> +#include "verifier_stack_arg_order.skel.h"
>  #include "verifier_stack_ptr.skel.h"
>  #include "verifier_store_release.skel.h"
>  #include "verifier_subprog_precision.skel.h"
> @@ -238,6 +240,8 @@ void test_verifier_sock_addr(void)            { RUN(verifier_sock_addr); }
>  void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mutate); }
>  void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
>  void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
> +void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg); }
> +void test_verifier_stack_arg_order(void)      { RUN(verifier_stack_arg_order); }
>  void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
>  void test_verifier_store_release(void)        { RUN(verifier_store_release); }
>  void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }

In v2 (May 7), sashiko-bot raised a concern about whether the tests in
verifier_stack_arg_order.c are actually being executed:

  The tests in verifier_stack_arg_order.c are never executed because
  the file is not registered in the selftests runner. [...] Did you
  intend to include verifier_stack_arg_order.skel.h here as well?
  [...] Could this be missing a RUN(verifier_stack_arg_order) entry?

Reference: https://lore.kernel.org/bpf/20260509013809.18E7DC2BCB0@smtp.kernel.org/

You responded in v3 (May 10) saying "Will fix," but this commit includes
both verifier_stack_arg_order.skel.h and RUN(verifier_stack_arg_order),
which appears to address the concern. Was the registration added after the
discussion, or is there still something missing?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> new file mode 100644
> index 000000000000..d38beba6b5e9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c

[ ... ]

> +__noinline __used
> +static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
> +{
> +	return *f;
> +}

[ ... ]

> +SEC("tc")
> +__description("stack_arg: pruning with different stack arg types")
> +__failure
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("R{{[0-9]}} invalid mem access 'scalar'")
> +__naked void stack_arg_pruning_type_mismatch(void)
> +{
> +	asm volatile (
> +		"call %[bpf_get_prandom_u32];"
> +		"r6 = r0;"
> +		/* local = 0 on program stack */
> +		"r7 = 0;"
> +		"*(u64 *)(r10 - 8) = r7;"
> +		/* Branch based on random value */
> +		"if r6 s> 3 goto l0_%=;"
> +		/* Path 1: store stack pointer to outgoing arg6 */
> +		"r1 = r10;"
> +		"r1 += -8;"
> +		"*(u64 *)(r11 - 8) = r1;"
> +		"goto l1_%=;"
> +	"l0_%=:"
> +		/* Path 2: store scalar to outgoing arg6 */
> +		"*(u64 *)(r11 - 8) = 42;"
> +	"l1_%=:"
> +		/* Call subprog that dereferences arg6 */
> +		"r1 = r6;"
> +		"r2 = 0;"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"r5 = 0;"
> +		"call subprog_deref_arg6;"
> +		"exit;"
> +		:: __imm(bpf_get_prandom_u32)
> +		: __clobber_all
> +	);
> +}

[ ... ]

> +SEC("tc")
> +__description("stack_arg: release_reference invalidates stack arg slot")
> +__failure
> +__msg("R{{[0-9]}} invalid mem access 'scalar'")
> +__naked void stack_arg_release_ref(void)

[ ... ]

> +SEC("tc")
> +__description("stack_arg: pkt pointer in stack arg slot invalidated after pull_data")
> +__failure
> +__msg("R{{[0-9]}} invalid mem access 'scalar'")
> +__naked void stack_arg_stale_pkt_ptr(void)

[ ... ]

> +SEC("tc")
> +__description("stack_arg: null propagation rejects deref on null branch")
> +__failure
> +__msg("R{{[0-9]}} invalid mem access 'scalar'")
> +__naked void stack_arg_null_propagation_fail(void)

Multiple reviewers (sashiko-bot in v6, bpf-ci bot in April 24 and v2)
raised concerns about test fragility in these tests
(stack_arg_pruning_type_mismatch, stack_arg_release_ref,
stack_arg_stale_pkt_ptr, and stack_arg_null_propagation_fail).

Since subprog_deref_arg6 is standard C (not __naked), LLVM determines which
register is used for dereferencing. The reviewers noted that if a future
LLVM version chooses a different register, the verifier error will mention
that register instead, causing the test to fail.

Reference: https://lore.kernel.org/bpf/b03ce38af2e3d574b5a79963da1a4db70e896e6712b2bf2e9fce69178433540d@mail.kernel.org/

You responded in v6 that you would use a regex pattern like
R{{[0-9]}}, and in v2 (May 7) you stated you prefer to remove the register
prefix entirely. The current tests use __msg("R{{[0-9]}} invalid mem access
'scalar'"), which matches any register number.

Is the regex pattern R{{[0-9]}} sufficient to address the fragility
concern, or would it be safer to make subprog_deref_arg6 a __naked
function with explicit register usage?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893
--===============1352431935289811826==--
