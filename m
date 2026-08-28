Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4D2DB79C
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940158; cv=none; b=VnMncaLzVKFey4qtzXPIv1aL92e/1EUSdZ4e2vw+jq3m3Kejb5cfdwk3zaDKhYCKKrVxsHmybC05vU7XDrcZILHQ/l5vPZLYlXU1I9/9YvqfzV7KY+HrlZiDKz7gZq464VWAdHfcgTu6n4tJChxDk8NDfRwk4yrLpEb3U9WJdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940158; c=relaxed/simple;
	bh=rkeDuYmelt0qo8TWXWt1/MsnPILLcuVkly8d/zILlq8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B/w1SMipc+4qdYzBQczmUNVciauOpaAa8hPdpk/49GyWV9qHybTqoTwJYlc0zT6jmHclD9Gw4MPL9AimUJNcNiv3KZdRokvMQ3nheMmtuc9JwSMtb750OnuLSoL070rDizIqsJKJarGZnXE2hpzaUEtfUmqx3j/Nt3YUQn+DkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHQvh1es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHQvh1es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B1D1F000E9;
	Fri, 28 Aug 2026 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787940156;
	bh=1efuzne4f1Ld2NPkUYhsg6j5eoP0gWovCSNmjFUrTKM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WHQvh1es5tpjQb2L/HDl4pJxERgczSJIVh+O3rHQQE2b4ul8Wcr6nYR0rPViNseQT
	 1yu1Aw1rkePtm9yiBsDDr6Y+iT6xjULXz8sFmYSMzdIUpMs0NUv9T39R3vQnLkQt07
	 f1zOvQ6llyCFHvsV7LYjWzR/2RR7d/7TXYiAyhoCzGcc3giv13QNmb+Et+D+vG4wWf
	 sTcrUVzUt46+xTLnvd3WGRSyPbK8ZnYtxSVQluwgkcxM7LOA+G/97sRkRah43yEOS+
	 w/qQ/XAg6Tl0oKAN4UwWAHKB6YxgKK+DlbDD1YC6fhfIsU3bdbEGaVaGRwnYiSLRp6
	 w1na1+93ARbQQ==
Content-Type: multipart/mixed; boundary="===============7287632020056444692=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cf27d7b3ae9842061b2291e98b9620683234d10d6955205d9ba0da41617311db@mail.kernel.org>
In-Reply-To: <20260828170534.1011183-1-yonghong.song@linux.dev>
References: <20260828170534.1011183-1-yonghong.song@linux.dev>
Subject: Re: [PATCH] selftests/bpf: Bound the offset accumulator in __tld_fetch_key()
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 18:02:35 +0000 (UTC)

--===============7287632020056444692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> index 0df8a12fd61e2..a31a399870bef 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -61,6 +61,7 @@
>  #define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
>
>  #define TLD_MAX_DATA_CNT (__PAGE_SIZE / sizeof(struct tld_metadata) - 1)
> +#define TLD_DATA_SIZE (__PAGE_SIZE - sizeof(__u64))
>
>  #ifndef TLD_NAME_LEN
>  #define TLD_NAME_LEN 62

This isn't a bug, but struct tld_data_u at line 91 spells out the same
expression for its data[] bound:

    char data[__PAGE_SIZE - sizeof(__u64)] __attribute__((aligned(8)));

Since TLD_DATA_SIZE is exactly that bound, would it be worth using the new
macro there too so the two cannot drift?

> @@ -189,6 +190,8 @@ static int __tld_fetch_key(struct tld_object *tld_obj, const char *name, int i_s
>  			return start + off;
>
>  		off += TLD_ROUND_UP(metadata[i].size, 8);
> +		if (off > TLD_DATA_SIZE)
> +			break;
>  	}
>
>  	return -cnt;

This isn't a bug, but would a short comment here help? The check is
unreachable for any metadata the library can publish (per the -E2BIG
guards in __tld_create_key), so it exists to keep 'off' a loop-invariant
range for the verifier rather than to catch a reachable overflow. The file
already annotates its other non-obvious workarounds inline (the
tld_uptr_dummy_t member carries a comment explaining it only exists to
force BTF emission), so a one-line note here would match the local
convention.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33193637868
--===============7287632020056444692==--
