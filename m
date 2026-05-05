Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84336C5BB
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008195; cv=pass; b=NXc19Kzj7CFT/BVseV+QI3qa4doN2zFWwOJstyUMI04KcT+n94uHwMBy6qh5Li+y9jqh9GDkuKuP2B8yo8x6tVjDsmTzVZn0dZm9YvFtPrTIRozY95Xf2pn69R5irjZlDDu5nwb3FT9axjhK6oDd+s/rMlMYA/t3FiMlLCyi9+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008195; c=relaxed/simple;
	bh=Bx9gkPPFEl1fePOmnwnlCcaRXiZsz2HzPTFaFk9GHic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzZAnjzpAa6y+05NgUCEW6yBsQptBGqupZF9wSbBRRzu4GnTyDUxYZHQow/Np+ZIwrcwjfymi1+jsR14nv02bBUkPPsw4ECzVpAfA52QsJYPXEou5y5M2Rfxzk2KaUGFXAyo8bWYVBtmpGl4jkDhBNeJhGzswVJUSZG0ZnsS8BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvxXfJ6D; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvxXfJ6D"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so1363988e87.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778008192; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8Z5zFWuZ6svVQWUAxR0qnUb8dNz/IIEhwVmYqIxp6v0VTCtiVv8IrwIazDCB4M0+c
         XuhfXXSt+9ZSzk2MC5+LLssnjRoUXq0C9WEpe3+xSmDBsbkbpjHf4lULR/4KjG/xX7IE
         KVrHH+joR4cUS2oQCBrx8BA7aJTcECTpm+YbQM3daA9LTMluXpC3LaBC7unyE90lpn49
         UOl1waZt82Szx0zZ6Tz34rX16QQi3NoEUtRoSzpMpscfEful50IoP8h8lldDXn9gAjMH
         ofjAts4V6SFjecVIONrVUhU4YmqVcwBjSGH2YX89DIdaFd8WBiZr0hFgQCxzjMJeaZsS
         0+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r6f5dGGeyzIZr/Pk0ZoSjwO9CpIcEaa4a+69NQ9afqU=;
        fh=Nsd0F4Tqz99s5KyVzoz1cO2JqxapLWSIRLlLyE50/1A=;
        b=es1xzWah1DoBLZJph0zeQIBzbDsS7554VDoOq+ArmllJ1EHFEuwLVijvpEoqEBh82/
         /+Rg5bVCy0iEB/C9kbCjU5ZvkJlmUmT8mM9dnhgFYmdhwGDWgf6jOy/R5jTJvXgii99u
         6nzvrUoqFTM+V5fYY3dPjQR1K+oBuwwT6tizWUY8/2nwu6vIJKJEXxZkebSJ3KDpfS19
         Gt9FwG1vOBDJ4zolis7IR6RMdX5aVUAlYxxdvsTnbfaQ1dewG6/qvDHF9vN0DJqpL9Rp
         tu6s32WwImF+34aCm5B6kXjNBHDoVBHwQ5QP9OslYp81AheMOs9z33NC0ttTjT3XYvBo
         8o8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778008192; x=1778612992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6f5dGGeyzIZr/Pk0ZoSjwO9CpIcEaa4a+69NQ9afqU=;
        b=mvxXfJ6DPIdMtmEF4GCWwcPWSizeDTCL+EskQTmsJYfhXnKkXfJDT2yRsi6woiS346
         QtDu4fh90x5QD4111MTzP3WyjUNknLdGnxvMq4ERR6gRUXsyHLBTjm6c3LrhEEcRP4Fx
         bjUu8+n6UpxDz6U4Kh6M246QqWr71of4Egd5T1UTFGK58vo8MoIuyh0nU/0vDmhJ/PnK
         7lHvuXJLgEJE2/MLyMMhZbP/33tmn2mESRvU0kRHHs8ugjwfs0nB5SJBsNvv0e0ehAcs
         0QHBNnGEvrg+zB+strNjR/GXZzsEBY5fNsyP4GC6ObuMqeLEIMzCfYUa+wLL+a4MDC0s
         aicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778008192; x=1778612992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6f5dGGeyzIZr/Pk0ZoSjwO9CpIcEaa4a+69NQ9afqU=;
        b=QhJLk3PlMrwoaqvKrbKyrVm1TFvmw4MftiYqQkRuFG6v0MKgPEAFuUFPV/Bl1/m21y
         bwtPmVxkKUXfNgbrmNkhImZkWKNzLmkv5SrpMAxUlC7g+naYYM/NuFEZqkPNo41xmI3t
         jAf6RkFLJe+R02RuQ85Sbbnb8VOpSd7tbCEe2gZfAjjq63Oi3sPNRf8CweVJYh1udVfu
         3WPh2Q5sglgrx47d+biw116HE8b+/V9JJNVAQhFR5P6Sv7fpr9cyHS2yjqyuwqKYSOPA
         f3wmv2LqnmBq+FGEtyosDelrGMoVqc/wauD/ngWC18N2O9RTSymWp7gJfBovHyvzX3/o
         5Icw==
