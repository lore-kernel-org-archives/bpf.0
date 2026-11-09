Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253567;
	b=i4IHXw1t7NOYG56i0DyJAse/JGARsVEldSNBFpgXlieseUbRhTtKSL13g5G1eX5MYvXx
	 dg2gecMRPjq0KRKApC1CoEVDhqrhlQdDhGInh17iGEO1S2dSEZTAPiKMfvzmp/d1OXToA
	 1AH4aSgfqVIMG748YNacNvowe7G3LIasH1nJNrxbUsz1XWfm20d1XrahuDbMaUzkPowdL
	 IBuB3D6ZRVxBegNxq5+D0JBzUq9Nfk/TLxQEojn+QBb6J4qUGpgSyr4mS8zNm6fJqXIf9
	 Zt7s/LzOxbtEWmTlW7Op+BxTnEErK1zCPJMWdrVKK76lYNGkI3nCpGRnc2qJrs0erGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
	b=hsPH5m0AlD2Jhi2/cGp4QFE+VgkAE6uai/Lav2jUCDG0HI52DhKVDykGvAIobd6Bjiqe
	 14RPHloZZHDl89bsBE4I8PNE8qq/+6AM04JX7Xu1vETIEILslJMNKWiGfxUQpeUwH7424
	 t6hZxuIJZiVJs9ZPKxLLXYACjcDSOuofnXP4SyT0BU8M0TKFwSt4sQe501JNFbWywpZX0
	 YuDMROi3G3Y1pogjlrrWP5Vnl9y4mMJ1M5cOqxthOs5eOVZr5VhlMbQuf+PIUxXeYqmkN
	 U8u98pBaxYf1nxgOko85YA6AFs90JSXNeknfzNnnKZb5eAEox6O03ZZmw+ZgUfnXYeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CFs9I3JG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BC606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 188BC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CFs9I3JG
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c45551fa84eso178110166b.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:46:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794253565; cv=none;
        d=google.com; s=arc-20260327;
        b=V73Wv5kdH19btHaEvb9L8U+X+AH3jAYO62usOhjy+1BAoAjTV/FHDKbNMDMs1YPs17
         wuHhpnYduplJahs4Y4NHvftmLZhdfqimLcD47CdzU3xsHUab2sFwlDGldIfNSTOhWkob
         ljLb403EB4d/Rdp9rjkyx2KZxEqsN66T5hF+StGhym6fXmY7U9G5zBoXsjrDyEIXvZuA
         /enwK9oVobBQQ6Yi8FbZDuIl2ICC9mKaN92pA6mBjtrO5y33X8NSwb5amK8o8+ealD5Z
         XIrAbKo43T7CIDvpkST+Bm/YhTj5ERe6WrSVXBi++2unaOD4AxkHCIBhiZoJNdE9A4Be
         mnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        fh=8kcUVivvaRGoGTYul9EV59QEjF4PrH15V8Bt/VC0ih0=;
        b=N83awv3+eZc+tWzeijNxb9J9HZqqr0wVBlt91+MlwzKjFARC9rG73H9jZJ5jWY3mWI
         bLl9qBLqXkpmh8cL4HeT4rquSdM0naBFaq/uWMRx2uxDzsYNlm0366robtRkoEtWRA/G
         a+DsVSVF4DJ7sr7Y6OJiiWLNCX4D0E2PwZBDs8EmYYyT73dMCieA0Oq0z+BWPn4P3HH+
         iPuRN+32e2UG7b5CBOvcUD847mhPGN11waeJ/isXsQ9MObUJ+aeJMCugmp/Wh3XXtBaY
         ESCfGbp1Eb9NCjyobENajuLr+Uas2876bd+bcG1GIEaLmNY9EcYfMyYRdbrWEfIoEWPq
         AfYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794253565; x=1794858365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        b=CFs9I3JG7+t7GGIVBu2Gb3gYCZIqnIG9eIDR2W7bngmQAFRocBnKTBOHbb1QZFtH3H
         KnaZMjrJCVtJgjAiGJtT5CxuRQ3n5NATFrwD4AZnQOrAlE0dGilWEWtA99YE5o1I5I+Q
         7NNp7qnK2lsNWaZzoeq7JlZ30te310/Gs5TAO2pBIQDHvGHdOX0a4krsIUuEE3UZGwrw
         5+mlYcO2grgYce/D+KUa4SKhSg4kZ9/sZBtWpFIbRNJDbYbQQNCkfTtYh4enmI/Y3GoL
         QugDVwQmP+lnNOQmCqn1sDTbTB8fS+qSgJHaNXBWN/rDIwWz7tohO8+2797TmGjvEHHK
         fNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253565; x=1794858365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOArzfF7wNe46tx1BE66G31FeLK1fkOr8F1BKZ5Pz78=;
        b=GJwy0u62pJaC7BzEg/EtY6wWDR7kIpMzX1syKVQTrtyKI3bssubn8lQ+xk7HdTs10L
         dsE6fatWoOEGejqUImDUB2InmYU08z+veXILsTTri12v+e+59zEThOuBqjc98F8oUXnc
         amfOoHNgoSZpypiNGHqOeJa6fTHj++KVPhXHZhBQWi7V95TofQ8p5dpjejBxKZiNPBe9
         XTT2vEMcIY3lNCkDW/aZHHOpdgIijx+AP/hhapQ7mihK7rgdMCWCctDPviYadafto5Qj
         rC4nfsHrlClZrUVtgvJ4NXSE/2YHL2JvzaF+1gJWFXSzpoIKzVSCJVmbJskfb5s6ub9K
         hmPA==
