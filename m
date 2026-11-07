Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794021236;
	b=imw/GJlXJnK+minkB1CAIKxbTil+6pGR8ySd8ZAA8Q6YI8nEheuZhXBHLfa1pHtEWcJd
	 SoHoUzGlDV00UmJcmfDHUavDPkpTDwmU/Mgk2I9ilY/H+PlFJfFWV7J1ACGevcsGVQ4IA
	 DfcO3dx/IJKeMbGi035tA9EdPuYm6cISDxt3JMic4Y2TcKM37c/YtIhqvxza0wpHj7Aao
	 Bdq0UURy3bLjdz512fTQV+AB4PUgaERVuwbOelrMo+TOLUwSLxlQWPrcbCQcfoAU2sDz+
	 I1f4cNRrXg3OCMJsd9e6yMlWMN7IWEZvKFNyByi13b0K9PDML6ekLaURJ3P0vOvfZMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
	b=qDZOtzNDUcn6SVSAGhLJrtWsJ5faO0mBfelQAoeeqOzt8A8V51DgtC9hSmID7tzLPC5t
	 aSq7Zdu8OMOISnicfXg82iaWRxL1TSSlWqJPn/zjPNPHiuXPqqL5QztuBVPVVYLd4Z9bq
	 GI+wZISf18G/Aq11U4Pnxa7zig4zPN8O/RRAw6CTZIHVNJzjhD/YA98Oyp1K/KKwdxW4N
	 XS78gm3XUIU1532k3grBHlVwXNCdZPTbnj1tHAzox8utfiSFoqVo8H8svF3UdoIiAqyeA
	 wbKljORyzqBFs7YN6OivbV4Jw3Tt+IQgVZ9rlkh4aYWhG750MTfO70qHfU6NVcjmKZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="K5/xSYU2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FC606A32E
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A5FC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K5/xSYU2
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c169ae1cb26so45003266b.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:13:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794021234; cv=none;
        d=google.com; s=arc-20260327;
        b=Ry0uJjsIewfQu+IVKmevtdqmwOZW/wjYyviNEDhykHgvQsVZFBhS7++CZiee2sWFqU
         zkcx1DdOHQ9mgglVOzAL3Gq0jsytaqlBFtXbfoFF+4H53w90FghHLDSKuTfqfeIhn0xM
         5FLAadxDzFOu87ZH17JpI1vRTTnFAimK2pnv5UYpqXyTB5wZeo8ArcRC7xRNG2+wmo9i
         0CAx+XeNtn+Ct03CwkWPEJijm6b7Olnclbwrd+6K8QOP9Q04QmkLcDz2txcIJvdP/+OI
         722ZJSYRx2nu/wSq7dsZUzkpe0am0J1PT8oen+Kk+/ZwzBew3/YOZXgcCxvnbPb7yRcf
         ahCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        fh=hWCrXtAC6V9xhBhx0d1fYfDqWqqwLpLzQYRFKMwBM/A=;
        b=Y9+auHNEb4CSZM3iETuakznlXywT0h9ndOm8X2W4AOOAwBUAbdstE7t0F9GO4Ul+XO
         q5GuY//LVg/XRaGLkYd4XqvYN6xlGoyveqqgc21O6YPA8TQvVa1PryUvYrDKe9YHtBS+
         wzxP3ho5y15/zPRbuppn9aX9PBBDeCtQHTj7us9fs9/OOoxCrJqWoPCvVifhVzPITcxH
         6GOntMBN+NQdmtA4ox782pVHNBMuojwojD0N0DfLgUgBdl+IwoMMAVelzk1IOekWa4il
         nIk/jyakZMmxme1lnmR2hKt6QHOIbWBPMJeORfyfAFUZ1Bz++gVJ21vdbxwxIb/Y230t
         25rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794021234; x=1794626034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        b=K5/xSYU2sTp+9F3Ssc9dMvDglneH6jUV7uspfeiii9TYyO072Qw+6C37+H2BuqkWhv
         4rseU2AYAVe4zjHmf0l6pCh7AK5v/CIYQC/ejfCs4DvYqK+kQOJqajhjMCEatzHYNUvQ
         gfRiiZd87mSWTSTX3Xc/Q/VNX+3fTAXEM54dMFBptzvI+h/iN+vLCb/DZOm7Sb5iV45p
         2r1wL6zEAzXVmcSmcQ3RIuZcM/htexTLwdbXmAfWmJ+b6mrIuA8sA3+ogMk7BMgA55G3
         +V3fAM9PBOvMP6b964JFduPMQPJVNzLOmEBClMyhd1REGDF4dW8Ov33ous0HAIWn63Uu
         TPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021234; x=1794626034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRpf6L6W1qrmOGUB2ywqgKb8dbORXdYECHA3ikhVQCU=;
        b=UpIjKtvgFmuKgfVMAg9IFRY0e2dRE/vyD1QA534IRoUCRvQ3e/R5DC7+Mh66L7YtUi
         PhP8H1D7F770/Sb7FjHu0H1B/Mi0e9MMn7GlAGdiR+VgOP7FLEDA6x1TcIuB5Wlq+TyU
         aGTTnReOm89H87sdqSvsLKspZfQQ3CnkmpdkMPwoW1FHJ4893s+0+vHx1cnal/DU2OCY
         k0iLzSMnbhYicG8xljnUxweI33Upjf8yrnOuNvRMN4YEfh6LpPuLR33nLXjSdyLC53B9
         FDFThrTroeBl0Z+xyPBNqaXrq5voJ84w7zRJvIqDcga3BCUli6RiNBlcmOZTowddgF2D
         UAzQ==
