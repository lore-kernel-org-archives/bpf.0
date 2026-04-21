Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F73A5E82
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810016; cv=none; b=dJEPVooULC6P0Z72yu3IgWXzmzKfbvi65fGVP4D/LqE4h/wuVHOr6WN/u9ZSYcx1XafFsucD3pgkviUYTS8d37AvY+rWg/cxTxt10EazD/7L34L0NPlKuv5x5rjW2NAXQynEmxGIQG4EC4yVqpPeizybO9wPmIRC3qEX2gUhd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810016; c=relaxed/simple;
	bh=a4w8+2wcKmtmeXRFt+uVdMabsR9DGM0MEHNTh4eYR1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzlwFbOAO2pyVgnNjbAZHl8p7i3ksPPJzxF9cJ0P/BZisBXL3Vg/iL2+4q6LAGIZehzKIjR9bpAIOGLCi/PtOxOTAlUiruzcKo/bLBNOexF4A928CaDq+UfTqEXePg3BZBZru8YxqovEzB+mMpHfbJ3IDSjBS2RrSrsd0JR69XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUJVyOE5; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUJVyOE5"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-42fb77499edso312586fac.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810014; x=1777414814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5k2a1ZwjWaXhRtVuXvTgvfheVXV0JH9Yw/NlxIWNNYI=;
        b=jUJVyOE5/NDo4UEHOphFCPt64D0hCUuS2V3jRA63xOqKhN2skt6NniISREZXhDbRSH
         W7AkyIFJdJz0d9uL3lxb1SFUpv+WSXhGwPraxHMzuPyD/q7Fc0Gxi/R6z7au7cCk9cvv
         0imS1A007VOMNO/op4SarSvxUKtA4t46AYofw1FmCkjC2ObpoxC1r04LMOEREfSQKmMi
         Ap4HYkpmcDnU11hlGxeLqAL1zClLwlUWN+yLo8sKROyQI/BIsaTPXW6ajwtsRUUb4nRE
         6wY0eVznPvAuw7tnlKjo+vdCNJ7pjCbJrpz5BZuuWE7PrKpGplheezNMXuGubgDnuuRz
         Uglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810014; x=1777414814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5k2a1ZwjWaXhRtVuXvTgvfheVXV0JH9Yw/NlxIWNNYI=;
        b=H6wXOpOBwMd/BxecRN0i3bu8xG47+SFY94ZWGvL4iChTR2gWEtIWl4sKWlGHluWGUo
         k6wQqD2ddKFCRWO21upiV47M/Cuhem8bCKFXr0ArNsevIJNl0uUG0rA7+Ya/GuH12edS
         iPtzBQBYDr0KWKRtQ4Qrt6YpLXE3urHvwjqU9knA4edlBmWOjogzrBPNuqMexFfaKo9X
         s+HsELxFK2GeLaJ98gK63fg1LnwcVsz3PeOu6Grs1nbRj50B/+8rHShircKLjLgaLLg3
         18RrPBZcPgKcFJRwkST22JxAPriB4luJiy1Y+UaUaG1J/kUU3gBXSUiMWrJXC0NDv4pK
         SnbQ==
X-Gm-Message-State: AOJu0YysTP0KKKBpPghz8zTt2KZ6JS/uUcZAKWykew4HWqs9k4JFveKF
	qYvH7THquHOGgybkvKCG8iHXN6cCuzoSOQt5hGlXCkAYhXrZd7N8zt4a
