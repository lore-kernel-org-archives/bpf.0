Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A953876B0
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777748690; cv=pass; b=Q1fD77WxABF3lkrLIgsupoRIlczJA7qVzDtigIJFXRSHh4vtAq7Uiw/VqmIx3hXkkUsExl14jk795ulr8ODMHIcGx6MVoLAb9eNklHlAjFgM20bMvjU2icIXxNvAenZzbKxunVMBSPIjuS89QHRQlEwfq4AlTrAq3+EoCx+pto8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777748690; c=relaxed/simple;
	bh=JabJJvGOVACFB5Q05Gm+KwlOst4BTOxQbBgtxJNSxhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpU/mTpPZQHx5UVKCtMhnXw/XkNn6+kFug3mwAIBceUmhVpACussbALpF4ciC7GyMh91WdIjF1JvCEBpfKv5WPnXjhYiqQK8sazT6qh6gQJLIQHouXw+235LlrdBm8mp/QH8fbRenCZlM4XvTLjHVIG41JbdUUUFvIXSu/oOW5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJ0AUG7d; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ0AUG7d"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so4020585e87.1
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 12:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777748686; cv=none;
        d=google.com; s=arc-20240605;
        b=htuqhJdqcF6Tnk3BT3BSP+ZBXm2RFJgfF/F24/fuQ/Ip8GiIXgXik4swZmfVszB8GE
         uW7DUy81fTPrJRdS2Spq2KF4uKGcZQgI0QUbRSAE/9kgYhUesO/xWxDO1uS7j0SDnArb
         3TL+7KTcClHmkh7AcnrBX3ZI5BBtTeTj9x571KkUKgtmDPhjGHJtxXhpdhw6vT7nYnNT
         0Z3GzfsRw+/BcIkUD0NwtixS9eYGLiQ5CIWyBy3Miq5ysw5ujm9vFMgETv/3DkqCC9JL
         kBnTe2jVGybmYoswJA/0RWoJkJiXb4mCIZyet6TQl1G4SQWJpqZOuF6fxBYwVbMEPqx8
         vprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJEn27V6OkYesuaUVcNgLy1Ezf+jQkNNDAQg+5dVDzg=;
        fh=JLcVtqjXw0muFvONtsPF/0ahnLj1Z7kKvyqbhQLD+ZA=;
        b=c/8kYDKDUnwGX6p6lLytbJ+zoJZqBFXIBmLruSjXxJEJF1owZL/4DjdYNPF5qiNv6G
         dCDH3+8V+rKzyoqzaJt2Dt97LKdtmoLcd48rThdzFR4s/YYf/Zgd1LjsDtEKjqeXS8Ep
         ah+bfn6zAhZDkPX6UfwmW6u08PeswcSr5rLjakEXkCIghPpHNiHam2vIGAqLFdbOISJT
         +bhRnBuB6aNwjWZ5lvPFo56nATBNrnHeLtv487eC/fKLroDM5S9HAuJ3awZ2D27Lz/aG
         BwOHrq/A+9zuqWpZJFwA5BjOjyDHwKFAlI+vMfrqFidtFDRAZDgFOg2U4eG8581UoFC/
         5uDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777748686; x=1778353486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJEn27V6OkYesuaUVcNgLy1Ezf+jQkNNDAQg+5dVDzg=;
        b=tJ0AUG7dhkSzOJzkp5ME5CQTf+lbbkBHLNqtJi2+FQwaw1VuFN8ybt//bO1oO5tdD4
         RnotA4P4MEVgVtLPwxRwVyq3IA3nXyecK34EQO1Aln5e3iyf7+5UsHNwk31opsUc/t86
         7TyNGkFPb7YMvhnhJWWW/ZxQHo409VISb8XYTshKOKA61WnDZQkp1rCp1pCpGvXcsWHS
         WJGa/ZCvsJmsEIZHRFF9KVvjvSwd08XFVgOE9ndJBmDFfhBkM2hlMTl86o9KAoIoBjzx
         AOumvS8S+4Dd76GtKVNOiBpt6PQbMBMP9ORbAIR2YXc03qAu/sxfv11rgzYTmlhHnJT8
         u5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777748686; x=1778353486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJEn27V6OkYesuaUVcNgLy1Ezf+jQkNNDAQg+5dVDzg=;
        b=TAGELxGdpB8fMEzr8x9QPN+Dd0HK0Vksi8vC59xM6oM7BWaA6L1YOQ4eR9qwGZWiOT
         FfOyQuiDkuHSj6CnMqFU1RpoLYWcZHVsA2FoTunVpSv06ovA0EYnH1K+/jsxM4WXwALW
         dRx/VxIH5kpIij1KrmeItlLDQTLxmTZ/XhG94WK7qg5CCDe6H47vndytffxrsuZ5ffte
         gTb/Ygd1IWZh7TVrNp/Kjpg6F9nAiwt8ZkI7n1Lj/QXMiaIPl4HakCI37e1AV3YVghWA
         G0QEixsKRQE56DWltLrdPqCem8J6TNMSfiWvmnY8oProlKqUi8wIgsqm6idIZSIeztPT
         P2iA==
