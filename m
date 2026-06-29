Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD1449EB6
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749128; cv=none; b=jzWi9qg2/ez7TcpswMxukkMVrMKiVaqUn3Cd9znsCYl3brmMtYLtS/lJ9Sl6RLj1oaBQH2LU6Vo90JdTkF55HRBlT4njRrEHA7uwjOcWXwZ9B+QklQS618XtcrGtoIsiko9/9nZjmZT0ZuQrNrNxLmjEnlf1ta5FGCKjQH5uzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749128; c=relaxed/simple;
	bh=AKxhrHDF1sGg2BHcgT4NCVphFTxcaS5rZrrWP7uH+Nc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=py4823aUcbNFqPbIlYryoFxQEn3EzvgSjG2v6CLOVPwRt279L6qjiZsR9lzUaDGZVYu5vmpsNV/UrHAqxk+CuOl8RvFnkgF9IRsvQIbsTvB+uovVZR0di0FBsmw2DlhwaSpIRj1KGIb89nIvcd0RiUzg6aRwNg+4sRGNTC2Nn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDxWx+JI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDxWx+JI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3791F000E9;
	Mon, 29 Jun 2026 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782749127;
	bh=VUr/sW2HtYQJrulRnmKfwsoJ2AFWrrO2I3Bxdl8gawA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oDxWx+JIJ1qUxpzAo48UxZXqSV8miKXn4fBI+Wh5Lc7r4omLeLzhgOHLJWvRzpUci
	 Fsq3cy4xPdOTBo+sEv88J0OLH3bUlocSspzuv3fSSCV+b238EN+118x/Yx0zZLHHLB
	 ewwEKkXWAQWKK5EfAQ+8g/qF4+ts/DHZquMs3rNSJ9qXJi4t7plPPsvo6T+SJoWpiw
	 5nAAhbz6YxMpItqDo6p8y6INBTQm6NF2ZRSF9tmkQetKtKccA1dboZi8G4EQXiSGxG
	 6RqksBhAyZNGw4DpPxd+PeKSyGGhl38vRGSjHauv96e9HThcD7njcwlLjc8GINrbfY
	 eXax/RuvDkC2w==
Content-Type: multipart/mixed; boundary="===============0918023420677207829=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3205a51da759dfd735af18490c48f952b34dd066a1ff0d47f832b0a1a5de6469@mail.kernel.org>
In-Reply-To: <20260629143844.862369-4-jolsa@kernel.org>
References: <20260629143844.862369-4-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 3/3] bpftool: Add tracing_multi link info output
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 29 Jun 2026 16:05:27 +0000 (UTC)

--===============0918023420677207829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index bdcd717b0348..eb0ba9d71692 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -377,6 +377,25 @@ static __u64 *u64_to_arr(__u64 val)
>  	return (__u64 *) u64_to_ptr(val);
>  }
>
> +static __u32 *u64_to_u32_arr(__u64 val)
> +{
> +	return (__u32 *)u64_to_ptr(val);
> +}
> +
> +static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ibt_enabled)
> +{
> +	struct kernel_sym *sym;
> +
> +	if (!addr)
> +		return NULL;
> +
> +	sym = kernel_syms_search(&dd, addr);
> +	if (!sym && is_ibt_enabled && addr >= 4)
> +		sym = kernel_syms_search(&dd, addr - 4);

When is_ibt_enabled is set, can addr ever be resolved by the first
kernel_syms_search(&dd, addr) call, or does a match always require the
addr - 4 adjustment?

If a match is only ever possible at addr - 4, would an if/else be clearer
here than trying addr first and then falling back to addr - 4?

> +
> +	return sym;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28384089901
--===============0918023420677207829==--
