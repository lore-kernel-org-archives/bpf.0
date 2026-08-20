Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6983E47CA62
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240693; cv=none; b=t2LJlvFxXW5Shjlwilo04zbuiR32t3xEEQy81PF7OtdbQiv6tansoz0XgopsYD4AxnG1oEdjcDOydXY5UOLvN83C91lIVmppLClTEwZ9igJkcWObbWWV619s/3wqCUoEz9jzzbmHBibz2QgjCYniHqgCiESTuIfcHXaP0c1VuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240693; c=relaxed/simple;
	bh=K2wB/4FNhxDYjkUEsgonv42m9EJh8NMvhM7iCaEIGT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fp19L1te2zBlhRPad1zkcwH1ZLT8ZDvm7S/fLoUvJBdtg4uNI+jbt0Mb6VsKf1xzxrW98XUiS6TQcoHbPCdSxaDEVvCCjj6QfIwCeTpZ4FgXldi3Jz221vo3aADDLOicPYHiTpxbkFy0AES9zSUMwwHEHIEBItyThG9p8pTGcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG+U5ARL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG+U5ARL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65CC1F01558;
	Thu, 20 Aug 2026 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240683;
	bh=11dvzmtD5jEiWJ5mF6PR8Wk1WS/7lNBZueh1DBLyciY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EG+U5ARLsjJ955/a3uIM4KX5L+i1jnWLg4hsprFQ8lR7jJ4JFrJX1BusAOYoXA/H0
	 0G1sbEQoJPR32tb7Y5MjE+xKgi1HWmAgOM0PxqnyD7TVtSypOVBv26iuQ4vVUGu1Ps
	 9L49xNmia04kRUyJN6YbdzWqvK+dX9YhH9cv51k9vAq/LKqn65cBQQnan9Q00Le8/S
	 QIxtzfEmvefgUmm83TrY40uNLy0KFLSRk3m4WIRQpBNXUQxF7Nd4Mh7kf8iK2ptEwB
	 8e6gRbxHw6C471d7UU3nW8nz5fo47o/Vxta9SQR8ZKeI6lmBZonzFDaGxfD1i2VQFL
	 0CA1dlX6gEKug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] selftests/x86: add generic prctl shadow stack
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818225428.1983328-6-bill.roberts@arm.com>
References: <20260818225428.1983328-1-bill.roberts@arm.com>
 <20260818225428.1983328-6-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 15:44:43 +0000
Message-Id: <20260820154443.A65CC1F01558@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The global `_which_test` variable used by `segv_gp_handler` is o=
nly initialized inside `test_32bit()`, creating an implicit execution depen=
dency.
--

--- Patch [5]: [PATCH v3 5/5] selftests/x86: add generic prctl shadow stack=
 test ---
commit 4df1cdb98415fac5314af3be03f1bd5e57dfbd7c
Author: Bill Roberts <bill.roberts@arm.com>

selftests/x86: add generic prctl shadow stack test

This commit refactors the existing shadow stack selftests to allow running
the suite using both arch_prctl and the generic prctl interfaces. It moves
the core logic into a shared file and introduces a new test executable for
the generic prctl.

> diff --git a/tools/testing/selftests/x86/shadow_stack.c b/tools/testing/s=
elftests/x86/shadow_stack.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/x86/shadow_stack.c
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
[ ... ]
> +int test_32bit(enum shadow_stack_test which_test)
> +{
> +	struct sigaction sa =3D {};
> +	struct sigaction *sa32;
> +
> +	_which_test =3D which_test;
[ ... ]
> +int shadow_stack_run_tests(enum shadow_stack_test which_test)
> +{
> +	int ret =3D 0;
> +

[Severity: Medium]
Could this create a test execution order dependency?

The global variable _which_test is used by segv_gp_handler to multiplex
between the arch_prctl and prctl APIs before calling siglongjmp(). However,
_which_test is only explicitly initialized when test_32bit() executes.

Since segv_gp_handler is also used by test_uretprobe() and test_uprobe_call=
(),
if the test execution order changes or if test_32bit() gets skipped,
_which_test will remain uninitialized (defaulting to 0, which corresponds
to SHADOW_STACK_TEST_ARCH_PRCTL). This could cause the generic prctl test
binary to incorrectly use the arch_prctl APIs in its signal handler.

Should _which_test be initialized here at the entry of
shadow_stack_run_tests() instead of inside test_32bit() to ensure it is
always cleanly set for all tests that rely on this signal handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818225428.1983=
328-1-bill.roberts@arm.com?part=3D5
