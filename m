Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215025;
	b=4gOjfoGft0/Lh6VLS5Lj4jSvsbYPWNm6oBl+lOA5fxAZmzCw9UUQo87febQVxiLLD5N2
	 lv+GHJrXTNRaPSK82gGG0qZgbo/TyDofXVxzhx9gvCcFGfD02BeoTrD4zPIwEG7a7SchX
	 zvfUfBzY3+QWt2SOCUno/ik9dAQcgyfYKwWItkyyX7nhO/hh4zjfygxq8xD0oDb7WXEPP
	 n+z4OPU7pQCsLmBPp3XQ3OjavkXQ+p6We8Ennf4TwmDywrdhYYJ2ROu5zMrRLOY+aeWnw
	 rsY6Ey+goFi/YtIEdeYaLNrnouRsrtqkjN3uSiXfg3+GI8pgueKWRvpKaiwWveELSbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215025;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=teexMSd8PHdfaM03rUjjEKQ2tL2BcpPqCRX495L4lZM=;
	b=Cs9bWOBkNVA7yAN0/SGx+MzTjQUQHG/Cg/q4WFCwwmuPphPSZp/K1wuxiTIp4fF/JRzh
	 gDXKkOXXJmcNU+9h/7RQEi4g4GwA1QMnWSFxxjLZJ4qXB4EB9QvRxr6xFjuHS/WpjEl8q
	 yVjCSnUb+yC/KcuTFZzoV+sOWzW3wdc/hiogcmAFlGXYRkMyuevgaqlh4XACUGk3oRGt2
	 utBbE4W9SGamJDURQUZhMy2Fe4vKYRRzxzJ/nCxF5/pkrVawwQZMZjZEPoODIxP9udDvj
	 ueOYWDlDQP3usaa8FhEWfnw/gZb7IuZDyyAZ9QjdTtoF71rdqBd3L2G8EoSZNaOM95A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MxsZGBG2;
	arc=none smtp.remote-ip=95.215.58.194
Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110E606A33F
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D110E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MxsZGBG2
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rYwH//s3ZpyAARSSd1MnfBFwVXfqUmxKvytgZIbg1u8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795215019; v=1; x=1795819819;
 b=MxsZGBG2pL2vQa3D3AfiNmNamr9MQJVzZruJXNdFYf3/YkdvmGy1gE09nGOchfHlKXCHgJzg
 IDRuz50KsTg2nq8Md2+cNVD7BmFfxMPkTXR/xvRaFDixG6YjRNNwEdB8ubI5W958cd+Amx7U646
 gyZDdFzvsBNKWCUTxxcYM+C4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 15c7c981e0c8d853;
	Fri, 20 Nov 2026 22:50:19 +0000
X-Mizu-Trace-ID: 15c7c981e0c8d853
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd1ed1fa-2ff2-435c-8e0c-372802eb7187@linux.dev>
Date: Sat, 21 Nov 2026 06:50:15 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] net: skmsg: fix copy cursor when coalescing clones
To: Kyle Zeng <kylebot@openai.com>, bpf@vger.kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, stable@vger.kernel.org
References: <20261120214511.25934-1-kylebot@openai.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261120214511.25934-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/26 5:45 AM, Kyle Zeng wrote:
> A splice or zero-copy append can leave the destination copy cursor at
> sg.end. If sk_msg_clone() subsequently coalesces with the last entry,
> sg.end does not advance and the cursor still points at an unused slot.
> sk_msg_memcopy_from_iter() can then walk around the ring and write into
> older entries, including file pages spliced from a read-only descriptor.
> 
> Software TLS can reach this with an ordinary MSG_MORE send after a file
> splice and a splice from another TCP socket. Both TCP and the TLS
> encrypted-message allocation can use the sending task's page fragment,
> so the TCP-sourced plaintext can be contiguous with the next cloned
> encrypted-message range.
> 
> When coalescing with an exhausted destination, move the copy cursor to
> the tail and set copybreak to its old length before extending it. Find
> the actual tail on each iteration using the ring iterator, including
> when end wraps to zero. Leave an existing copy cursor unchanged and
> preserve the normal coalescing, reference counting, and memory charging.
> 
> The issue was found by an LLM.
> 
> Fixes: fda497e5f5b8 ("Optimize sk_msg_clone() by data merge to end dst sg entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Zeng <kylebot@openai.com>


Hi Kyle, I also received same issue from somewhere, but I think we should fix the root cause(TLS).
I have a fix patch and will send it shortly.
> ---
> v2:
> - Rebase onto the BPF fixes tree; no code changes.
> 
> v1: https://lore.kernel.org/bpf/20261030042138.73739-1-kylebot@openai.com/
> 
> I have a reproducer for this issue and can share via DM
> 
>  net/core/skmsg.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 8a3b8536c0c2..f47c59ba1ec6 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -103,16 +103,26 @@ int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
>  	}
>  
>  	while (len) {
> +		int last = dst->sg.end;
> +
>  		sge_len = sge->length - off;
>  		if (sge_len > len)
>  			sge_len = len;
>  
> -		if (dst->sg.end)
> -			sgd = sk_msg_elem(dst, dst->sg.end - 1);
> +		sgd = NULL;
> +		if (dst->sg.size) {
> +			sk_msg_iter_var_prev(last);
> +			sgd = sk_msg_elem(dst, last);
> +		}
>  
>  		if (sgd &&
>  		    (sg_page(sge) == sg_page(sgd)) &&
>  		    (sg_virt(sge) + off == sg_virt(sgd) + sgd->length)) {
> +			/* Start copying at the newly cloned suffix. */
> +			if (dst->sg.curr == dst->sg.end) {
> +				dst->sg.curr = last;
> +				dst->sg.copybreak = sgd->length;
> +			}
>  			sgd->length += sge_len;
>  			dst->sg.size += sge_len;
>  		} else if (!sk_msg_full(dst)) {
> 
> base-commit: d5ba86298b45e1a81c578c499e9a222a3b734d5d

