Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794217146;
	b=G/fCS8JNEbpIc1jiu2S50CB9luFwekBZMEGro3Tzb1qxrS29jipItHK5j4YnKUh9ocLx
	 radNIw6L0dwXXM1bSkSGzgP4xifXjpBdrmQpo0w+5b4Ovr2EonrxhedlUJRmhCANIY8vG
	 IW/Rz3vtF0sKhJzmsR7x6nExeSShuTazEpQsUsAMESQ1q7utd6KE8TUA1wO5Ma0oRHSqt
	 eiQw8JYUYbA2mSldt25lFgODJjfhSlnJnAPpq1s/0mOy3EQtx1Lt2NJWgqYkfm3d8W4o0
	 DJ17uToaD0Enff4+ygNxhRqG7K9s73FdDDjkYOWxx/tSBp8t4MJ+mAxHc4TDs7SdG2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
	b=4zT8caF7EE1oPR6nmtlBcufssiN7PTUTJahiw4ImHzeJp2UkQmZmZLlpi5UFBiAdinXa
	 t/17zzZ6hKIVtbDmm7/9kUmARd3UCRII5QQbzBkbzSdyQPsX26TLqDVsdTeLzELxok05b
	 k2+xgPnDNkLZWEMo7VWP4zfMgO18l/R/e7kwraSH3ALT3DqX7cskcPevn5/1jkf+k+Sol
	 ZX47JS5IUwyMHQzyKTDsW9/rOEQGFSQB4PpYLc+LOCkS5XOajzhJ9ysBSF0Yy2qjdmc5V
	 BEbqrZOFM6SiNwcO5zmcRfELBP9vcF1fftl60xaAeG/1XI7ahZ9PAp/YQvFkoJysD/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ez/Z55b0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985D606A323
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 09:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0985D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ez/Z55b0
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4ad5b52f0a7so439930fac.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 01:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217145; cv=none;
        d=google.com; s=arc-20260327;
        b=sKkUnnEXxhDulSwDFO7ZYGAD01hz2Ks7rOxYFD8sxyueYEBEdK0+dOQOaUQI4QRS0+
         X9N7I1Ton1RM3Aoo9G9njMscnY3mf3gs+szXGOuDKYT4zxsNiI5w1fIb0cYP2W1DDyu3
         8uxDFYIi29rTyx7seyHPGCCtefHPpstcwfJ3w4vDhZnltfj/C+rc6fWF2la7ef0JgfaP
         /mCOs7AQpEEWtBSMyEc7JKw5KDrtWxGJ/kOuarnvKJz8YYzG4UocIs6QNrd93WKdav2h
         pg7qU+vioKMh8lnCe+/y1gq9wmH3adt2kpN7ZEjFomclOuD9bZxV2G22VHjA8dWD7LyO
         tVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        fh=OdB2oufQ+acfXl/PRNVyLdamfs/v8PFpdgRxoK3B/6A=;
        b=MBu8R/z1GAeteRKYY1Fi4W9KvydWkBLI93MiZucnupnCZD8THWMs344Xvfl3G35bc1
         mOD4HUS/s4QFoim+Cc9ESYkDtY2EVpCX1M4WiVClW7KLCwJwUI6HjTpTXSJ397mNhf3x
         GSBuofxId0QNXtCvBCeAcXwItavLNfhgpopQnLNSd2+DV5V77HiPDnTgAC8TJEpnenOc
         hVBEfCTeCMROIOrnlFD54OeAwgNxFpr9ECmd/P85cEebFloDox4uwidHl9zhUwUcbgyQ
         PqALfqG6/9lIQIxC2VIfD3FvwISW4kgGE4ETb0fg0KQiduD9fCyRAabo7W986iqE6ZcT
         6HpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217145; x=1794821945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        b=Ez/Z55b0uswFCCrOov466Vti5izMG1v2RfIprz1liD212lvlAPN/9oxAdWhDg8/HNo
         hRWSJkAfaoWCJV9ylz1pMAI4Im1eai8Bz2J7SNqnmNttW4mOzZXW/RNk5dwQcwPU18q2
         75/965pmobYanJrT/00PyCd01etzF7VJNN5PdoYALtWwGKJ7yf4bGFy01E6aOM4G9vJX
         PWCB2pPCGQ5kmudjm2rrRMbIBGZ3X/Q+hh0qoTWNhHgH3sg2OKQ1J9mkXdeR0soyUnUT
         oK4d4EoG2w6Fti24nb/9i+6XfjKQSiMsQJZ2EKY2yg41a89atwJ6KA/NBWy/R6jeI/mN
         9zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217145; x=1794821945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bt2kTkjGKfcd8zMvx1shHZytI48P75SXp34GvUI4/fg=;
        b=a7eppw8PtE/uoV5sX/O9VfYT/RharV6g29BjHC9n6Z52YShk4aGe87+19wn5NJaY9y
         H0Dbfk27lgjX+aHcnBu+HBG932fStjBsRzAAoXdAbmjSRfjLQAledNwFVdd9NFC1fzfw
         jO7UjkjMMX+Kc/WGT2SsPn0GaxH+Z/nynWsnzYyZwi4A67TIiTAF+0W/HXIRlnd3NTLV
         cPxvBbL0nTsRv01wf1YBLYVEoNmNNyflmaa4s0FgrUOz3wFEkf40u01CJ+muirKaQEJZ
         xufhHzpmW4rZoe1jH6SQlUoAFEVsvMbyhaJ9I1/bt6E2k2Wqe4lU/H4+qAQPuD/vzbS+
         Pgyw==
