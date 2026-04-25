Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B801DFFD
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777125275; cv=pass; b=Nt2uUfxDoLKMutHE6Gq97yRwb+wnHdAa/JGXwkzRmHU2hsC0gBFK/sr89Vmyc1cFpgXF1DRgS4f3W61l3Av52pGxnb6u73Ovpq2C/5Qjz55ZKOvhzBNRx8INyZyoih55s0w2MQ+2EVniT4w49vVlFZDuwEIUUF/XRbol6VN9Sx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777125275; c=relaxed/simple;
	bh=vbwPluvlf1NiwmpKuGMOnt7jPg/l/NJQS69Y1o49T5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3+htjFbE24T6j9f+xZoqJBjyXo7m3fjaz/dF+TZf8kYnSmktIcXAtO/NOBA3pOXG/S+G4BX0cXk0P1VHHGLcvJcZ/1jpdHBiC06E9gmxJHRSMk/X9gf0T+VlgIMlr1HOccz4+Q/J2wIo8n70y8BWg1SCrVEOJBzZubbXMsRLR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozEYemZf; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozEYemZf"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so10958193e87.1
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 06:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777125272; cv=none;
        d=google.com; s=arc-20240605;
        b=XSD5naUFyxyz9ETjEOIoovhoy9LbZj539+OFqeGf3copwy+9ffIID3FkGZequOVHuA
         aKEdl0uVqy7Jm2fZFAQGIjrLWoei0q8EobnW+9lRMno/zQhwnUDW6PkNj1AnKnxgiZ7V
         fxHDcHqGLDvtnwJOPOhG4IEfJoo9xevhuF/N6YgN6OYng6GNxpISI7D+GheThMdqDYvM
         DILJbYQRU+QFed9qNAHReiJrhw5EF8mE3RSLyJcOlB9R8trKqKFDKt685orIWmQInZ7D
         M/9Scw0ugexxuA8PdHeT31grSS9SJ5IrjENDlcqtQ1E72/m+E51LcieIA78jNkGa3/Al
         D3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0WioSV/XaHHzHaS5+gc9OU+O+VvZzNjsxQQraWtfsds=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=Cx909zuZJFYR3j1Eiq6t5xAHpMXfUoujG0Z8YxVi5Ojc9CqBz4zJ/wyeqIe8sPFm6x
         Dk0ix6grAvi6PVcjI5GIjQqeVO6iiZ+tlRF8c09gy4YAc5NpHu5V6jqW1Q6Lamd9d8T/
         NJh/uG2P3VxPj9k2jAdGrjkw98V26wrr3s5oeG3Bq18UKpnbPGzo7snMDqcfslTVZBRM
         ovny/OIR0Ee5j6QsqUMdgGFg6dhGi9eolP1lI7/Cz9brgb7nvqNKgEyUucM1r/9fBjYP
         fNn3LvQpzOpJrAzCiEqMu4W9wjZepTIm6KFeYX4xRC5w8MbJQ+wf0p5mjdtAEdvsG95y
         YDUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777125272; x=1777730072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WioSV/XaHHzHaS5+gc9OU+O+VvZzNjsxQQraWtfsds=;
        b=ozEYemZfqzTYrM4dlZWP9CLzGPyZV6ponDOeTP1aWbQBU9QX1ofRdLRZBRbVQ62YQK
         Kcr7vix+eSrOxfT0rIjSOJYh4UcOrHtACY+pe2vlZgD5mYM7TrkO6kf7E6CSEgJd3T7C
         5Cdubi0lfzQuvTeOS6BoVL5TSeg4qMMOSVfbX1KQmMgx5I+He8eDVGOviDQhJq+hpXJm
         So4Bkc3Q1Tq0rYzKSoFL6g24/KvsDpNGTpsBKj+cGNNHzZW/oH4MjMRYzCqkHNeBqNFz
         f/gZEuoSOmKVkDTFhdCCOhF/Bd1namBPQ5WmibLE0X5K4HXXbh4PxiJ68mgKonow7U0h
         rR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777125272; x=1777730072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WioSV/XaHHzHaS5+gc9OU+O+VvZzNjsxQQraWtfsds=;
        b=b0C7vDlxicFn/9lnT71h/09D1mxXMYLXK7EejoIV3t4hW/8l2e9ORGo+QM//vKM9KN
         uWKGC9uMd2vO35oq/ChEwZiNKrDW0A9IAPXIq7X+v1E++lOxWLfBV8LoB/uXlfKo/LVp
         +CuQ1i6DkNJukwnVlxoWIbT3Yo8vDfFlHFr5FBN3D6MK3jqgvW5lnAWOYtEVUeULzKze
         mHOQnPf/aOJOn+AG4ECg1vV3ltmkeddkWsFzcP7a0IHJsOLPWjWUHKh76Iy5qd0YkRFm
         LFTeHw+UKwTLjfE5/M7NSjg+M9ZNUfqpORvkTj5A86xxBqBuvcAiRJ+GAVL7jad/XYpO
         wo1A==
