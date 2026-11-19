Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126486;
	b=X+wV13Rp51wlWynIA8BuFv/FdfHvpvXbgaYWND+tfYZfhZlyftzRz0iukRAJU7Qvx7dS
	 NUGZlS633DeP/qaB8yDEGfJ8rnoSgtTcbc5lWKtSmbdSRAsqHyAHWTIh4RjHf7gOvfjHm
	 j3n1KNE9GVGYdRSya3Kpq0mdneaqGkYDcl+c2aGja9cpuANp+LimQYETA9sEIil2uXYHH
	 eGboAvuns8llf8ISdWv/3fTNO9YESVWmQgVInT+twfTL3DR0Sxx28tQajbTKClkKYUBVq
	 7hZ8QzveJO4e1OLGrzIfMjYVS+dJOwJVyP/SXwzrtTKFfmxQ/KBVzOmUIzh60VOjfSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5quLvdk775X0CDOngoeqmA0qWzTp4nCO/5ykmUMU3f0=;
	b=2wmlQDGD6LrBN+m2sIkwskiRa5a9AATSAz71QfUb+uRGd5WiGv5r1wkSsSlRFg8Foq4H
	 B3Bnm8cAZPRzVasElz6BZyr4oBeTr1M/Vsw6JgXKpuHJjZ3GWJFFdwLpKmoEbX28o8GIf
	 juUN5ivKMKP3ftvvpk0FdPKEP2pcB6oh52jyv1OfGlS9NBxBjrBKFtbW/EGc9takoYDo+
	 aiLhwQPUJWD2NEPhgw3Hc2jyiThDXeC9rBGNuyolMjRg/iLKa08CXDgzewTK7DM8uNsTE
	 V+jvq2Kf2p3E4pZpwv1ptvapC2MX2h3jPu6VESjqAvzf4OrUoPZvzFuyBuZforWFBKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Njzv5Dw3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D7606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 22:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846D7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Njzv5Dw3
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2efc4a84e75so6485ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:14:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795126486; cv=none;
        d=google.com; s=arc-20260327;
        b=E9C/VZ4R0iF9tEjstafc8w8MVCgPyOm54vBTJsNs97qe6Rh9Y6HSp6iGVvvxvEWKA2
         HxgTFYR8MausbhLEteAFKQtPif6MYEsdDaSKlfok+rU+pVSCbC0j/AL8mElVA5W/QENU
         A38Oorvlo6vpbj8ef+lZ4EK+PyVHmBQnJWM6uV18OYnxR1cLUh1t/yVxAMoFVrR0TBJr
         fnU1Obyc7yorGLFLlikZks9cFslJTvQC68EZp+6RVkjqmsQAbwefAPBbiMiMgoe23kZt
         3euYn4yVw1rHL7xmVcE3Zov7q8eGMuCMYxWUt2VXCKD/vpS42nuAWNyT0f3xgH3fqeoM
         h6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5quLvdk775X0CDOngoeqmA0qWzTp4nCO/5ykmUMU3f0=;
        fh=bGAubIIxPs61R135Fo7JqeOWEbEJJ2QUaf1oF++7vXM=;
        b=EZ0geuyy505PTCMPfDW0epQNCd3QO5ErUJRSXEAS63nEbEBXvq2mKWvxsvwqTCyjh/
         dz9lpwxr0GMqEeTxKUUI0J6MyOSxkPWrw8vAgAPDU/juAsUMMHPMBRy88l6iCFWHj+kV
         rCmoqkihobIgTkvl169osLJFfN79/YdeGvUrL4AP7OuEyUbvtlzNkAefkHIFlucyDYOm
         jgiqQl/iBexUd/B5s8H7jU82JxQ8AePRWwi9HYCB54FM6PkpBMZyrJ4F8um8zvpnDoYs
         7EzhmhzADwAhnsJdMgF3+ZO1KG2vgd0o/+7Lj9F5U2XgDeNQiihTSsWAdzfCZ5K3oxgP
         S9Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795126486; x=1795731286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5quLvdk775X0CDOngoeqmA0qWzTp4nCO/5ykmUMU3f0=;
        b=Njzv5Dw3Z+mntNouomiyw2TjPleQN7sR9egv9Pehd8U4JRFFoC/ouYv0Lm5+iUxsZ+
         kQSdLLNtxVZNorr4fFx7zhU+lTf8k+w5pYeJj7kgUHefPDi4qRP2XbUf/a/t8usPWfQL
         gk3jI3ml+ZliZLG7/wEz4RR2yvQuBceOmKoy1GDEjcoY6bD0XW2fIOJGSr3zWVT6E6h2
         CI4kP6sGSdIZQcf+lm09BgilzDcwOABetqwaGzudqCOeYH7/a/fLzgsoU/SyRelCtkdt
         7xZJcdtLTRxJSbuux+IDStuurIeNmQNAnPePUhxJ5tMtsf37MKi2MnV62GhU37GgZu+2
         BU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126486; x=1795731286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5quLvdk775X0CDOngoeqmA0qWzTp4nCO/5ykmUMU3f0=;
        b=JX4uiseSuNyctaEMhchuLNsQITwc2h9boiA968QgQ8Y3ZvTMm0aj1O7lE/ZedUnxUR
         3MEr0i6ZN7wUWfkoSJkhyZmSdI47QyurUlh9Qi4DBgeGeNlhJ2MGZS/apPWCCPDvjQiX
         bwTzSeSpSc9dEr8Fwp66MIaYLNM8kAhbwAXNWwETdBs8FRsvY/7gtvlJ7z3od0V0w0kM
         uWJju4pJOasLjIq9GgRN7dY8sQfRqC9NVN9gSguRboN3z9XmbLoqVmzGXi1DtX/gg//W
         /nhY3T6l/JXUNp1mfEqrnwWS2ee4MRUFihGx329y+ss4gwBSw690tyd/z+jMky+5AJSO
         uw5g==
