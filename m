Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939923;
	b=GqgD6aVPvR01OWJFwHnF6+2GFN7q3nOuGIFPFhN5hHFmbTFDuwN/Mvnccpyo9eLoP9PB
	 bRMTTxjTsXZ2KgP6TjLqjxwEUqxF6WBFWvr3W9dXEQJ2qZ8g+yNKLCYf/Cj3WBpqpN6Dt
	 6A0McwurB89SaR5okBZhzUwU9KQdWsQnniZBBai+U0JKFb93s5v1dEz2awKZ1FAe1CM4f
	 KCTn3308RgXl7z8lh6MWrncC9byZrFF+tTP3egyaxvbcBCHCnUqR33q5YM1Wy/pTDJffD
	 lfceaMuexnl0ZF6c2gZqvT0iOAwD6qCYmY9yRItdW6/3xc8ugERtxu2VIM0xi4vZOKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939923;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=eKtFC1/nkLHos9S8mxNsSvZyijKzHREi3soXK7nOGqg=;
	b=F9gNZgeDr2PSgvvNPs/gxw99k/eXD350i7QkQMXP7uH9kyRFQ9SoSdgflzkjjHCUSTTz
	 BtuZZrMqMFmRiLlOn8Y+2GQwUH5OD3MxUMMqMv+eDAmyO/AGxV7/Qt6wk/GYIG0mRDTp/
	 6a+BOjnBxeJc93Hv2T3J8iPuoAbvwh8hyseHeNEbgGQxseXbKz+uvYGDshxobC3PaJXKn
	 z0ZK1kjNG4yFsEY81yzWuqjb7XrYeIruvMhXk+KzFCLzHHeyD2Rva68feMIQm1G9Zq0RF
	 iqo/14YSbs+Bw24yyMTp7ZclAIuhnTwTmYS7Po3Q9haHURlG8p1Kom7jkeozCS134dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ocb/FL5m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8792606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ocb/FL5m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3194F1F0089F;
	Fri,  6 Nov 2026 04:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939922;
	bh=eKtFC1/nkLHos9S8mxNsSvZyijKzHREi3soXK7nOGqg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ocb/FL5mXUchD6nJOUSN0fIRx14YSQ3ZFlxQk3/6QpaJGDGDXYYToozNGW4YMS7CZ
	 gzM7P4ByMLCJxVTTGRGY5NI9U7dl2BHj/RPpjxYviEDr1Hy1E+anZPEm3X32YyfqTi
	 BO/zpjskkNq9V7iYtZzlQgLt/saMpDqSNoa9G/55YZq04LlnKqMaLNUwH95jJt2sZ+
	 7CMtb601KCCXSryHxdrcYR4yzW4RCr0ORRWiWhmyFr2b3HqcTAri5zBDuS9eVHpTlK
	 yFFicSoBxBI3Yqkg4ot+yqIvXUpH0vUWu/8JOx5HXSbCjUmvvqrEU18qEgzdFrePVB
	 N28VZREmvywuQ==
Content-Type: multipart/mixed; boundary="===============7968769607621321351=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6e5cf38bc8a796c974fa938d4bd1dcee4821c916a3c4a5fd5981326574055d36@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-6-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/45] bpf: Add join of verifier states
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:42 +0000 (UTC)

--===============7968769607621321351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add join of verifier states

TL;DR: Nit only: join_loop_stack() in join.c repeats fa->loop_stack[i] and
fb->loop_stack[i] many times; local entry pointers would read better, as in
loop_stack_safe().

> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> --- /dev/null
> +++ b/kernel/bpf/join.c

[ ... ]

> +static bool join_loop_stack(const struct bpf_func_state *fa, const struct bpf_func_state *fb)
> +{
> +	u32 i;
> +
> +	if (fa->loop_stack_cnt != fb->loop_stack_cnt)
> +		return false;
> +	/* what is known about a counted loop comes from the state it was entered with */
> +	for (i = 0; i < fa->loop_stack_cnt; i++)
> +		if (fa->loop_stack[i].loop_id != fb->loop_stack[i].loop_id ||
> +		    fa->loop_stack[i].terminates != fb->loop_stack[i].terminates ||
> +		    fa->loop_stack[i].guarded != fb->loop_stack[i].guarded ||
> +		    fa->loop_stack[i].counted != fb->loop_stack[i].counted ||
> +		    fa->loop_stack[i].apart != fb->loop_stack[i].apart ||
> +		    (fa->loop_stack[i].apart && fa->loop_stack[i].trip != fb->loop_stack[i].trip) ||
> +		    fa->loop_stack[i].refs != fb->loop_stack[i].refs ||
> +		    fa->loop_stack[i].max_header_count != fb->loop_stack[i].max_header_count ||
> +		    fa->loop_stack[i].entry_state != fb->loop_stack[i].entry_state)
> +			return false;
> +	return true;
> +}

This isn't a bug, but could join_loop_stack() take local pointers for the
two entries, something like:

	const struct loop_stack_entry *ea = &fa->loop_stack[i];
	const struct loop_stack_entry *eb = &fb->loop_stack[i];

fa->loop_stack[i] and fb->loop_stack[i] are spelled out many times in the
comparison.  loop_stack_safe() in states.c uses old_stack and cur_stack
locals, so the comparison would read the same way.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============7968769607621321351==--