X-Gm-Gg: AeBDieuvavHTxyOCMrTc0xolrs8odKgxTJ9yT5j8x3K4d++j6S50EDX5u8jwrYuLTkr
	iHxDmNj1GCpyHGUMnN9a0Do5a3U7oGJJx89vjNPnSgV10G15LwyIDJ89JcEcZSa3jOITL1c+FQ2
	qBulZs8/Yu/S36aFeGXsTFkWR02nuMj9zwucx+fCOr9Wug49bGXfhDGUnEp63Gi2/0lQ0irKjMn
	6CQkfeNaCsfL3lKyzA4JHhsmNoU3uEvwCZb+rGlVDt+yJEnzIyouqtUMEdAMrKeQsVd6o+7TN6O
	8C+6JaKEaSR0nEoUreQAOk/AqbghNam8eh1l32O+/1awXtPISCilbQIEj3XSd00dSWUVB0qPd48
	P2OVXVKcnTCFRPdTsOE0ZuUHpzxplvC53rqWEvxcnFntIScrEvN4TEzTg73WTVKBtSDArw0Hwte
	BwiFHLFRoWotck0/UvI2F1v7cEHotH
X-Received: by 2002:a05:6870:c6a0:b0:423:1c3a:33d2 with SMTP id 586e51a60fabf-42aded6ed1cmr12505398fac.26.1776810013852;
        Tue, 21 Apr 2026 15:20:13 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9acc056esm13255853fac.17.2026.04.21.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:20:13 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:20:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
Message-ID: <aef4DpNOD3otivdp@devvm17672.vll0.facebook.com>
References: <20260420082805.14844-2-kerneljasonxing@gmail.com>
 <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
 <CAL+tcoCwEeOriG3y-EZm6TfDenr3uCEDXUJ8MtrW9x=Jx40ohQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCwEeOriG3y-EZm6TfDenr3uCEDXUJ8MtrW9x=Jx40ohQ@mail.gmail.com>

On 04/21, Jason Xing wrote:
> On Tue, Apr 21, 2026 at 3:34 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > skb_checksum_help() is a common helper that writes the folded
> > > 16-bit checksum back via skb->data + csum_start + csum_offset,
> > > i.e. it relies on the skb's linear head and fails (with WARN_ONCE
> > > and -EINVAL) when skb_headlen() is 0.
> > >
> > > AF_XDP generic xmit takes two very different paths depending on the
> > > netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
> > > skip the "copy payload into a linear head" step on purpose as a
> > > performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
> > > pages as frags and never calls skb_put(), so skb_headlen() stays 0
> > > for the whole skb. For these skbs there is simply no linear area for
> > > skb_checksum_help() to write the csum into - the sw-csum fallback is
> > > structurally inapplicable.
> > >
> > > The patch tries to catch this and reject the combination with error at
> > > setup time. Rejecting at bind() converts this silent per-packet failure
> > > into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
> > > launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
> > > because they do not call skb_checksum_help().
> > >
> > > Without the patch, every descriptor carrying 'XDP_TX_METADATA |
> > > XDP_TXMD_FLAGS_CHECKSUM' produces:
> > > 1) a WARN_ONCE "offset (N) >= skb_headlen() (0)" from skb_checksum_help(),
> > > 2) sendmsg() returning -EINVAL without consuming the descriptor
> > >    (invalid_descs is not incremented),
> > > 3) a wedged TX ring: __xsk_generic_xmit() does not advance the
> > >     consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
> > >     the same descriptor and re-hits the same WARN until the socket
> > >     is closed.
> > >
> > > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
> > > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk_buff_pool.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 37b7a68b89b3..c2521b6547e3 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >       if (force_zc && force_copy)
> > >               return -EINVAL;
> > >
> > > +     if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> > > +             return -EOPNOTSUPP;
> > > +
> > >       if (xsk_get_pool_from_qid(netdev, queue_id))
> > >               return -EBUSY;
> > >
> > > --
> > > 2.41.3
> > >
> >
> > Wondering whether a better fixes tag is commit 11614723af26 ("xsk: Add option
> > to calculate TX checksum in SW")?
> >
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Thanks for the check. But not really. It is the commit 30c3055f9c0d
> that brings the csum support of IFF_TX_SKB_NO_LINEAR case where this
> issue can be triggered (because this mode no longer puts data into skb
> linear area).

Ah, right, good point, it's the IFF_TX_SKB_NO_LINEAR path.
