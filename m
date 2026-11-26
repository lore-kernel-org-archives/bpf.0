Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693621;
	b=YJiv+kv5ykRuE3xtvhxZ/22BrKj1ju0JLqCCJALZ4tZDiS72vmi0nTvqVEX+GRQNBShQ
	 2DdBNhDrV/kZlaNTsDX2D6HwAC8FDwx8wDXk64nKHLyTu2tgb05y22+eILsB5+hJAmelF
	 o5bmuknC/LQyV0krPPLW293WPR48+Gh2+ODBg3x+NTvDLLwPkEUJ1JlaWa4d4BQidjDNS
	 tuP535lnS8GpHVkfznUaeD+aQE/i9vw0Uiw+1vZ6FMhC1S6BE+CZl8Uxzi/cQzbAq0YjD
	 LHOp6FdWwmCSzaeFiW2RHy9MmpryohmjHL8es5s5S2dMPAW6geRNfyHJtp2OG+rGVSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693621;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ivn1Psu3XjOT0UDZhebXauXh6dqjE8h2Fybirczcnno=;
	b=XIy4KmvLdn2F5WDLXOca4fRqvzrzsY31AX845LZX1OmALdWvU0sr6L8X0yXQKZTZPj21
	 4c+nZBjiEG2sfS+6kuP0GmQ2LTE+DplG7Du1GPIO6+39/qwnV1zBHWsQXlXud2oVSUY9w
	 GShmENtkQ95b8H/QnMA1BtU6y8+2Qgp0lX8MRaElbDstH9KGCMZq/6yiWZOkwWOgdqSuG
	 VF1V1juUyKInEG+vBTniInNq42C3d/ZY/i7zwGz5iJYIwTP43fG94dO8/2GWY+8q/S+D/
	 GAJWeomJrp7xZWBTIL3FiTaVyW9m3Y+ugyO9EdMQ7WsJdA5EOHccn8nGcfpsKz18jxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OoWbWU35;
	arc=none smtp.remote-ip=91.218.175.145
Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBD606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 11:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79DBD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OoWbWU35
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EARKZi3tUvP34hFIJf/sEqfvTJW+Kcy4TT8XVR4TKas=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795693617; v=1; x=1796298417;
 b=OoWbWU356Tbs4SADZr0kUmEDzYW31C0pKAyjCnF+BsrCBdYuTIV+Pomo83VRcYkr9JbKZJzX
 UBI7QveIwsRSqExtEKSBspMpXlEw+zJwiQPhQ1A4jHzE50XV/8fQ8U+0nGlvap2NyoDakSzwvoP
 rbflLDZD3VDLt2VHjYzGvTok=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e6744248fc0be58d;
	Thu, 26 Nov 2026 11:46:57 +0000
X-Mizu-Trace-ID: e6744248fc0be58d
X-Migadu-Flow: FLOW_OUT
Message-ID: <fae65e0a-182c-4226-9694-152c42cd8e55@linux.dev>
Date: Thu, 26 Nov 2026 19:46:46 +0800
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
Subject: Re: [PATCH bpf] bpf, sockmap: Clear the redirect target after the
 stream parser runs
To: Sechang Lim <rhkrqnwk98@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, cwang@multikernel.io
References: <20261126101950.1682160-1-rhkrqnwk98@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261126101950.1682160-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/26/26 6:19 PM, Sechang Lim wrote:
> A stream parser can call bpf_sk_redirect_{map,hash}(), which store the
> target socket in skb->_sk_redir. sk_psock_strp_parse() never clears it,
> and it shares storage with skb->_skb_refdst, so skb_dst_drop() later
> passes the socket to dst_release():
> 
>   KASAN: null-ptr-deref in range [0x0000000000000128-0x000000000000012f]
>   RIP: 0010:percpu_counter_add_batch+0x24/0x220
>   Call Trace:
>    dst_release.part.0+0xc9/0x180
>    skb_release_head_state+0x1cc/0x2f0
>    sk_skb_reason_drop+0xbc/0x420
>    strp_done+0xcf/0x150
>    sk_psock_destroy+0x85e/0xb10
> 
> Drop the dst before the parser runs, as the verdict paths do, and clear
> the redirect after it. The parser's redirect was never used.
> 
> Fixes: e3526bb92a20 ("skmsg: Move sk_redir from TCP_SKB_CB to skb")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/core/skmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 005e09121f00..4089901a9581 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1131,7 +1131,9 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
>  	prog = READ_ONCE(psock->progs.stream_parser);
>  	if (likely(prog)) {
>  		skb->sk = psock->sk;
> +		skb_dst_drop(skb);
>  		ret = bpf_prog_run_pin_on_cpu(prog, skb);
> +		skb_bpf_redirect_clear(skb);
>  		skb->sk = NULL;
>  	}
>  	rcu_read_unlock();


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Theoretically‌, we should reject calling bpf_sk_redirect_{map,hash} in SEC("sk_skb/stream_parser").

Putting helpers into bpf_helper_changes_pkt_data may help but it is weird.

Both "sk_skb/stream_parser" and "sk_skb/stream_verdict" share the same prog type 'BPF_PROG_TYPE_SK_SKB'
otherwise it would have been rejected natively.

