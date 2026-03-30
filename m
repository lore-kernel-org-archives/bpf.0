Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D93284B29
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862780; cv=none; b=MyKSpdHl0itoeS1+HvjjYH4KMcpyU1t2XtVJPL1eitMueYkGPny4sG+CAqGNT3YEsLoUSIMrx3hLQQoUQ6kvaRsnqQalihKanHa7qdQmF3Lm+ncFd+ld3oMYTKfIK7j5cg6xnY6Q1xoOcJGHd7khqGlAaOY+si7m5Tkz0AB297Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862780; c=relaxed/simple;
	bh=DR19R+3fwQ3BqBBpwMykWcYWQRMojXvEWPI//+c8MMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXuTD09CpHegcaOfQRE3o5ZWSYJM8UyXB9U5fJlCS0M4Ws+kJugGwoUuumm8MN1bk+g8khBX9PGT0d71xyRFA+3/SWfoqum6hw1DWZD8XUb0oZzuPTIwBrbKP1m6CkPzI1C7olRn35QHzZp/vmcmqBBjy9MQotYQKCfheNg+WcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IVsvXuD3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IVsvXuD3"
Message-ID: <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774862766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKBqVj13lx/MPnFDQq/AzvUbYUq2ml+LYlzgDV8zhU4=;
	b=IVsvXuD3BI5AT7lOaqhItODLuwxuhhJH9UAcBtnfs8fPS/sdINqCXBrdatpb5LtrRTmLV9
	jTKCHiS6x4IAGsJaXleZp+AExrvia2yYMkbkI4mSfYG0Y2BhQJ+ri3xBxdoub3SYjrWo8M
	uBQt0RRWznpezirxHId+EQTO2D6pckc=
Date: Mon, 30 Mar 2026 17:25:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: kuniyu@google.com, martin.lau@linux.dev, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
 <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/30/26 5:00 PM, bot+bpf-ci@kernel.org wrote:
>> #if IS_BUILTIN(CONFIG_IPV6)
>>   	case htons(ETH_P_IPV6):
>> +		if (ipv6_hdr(skb)->nexthdr != IPPROTO_TCP)
>> +			return -EINVAL;
>> +
>>   		ops = &tcp6_request_sock_ops;
> For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
> immediately following the base IPv6 header. If extension headers
> are present (hop-by-hop options, routing, etc.), nexthdr would be
> the extension header type rather than IPPROTO_TCP, even when the
> packet is a valid TCP segment.
>
> Would it be worth using ipv6_find_hdr() here, similar to
> bpf_update_srh_state() in the same file, to walk past any extension
> headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
> always identifies the transport protocol directly.
>
> In practice this is very unlikely to matter since TCP SYN packets
> with IPv6 extension headers are essentially non-existent, but the
> check as written would reject them.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary:https://github.com/kernel-patches/bpf/actions/runs/23735111188


Thanks for the analysis.

There are many places in the kernel that check nexthdr directly without
walking extension headers.

I'd prefer to keep it simple for now and leave ipv6_find_hdr() as a
potential future improvement if needed.

But happy to change if reviewersthink otherwise.

