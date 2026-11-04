Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823280;
	b=12vqK9LPJu64flokufeLS3OZHm4KYogdcPc2sYcCVg89wgw1nIY+mEHeMjK5LW7ki05g
	 3rYU4durx8FNYX/oJ1q+E3pXkTM/df++Fla1KjgcSZeSxGaSFjQzdZcWvHPy9gB/xF4WQ
	 mL3+rrHN8W97TnmzbAi8t7pPSURNBxptW/ZX0M1O39CHxYGMR2fkC2So85PWmaFka/gTe
	 Nn5E4iFYvZXlyD8AEKjY6CScQl6tJfg9TxOT2Ey03LzwCQhV/GJvwjQ7dQ6vFRsIx3SLS
	 lwGRkgzfvBd1n3gzLp2UNFfshUzUI2ICZS1Wqq/OM0pvx3fQLh41Va8Gma3pcLv92lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=nAk9TdoYQsbnhW9OiR+BprvysYmI/LWBbcb+XpKe3i0=;
	b=hG4Tze/Vck/FYvB6+zQsX1UMlWQDPICCEMmW1QIGjtk2o8R9/a/xNhskJLjzeWAMweiI
	 Bkzpuv+5tqzB/ISlwweWJTg/qDYLZwzDeKqPPHlXgMNT90OkRwi/zd+ogeqwgBWOm+ORp
	 XJ6cUnvOcdSfIskCNL0uyj2We+6KtWMMb/InSOTfHhnr3tunkk9rjSFUj45XQhSQThFW3
	 R2LDzwGSwZqkIHdtPfuyRYheePYhMBgsgIoNDdbTVUGXzMVnXsDB8ktggHusCb46Ggn/2
	 8em2aAPwOtD1eXyi/BuG5hRg1qB016N6ZMxVOUZAJaeFLJxChdMU6SZwscur/wEXzFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ql+XRLib;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397260B88D3
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 20:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0397260B88D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ql+XRLib
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso706480a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793823279; x=1794428079; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nAk9TdoYQsbnhW9OiR+BprvysYmI/LWBbcb+XpKe3i0=;
        b=Ql+XRLibDWnQ1LnoQjFEX/qf72hQkbUy+kGN/fXTX2FCPHDIlqSMYkBDf3lVI7MaKM
         VUWVMULjccrZBJ/djTGNKLVIVDpRmRhcEZUUQBwZK4+Rr8mO0+Bi0mkZfd2ZHBPpudVQ
         EPZbDUg7TiomNlcc7z64bbg+e4EE+2sg2iMSx3lmLZVHDo+GZSxXWifh1/SaayVPnaRp
         fgl3Wyi2yHuh+5k9k4PHZmTk2AbYt+1hHwsaY8Jwj4YkXCITgQsAVWUFq+2ocr269ahq
         tZeFIBtfeAQ2FlkWYd0pHUvZGR0OtNpSGdz2nBviXUv0PFsroYvJfhjYOzvU4/UdckL8
         DAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823279; x=1794428079;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nAk9TdoYQsbnhW9OiR+BprvysYmI/LWBbcb+XpKe3i0=;
        b=T7DykzboBNWhQCIf7XF958Q2nNPoFQhMYN2bVWw3IKlj78EFh9tiwg5iqF0aSHkeiE
         mK4l1FTnWiebwEm0JOt73zH/KhioVeT1VWOHbxM6WRydNYVEwA0uPNh+bolhsTk2ouf6
         ioc2ZEC+jBMk2NhlMwjjU/GQ+GpfakGf2Kf6f8/Y8G11AtIyV98RfOyOOfGrL8XJEWIl
         Q3DsZKOgMgDW15j6EIAzbKycsoRcMT7O4umorRbX5g84hJjpg8JkF0Ubh9QBlwzodPjI
         6V+94telqkDBCXCfFyem5CCAroChf4QmsUp3acZOqpcYAPdVd1gn1IQQv5qhKaqFpHJX
         hyvQ==
