Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCC1A9FB7
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695854; cv=none; b=j1/lXhbrzk63eQgCARMmZ4w7cU3+sXIdjTXFqSSKup+ijqT2ynsFGi0MPQiAbtcUfwwxm2B2O/GRbnpEMmyBoLDVHiAdErdXSMhckqrLZixU/FIaUE6ZhcR04xfOzJjwm2WkQFyzApaGlvvx3JvRR9QGx1hgjf26Rk8CzMcNyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695854; c=relaxed/simple;
	bh=oQAhsnrfP0sFGA5lLQfzHQsWZVuca2a07f1zgkLB1Cs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o6MmYsjgw3v9tLjLg4+brzY4vlURu2Oubql+jzGfj3pD/Xyf5FUjj0rI4RlCIFU4LDZgwv1YIV9UuHT5w1VqJpjFtu+1j21f2ojYjEz9WSucWAQXjlJ7iEFlKWNUgCXpqThpFSm49r8KBvjR08FkPqgAdZSAj/rqrV2WR+0D2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAtJVHFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAtJVHFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8981F000E9;
	Fri, 10 Jul 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695852;
	bh=y/afqsio6GacwzDz7e/Gy3GIvKAf1NRJu8FPHNAlIUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAtJVHFBt03JNzC3Nk8uBQ722KF51FN8m188aFaW6TnEigJvnZ81G/QtVIIah2WHk
	 kaUXByCz/67tBK1cCOivijmUf8QiGio1dYk1AGVRK8K/RLeis4ZTE25V795/wP8nK3
	 Lh1y+ssmQwkSDGmGv9qA94LAyGz66WB2quVnk38vLHH9zWG9CW5TvXKdsaOe6VX8Q5
	 hxDmcaU2qKUzFiICYlKKli7pkaMRReSGUzOOuTTmwdCNojS1YE3mUyN+ppjLwqIbSw
	 yyT3Z+OOF8OObg01fOxZCAjfdt32Jej99jgmHwnfpfv8s0az9J1rixLRryDVkKwI4O
	 Lz3pHCMmCxPCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test fentry link after
 tracing_multi link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710144734.78203-3-leon.hwang@linux.dev>
References: <20260710144734.78203-1-leon.hwang@linux.dev>
 <20260710144734.78203-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 15:04:11 +0000
Message-Id: <20260710150412.5E8981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test Flakiness due to Missing PID Filtering in BPF `fentry` Prog=
ram
--

--- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Test fentry link after t=
racing_multi link ---
commit 7dc95a7a3d3a0ca96e45e5ad2ebebe5157ae17ed
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Test fentry link after tracing_multi link

This commit adds a selftest to verify that an fentry link can be attached
safely after a tracing_multi link. It introduces a new fentry BPF program
and a corresponding user-space test case.

> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_at=
tach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> index cd5be0bb6ffdd..5ebbe3b602a4f 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c

[ ... ]

> @@ -11,6 +11,14 @@ __u64 test_result_fentry_1 =3D 0;
>  __u64 test_result_fentry_2 =3D 0;
>  __u64 test_result_fexit_1 =3D 0;
>  __u64 test_result_fexit_2 =3D 0;
> +__u64 test_result_fentry =3D 0;
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry, int a)
> +{
> +	test_result_fentry +=3D a =3D=3D 1;

[Severity: Medium]
Can this cause test flakiness during parallel selftest runs?

Because bpf_fentry_test1 is a global kernel function widely used across
various BPF selftests, parallel test executions might trigger this program.
Since the counter is incremented blindly without filtering by the executing
process PID, could parallel executions increase test_result_fentry above 1
and cause the userland assertion ASSERT_EQ(skel->bss->test_result_fentry, 1)
to sporadically fail?

> +	return 0;
> +}
> =20
>  SEC("fentry.multi")
>  int BPF_PROG(fentry_1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710144734.7820=
3-1-leon.hwang@linux.dev?part=3D2
