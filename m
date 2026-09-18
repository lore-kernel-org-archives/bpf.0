Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734A370AE0
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707663; cv=none; b=pCQA2Oltr2kg7JxLg9JyUI2NoDIfWf7bF9ggKMA4RRtqLPocI85hQu7Ofr2HtNufoHCtY5bQjMASakwYDmZDw/xLC+vnq87QwDy/+uZsyVPexIN5R5CKVGPL+/hvyZYcJN0d0+D+S9TChBt0+JpE+pJL0gvslvYKhOeoTZ/gulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707663; c=relaxed/simple;
	bh=PsYmFIlcc3p8t7bTmJ32wRcPQyvtw4GPeT9Sw47hJZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFmxWIUVQVTmXMe/WyPf6H1sje31VYjdW6NKghnSSLY25XwlGXrvkb8G1XhFb9eF36pHnkvZRUqfTK09fpweYwaLxqE8v7V7mI3H1bp3Om8roFyZSmRbXYfcoUNOf1cMI1dgtTf1EKKk0BhKPUj0kCgvS8dQoBCz94Q3VpxqeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbzEiB6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbzEiB6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A9F1F000FF;
	Fri, 18 Sep 2026 05:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707660;
	bh=HmVhWTsU8jNQ99++c45vuelIqwe628nyi+QcNYPFpo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbzEiB6l5E7cwDcqDfbbdF7LFL4A/tmguuUvk1bcc1ZnimnTRvKZJ4MNy81jThsWh
	 B4JBl5l+Or89SJ5SUC/LCVQgErqIh4SytkD0ROp3tBIuAbURVZMmZMV5xsTlF0eglF
	 3z6zybsCrvEr+lX//Sr9XlN0XycvqIbxQw7z3ZI8c3JqymSZ59IiBYQlmysm+bvs2N
	 My20fEDROg0CArzmGS8xpzEpP3DVYKptOgaKwvCEcuebOH6i61SBcBfszd+xEhlom+
	 +5N3VG2jMjXYk9vCO5WUhCBU97M1UaHUuhE1NqR0tKjtgjL44LUtxN4llYtr7+kB4i
	 Q6Ro5LvYqQFvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 19/20] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044337.3293731-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044337.3293731-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:01:00 +0000
Message-Id: <20260918050100.67A9F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation
--

commit 59a07b8ba8f5c3976a5da9bea3b5d6359874813a
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Cover the exception cleanup shapes the chain does not reach

This commit adds end-to-end exception cleanup tests for various edge cases
and shapes that the primary call chain does not reach. It tests things like
tail calls, nounwind calls, subprogram pads, and landing pads that interact
with the stack.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> index d1e45b765af26..ffc0b95191681 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c

[ ... ]

> @@ -35,6 +39,314 @@ static void run(struct exceptions_cleanup *skel, __u6=
4 input, __u32 retval,
> +static void test_shapes(void)
> +{

[ ... ]

> +	/* The same call site either way: the subprogram's throw unwinds into
> +	 * this frame and runs its pad, an extension's stops at its own boundar=
y.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment follow the BPF subsystem coding sty=
le?
Multi-line comments should have their opening /* on its own line before the
text begins.

> +	if (test__start_subtest("freplace_subprog_throws"))
> +		run_shape(skel, skel->progs.entry_freplace, 7, THROW_COOKIE,
> +			  RAN_FREPLACE);
> +	if (test__start_subtest("freplace_extension_throws"))
> +		test_freplace(skel);
> +
> +	/* A tail call that is taken: the walk ends at the target, so the cookie
> +	 * comes back from there and this frame's pad does not run.
> +	 */

[Severity: Low]
This isn't a bug, but is this the preferred multi-line comment format? The =
BPF
subsystem coding style mandates that the opening /* should be on its own li=
ne.

> +	if (test__start_subtest("tail_call_taken")) {
> +		int key =3D 0, prog_fd =3D bpf_program__fd(skel->progs.tc_target);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.=
c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> new file mode 100644
> index 0000000000000..f5eb2ff15c896
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c

[ ... ]

> @@ -0,0 +1,863 @@
> +static __used __noinline __u64 tc_thrower(void *ctx)
> +{
> +	/* Never taken; its presence is what makes this frame, whose spill the
> +	 * walker reads, tail-call-reachable.
> +	 */

[Severity: Low]
This isn't a bug, but could this comment formatting be adjusted? Multi-line
comments in the BPF subsystem should place their opening /* on a separate l=
ine.

> +	bpf_tail_call_static(ctx, &jmp_table, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D19
