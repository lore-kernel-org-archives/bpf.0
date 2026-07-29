Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E53D45D0
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358631; cv=none; b=kCxHPWHe15Od6UUyoANjBvOfpNFRXdj/Rpu1Sw6wuJQfdy5lEq8VZdHdLsXJewm8lNLYBs68gS/6B8uU+oPhvEVSlcbgnYfdxQWJVqFwCT2QxdIu3sfxnsv+uZFzKu0AfXRGTUj/pqvv/akkuvzBnQ+pkxl/W2JH8J6ayUiOfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358631; c=relaxed/simple;
	bh=yihkv+xuBlxAKJiKlSJNJ40jM9kfeYA+kNT+iwN9Dqw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ECC+TKbUTeib60VhgvUFjfczAl/YOum8sT2xVQrN7wYm+TUeVsYMPouvYuD17Uwp5ECv2shG0pgGfGNZ9Pe9mWulQ/OU4zWw8SCwiVxHqGXCwx0F3Hg0/lQSaVEYnZeD3kJFqC5xAzaXZGkPRTJZtR4a+UJahwFVtL9A48MVvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuXdnO83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuXdnO83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB251F000E9;
	Wed, 29 Jul 2026 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785358628;
	bh=lS0GHKp1DPgHn7VaiA6bpKWGa+MwlXqws9oO+PIj8aI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PuXdnO83Vkoo+BRB9PhpWFvtT6CzZdzkJsX6KXekQEGATJoHZZzXHARVrg9R6z/oL
	 P8KElVHHH25WlGcQO4M9rvxQ6c1gsZHhyQqomhzZlkYWII4yVC+ma/P5FU1dlDsW6b
	 fnHmyGay+wahzR5u7sVJeuZBXS8NXS8n+SKTgB8opDNaidAV1RtrWi/QuIafLTXqEP
	 eZdLnEFxJsCQc+f3ocWXVVXEumUajn7EmwZpTh3cKZezVeG9/6fnIY1cl8tt/lYsyl
	 O0WDS1eAS7ko3VaW+1ut/H7V/83OXHHrJ8/EG/lnaL/MOz8w5USQ5/3vmB4CobGTlY
	 bueXOfFva2Mqg==
Content-Type: multipart/mixed; boundary="===============7969633414471911093=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <427b5feb2cb3ab65aebd4dc7a69c2b4ec4788b314ed6c79fd5bcbdd4f3d43d57@mail.kernel.org>
In-Reply-To: <20260729194932.292368-3-vldsampaio@pm.me>
References: <20260729194932.292368-3-vldsampaio@pm.me>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Simplify cnum normalize() implementation
From: bot+bpf-ci@kernel.org
To: vldsampaio@pm.me,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,vldsampaio@pm.me,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 20:57:07 +0000 (UTC)

--===============7969633414471911093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Simplify cnum normalize() implementation
>
> This patch introduces a optimization for the normalize() function.

This isn't a bug, but could the opening line be recast in the imperative,
e.g. 'Simplify normalize() by dropping the redundant base comparisons', to
line up with the subject and with submitting-patches.rst? Also, 'a
optimization' should be 'an optimization'.

> In normalize(), there's no need to compare cnum.base with ST_MAX,
> because any cnum with size == UT_MAX represents the full unsigned domain
> independently of base, so normalize() can canonicalize all such values
> to base 0. Also, it's a no-op assigning 0 to cnum.base if the cnum is
> already unbounded, so we can remove the base != 0 check too.
>
> We've also run some benchmarks to compare the performance of the new
> implementation, for example, for empty ranges, overflowing ranges
> non-overflowing ranges. We've run the tests with O2 optimization.
>
> Results:
>
>         | Test                    | normalize   | normalize_new |
>         | ----------------------- | ----------- | ------------- |
>         | normal small range      | 1.254 ns/op | 1.049 ns/op   |
>         | full range normalized   | 1.055 ns/op | 1.046 ns/op   |
>         | full range nonzero base | 1.053 ns/op | 1.055 ns/op   |
>         | empty                   | 1.054 ns/op | 1.059 ns/op   |
>         | signed max full range   | 1.051 ns/op | 1.049 ns/op   |
>         | max base singleton      | 1.253 ns/op | 1.045 ns/op   |

This isn't a bug, but since the deltas here are all well under a nanosecond
and one row regresses, would the changelog read better with the benchmark
table trimmed (or dropped) and a bit more room given to why removing the
ST_MAX carve-out preserves the represented value set?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30487300521
--===============7969633414471911093==--
