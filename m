Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3771194C96
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805373; cv=none; b=CJo5kuh3PxPakW2cgqPXijS69Pjgs4TkilHIqn4NHKnHvecZl+TsdKn0kj2kCrMMv6q763LS4TioJzglDMEoxEy7idMCJAHMXUObj8qymO70hDd8iNtK8paR6rY3XMQ83LEdW1jjSgmd2DlV0K30K206RAdXsQ7L8IDW8dcJUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805373; c=relaxed/simple;
	bh=OxE5vor/6FsIva0nY0wryyb7aV1jiveVgB1t6lyZ0vg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tms2c3T9KxQzA7IbkLbIhXA9AAxwnB5KHHtMMASyLVzECIPaKMV/pLwbwsGeq7KHReK+F07I+2HHrtn/AFAFLqsKvKh5PgCjYqNGsl7RMcGKr6NyhW/dQz+l/awvrEqBuO9AH3blkUwoHpuX+InLvA8dnW2LJ5HpK3z3u6oJwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnaMxcEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnaMxcEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB2AC2BCB0;
	Tue, 21 Apr 2026 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776805373;
	bh=OxE5vor/6FsIva0nY0wryyb7aV1jiveVgB1t6lyZ0vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lnaMxcEMBGRC8jLZWGI8oqcXmqvm1QHoVBhveTBRRhrSLsh6e7WEGCisUTepF33rg
	 Ef/imBADq9ZSLF+TEw5S/93MXrLip1EQAtA5uM9o8BX+cbjCZqaPYhzAT89CR79iw+
	 k/HqnDCifwSq1YjqNhntr/vnbnBjaOPTgjxjA7AQmkKkz4MyZ1Pzu1llJxs9hA9QH0
	 +SD5hFmRRwgqpa6n1bAUxxtQIvQYEAABa0Ti7pyppwKbGLFtNHbxAyPsaRBoGHtNB4
	 xDsnW5DncR4eJCADzwgnTKle6AcZNxiDFp/k+5J+SNdZALsYUeM17fZUJy3SS4yaR+
	 jaFkSj6uvkNzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 3/3] selftests/bpf: Add test for large
 offset bpf-to-bpf call
Reply-To: sashiko@lists.linux.dev
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421144504.823756-4-tangyazhou@zju.edu.cn>
References: <20260421144504.823756-4-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 21:02:52 +0000
Message-Id: <20260421210253.5AB2AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The selftest causes a kernel panic on unfixed kernels (when JIT =
is disabled), which disrupts CI pipelines and bisection workflows.
--

commit c0593c5f6291ee1a846f9c17858890ded3cd8ea4
Author: Yazhou Tang <tangyazhou518@outlook.com>

selftests/bpf: Add test for large offset bpf-to-bpf call

This commit adds a BPF selftest to verify that the verifier and JIT correct=
ly
handle bpf-to-bpf calls with relative jump offsets exceeding the s16 bounda=
ry.
It uses a large inline assembly block to force the verifier to process a ju=
mp
exceeding the standard limit.

> - Before the fix, the verifier rewrites the call instruction with a trunc=
ated
>   offset (here 32768 -> -32768) and lets it pass. When the program is exe=
cuted,
>   the call instruction causes a kernel panic due to an invalid jump targe=
t.

Is it safe to introduce a test that causes a kernel panic on unpatched kern=
els?

While reproducing the bug is the test's goal, crashing the kernel is highly
disruptive for CI systems and git bisect workflows that run the testsuite on
older or unpatched kernel trees.

> diff --git a/tools/testing/selftests/bpf/progs/call_large_imm.c b/tools/t=
esting/selftests/bpf/progs/call_large_imm.c
> new file mode 100644
> index 0000000000000..7cdf1e6d80d8d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/call_large_imm.c

[ ... ]

> +static __attribute__((noinline)) void padding_subprog(void)
> +{
> +	asm volatile ("					\
> +		r0 =3D 0;					\
> +		.rept 32765;				\
> +		r0 +=3D 0;				\
> +		.endr;					\
> +	" ::: "r0");
> +}
> +
> +static __attribute__((noinline)) int target_subprog(void)
> +{
> +	/* A volatile variable is used here to prevent optimization. */
> +	volatile int magic_ret =3D 3;
> +	return magic_ret;
> +}
> +
> +SEC("syscall")
> +int call_large_imm_test(void *ctx)
> +{
> +	if (zero)
> +		padding_subprog();
> +	return target_subprog();
> +}

Could the test be redesigned to fail gracefully?

If the large padding block were placed before the call instruction, the
call site would be at a large positive offset. A truncated negative jump
(-32768) would then land safely inside the valid padding instructions inste=
ad
of jumping out of bounds of the program.

The execution would then fall through and return an incorrect value, causing
ASSERT_EQ(opts.retval, 3) in the runner to cleanly fail without bringing do=
wn
the system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421144504.8237=
56-1-tangyazhou@zju.edu.cn?part=3D3
