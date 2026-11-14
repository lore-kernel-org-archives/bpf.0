Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794657899;
	b=ZjbeLpuQB3GZ8oudrzoy7FDKfwyiXwE14N0i9Z9bNo4sR7didBWQCpcm+OsUNPefVsip
	 EcjRfKcauA72YSsn36qjYCgybcLHp3hOkgq0hXfEsCdFuUhVqfNCuzugAHiz2EqshAUfP
	 6CyexijhvhOqsctW8HCjI7HhvOf5fPTSw6eNM8OmL0qCsNrzrXzn9LJfJRRZr9FC5mV0Z
	 tWyUglSx6jkT2gDFBzMZV2oycPVhqzHfIh/ZE7UMaYsTT+jlS3UrGx1u8IoiPdzzwKmrC
	 z2vBA4mhHUABSARmsV64+8ylSulTtNduNMVDqNamftkgr9Aix6ZPOMOSjtrTqf5IlsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gKJ+mTdGFKhhnohs/NLJjgkzp0d0JdJ5SvOCcapXCp4=;
	b=AQgFvTjNZIb/bMUzpi0w34T0GONSP9UfZD4fQmePkSBLezyZk95xTK0e9JKdowqGck2u
	 GGVGD3eLDaOxwA3TDBsGG6i3wTKiBAKQXAry6Ycp6BgNePGngUlhKbKtQOzuV9q8YhzZs
	 tZ/8UDEQ7Cf7S/ZkAf4kreKIe9JV2buWXG3fKlGj2MB/Ay6lEncMSWB1+ritfk3XBnByP
	 4+mUpV6qRorpN7v4hwTT5ViNyw+g0sPVhhDWmdWCH1CSOQbw8/nmLChKs2k+4UDT1C10c
	 hgwNGxP7lJ/ETUsHvB+ebqVgo8PzzF7U77mrwzrRHcamXK7NuWe1BjrjwYeZhs+NTtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=t8fY95lo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D648606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D648606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=t8fY95lo
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so958504b3a.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 04:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794657898; cv=none;
        d=google.com; s=arc-20260327;
        b=VcS774ZbHNWDz2BH6I41myGzoMSI9Mj2an6y4gzL/JVbFfJSSTac211nrY6/Uzc+3Y
         OwvUSsBpwacelfhqjJ7gcpO6GTJw33ZZqi7ZuFZPjQLvDoUxrHtHxF8a+CNihmN+/+tp
         hiBS+li4ewhK2TscoMJsU7mWv/iyod6mbcYFdtPmoFeomV+NerPeu3oLeCp4q7V5pv1p
         bQ6buMBVyXgJ6rbNuDPty0kcR9TbhXKvaYHZh+13PTSsVjB8zid8rluB13p8DPngNzGk
         UzhMJVsqQnii7jP4z5Se0eWrUulwuQXZUzaSSQ55fEZu1RfAEFrcBqhIRC+IEOSKc5No
         mb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gKJ+mTdGFKhhnohs/NLJjgkzp0d0JdJ5SvOCcapXCp4=;
        fh=tA7uA9u+V9KMXEcuQAbuNaKUdU2SlGCEIBEKkrjo7T8=;
        b=MQaeMmMR3Aw1G2ixs79eLzxoXQgdbaAdOaASrLVvmkYzaB6BC87appM7TWE8aMfmTk
         45cVe5VhnnEGL1tgZCIf3lBA5MsX9yrWO/aOuXkAisgWALBndCOva51/rTmk+mjn5BR9
         o4B5Q4BIS7CGUUA6cINFBz1U8L0znCkSj3yW6fn2RDHR3D0ZE1YXPl843HVxdA7Nhbxr
         jIYMiROcAQiDSJy23H4uPnNVUUmSasRHNTMhPW/cysRKXQhELOVokuKOY864SrYiZCVX
         zgCz+3OsdlzoXyD7j45w8D5Kg+3eoO7pAJY+HLa1neF+hB9vxSor9Q979wAMbxgrjiSm
         GcQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794657898; x=1795262698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKJ+mTdGFKhhnohs/NLJjgkzp0d0JdJ5SvOCcapXCp4=;
        b=t8fY95louL73YALHqWLdAldiJ/r4amI16c1eqOrXx3jcxfMoZqAtjWM75h5sjD1Mpp
         lMgAUBaz5oH5XGG95vbTUw6EcYJB1G6zGGuvqnJ2snSxN7Pvp385ga6Xft+w3+RcOsPK
         KyVCico6t7O6BtTDrKWFmk1JK1g553StTKLZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657898; x=1795262698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKJ+mTdGFKhhnohs/NLJjgkzp0d0JdJ5SvOCcapXCp4=;
        b=W/Fzci1arYLVjo6uS0UkAaW3A1fJD9ruQglQiIwbNEmAC4AwkE/xzouHpPDzLh0ZNO
         S7XbkjjkPoTUTX84P7b5/TXyRYMBUcvmzEQSZ6dLDEzqwljDTOGJtW08/HLTTfbAz31O
         BbXjjaQ/riFJZfyxsSLG/BadxSo79ULDScELRwx4xhKgcpV2uT7/uMMu6YnOaQFDp59A
         Y96HbgATY9qY0x2bgyG2MSczh+d6W/VPu8E/oQVQvkNmnTeeVzGr0kYml9xvzlq2gABr
         EgwyHWqI5+vDJrrrw0I3BNFkw2UiFUem/HYbXYkxxe9auqi1xtjf4G8fWgjOUWb4Z8Hr
         p+/A==
