Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795045485;
	b=M6OOWVepIhkn4AfLsD3oPd9fpy7j4luCmZyr+jKwoyZI4+NAz/gHIjry0nSODoGZbcCG
	 yGdiO3Z1ELXv11q8zI3tI61Ef6vd/1WrWe7T5ZFJuU/SVkvjypD4kLKyITt6gwOhR5r3O
	 5GzhU6Wh02ejja4sL2WoXpbWPx8xh1UayVjXbCv8sx8CtAkQb8U5HVyNpnIQCN423LrJg
	 gJyDqVncgbAVt155AJFmMdl99g9ttTIPlMJy930heeVrdPuUwK0x9NQxLz8cWTpeTM6ka
	 e2WMDdGY3syWpXvijMcDAyjEiqnnBf5YK0Fp1Il++fcvVDpuKtf56iVOOSmOvJo+yKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SGp5rjwYDX23uopvAqENY3jXGmkT0rNpBZ6WTxZ+Jjs=;
	b=XipHbn3tm3Z8gM7g6OGEqQbB+o246ctUq/75iEDqPQjr0BY29/BU2Iy2vfahqD/FWjBc
	 rEfA7+AKgdIrfXE0rkZykvbiz9pyHD6Yqi6ENd0/b2olGJLg0OTHJdpVy7dyaOhbd++HK
	 YQ+aT37/xaiElg7EhY7d43dWmWeUysoPdXv16YmpGzx5K5V3p/g4bAOav37OdvZdplkZs
	 uCXilnsPjiQIOSK9zBkaYWkBsv4wvkgrHSIpA+peYAhRT0QoMBGNU1RmPYWXmhC/4eoSu
	 Yb5GwIThB0agRGTNWg53B/0No/OrjfuHJpkgQeblQGV12t8N8HoAQcdjISmmnqBEcJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JK0PcKYS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CDE606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 23:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52CDE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JK0PcKYS
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c5123794038so103539266b.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 15:44:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795045484; cv=none;
        d=google.com; s=arc-20260327;
        b=KxhR7a+5gqu4GV1HPzKs6u+3zbGJassyixGwLcibW8kV/3lzUJBbM1ctwZAZ+iW+JX
         4bM3Yk1QJ+z1Fwt3HLfFPYsET0gCWNNSw+MInj129WBRPc0KfUWv00NYLQyTXF8yNBCD
         aHkDsinSHgAWjkh8dUola1nG4ij2MKrlUGW2a2jgzrvLdvkdrlWgsxvhdZpqdS91W6oh
         ncGjaiHNk9z/zbLRHmhz+G9mzFkoNEHFdSBJ4gyiobtHtsFLZlxX7zWOfJzp9OCMvSfK
         /7Q/A3UBkK+8k2J310ojCXJJEXtLkdnIn2ZCSWSl588EHU7FMKAUkRQ0tIScIgQ+GQIk
         701Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SGp5rjwYDX23uopvAqENY3jXGmkT0rNpBZ6WTxZ+Jjs=;
        fh=iXmKKlaLWIOuRMybPq9qN1/UyDrHyLZ/vYFyJBDJ+dc=;
        b=bzsARHzgDSIKbL8UC5aGclZ9RWKTeA2A9cUkJKJcKhzCFnotl4b6gOtgLRi92M4XBo
         OuiN8PbTakLHoGd4znCbYiMvWmzeH1cmqzu6XrfQ9hSHZ8cwOr0n4fY+GbVIcn4glAb4
         QOjQ7W5AsSExXcf1a9Rr8U8YawQBB+Uy89HGKBps2uPz9CZT/CrWDkhp+h8xCS93MZcY
         uRUBUgkEpY8ULH3U2zrMH0TSiPOYX8Qjx2rjJ33DM/XacqicAVmp6Wwtl9T5D7Nlpc6U
         uJ7a/z7Wb7ewbdwOUR/hoegNx8TvNTHhvTLQEOA0sQrhwKrEEWwsIgb/gNXSIxP8PNbi
         sQQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795045484; x=1795650284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SGp5rjwYDX23uopvAqENY3jXGmkT0rNpBZ6WTxZ+Jjs=;
        b=JK0PcKYSHAKO+qQC/+4aNiD5nhfc763XwiPqerouNhTrKGusr/SBUtuJKcUvx2DuL6
         rOxM64cUl3V1XtkfN2bkMSRDdw8aTTfkSzcaFxK4njXz8QvtzkVhKIyVM8hiLLzFpL5B
         ATy8/PN0PgdonBHEgE51nsBudv/OwEzdH/nLG3G8PTB66MZBmAUdfXQsefwucT1w4XHq
         8BOClWx6pilsAlcc3+gW4mAu0Qkq6/auy/68Xw4fRgNf5BOXjGFOrxWQpXCgEIHezUTZ
         nifWbVLau63PAI+MhmIum9hksaj1FZtJnhVSURt12czUuD0F+u/emt/rDw0J9smgS6Vq
         rMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795045484; x=1795650284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGp5rjwYDX23uopvAqENY3jXGmkT0rNpBZ6WTxZ+Jjs=;
        b=gx/9twnctjqLJHwOlFyhWaSHuwq3NSQacnRcVbf5AXYQQa8hS/mqGbOkxtN9Iv2vB/
         0mrdDdXMpg7vCEMm5zBViD6UqYEGfKw0jWBoG6RE130QbmsEDV0q1wOkoO/fBSIit7m1
         az9dJuIXa1WJgi7PrsX1GYgVPkNTAc1JJuFVr4Tjz0wNCLBoNv+6OfQ5d/hE+HDZ+l+7
         mIo9iOWEImDg+0OFzdPGWyCQwtaZDaA9xA9ct4253S6jYsQZ94MHAnEbFiZJ4TlcZpYD
         hLsTB+tXpH8RqM3eksLjbDNxjt5XFnnAoeNGBibPc5lgmIFmNAaVMYV6BKmG69slAFl1
         5L6w==
