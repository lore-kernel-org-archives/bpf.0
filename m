Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABA495059
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460818; cv=pass; b=oIJKk91JRJs14E5JFCmCOTrB0eL2GoDzTlcQrv2prwx2n3biTm96Qzxbg1thbpfNWkAOsGDcMDcXa0pesxfo+kxGUkaBPT18ZpZZB66dQ+bzY/MhBk01HK1ozp3wRxb60bVi7/z639DbQYgTNU3J34oJN0x9dcA1Iu5QIGR4PxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460818; c=relaxed/simple;
	bh=nPB8HKMrWHw3m7s8Z1NEO0K4n5NwCAXwyUr1xW5XU7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIOTmgHywz/z4zYF0LwJmKbbzc5qJzxqdj3D+lafUmw9SyHw56GU1gNwkm+fernWpf832rZZBVEsF4PC1Tezx4Dyd1ty3YmyyQVlDy1PghuQ9yknpoJjme54QUD8cZDXaRGYNPBNM3lvEkmEcH6lyUegJowX/cubr1YAqu7wLFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=LGyD24N5; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="LGyD24N5"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86868f7707dso1149832b3a.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789460816; cv=none;
        d=google.com; s=arc-20260327;
        b=Zyz4/NcKzptCipwNh/xx+9yq624cmIXqjODgtPDNqtPRJuDD+xbHnchY/vvmu9J3OA
         xbj4Zl4OdKQXDgLJOwm2UxxiQc64klzSzqW5v0HkNW/mQXwQ8PRc4F8RSyQ4QUfjCnC8
         U2/vVYvaU1OkTF7mlIlROP3o7iQCfxUus4NNDQSBJr1AD/gDa8Vs0lvi1CK5OQu3DaqN
         VmmAXpJAG8p2zYtkcXRcihdmsW9WSyJCCEnaiR9vKLmGkOUaV8YGbY2vPKPa6e1Y/KsL
         lHoUzabN1O8ffdIz3Yk7MtIS1LUHzwlj+O5P6w5R/yU12AGAw97GWo2ji2BTqcsxAmIz
         rfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lnh5CgWNygQ5nJ5BcAug/UGA2XoqYnoWr3xk+1LgwT0=;
        fh=zPnPTWUxWRtYlif1/HEdridQuN8ddhx84llcgI8E+xk=;
        b=g3YYyiG4aQgim3VfF7FwoaeQMQ4KLdYlQFKmAF3tn5P+bl6x5SWFYHOH8ROGmvqywl
         t3zGI8+sK536Vq65h69jlEz21YkYV2H3B4xclfqqXelTWnTP3DfWadQGjRvWAY4NNU/5
         L2d7foIq624VK/YT1UgylKzDROidaTP1elFJcKNrH0Ml/Fl8UvLdp957d46H3AtpqsLR
         S4/wLHrEv1sjHWbxJ+VifIo2xlDsHweJ/Q2zPOMocKo/YAiiVn6/kH3B/oGqAX9h1XuF
         MgIlKZLF5siXEVBDMgrANwHe+8AvIjtGYj5pSOM+vCNphupXE89ByJA7EIxrlpeXVbl8
         HoGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789460816; x=1790065616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lnh5CgWNygQ5nJ5BcAug/UGA2XoqYnoWr3xk+1LgwT0=;
        b=LGyD24N5l64zOz1F5J3fHUPcg+6M1qW99Yar6dgJRHRQ/M5ve/6QkiNuWBnYTnSdSA
         x1neQC61BUcK87a1lGXNkl0PTLYYh9toSY5PlqsPORHkjXGAKPA3ku28hqt0jTpp7LUb
         EWcW9Q3mpH7hWLZEMXYX8w/5JlVa0NfXXPoM1AUj80OaGhPOeDXwKnrnKIAy7YfjECEJ
         5czUC3+GUo6x6S4bZDYuxTOOv2B4/f1g2bj7URhijvuJBAGHOPFHfE7q9B+E6aASuX5b
         rTWpO119zUSVLFscBSRvBLPkLz1Yr6zmR1HZEAtsewQbZX+rtkbVtPvUNpx+hb7HGqvu
         l4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789460816; x=1790065616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnh5CgWNygQ5nJ5BcAug/UGA2XoqYnoWr3xk+1LgwT0=;
        b=LNJ6vDlq7/l54mDUaJWE77nKKCwRj8lmKQ7j6jB4AOSfDbjmN498FrEyFCF0gzUNjh
         Jfczs55xJk8EbuJWprarGb7QBO/y+ArUtl+hU/Krb85czQdplQug63RI8tIFF5kPpPrk
         4q6nYhbIOyabqF6lPOtD3ZvjBpxDkQjrBwYyZCA/JyVo0WiQC+aW5HK9Au5f8sx8rYOc
         p2LK2elWtvpC3pqF4333WQZevaLk8z3e7koxOzOUsbR+4mUrpSvgU2T5+orZQYBbFv4S
         tVCcciOuiOn7Wm+z29ZrBHEWMK3FN6zh2jlrzCMkGBtfxyZ7ld+uYtkmyJcECWg0YI0j
         0ZzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTmpu+oVnJ36rDlTok91fowIB0CI6C06qRGLCDzk0bPVNHAwQOw1GngmVoogtJ4vFwLNs=@vger.kernel.org
X-Gm-Message-State: AFuF++koM3QxOYerDT6yWZVAAciSaFzHJbmWDDGxYKURaJSc8egj6vn2
	jMfB98O5AdC3HNMH3lrrwKlhLoM8DSRCd55B9r3YSV8uQAwGPwT+oB0XmZMtj5xIJF6I69V9mhU
	oGHXQwANuDwAbIqJ/BZv1t0xn03l5Yj8CvvWC/xhK
