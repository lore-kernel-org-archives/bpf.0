Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0CA3F65EE
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406070; cv=pass; b=TIYnQSIi+bn86yh9l0+y6quVON3lo1zusHo2HwiJ/SmduI7u18O8c73MLLNJWDPkcCpNe57a5WWsG0XSWJM3FzeoZNcaGOZCjv12461N12bhep3WSIjtcJ7us9aVxDCh9jJykxRo2orL0FbLz1DjRp9bPGhQT/mpv0FYtuFkIpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406070; c=relaxed/simple;
	bh=ciGMzskNIsPhsbh0dgt35XO4TszyumewRL+cei6XM8c=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct+d2WplgJ7rmZFModcfSSKciPB0YZYJJkSVD4AC409to1/cbdrjsZgNQ0iXgsLSymFZF2J15muBL3P6jeO2mVdQOkWaHDNkFxQYO3MQcQSo0f56AtVOXNa+n1rk+HNLlEdtKYUPrKPovp/AQ1FpWSlMkzerm0zSQqHqRA9BtQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4n7ViTQ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4n7ViTQ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6685001353fso1983987d50.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 03:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785406066; cv=none;
        d=google.com; s=arc-20260327;
        b=ONw0jtdn4X3YB8bIIBCBtDpD7wgmses+8pnn1p+ywskzritROntiSU5hNCnv34av4I
         Ra3GzncdlnL44sIr6WFL8ofCCUAzoBVZ228vQIIldG5f3qpjSvE4D0DDnqeVqluHaST6
         P9ZtzRlNLjXtwGbs1kmTu0EcGpNJ+Im9ux8bB4vyJ/PJXw0okjYUFiXCM7u6N95KDjje
         iDT7XO5O2CX+V1JPrmIXYlS9z69wogmSOpiRREIjRAWOB7rWsqCduezSlNyCW6aZz+oc
         9QcwUTpUhjrKXY6GB8hpsOvmWvG8NPgzbAp3Vm4xrjFVF2nkO7SL4QgBralkiNadsred
         +zZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=ciGMzskNIsPhsbh0dgt35XO4TszyumewRL+cei6XM8c=;
        fh=obbJOSQTNrWpNAq0DaPubzw17oEYHp61ikwpn/Mep5A=;
        b=kDkFfF3ib3V53UrpOOFEm/WH10wLkTavp+5ZPT2G/NXaoJ1zoD7w/5UYvdhYgVChBQ
         5NsaRoJKk2490sQp6L4sgqY0uGvKquPBXG3W2OSxUglRvs8CHEBTktuPvQrgXPkXlP12
         Eb7o2m7qv7dvvWaJ74JzWmCJzbi5+HpmXe/+BHkW8UbxSy0YQxmszhC2c/Hb/Nv2NLQ4
         XcIOsSItJG+UXzcoPlZhWmJQeTcbC5q/+G6GXVUyVAcYsd63EFLFbyY5tORdX9yZ2alV
         gc3pt4bmqjQgWG7hd9YJppF3iYuZYmDqWETPxZ2F6z3QUI0k7PigK79CF9oFdE6SukCw
         w8HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785406066; x=1786010866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ciGMzskNIsPhsbh0dgt35XO4TszyumewRL+cei6XM8c=;
        b=Q4n7ViTQAyc7nT5qQEEVsKDtHN2570A9oc4mBJqYdynxPkVnjfln+dVfwGX7cTbjnp
         6Qm0df9drIbBJJkQu1g6CFiWEEmUTl20m5B6MTCgYCy9ZXJUH0Lm68n1c4bLxFLwXFoe
         fHrkASwETWPB7H/U9kjONJ56VqIv8ZJfZvr+p0ov89ThxoWMYiDbhqsnYX/EI2Wg5xNZ
         vqDzMWmzY81yxFaJ7Q70/cGlUiw1ETOjcPSPcleP+ioVon4YLn/MNqXZi/JzTpvIGXwB
         6GxL3Z+C5Kl5RNA+3+DFAqp9bCRrwzll3ajPpIRfdV3hkmui4W2oE5DSnc8A7YZRU2j/
         8ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785406066; x=1786010866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciGMzskNIsPhsbh0dgt35XO4TszyumewRL+cei6XM8c=;
        b=ca6r56WqkTifP6qQb48BryxYmBC3D6KseponTQ+fVxObGPE2hWOSd0m7OtOkhfmA9s
         pg4bwfDWKtLqAuo9l7jFKFpl2znB12npn8M0zSTh0aY2YavjkTyFUPtqxzXfmQRy6Fi2
         QlFhWVKTEZE1ns3Gba4ZfWuS0tmlDrbWhBWnSFjYBNtCcPO8kqeHBqNjOKfLE5EUJJMv
         CONa173A5S1nsP4c9GBkMRbwS7vdLBRpdIyccFxIPnbpElCHJzUrBrXsGWOvrsGGcgf1
         ZwwqeI7CjVQmJRoNTtiGh7zYHN6eLiv0WWpKs5D8Fi5nXujxlQrIBEML5fStM4cffstC
         GHbQ==
