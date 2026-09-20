Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0334274FDF
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886779; cv=none; b=EhOkIM+/fqkZQH0dPcKLVQkFzz4Y9VHwPCg2O9TmAGOCnOBbkgZZw59oSapLxshi0BjnU0paD2SJz4qetsokPM4nNPT4MXOKG5VQ81Aeh37i4/Is69wmgqe/O69+ELZxMb/3tw5t2a76R8Vy05yNkjL0w68L1TOZ4UFd6Yem8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886779; c=relaxed/simple;
	bh=0ewnm0OWwqkehTno3D9USYJxMQbvvBOfTwOq1gaVyrw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NoU9JZiGzLlC6RA/nC+2JzrQlJmaYlCrXqOLiY4fWutXJQPvebQLMrGFvE9SC4Qdyt7kDiBFIKtQZJCOUB6v4KamEtalBtdoUYVb3iWqjkAj+zihvOvhGAU1SWF6GrQAti8ogznZQyVVX90luuJKd2Ky7gmQfksxMoLp3BNXNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRdq8kV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRdq8kV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F31F000FF;
	Sun, 20 Sep 2026 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789886778;
	bh=LZUab8HDFJlk6jiMm3z2U4uXXflw79luUCnQA9en7/c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SRdq8kV+oxXKYQy4a0AbgKfnvjwdfQaR2ZDGApIwt6N0FbYTLYe36pM0mMH4XdG/e
	 oHi/+oXtIrwdNnoo8ATMSJcSpHuYS5+dAE14gb1YJUYUmjrzpjj0NrkOg0knhHQL81
	 3Z1YcCKTXptSPnpaDNsnOPYol20Nl5peHXmor/aqXFL5XYE1BzcT/zzype6DFUYMbj
	 SzWWwgFnBkbtHlPSjQa+DfkuirQpYUmWkLC2ZrgttJ74WO8Ohyac+ON4xgCRTqcwBa
	 qlhss7hV2p8a+jlf1N5f7NB6s8qX7SvtPEBGpDZYZMFH7TsOl9CZ/5gRWaTLzXZrlz
	 Iv1xo4VODj73g==
Content-Type: multipart/mixed; boundary="===============2324568164195763831=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37c6c163cd23d9760d1d08616706cb1ee8c4ae4799150a8ad36544453670161a@mail.kernel.org>
In-Reply-To: <20260920054403.874319-1-yonghong.song@linux.dev>
References: <20260920054403.874319-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 19/20] selftests/bpf: Cover the exception cleanup shapes the chain does not reach
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:46:16 +0000 (UTC)

--===============2324568164195763831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> new file mode 100644
> index 000000000000..493f8e030652
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c

[ ... ]

> +/* 2. A callee called from both a covered and an uncovered site: the pad
> + * belongs to the call site, not the callee. Either site can throw, and the RCU
> + * lock between them is what an unwind out of the uncovered one leaks.
> + */
> +static __used __noinline __u64 shared_callee(__u64 x)
> +{
> +	if (x > 100)
> +		bpf_throw(THROW_COOKIE);
> +	return x + 1;
> +}
> +
> +static __used __naked __noinline __u64 shared_frame(void)
> +{
> +	asm volatile (
> +	"r1 = %[input] ll;"
> +	"r6 = *(u64 *)(r1 + 0);"
> +	"r1 = %[outer_input] ll;"
> +	"r1 = *(u64 *)(r1 + 0);"
> +	"call shared_callee;"		/* uncovered: no pad for its unwind */
> +	"call bpf_rcu_read_lock;"

Does the shape 2 header comment accurately describe what the code does?

The comment states "the RCU lock between them is what an unwind out of
the uncovered one leaks", but the uncovered call to shared_callee()
happens before bpf_rcu_read_lock() is invoked. When the uncovered site
throws (which prog_tests/exceptions_cleanup.c tests in the
shared_callee_uncovered_throw subtest with outer_input = 101, input = 1),
active_rcu_locks is 0 and there is nothing to leak.

The verifier would also reject a throw with the lock held via
check_resource_leak() in kernel/bpf/verifier.c, which checks at
unwind_finish() and refuses with "bpf_throw cannot be used inside
bpf_rcu_read_lock-ed region" if active_rcu_locks is set.

The lock sits between the two call sites so that only the covered one
unwinds with it held, making the pad's bpf_rcu_read_unlock() observable.

Should the comment describe that the lock is taken between the two sites
rather than before the uncovered one?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============2324568164195763831==--
