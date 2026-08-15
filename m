Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F81D798E
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786762538; cv=pass; b=rN/wd5Z2egs0X5xVmyvi2XmcrP2ffwX12C+//Suk9P21fnXGDWzAUGPU0HXqbQJMXUGSIwO0dWU1ZUrlzudqhDQjxwPpBGFJ0dFKfQN+bfbIbydRUuGmYmm67c+U/hMN9LloLZJZzsYG5BTtobyTOVVi8/xhpedrOFzzrmKvax4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786762538; c=relaxed/simple;
	bh=Fx8jpcriAtMOORqEdmHYz+cT8ZtXqnCKp7LKXe/56PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mxszl9u0qt9phdoYRoWOI+K4HxC/eeEKtEjvdPFFfOHNarvrbi8duLN7nfmV2LNqCP4O8i8cosF0LCOIpctV7TLjDMm5yQ2atf5knE2RceB4LKw1BkIrhDqVoJ1y9hDnbcMLEgN1EbT/O4KkR8xdepC0rmuPG8is/2gT8QZGm44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCSUjx9z; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCSUjx9z"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1138515a91.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 19:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786762537; cv=none;
        d=google.com; s=arc-20260327;
        b=ZckB8yy4U/vCf8AOLXIjZQQ/WMF/xIGWMwS5CoPosNAPwSC04BkXPAbHKfhmYl7VDI
         mwzvZhxEkfpcP3+7Wvu7v5AMKfhsu7Ne/ZM7cHJJ2J3D9fEPKrBCKKLQJiZ454JeUaMo
         S243ilNIh8tiJspCIBKxznSvNeXpsRiVcslgfjj4Qi9ZmAJjWCWBY0wVMOF9xweLqqeO
         ta4b8i3PItW7Gaq96Dl7TrZ8LAXr4CTed9pRbTz1whD6nqmCoiisQZMSx5kSxp4gqqv4
         f/vfIW2mxU0i6UIOn64O8OOrcmk5HoiADGWrKRCXyVwKI61cozkUNQOid9eCno1Vf2id
         cHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPaZxMbqLEnlS6J9v9E+TEXvf9o4iRcf1Qh32ca3bM8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ApG6wg8rQlNxw//QVZ0xwEgINb/3EyQl/KcxPUSHyL34qZoOjwur7Cy0+KGlvjlJq9
         8wlFdTU54H39DTAcgWdglDDPIJHgJO351dw8jw/rQ1M2Dfuu0zj7xPxAaKmmbxUo5+c1
         UFxN4wr42uZinhTkIic8OtmXlPAloWkitYa/vRkyJyfRhRQFcDmIGyTdspfK3sAdbV13
         YSQuzBwNdSWICeJZMlu4tKsPQvKjgZDi1QV/1gPa+z58kRBoijF6zrTBzeH259AK9A6x
         9j+xCCXS/z97utSt72oSwH4N97HvBblejC+9sdu82u+uoo4YX8EHSQ0KuNrXhWzMreDy
         6nxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786762537; x=1787367337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VPaZxMbqLEnlS6J9v9E+TEXvf9o4iRcf1Qh32ca3bM8=;
        b=kCSUjx9zn1Ef+Bb1iCgl1iYF3wUfMhAwssVkWJPwR1KWozbYllpCJV7W3xoVcWPvpS
         sM7a5vHw+9WDcvls1KaTd/HEkHd63VSOSECvdnEerezFTs8NbV1zNUx1gmLCgzeDFepg
         YwdFw1Q0RpURSgjjpouKaCASU57ZJ72HPnCDQGMkx9ccNiQj8twtSouU64eKjRchrsWT
         ksKaAPvBMsLqaDZYZuxlDoMNp3INmBSVUmMvHPy8J22ACtGEVeSGsltYidqpAfZNGknY
         pkFnX3dhAyg5unlIgk0+Mr+4L0IPjZ9nOVB1Im4job4z6KomkNiGUk7Eps+OC0JVkzXU
         Q8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786762537; x=1787367337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPaZxMbqLEnlS6J9v9E+TEXvf9o4iRcf1Qh32ca3bM8=;
        b=nuNH1NRcM8Z7xHNtTqvALaxfp67y5/6Z9WUw7OBfC8um/yr/wAes6TZEoGAkEvZ3Lo
         YHnMnIzqFP+OIjoferm4PWTkmIKb9RuYtGMzmGYKJLNMOjK+nkoxjNSRLg/13L/DQnme
         FdYvA2G6AFJSfmzVmRcU9UjQBMOjuwcor1yLnq0ckxEw6Bfo3zRMn4oWrKWn4bWwf9yS
         MO75cdWPDNmeX4Aty/Ppb3kWKc+QWu76KtfSflmW6ugpfPsZO+O/HhNMdjhv9PuLDs2s
         BDfFyd8WTdfSZKxbO1m99ajORTZ+ezdmZsWmOiTAofxq8jLyOt6gBJIQpFJQI0KdVc4C
         As5Q==
