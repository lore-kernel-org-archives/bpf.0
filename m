Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52D350A0F;
	Fri, 14 Aug 2026 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728093; cv=none; b=fuKoDLxWjRO2sXHua8YEJGOtlet5nwILnK9r7ZWoILzWZB2IsDJ2F0PKpblJqP1xxeaflLG4aiY82d0zJnP+oPWqfbXbqMkxvV8EnP5ic4nFhx2kC6enkbLYhMBEGWvm6KECKDn6Z7qLV4/iff30aSPc9y/Sr4qCqiuZr4BLbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728093; c=relaxed/simple;
	bh=PryW5/Q3Bv9cFHlmdZEa9lIN7kJ7Y3htZG1BnRooRG4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q70Jvx10OgbzDbA5qm7mH275i6Yfuzpg9Gfmw6t9SsUSWvta3hlqJpb3stWrUmKqhbNJRAZGxS2UBiH8+59Z7fdH7hD/ub95utNClj5cIbDgX85DxXTm1eilxDOZ1g6OuD3OPOD72pDyIGQWNooAIcOpobfDp+Ji/tA1ShbbMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDcRmryS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDcRmryS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01E61F000E9;
	Fri, 14 Aug 2026 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728092;
	bh=kCMwHYDuAmEah09k0GzoAXuVg4lWJdEr8l1UPNwyZug=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LDcRmryS/x2SewUpNUujeWMPe1PlOZCVYY2WguAGZ+i2Zc6s3R3mk+8+GgwXHFvqc
	 ha56Z5zO10N0zuvg5LClvSoUO0dG9ClOBpM9CkuyfBye8aL6vMfAJ1AG2vuVyaozYj
	 M3K/UKqJaVMIjDz2npHPPKGrWn2QHYmPBKdR1GErVwynZ0IcOAlZnmcdpgPzd8SSfG
	 5sTneXss5cdRXE6R//bUOpSi+lQIJHv0J/Z+iw8wOtw3c/JlsUJRVD9/t0oJmwqlLv
	 dIJ08lfb2my/Uxq2vHbC/DSFTh2aNtoS2fsJVmdblIDp1AYO/zGyJ1S+5OVlZKY+2Z
	 BRSYA+DTErD+g==
Content-Type: multipart/mixed; boundary="===============5235386225210976763=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0202fef2f34b7ea4b7c23e7a618a8be029263009449a952e586d734bb9a86938@mail.kernel.org>
In-Reply-To: <20260812171940.1046116-2-bill.roberts@arm.com>
References: <20260812171940.1046116-2-bill.roberts@arm.com>
Subject: Re: [PATCH v2 2/2] selftests/x86: add generic prctl shadow stack test
From: bot+bpf-ci@kernel.org
To: bill.roberts@arm.com,hpa@zytor.com,aou@eecs.berkeley.edu,alex@ghiti.fr,bp@alien8.de,dave.hansen@linux.intel.com,mingo@redhat.com,palmer@dabbelt.com,pjw@kernel.org,rick.p.edgecombe@intel.com,shuah@kernel.org,tglx@kernel.org,x86@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-riscv@lists.infradead.org,bill.roberts@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 17:21:30 +0000 (UTC)

--===============5235386225210976763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 434065215d127..8748e2f4a915d 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -19,7 +19,8 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
>  TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx lam test_shadow_stack avx apx
> +			corrupt_xstate_header amx lam test_shadow_stack avx apx \
> +			test_shadow_stack_prctl
>  # Some selftests require 32bit support enabled also on 64bit systems
>  TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
>
> @@ -138,3 +139,5 @@ $(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
>  $(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
>  $(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
>  $(OUTPUT)/apx_64: EXTRA_FILES += xstate.c
> +$(OUTPUT)/test_shadow_stack_64: EXTRA_FILES += shadow_stack.c
> +$(OUTPUT)/test_shadow_stack_prctl_64: EXTRA_FILES += shadow_stack.c

Does incremental make produce stale binaries here? shadow_stack.c is added
via EXTRA_FILES but isn't made a prerequisite of either binary. The pattern
rule at Makefile:44 is:

    $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h

so the prerequisites of test_shadow_stack_64 remain 'test_shadow_stack.c
helpers.h', and shadow_stack.c (which holds most of the test body after this
commit) isn't in that list. After editing shadow_stack.c, make reports
nothing to be done and leaves the previously-linked binary in place.

Lines 112-120 define an extra-files helper specifically for this: its
comment states 'Note: the only way to get extra dependencies is to
override the target (by leading 'test_XXX.c' with 'override test_XXX :')'.
The existing amx/avx/apx EXTRA_FILES lines (immediately above these new
ones) have the same omission, so this follows local precedent. What makes
it more visible here is that this commit moves 1160 of test_shadow_stack.c's
1167 lines into shadow_stack.c, so essentially the entire test body is now
in a file that isn't a build dependency of either binary.

> diff --git a/tools/testing/selftests/x86/shadow_stack.c b/tools/testing/selftests/x86/shadow_stack.c
> new file mode 100644
> index 0000000000000..a375c4ff7a6ac
> --- /dev/null
> +++ b/tools/testing/selftests/x86/shadow_stack.c

[ ... ]

> +#define SHADOW_STACK_ENABLE(which_test)                                             \
> +	((which_test) == SHADOW_STACK_TEST_ARCH_PRCTL ?                             \
> +		ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK) :                   \
> +		PRCTL(PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE, 0, 0, 0))
> +
> +#define SHADOW_STACK_ENABLE_WRITE(which_test)                                   \
> +	((which_test) == SHADOW_STACK_TEST_ARCH_PRCTL ?                          \
> +		ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS) :                \
> +		PRCTL(PR_SET_SHADOW_STACK_STATUS,                               \
> +			PR_SHADOW_STACK_ENABLE|PR_SHADOW_STACK_WRITE, 0, 0, 0))

