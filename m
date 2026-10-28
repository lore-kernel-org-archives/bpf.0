Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222559;
	b=evpMC1Te30llC7tReHbsld7pgYtQeOwwAOlxLar45TnE6gl9MOh4rIcHT0iYkUjf+73p
	 gQkY0qOinyy8UN95JJ3THe7oBkfplTeeRXh8jY3ofDVq8gU6L4cAXyARV7bYqHa6/plrb
	 Ltbk5ucDBK/FjIXhExH3fXzS3eGIE9oU+GR0OkIStPlZEsH8zHDSNzgMIy/pW3Z69LDM+
	 8/FKUq/cL5i8ska5X8CVOYe1IXCx6/HhvrK3JXnQdiUog273vMqTzsgiJMX9zDOI1hn+F
	 9/TcD+Qpt4S3xgkbbtCdv06h8z6QdmnMf43lej8hZs02+9rdKKax5nD9Fi0UgUWAoCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222559;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kAQ7tBlQYavlf9snX1q18zYIcSo4eg7gEGdLnhqb8cY=;
	b=hJ3S3mKOx33EM+pd6a+8Tlvnqz9v4sG5XAF1uLI8RIDoSkurj8SUgbIAyohh3Am3bVfB
	 3E0qxvolwoILh/R+c6kdVsrHg8HpKmTKo9OUlikkDG5xowAmN0wjwcKmgPOyibGh+LUW+
	 IaKdZFoV6/gx8LERM31cCxthtRQ7cTNkOKPrWOK5G30LtzjggoiZq/JlIiWci5F3ro11c
	 YY5S5JOeopz8uC0nccdTFTQ2BDZij3IvAJg4MRsNhXxVH7uKkzjv+dZyb9b4kGzotN1WY
	 kCAKbBZqC0zqbjcTX+n3qNdXUrfj32J1cRjBy6sSsKDoH41OP2Pnb5C5mW0Il5PjnKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYcYOsRR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD67606A329;
	Wed, 28 Oct 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYcYOsRR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6171F01829;
	Wed, 28 Oct 2026 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793222558;
	bh=kAQ7tBlQYavlf9snX1q18zYIcSo4eg7gEGdLnhqb8cY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aYcYOsRRWXRVoQZo8o9WqX1U9ijj1Hb8dk3xMJs96Ie5PjTP+0eGHEJ6eJydTn4KN
	 8U+M/d2ZnV9EcOLVbIpuKHGX8GNowAUymJOYzMW4bcb97HuctYZLy8ECyTdyZ7iJwY
	 MksNcPBAN2tlwdmTRwKxoUtm8CFYO7JAiMv2Jva2qJA1ENwDkTAgc7brEF1pfB3DXM
	 PFFFuoDUL2paLjVcBTVYP6lz5+cFwpMuYNdUHlwJSc7/shbySLVRiTNa+oBLTu2Yir
	 K3ZJ/HsPG3tAOdODGxzcO7HKjAao1WHJShq1CwHQsyaWGvugq79m8m0zDQ7Svoj5Fb
	 gBKiSK4oxJeiw==
Content-Type: multipart/mixed; boundary="===============3658763065574181209=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3833268383adcd104d44051cbbb7687180f4e13bcccb0057e8747f2e10a5ad68@mail.kernel.org>
In-Reply-To: <20261028204158.1021284-2-vineet.gupta@linux.dev>
References: <20261028204158.1021284-2-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/8] selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jose.marchesi@oracle.com,david.faust@oss.qualcomm.com,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 21:22:37 +0000 (UTC)

--===============3658763065574181209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX

TL;DR:
- data_in_arena.c use_ops() isn't converted to CAN_USE_CALLX, so GCC with
  callx support may still call add1() directly; commit message claims all
  tests converted
- Commit message typo (nit)

> selftests/bpf: Build callx tests with GCC that defines __BPF_FEATURE_CALLX
>
> Commit 7cd1f73b37ea ("selftests/bpf: Fix build of callx tests with GCC")
> gated the callx progs on __clang__. GCC had indirect call support which was
> recently refurbished along with a __BPF_FEATURE_CALLX macro [1], so gate
> on that as well so once this GCC is released, the tests start passing.
>
> Put the arch and compiler conditions in a CAN_USE_CALLX macro in
> bpf_misc.h, and use it all the test programs.
>
> While at it, mark the placeholder programs left for unsupported
> toolchains and arches with __skip(), so they report SKIP rather than OK.
>
> [1] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ffe3ead4a8ad704b557b0cfa4f823df647c65a0d
>
> Measured on bpf-next with a stock bpf-gcc that defines
> __BPF_FEATURE_CALLX, test_progs before and after: 76 subtests run that
> previously did not exist in the report, 75 OK and one @unpriv SKIP,
> with no failures.  The two dummy placeholders retire and
> callx_rodata_lskel goes SKIP -> OK.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

The commit message says CAN_USE_CALLX is used in all the test programs, but
use_ops() in progs/data_in_arena.c is not converted.  It still gates its
indirect call on __clang__ and keeps the same comment this patch removes from
the other files:

progs/data_in_arena.c:use_ops() {
    ...
#ifdef __clang__
	return ops.fn(*ops.data) + ops.name[1];
#else
	/* gcc doesn't support indirect calls */
	return add1(*ops.data) + ops.name[1];
#endif
    ...
}

With a GCC that defines __BPF_FEATURE_CALLX, doesn't this still take the
#else branch and call add1() directly?  That means the GCC build never makes
the callx through a function pointer in .data.rel.ro, and the "gcc doesn't
support indirect calls" comment is now wrong for that compiler.

A grep for "indirect call" under progs/ and prog_tests/ shows this is the
only remaining gate.  None of the later patches in the series touch
data_in_arena.c.

Should use_ops() be converted to CAN_USE_CALLX as well?  That would need
data_in_arena.c to include bpf_misc.h, and it would add the x86/arm64/riscv64
arch gate that clang builds of this file don't have today.  Otherwise, could
the commit message be adjusted so it doesn't say all the test programs were
converted?

This isn't a bug, but there is a missing word in the commit message:

> bpf_misc.h, and use it all the test programs.

This should read "use it in all the test programs".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40768193895
--===============3658763065574181209==--
