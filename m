Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE63090C6
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226579; cv=pass; b=UHCw+jKy7bijhqxcRn14X70G5acmRkx2WLIswvK5tnVWUyfgWJl6dUU7vVxeOEZw+KZF1B+Go8ZLJ7UkkJrn2GAy84JxoWsbGSuTo1woL92hzSsUHliNxZbRwKMk+IDiIK7KNL8OzmiQSwagS+FGAjHAPKTHpFBqbA5JeYdc+uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226579; c=relaxed/simple;
	bh=9gi2TnyLTtIq3LPG+G/+Ly7DV11ab410M+WEj0lWYhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeJL39IlETVpXz1lYhddyOAynMKwszjg+yzwPLVI2veT1XPtZnJyCU1zShtfF2w67X5RYw4XBqjKSIdnrA/c4nELBglWOsfVcC4Ar/kDYAu5NbRX2d/iz4AyhBOAEZQm9qrHvM25dGJjuhmAcmglNMLpIyp+X0SPZdviWmTcUTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoMITiJO; arc=pass smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoMITiJO"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7efac480dc6so4148947b3.2
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781226576; cv=none;
        d=google.com; s=arc-20240605;
        b=Sv3waljFvOjrVT6D8/nKDklPbfJ/BYOjd5PgiJUTEE+ZO4EyGNqeKyp2DTW92SXG2o
         2jNclm94+yUhIBaRbfYF8SxuESFeAeHMqR6RrhEBo17KV7n4TJwf3+lqRXHqDwtH1LLI
         qYHD6Dis6wSl5mmwYvb+nZ5HTP4JuDnR7K2iauWuIlTa3VGal/PrqdcOKJoQoJ6Fr5zT
         gLh8A57vSPErWvnPW724h2ubrLzTOzb4+kH+lA2/u6db2Z+daeUxCg/wLYSJlxlqz6lW
         uuzECa4XV21SiL/5aiocwf7+3z+cKGKAnoKxfkkUnuL1HU5TwH4Qts/x576YZ0Z5whqU
         SGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        fh=58vWo/0S4wV7hqLiRYqP/uFZKDxydYGdJAnl+Eobsbc=;
        b=Op7yphXNXCR04EYX0O1BcIgqddw+3RUzi1ho8DrW/ozpZ9au4leqq5CV2F7pqPOc7P
         ixYLaqgGbGSWnLsMe5R5ktBZMA3BhE5qhszUlklCm+N6YFBDLxXFPcSXx0m5sFg2llv2
         +2OjeXV/Wx1vPx/oD63Y1jZ1dhi8pTaeNyq5oVzXaQCjKiQIZPnDiUjcR1eIxaqriKMB
         eX6knLwgpleJdDt63TXJo02zldy7V5aNi0I8f8bp0ssnzSDkOrjYK1T7PuyAzDNtKFVE
         s2ivyys/UMJOb0L3ePhR6CNGFW7y9AwrMktrZkhUgwpj1dQ/CWGfBmdy6x9M20/8r9lS
         EJkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226576; x=1781831376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        b=HoMITiJOeAjZWLDIRpHf4JkHIMjvzp213v8BBhbfEyog5/dTD3TwNqE9rzn5op+cih
         jMr0LjEOPB11k7ZzAlYjZZgUEHuZMjuhTEV0+TWX/eX3a4lBHWGiqf7XIFi1THBX4m5i
         O2R0U5lStbEXFBKp5JCV8Lm/MMASI7qAr5H4ey/Je6B9xEvjxCXjRSD/dm+BwRZ6VTUH
         wMjJtXFkxD0YXO0wfBqmm7BGMMvGePNll5/d/mfozzMTJanE9LQzBGXFCjRaQ0rGNyEv
         9SaPH+p+A80MF92owNPppm05ngz3CBHwKC/fyJHeZgV0AkKt+hDQWkX7I+6ocTxipkoV
         kprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226576; x=1781831376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        b=Amg1q46YIuNjxx6AeLgSzXGeIyhoXc2aNm2DWUv46vWrP5ZZd/6lnQWkWNhXhp03gi
         XT4nh5q7Gi4yuDcGzpO+To65tvXdhXTK4ckHCB8mlxdVUxiol53YQrDWBpvZOvmw/LDn
         iRZsqMYS8uCuwSor7lrpM1hQS4EVjE2DJCU6mf4xXkRKo6Md/E8oLJyYrQJgW/VFFBnx
         GQ7fbcau/npVplGrXPC50gaVEcJ+77eojhkRC21FoZavfaWI+0UMeYTbIxAzKDGR72gC
         gOswmcoNulouwFQHuyDv/zroaPWIratla+aGX2x2Hpg6SsW26BVRtr82z9bZ4XtxZX1P
         tZiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vRc4Moubc72Y4DStKOUPisfo5f5WkMYlqGyRmN2CLFkLc5x9iWEHGal+bCxZzwctrMjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnL8UgYk8COp1yLDTMqmLUkvLs7GPWAHY/l/kbtzgYAYXhFRR
	5SuSFzHczM/1SCM9TS2fdSPV34e2TnIDhrU8bmpYUvilbQMGnM3DxUDuVC6vQbL6nBMFXb+XHCI
	mbRbJZR7fmwNzlhpPk8XWseIwjRAtshc=
