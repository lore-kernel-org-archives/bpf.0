Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD123D7F0
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931134; cv=none; b=HdzeXpogEGP7yq+YWNgWEYEgysYxwEsCcHqzI7E0cBQsCAXTJCJpNt1JRu0MgA072dUl9dg/4jDDi4Ip0xTjTTeoqC/zdgRyC+8XA6LwJirNw9/tbjZKDyBzp2iBEc/iBjzRWiJyse4VlTvKimgd7ZTbWC5OTR4zhxDaFBqq9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931134; c=relaxed/simple;
	bh=XEngIb4x1lZ8GtG3ZRzv4aGqp50P/fT6eF/jbhkhodI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FZgDOoUPKUJJJgYZZnCPrOoxlQWIWOBI64oUmFYaob/JQ9sfygvsqFAp+dOYXrjn5iyKH0VA8G2m4HBsE5fj2aRGcVhzJLnH+aeJxe2U0jcY6iWWkHt7AJAh9gAHRijr17OCnCcVcArf1R+JegKoTKZ3jehyCZtevIRhI4kGR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C08gzr85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C08gzr85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EA91F00A3A;
	Wed,  9 Sep 2026 05:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931132;
	bh=2HK+8i0Z3NRyd7YCnzcoQa2z1Rwjdhej28WxdLb0flU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C08gzr85Nu8YY8UV+hUMsV4x2gFwKnVWy1uTkgpWTwC9BPI3+lpMyKZC9mHZJ2vgs
	 fq2VkyD/Nyi28KaRK7s+VlnW16Cvb8wvcwL/g2qvri25iLzB99Ig1VgP8256n3CJfN
	 oO9ZTJxyev6xnroMPF+0K1BvHYfYN8notqHY6hKMPLgdpb1KAuFUafRoqdm1S1KdPX
	 dw2SoXGfRjwk5/ZaCGlUP5MuAoglY2O9BgcsuzM/pgC26oFQKJXJvUfO19KzA55qev
	 cwnuJeFLuQEShgSwup+0Q7cWTPKMM2o2iYWlOTduUlAuKAafwJe/5h1Ckuku+gXIm4
	 cmhX/tQXIZYmA==
Content-Type: multipart/mixed; boundary="===============7339767047460865172=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae713b63e5eb5ea97f385b0e63ac8f2ba7ad3f44b28e76fd9386f1e1c51f71a9@mail.kernel.org>
In-Reply-To: <20260909042858.1734125-3-xyx2021@mail.ustc.edu.cn>
References: <20260909042858.1734125-3-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test slices escaping a clone call frame
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 05:18:51 +0000 (UTC)

--===============7339767047460865172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 1cd61d72c166..0704662cd32f 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c

[ ... ]

> @@ -1892,6 +1892,52 @@ int clone_invalidate4(void *ctx)
>  	return 0;
>  }
>
> +static __noinline void clone_slice_in_subprog(struct bpf_dynptr *ptr, int **data)
> +{
> +	struct bpf_dynptr clone;
> +
> +	bpf_dynptr_clone(ptr, &clone);
> +	*data = bpf_dynptr_data(&clone, 0, sizeof(val));
> +}
> +
> +/* A slice that escapes the clone's call frame remains valid while the
> + * shared ringbuf reservation is live.
> + */
> +SEC("?raw_tp")
> +__success
> +int clone_slice_returned_frame_valid(void *ctx)
> +{
> +	struct bpf_dynptr ptr;
> +	int *data = NULL;
> +
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +	clone_slice_in_subprog(&ptr, &data);
> +	if (data)
> +		*data = 123;
> +	bpf_ringbuf_submit_dynptr(&ptr, 0);
> +
> +	return 0;
> +}
> +
> +/* Releasing the shared reservation must invalidate a slice that escaped
> + * from a clone's call frame.
> + */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int clone_slice_returned_frame_invalid(void *ctx)
> +{
> +	struct bpf_dynptr ptr;
> +	int *data = NULL;
> +
> +	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +	clone_slice_in_subprog(&ptr, &data);
> +	bpf_ringbuf_submit_dynptr(&ptr, 0);
> +	if (data)
> +		*data = 123;

This isn't a bug, but would it be worth adding the usual `/* this should
fail */` marker above `*data = 123;` here, so this case reads the same way
as clone_invalidate4 just above it?

Every other clone_* failure case in this file (clone_invalid1/2 and
clone_invalidate1-6, including clone_invalidate4 immediately above which has
the identical shape) puts the marker line directly above the offending
statement. Here a reader has to work out from the __msg() string whether the
expected rejection is at `if (data)` or at `*data = 123;`.

> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34312284038
--===============7339767047460865172==--
