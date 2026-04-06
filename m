Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1C14A4CC
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442519; cv=none; b=FjyyuVYjTE2XH4D2hpJeuNrC7GogzS3KTCiZBqyAdRRH5hjv0ntBzs6mbkdnj76x+3AuASZ8mXd3NoHDjymVYmGcTWin3rKsSQOMvvvK61eiD1orhlosRVrn5tpI3neVH/1L0y4C71HfCcCl5cMiSGV2KNIDVzSN8Z16TqMiRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442519; c=relaxed/simple;
	bh=gPhK7Alr55S45PmV98K6LP+ammYGOm16NrIMAbQUiA8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ecpcCPnjMV/UwZdxWKXxPR2qpjw4Pf9cXEb0dBlKsvTxfadYYYLep1sQG/IHFJVJsB4k56M2GCG1zYE9+QDclN08pQqRaPtrC+jadp3Fnex0HRCrLGfGKW/0G6Z6xxpHNfTJPmC7QXdnIQEWUT62uzF3gfndYE6+0X4G+ZQd9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guEgBTGJ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guEgBTGJ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7dfcso29503517b3.0
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775442517; x=1776047317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c0HNGgHv3b1xvu0EqDfMupLPT0WGKpfbbK/oIqVuJk=;
        b=guEgBTGJDFeKBdq1LqjV5VDxRFn752dUucGfBs6adA8nhv5IyicPb6grmY7SB3D2Ak
         Xu2soZJRzSf3XP2mBQZEb1WDYinT+AQ0TRTsh5c4VnVPzHtaQGbOWpA/queBR66m+GLD
         ANn+wN7YKLUw1JK82gvJljPTSdAd8TbEBOb0zcO9KcPjDItlcLcK0G4yKCIejpX23X21
         Aq7lF/eUtJ9Ljl5MyTzvAfxTJLCPS/QCGWvHH/vMC9IpWJ7bfEk3KNnhtDLy+ubFONvZ
         5nsWIqSCqJ7N4mlPOOq5ohtdEYCIS1hvo8DH/qazRDKiX3hY57oFm723zngyIwgWe72j
         4GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775442517; x=1776047317;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5c0HNGgHv3b1xvu0EqDfMupLPT0WGKpfbbK/oIqVuJk=;
        b=pmyFCeD0TiWoa6P2fl548iW+kJwAE3nZCxajTigi32tuOYP/FnzrUxeZDSO7EQt2JZ
         PE//cA9w3oC1YRjNg57oHL4XJR8Pj2BOCo22MP5pTFH9vISjjfETzh+np9RKzjGWmIpE
         aOTTKF8nViESp7kkhNvntrp5/HT87hOfT9nuooxFBSDUOEQkPyGDB6hHml+pyMiI5cpw
         Em0UCYcZLsUy8e0p4EqTHBsvPGkIbUSbNvlcKX5hv7a2Bk/9eyS5xX5o8jLrmW7oyqOY
         N8p2lpp2CoTrfsEH3LTPimgLEVEqA7OxVyo9lHWqz2f/LlHm4b2csfEuew13oYDjRTDB
         Z46w==
X-Forwarded-Encrypted: i=1; AJvYcCW5pwnrrvmMLvhO0Zp3wVCN7u/tHARmETTejZPjdiG6zVXac4bfZScXEzEDfuF6pNY4DsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5mmkjDwl8LRUYVuY7L+WTX7Y+6xSiIdjcEdshR6IfhHSpD60
	8SwD4jadltiwVz5PfjdOdVZyjKhLm91OQQKF2h5yea0hkiXVLszLq/oU
X-Gm-Gg: AeBDiev0vOKRBijbzlZKPutmHq55VswnEf7GotnTEvq+oHOYh6UGlWKXgXTBF/FuJfM
	RWKAwYaNGtZzKEPoN+qsqKChyxtLDvmwT39q/ZwTwE6wxQ9NRp1mCB70P1bodhF3rRErQ8+WVQu
	I6aHKllzBoptxZVM+bTIknE922gzQWP3psEL+8Co8AEubjD3nJIc40hfRaX5hntyQ2PPphpkFVk
	nylzwJ9q4Q9LXEKYizdfuIrQlBgdthlkIIoOv5ykV/V5VddQ1LrjKbDF3K1HZ5S4rzMRA9/uSfz
	KX5jEHrG/BINUDc3y1ikwBauINeaMYKiz542sfwX8PTbJqFlyxwHkapNoEP1/wVaa7UcbkFJ/LG
	maifunOrkq727zTFD3pu4xtmD+VuOnSgj5L88AMwSE6KAqCfZYwRsyEj4OGOjPY3kvQKSDmLCWg
	476ds1EM4ts82DpdQTYQVSI/FJJnq/uwdJrhxWyXU1ubfSI7PtjrUKb2tRaK+Z1/qlY7Gtmw6G/
	vFj
X-Received: by 2002:a05:690c:660e:b0:79e:1fe4:80d7 with SMTP id 00721157ae682-7a4d5d5d907mr104832267b3.48.1775442517236;
        Sun, 05 Apr 2026 19:28:37 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370ef4af8sm48861247b3.41.2026.04.05.19.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 19:28:36 -0700 (PDT)
Date: Sun, 05 Apr 2026 22:28:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
In-Reply-To: <20260404150452.83904-4-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The patch is the 1/2 part of push-level granularity feature.
> 
> Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> though it might not carry the last byte of the sendmsg.
> 
> Prior to the patch, BPF timestamping cannot cover this case:
> The following steps reproduce this:
> 1) skb A is the current last skb before entering wait_for_space process
> 2) tcp_push() pushes A without any tag
> 3) A is transmitted from TCP to driver without putting any skb carrying
>    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> 4) sk_stream_wait_memory() sleeps for a while and then returns with an
>    error code. Note that the socket lock is released.
> 5) skb A finally gets acked and removed from the rtx queue.
> 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto)
>    'do_error' label and then 'out' label.
> 7) at this moment, skb A turns out to be the last one in this send
>    syscall, and miss the following tcp_bpf_tx_timestamp() opportunity
>    before the final tcp_push()
> 8) BPF script fails to see any timestamps this time
> 
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c603b90057f6..7d030a11d004 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  wait_for_space:
>  		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>  		tcp_remove_empty_skb(sk);
> -		if (copied)
> +		if (copied) {
> +			tcp_bpf_tx_timestamp(sk);
>  			tcp_push(sk, flags & ~MSG_MORE, mss_now,
>  				 TCP_NAGLE_PUSH, size_goal);

Now the number of skbs that will be tracked will be unpredictable,
varying based on memory pressure.

That sounds hard to use to me. Especially if these extra pushes
cannot be identified as such.

Perhaps if all skbs from the same sendmsg call can be identified,
that would help explain pattern in data resulting from these
uncommon extra data points.

> +		}
>  
>  		err = sk_stream_wait_memory(sk, &timeo);
>  		if (err != 0)
> -- 
> 2.41.3
> 


