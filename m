Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ACA378825
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854849; cv=none; b=BnEZULxbyyQHHmsLU/CcGs9Ry6kGK0njB/4WNxdcHq3LoppEW9L4F2OUQcxgFtOSTsksht5Joh9blh4t/tIMj7VMMEUmTZnUzG5ZohDglzgXrdwn3geLDPVvhJfnKJ68omO3BYtbwhwT9HorBLhFQszx4KUzg0axwhtK1UGkM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854849; c=relaxed/simple;
	bh=TXd+/68sQglUKzvvxBV2SfINPopmXFIZTzusivJeN7Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FgaYlTvruQXu9oDME02wodm0oD5lUjBGBJvcSsvOz45kQOhO62GtPXsPqs+00xKWxneuE/+YH/GtNN3F+Es/6kkal4NaLaoSsRUX15NAz3cHbNKrl+LX3GgUFz1VMOZuHWQO6bV5CPaLK36dffmR9Gc24UKC0vRQ8+4f82z5FEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBI7zGG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBI7zGG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF4E1F000E9;
	Tue,  4 Aug 2026 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785854847;
	bh=LrqBMcDlbWfG+k81Tgz6ACMEHgnYLm8hl2uVMGL1QYI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KBI7zGG3CgjD+hTNcrBv+tfbVxZO/fK7ON9AhYljb+n47pRfkHtm94JikE2h3Ld5a
	 gmf5Mv1FzNisXTcHcad8DpV3ebRPV47Sjy+Ov6KTdNmzfzZjdKPvxnPR7Chd9J81U5
	 TQTZnvJR0TlBXbajG8TRQJihm4XtNWZi5H3Bk9rVVRKIFqVih3/C2pxUseyWYZ6kLZ
	 pVEiQ9CrXwQKe7uhN8RRmUqQyWojveWI7gmMlwxhzfu6jUrAVdj8rEbtfckvnXiBqc
	 Dm5pgQlFxpEg/c1HUuzHaw/V1A5/jIHT0q/+y91oXIHHwg2E2F4mDQ9I9zwlhhbU8G
	 w1L8yIlsUnlfQ==
Content-Type: multipart/mixed; boundary="===============1611651014434636038=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8203f8266fa504ec5dc4719a590280be46d11dea934146476db1307829dc71fb@mail.kernel.org>
In-Reply-To: <20260804134601.2305303-2-puranjay@kernel.org>
References: <20260804134601.2305303-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Correct the overflow check comment in bpf_iter_num_next()
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Aug 2026 14:47:27 +0000 (UTC)

--===============1611651014434636038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index f5eaeb2493d4a..b235e117e206a 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -802,12 +802,11 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
>  {
>  	struct bpf_iter_num_kern *s = (void *)it;
>
> -	/* check failed initialization or if we are done (same behavior);
> -	 * need to be careful about overflow, so convert to s64 for checks,
> -	 * e.g., if s->cur == s->end == INT_MAX, we can't just do
> -	 * s->cur + 1 >= s->end
> +	/*
> +	 * s->cur < s->end while iterating, else s->cur == s->end == 0; the signed
> +	 * s->cur + 1 >= s->end holds even when s->cur + 1 wraps (start == INT_MIN).
                                  ^^^^^
>  	 */
> -	if ((s64)(s->cur + 1) >= s->end) {
> +	if (s->cur + 1 >= s->end) {
>  		s->cur = s->end = 0;
>  		return NULL;
>  	}

The replacement comment says "s->cur + 1 >= s->end holds even when
s->cur + 1 wraps (start == INT_MIN)". Doesn't the inequality evaluate to
false in the wrap case, not true?

Looking at the code: bpf_iter_num_new() sets s->cur = start - 1, so when
start == INT_MIN, s->cur wraps to INT_MAX. On the first call to
bpf_iter_num_next(), s->cur + 1 wraps back to INT_MIN. For a non-empty
range like the selftest bpf_for(i, INT_MIN, INT_MIN + 2) at
tools/testing/selftests/bpf/progs/iters_num.c:101, the test becomes
INT_MIN >= INT_MIN + 2, which is false, so the function returns the first
element.

The commit message describes this correctly ("the wrapping s->cur + 1
brings it back to start"), but "X >= Y holds" reads as "the inequality is
true," when what seems to be meant is that the comparison mechanism remains
correct under wraparound.

Also, the first clause says "s->cur < s->end while iterating, else
s->cur == s->end == 0". This doesn't cover the post-bpf_iter_num_new(),
pre-first-next() state for start == INT_MIN, where s->cur == INT_MAX and
s->end == INT_MIN + 2 (neither s->cur < s->end nor s->cur == s->end == 0).

Since the sole purpose of this patch is to make the comment accurate, could
the wording be adjusted to avoid asserting a condition that is false in the
cited case?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30915992491
--===============1611651014434636038==--