X-Gm-Message-State: AOJu0Ywzt0tFmQoolnAnIfBjiW2fUfzMNmvF419z0cXqKc5vhUn28xDV
	w0/8vAnMX/ATEqQHZicbAk5jxm4ekyfGI2Z46ZrduoeqLxUp8vLeQkNH4O/VV3lAu160Q8Ybak9
	JuTQXvRXfzY6lzTkpaPGH2Fs3NTZtXM0=
X-Gm-Gg: AeBDievHwqygvGAFettnSSacmOn4SrBICt1ObUQOLu2l7HLaTuwbKJ8+psGosleevOg
	QF8JmTzmvc4UnSY0uLWR8zenlrBF+cgdTrl7SiZ3tFHrfqpYuhD2MaZ30VeGm6jG0RonblSToSi
	KiS9K620qytO757YLolY5cclXeT8WKQjjQQjhaXIgvrkeM4mcZuFkhR6Q7NAn0jj19JsivGgv6r
	JZ6vJo5kxyTZejCzFZr2FNsV93rlUtKqJwOoGECfeixNSvhFP4k1+zD525kDt8lT/S+EbknfChO
	7Qwe3Zahy7JkE8Q9vKq7ggJ2Z5i427iY2vElt3dhZYSW6dnj
X-Received: by 2002:a05:6512:31c9:b0:5a7:46f1:d96a with SMTP id
 2adb3069b0e04-5a862ec3439mr409761e87.13.1777748685442; Sat, 02 May 2026
 12:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-2-kerneljasonxing@gmail.com>
 <20260425054032.28A27C2BCB2@smtp.kernel.org> <99816901-6026-49ec-9c20-b548ed362d11@redhat.com>
In-Reply-To: <99816901-6026-49ec-9c20-b548ed362d11@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 2 May 2026 22:04:06 +0300
X-Gm-Features: AVHnY4Lr-W5067WEgcSeNunEx2Jj-8DqWBliGYLjrFqxjd89zBTtZWswi8YtXcc
Message-ID: <CAL+tcoDcOz0q9MNNOfgYdt2XAKHAkjFW=r-seHifYqyMH3RV5g@mail.gmail.com>
Subject: Re: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, sashiko@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 4:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/25/26 7:40 AM, sashiko-bot@kernel.org wrote:
> > Sashiko AI review found 1 potential issue(s):
> > - [High] The patch incompletely fixes the WARN_ON_ONCE in skb_checksum_=
help() triggered by pure-fragment SKBs. It successfully prevents the explic=
it fallback in xsk_skb_metadata() (which wedged the TX ring), but leaves th=
e implicit generic network stack fallback vulnerable. If a user sets XDP_TX=
MD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device and the hardware checks=
um offload is disabled at runtime (e.g., via `ethtool -K eth0 tx off`), the=
 core stack's validate_xmit_skb() takes over. Because NETIF_F_SG is allowed=
 to remain active even without checksum features, skb_needs_linearize() eva=
luates to false, leaving the SKB unlinearized. The SKB is then passed to sk=
b_csum_hwoffload_help() -> skb_checksum_help(), which hits the exact same W=
ARN_ON_ONCE(offset >=3D skb_headlen(skb)) because skb_headlen is 0.
> > --
> >
> > commit 86ab0a4900aa60bee0c3df7393a2846b5ff74ccb
> > Author: Jason Xing <kerneljasonxing@gmail.com>
> >
> > xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
> >
> > This commit attempts to fix a warning triggered in skb_checksum_help()
> > by AF_XDP pure-fragment SKBs. It rejects sw-csum UMEM binding for
> > drivers advertising IFF_TX_SKB_NO_LINEAR at setup time.
> >
> > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.ker=
nel.org/#t
> > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate=
 function")
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> >> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> >> index cd7bc50872f6b5..d981cfdd853578 100644
> >> --- a/net/xdp/xsk_buff_pool.c
> >> +++ b/net/xdp/xsk_buff_pool.c
> >> @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >>      if (force_zc && force_copy)
> >>              return -EINVAL;
> >>
> >> +    if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEA=
R))
> >> +            return -EOPNOTSUPP;
> >> +
> >
> > Does this still leave a path for the warning in skb_checksum_help() to
> > trigger if hardware checksum offloading is disabled at runtime?
> >
> > If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR devic=
e,
> > and hardware checksum offload is later disabled (e.g., via ethtool -K
> > eth0 tx off), the core stack's validate_xmit_skb() will take over.
> >
> > Because NETIF_F_SG can remain active even without checksum features,
> > skb_needs_linearize() evaluates to false, leaving the SKB unlinearized.
> >
> > The SKB is then passed to skb_csum_hwoffload_help() which falls back to
> > skb_checksum_help(). Since the pure-fragment SKB still has a headlen of=
 0,
> > won't this hit the exact same WARN_ON_ONCE(offset >=3D skb_headlen(skb)=
)
> > warning?
>
> My take here is the issue describe above should be handled separately.
> (And on top of my head I don't see an easy way to address it short of an
> additional check in the tx path, which I think we want to avoid).

Agreed. I've already reworded the commit message locally :)

Thanks,
Jason
