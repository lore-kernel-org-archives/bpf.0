Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FE40EB99
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124682; cv=none; b=Jy4J6cZkE7OyOR+9ltnbJ1bJmji4e5o8Zg1CELevNxRx7eD9xyDC0Kj1G2pwMY2EMjC89xcC+bArNRpROsFM3eY0c8BDkzIlYH729g6te/t93fid1aYQtJNc82SbLFfDqql7OWdNm6I+ns3WtQQAKU+Cm0qcPH7sj29WlB/QuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124682; c=relaxed/simple;
	bh=RA9msLx8YZVz0nQkiJOmodBiTiA4Hy7Pm2CbmYB59sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kExVTSSW//yQmxefx/vt5H0/tjFoETR48fscJW9WcxCOVSIHc6YvDvuqSdDMJXMeLP56tkTSUiedivkb3PnLUWgYkqDiek09f2w0gsXJs96Xx5gfOzzX7FkwUlmuCeKNvG9YjKry8edNGKAo7pB0KbUSto0T4woYIoCcuuhJ4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cLGEsdhP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cLGEsdhP"
Message-ID: <ffb90c46-6bb4-438f-8915-6983a931d3e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784124677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWpEQZen8y9kDoBjZT+t0D5JRqLAnm4B0/i7uKFgG+Q=;
	b=cLGEsdhPVTzDjzk5fwYDd79KdD7FaYozHLS+NyFL3pEEuN3WeYYdebdu41LkwJPzLTM6yh
	Vhtqmi37nNS1Hp6h0oga+1TluIc/rUexdWKiKg1s6ZmV/6lE0lIWC1R1Cqam1AMOjs7c1N
	MORfHbZlJXN6iaMJEXZLXtpwv20JxvI=
Date: Wed, 15 Jul 2026 22:11:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] bpf: Inline the numeric open-coded iterator
 kfuncs
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
References: <20260715130430.318421-1-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260715130430.318421-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/15 21:04, Puranjay Mohan wrote:
> The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator. It
> expands into calls to three kfuncs: bpf_iter_num_new() to set the iterator
> up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy() to
> tear it down. The verifier emits these as ordinary kfunc calls, so a
> bpf_for() loop pays function-call overhead on setup, teardown, and — most
> importantly — on every single iteration via bpf_iter_num_next().
> 
> All three kfuncs are tiny and only touch the 8-byte on-stack iterator state
> (struct bpf_iter_num_kern { int cur; int end; }). That makes them good
> candidates for inlining, the same way several other special kfuncs are
> already open-coded in bpf_fixup_kfunc_call(). This series replaces each of
> the three calls with an equivalent inline BPF instruction sequence:
> 
>   - bpf_iter_num_new(): keeps the (s64)end - (s64)start overflow check
>     (emitted with sign-extending moves) and returns the same
>     -EINVAL / -E2BIG / 0 results as the kfunc.
> 
>   - bpf_iter_num_next(): the hot path. Since cur and end are int, the
>     kfunc's (s64)(s->cur + 1) >= s->end test reduces to a signed 32-bit
>     comparison of (s->cur + 1) against s->end, so the inlined code uses a
>     32-bit compare with no sign extension.
> 
>   - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.
> 
> The emitted instructions are plain BPF and remain valid for the
> interpreter, so interpreter fallback stays correct and no jit_required
> marking is needed.
> 
> Patch 4 adds a bench_bpf_for benchmark, modeled on the existing bpf_loop
> benchmark, that runs a bpf_for() loop with an empty body so the
> per-iteration iterator cost can be measured directly.
> 
> Results (./bench -p 1 --nr_loops 1000 bpf-for):
> 
>   +--------+----------------------+----------------------+--------------+
>   |  arch  |       inlined        |     kfunc calls      |   result     |
>   +--------+----------------------+----------------------+--------------+
>   | x86-64 | 12884 M/s (0.078 ns) | 5812 M/s (0.172 ns)  | ~2.2x faster |
>   +--------+----------------------+----------------------+--------------+
>   | arm64  | 546.1 M/s (1.831 ns) | 545.8 M/s (1.832 ns) | neutral      |
>   +--------+----------------------+----------------------+--------------+
> 


The bench results are excellent on x86-64.

However, after looking through patch #1 and patch #2, hmm, they seem
quite complex.

Alexei suggested that the kfuncs could be inlined by the kernel disasm
approach [1]. With that approach, it should be possible to inline many
kfuncs and helpers on both x86-64 and arm64.

I think we should try hard to implement the disasm approach.

[1]
https://lore.kernel.org/bpf/CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com/

Thanks,
Leon

> On x86-64, removing the per-iteration call to bpf_iter_num_next() roughly
> doubles throughput. On arm64 the numbers are unchanged: the loop is bound
> by the load/store dependency chain on the on-stack iterator state rather
> than by call overhead, so inlining neither helps nor hurts there. It still
> removes the calls.
> 
> [...]