X-Forwarded-Encrypted: i=1; AL+hErGSttdEfIc/j8QeH+FWCYZQyxl+LVah3KUNCoDMCu9ywsDHk7bJnMqx0tVDueWz8DdK568=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7SuZnPhG5p6YziRU3/d0IAZyzHJj9LssAHEN7Tew/0sh5KHCr
	T/DrCg26DoIBBjy/urVNA14PB3+4Oez2dxecnHGs7Q0oK30DeK93jTCjEw/gyORtm94XjJnIEc7
	r/wY9UB7cwTAwSdvRGVL45IDFyl4CyCfhGftuG/AY
X-Gm-Gg: AZFdTZcdj6vp7q6ZqpJdj5ZY111VdQHLEkdqv9ZcBYu3FGNTtBJnT0eyKP4KWVOLcco
	WXrOi74E/k8YB0zrLe4Jc4NWZZmw9R3hsTjIUK/kqKIy6nJ2Fgp5P9NNcJYrwcnyCu/r4u9cl96
	285SataJOP5RskWBViTRq54pjxS+/BDh8H6Hv1v7wjwXDZHNWNnijaKdH0MqRx8qYNnSBZBMnGt
	wxu+O5RG2XIWCyxfsbKDvgdgSyIhcCQrpU2INtVBkyrSQ/ZN2PZT80uxVLouLfezrT4Kn8bfkLn
	Bj9cGQgWlZ5VInJUd/4vnoLa/Ki04WYNE7pKaxKLRnzw/Ddf14ui9XcXoDkICpsTJIOqttN6+4S
	gd9tcQuv9Z0jhzpr29nButXs7JgsCMKDzmxlfOV2e7YMomZeJpWcIkRIRlBgOm86dZquiPsntr6
	B5Qfah9kzs4DvvWDvZ/GwyeQyxMMTIXGg05jMHhdfFQKPwIYMWHLfpmU63MA==
X-Received: by 2002:a17:902:f708:b0:2e6:d25:d874 with SMTP id
 d9443c01a7336-2f0439d84a8mr679585ad.10.1795126485206; Thu, 19 Nov 2026
 14:14:45 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118232315.3593731-1-kuba@kernel.org> <20261118232315.3593731-9-kuba@kernel.org>
In-Reply-To: <20261118232315.3593731-9-kuba@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 19 Nov 2026 14:14:33 -0800
X-Gm-Features: AclHuK9pJKt4rtset9qfU1mxMlcT4dQR2Nkvj5gYRiUEQFrzr0nja1ocDKAzpzU
Message-ID: <CAEAWyHdaAdvLHU5ivRSHmfoh9Lm+eNnwOYrLmkyv4ogFnqVdtQ@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] eth: gve: drop the now-dead HW-GRO vs XDP interlock
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com, 
	tariqt@nvidia.com, saeedm@nvidia.com, daniel@iogearbox.net, hawk@kernel.org, 
	sdf@fomichev.me, willemb@google.com, przemyslaw.kitszel@intel.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 3:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The core clears NETIF_F_GRO_HW before ndo_bpf runs and refuses to turn
> it back on while a program is attached, so neither of these can fire
> any more. That holds for a program an upper device pushes down as well,
> which is why this comes last - gve_verify_xdp_configuration() was the
> only thing standing between a bonded gve port and XDP running with RSC
> still on.
>
> The user visible behavior changes as intended: attaching XDP to a gve
> device with HW-GRO on used to fail with -EOPNOTSUPP and now succeeds
> with HW-GRO turned off, which is what bnxt and qede have always done.
> The header-data split refusal right below keys off
> priv->header_split_enabled and stays.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

Thanks!

> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 0ee69bc11d83..8b65b8119662 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1798,12 +1798,6 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>         struct gve_priv *priv =3D netdev_priv(dev);
>         u16 max_xdp_mtu;
>
> -       if (dev->features & NETIF_F_GRO_HW) {
> -               NL_SET_ERR_MSG_MOD(extack,
> -                                  "XDP is not supported when HW-GRO is o=
n.");
> -               return -EOPNOTSUPP;
> -       }
> -
>         if (priv->header_split_enabled) {
>                 NL_SET_ERR_MSG_MOD(extack,
>                                    "XDP is not supported when header-data=
 split is enabled.");
> @@ -2212,12 +2206,6 @@ static int gve_set_features(struct net_device *net=
dev,
>         if ((netdev->features & NETIF_F_GRO_HW) !=3D
>             (features & NETIF_F_GRO_HW)) {
>                 netdev->features ^=3D NETIF_F_GRO_HW;
> -               if (priv->xdp_prog && (netdev->features & NETIF_F_GRO_HW)=
) {
> -                       netdev_warn(netdev,
> -                                   "HW-GRO is not supported when XDP is =
on.");
> -                       err =3D -EOPNOTSUPP;
> -                       goto revert_features;
> -               }
>                 if (netif_running(netdev)) {
>                         err =3D gve_adjust_config(priv, &tx_alloc_cfg, &r=
x_alloc_cfg);
>                         if (err)
> --
> 2.56.1
>
