Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46D3F39DD
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691592; cv=pass; b=ot/Nfk6NysUL2O3eB3kBkRR2NLUgva0URWVRxXsnZMbPtyBcrvWGoho2n1JpGiDhcHGjG2sSjJCiRj8nznab60kDWC4pU0IcAnU3QcpgHfdZjK0s4rsY2YG+BIrKwO0Bk6ClJFpAokjyBNvzlRECWs3zQoplLTRCUTREarw6y6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691592; c=relaxed/simple;
	bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/i0ZJh6aiBM+dz2r5aOezpvfxrZAYfFNjAPEPIowiAQZqzaGoPRssGl5zlk5n58ZaHKyKc4CdM2MzHheamBEwQYNiPlDDPZXCQqmtOBwRGZYfvDgVS18NUV9vJrAALdxn/pcSrP3tmV8kIwoGtvcpGvm4NGippivLgvLC2DiS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8I2x0be; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8I2x0be"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad4c0c94fbso130398e87.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 03:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781691584; cv=none;
        d=google.com; s=arc-20240605;
        b=ELfOD3hxsjBxcHmb4/o8uDnfwTZZomKj3DIow0dTtwODAk3rGrWXReCt6HULJdgEx2
         uUwqXReDP7j2NAMy5H+1h7o/VudnhyYQcRP9gIVJZfNMyOrr/LN4NtpW4nP4aLPxp3Qh
         b3bFF0X9s3DbZDFUMW231fflCyKBjb/xLK5po4yiPdui1DtKBUSCx5pFPfgQMZa3arvv
         IXX0IXVLriDJ3er1CNW/zbN7F77Hwk+Tty47p+zvquLHHtBoG4EYGg8UIgYuQyzkuap/
         jNLfvzzgayHReirCncIJXf5iOkGOjxG0yZcNFpMLBHbsCELpgasj53ByY+lFq6tpwf1N
         okMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        fh=iHI0X28YX9+K4q4FbgK7S5nyto7Hk6ldOp2pCFIPFg4=;
        b=C2kSyNcOlg/r5nx6VhZChjTk51hc+6Qop0BQxzE9z5nG1xgZ2mxOgQCYM9jfUz3bPH
         GqyHhP3sK6IVbh1eEFmHn8pw+5J4neVqOOaMyup5q2XsZO+f1LILvJcyotffql67mUUG
         XVrP8d7uQNnuNEq8AfWBIV9Grg1rulvE6axyx/JFxQ2n4fLqh1JvfXqYA1JS7Exx0K71
         H2LV3SZZaHg3QhU/THXdrAtt8Q2hAouK0XWHV1+rIrZ2Hb3a8D45xcZoTfON7OQrd0EM
         TKCWn2QBfTlRZo5yK/AKDFTgJwLAN7JigNG8kw07NKaoJXOnPz/XIGrUjT7aferdBW4T
         W2sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781691584; x=1782296384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        b=m8I2x0beRrfR12co+e+px7vvMJ9czl1/uz3hO2DUXg4V63FWr/bkrD2yJPMvo2KjBI
         jBcBJc1DWL9AOcQ7sPZEYtRPMFgcA1xVL6jyqp3rbr7dFSvMr7DzfjPg63c1NQNBLPt/
         mE6dxI3I5fxSfxdmibcV7pefz4Pk28xTKRZQSxG2U1bpFZUTUrZwjJcUkBRAk/O8UFVg
         JpqWATDcRpqRPdhXq1X3TTKzLlfFjf0h1tGqKZY7wU8dg62iJRUfY3N6vqKKS8xyaD/H
         nRKFGtY6Il2ZJPIky23EMUAoS8KOBDzHwH3ndQSI5Egsw5WYarRSNrDGim9jX4JAx8cp
         ZdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691584; x=1782296384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        b=G+Kbol4VYzqu/jYDF6ugooCfllPyAT4+b24W2kJ07/qTK+6W1GXugrlXWkn4G+CXGm
         g2Dryzx7WbqewICkTbH3d7UdRxW8sNomREub68BhMQBm9rB5EXHYWGnNgC6lYykK/w1j
         rv0/ClT4ZIgtG9MrV0tUwWH7Rwmdu0t+DoqbMntXrZTeHBgx/GaqToD8BUnHB1Gj+3P6
         xqpOYP5shpw1rn4M4GwuiAIOHG9u5D+oqTZbO6pFfWuZj1k1tibHYXyxdSac8rU2Om5n
         josczcrwxTGfl8QaCUIABeL6Kvl6pJ67E2nN470nTwOACdP1kQD4ywclxLFL+zMuPorg
         ONCA==
X-Forwarded-Encrypted: i=1; AFNElJ8c/CZPvs12jcpbipq9p7zj3agt6hHsugcN9N/9GU90loFJVnZ6Ocw2M+FZa7N81Lr0ln0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSIaO5M5HBjOkuJBv49cFPriYTdwmaGfclldJfqdeKf44a3Dl
	OVCQNGA0K4ZOlQoaBwCWF3WuYIv2fsPAH6PHJZKsFSBHqDdRlsM1SlEtp3v9N9Sd52HkEEaFF3Q
	onY5FsdKKjmTfexUa8LiOyKlG38JmMTk=
