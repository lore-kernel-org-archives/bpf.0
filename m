Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0902213E9C
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785804; cv=none; b=ErDDB8AaUeSN0GJxakVaFwAnTqEy3pLUybF0PQTGjOnFhRlllIUa27ZzHviocR2qUPThn20YLkPmU+nbd+FIpzEm/eB68L3Dc2ThpacJSVte43kAjyM/P6ed/S7sjUzlkyO/Je5PQjgDquimeNyZO7XkifbpcLf66XIyCn+YT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785804; c=relaxed/simple;
	bh=44q4fiGd17ezwKcivgTVaFF0Wf8IQOJFG36Ugke6+FY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YCxUNmiJY/WfdvQnzN0OjQk6YyRMUyh5MOg8ukV+pdTWPPwYb8ausrsIwX1/r+tL4BYuPPqr7iv+Mkthu2VwK/m9XuRlACiE5HXVeJkooYuBLqDLBLgcIOAulBWbWPrO8NYgFQ+2GMoPq3wi2ePNT2zBEs/3c51YVJ127gIGjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnsDH75X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnsDH75X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA8DC4CEF7;
	Fri, 10 Apr 2026 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775785804;
	bh=44q4fiGd17ezwKcivgTVaFF0Wf8IQOJFG36Ugke6+FY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VnsDH75XCXDC4Y8kxPzfcbfwlDer/kiKTHC70w945+AVUbBfMxUQvEFGgD7hGdJ05
	 77BDDGZw+PmLh6tT8poJcB7FXNjRbwaefskf5swEuOa6kAxaXsCgRtKKkIGwNFR5IA
	 dsxJkD9oKO+9Gw8jf3E0nc2vjxGLaYJSMFL97EmSb63cVOPtOH+XT+5Yr55t8/pylp
	 xU+d21QHKm8eSRbpcFF/2xqc51fJM490AA/5ohdfRYF5FCnGyxbOBN43V/yWGoph6B
	 jP0uSxD2qrtQVHxZLgTx2A2Lj/yrDKGfl5x9/2sqrqfkPoE4RgyKGxY8uBZZJKLqnB
	 Kg57NX/Y5L/8g==
Content-Type: multipart/mixed; boundary="===============3175991978239558108=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d7f8f5857c7ba5ca8b5cbf34e001d1ff7afda61513f35e14edb441c5eee1d9f@mail.kernel.org>
In-Reply-To: <20260409-patch-set-v2-3-651804512349@gmail.com>
References: <20260409-patch-set-v2-3-651804512349@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 01:50:04 +0000 (UTC)

--===============3175991978239558108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 410939d7b325..124828c9a916 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> +static inline bool spis_test_bit(spis_t s, u32 slot)
> +{
> +	return s.v[slot / 64] & BIT_ULL(slot % 64);
> +}
> +
> +static inline void spis_or_range(spis_t *mask, u32 lo, u32 hi)
> +{
> +	u32 w;
> +
> +	for (w = lo; w <= hi && w < STACK_SLOTS; w++)
> +		mask->v[w / 64] |= BIT_ULL(w % 64);
> +}
> +
> +static inline spis_t spis_one_bit(u32 slot)
> +{
> +	if (slot < 64)
> +		return (spis_t){{ BIT(slot), 0 }};
> +	else
> +		return (spis_t){{ 0, BIT(slot - 64) }};
> +}

Should BIT() here be BIT_ULL() to match spis_test_bit() and
spis_or_range() above?

The bitmask is stored in u64 v[2], and BIT() expands to
(1UL << (nr)) which is 32-bit wide on 32-bit architectures.
For slot values >= 32, this would be undefined behavior.

spis_single_slot() passes values up to 127 through here via
spis_one_bit(spi * 2 + 1), so on a 32-bit build both branches
would hit shifts >= 32.

Note: this function is removed later in the series by commit
6314c1b64c52 ("bpf: simplify liveness to use (callsite, depth)
keyed func_instances"), but it is used in the intermediate commit
3199040a2cb9 ("bpf: make liveness.c track stack with 4-byte
granularity") via spis_single_slot().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24221779050
--===============3175991978239558108==--