X-Forwarded-Encrypted: i=1; AL+hErHJ1BmXcNLwx/tDbYWJH555BxOUzbsxDEmXdYZnvPzHpG5YrpjNJu3ft57/MDnT5LX6IgE=@vger.kernel.org
X-Gm-Message-State: APuU4Z862cXJzlxMN70rcIO23jNE0HqFcozixCFGdJb22uyMwT2pJgOz
	+H4RJQBqkrO/hHe2nvH/+Zgwf4t4s3oT27Q9uvHCgMZZdWgyn0PndCS3XkhDflK5Zy2PnRpqPvd
	QfQ2c9WsVQv4kFF9CLu6IVryhS8x70uw=
X-Gm-Gg: AYBFou3F7VXAQbWhGEdjgFxnpg9VDPTyfFlr03H8clEZw7AGx0EQEdfwNKricQ4GLxZ
	Jmj2SMXFl9ZJgKvjmKc1nCutZcnVR9uOSnp3OzOIHFeL4BtPS+wZGigBpkA8GHyGD6mfOhAbcfY
	JN735jGec9Z+x+6IMC0VqzreU6O6DRoNyxdZAosyASPuJu7mn6U3KbMgYldDxfDvQKO1CxClONJ
	wQN2Vs0DBcz5InOpNAzj4nMHMe6okwRipvNccSexDu3H9dlUHOWska42x1QYF16gPoWjKBxlUYS
	B2a5dBQJAEeCtlYUQ4yByKsgUev0nOhA/HfjOoeVTg05JMAGsiZyDsWz9vtWc25PEGbJybnUq9S
	nuxvkX+zLdWaJrdPuXdMtH4h0U8AA6zpTnbE6HdQBoeSYD8mHF8ATpiS7LcOMlMmtrVD+PfjEnv
	qIGs9pzHnX8rKGgw==
X-Received: by 2002:a05:6871:b09:b0:499:c554:b635 with SMTP id
 586e51a60fabf-4adec9a0521mr1832827fac.28.1794217144641; Mon, 09 Nov 2026
 01:39:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106114551.212675-1-amaan.cheval@gmail.com>
 <20261106114551.212675-2-amaan.cheval@gmail.com> <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
In-Reply-To: <CALuQH+VtASWP=w9ibTJ7ioYxWrS5sgi9yCZMVK0D831_A-zusw@mail.gmail.com>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Mon, 9 Nov 2026 15:08:53 +0530
X-Gm-Features: AclHuK8ZY94zA-0byUQ__DrC9NeVtoJKfHv6SKapSVwO8ABChRUHJeGPjboSxYY
Message-ID: <CAG+wEg3VCFnPMkkXVLBNgSNra2YBSZAM-Q--AEQvA597z7X5MA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
To: Joshua Washington <joshwash@google.com>
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

On Sat, Nov 7, 2026 at 8:43=E2=80=AFAM Joshua Washington <joshwash@google.c=
om> wrote:
>
> On Fri, Nov 6, 2026 at 3:46=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.c=
om> wrote:
> >
> > Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> > RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> > verify_xdp_configuration(), which until then refused every format but
> > GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
> > advertises no XDP features there and gve_xdp_xmit() rejects it, but the
> > core only checks that ndo_bpf exists, so a native XDP program, and an
> > AF_XDP socket on top of it, can still be attached on DQO-QPL.
> >
> > The DQO-QPL RX path was never written for that. Its page accounting
> > assumes the driver keeps a reference of its own across every handoff:
> > gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> > recycles it with gve_reuse_buffer(), so a redirect target that releases
> > the buffer synchronously, such as an AF_XDP socket in copy mode, can
> > drop the page's last reference when pagecnt_bias runs out. The page is
> > then freed while it is still DMA-mapped and registered in the QPL, and
> > the driver posts it back to the device.
> >
> > Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
> > matching the features the driver advertises. A zero-copy XSK pool bind
> > is already refused by the core for the same reason, and a copy-mode
> > bind never reaches the driver and is harmless without a program.
> >
> > Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ R=
DA")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba633..4e9e692a0ed0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct n=
et_device *dev,
> >         struct gve_priv *priv =3D netdev_priv(dev);
> >         u16 max_xdp_mtu;
> >
> > +       if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {
>
> Thanks for implementing this!
>
> Minor suggestion: Can we check based on dev->xdp_features
> (NETDEV_XDP_ACT_BASIC) instead?

Thank you, yes, I'll respin.

>
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                                  "XDP is not supported in DQO QPL que=
ue format.");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         if (dev->features & NETIF_F_GRO_HW) {
> >                 NL_SET_ERR_MSG_MOD(extack,
> >                                    "XDP is not supported when HW-GRO is=
 on.");
> > --
> > 2.47.3
> >
