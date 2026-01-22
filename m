Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35773542C4
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101096; cv=none; b=XQSq2VyowD0Pg9L1kaRLsJM2FvL25iGFc+W7kIwIUzfDBTjST99j/tULvmYHgIA4FCROaIzr4ILeCCg6sr1AvZ0i5Cu8Mt+IbjownYOhjf3JgL0BDGELovBoxN3aL7eipap0vGcNiUxXsI3Tmq/SSV84a2dvh9aaao0ZVGBUqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101096; c=relaxed/simple;
	bh=WZtRP/ykoFOzI67UhM+u5hl2WVDrIMN6nCJhl2AxgqY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=grfpG7Wgs+aGZFC/Iq/CnokpVBRfWgLzx2n5YLKkTcjBWuDbEiyBFAacHM7wteLj9pjZzGQhdc6TPAO1a585x+tZMh7ps5ZQdQnm3IdogvjX/CFinIHFpmVExRVZ9tXiekVSrOnEW0ReHEBtvIgg5V1NQi7KyODXaj8EjsIUZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPhWHpGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPhWHpGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF33C116C6;
	Thu, 22 Jan 2026 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101094;
	bh=WZtRP/ykoFOzI67UhM+u5hl2WVDrIMN6nCJhl2AxgqY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XPhWHpGszmaO5Q/u//5qeuewibh7LkGPHK9wgBWNgg/kCKaEc10Cr5PUhItZfcrMz
	 XfM1czXsCL0OecB9p8SQW7Cj9iM9vMZ17fLvJ05GKY8U3FOoT4e0gYlUG5ysBN4zU2
	 9vDWV86mdy0Smdy7uIOTVNgC2L+VXfTBrlvQDdQ5ROxF8JtjQBE+aXpQ/hRdOhx3Vt
	 dGkrD1xaBIzOjnf2Rb8KxYHeiP4WgQhr7Mlh9RHY/yF9RPBLnPYSSbKjgHWqmWMDhp
	 yFkXEX14+1cN4HhkEzF5JAoTN4Fmp4gkORqu29XK7uSbXbdZhnVQdzlZw9p/rmJPAA
	 b8FSlYAjB+cmg==
Content-Type: multipart/mixed; boundary="===============7114721203286322488=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc73fe661a977aa87f21e92e96bfd4e63bcaa54c5356627257a8d485dc515821@mail.kernel.org>
In-Reply-To: <20260122160131.2238331-7-etsal@meta.com>
References: <20260122160131.2238331-7-etsal@meta.com>
Subject: Re: [PATCH 06/13] selftests: bpf: Add arena ASAN runtime to libarena
From: bot+bpf-ci@kernel.org
To: etsal@meta.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,daniel@iogearbox.net,memxor@gmail.com,puranjay@kernel.org,song@kernel.org,etsal@meta.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 16:58:13 +0000 (UTC)

--===============7114721203286322488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> new file mode 100644
> index 000000000000..7d39ee7b68bd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c

[ ... ]

> +static __always_inline int asan_report(s8a __arg_arena *addr, size_t sz,
> +				       bool write)
> +{
> +	/* Only report the first ASAN violation. */
> +	if (asan_reported && asan_report_once)
> +		return 0;
> +
> +	asan_reported = true;
> +
> +	asan_violated = (u64)addr;
> +
> +	if (asan_emit_stack) {
> +		arena_stderr("Memory violation for address %p (0x%lx) for %s of size %ld",
> +				addr, write ? "write" : "read", sz);

The format string has four format specifiers (%p, %lx, %s, %ld) but only
three arguments are provided (addr, write?"write":"read", sz). Is there
a missing argument for the (0x%lx) specifier, or should that part of the
format string be removed?

> +		bpf_stream_print_stack();
> +	}
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21256973563

--===============7114721203286322488==--