X-Gm-Gg: AYBFou10NKWUBywRoG2by4DPlpbVZ38/AcO29lwJKTymo6OHvZUWMN0g4ivznyQhPig
	6qe19UB4/h5HdPjHfx9TtCrNA+RZROcyAwGFwO8YWSQBP1cDr5o9XKSLZj3JVI4bnSqSLZVe3RH
	cNOuPZW7ws9ZyMoFO1EsWzAD7DxL/RzjoqP9gKNw3OXHYEUn/rWEQ2pP4/Ay6Q/0+FpNwrp9xyO
	GRWD/fTVg0d4Qu5rLQZRJ722LZzf0IySQWW01iAVW/qeoYczulR/vsfTN9q6PTNHuv0hHsRN0i6
	PPZOr/AaEuophZtlZyEG1ljg6LQLBDnYwfxNtO8XzE4k5prF5OxjSiqC9qxIq/EaCKfAkzB1Zqx
	VY11yefWqKsZaTijDsq+j39W4ENKcelUYGjDLY/lIut8yQZzhhHYkHVgy
X-Received: by 2002:a05:6a00:22d4:b0:857:7337:5db6 with SMTP id
 d2e1a72fcca58-86f857f03e4mr11800026b3a.20.1789460815852; Tue, 15 Sep 2026
 01:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915082426.703892-1-xmei5@asu.edu>
In-Reply-To: <20260915082426.703892-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 15 Sep 2026 01:26:44 -0700
X-Gm-Features: AcwNN1VHk4qFiOTVVqpCxopv6W4c447U28-fnrK3q7ySLfaNNx1iHuyYYDxzrTc
Message-ID: <CAPpSM+SviG8h4CYfjYf3FtowDcj8JE11ThBTip=+f690514uBw@mail.gmail.com>
Subject: Re: [PATCH net] net: bcmgenet: restore the hardware filters on open
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jakub@cloudflare.com, Nicolai Buchwitz <nb@tipi-net.de>, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this email. It's an email sent by mistake.

I got this patch for testing and wrongly sent it out. Sorry about that.

Xiang


On Tue, Sep 15, 2026 at 1:24=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> From: Nicolai Buchwitz <nb@tipi-net.de>
>
> bcmgenet_hfb_init() runs INIT_LIST_HEAD() on priv->rxnfc_list, which drop=
s
> every rule off the list, and bcmgenet_open() calls it on each ifup. Every
> rule the user configured is silently lost:
>
>   # ethtool -N eth0 flow-type ether dst $MAC action 0
>   Added rule with ID 0
>   # ethtool -n eth0 | grep -c Filter:
>   1
>   # ip link set eth0 down && ip link set eth0 up
>   # ethtool -n eth0 | grep -c Filter:
>   0
>
> Initialise the lists once at probe and restore the rules on open, as
> bcmgenet_resume() already does.
>
> Fixes: 3e370952287c ("net: bcmgenet: add support for ethtool rxnfc flows"=
)
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> Reviewed-by: Justin Chen <justin.chen@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Link: https://patch.msgid.link/20260913190052.939955-1-nb@tipi-net.de
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index a2305e6428d1..b916080f4ff1 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -749,8 +749,17 @@ static void bcmgenet_hfb_init(struct bcmgenet_priv *=
priv)
>                 INIT_LIST_HEAD(&priv->rxnfc_rules[i].list);
>                 priv->rxnfc_rules[i].state =3D BCMGENET_RXNFC_STATE_UNUSE=
D;
>         }
> +}
> +
> +static void bcmgenet_hfb_restore(struct bcmgenet_priv *priv)
> +{
> +       struct bcmgenet_rxnfc_rule *rule;
>
>         bcmgenet_hfb_clear(priv);
> +
> +       list_for_each_entry(rule, &priv->rxnfc_list, list)
> +               if (rule->state !=3D BCMGENET_RXNFC_STATE_UNUSED)
> +                       bcmgenet_hfb_create_rxnfc_filter(priv, rule);
>  }
>
>  static int bcmgenet_begin(struct net_device *dev)
> @@ -3376,8 +3385,8 @@ static int bcmgenet_open(struct net_device *dev)
>
>         bcmgenet_set_hw_addr(priv, dev->dev_addr);
>
> -       /* HFB init */
> -       bcmgenet_hfb_init(priv);
> +       /* Restore the filters, the MAC was reset above */
> +       bcmgenet_hfb_restore(priv);
>
>         /* Reinitialize TDMA and RDMA and SW housekeeping */
>         ret =3D bcmgenet_init_dma(priv, true);
> @@ -4075,6 +4084,7 @@ static int bcmgenet_probe(struct platform_device *p=
dev)
>
>         /* Mii wait queue */
>         init_waitqueue_head(&priv->wq);
> +       bcmgenet_hfb_init(priv);
>         INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
>
>         priv->clk_wol =3D devm_clk_get_optional(&priv->pdev->dev, "enet-w=
ol");
> @@ -4272,10 +4282,7 @@ static int bcmgenet_resume(struct device *d)
>         bcmgenet_set_hw_addr(priv, dev->dev_addr);
>
>         /* Restore hardware filters */
> -       bcmgenet_hfb_clear(priv);
> -       list_for_each_entry(rule, &priv->rxnfc_list, list)
> -               if (rule->state !=3D BCMGENET_RXNFC_STATE_UNUSED)
> -                       bcmgenet_hfb_create_rxnfc_filter(priv, rule);
> +       bcmgenet_hfb_restore(priv);
>
>         /* Reinitialize TDMA and RDMA and SW housekeeping */
>         ret =3D bcmgenet_init_dma(priv, false);
> --
> 2.43.0
>
