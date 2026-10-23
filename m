Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716597;
	b=p53M2wGNo49/g2WtKnz6/V5GomDJmFwFdWomUaLPVNrJ2doMzZCLcRGR0GGSleZbjvep
	 Y59PtVPbmnrwQrNrwhT8s/HgLZciiMegrftx6kki+KOzmQINYgfZzV81Xo1+UE5z6mL23
	 jG6Jt0OPJDzLVFYk8t97LIRiwH+NayzBQBUlRJSieaFW3tjT+8X0fB0os+nmzSgT7RUut
	 NrhpmKLBftg8QtS5AQ8Tvmm1FFXUR4Rtq0ehchgmOQROP8IuI+l3Z8WKi9amQDwQnAGQ0
	 hV7ymrB+D+YGWTCmy+6drGot9eKCHeIPT/4KuEHSSxSkD65qWwg8IEclv2mKiTf2ZPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716597;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=5IT8lcQuEHk4+YLkTHf+j9Bw5J6DUkGoAxexESbLW2w=;
	b=u7U0vzF2EqUazPssncuOZZiOkEEl/RYxc9kNzDd8r+Q2pmJhPIt1KyUBMtc9EjzjTGEK
	 PO0KiGvlT0t1spRqVU257xUbF/x5QSc+WUTxSts/kd/rYLS1eD2/1DngIL4LjLGZyiD4v
	 iYe13e/x81QnA4qOhpILWVDwiKdpHwr2hQqqPgiXUwk6rAWm58DHehHnuxV9MT/dxW4Bs
	 naPOy995yzZi3KJq3PnEZ2FLSZxkTvrW+Ih7vF4dyXg5KNDbLL6Z/lU8Q/mrzRITxoBe1
	 8EgoFBakwd//sHkcAAm/cF6PmW1YPfaqht6bWg1r1hPcQQ0N+6/BhhZI6jfRbjEFEhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWJFB4Dc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E902606A319
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWJFB4Dc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6821C1F01825;
	Fri, 23 Oct 2026 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792716597;
	bh=5IT8lcQuEHk4+YLkTHf+j9Bw5J6DUkGoAxexESbLW2w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NWJFB4DcsqwLOGXnQ1CrCIrXTuVeLWzyAk1usmtWmchPA8nUqlDL0rT+MUOXu3XJV
	 NFD5zxr/AnqmiM5HkrUhKUyOfBJ+W5ApjdB8ycCHuGsDQK9kmnbwtzuN9Uygco7ybx
	 yzHOue8C4rmageqfan3SRZFwEQcnJKMlThzO6eSsHVLHSff8HJkfAGX9AvjYPVjqO7
	 Fw9c75C9vXIcXb2qBCqwfDQ8fOjWtCRgeHkZoX0wKHOIyOptGHf8u/5KkdoeoPGbrT
	 qnJvfZy92F94d96D6jA2nk9guhH+qIu8i9ErqaUIBsu3FafUDaAJDq787aVOCXtN6u
	 l3MohBmUGGjag==
Content-Type: multipart/mixed; boundary="===============1835415968709184545=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <34442f2421f6736cd80dee1fedf5e6754a900344c0d5e48568cad914507e03ab@mail.kernel.org>
In-Reply-To: <20261023002056.6647-2-emil@etsalapatis.com>
References: <20261023002056.6647-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 1/7] selftests/bpf: libarena: Add bulk buddy allocation helpers
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 23 Oct 2026 00:49:56 +0000 (UTC)

--===============1835415968709184545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Add bulk buddy allocation helpers

TL;DR: Nit only: the comment and commit message say buddy_free_bulk() fails
only when the lock can't be taken, but it also returns -EINVAL for NULL
arguments. No functional problem.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -900,4 +950,40 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
>  	return ret;
>  }
>
> +/*
> + * Fails only when the buddy lock cannot be taken, in which case nothing was
> + * freed. Objects that buddy_free_unlocked() rejects are reported there.
> + */
> +__weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs, size_t naddrs)
> +{
> +	unsigned long flags;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!buddy)
> +		return -EINVAL;
> +
> +	if (!naddrs)
> +		return 0;
> +
> +	if (!addrs)
> +		return -EINVAL;
> +
> +	ret = buddy_lock(buddy, flags);
> +	if (ret)
> +		return ret;
> +

[ ... ]

This isn't a bug, but is the comment above buddy_free_bulk() accurate?

It says the function "fails only when the buddy lock cannot be taken", but
buddy_free_bulk() also returns -EINVAL for a NULL buddy and for a NULL addrs
with a non-zero naddrs, before the lock is ever attempted.

Nothing is freed on any of those paths either, so the contract that a
non-zero return means the array still owns its objects does hold.  The later
transfer cache patch relies on this: buddy_cache_spill() in f23ed100d6eb
("selftests/bpf: libarena: Add a transfer cache") treats a non-zero return
that way.

Could the comment say something like "Fails only when the arguments are
invalid or the buddy lock cannot be taken; in either case nothing was
freed"?

The commit message has the same sentence:

> buddy_free_bulk() fails only when it cannot take the allocator lock, in
> which case nothing was freed.

and could be adjusted the same way.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39878206535
--===============1835415968709184545==--