X-Forwarded-Encrypted: i=1; AL+hErG4Xav8U9uHWlnKu1wtLPPoJKPrBA4Xv/goUXd8mDrhqj8TVB1YAjT70I3tSqib2LgtrR0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FarY+YfKfGN1qtXOvwYKfCes8GJZ5XNJ0dYdFeUpixfSZyadT
	CWEk/KopbNtKUkA2prOpONGPpXXIu3TOP++A1x4vaWJjQeQN57t4Q8hATDTl7XzNvGZkSBe+Ycn
	0947GHVszcbsDB2hJeXU5JnFcQolVVo3y9xisUVfv
X-Gm-Gg: AYBFou1EkFSrxGLa62hxn3N6sYYuGgBvKzLVSxjd+FOkDTqRAMIEuA2aQXxrdTtRuzc
	T3Zh+IoUf4hNAM6rFX6A3ZJwERGwh2nS2Z6q6yZt4wVBDswzyqHs1i7tAXVK8GB/FznR5sKQ4np
	+3VEWYw/aCSKitWuLnEL+I+QLbvls76JLzulvEEc96m02HRcmetO+TjwcbmVDVpjBODw29EWvCc
	afyO+bYrrFZw+jiikEdh+T75GDS8/x9A6Yrif1CuEIaalrBMNOqT+m4crrTJwTsaRg47sPL4x/I
	Ek3eow4JS0YeiDWYC/GGZRtvUZZA1v5CBl7IIW03lWWd6VKBfhmPLFbCJ2Fs3SAZZgXZgXSseWj
	uphz1BbwA2Np9ayrwQIPCMXO3koiaBxMCT19hSPV6mvdu2LjMDlxjpCF+tf166FwJ7YMUh3nL9x
	65RG4itSKoJWIrSO8=
X-Received: by 2002:a05:6a00:188e:b0:8b0:4e79:b3b7 with SMTP id
 d2e1a72fcca58-8beb63a2bd2mr4941673b3a.31.1794657897786; Sat, 14 Nov 2026
 04:04:57 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113185553.171059-1-toddfreed@meta.com> <20261113185553.171059-2-toddfreed@meta.com>
In-Reply-To: <20261113185553.171059-2-toddfreed@meta.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 14 Nov 2026 07:04:46 -0500
X-Gm-Features: AclHuK-HzRxyaz50x2QBJn-n5uNP2J1O-ML4FbLSRGjiewNn8xPID_Ky1F0Sj0M
Message-ID: <CAM0EoMnJEGweo2oxJsgAjuwLDHrMAEEwuisFX-CDSbj+TvK3PQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: act_mirred: don't send decrypted skbs
 from egress to ingress
To: Todd Freed <toddfreed@meta.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Wei Wang <weiwan@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Sabrina Dubroca <sd@queasysnail.net>, Boris Pismenny <borisp@nvidia.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 1:56=E2=80=AFPM Todd Freed <toddfreed@meta.com> wro=
te:
>
> On transmit, skb->decrypted means that the device must encrypt the
> packet, e.g. a packet of a kTLS or PSP device offload socket.
>
> On receive, skb->decrypted means that the device decrypted the packet,
> and kTLS device offload trusts it as such (tls_device_decrypted()).
>
> A packet which mirred redirects or mirrors from egress to ingress keeps
> the bit. On ingress, it then claims to have been decrypted by the device,
> although it was never encrypted, and its payload, which was to be
> encrypted before leaving the host, could then be forwarded in cleartext.
>
> Clearing skb->decrypted would not work, because that is what indicates
> intent to encrypt the packet.
>
> Don't send decrypted skbs from egress to ingress: a redirected one is
> dropped, a mirrored one isn't copied.
>
> Fixes: 414776621d10 ("net/tls: prevent skb_orphan() from leaking TLS plai=
n text with offload")
> Signed-off-by: Todd Freed <toddfreed@meta.com>

Missing Cc: stable other than that:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

unrelated - are you sure patch 3 belongs in net? Feels more like net-next.
psp_reply_set_decrypted() only sets the bit when the association has a
Tx key (which you are testing here).

cheers,
jamal

PS:- on your question regarding sashiko-nipa reviews: They show up on
the mailing list - but sometimes its unreliable so an alternative is
to visit the website: https://netdev-ai.bots.linux.dev/sashiko
> ---
>  net/sched/act_mirred.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 1c98e4d81ebe..52c3eeab381a 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -285,6 +285,12 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, st=
ruct tcf_mirred *m,
>                 goto err_cant_do;
>         }
>
> +       /* On transmit, decrypted asks the device to encrypt the packet. =
Sent
> +        * to ingress, the packet would read as decrypted by the device.
> +        */
> +       if (unlikely(want_ingress && !at_ingress && skb_is_decrypted(skb)=
))
> +               goto err_cant_do;
> +
>         /* we could easily avoid the clone only if called by ingress and =
clsact;
>          * since we can't easily detect the clsact caller, skip clone onl=
y for
>          * ingress - that covers the TC S/W datapath.
> --
> 2.53.1-Meta
>
