Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67762139C9
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287499; cv=none; b=LpUZ52siLnbIs7jABcgkol8jP5eJBZge8svXummdu1gVKqniqSOR9KRbauym2sIyJMtVVkN/HXbZJPdPIR+j+sbBMKi5PRqEuNBfhvpzc0fnQSkpMM4nHfeVRGUN8cfSFIVFk2t4e8ktlGaNOLZimiR/CCuV9OzVDWYTgZNcnW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287499; c=relaxed/simple;
	bh=c8rp9kmmN+Cyv/k//QbCJcn+p1GYGWNjgiKOWWHQNCM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lhDbEQ9hO59puOnCv4iQt8q73RrqlIH93oTqNL2xtUoCaDD5E7BMG6MpB3O3qCV3u5Xf7wmx8SL5EHJU8POlrbX6JtRegOtLwh1ptuYfJ+6jfxWhNCxik4zdhDASX2VASlSySY76ha8R/y5aw7qysKCmTEnqedw/MHgjN+fyy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6q2MWwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6q2MWwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DD1F000C4;
	Sun, 18 Oct 2026 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792287498;
	bh=ocPgm/n1PmCC/DZ9RyVxOVZYExcMpYWZIXn5CVSzLGI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=a6q2MWwa15FEDmb2Hkt3c6Kwhf0NXsTPlGgMSXWyyuwZwL5L2IKDJS0gxU37iIKYd
	 Nwj9TuMBGQwO6D1tcw5sZW23ubcYqAg7XvYk82Z68HyUpHwoxC+AWU4eHm33bM4cRp
	 HWax+hSyJ1CtnbOqfGkB9n7dc4nBZjQEHNon69ULR+d4Wl45eW8F8P+z2Y+N4F8+hc
	 dkV5x5QbwyzsiWKLCYxM8D9njMcEZauNBE+KP0EqSna9g7x88RD48l5pnhed1q8EKA
	 +X8J0NI0WWD6aiecfPTIJ/rIxwClfqeB976svmw0+WeTGgz7gJ40j/pjF5P3QU2VZa
	 cO4k4aZReS28Q==
Content-Type: multipart/mixed; boundary="===============1834638559549938750=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <82a0d7f7c3e52fc72b8b790724b1fc02abcc305e2c7444bac55701a280a098f3@mail.kernel.org>
In-Reply-To: <20261018010246.1643877-6-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add a C++ prog with exceptions
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 18 Oct 2026 01:38:17 +0000 (UTC)

--===============1834638559549938750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add a C++ prog with exceptions

TL;DR: Test nit only: test_unwind_cxx() skips silently in three different
cases (no object, llvm lacks unwinding lowering, JIT disabled); consider
printing a skip reason, though existing tests do the same.

> diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
> new file mode 100644
> index 000000000000..6a189045851f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c

[ ... ]

> +void test_unwind_cxx(void)
> +{
> +#if defined(__x86_64__) || defined(__aarch64__)
> +	const char *file = "./unwind_cxx.bpf.o";
> +	struct bpf_object *obj;
> +
> +	/* gcc flavor doesn't build it */
> +	if (access(file, R_OK) || !llvm_lowers_unwinding(file) || !is_jit_enabled()) {
> +		test__skip();
> +		return;
> +	}

This isn't a bug, but three different conditions end in the same bare
test__skip() here, and none of them prints a reason:

  access(file, R_OK)           the object was not built (gcc flavor)
  !llvm_lowers_unwinding(file) llvm has no BTF decl_tag "unwind" lowering
  !is_jit_enabled()            the JIT is disabled

Would it be worth printing which check failed before calling test__skip(),
for example:

  printf("%s:SKIP:llvm does not lower unwinding\n", __func__);

so that a reader of the test_progs output can tell an old toolchain from
bpf_jit_enable being 0?

The subsystem selftests guidance asks for a reason string with every skip.
The same pattern is used by test_rust() in prog_tests/data_in_arena.c, so
this may simply follow existing practice.

> +	obj = bpf_object__open_file(file, NULL);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39085585797
--===============1834638559549938750==--
