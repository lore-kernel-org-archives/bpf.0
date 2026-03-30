Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8F2E5B2A
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881793; cv=none; b=eCS0ObBEWTSTj/r5O7h0rtLvS8QFvZTAn87LIylqKqfTc7l3ZsPlE6tgzvYUvAI1TaiLvDBasrmwJoW8FNlRrf6lNlXUMUfOn7EyBQfam1WNObz6xUKWjpYX6szzT4YJBSkp5C0/aU8Air8sIWTwBSTYvfk+MyNV0pc8TgnV+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881793; c=relaxed/simple;
	bh=dpr6ZiFU5DSC+A87WIiBmwWwhopoj3mnxtuBhiQkJGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggsw1k9KP/2kvHfROkyimvb0HZE7ooJG2mTfjrWrYmWVZVkYyl/evgw8dqan5v/dKWiPUm40pvGZXxTzevfor6trolfWCGAghIpJBNsU1fZpfZvksHkj+4Wo3r1XnCfs7kl360IYE9nJATj1CM/Dpq7cRyYQ7cfRFtFIKBpbNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OCyKSBF+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OCyKSBF+"
Message-ID: <0c82df11-2dc8-4828-bcb6-29114ba91fc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774881790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3Ner8dgcDR2dALP+8/EaVuBrBdI946AaCaedq/Kcdg=;
	b=OCyKSBF+7WaxhOYSKKBs2K2aG5ZcIqT0hvN/VGqD3xaHjs48tURShNAL4pAxVMLA6F4smC
	yutEJSW0gmxmHUEFzgo9YW/dmDwyUr8e9bkEcy6Zse/7vpoDvAgQlIplylFERLHINCVBC5
	i+Vha+h7IxK6lO6MEO2bY3fmGbXF4ps=
Date: Mon, 30 Mar 2026 22:42:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK
 feature probe.
To: Varun R Mallya <varunrmallya@gmail.com>, andrii@kernel.org,
 alan.maguire@oracle.com, yonghong.song@linux.dev, song@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 eddyz87@gmail.com, martin.lau@linux.dev, jolsa@kernel.org,
 menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-3-varunrmallya@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260330110019.549079-3-varunrmallya@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/3/30 19:00, Varun R Mallya wrote:
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 4bcb6ca69bb1..633106a687c7 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -388,6 +388,8 @@ enum kern_feature_id {
>  	FEAT_SYSCALL_WRAPPER,
>  	/* BPF multi-uprobe link support */
>  	FEAT_UPROBE_MULTI_LINK,
> +	/* BPF multi-kprobe link support */
> +	FEAT_KPROBE_MULTI_LINK,

Even though it seems good to put FEAT_KPROBE_MULTI_LINK here, better to
put it at last to keep backwards compatibility?

When users compile application using old libbpf and run it against such
new libbpf.so, will they get incorrect feature support?

Thanks,
Leon

>  	/* Kernel supports arg:ctx tag (__arg_ctx) for global subprogs natively */
>  	FEAT_ARG_CTX_TAG,
>  	/* Kernel supports '?' at the front of datasec names */

