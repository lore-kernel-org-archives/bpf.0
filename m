Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00921380FDB
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124162; cv=none; b=ARJ9VV9/cS0L/6GQed4Tqs8tGVKkCOfvxIAVoOLiS0sNvnTE0mm2IYO4ZWDiJRhNh5r17ysa0ridlVvMQ1b2NkcajAm5QCdG8CW16weSjw1vyHMfnKEppAE1FZb1EscxgLDi3XuSUPRqd5LK6rvc2QQ2FB5pShj70Hjkwyfvoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124162; c=relaxed/simple;
	bh=IDkp1qEmW5HMnYT8xDHs2bziEMDzXA0W/mjgi+ut/fM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=slofqReezkBi4v2oHogc7SvfhwEDiXjSXmRwsicbbrlCjL5Hqp01+u+Tf8LwCPj8gcvHI823V/3XfIry4O1hn9dl+8QEWVhqZabG5AS05oibcQJJflXHBuT7atkHDSf7VjrCoXmGfT7XsQKESJzBjRee7Xhl1Un6RXgTYT8284U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YErxbABk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YErxbABk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53767C2BCB7;
	Mon, 18 May 2026 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779124161;
	bh=IDkp1qEmW5HMnYT8xDHs2bziEMDzXA0W/mjgi+ut/fM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YErxbABkE+D076nlS8pN3G8TBxzoc8T+3/WeL/zkdGGe3i7k+82Hety8pLlFdpkY1
	 G1hHJqfW1TtUWsM5PZzPufFOTdxqb959+6krBPNDfzCfE1NTb0BxADe5sl9Hpffh+s
	 u8g21saLPQtudn1v9diDvhSKwXknbljopZMBKRCGpGxMi7bs5N8x0DAzpbmYfm3Co6
	 VOwT5c7N+sTlU5fgsi3vH4+g1xfFe0lvk5xwlbbO1k7z8kOUIbz9AfGAX5I7toxgSg
	 whoKHiXtqAEPr4vk54LxCsp0DUSt3rGeSij+xafSWfQrORO0yEtBwQGPzpXHmelrGe
	 lQQxAJg086uoQ==
Content-Type: multipart/mixed; boundary="===============0915842576159487075=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86c3b9ef65bb65d98d90fb341c3ff0c278053fe2bf77f118084af3ff500c6e64@mail.kernel.org>
In-Reply-To: <be2dc2c3d85120286e60b3029b3338fff339f942.1779121582.git.paul.chaignon@gmail.com>
References: <be2dc2c3d85120286e60b3029b3338fff339f942.1779121582.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test for refinement of single-value tnum
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 18 May 2026 17:09:21 +0000 (UTC)

--===============0915842576159487075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index a3e4c0945137..bc038ac2df98 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1892,25 +1892,25 @@ __naked void bounds_refinement_tnum_umax(void *ctx)
>  /* This test covers the bounds deduction when the u64 range and the tnum
>   * overlap only at umin. After instruction 3, the ranges look as follows:
>   *
> - * 0    umin=0xe00     umax=0xeff                              U64_MAX
> + * 0    umin=0xe1      umax=0xf0                               U64_MAX
                              ^^^^^

The comment says umax=0xf0 but looking at the code change below:

>   * |    [xxxxxxxxxxxxxx]                                       |
>   * |----------------------------|------------------------------|
>   * |    x               x                                      | tnum values
>   *
> - * The verifier can therefore deduce that the R0=0xe0=224.
> + * The verifier can therefore deduce that the R0=0xe1=225.
>   */
>  SEC("socket")
>  __description("bounds refinement with single-value tnum on umin")
> -__msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
> +__msg("3: (15) if r0 == 0xf1 {{.*}} R0=225")
>  __success __log_level(2)
>  __naked void bounds_refinement_tnum_umin(void *ctx)
>  {
>  	asm volatile("			\
>  	call %[bpf_get_prandom_u32];	\
> -	r0 |= 0xe0;			\
> -	r0 &= 0xf0;			\
> -	if r0 == 0xf0 goto +2;		\
> -	if r0 == 0xe0 goto +1;		\
> +	r0 |= 0xe1;			\
> +	r0 &= 0xf1;			\
                   ^^^^

After r0 |= 0xe1, the register has umin=0xe1. Then after r0 &= 0xf1,
the mask 0xf1 allows bits 11110001, which permits both 0xe1 and 0xf1.
This creates a u64 range of [0xe1, 0xf1], not [0xe1, 0xf0] as stated
in the comment.

Should the comment be updated to umax=0xf1 to match the implementation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26047251229
--===============0915842576159487075==--