X-Forwarded-Encrypted: i=1; AL+hErHMFNIOgzugHo6TWN70C7clbbB6kRMMMAjjx03yyIr25kE/hNTlnEolDUZP3QM3ENyoPrc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aldAhJHsldWzQmf2O7l1djEoxENJLlLCB0GPsBJVoegcOhkiF
	CBob4VcHfgRDzC+n/MPDZW6N8306O31QFhUE1P2DXtQxFYwP2n62BiA78fmZOC8tIf1BVsxc0pN
	V1IB3AS2+IR+KM29o5KRsn+Kq8LZgQ3Pxtp4PsUk3
X-Gm-Gg: AYBFou3lvQUjROlQdwo1NslFaB8LJXDpPj/wKL/v9cqVUnD5tZ/Z9dmbTBqtC63Gs7m
	kCV7YCo8Z0Anzij9u2cSJYV1mNxzM+7To+h46PKo0zBTMnjx7tVz36pu+P3/gBnfYrmFqBX1bSv
	R+YB0ObTLmxQJq2Itzi5nel0cVIZ1FAPXe2Ugd2CNSVLCqv/0zLMFfRCCoPZnZZG4No4LyAAJdv
	vKPppF0MyMBrkjtVg2O1tP+8QEDkWnntYC+VXT6kdOCrVdz4ywHsoqUic7Ero571ok/kjCy9QHl
	Vi3GZI4BTWoJR4t5THHAI+vupROOp+0A9hcK/yAv4mi+u60ElVaPKzdkCjAWesXUrNRKG8ejFTE
	GgcPYMr8KG2sCPx5zu4vCqmIoYuHfS6T9qGeqKLNhq0DmcvLNmYxaBmYfFOt3+v3EgwyM6A==
X-Received: by 2002:a17:907:96a1:b0:c44:3006:5c3 with SMTP id
 a640c23a62f3a-c510e363cf5mr385102766b.28.1795045483213; Wed, 18 Nov 2026
 15:44:43 -0800 (PST)
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
From: Ankit Garg <nktgrg@google.com>
Date: Wed, 18 Nov 2026 15:44:31 -0800
X-Gm-Features: AclHuK8KCUSFfMVAJ2SP6DGMcg4kE8fDBiDjsO5JzsBpy68f71zpFA4ycktbcqY
Message-ID: <CAJcM6BHQtbUT+QGhKgJeWcvhWqUsmHK8yY0ZXJ=kHunF2LKOrA@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] eth: gve: drop the now-dead HW-GRO vs XDP interlock
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com, 
	hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com, 
	daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com, 
	przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
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

Reviewed-by: Ankit Garg <nktgrg@google.com>


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
>