X-Forwarded-Encrypted: i=1; AL+hErFSZ8ZQXXihYmh6af0eBzpS7P1QGsTdpB+08QNT0n9AKTFdc3YYRzK3SvkmrM1uLUgoNZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Xr9AX08plfcCKD6/2DqIsvcRURQmcaCky2kf/iNS9GGjn+8EC
	WHl7s/Iey3FsG0XoZjGZ6xFGezpPczMSniOLSFaYdfzryuhA08QlXdCdtak4quIK44dbBrwmnUs
	jhwQycWDcoVgB7H909YQT6HujvexVbaovT9kHOUdY
X-Gm-Gg: AYBFou3w+W4fLfrOyaca94pufuw6QEpuj94XUlLxewFTOPjD8dPZ2cMNxRMNqUolNbH
	2zGAEywavLglszBhkN6jiXWNIenM3jx7YBCbb8hJxl733uLTjP4LLnaWQ6ZJl0i84FMOfPDH7lZ
	9e/vvAB0BzOJ/mxbM3J9VDn6oHyzNng4neDEpEKB/kcau3YrqiaLtVzoHwOfdsW9CeEyAKyQSI3
	cQLV9OSwYHEz/pkqH/r8CxWM6P/WSDctayWwiPYKMDSIPSHJuQUtiDeF+W1I7lUj4Slh4PmsfEo
	XVH9N9XveJIR/bIIsErjmvIjs1bFss0Qj0lagSMgwcaAW2lNDN6yLv8w9jsgpvP9Ru2oI6FNtqQ
	ROHPY0/tzWvLYO9UKaqrOe1G4E2DZhPYp2CvoXADbDP9kVocX4dHIV99emMA3/69OTPE=
X-Received: by 2002:a17:907:d22:b0:c3f:2:6faa with SMTP id a640c23a62f3a-c4d523bb4f1mr41862966b.1.1794021233358;
 Fri, 06 Nov 2026 19:13:53 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106114551.212675-1-amaan.cheval@gmail.com> <20261106114551.212675-2-amaan.cheval@gmail.com>
In-Reply-To: <20261106114551.212675-2-amaan.cheval@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 6 Nov 2026 19:13:41 -0800
X-Gm-Features: AclHuK9hqj7STkrMrTFdH3gqq3iNgCshZou6dOEEbH9VmQvXrAu4YpDfrgJPse8
Message-ID: <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
To: Amaan Cheval <amaan.cheval@gmail.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 3:46=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.com=
> wrote:
>
> Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> verify_xdp_configuration(), which until then refused every format but
> GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
> advertises no XDP features there and gve_xdp_xmit() rejects it, but the
> core only checks that ndo_bpf exists, so a native XDP program, and an
> AF_XDP socket on top of it, can still be attached on DQO-QPL.
>
> The DQO-QPL RX path was never written for that. Its page accounting
> assumes the driver keeps a reference of its own across every handoff:
> gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> recycles it with gve_reuse_buffer(), so a redirect target that releases
> the buffer synchronously, such as an AF_XDP socket in copy mode, can
> drop the page's last reference when pagecnt_bias runs out. The page is
> then freed while it is still DMA-mapped and registered in the QPL, and
> the driver posts it back to the device.
>
> Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
> matching the features the driver advertises. A zero-copy XSK pool bind
> is already refused by the core for the same reason, and a copy-mode
> bind never reaches the driver and is harmless without a program.
>
> Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 2437cd8ba633..4e9e692a0ed0 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>         struct gve_priv *priv =3D netdev_priv(dev);
>         u16 max_xdp_mtu;
>
> +       if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {

Thanks for implementing this!

Minor suggestion: Can we check based on dev->xdp_features
(NETDEV_XDP_ACT_BASIC) instead?

> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "XDP is not supported in DQO QPL queue=
 format.");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (dev->features & NETIF_F_GRO_HW) {
>                 NL_SET_ERR_MSG_MOD(extack,
>                                    "XDP is not supported when HW-GRO is o=
n.");
> --
> 2.47.3
>