Are the SHADOW_STACK_ENABLE branches equivalent? Looking at
arch_set_shadow_stack_status() in arch/x86/kernel/shstk.c (from earlier in
this series), the prctl path with only PR_SHADOW_STACK_ENABLE falls through
to:

    return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS);

so it clears WRSS, while ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK)
leaves WRSS untouched. shadow_stack_run_tests() enables WRSS once at line
1108 via SHADOW_STACK_ENABLE_WRITE(), then re-enables shadow stack with
SHADOW_STACK_ENABLE() inside test_uretprobe() (line 881) and
test_uprobe_call() (line 960).

In prctl mode those two calls silently drop WRSS. Nothing after line 881
currently uses write_shstk(), so no test fails today, but any future
wrss-using test added after the uprobe tests would only fail in the prctl
binary.

[ ... ]

> diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
> index 3d6ca33edba42..d89c04623001c 100644
> --- a/tools/testing/selftests/x86/test_shadow_stack.c
> +++ b/tools/testing/selftests/x86/test_shadow_stack.c

[ ... ]

> @@ -1,1174 +1,21 @@
>  // SPDX-License-Identifier: GPL-2.0
> +
>  /*
>   * This program test's basic kernel shadow stack support. It enables shadow
>   * stack manual via the arch_prctl(), instead of relying on glibc. It's
>   * Makefile doesn't compile with shadow stack support, so it doesn't rely on
>   * any particular glibc. As a result it can't do any operations that require
>   * special glibc shadow stack support (longjmp(), swapcontext(), etc). Just
> - * stick to the basics and hope the compiler doesn't do anything strange.
> + * stick to the basics and hope the compiler doesn't do anything strange. It
> + * uses the x86 specific interface for ARCH_PCTL, whereas
> + * test_shadow_stack_prctl.c uses the generic PRCTL interface mixed with x86
> + * specific code.
>   */

This isn't a bug, but there's a typo in the new sentence: 'ARCH_PCTL' should
be 'arch_prctl()' (the first paragraph already spells it correctly).

[ ... ]

> +int main(int argc, char *argv[])
> +{
> +	return shadow_stack_run_tests(SHADOW_STACK_TEST_ARCH_PRCTL);
> +}

A subsystem pattern flags these test binaries for not using the kselftest
TAP wrappers: main() returns the helper's int status directly instead of
calling ksft_exit_*(), and shadow_stack_run_tests() reports results with
hand-rolled printf("[OK]")/printf("[FAIL]") text rather than
ksft_test_result_*().

Without TAP ok/not ok lines, a runner parsing results cannot distinguish
a skip from a failure: shadow_stack_run_tests() returns 1 both for a
genuine failure and for the "[SKIP] Could not enable Shadow stack" path
(shadow_stack.c:1131), so a kernel or CPU without the new generic prctl
support surfaces as a failing exit status rather than KSFT_SKIP.

The ad hoc printing is pre-existing (the old test_shadow_stack.c main()
had the same bare return and printf style), and every other test in
tools/testing/selftests/x86/ follows this convention rather than using
kselftest.h. Converting to TAP would be a rework of the whole x86
shadow-stack suite. Is the exit-status conflation for the new prctl
binary's skip case worth addressing separately?

The same pattern appears in test_shadow_stack_prctl.c below.

[ ... ]

The parameterized shadow_stack_run_tests() now takes 'enum shadow_stack_test'
and shadow_stack.h even declares SHADOW_STACK_TEST_COUNT, yet this main()
hardcodes SHADOW_STACK_TEST_ARCH_PRCTL and a second, near-identical binary
(test_shadow_stack_prctl.c) passes the other variant. Could a loop here:

    for (i = 0; i < SHADOW_STACK_TEST_COUNT; i++)
        ret |= shadow_stack_run_tests(i);

exercise both interfaces from a single test, or is there a reason the two
must run as separate processes?

> diff --git a/tools/testing/selftests/x86/test_shadow_stack_prctl.c b/tools/testing/selftests/x86/test_shadow_stack_prctl.c
> new file mode 100644
> index 0000000000000..4641a3b1ca036
> --- /dev/null
> +++ b/tools/testing/selftests/x86/test_shadow_stack_prctl.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Same as test_shadow_stack.c but uses the PRCTL interface
> + * instead of ARCH_PRCTL.
> + */
> +#include "shadow_stack.h"
> +
> +int main(int argc, char *argv[])
> +{
> +	return shadow_stack_run_tests(SHADOW_STACK_TEST_PRCTL);
> +}

The TAP reporting concern from test_shadow_stack.c applies here too: the
new prctl binary returns 1 both for genuine failures and for the
"[SKIP] Could not enable Shadow stack" path, so a missing prerequisite
(kernel or CPU without PR_SET_SHADOW_STACK_STATUS support) surfaces as a
non-zero exit status rather than KSFT_SKIP.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31820235607
--===============5235386225210976763==--
