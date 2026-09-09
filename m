Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904337CD52
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939018; cv=none; b=RdUAXI8ZWbiu7Q1TGvWy8sJw0a4Zs8gTeWzu0wctmpiJ5MQ/TMJuB5yJYrbRFnm1mfTtZsM9lqeq5UILnxxyZQF6zVys6kn67c2voqlSTr8NJuYWJMsUo5emYXmabxrAk9TvyD1rmlr12sd4nfhWcZsgsyco9x0U8hZYQw4zRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939018; c=relaxed/simple;
	bh=babCDaeIGYJ4zvDpR1vJeTZLGZLQb5H8UwXevl7msTk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sEN1XkK3c5I4DMJqmFK+2qoZuNNFNd0h4kJqBx3sc/0v423Dem9HztgC68hfz3P7e8Cb7IilE651zrhkcmpSf1XARv1mEsWjNVTEkgl7vXMiGaen8q8iZB4dhFnkElVeYfk8iwV8J5dY5jigmoGOMXRjQ+W6L8MADUoyWplZh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAQBbehj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAQBbehj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B3A1F00ACA;
	Wed,  9 Sep 2026 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939006;
	bh=fKvZlaokcPsWkTYliCumBjzcmkfWnIlivoO+LfHwpkg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZAQBbehjyMLeII/Y6+k+LJP78nu4+fVMh4clTpLrQNxzS+/bKcL3lho4ltYNsqcPE
	 nCgqB61ZR58oVCjYKtZXvv0MnaMyCciVFBPE2utn6Ua2mCNNfNAndS/Xf03YEsWXbg
	 PZbTUTk+WGIap5Ra440g5kiERcGH9KP9k4rBZEj23pCiMD/gzVQdYgIK0tLKLTSz12
	 eZiEBHDe3Dufh68ft1SCEZ1oLJ9txSMhuSNaNhBpHGhi13LGT8p/yVU1r27nbS/7eV
	 mt42IEkWB74eY/MMF6LV0zc+NpjBKtyAPnv1JINbuKvo6LUWOyLcxxSDMLpA+D0hJR
	 7UsknkQOy8IbA==
Content-Type: multipart/mixed; boundary="===============1907044879645282022=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14888dbc8203cddca1f5affa396a0620902c0104604e6eb8dfd9d4a0470b78fc@mail.kernel.org>
In-Reply-To: <20260909062621.4009625-1-yonghong.song@linux.dev>
References: <20260909062621.4009625-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 11/12] selftests/bpf: Add inline-asm tests for by-value arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 07:30:06 +0000 (UTC)

--===============1907044879645282022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
> new file mode 100644
> index 000000000000..61dd5f86c3a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +typedef unsigned __int128 u128;
> +
> +struct pair {
> +	__u64 lo;
> +	__u64 hi;
> +};
> +
> +struct too_big {
> +	__u64 a;
> +	__u64 b;
> +	__u64 c;
> +};
> +
> +#if defined(__clang__)
> +
> +__noinline __u64 global_arg_pair(int a, struct pair p, int c)
> +{
> +	return (__u64)a + p.lo + p.hi + c;
> +}

[ ... ]

> +#endif
> +
> +__noinline __u64 global_arg_too_big(struct too_big s)
> +{
> +	return s.a + s.b + s.c;
> +}

[ ... ]

> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
> +
> +__noinline __u64 global_arg_split(int a, int b, int c, int d, struct pair p)
> +{
> +	return (__u64)a + b + c + d + p.lo + p.hi;
> +}

[ ... ]

> +#endif

This isn't a bug, but would it help a later reader to carry the
changelog's gcc-invisible-reference rationale into a short comment above
the #if defined(__clang__), and to note why the last three cases need
__BPF_FEATURE_STACK_ARGUMENT (and maybe label the two #endif closures)?

The sibling file aggregate_ret_func.c documents its equivalent gate:

  /*
   * gcc returns a by-value struct through a hidden pointer, and emits the
   * 'r0 = r1' returning it after the __naked body's exit, leaving the
   * subprogram falling through. Build these with clang only.
   */
  #if defined(__clang__)

and other progs files label the closing directive, for example
verifier_ldsx.c uses #endif /* __BPF_FEATURE_ADDR_SPACE_CAST */.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441
--===============1907044879645282022==--
