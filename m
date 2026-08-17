Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34C3BE168
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998359; cv=none; b=NggLkdO+K8OB8gzuaVaWc/Nk+GMU/77FD56c3vaoc7Cqq1AO55pP6qzSNWNHINvsFHTFEEXRo1RrKCQJBWGIZiRtLIhp4aaG0NwFxXPGfrRBRj2cVMffyCyhNPJUliQ8NtAHgdsgaG6WpXDRD+hrlrFPvgKHLNclIdo9VTr08UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998359; c=relaxed/simple;
	bh=I/Wxftlxnz9uT+xxtLnnBQbPtFd6wxbMXnv2u3TmnvM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g6cSPKlMJA45F75Qwk9vxDNKXmiFpMsohLQ+A0XzAAtSunBDo3fXCMQ/ee23IgzeXzuCksXwCi3zVfPqBOIu6DnPy/o2Xn0vNyuySmycxbvTgVMqG0cMO3c0vsnLeQ+9KPLTs80zhHzt54+jPMrUctci7m7+u4ElkBDzb9yKc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOUwY54l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOUwY54l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2F11F00A3A;
	Mon, 17 Aug 2026 20:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998357;
	bh=dHn7/cnuaIs+yn8PJKkSYJsYn6FD5lOubpCrxgiYibw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZOUwY54lUA2wGGOebeBpCH0BnkUn2sUSN9AVckSqs3MAmDd8QOIzlh078LBFhpu4s
	 qOoy4Vp3ZAPLhiIEKv+JlOWlRRPnTqa6K6m5DbIdwoj0qF0JFiHVrVw+m5j56b/THc
	 lifW1NUtbzuaSaQLrgDPSaY3u2/oH9TOsmLElfLt5rlsbKXrb4vxuc9/TPzN5JHBtz
	 2P3isnyJPJum5EP/EAQsl5mixgu1CjksMLPdoexkzPEECeFscnJiYZDVHJl6SmWMes
	 shh2/VI2YOAnt8cq9oacEMNWNxpQcBsAH8cdVMNr6TBfsA/RwI8W+KtucoUaoptYtZ
	 KfhvZ/bM0bKAg==
Content-Type: multipart/mixed; boundary="===============4622850309522828591=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a60462e917e53f5f3372ae21a7d8ee422ab6fda09cbd31cfa64f87e1c8b962c0@mail.kernel.org>
In-Reply-To: <20260817191616.11071-5-emil@etsalapatis.com>
References: <20260817191616.11071-5-emil@etsalapatis.com>
Subject: Re: [PATCH 4/6] selftests/bpf: libarena: Add calloc() call
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 20:25:56 +0000 (UTC)

--===============4622850309522828591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> index 931ace9a49e2..d32a51ff5e7f 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> @@ -49,6 +49,7 @@ extern volatile u64 asan_violated;
>  int arena_fls(__u64 word);
>
>  void __arena *arena_malloc(size_t size);
> +void __arena *arena_calloc(size_t ncount, size_t size);
>  void arena_free(void __arena *ptr);
>
>  /*
> @@ -61,6 +62,23 @@ void arena_free(void __arena *ptr);
>   */
>  #define arena_subprog_init() do { asm volatile ("" :: "r"(&arena)); } while (0)
>
> +/*
> + * BPF does not currently support the memset intrinsics. for large
> + * sequential copies, or assignments of large data structures,
> + * the frontend will generate an intrinsic that causes the BPF
> + * backend to exit due to a missing implementation. Provide
> + * implementations for the intrinsic.
> + */
> +static inline int arena_memset(s8 __arena *dst, s8 val, size_t size)
> +{
> +	size_t i;
> +
> +	for (i = zero; i < size && can_loop; i++)
> +		dst[i] = val;
> +
> +	return 0;
> +}

This comment was moved and reworded from asan.bpf.c, but now has three
issues. First, the sentence boundary is lost: it reads "support the
memset intrinsics. for large sequential copies" with a lowercase
"for" starting what appears to be a new sentence. The original had
"intrinsics. For large sequential copies" as a clear sentence break.

Second, "intrinsics" is plural here but only memset is provided. The
plural was accurate when the original comment listed
"memset/memcpy/memcmp", but that list was dropped.

Third, "Provide implementations for the intrinsic" doesn't match what
the code does. There's no memset symbol or lowering hook here, so
__builtin_memset(), a plain memset() call, or a large struct
assignment will still fail in the BPF backend. What's actually
provided is a helper that must be called explicitly as arena_memset().

The original comment was more accurate: "Provide a simple
implementation just for memset to use it for poisoning/unpoisoning
the map." A reader of the new comment might reasonably think the
compiler-generated intrinsic is now handled.

Could the comment be updated to reflect what this function actually
provides?

> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> index 5135d5c72a46..de656b69d13a 100644
> --- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> index 41b1de3452fe..d1af60b81838 100644
> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32062809860
--===============4622850309522828591==--