X-Gm-Message-State: AOJu0YxmEYLDwJctCEjSPLZRIha6akp1buJD6ME9LE/rcvl2ENPCrdZA
	MNFXfoOiNI3tVdMYusC161pke1+fZ2JhZPajlcw7jzZ1nRYpDr+B/uvct4mY65P0Y4ZPiui6/I9
	q05GJ3OhZ9KFV3goBHjiW7ASuP3jOG0ScUgH4
X-Gm-Gg: AR+sD13tqHXFQRDY60j4fcBtxPcE6vVLoeGQklVeUBisHrPJBquLXXBJKhObvQg0NXF
	8n1xwsTA2qAsiVs3kChc4J+4Q3Xg1u8vx6oQ2IzJpvoxzTP9OuA5ARC5aDXdObmwjY9WVqnQndZ
	LuHrbRaKeYPbWMsiWMzlmt7SY6gfi8cPTkPqHVumZ47LjweNsWl9ruexfg98MDKYvMCcp1eaMQ6
	O1wx9dL4MVEyxJ4dNUI782AjfCpTnNMdaHCsQ5moE/1py+F4AJwQmW9o8rbZJiKLd7iz2hYS3+y
	jixg/JCG5WuNLqTWywehUEOGMZDDsQVPiy1Q7YAKPxX2EgD1YK3JiB56rYjtB19JXgBuTG2H6SQ
	P4rs03KpGWhMDpFh1nwEYGyvaeA==
X-Received: by 2002:a05:690e:812:10b0:667:b503:4d36 with SMTP id
 956f58d0204a3-6692f631d08mr870536d50.42.1785406065655; Thu, 30 Jul 2026
 03:07:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Jul 2026 06:07:44 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Jul 2026 06:07:44 -0400
In-Reply-To: <20260728032611.EA2001F00A3E@smtp.kernel.org>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-3-sun.jian.kdev@gmail.com> <20260728032611.EA2001F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 30 Jul 2026 06:07:44 -0400
X-Gm-Features: AUfX_myZG36cbEX4KAdVVoloVQC_lyxlLR7o48AISuEXBCtTOC1jjUm9EzrycjA
Message-ID: <CABFUUZEQ==gohFF4GuEZEGGorEv5Hszcfe_saeKB-zSSxnshYA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] veth: fix skb length accounting after XDP frag adjustment
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sashiko,

Thanks for the report. This exposed an ordering issue in the veth path.

I confirmed the case where the tail shrink removes all fragments: calling
__skb_put() before reconciling skb->len and skb->data_len leaves an
inconsistent linear skb state. In v2, I move the fragment length accounting
after the head adjustment and before __skb_put(), so the invariant is
restored before the tail adjustment runs.

The more complex combined head/tail scenario will be investigated
separately; v2 does not claim to cover it.

Thanks,
Sun Jian

On Tue, 28 Jul 2026 03:26:11 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Incorrect ordering of SKB length synchronization and manipulatio=
n helpers causes BUG_ON() panics in __skb_put and __skb_pull.
> --
>
> --- Patch [2]: [PATCH net 2/2] veth: fix skb length accounting after XDP =
frag adjustment ---
> commit 7bca8b2841500975db8d1e89e6bd51e147aa4ad3
> Author: Sun Jian <sun.jian.kdev@gmail.com>
>
> veth: fix skb length accounting after XDP frag adjustment
>
> This commit fixes an issue where veth_xdp_rcv_skb() left skb->len contain=
ing
> stale fragment sizes after an XDP program adjusted the fragment area. It
> subtracts the old data_len before replacing it and adds the new data_len
> afterwards to keep skb->len and skb->data_len synchronized.
>
> Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.o=
rg
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
>
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 00e34afd858e7..a956498a073be 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -871,12 +871,14 @@ static struct sk_buff *veth_xdp_rcv_skb(struct ve=
th_rq *rq,
> > __skb_put(skb, off); /* positive on grow, negative on shrink */
>
> [Severity: High]
> This is a pre-existing issue, but can this sequence of SKB length
> synchronizations trigger a kernel panic due to the order of operations?
>
> If an XDP program modifies a fragmented packet, veth_xdp_rcv_skb() adjust=
s
> the head and tail before syncing skb->data_len:
>
> if (off < 0)
> __skb_pull(skb, -off);
> ...
> if (off !=3D 0)
> __skb_put(skb, off); /* positive on grow, negative on shrink */
>
> If the XDP program shrinks the tail past the fragments, __skb_put() is ca=
lled
> with a negative offset while skb->data_len is still non-zero. Doesn't thi=
s
> trigger SKB_LINEAR_ASSERT if CONFIG_DEBUG_SG is enabled?
>
> Likewise, if the program shrinks the head (triggering __skb_pull() before
> updating skb->data_len), could skb->len drop below the stale skb->data_le=
n
> value? This would hit the unconditional BUG_ON(skb->len < skb->data_len)
> inside __skb_pull() and cause a denial of service.
>
> Would it make sense to synchronize skb->data_len and skb->len before call=
ing
> __skb_pull() and __skb_put()?
>
> >
> > /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > - * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > + * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> > */
> > + skb->len -=3D skb->data_len;
> > if (xdp_buff_has_frags(xdp))
> > skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > else
> > skb->data_len =3D 0;
> > + skb->len +=3D skb->data_len;
> >
> > skb->protocol =3D eth_type_trans(skb, rq->dev);
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727032535.13=
469-1-sun.jian.kdev@gmail.com?part=3D2
