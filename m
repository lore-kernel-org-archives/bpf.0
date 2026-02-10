Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D02319871
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724368; cv=none; b=AmiI7hGPJHSh08sn0gme9h5tJnfJL7GEtxfVyVo8qucQNTYg3kT1IVdPhLSxpxvVBj2QfCV5KXNc4vsdt0iXNuyeN8dg8a+6BKV+fUeEQTlrEABYsIPrnR9nGp1SrF78FGK9FSQX2RMogOZ9fsBQUGl6iZr12vKr7j9IJKNMKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724368; c=relaxed/simple;
	bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxyYSfQGXaCdFMVnF/ehUKuqyqUa1o2JHQFEDvYG4smj7f20Dv9FCnSHuBQXlruMCM30xrADw9ixzQa5A9Sqat8xuxow6vMKFvM/+gAwIyQYF+iLMntjUcV9DFRapaN9DMTaNQ9reBKtnarMEna6XwKTAOMDa+HFoGF61F1Pjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxMs56+I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gz0EstAj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxMs56+I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz0EstAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
	b=FxMs56+IYy0x++MJK53VPiDHt9dxCxCcXSCvHeDj9mwJV38sX40rGceF32kw6r0zafwnX2
	KXXmnmKL7oVdr2TRjaIKYwR6Odj0brUhvKJKMW5eYutQUqEWxEzoPLeL2dUHXT2XiX69nk
	9utWDp9AT/L2LTy3AVXXbkLd0CHe8d8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-eFHbnAwlOp6PeP0ntOD82A-1; Tue, 10 Feb 2026 06:52:45 -0500
X-MC-Unique: eFHbnAwlOp6PeP0ntOD82A-1
X-Mimecast-MFC-AGG-ID: eFHbnAwlOp6PeP0ntOD82A_1770724364
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435db9425ebso1123535f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 03:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724364; x=1771329164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
        b=gz0EstAjSgb/A/c0NxftkudgJS2mTPC59CO0nWTFFL4i06U4Y/z2Mh1VdS0tUVH031
         AurvhRpVN76JjLEHola5zdVwVLA0hXOeA2BmXPt6eVwYETNlo1okxwWkkQelOTO0S/GP
         y/KfT4K+O1IDOK9mB+l4iy6O+zzGDSwlcLPGqsA4fjso0uANMiALdpOdYZA++xBoNQFL
         y0xfzMiY66ZbaoCEyWgSsfb0OmSEeUyueIs1FcVSomNFumWwnrEVNqUTv80gyJvKKsJ2
         k+ZP1CDbjRYQac222tj1+gH5bZuRaShF3zpDKme1RVaKgpeIsxm3HHz13hibO7NVSLqW
         8AtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724364; x=1771329164;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
        b=bpQMu9ZVuB/rmWj8F+OCb/lhXC1gTRCiXbMNXkYAfZkkyIBHljzF23VPsY8TLQPa2+
         sbesQdWRrcFByaW4xScGLPSC2dAMW8dlGOBw6W327eIUZXH+tWGWqvSbDO0iUIrDgeGI
         JQOcD7HbIVDbS5KDVQR+rN2kJNYymXG6lbhrMyJr/1r3rDYeColaTzgPYJNZaB3UHgxw
         OMD6OuITUM896TbSHenbgexsTZTTZx01/oezLXMrX1MDKO3wAfayJtg9RUE0iLv2Qp1g
         jNuOW8K/+7yrb+qSJq/7EsnJ+Bu4aiUbUEkiHPnVvUQVXaMEZzsz602ucqMhzKGXPSrD
         z6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCX8au7jkZK220oBvpkUnAO24jHV2nnXZDEpmqW0fbMDSqHybXsg1k3t/GqC6J1nJhBb54U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzek0bhWCFNeC9+z8z+/Ny0fLJvJ53AyNXyPPMuBRBLu30UGX+H
	RRmNt5KE600+w4yFND0Zj/K9p7ji128VcXg5Xz3xT53pFagGz7k+ZZegxQf7DYYVZ7+3rdVzkMw
	/ECHiiYWY2aJt906ZuDLzzNbsl2EdGV2X/0oLZqDbgQVgJs5Lzm648w==
X-Gm-Gg: AZuq6aJbE0x/KrA231UGWo/XWMQpTb4qjykBx4RHQvMbJYGAxeJJo5uDG7mRFTlb3Pi
	BB98lljiNB5yCNs+deLCSCrjjaKeXYM875+iIONZaruiFqV7ReMuFlSCjFQIN69iUqsvo2Yebkd
	RGN42U1OR4BarMgT0VGXcgBo2GXlGASRsr4ScAZrDa+X+3XwbSe6/3qeucEF0OSYabfAepKy8gJ
	Vebcin/1nfxOT8bf1QZhYmYP0eTpn49zM1b2yUuaYA1UDm1DwY7ilVVYekV8YpVWN9vjXWkY+Qi
	m2AjX14F//2jvoGVV6Qmcu3/3gOmhFFXVc6IZF+3nD7ygnHa2GUYAqxUmv/Few/+aPnMj052gI4
	cZWfLRRa0NPfsIOdZZFXhXMtjcIQvvlw1czNeH+gj+2rwOuD6
X-Received: by 2002:a5d:5d05:0:b0:437:6bfd:c3ab with SMTP id ffacd0b85a97d-4376bfdc733mr10540275f8f.51.1770724364238;
        Tue, 10 Feb 2026 03:52:44 -0800 (PST)
X-Received: by 2002:a5d:5d05:0:b0:437:6bfd:c3ab with SMTP id ffacd0b85a97d-4376bfdc733mr10540238f8f.51.1770724363769;
        Tue, 10 Feb 2026 03:52:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm20713414f8f.37.2026.02.10.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:52:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CDE1E4FE89B; Tue, 10 Feb 2026 12:52:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 3/6] net: sched: sch_cake: use enum
 qdisc_drop_reason for cobalt_should_drop
In-Reply-To: <177039507595.2258217.4088231078326234454.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039507595.2258217.4088231078326234454.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:52:40 +0100
Message-ID: <87y0l0yfw7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Change cobalt_should_drop() return type from enum skb_drop_reason to
> enum qdisc_drop_reason to fix implicit enum conversion warnings.
>
> Use QDISC_DROP_UNSPEC as the 'not dropped' sentinel instead of
> SKB_NOT_DROPPED_YET. Both have the same compiled value (0), so the
> comparison logic remains semantically equivalent.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

So before this patch (but after patch 1), we're basically assigning
invalid values to the enum skb_drop_reason variable? I guess the
compiler just turns everything into their integer representations, since
this doesn't cause build errors?

I guess the only way to avoid this is to fold this patch into patch 1?
Not a huge deal, but maybe that's better then?

In any case, for the change itself:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

