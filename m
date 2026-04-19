Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD42E6CB3
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618909; cv=none; b=hJ3kNIi32ChS6daqvNzsTIu0gbAkC7KhBnDetdQEhukIkAoo3Z0aqexuMqAShQAoop9CamCo4gcRzMSKQrE0nk4RWlXsDIiOQGabziaZT/Zr/RMjsjDqNX09tTqHLsFiwpMosZBEJSQT6W2PGHGFkOpoIAxH3Syde/o/DLg9/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618909; c=relaxed/simple;
	bh=wvjpQQbkmDeTv1VxgflcysQZv7HlejhjNbJx5nsj/Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cH0dPTykVzU4bPL3m+bWLChiN6WIx5QQokKJ+Bb/bJMCmP2tcVwisjFBNOXLODwx5AUPkHSHWsQW3ShPlc0mFp7AxhCbToARcc9VanwszJroV+jptT/vOiMjHP0Ph2x+4+I7+x/lsIrAthnuOuSH/qC4/9BRNklGLf79X/htfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3OuFVyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3OuFVyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541CBC2BCAF;
	Sun, 19 Apr 2026 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776618909;
	bh=wvjpQQbkmDeTv1VxgflcysQZv7HlejhjNbJx5nsj/Oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=h3OuFVyrSkyILcVnr5mtJMVgL9mhNk8wKzIF2InFjCIOWUqvO6YtTq4PXRa4HKljl
	 OrTyZiDHl8/hFtDr8dEm2Z4sVvtr2UThfMcK/JiLRC0NwKEH9LDe1+BNHFXmH3gNRi
	 XJwTPh9idDfXKtWX7Z4uYY1kEG644J77fE5F2EB+COU11efR8RI4WT7LkYfc6JNhSB
	 SaN5RF7cWcy2JGyV5GqMWR1oqZgn2YYLksHDjLj7ykqrbq2g2Z4oJLq1gpcYRfpJF1
	 zTJ1VZyDh7qvRbxFYX6bby0KZ4p19PxzHaqzPWkKFnazARxbIktNJWRgba/CqvY7rz
	 UErEtOeJ1h4ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 15/17] selftests/bpf: Add tests for BPF
 function stack arguments
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163435.740110-1-yonghong.song@linux.dev>
References: <20260419163435.740110-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:15:08 +0000
Message-Id: <20260419171509.541CBC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The `test_async_cb_many` test uses an extremely short `usleep(50=
)` to wait for a BPF timer callback to execute, leading to potential flakin=
ess.
- [Low] The block comment for `global_two_callees` incorrectly refers to th=
e function as `bar`.
- [Low] The `bpf_iter_testmod_seq_next` kfunc is incorrectly declared with =
an `int *` return type in `stack_arg_kfunc.c`.
--

commit 63c1c9ef99d02448833e84a39ecb212ccaaf5b80
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add tests for BPF function stack arguments
   =20
This commit adds selftests covering stack argument passing for both BPF-to-=
BPF
subprog calls and kfunc calls with more than 5 arguments.

> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/t=
esting/selftests/bpf/prog_tests/stack_arg.c
> new file mode 100644
> index 0000000000000..d61bac33f8092
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c

[ ... ]

> +static void test_async_cb_many(void)
> +{
> +	struct stack_arg *skel;
> +
> +	skel =3D stack_arg__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +
> +	if (!skel->rodata->has_stack_arg) {
> +		test__skip();
> +		goto out;
> +	}
> +
> +	if (!ASSERT_OK(stack_arg__load(skel), "load"))
> +		goto out;
> +
> +	run_subtest(skel->progs.test_async_cb_many_args, 0);
> +
> +	/* Wait for the timer callback to fire and verify the result.
> +	 * 10+20+30+40+50+60+70+80 =3D 360
> +	 */
> +	usleep(50);
> +	ASSERT_EQ(skel->bss->timer_result, 360, "timer_result");

Is 50 microseconds enough time to reliably wait for the timer callback to
execute?

In CI environments or heavily loaded virtualization systems, might the
scheduling and softirq execution be delayed by more than a fraction of a
millisecond? If the timer does not fire in exactly that short window, the
test would incorrectly read a timer_result of 0 and fail.

Would it be more robust to use a polling loop or a significantly larger
timeout to avoid flaky tests?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testin=
g/selftests/bpf/progs/stack_arg.c
> new file mode 100644
> index 0000000000000..8c198ee952ff4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stack_arg.c

[ ... ]

> +/* bar calls foo1 (3 stack args) and foo2 (5 stack args).
> + * The outgoing stack arg area is sized for foo2 (the larger callee).
> + * Stores for foo1 are a subset of the area used by foo2.
> + * Result: foo1(1,2,3,4,5,6,7,8) + foo2(1,2,3,4,5,6,7,8,9,10) =3D 36 + 5=
5 =3D 91
> + *
> + * Pass a-e through so the compiler can't constant-fold the stack args a=
way.
> + */
> +__noinline int global_two_callees(int a, int b, int c, int d, int e)

This isn't a bug, but the comment refers to a function named bar, while the
function being described is actually named global_two_callees.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/=
testing/selftests/bpf/progs/stack_arg_kfunc.c
> new file mode 100644
> index 0000000000000..6cc404d578639
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c

[ ... ]

> +#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
> +
> +const volatile bool has_stack_arg =3D true;
> +
> +struct bpf_iter_testmod_seq {
> +	u64 :64;
> +	u64 :64;
> +};
> +
> +extern int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64=
 value, int cnt) __ksym;
> +extern int *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq *it) _=
_ksym;

Does bpf_iter_testmod_seq_next() actually return an int pointer?

Looking at the corresponding kfunc definition in bpf_testmod.c, the function
appears to return an s64 pointer. Although this function isn't actively cal=
led
in this test file (which prevents a BTF verifier failure here), could the
mismatched return type declaration cause confusion or subtle issues in the
future?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D15