X-Gm-Message-State: AOJu0YwyOu2Lor9DVnqJ8p0RRt+ilNFkdJPCy9D8XXQggv2Cu/RtJgP0
	ehTXslz8qWGVBksPOt5RFpPyIHJfSwUJ4Xtf1UXblTrbh6TaTCfMrSgMfkjfg06e5segvCwrzMl
	ba5pxu4Au3pWIFq++xWR4RqpcBTWtQTrmKq55
X-Gm-Gg: AR+sD12XWwfIwjWJNvTxYgT8z4Lv/flvUzZiQLMZkPFC9b8SE1MWfSnI85PZJ4RsJ89
	CogambWTT2s04fQoduvNlqTxy38Ni5yhd2y58cfbUoNceDNVL807EH0B+aTMahtfhG5PupXmoHp
	emx1GqxzvkvYGmHla74fBgRJE88ca2yKYxbn8xmTSL9DFj/MJ/OqS7znaHsBPVAz79tEUf/QPGZ
	g5zZ/EvJU1w53k4PlGAq4+CTD7a7RmVquMBuC5h4/8R+JWtyyLpmxDPMS4ov3pOxJcHX1kSIYqJ
	9KbO1flGnbYuNLeJ/jmcpiHMbQCfKzDDiqJbsN3DYs72FuE=
X-Received: by 2002:a17:90b:38d1:b0:38e:4e61:c9e with SMTP id
 98e67ed59e1d1-3933b168bbfmr6998267a91.21.1786762536518; Fri, 14 Aug 2026
 19:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-net-netdevsim-v1-1-521a85e4fe91@gmail.com> <20260812140235.8AC2B1F000E9@smtp.kernel.org>
In-Reply-To: <20260812140235.8AC2B1F000E9@smtp.kernel.org>
From: Subasri S <subasris1210@gmail.com>
Date: Sat, 15 Aug 2026 08:25:24 +0530
X-Gm-Features: AcwNN1UFV3hM3RwZUnTxCyjKPBWwLWgg9-4fTDT5T6kLa1MmJrERw0zuW5mD6Ls
Message-ID: <CABfayGNZF553ZW=QoSkwA8YtRoDAQ5RP=MGyGXEbzbegYBN10w@mail.gmail.com>
Subject: Re: [PATCH] netdevsim: update rxq->napi pointer during queue reset
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 7:32=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> Earlier in this function (nsim_queue_start), there is an early return
> for rq_reset_mode =3D=3D 1 that bypasses the new restoration code:
>
> drivers/net/netdevsim/netdev.c:nsim_queue_start() {
>         ...
>         if (ns->rq_reset_mode =3D=3D 1) {
>                 ns->rq[idx]->page_pool =3D qmem->pp;
>                 napi_enable_locked(&ns->rq[idx]->napi);
>                 return 0;
>         }
>         ...
> }
>
> Does this skip restoring rxq->napi, leaving it NULL and preventing XSK bu=
sy
> polling from working after a reset in mode 1?

Yes, I missed to handle the case when reset mode is 1. Sent a v2 patch fixi=
ng
this - https://lore.kernel.org/netdev/20260815-net-netdevsim-v2-1-d6c85c515=
7a7@gmail.com/
