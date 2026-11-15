Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794785806;
	b=afGBJC2gfrAKp7+g5nDJSJojI1bJCq395c/vgydCLmgXNWHtFp4C5wLXQ5+ob0fZ7l98
	 zxPA6y8Jyc/Uo83IxbYF/w1/JbXOk6fvAWYolscOogKzuA4i8SUaz6feoE0ac7Mxl55cZ
	 dUCjopiHWMIkZG7yDy7GEljLPz+eLgIyLRWTkHLvdh0y0aT/L68iHfXeNXUOzRUBvuQwe
	 7moAVjHpnoQ27kdD2oPjMJ9Pk6jBF0AF057MBufathMhBSvQod1LAyP6rL4dPuPgIssTx
	 s595yrlYSItBBJcPZbz7OGIe9HNtfJ08fhNuLlRSN7HX9wn6HleCOxoFJKzJma5z3rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
	b=FivNAo7mL/egH+EA9Uaj4MJWnPZIWmxsKzh1F4nRKqgMJWWct0GuYvNmnBcmOrmnDON3
	 DCSinE0p1l7yJLUkOuN+Iar6Er6h/EnwjejSPmx1lJJfp1vB8QeaJY3XeCtNe+EUy6vtB
	 gGY8ijEUVFeZFSPTbEebNLGOMo5LAiyrl2tVS0vyX6ACUTtCmVlRXDUgmFxDgr4e6B/Lb
	 Vy20bxnkpJ5URl1Pu3SH2gPjveQBU0h8eRefIOVFt25EZO+938Dt57F9ZAxjckgUir+em
	 6wK+IA4H96iyNUb9pf1XkejgOAHG54muQXC5+7RBjKIXlKtH4Gl/OgkRZmhiUVmp8SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Zmpxi2jL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC1606A31F
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 23:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EC1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Zmpxi2jL
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-70b875f6f1fso3295660eaf.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:36:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794785805; cv=none;
        d=google.com; s=arc-20260327;
        b=LAPS2ACNqVfS4GK6L+SbM24LZUTIUL1l80daXq4ZjVVxEODN+lg0n7t843IiAZ8+hT
         cz65etgTaWsATT50SH0uLVVUryLkgefZZUKcpOc6PNVOuGVND3zApHPSCdm4J8iILgWV
         585tMZkMn2JRWL8l/hQNCLiJsP2eEjZH4hz7G/oPfYjRdwKVRTNNFqaoc2wdlYfqx4Di
         6RaEMIJ+0qVD65aztI3zKBvXwuWU5iqChIdC43c0Cej10D05om70aMaopS2AMVTFuVuM
         5g6sYIQhjnHJqsPQY6S27TcUDevIVqa/Vits/zcu/wMLSI/CvsPqDZOA3F4p+bVj5gr6
         W2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
        fh=98JoR3VmPWICny5PTp+47R5mRPSei2P3fZLQdH8xN1M=;
        b=A6jQt5MiwFb9J7OKWFmxtkkIpf3ZJ/mcslLx4VkQh5VPyeL6udD7D4X6UP/HzZnu3/
         TfyLVXGVl5RgJ9VyX4WuDPpDZtu0EtDWkUmCFDjA0BKFpd6MiM3WhYERbFaQBQOELxQT
         noT/2GGKAVR/ijeH295UTTIinFqd7ptM3U98K9KMkyCKYh1BHco5jjIa0maHCKlh7fdo
         9LpchTX7vuPcIQZs8coG16KvqVZqd4l+8PEKxDvg/vE1dW8JVs3xqtfHi6LjtFbkETc0
         PcyymLcdXZNEnQqRC02+kNRkCOuV6bqYKenWMeEM3hx0tOBAv73Ms+2T7jJTtzInq9vj
         4qpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794785805; x=1795390605; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
        b=Zmpxi2jLhXSm+xCyJlTdzyhYrYxOhwtwnZiPPOViT6SmtKy4Igqbe58in1dXdljPa5
         odULis3BU8aEvIzMrkCPSOWvtShZW07qQQKGRG/uCEK40LNJvS9VS1MHC+1cK5cE+88x
         Wkakd87wbsOKtHD+85cG9Y8BDYm21VJUwuormhJMhBg6ms6ZqxN7bKewkahZAArP4k5U
         4iyaONp5TNg1pYjLWDT0L0NCPwogNvCbKN8doTyDHkmy/1O8TDtKGuMR+ZhV1GvB4GjX
         YNF9M/z+z1n0JUvO57uhcw7KQgxPFjtEqMAGWnxKoh3OFvh6kp8Z0a12mv3XIxy+drs8
         59Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794785805; x=1795390605;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
        b=G12sy3NT2g3ZrzgC1AHpRqAWDmZ3UIuxB6H3ZK4rlvAxgST7DDKYcG0fZEXIkj2oWg
         KlmG9/+TTf6OvwEGhEQAAvfiSQOSJjTJQLGBf1I9029SvzxE8RqxjS1PUdOSIOEgkor0
         O+QF372AaUCoMO7Aviy3JQ+glWjNU4MUcE3aJRc2SllJiPLikma4S6tK3JvVCvGVNq8u
         DAR5Tk5MqMFVaSPJc8wte07c7thByWaypcy6z2k308NKnKTOHxoORRzUYtMAKA8jaYN1
         pir9Y1SeBzUHHcf9ZcINGas6sUE51AzMyiGfKbEPnxcFMXlnI5yDLKIasvr6Y9DU2omj
         bWAw==
