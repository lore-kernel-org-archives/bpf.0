Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA371448E0
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744876; cv=none; b=MBYZNdXRSAT5xwGYiQ61f55f/oe13jdbzry4Gh3RrQNCiE8mJWhBtdTKBS5Ej0NgOTntXprr8gfMmDyVr0ynKzbxpJmdnl3eRAXU/dwfg0Bg97n7kfh2mXwkatkUeiFvPitKgxV4BYgLnPfw+OZ4aPziDGMsVhrUsdj+uGyEv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744876; c=relaxed/simple;
	bh=4dFXEuel87yyPPmXOJ0zQXoMveEW9FQlrdOnqgKI4ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7Qsts5IbuJm1/tCLedd1uygtBqGu5pwN9MSSu2moiTF8m4/6+6xWrl6aZ5lSVZBdx1/QMv3JEN4XnazyKHWnR9EDgv8WSafpajf/0t9tJhtyNVPxd6EMLNe2M7MugkI+or/gtvrh2jRzWr+Zl5o3vLYJkIE0Q+qCGvGSLpU9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I+mLOE7f; arc=none smtp.client-ip=95.215.58.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I+mLOE7f"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4dFXEuel87yyPPmXOJ0zQXoMveEW9FQlrdOnqgKI4ug=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788744872; v=1; x=1789349672;
 b=I+mLOE7f4vHxm1sVyU608jw74OeaFVgHeSOtYn5Ap2qlrn4WDXDY8+K51YP6muEtGy5K/2Ga
 uVaGFBdoh9pmSAitI4Qm10oEKQDcaMrNMBKGqslHgfRa92Fxe7SeQf8iLGATZWcLOOEllmlc+qd
 6QoDjHPmiXm6G2d1QlQasMm4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4e1794e827747af7;
	Mon, 07 Sep 2026 01:34:32 +0000
X-Mizu-Trace-ID: 4e1794e827747af7
X-Migadu-Flow: FLOW_OUT
Message-ID: <949b0983-4491-474f-b105-5a69925dab69@linux.dev>
Date: Mon, 7 Sep 2026 09:34:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf, sockmap: Fix self-redirect copied_seq
 double-counting
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <1d2370f4c81f10834b8dd77524924575c629a464.1788591198.git.tanggeliang@kylinos.cn>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <1d2370f4c81f10834b8dd77524924575c629a464.1788591198.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/5/26 3:03 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> When a BPF stream_verdict program redirects an skb back to the same
> socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
> calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
> skb is then delivered to the socket's psock ingress queue and later
> read by tcp_bpf_recvmsg_parser(), which also advances copied_seq via
> the copied_from_self accounting path. This double-counting causes
> copied_seq to advance by 2x the actual data length, triggering:
>
>    TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
> 			   rcvnxt BF2E806, fl 0
>    WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x72b/0x2640
>    Call Trace:
>     tcp_recvmsg+0x10a/0x500
>     sock_recvmsg+0x168/0x1d0
>     __sys_recvfrom+0x19a/0x2a0
>     __x64_sys_recvfrom+0xe4/0x1f0
>     do_syscall_64+0xf7/0x530
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>    cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
>    WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
>    Call Trace:
>     tcp_recvmsg_locked+0x8d1/0x2640
>     tcp_recvmsg+0x10a/0x500
>     sock_recvmsg+0x168/0x1d0
>     __sys_recvfrom+0x19a/0x2a0
>     __x64_sys_recvfrom+0xe4/0x1f0
>     do_syscall_64+0xf7/0x530
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fix this by converting self-redirect verdict to __SK_PASS at the
> beginning of sk_psock_verdict_apply(). This bypasses the
> __SK_REDIRECT case entirely (which calls sk_psock_eat_skb), letting
> the __SK_PASS path queue the skb to the psock ingress queue. The
> data is then read via tcp_bpf_recvmsg_parser(), which advances
> copied_seq exactly once through copied_from_self. Cross-socket
> redirects continue through __SK_REDIRECT with sk_psock_eat_skb()
> unchanged.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>   - fixup the verdict as Jakub and Jiayuan suggested.
>
> v1:
>   - https://patchwork.kernel.org/project/netdevbpf/patch/b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn/
> ---
>   net/core/skmsg.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05..df385a5a961e 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1000,6 +1000,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
>   	int err = 0;
>   	u32 len, off;
>   
> +	if (verdict == __SK_REDIRECT && skb_bpf_ingress(skb) &&
> +	    skb_bpf_redirect_fetch(skb) == psock->sk)
> +		verdict = __SK_PASS;
> +
>   	switch (verdict) {
>   	case __SK_PASS:
>   		err = -EIO;


LGTM.

Please target to bpf tree so that BPF CI cat capature it.


Thanks