X-Forwarded-Encrypted: i=1; AL+hErExofv0yzbBj1KwVp20r5ptIp7fyjF/DRuEVRy4NHkK4ABubjeS0LzVPqzFcZZ93GNSfeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z81dRmX0ceAkUQkytGYrmZIGLVi2j8Vg3aNA3URtVV2ahNxbURn
	8nP1hptFAaqN/tntxN6WP/hrjB01ZkrR+bUGO10UCB+8I1z+HOsuDpFxbuHOJ5BWt8hfvrruC6l
	1S83mhWlZzZ31054ikNii9CL7Yu4pYhUBgwRn/bPW
X-Gm-Gg: AYBFou2hltfdFrmQ+ctvH+wSdTcTWQw7NIAXYZycYyfcRrWxOyeJzGVwLFceQaXSvke
	B1l6af7qeezwQZ6S/C34Ag5/iSUpqI8X14oBBkS6LaestPgDQ9SzSJT+pXNuL7P3NFijyPkBU6z
	hPlOvhtWm7mxL0uIoEZNQDlgMXlRCPAOFD051X5j5jtEXtr6dRZAzaR5nCnutPbbj2VhCRFlSsN
	Sxv0WJsuhputXF6+bnIm+3NHqjXzdwUoKn/4t9yX9gIVLE98IDKw8bqg57DY/yOrCMxNLc6qJca
	oMlfNY8odYWUcTyMONXoJuvtaKDhzm8HhAJTAr8qK4STy+I46RWnHTJxb3uaPgu8SWnCgNL3qGy
	oI5I83JAVpXH1vdCiPnYR0VpvRO1BHU3dlvvrKPNTVuvlR1lYCvA87ZGLnfTzDbS6xF8=
X-Received: by 2002:a17:907:3e20:b0:c41:64c1:cc2d with SMTP id
 a640c23a62f3a-c50491bd62emr32238066b.2.1794253565000; Mon, 09 Nov 2026
 11:46:05 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109100437.331423-1-amaan.cheval@gmail.com> <20261109100437.331423-2-amaan.cheval@gmail.com>
In-Reply-To: <20261109100437.331423-2-amaan.cheval@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 9 Nov 2026 11:45:53 -0800
X-Gm-Features: AclHuK-f_6xX0FRybZe2n9V_Z8dkntQqvMXacQrG_VwUeSpjRAkA9EO6aNAi2BM
Message-ID: <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
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

On Mon, Nov 9, 2026 at 2:05=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.com=
> wrote:
>
> Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> verify_xdp_configuration(), which until then refused every format but
> GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
> no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
> only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
> socket on top of it, can still be attached on a queue format the driver
> does not support.
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
> Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
> advertises no XDP features for the current queue format, which today
> means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
> for the same reason, and a copy-mode bind never reaches the driver and
> is harmless without a program.
>
> Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
Reviewed-by: Joshua Washington <joshwash@google.com>

> ---
> v5:
>  - Check dev->xdp_features instead of queue_format, and reword the
>    subject and message around that (Joshua).
> v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval@g=
mail.com/
>
>  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 2437cd8ba633..fe560f5c5408 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>         struct gve_priv *priv =3D netdev_priv(dev);
>         u16 max_xdp_mtu;
>
> +       if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "XDP is not supported on this queue fo=
rmat.");
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

Thanks!