X-Gm-Gg: Acq92OFxcUL2R5ucQXZfAj6ADA8xVjZpGc7mI9/yYdZRq9iF/WigVAy9N+dXX0HRA5Q
	tgt1y5tdjdhIxETWiyis4EUVdBoGSMCuvWIWOI9/wfsDpAGY2xBiptDl1kaaa6kyOxp4K8z/qmn
	7v9R+Zp0IL5FCHXp7xJEMUyCshAuIjsnm8ZaaLmvGDGIofOvZrubcr8azOfGnUzCljMAhQIMDii
	mJkUbF5O3J1wgvrbwLJKTs/AheVGshDqtEd8Bo4wqbWqoqWH31oNS90tZFn14kW2jOFsOeQgNWc
	wQKfCn+7Eg==
X-Received: by 2002:a05:690c:63c2:b0:7dc:7ccb:33a1 with SMTP id
 00721157ae682-7f7b862ebbbmr7194657b3.23.1781226576049; Thu, 11 Jun 2026
 18:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn> <aisBEUmSJa1vkFYo@boxer>
In-Reply-To: <aisBEUmSJa1vkFYo@boxer>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 12 Jun 2026 09:09:39 +0800
X-Gm-Features: AVVi8Cem7Z_iAE0cAcLpfhNtsEYe4ISMI5m8TQRa6PlH_Zbru4XArHRge9Hviwk
Message-ID: <CADxym3Y_2NPr0ktHxdgh6NKd4xnoq8TrMYG=QRMdhm9g2Q1zwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] xsk: support tx napi busy_poll
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bjorn@kernel.org, kerneljasonxing@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:40=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jun 11, 2026 at 03:12:39PM +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > For now, we use sk_busy_loop() in __xsk_sendmsg() to send the data in t=
x
> > ring. The sk_busy_loop() will poll on the target NAPI. However, for the
> > nic driver that support the tx napi, such as virtio-net, it can't sched=
ule
> > the tx NAPI, but only the rx NAPI. If we enable the busy_poll for xsk a=
nd
> > use virtio-net, we can't send data, as the rx NAPI in virtio-net doesn'=
t
> > handle the packet sending.
>
> Am I reading this right that you decided to break busy-poll support for
> zero-copy drivers that happen to handle transmit side from Rx NAPI contex=
t
> in favor of supporting virtio-net?

Oh, nop. This series only has an impact for virtio-net. For the other
driver, the logic doesn't change.

I added a "tx_napi" field to struct nap_struct. For now, only virtio-net
will initialize it, as only virtio-net has the "tx napi".

In __napi_busy_loop(), we will use the napi->tx_napi, if it is not NULL
and we are in the tx code path(sk_tx_busy_loop), instead of napi.

Thanks!
Menglong Dong

>
> >
> > Fix this by introduce the sk_tx_busy_loop(), which will poll on the tx
> > NAPI if available. To get the tx NAPI from the napi_id, we add the
> > "tx_napi" field to napi_struct, which is ugly :/
> >
> > Another choice is to call virtnet_xsk_xmit() in virtnet_poll() too. But
> > this a little contradict the design of tx NAPI.
> >
> > Menglong Dong (3):
> >   net: busy-poll: introduce sk_tx_busy_loop()
> >   virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
> >   xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()
> >
> >  drivers/net/virtio_net.c  |  1 +
> >  include/linux/netdevice.h |  1 +
> >  include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
> >  net/core/dev.c            | 23 +++++-----------------
> >  net/xdp/xsk.c             |  2 +-
> >  5 files changed, 46 insertions(+), 22 deletions(-)
> >
> > --
> > 2.54.0
> >
