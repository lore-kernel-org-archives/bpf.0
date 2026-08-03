Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1117A2FB
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764134; cv=none; b=QXRvCJTv2zB5//c6i74ZK8o1J9KnLLo3BMUu4cWuw0Xieny8y7fzZaa3K/BpvxYMjq3eG/4y0irXlZA4kp2GXQfHpG8b0KJ3sq5rSPFmOghKnvOAz45pgkDP7QyEyDX6x4HiamnZFBX6NI1giIBicdnzX+dxS4aTRJ646qNLGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764134; c=relaxed/simple;
	bh=jDcWkYATquljf8kqSzc0Z2GUfra2TKrTR67BEh/TX74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eq7rggRnEOPMuBi363fx/5DSDC0t8wE3LDxICcJWm/wR++VZHyWRz9jKt58pJOywZrKruUcxt5NruqzX16HF9casjStppD3/z6Hq8OOHZTAZzPI1h17yp0jp9d71tLgatJeakAH9ZsccWFsngaTcnkQSf/xG6iaeAy9frAaudAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbcnJrKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbcnJrKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3051F000E9;
	Mon,  3 Aug 2026 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764132;
	bh=xMPzUUnaXWdj8lVbmr/iwpiGLvbEz5nwDipNZtE91hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EbcnJrKE1J5T2cUWwUXQOO564uj84SQYTH3b6sVDQPl3i08mrPj6CKwpivusSxPIB
	 2hZzug6kxlDTw0edhyh1BZy1fUUQNtCspelzRQ6XjuDt9if77agkknY3rpa6/3rSjM
	 LBBP4+sRNJLZ7Yzk945HN2MjADT0YrsvT/IeJikLFYB0q6ulwJ6umPwMS4lxYNtSXA
	 IDSsS3r5dVTmZEHoz14Duioumd7tUPxFK2Z1jQncP8By+Is8AxqPbHydgYTbVuvnmP
	 DucRLOt8PutLe0VfeyvvmMWqEg+xmv0RqLGfSzmW07dK+jZxlAYVuhkcGtaCE6z1Ef
	 xeac3btrQHfJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803125115.2264733-6-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:35:32 +0000
Message-Id: <20260803133532.BC3051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `arena_arg_stack` test incorrectly wraps its failure-inducin=
g logic in an `#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)` block, which cau=
ses the test to falsely fail on compilers without this feature.
--

--- Patch [5]: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and=
 __arena_nullable argument tests ---
commit b62ba0a2046a4e44e0da5d972133d046f475c161
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add kfunc __arena and __arena_nullable argument tests

This commit adds arena-argument kfuncs to bpf_testmod and a corresponding
suite of BPF programs to test various argument forms and rebase semantics.
The tests are intended to run on x86-64 where JIT support exists.

> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/test=
ing/selftests/bpf/progs/arena_kfunc.c
> new file mode 100644
> index 0000000000000..e7250c5197ab4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
[ ... ]
> +SEC("syscall")
> +__arch_x86_64
> +__failure __msg("arena pointer cannot be a stack argument")
> +int arena_arg_stack(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
> +#endif

[Severity: Medium]
Will this test incorrectly fail on toolchains without
__BPF_FEATURE_ADDR_SPACE_CAST?

When the feature is missing, the #if block evaluates to false, leaving an
empty program that simply returns 0. The BPF verifier will accept this empty
program, but because the test is annotated with __failure __msg(...), the
test harness expects the verifier to reject it.

Since verification succeeds in this case, does this cause the test harness =
to
flag it as a spurious test failure during CI or user builds?

> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803125115.2264=
733-1-memxor@gmail.com?part=3D5
