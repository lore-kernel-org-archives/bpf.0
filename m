Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9812C08BC
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579267; cv=none; b=XumGB/G47LEZA69R8ffGNkVovAlVjvssYkeAaCs2kO9xtCTZw1DhOE01D104dw1/KKfbjuP2k8oZFcx8egGSKvAfbCl5tZipIoyjPuZVg43FEIju6axwIJKidQll5FuDXp8rwz7kTb1t5Dnd827guDiBSSZVoYvKQk7iZDkXKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579267; c=relaxed/simple;
	bh=oP+lMTpCs/MmCwIYHBt69Rx7OGgXh1o1Niw4wj3xXv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkKT1gXfEE9tMirbpmRoxpFDeGNvjrPcBJar0rgOGQ6YFDM33tKsPYLTLn0PALTGPZTCntqQIsNfNSfgezru60PO0ah4KSmttaPUsSh2l5BpjW2GUaL97dfx6ZiQM/5IQBAdQLkoEP0LkBGi7unMpnKMU7bHz2hOudQOzf29r5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgHAkiT7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgHAkiT7"
Message-ID: <e683a7db-b465-4b34-b002-8f22031c77ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778579253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvrH+Ii9BjHSgJDxxEyJuHR+FWTHspsLDdnJSbT4jsE=;
	b=AgHAkiT7KixQP/FeD0poHKsx5Dep01WrHLXHY434tmofh2griLBM+z7tLjN/RTd0qLAdee
	SOAUP0TwZ2xxb/j75elDqp8wnaAsozzfA8zqPSsAOV2wUO2jUgQPYKqqiL0KIOJN9DYTdy
	bhpJniS6bqnmABez6b8u8oMg2Y3WjpE=
Date: Tue, 12 May 2026 17:47:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 3/4] net: tls: fix use-after-free in
 tls_sw_sendmsg_locked after bpf verdict
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, sd@queasysnail.net,
 john.fastabend@gmail.com, bpf@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-4-kuba@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260511174920.433155-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/12/26 1:49 AM, Jakub Kicinski wrote:
> bpf_exec_tx_verdict() may return having modified the record
> and the plaintext/encrypted sk_msg pointers. We must always
> reload those pointers after calling bpf_exec_tx_verdict().
>
> On the wait_for_memory path after sk_stream_wait_memory() returns,
> the post-wait contains a shortcut:
>
> 	if (ctx->open_rec && msg_en->sg.size < required_size)
> 		goto alloc_encrypted;
>
> which dereferences the cached msg_en, which can equally point at
> a freed record if the prior bpf_exec_tx_verdict() split the open
> rec before returning -ENOMEM. Drop the shortcut it seems to have
> only been an optimization to skip trivial intro of the loop.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")


Is the blamed commit correct? I don't think I touched the following code 
in this commit.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/tls/tls_sw.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 3bfdaf5e64f5..360f71fd7884 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1112,7 +1112,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>   		if (!sk_stream_memory_free(sk))
>   			goto wait_for_sndbuf;
>   
> -alloc_encrypted:
>   		ret = tls_alloc_encrypted_msg(sk, required_size);
>   		if (ret) {
>   			if (ret != -ENOSPC)
> @@ -1255,9 +1254,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>   				tls_trim_both_msgs(sk, orig_size);
>   			goto send_end;
>   		}
> -
> -		if (ctx->open_rec && msg_en->sg.size < required_size)
> -			goto alloc_encrypted;
>   	}
>   
>   send_end:
