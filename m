Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618362;
	b=jc1LB1Gtd3tsuaXPbOsMkToEJDe/Bc+tQ84VUZGfyvP8Cp+mM7nnGRVFl2ZTYsfvAtaW
	 OEQdHQFAfImUfO2A/qK+bwGdi1Hit2En+2HXJ4bVh4CvBnnCOkLRdic/74AX22gg1p88K
	 YkFTRhsl+JDrYFd7G/4PJApzrAwXKk/dhwQIKnL9WzucAcLZuHONgvQT4uZK/OoX2iFyp
	 HbTWrTnySl3Yg6T809ZBPVR8s3nRqbFNuPtsb9aqf8WRolZxnG0FeH3CmC+BnhDfR0cYR
	 fK9jt4AVjCrxt2TDOyeUUgQubnEIyIy5ewgdj/zkM/9dBM/BIDBAKnTTBiLFDyqzMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618362;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dRXNIv+DjYJ9+xKJw7sbi+h+wlCEfvAUG5KDSY1I8Bs=;
	b=zV7O1UWpKNavIgr3Nd42hFnTPLLV3rVloZ9fFY/cjp/DMudH50ABw74HJHGKDciQXPzp
	 pSv3qVLRb1YljXCNoNMYJPC2NumHsiLQcrQjsZ9xheddnDg4cRGD80P7jkT+ltVO7XxQz
	 gP8HAq0L7jFd5XdegSsRZz2gmBJV05DnsOYOJjdqLfvd0LgvcH3dLssARS3QrB3i2XsAw
	 +tT3DKUP8X1ei1ieG9rb2aeuD3E3FMiKd8CRMHByllBbRSVBfxHaEKUKE4+0iecle5KDz
	 sJgxh6xQRxpbQ5F5hq5tK/x/XytjSinmz90mn8996vtg1x32wb5IEHhU0Gekyr3x7eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IxGU5tNT;
	arc=none smtp.remote-ip=91.218.175.196
Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A3606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 11:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9A3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IxGU5tNT
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kdrMq5KnZifKZQNMAwZlFHNok5RGWVsm3UzqOukQXj4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793618359; v=1; x=1794223159;
 b=IxGU5tNTW00mxD1061NSfytTWBcJgf2THMlRUiwpR0NtaICUnmDdp/LaCuJ2J15yN6mAwZ+I
 takgOxP7DoJJQU4mc+WQ9EPYCaOaWaETfCWG4k9WB+ZlooddlsE4eqM9Kaae8V7IqMyO0VNgYN1
 qsXQvE5rLy1rax1Y9mK1Ev/A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4f07de2689d355c0;
	Mon, 02 Nov 2026 11:19:18 +0000
X-Mizu-Trace-ID: 4f07de2689d355c0
X-Migadu-Flow: FLOW_OUT
Message-ID: <f846ce70-58b7-4932-a1ef-35ffb747387f@linux.dev>
Date: Mon, 2 Nov 2026 19:19:09 +0800
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
Subject: Re: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes
 from the return value
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
> message. It then subtracts tosend bytes from *copied, the return value of
> sendmsg(). But tosend is the number of bytes that the verdict applies to.
> After bpf_msg_apply_bytes() tosend can be less than the message size. Then
> sendmsg() reports dropped bytes as sent.
>
> Subtract the number of bytes that sk_msg_free() frees. After an error the
> SK_PASS branch already does this. The SK_REDIRECT branch does the same if
> the message is not the cork. Nothing changes when tosend is equal to the
> message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.
>
> Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/ipv4/tcp_bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index b016aa419fb2..36d1bf46353a 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -521,12 +521,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  		break;
>  	case __SK_DROP:
>  	default:
> -		sk_msg_free(sk, msg);
> +		/* All of it is thrown away, not only tosend bytes */
> +		*copied -= sk_msg_free(sk, msg) + delta;
>  		sk_msg_apply_bytes(psock, tosend);
>  		/* The verdict holds for apply_bytes, not for ever */
>  		if (!psock->apply_bytes)
>  			psock->eval = __SK_NONE;
> -		*copied -= (tosend + delta);
>  		return -EACCES;
>  	}
>  
