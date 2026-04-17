Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAE2459DC
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776399618; cv=none; b=sKTdn/+NP357V6Ckw7QlAwzkCgYjS9kYgHc4QX5Jmit2F1c6pcSyKWtnQL4HH7cGWq0JVz8aIWMSlOiWufnHB1iI8XkWdIDh1xQpluYKFWw9GLTXaT2Nvibt6PJouyX4IHNiGByi9OqUz3asaycJFXR8EuLqjZEhPIE6zqZyMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776399618; c=relaxed/simple;
	bh=sLMcVonSwal1JFB46efDC33BakAbvoTFfpcFXg0ejiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Phutmr5MJRipEForDu2B4F9e5nNFhK6t3DqQzWTkixrLmmDoER9tBfJRuDxiJM505DXiR7G7d760c6IJUr1UhN1bQWH+k4GpE85ZEi/GkXXBxMgpmZ4vp9egmkLE7lC5dxumoH7RY1CT2r7nUig/U/FYAS3fyswkqNvmdf5Q74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6X0JSFg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6X0JSFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF065C19425;
	Fri, 17 Apr 2026 04:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776399618;
	bh=sLMcVonSwal1JFB46efDC33BakAbvoTFfpcFXg0ejiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R6X0JSFglc4jbKgwjVzpGFCxeJjyenGrMuqtA9L0Cs1/lFk1JXFfGHlejvWYAXFpJ
	 6PBhToYQQfTIa1l07GJvOrakmWTJkYUzjO6Z4g4xR/YCguPO/QSiaxmIJ/FtVRRS3o
	 5zkwkFla0pSW1laxK2kM/NOjUvfdNVR+ANqrlYIjdX+OTnI0WUwAVmBb0g5eJpgKJw
	 yukbIKmzK6PNEBmJZppuc5UcS+aygTwiK5F4/wmhBYAI7i6f+rwJlXz1yQhmQzc6Gm
	 LhBYxBXW1hs9KVvnCEIubOE8f878/fwMowjhClquY4QQREQsaftRGPPhlhhypv02dQ
	 HVwlM8rBZ9EFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 14/16] selftests/bpf: Add tests for BPF
 function stack arguments
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034828.2634626-1-yonghong.song@linux.dev>
References: <20260417034828.2634626-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:20:17 +0000
Message-Id: <20260417042017.CF065C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The `test_async_cb_many` test fails to verify the execution and =
result of the asynchronous timer callback.
--

commit ef139a03093697d9985422f1f900de9a12f9a0dc
Author: Yonghong Song <yonghong.song@linux.dev>

    selftests/bpf: Add tests for BPF function stack arguments

This commit adds selftests for BPF-to-BPF subprog and kfunc calls that
utilize more than 5 arguments, verifying stack argument passing. It introdu=
ces
test scenarios for various stack argument types, including scalars, pointer=
s,
and async callbacks.

> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/t=
esting/selftests/bpf/prog_tests/stack_arg.c
> index 0000000000000..130eaf1c4a78e
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

Does this test verify the asynchronous callback execution and its result?

Since run_subtest() only runs the program and asserts the return value is 0,
the skeleton is immediately destroyed afterward. The timer callback might
not have time to execute and could be canceled during map destruction.

> +
> +out:
> +	stack_arg__destroy(skel);
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testin=
g/selftests/bpf/progs/stack_arg.c
> index 0000000000000..8c198ee952ff4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/stack_arg.c
[ ... ]
> +static int timer_cb_many_args(void *map, int *key, struct bpf_timer *tim=
er)
> +{
> +	timer_result =3D static_func_many_args(10, 20, 30, 40, 50, 60, 70, 80);
> +	return 0;
> +}

The result of the callback (timer_result) is never verified in userspace.
Should there be a polling loop waiting for the timer to fire in the test,
followed by an assertion checking that skel->bss->timer_result =3D=3D 360?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D14
