Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7629353A69
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555796; cv=none; b=Q5j4Ba2W+PpdbhQJbbyFjAb5WxpSFoD4H+VlCT3Z3SnZjqElzvs1yt/jH/os8n2MrFMgn5i/rI4Wk1iEFSTbDEz+ORDxk28pfZ/jyoX8BU6bCCkYADjZcd2TQ4DIFdz9p42gG/5KgKNHSFt2vO26/C2cRcuHplAmOv2dF9OoEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555796; c=relaxed/simple;
	bh=Jzh+zi6X8yvQMnWSYoRLVonGTVhgaE78aouNGMHixlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r2xBObX8qvwhYu/3qauXFW7DqrtbH3y7x4jVC7N+o3x59v5nUrG13QHawEavinXuUF7SBQs5AeRzR94zDHNgV9XW3+JlPVrGuf453FjhSJg+ckrnJgg3A59YzLAQvhsyiRdmgq/V2gi32BjEVtzx+bQjNhbcgshCqE3ntZGjw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYN/v9wJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYN/v9wJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3501E1F000E9;
	Wed, 12 Aug 2026 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555795;
	bh=7RhF35zR6vF2Y5+UVFmRR3DvwjVgUzbd+iUODIx6s0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYN/v9wJ1yYNT4aKD5Hjamxu5pFLsr8SPDWgRGlrcI9zIDExN43ACbOFUzNddsd6k
	 ssOiEHtuxvIKRg4YPcXylM9oZQZk8i9vRdA7iiOst9s92dLkrGAUVnDEJlPZehe6Mm
	 niVqttp+V7tZ0t5gXNKHTOkylLG5OgUCaQ7wVnC2x6qdocPljvJi+7HWY4Zb/tZiPm
	 7ltVOvpm3qAbekzTmUyuEQ+xePg7Uo04ntbwoxM6+BlJOz8T+SRXLn2/VLb7XCPmvo
	 7IHFuJKTb2XB6by7Z1nm29hY5FMauX2fqLemVzC3q0k9/5ZuLXrCoZeraBKZ8eRpJl
	 r8U3Cum+fLk9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/x86: add generic prctl shadow stack
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812171940.1046116-2-bill.roberts@arm.com>
References: <20260812171940.1046116-1-bill.roberts@arm.com>
 <20260812171940.1046116-2-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:29:54 +0000
Message-Id: <20260812172955.3501E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The global `_which_test` variable is never initialized, causing =
the signal handler to always fall back to ARCH_PRCTL.
- [Low] CET inline assembly is exposed to older toolchains due to an incorr=
ectly moved compiler check.
- [Low] Missing fallback macro definitions for PRCTL flags break build comp=
atibility on older systems.

Pre-existing issues:
- [High] Unchecked `fork()` failure in `test_ptrace()` broadcasts `SIGKILL`=
 to all processes.
--

--- Patch [2]: [PATCH v2 2/2] selftests/x86: add generic prctl shadow stack=
 test ---
commit 347a779613419462705a2f200f991f112e768094
Author: Bill Roberts <bill.roberts@arm.com>
Subject: selftests/x86: add generic prctl shadow stack test

This commit abstracts the x86 shadow stack selftests into a reusable
library and introduces a new test for the generic prctl() shadow stack
interface.

> diff --git a/tools/testing/selftests/x86/shadow_stack.c b/tools/testing/s=
elftests/x86/shadow_stack.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/x86/shadow_stack.c
[ ... ]
> +/*
> + * Define the ABI defines if needed, so people can run the tests
> + * without building the headers.
> + */
> +#ifndef __NR_map_shadow_stack
> +#define __NR_map_shadow_stack	453
> +
> +#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)
> +
> +#define ARCH_SHSTK_ENABLE	0x5001
> +#define ARCH_SHSTK_DISABLE	0x5002
> +#define ARCH_SHSTK_LOCK		0x5003
> +#define ARCH_SHSTK_UNLOCK	0x5004
> +#define ARCH_SHSTK_STATUS	0x5005
> +
> +#define ARCH_SHSTK_SHSTK	(1ULL <<  0)
> +#define ARCH_SHSTK_WRSS		(1ULL <<  1)
> +
> +#define NT_X86_SHSTK	0x204
> +#endif

[Severity: Low]
Does this code break builds on older systems?

The test now relies on PRCTL constants like PR_SET_SHADOW_STACK_STATUS,
PR_SHADOW_STACK_ENABLE, and PR_SHADOW_STACK_WRITE. If a system's
sys/prctl.h is outdated, these will be undeclared.

Could we add fallback definitions for these constants similar to the
ARCH_SHSTK_* ones?

[ ... ]
> +#define SS_SIZE 0x200000
> +#define PAGE_SIZE 0x1000
> +
> +void write_shstk(unsigned long *addr, unsigned long val)
> +{
> +	asm volatile("wrssq %[val], (%[addr])\n"
> +		     : "=3Dm" (addr)
> +		     : [addr] "r" (addr), [val] "r" (val));
> +}

[Severity: Low]
Could this cause build failures on systems with older toolchains?

The compiler version check for CET support was moved down to wrap only
shadow_stack_run_tests(). As a result, older compilers might fail to
build the test since they won't recognize the wrssq inline assembly in
write_shstk() and get_ssp().

[ ... ]
> +sigjmp_buf jmp_buffer;
> +enum shadow_stack_test _which_test;
> +void segv_gp_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	segv_triggered =3D true;
> +
> +	/*
> +	 * To work with old glibc, this can't rely on siglongjmp working with
> +	 * shadow stack enabled, so disable shadow stack before siglongjmp().
> +	 */
> +	SHADOW_STACK_DISABLE(_which_test);
> +	siglongjmp(jmp_buffer, -1);
> +}

[Severity: Medium]
Is the generic prctl() fallback path ever actually tested in the signal han=
dler?

The global _which_test variable is declared but never initialized.
When shadow_stack_run_tests() is called, it receives the test enum as
which_test, but never assigns it to _which_test.

Because _which_test remains 0 (SHADOW_STACK_TEST_ARCH_PRCTL), the
signal handler will always use the ARCH_PRCTL path instead of the new
PRCTL path, even when running the prctl test suite.

[ ... ]
> +int test_ptrace(void)
> +{
> +	unsigned long saved_ssp, ssp =3D 0;
> +	struct sigaction sa =3D {};
> +	struct iovec iov;
> +	int status;
> +	int pid;
> +
> +	iov.iov_base =3D &ssp;
> +	iov.iov_len =3D sizeof(ssp);
> +
> +	pid =3D fork();
> +	if (!pid) {

[Severity: High]
This is a pre-existing issue, but could this code broadcast SIGKILL to
all user processes if fork() fails?

If fork() returns -1 due to resource limits, execution will proceed with
pid =3D -1. When ptrace() subsequently fails, the error path is triggered:

out_kill:
	kill(pid, SIGKILL);
	return 1;

Since pid is -1, POSIX specifies that this will kill all processes the
current user has permission to terminate, potentially crashing the host
environment.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812171940.1046=
116-1-bill.roberts@arm.com?part=3D2