X-Forwarded-Encrypted: i=1; AL+hErFtLunjUOq5MSQkf14Cvvr93AsAaJ0I9n49XfyZt1n5oYSBQPCPbbuP2c2XN5m7+n6tLLw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dlcDje3zYEmPaZY8wjzvqzG8grPt0PNFydT+I31Cf65mrGLVA
	NmCK+ecOwAMdOiH56CNCQEAT0esL7Jz39s+hqyetm/Tz8uzRNn9XHdqhvZk2YVsSTIdnl9NQ55H
	DQUk4ToQFHlkY/FxFOeqtCIV4HSVJ/Z4Gz/XqtGHd2g==
X-Gm-Gg: AYBFou0pWBg3EyFOtgoEehRBoaTFc89t5KRWVUMSehoFdOTbeh5y6wAn59Lfi6s7+D8
	H2HdLsbRkCNCWppgLjgG0UsW3ubBXJ7a5Sc/R/f9ZRo6i9uA92mCXQufSaDpHhW+B12tNYwN98+
	VQF5j+OKc2sFlKd+Sh9IUh+oOWDLETGkqRh35PLCMhIpA+f6WjPmyfD1B9ZDzTJPKVZ0bOYAd+J
	+fnfe/T5QH1ser0EJDnQaT502KYe9/7bUpu4o1M/SON1nAdXJBRM3cbxDCRHgmKmb6tTf6Ybqoe
	2vVN60djwxX6QBbkaX+oj7Dc5EC622G9lNDoS7wIjjvZwlRIZY7tLc/fqewIA82Gt+DBQeLTDpc
	SjPepl+ffufQafe2jCMbHzRkr/clrw1Zi8vqGuyOkEKGm/BegFoayE/C2hWXEtF/sea+p+CavI5
	QTqoc88jT044vM5jcpNnP4zJ+2MSYXEnE=
X-Received: by 2002:a05:6820:3411:20b0:71a:f794:49af with SMTP id
 006d021491bc7-71af7944afamr223598eaf.56.1794785805311; Sun, 15 Nov 2026
 15:36:45 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com> <20261115113902.4834dda6@kernel.org>
In-Reply-To: <20261115113902.4834dda6@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Sun, 15 Nov 2026 23:36:34 +0000
X-Gm-Features: AclHuK-Ta2Fkr4hOVhZX_y8Xr7mXxa9_sbD5R_U1pL1RP64y3ME0zGRwgXOH1aQ
Message-ID: <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	llvm@lists.linux.dev, kernel-team@cloudflare.com, 
	Tianyi Gao <tianyi.gao@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Nov 2026 11:39:02 -0800 Jakub Kicinski wrote:
> On Wed, 11 Nov 2026 01:07:46 +0000 Tianyi Gao wrote:
> > - On veth, an XDP program removes software GSO from the peer, limits
> >   its MTU, and can copy skbs from the peer.
>
> Could you remind us why you XDP_REDIRECT xdp_frames to the veth
> if you end up allocating the skb on the veth, anyway?
>
> I thought that was to let veth run its own prog before skb is allocated
> but you're saying that you want to avoid veth having a prog, so clearly
> it's not that.

Thank you for your comment!

XDP_REDIRECT into a veth without a program on it has been supported
since commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog
before xmit of XDP frame"). There is demand for it [1].

With or without a program on the veth, and on cpumap, this series
keeps the RX metadata from the NIC until the skb is built.

[1] https://lore.kernel.org/all/20210416175929.35c3c389@carbon/

Thanks,
Tianyi
