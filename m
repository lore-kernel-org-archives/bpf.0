Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405888;
	b=5XmaUK1vuoQYofexKl05r59D4BZ5eziQHe8Qgva0/yqiYrJl85YMP/01e/Nyfq+1Lcp/
	 I9BToI7h1qGbgzNa0jI1Z3ci0x9ymbU7lTK+GS+x/3kZgO1KIt84cmYgPq8gTnhql+iS8
	 mVh9xA2JuGTEhRWcwPZe3tYLcEk4WRUYzriJXsnZzNDK8NDe86aU5sZ4VjyXy2imZEACU
	 bf7a5ipwz4ed5AdyDO77p2gF4PiPPLmy0qBqCgYmF+EOfgpuLbeJak4dvLK4jQ2t5gXFn
	 k9RgDbXAPEVp3GtrD5oGUSqfecxy8xDjsj3NT3mGydM3ZAH1pl4uE5Vgow01jSywdnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405888;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=bTwOPLcSFEHy2YtPOhTSuvQ7z6hjEY2evq/yScdAuLk=;
	b=rHJQETE0hu+iNDHVy3kN0uSVWca6Xj4Q+LoVtFIxPA0sUe+S2y9wtbeGarp99bwEuIgA
	 5rbpiMVw0lNGBbglPKDL6dI3x7NyNvgigKNU5GdsTc3C5ekgApHpM+yeeDubO2/j7pe3O
	 tNuvbbvK2DNJAAUfOTlWgPZEMnvr++iXHWJMJ5E8QW0NUXKULCz519mU3fHDd5pXp/NUL
	 646pkFNh0FsgBRc8Qufa0eBiIgPQ4d6ABXOgQmRQoM5VrMPg42JpmI6NcllojXPhBVRUG
	 /2C+f+cxTQ7y9sSiIVk4qqYnhVdKb0guvBrJVaJ4+yH0hBukhyUV5x0PNRrV5DAAnAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr1Bf22K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C6606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kr1Bf22K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371511F00A05;
	Wed, 11 Nov 2026 14:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405887;
	bh=bTwOPLcSFEHy2YtPOhTSuvQ7z6hjEY2evq/yScdAuLk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kr1Bf22KtF6u+5tupU0xHEA4yMI+SmTIKXrDdXlYyr7rjBE8ZXprl6ecQ8IzNnZq1
	 YmqD5JllXGxF2jqDE+FRXOUqovCsg6kaFm/+I2IHUGMobm8gUx5dd7zAyNrqg1Ix/C
	 5tae5dbBpGaBM7r2HVcsdHOIxSUzD7Jh81BHDAm4x9q1wTkPSkOhcDjuASPUx2uh08
	 SqJGXjxor/B9xihc6LdHbGXSc4Col5xSYhqBGES1Idv2sjW0C8zuSpizG1rYk4FSXA
	 6qk49XhPHOSAw3hlzoEurQPGnxJn69sH4UuHD3Dc9S7LmIZF/5R6ITm24L8LVydphg
	 5jnt+fexItKrQ==
Content-Type: multipart/mixed; boundary="===============3240238601841082241=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6d9cf4ae1f2c4d35307592b2b147ee5fecf009b09e047e418bb0914e67d20736@mail.kernel.org>
In-Reply-To: <cd23f7c9bbe266852c979693ad25d72fdfc95616.1794399387.git.memxor@gmail.com>
References: <cd23f7c9bbe266852c979693ad25d72fdfc95616.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 15/29] bpf: Describe handles in registers at throw sites
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:47 +0000 (UTC)

--===============3240238601841082241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Describe handles in registers at throw sites

TL;DR: Nit only: the set of registers a throw site can name is defined twice,
in ref_locations() and bpf_frame_desc_kept_regs(), so the two could drift
apart. Suggests sharing site_regs[] and naming the literal 4.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c

[ ... ]

> +/* The registers of frame @f of @st that are kept, see bpf_frame_desc_keeps(). */
> +u16 bpf_frame_desc_kept_regs(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
> +			     int f)
> +{
> +	u16 kept = 0;
> +	int i;
> +
> +	if (!env->describe_regs)
> +		return 0;
> +	/* the registers a site names: R6 to R9, and all but R1 of the frame that throws */
> +	for (i = BPF_REG_0; i < BPF_REG_FP; i++) {
> +		if (i == BPF_REG_1 || (i < BPF_REG_6 && f != st->curframe))
> +			continue;

[ ... ]

> +	for (k = 0; k < (throws ? ARRAY_SIZE(site_regs) : 4) && loc->cnt < BPF_RES_LOC_MAX; k++) {

This isn't a bug, but the set of registers a site can name is written down
twice.  ref_locations() walks site_regs[] and relies on the literal 4
meaning "the first four entries are R6-R9", while
bpf_frame_desc_kept_regs() rebuilds the same set from a loop over R0-R9
with its own exclusion test.

Could bpf_frame_desc_kept_regs() walk site_regs[] with the same bound as
ref_locations(), and could the literal 4 become a named count of the
callee-saved entries, so the two definitions can't drift apart?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============3240238601841082241==--