X-Forwarded-Encrypted: i=1; AFNElJ8mYZZH7E5zbfbEwifoJJUVia56iB1A2twm1QEeV95aSjOdAJlgyBl4WaS7ImoR0PhWlUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5UyeE75ALvsm+HoB9uygOECLueqhVyWKKLv7P0dfxEgdtTVC
	czmRiMRQhnhRctoi11Cx9aOytTdy9dVvK/fwMarmXcX0pd+GcNd3AvlYgghNxd5RkBVSfcmVCLn
	UAugV7DWnjSaKmoaW9IOpvSXK2h87Oyc=
X-Gm-Gg: AeBDievdO8nT2mO2SU5isISahvLwJEqfAVh1mf1n3pCxpff0UIiMYL/TRcvVyXk37w1
	6At0HqMml9D4QRETB8CpWwz8w06+zEGnyNwbBA5/2yQG8lgildKrDZfXMwMqxy0eNi6I6ghKopA
	7f9Ovv4yjbAHXVB/jQkG8q6dDg6FCTjBKY0ePP/7GYMti3relHX2ROwW1OBOFxhBqAR75Gqim3w
	fg2O/9nvgR1qunGr00rmYPxkF66Vq8idwUhtv0DkzYjTQ5BjuaH3A0T7CfQyhpCEZIOb0KrclwR
	RAhtGgqz58/lXF9sP8Rt9HJQDCoopMHtGNT36VS3meC1e2Sr
X-Received: by 2002:a05:6512:3c81:b0:5a7:4783:a13a with SMTP id
 2adb3069b0e04-5a887adfe0cmr13645e87.6.1778008192233; Tue, 05 May 2026
 12:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-1-kerneljasonxing@gmail.com> <7418a37b-1aff-4b48-80b9-012830e5f9aa@intel.com>
In-Reply-To: <7418a37b-1aff-4b48-80b9-012830e5f9aa@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:09:07 +0300
X-Gm-Features: AVHnY4Kmshfoum5z54jJolebXkA9r9-UGluPM9tCJdED7bWrAykrbXBKxnxoXaY
Message-ID: <CAL+tcoBQiEtYaeCECCPkOnWdHD1vGPYbtUEe+RVUPn1j6SEuHw@mail.gmail.com>
Subject: Re: [PATCH net v5 0/8] xsk: fix bugs around xsk skb allocation
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 6:45=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Sat,  2 May 2026 23:07:14 +0300
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > There are rare issues around xsk_build_skb(). Some of them
> > were founded by Sashiko[1][2].
>
> For the series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> Just don't forget to look at Sashiko's replies, I haven't looked deep
> into them, so can't say whether anything there makes sense.

Thanks for the review. I'm currently away from the keyboard because of
the long vacation. Now I'll handle them one by one in the following
two days. Hopefully, I can manage it today :P

Thanks,
Jason

>
> >
> > [1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing=
@gmail.com/
> > [2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing=
@gmail.com/
> >
> > ---
> > v5
> > Link: https://lore.kernel.org/all/20260424053816.27965-1-kerneljasonxin=
g@gmail.com/
> > 1. reword patch 3
> > 2. adjust the order of patch 6 that is now moved up to be patch 2)
> > 3. use helper in patch (Stan)
> >
> > v4
> > Link: https://lore.kernel.org/all/20260422033650.68457-1-kerneljasonxin=
g@gmail.com/
> > 1. fix 32-bit arch issue in patch 8 (Alexander && Maciej)
> > 2. add acked-by tags (Stan)
> >
> > v3
> > Link: https://lore.kernel.org/all/20260420082805.14844-1-kerneljasonxin=
g@gmail.com/
> > 1. use !xs->skb as the indicator of first frag in patch 3 (Stan)
> > 2. move init skb after it's allocated successfully, so patch 4,5,6 have
> >    been adjusted accordingly (Stan)
> > 3. do not support 32-bit arch (Stan)
> > 4. add acked-by tags (Stan)
> >
> > v2
> > Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxin=
g@gmail.com/#t
> > 1. add four patches spotted by sashiko to fix buggy pre-existing
> > behavior
> > 2. adjust the order of 8 patches.
> >
> >
> >
> > Jason Xing (8):
> >   xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
> >   xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
> >   xsk: handle NULL dereference of the skb without frags issue
> >   xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
> >   xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb(=
)
> >   xsk: avoid skb leak in XDP_TX_METADATA case
> >   xsk: fix xsk_addrs slab leak on multi-buffer error path
> >   xsk: fix u64 descriptor address truncation on 32-bit architectures
> >
> >  net/xdp/xsk.c           | 115 ++++++++++++++++++++++++++--------------
> >  net/xdp/xsk_buff_pool.c |   3 ++
> >  2 files changed, 77 insertions(+), 41 deletions(-)
>
> Thanks,
> Olek
