Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A627E045
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775587381; cv=none; b=mTTjBkaPW+vdyJxvvFS9W3B3V7GJcAg/UMpje2qcx6jUoXUWtyF16edHrB+XJu8V6mD+wcXJTJx123xzlzmnV3zxfMnIdWxqBFRMZHYc4s8FY17BTpZjgAIYvyY/G3XbBb+0ovPqvfAsdYMLqBCXHcc8vPumi7IKZQUCZP309DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775587381; c=relaxed/simple;
	bh=BqZZ88ZyfFtV1iG7o0x13A7i3m7UwZk8dz6w/VKAK8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aa+31js4AHsgp1mKS4nKEzfcz06QRZ537Yt0ybXFy69mCiYcFsXWaWfFq4rzJhRLs4ypzAEOZL2WaVCJOQtRgd+apWRf2eSttMF8Izt6DpWUmrqrWjgEs4+ymM4i411Xx+nXZtvSOGrYdAysA9As4xPWBohyg1ciyqhyiGXrMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LcDWftGR; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LcDWftGR"
Message-ID: <f96f82ea-2c39-4b3b-b177-38fb93bc6169@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775587376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHzoTtQhom8Iy/wMxziQ3JMK0R5Gn0tKEllnnrR7caU=;
	b=LcDWftGRPXFRioM9jQ0gbFbRf/XvA3VogphJWAdO2XdUBp7Mra6IO7FD3zFQwrGXU0wX9r
	EiKr/bG7atjCMRBo1+2+5W119WeT799KCJzUL1gCPKh3RJncEccGTyj7ZMvWbxl781Vid8
	7U8D2XS9B0Db51HJALbLzEZHlsb7a6k=
Date: Tue, 7 Apr 2026 11:42:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/2] tracing: Prefer vmlinux symbols over
 module symbols for unqualified kprobes
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, jolsa@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, emil@etsalapatis.com,
 linux-open-source@crowdstrike.com
References: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com>
 <20260407165145.1651061-2-andrey.grodzovsky@crowdstrike.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260407165145.1651061-2-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/7/26 9:51 AM, Andrey Grodzovsky wrote:
> When an unqualified kprobe target exists in both vmlinux and a loaded
> module, number_of_same_symbols() returns a count greater than 1,
> causing kprobe attachment to fail with -EADDRNOTAVAIL even though the
> vmlinux symbol is unambiguous.
> 
> When no module qualifier is given and the symbol is found in vmlinux,
> return the vmlinux-only count without scanning loaded modules. This
> preserves the existing behavior for all other cases:
> - Symbol only in a module: vmlinux count is 0, falls through to module
>   scan as before.
> - Symbol qualified with MOD:SYM: mod != NULL, unchanged path.
> - Symbol ambiguous within vmlinux itself: count > 1 is returned as-is.
> 
> Fixes: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at modules as well")
> Fixes: 9d8616034f16 ("tracing/kprobes: Add symbol counting check when module loads")
> Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  kernel/trace/trace_kprobe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a5dbb72528e0..99c41ea8b6d7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -765,6 +765,13 @@ static unsigned int number_of_same_symbols(const char *mod, const char *func_nam
>  	if (!mod)
>  		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> +	/* If the symbol is found in vmlinux, use vmlinux resolution only.
> +	 * This prevents module symbols from shadowing vmlinux symbols
> +	 * and causing -EADDRNOTAVAIL for unqualified kprobe targets.
> +	 */
> +	if (!mod && ctx.count > 0)
> +		return ctx.count;

Nice to see this actually works.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> +
>  	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
>  
>  	return ctx.count;