X-Gm-Gg: AfdE7cm0E9E5oL6VbwNVA8IB5dKchY06MiH5HAnJ9hqSTXNXg5y9lnTsT6rgNNhdI6L
	Tf87WgyU9BsZy4JiwyGua+HgaMXNF+gF9B+0j8bn8TwhTposZ8s32hwklIg6GWyQCkskkjpxkKu
	n8Si8g2QIgy1/Bm9F99IpALvha/K/CGIE7SjQoSQDitKV/2/Q+CheHI1l6W5y1YRgmAe5AxYl6o
	6gEJCH6aPynHyf6xNME7aekBj67AQVVlbSDS/RbkJ8K4ct3aESOLbCQJZOzKeVp12nYX0jfK2oB
	WQquQq6MNOamVeOHeHXdsSrUCQjO+5CjEIyQIeVWsN0RdJLeu5zxiR/bg2PUjePLuNLs8A4P+is
	XVZboSqMh/AI=
X-Received: by 2002:a05:6512:1c8:b0:5a8:86a6:c476 with SMTP id
 2adb3069b0e04-5ad470467a4mr663270e87.37.1781691584047; Wed, 17 Jun 2026
 03:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn> <20260613112113.55d9313f@kernel.org>
 <TYn10tJ2SIGF1pAhF26DRQ@linux.dev> <ajJrckiXEUztBQDz@boxer>
In-Reply-To: <ajJrckiXEUztBQDz@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Jun 2026 18:19:06 +0800
X-Gm-Features: AVVi8Ccr6U6gFua-s95uJJAy8Eyxi9pGTjbRb0f81lrrSkjCY3B3t1Mt-CCv8VE
Message-ID: <CAL+tcoCcrJdynuBqrntDGK_OMSkKkQB9XeoUAC5ig-1_mVjaeQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, menglong8.dong@gmail.com, 
	Jakub Kicinski <kuba@kernel.org>, jasowang@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bjorn@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 5:40=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> > On 2026/6/14 02:21, Jakub Kicinski wrote:
> > > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> > > > For now, we use sk_busy_loop() for both rx and tx path. The sk_busy=
_loop()
> > > > will call napi_busy_loop() for the specified napi_id. However, some
> > > > nic drivers have tx napi, such as virtio-net. In this case, sk_busy=
_loop()
> > > > doesn't work, as it can only schedule the NAPI for the rx queue.
> > > >
> > > > Therefore, introduce sk_tx_busy_loop() for the nic drivers that sup=
port tx
> > > > napi, which will schedule the tx napi if available.
> > >
> > > First, I thought the only difference with Tx NAPI is that it can't be
> > > busy polled. So if you want to poll an instance don't register it as
> > > a Tx one instead of adding all this "tx polling" stuff in the core?
> >
> > I see. Register the tx NAPI with netif_napi_add_config() allow us
> > busy poll it. But we still have two NAPI instance: rx NAPI and tx NAPI.
> > sk_busy_loop() can only busy poll on one of them.
> >
> > Before AF_XDP, we don't have the need to send packet via tx NAPI, which
> > means that we don't need to busy poll it.
> >
> > I analyst some nic drivers on the implement of AF_XDP. Some of them
> > will check xsk tx ring of current queue and send the data in it in the
> > rx NAPI, such as mlx5. Some of them will allocate a extra "rxtx" NAPI
> > for the AF_XDP zero-copy queue, which will poll both the data receiving
> > and sending.
> >
> > In the case about, they will do the data sending and receiving for the
> > AF_XDP in a single NAPI instance.
> >
> > However, some driver receiving the data in rx NAPI and send data in
> > tx NAPI for AF_XDP. In this case, we can't use sk_busy_loop() for both
> > rx path and tx path, as we need to wake different NAPI instance.
> >
> > >
> > > Second, can this problem happen for any other NIC or is it purely
> > > an artifact of virtio's delayed Tx completion handling?
> >
> > According to my analysis, only virtio-net and ICSSG driver have
> > split NAPI for AF_XDP. I don't have a ICSSG nic, but the codex tell
> > me that it does have the same problem.
> >
> > I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
> > Maybe we can modify the driver instead by using the same NAPI
> > for both data sending and receiving, just like others do. The
> > advantage of introduce sk_tx_busy_loop() is that we can split the
> > data sending and receiving, which maybe more efficient.
>
> Would be good if you back your changes by any performance numbers. I
> believe that drivers do tx processing via rx napi as before AF_XDP it was
> only about cleaning up writebacks, AF_XDP added more weight via actual tx
> descriptors submission.
>
> Maybe you can vibe-code virtio-net to work only with rx napi and see what
> are the results.
>
> Side note/question - Do you have a tx-only use case for AF_XDP ? I am
> planning (for a long time actually) to implement asymmetric AF_XDP
> sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
> queues even when you do rx or tx only.

As far as I know, since I use TCP as the userspace protocol, I don't
have any idea on how we can apply this. It seems you've got the
requirement in the real world? Interesting.

Thanks,
Jason

>
> >
> > >
> > > Third, this series does not apply.
> >
> > Ah, I'll rebase this series if a V2 is acceptable.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > >
> >
> >
> >
> >