X-Gm-Message-State: AOJu0YwqwDmUV/0DVT6CPgYm7OTL6KB8xbhIkFeZlkhc53NIDjPil+J3
	tWo688qflXkz18HMxSaVErK9esFmTvcVnXJv+y/JVYpNfzxSelztppKLX9XDkrBYCFt/T/Rszcs
	GJ1s8my5qORliptXX9klYDRXeHu3IK1+4+gXV
X-Gm-Gg: AeBDievnMy2uD0FoR/nv3GF3/C5soypSQ0SWp1FSSiBtmrQ++aAO8oBT1Wm9iUucvtq
	eFa9+t/khOyMbXZq1xEpelvYOioOeCNfDTgmsSnZV/BI2+/CDzRfJekVDrUlgEw4/bxqznto6LP
	i/KqbTlVZqM95SmGLM31KwKYHDWvOWkV6+/ejfXGF4pAlit19piBqW84ZD72KiMxSCH7ZAXqrWU
	ryg1w79hr+KXpss0mTGstp1dtPmrNJDbQtWvfamL+Il6v82e3SKuOmHtSuxAmpqdYCA5r5A27i/
	6LuJW71lec5w74TtQy4THTozBqqj1SFmH4dRbwyMaRe9PD7vlA==
X-Received: by 2002:a05:6512:3b13:b0:5a3:ff58:e111 with SMTP id
 2adb3069b0e04-5a4172d35d4mr11595405e87.17.1777125271364; Sat, 25 Apr 2026
 06:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-2-kerneljasonxing@gmail.com> <20260425054032.28A27C2BCB2@smtp.kernel.org>
In-Reply-To: <20260425054032.28A27C2BCB2@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Apr 2026 21:53:54 +0800
X-Gm-Features: AQROBzCGYddrlwvDcEbeMReF-0Bx3PFXgwy5lg3LeXzyvZitEsT1jZHhoHF23kI
Message-ID: <CAL+tcoAYdOawD3xfuD3Kap6qCBnviMdLodZa8JkKRHLN3r+fJQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 1:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] The patch incompletely fixes the WARN_ON_ONCE in skb_checksum_he=
lp() triggered by pure-fragment SKBs. It successfully prevents the explicit=
 fallback in xsk_skb_metadata() (which wedged the TX ring), but leaves the =
implicit generic network stack fallback vulnerable. If a user sets XDP_TXMD=
_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device and the hardware checksum=
 offload is disabled at runtime (e.g., via `ethtool -K eth0 tx off`), the c=
ore stack's validate_xmit_skb() takes over. Because NETIF_F_SG is allowed t=
o remain active even without checksum features, skb_needs_linearize() evalu=
ates to false, leaving the SKB unlinearized. The SKB is then passed to skb_=
csum_hwoffload_help() -> skb_checksum_help(), which hits the exact same WAR=
N_ON_ONCE(offset >=3D skb_headlen(skb)) because skb_headlen is 0.
> --
>
> commit 86ab0a4900aa60bee0c3df7393a2846b5ff74ccb
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
>
> This commit attempts to fix a warning triggered in skb_checksum_help()
> by AF_XDP pure-fragment SKBs. It rejects sw-csum UMEM binding for
> drivers advertising IFF_TX_SKB_NO_LINEAR at setup time.
>
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kerne=
l.org/#t
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate f=
unction")
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index cd7bc50872f6b5..d981cfdd853578 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >       if (force_zc && force_copy)
> >               return -EINVAL;
> >
> > +     if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEA=
R))
> > +             return -EOPNOTSUPP;
> > +
>
> Does this still leave a path for the warning in skb_checksum_help() to
> trigger if hardware checksum offloading is disabled at runtime?
>
> If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device,
> and hardware checksum offload is later disabled (e.g., via ethtool -K
> eth0 tx off), the core stack's validate_xmit_skb() will take over.
>
> Because NETIF_F_SG can remain active even without checksum features,
> skb_needs_linearize() evaluates to false, leaving the SKB unlinearized.
>
> The SKB is then passed to skb_csum_hwoffload_help() which falls back to
> skb_checksum_help(). Since the pure-fragment SKB still has a headlen of 0=
,
> won't this hit the exact same WARN_ON_ONCE(offset >=3D skb_headlen(skb))
> warning?

This is a new case that happens around sw csum feature. It's not like
how I did in this patch (this kind of combination proved to be a no-go
from the start. people should be notified of this).

But your concern about the scenario you're describing is right. The
problem only happens when the setting of the driver is changed. If
hardware doesn't support csum, and resorting to sw csum fails, that
will cause the skb drop instance. It's not that particularly strange.
People will soon get warned and adjust their code or policy. Maybe in
the future we'll be able to add more observability code into xsk to
include this case, like adding one drop reason to let admins be aware
of it. This is already on my todo-list.

Apparently IMHO it's a bug at all.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424053816.27=
965-1-kerneljasonxing@gmail.com?part=3D1
