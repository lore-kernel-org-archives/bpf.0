Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340D3B9DA5
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357733; cv=none; b=RbJZP+/qKeo9eGWZSj3wV70s+Mjhfc5Z7oryfepttXF15tivN17ik1tnS7noTY4/Y4A277oSLpSGXR+As0mxF+7JzFtDItJyHo2m6Q1SyRDqLGMdhvRY70TBcjekusdJTBA71LNMcSfNbWfBrTt3CsVOFYgMKys1oMLQnBrzPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357733; c=relaxed/simple;
	bh=3uSckf3MP8Ic+fDUJDwMj+ZxIM5+kp0HKPE0Ypz6scc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HpeDvyhThVHe+baFC+qAr0rRuhu6v6132K6/xHR4rDT8jxA/Iklm4ouPrkLgjaOBtD6Ykpy4iSd2ovDmdE1ShQAc2YCAopkTR+JYjlEXdb62IffE28CGGleMlKT5NaxuMwcx0hEq/JTdz7MRZAXVVmmXAnieGPsV9I0w58veQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/6G+LBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/6G+LBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A416C1F00A3A;
	Mon, 10 Aug 2026 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357730;
	bh=xS4OvKmluMZ3UtxuoqNzA82slYjossUonDgSnRqPc2U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J/6G+LBoQaAckrqRuXjq9nNS8r4udYd2je4QJ15C+T2lhvHP0wi4hYZhSzf/ArCBh
	 7AoD6lUqWdXwNPR8CZquFvJ/dR/lQMB+yKRcY+GbAZYJTyEi4k5grD8x+jf2d0rXO2
	 gx/2Hkw0052Wn3COVx8oPn5+15s5dyM+0gllYFsDiX0UP0xbmbbKU177YOH928nMb+
	 2ro7NyaCKFSLv5i1sBvEIcmhEp4Xsp3jvmNC9uyLzJBTXK0KDrrtks5sTo5papA/aE
	 KrgjwPWPzRB49UQVvDyU7gK+oXsQMoW8mYk+XaVgXD/h88wx4FEnWSFY96+GZkLxxC
	 Nzsw1ODNNPz8g==
Content-Type: multipart/mixed; boundary="===============4743473982158245139=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86fd4df54c74ea4deab367b47e594137099eb29d0452bca1f2a3d4d393df210d@mail.kernel.org>
In-Reply-To: <20260810092814.2698521-3-chenyuan_fl@163.com>
References: <20260810092814.2698521-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add regression test for queue/stack map size limit
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 10:28:49 +0000 (UTC)

--===============4743473982158245139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> index 41441325e179..8ab07ea77775 100644
> --- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
> @@ -101,8 +101,53 @@ static void test_queue_stack_map_by_type(int type)
>  	bpf_object__close(obj);
>  }
>
> +static void test_queue_stack_map_alloc_check(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const __u32 big_value = 1 << 20; /* 1MB */
> +	int fd, saved_errno;
> +
> +	/*
> +	 * Regression test for the u32 index overflow in queue/stack maps:
> +	 * a map whose element storage (max_entries * value_size) exceeds
> +	 * U32_MAX bytes must be rejected at creation time, otherwise the
> +	 * u32 head/tail index multiplication wraps and push/peek/pop
> +	 * address the wrong element. 8192 * 1MB = 8GB > U32_MAX.
> +	 */
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 8192, &opts);
> +	saved_errno = errno;
> +	ASSERT_LT(fd, 0, "queue_oversize_fd");
> +	ASSERT_EQ(saved_errno, E2BIG, "queue_oversize_errno");
> +
> +	/*
> +	 * max_entries == U32_MAX would make the u32 capacity counter
> +	 * qs->size (max_entries + 1) wrap to 0, permanently breaking the
> +	 * map, so it must be rejected as well.
> +	 */
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &opts);
                                                                    ^^^^^^^

Does this build? U32_MAX is not defined in any header reachable from this
file.

U32_MAX exists only in include/linux/limits.h in the kernel tree, which is
not part of include/uapi/ and has no copy under tools/include/. The BPF
selftests include closure (test_progs.h and its dependencies) does not
provide this macro. libc provides UINT_MAX and UINT32_MAX, but not U32_MAX.

Existing selftests that need U32_MAX define it locally. In the same
directory, prog_tests/reg_bounds.c does:

  #define U32_MAX ((u32)UINT_MAX)

Since the BPF selftests Makefile builds with -Wall -Werror and every
prog_tests/*.c is linked into the single test_progs binary, this breaks the
entire selftest build rather than just this subtest.

Should this either define the macro locally (as reg_bounds.c does) or use
UINT_MAX from <limits.h>?

> +	saved_errno = errno;
> +	ASSERT_LT(fd, 0, "queue_u32max_fd");
> +	ASSERT_EQ(saved_errno, E2BIG, "queue_u32max_errno");
> +	if (fd >= 0)
> +		close(fd);
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, big_value, 8192, &opts);
> +	saved_errno = errno;
> +	ASSERT_LT(fd, 0, "stack_oversize_fd");
> +	ASSERT_EQ(saved_errno, E2BIG, "stack_oversize_errno");
> +	if (fd >= 0)
> +		close(fd);
> +
> +	/* A normal-sized map must still be created successfully. */
> +	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, &opts);
> +	ASSERT_GE(fd, 0, "queue_normal_fd");
> +	if (fd >= 0)
> +		close(fd);
> +}
> +
>  void test_queue_stack_map(void)
>  {
>  	test_queue_stack_map_by_type(QUEUE);
>  	test_queue_stack_map_by_type(STACK);
> +	test_queue_stack_map_alloc_check();
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31375986836
--===============4743473982158245139==--
