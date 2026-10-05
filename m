Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C974D4896
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227242; cv=none; b=UpFZnhL9lwDaqIZc7zOAA3y7Bn5bl/PgbsaasSiq8zYp1oFz/jZN0Mt9nH4QmFOwogzeZTG9rjsmpxL5D/iAfrbt1nSYvhUhv/F8F6GO2d/4l3iJw3lxygy8SXdj8HK5s92ZTU/mv4k5jisuExNErN8NoQMEqqHLGE0ZS2n4L4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227242; c=relaxed/simple;
	bh=1WSmRvjWV9HGILmhj9Wv5qI2aLp44kNH8VVeNd8YtcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5ROwOdv92wUQOhD8aw/HCL+uQ1keemC/0i7X3qbL09CmGji5Oj6cicvNzbHtcMLwAqhFuYo1q1DXh/n2Yp93rY+4DAfBFfLbpEyJ/G7MTSNisqgSeWXk2SSwJsSehcV0pvpfSn3gdA2WBsm8l1xrwMy3tuVN5xN5aGquun4zTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyx0W+48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyx0W+48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DB81F000FF;
	Mon,  5 Oct 2026 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791227241;
	bh=Q5kazcx0xiXiK7YEqV+i7FgdmVE/mNIcWe0SuoyEYGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyx0W+48G+zVvyBI26LRhzRhez3xwUkTOqfPVUXOS17soLliefEi6H6j4/Sx2Ld2x
	 raIMTYXW3oemBX47zZgGyIGAurC1eiQspMViN11DMNmY5EetbfQWFB1SANEviRA+Xn
	 3MhiqxcBY/ykkA7clZGjoDr7EeH6Eo5kONUTnhbMpUuIrwinotn3yT4Sz1ooz8ryTv
	 O3xtjsFNd42Upi235sUm6DGHW2vsa8HKC2XnaMnIU+ehgXmQPTV0RLX4PhTkKJDs5K
	 s+F2KrpVsZ50aS6JWMsv6aOybt56Ma4KaMJJnsLjw78aAKNas6QsBaVhBoY9vSIxZO
	 Z9Kb2CDRbFS1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] m68k, bpf: Add initial BPF JIT compiler support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261005185251.2422114-1-visitorckw@gmail.com>
References: <20261005185251.2422114-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 19:07:20 +0000
Message-Id: <20261005190721.44DB81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: m68k JIT triggers page fault by prematurely locking subprogra=
m memory
--

commit fa231b58c29a2f776715a46043e7efdefca56e74
Author: Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: m68k, bpf: Add initial BPF JIT compiler support

This commit introduces a BPF JIT compiler for the m68k architecture. It
generates m68k machine code targeting m68020+ processors and coldfire parts
with an mmu.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c
[ ... ]
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
> +{
[ ... ]
> +	if (bpf_jit_enable > 1)
> +		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
> +
> +	if ((!prog->aux->func || extra_pass) && bpf_jit_binary_lock_ro(header))
> +		goto out_free_hdr;

[Severity: High]
Could this condition trigger a kernel page fault when JIT compiling BPF
programs with subprograms?

When loading a BPF program with subprograms, the BPF core invokes the JIT
compiler twice. In the first pass, prog->aux->func is NULL, but prog->is_fu=
nc
is set to 1. Because this checks !prog->aux->func instead of !prog->is_func,
it evaluates to true and calls bpf_jit_binary_lock_ro() during the first
pass.

When the second pass runs, the JIT attempts to write the finalized
instructions to the already locked, read-only memory buffer, which would
trigger a page fault.=20

Should this check use !prog->is_func instead?

> +
> +	prog->bpf_func =3D (void *)ctx.target;
> +	prog->jited =3D 1;
> +	prog->jited_len =3D image_size;
> +	goto out_off;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005185251.2422=
114-1-visitorckw@gmail.com?part=3D1