X-Forwarded-Encrypted: i=1; AKwUvByPU6EymD4wnDjo9qXbLTmif3h8xDF5qOl7qQHBpPZmczQCPa6CIyrT1ui3CyAERZK+S7E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O7QTrjyOnEVG1ZgaywJIRQmOGMUv0XODw7/iCbKnNS4oR7YcI
	tYy9RLqNRi807R3DmLS0f/fEC3wxVj71bHtQ0kRPLX2tnLBvtpSNAJZk
X-Gm-Gg: AYBFou2sQ0qUKq7GqkqP3bdhLoJkjuluim6/alQUbAL0CVFbFgFfoRIAXblIagDc0S0
	saWPzhNqZ+b949OldWNx7n3Pge5+zlh2Qnuv0JVNI4XSnZrysQTU9iHuIFqVtsbijw8ig6qkGIl
	RqiB3Vn8NsWPm/N0JXdejUAYS8brptYMrpZAiEtVXNWu4volgVvqovdIpk4lknBH/JGoYxcMQPC
	WrrXvKf7RW4gD4dpUIZedkS2JolBJv6pDvyNK9f7pJl/WO2pIByM9EU/tCgjUpRWWIGWvG6JdBe
	p0rvB9mqYzBKcC+mdvIS+xmMs+h7mlBYZdYQ6ZKF+XfUbpXNMBIGgjIUfXOKc2kulyb7UxpabtG
	eUrIxuPaEv+9HQH+xPdaqpp+53UGV8I2pYPXR/STH81GbZ1/B2yvX3ePyNRu2t8G0ko1rjHOmKb
	ixOZyiSo7yI4LyZvnGwC5V2cRr/HcU4HEwQpnHFeI+PmdiP9PT+f3KquxLmSlpjvREjyn845T4p
	UPN3GaW2ouGnA94I1C5J0ftyc6S0mOSpPzjeqIlFOYRyMihCpMaMSh/98L3Tx06GYqsy+DzEFtc
	3p0z2Xrr0sSyJESQhFMbbE6fTZ0JBUWwuVXkZ/ZxrMz/ajO7pPGLGN+xPb4NVfSlVoKxgvdgGLk
	EtAYjBXxtVQ3+u9UvHWpwrS4dXzebMsJ/hro=
X-Received: by 2002:a17:90b:57c5:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3ae897cc815mr14967216a91.13.1793823279118;
        Wed, 04 Nov 2026 12:14:39 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094ce9f65sm2992245a91.1.2026.11.04.12.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:14:37 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 20:14:36 +0000
Message-Id: <DMMPA4SE5V7I.BQOTSW259XNA@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
 <mbloch@nvidia.com>, <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
 <edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/mlx5e: Prefetch packets of upcoming CQEs
 in the linear MPWQE path
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261103235823.536706-1-antonio@openvpn.net>
 <DMM0ADCEGAAB.2RFNF1ZI5TGWK@gmail.com>
 <f4bdb8b8-45d6-477d-bd7f-4ca4bbafef7c@mandelbit.com>
In-Reply-To: <f4bdb8b8-45d6-477d-bd7f-4ca4bbafef7c@mandelbit.com>

On Wed Nov 4, 2026 at 7:46 PM UTC, Antonio Quartulli wrote:
> Hi Alexei,
>
> thank you very much for the review!!
>
> On 04/11/2026 01:39, Alexei Starovoitov wrote:
>> can we prefetch 4 strides ahead without the CQE, like gve_rx() ?
>
> Yep! I measured your version against this patch on the same system (one
> RX queue, MTU 1500, mean of 3 runs, gain over stock):
>
>                                     v1      yours    yours + shinfo
>    UDP 512B flood, packets/s       +39%      +35%      +36%
>    TCP, 1 stream                    +7%       +5%       +8%
>    TCP in an ovpn UDP tunnel       +36%       +4%      +34%
>    XDP_DROP reading the packet,
>      NAPI CPU cycles/packet        -38%      -45%      -32%
>    XDP_TX, cycles/packet           -35%      -30%      -33%
>
>
> It matches my v1, except where every packet becomes its own skb, like the
> records of a VPN tunnel (ovpn from a development tree here).
> In that case I got only +4% instead of +36%.
> Dropping only the skb_shared_info prefetch from v1 gives +5% there, so
> that line is the one that matters.

Thanks for the benchmarks. Glad it helped.
