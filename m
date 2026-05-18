Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD382D0C98
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118478; cv=none; b=oJb2sBG2TqOpBZNZAgD8aH0XNXrHRGeyoTZtu+henjRutjPTCGlHydFOYZHyr25NFwsD4Q4uY3Y5CBVtQW65XPhaX4fbM+cH+AGdiewCsHBrEAhtQ0HtzYqG8fUwbRpzLGx6eUSBgs1gii4fdh512cETZ0SkGP2YZYLx2q7gUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118478; c=relaxed/simple;
	bh=tbBqVl2Rwq+ug/3pxcSsXUY2Omq/LcBl+AADnhVJGJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGMzSdXaOczI2w+JSPhkIgJUnpXqj0v7Q2jJxeWy+ldtL7xXa4uovMFIU1KZa2lvGhCssYkWWC9pGHrBctqswh8a5dcBRYKAWKhFZLTnckB9hL9K0PL82jGjbWmnFHTNp3QIKpwPa6LJftaCYxT+TAr4o2KYfbpXzAPv4hOIRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tA1IA9X4; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tA1IA9X4"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7bd65714dcaso18335887b3.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779118476; x=1779723276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQbyMvz6XLiuRTxyqtiLM3EHuxR7kEEq3JV9iEUFgR8=;
        b=tA1IA9X4xgPK8efiksGsoB8Im0KF2PQUOu2+0Oe+VxGUj4fbZ0cxjWBgPRwVgT5dIm
         dWQj+f3pq/uQxeuFhtbTPAGXgNyuxFfdo3yo6pphc/0kl0DQwBjbMJRIEPLC8/ukX3A5
         sWet9IW6xWB1MFtEQpFsF6kxrSTYbyBcOaorUaLa8dlfvuTYZCccmCt4u+do+QjWgd7t
         j3U0V3aRsTfmrqpCz3ZNIowJRLQBf2vLzGNrDUSASSRu19hNkl8BRpS4+2wzQJBPnPei
         5e4KqjEx5GFfyrReQuo1s9vWiRiff95nbndkC14jDGzZp6nSO4dMyeJjnoX+b2qFQKLX
         oHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118476; x=1779723276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQbyMvz6XLiuRTxyqtiLM3EHuxR7kEEq3JV9iEUFgR8=;
        b=b+TCbm1zMa4QYUcdQ3VFl0oeiGPZQ+YkU5ZsLURzx8G78NlMwDKU6GmRlJoODwZ7lN
         gsZfhHFmeeYh76u3usvB4EzPk+4MR4wK1xf03CozHPadNIpwRaZSIef2OuiqyHKg2Uph
         Y36JLQKE2we2EaHValoSifPDapHpP8of+wEaXem8mJSTxkq0k7uB4P4leIWoJRJXtl40
         +28Uu31YBsqED7tYlKWahTS0+G8xny66g469bIaNJPxKlZdSKsTIXREwsrO2sgTwTltI
         Vtt3NXtdeVWi0U+GvrQxwYcSsdosky0vrkJm/7S8QYE68cpbDOBPAAzdA04uD/SEBWZ/
         RI5A==
X-Forwarded-Encrypted: i=1; AFNElJ8MLDRHuJaphvswk02Tf4cmFdV6ixTInWu7CmrpdoMhXtHEcnN35jWTbJZaQ2EkSd29X94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSA5TD02WHTQMbLcaTBjWRCwY6G6Uj1Qgx3/xmtO2zaD/Afnl
	mDc+/yCt6eTg3GTT+Nu69TKU3rD+we8kEtCjkIdgehtH0fryhRK8OafQ
X-Gm-Gg: Acq92OFrCFVWAKSADIvSSgApXXh95kzi98CVh0nMtY82oM1OJazgpg9NrmJHdfXMQrF
	rB2ra+2n/GBHPcLACupqz/WF6vVE4SYdQmI9oJZYLUk6I6tHXG6L//lDU5wMuHEsgoCLA6OqMSb
	T0Db1UJVHVwxEl+/rpRsYoFjD6LdCvh7Q4viUTRpVX/lKttnyL3CG/+LQ2ElUbS57GMzJ4ie5AG
	MdNWycoyeJTgaeUWvwwYUzvke1b9Jmo3NMMLLwI4LCTqZ30Tuobj51/64Bo1nHalPc3/z2AgkhE
	guIYz+riSQ4NBPMpSgaGG8tE7zvl8XzEE208rA5fElwwUZXW72lN9pFdJADCyxb+31mWQujrif4
	U3sUO8TA0kKHaVXzQ1bdkkNCf4b+TpMB5a+0Xi+igPpYkqUqMMhAXLumGF0zM1FHx5wCx84fShO
	ZysxUPx37Z3rODS03SQUQiermeNMY=
X-Received: by 2002:a05:690c:c1a:b0:7b8:bc4e:a54 with SMTP id 00721157ae682-7c95c7edf69mr180168827b3.29.1779118475483;
        Mon, 18 May 2026 08:34:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0eff6sm22692987b3.23.2026.05.18.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:34:35 -0700 (PDT)
Date: Mon, 18 May 2026 08:34:34 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
Message-ID: <agsxE575ri8iLgxM@devvm7509.cco0.facebook.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518082344.96647-6-kerneljasonxing@gmail.com>

On 05/18, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add two if statements to accurately isolate bpf timestamping and so
> timestamping. They can work respectively.
> 
> As to so_timestamping, only add a loose condition via report flags
> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> and performance impact. If the loose condition is hit,
> tcp_recv_timestamp() is able to handle the exact case and doesn't
> hamper the existing timestamping feature.
> 
> Make it work in TCP protocol.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 21ece4c71612..64c69bb3578a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
>  	release_sock(sk);
>  
>  	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
> -		if (cmsg_flags & TCP_CMSG_TS)
> -			tcp_recv_timestamp(msg, sk, &tss);
> +		if (cmsg_flags & TCP_CMSG_TS) {
> +			u32 tsflags = READ_ONCE(sk->sk_tsflags);
> +
> +			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> +				bpf_skops_rx_timestamping(sk, &tss,
> +							  BPF_SOCK_OPS_TSTAMP_RCV_CB);

What about tcp_zc_finalize_rx_tstamp? Do you not want the rx tstamp for
tcp rx zc?
