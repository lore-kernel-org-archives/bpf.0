Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A83D1CD7
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690636; cv=pass; b=a9mxIL+Jibw2Awd7TcTtjUrlOXKIwC98e9XyezE47pR+MzB0kCCzyhrR78Rx03HNfzcFjjU7FgTuKXnZmDjV9PBuszWcLtzRBlJl0w8GWV5APD2ed7gSBkV5uSkiG1D+fMgqcih58LD8Oy46NzIXD+wNiyazfnJxO0GnDOtwvkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690636; c=relaxed/simple;
	bh=uNWxnj3qi2+ykxztSlNloYhZMOqtxnahieXViRSeMXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxImqkyxmgt5WMvQQRYi4xgDMMXc/9NNnOgv46TlnsJwut9Tsn+V9Q/Hmz6C64qNAtKyGKRSGc1hX2cRK34vanTe8sZhWY1t8egt2PbjCk3YMwycxCY06+2lzv3mAcZ+nKMujVoaXJ1W0TuEjHtF7sGawZA9idryZGpvkWHT6gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1a8Soi5; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1a8Soi5"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so5608986e87.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 03:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690630; cv=none;
        d=google.com; s=arc-20240605;
        b=ZfQf0LXYl4wkxqwdtCsYiZ4/iLVbnLys71Nw67G2xJ2T+JA8wE8lU/2vuwlzmbberH
         RC8ecEFwjOIuzS8m1Jjq4HBNhc43IMNO3i0RbaZZ59MflhN/qqcb/NMgCdIhAtrdM7nx
         DhkgTHGy5LxiqC7lG5e6bYSOat9GJdPTEYMdrYJ+SvyVBpp2+R602cZ8ue9FSH5irEDl
         dPGAmwmyrGu1JGYFnlYmdkC/oT7pA0sFbhhGB9bqd8GTbmBAl1OWg6CEOXhaxmyq0C8r
         H2a4nxYW0w/Ahbd7wDgbD++sAm2sB1Hu4CdM0poG0IUnOM/xOi4+URO+wlw3C0MzMIqR
         sQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NavSmjCORSGnrcL8EH/P2IOvDWqUXT9HSOh3FGii4Es=;
        fh=Vf1F683dbeFVC428sP4xvPwD+d/5d5oCmssWaK/guh4=;
        b=KhbYs+zOzR5IsFs1T1GRAJBuKWWkpvMPD/uGPzPHCilhyofF3AUag0rQqn7c0hSyB9
         kulh2vUhsxa/TZYhAL21lDCE/N8s+SGBOR6WbinVRbRiPd+q2vXKmGby3AdoR0XhXPO7
         PbVI0JshbHKhnQmy7/b1p/8+bBNcFR/F7ZjjALwxCfkdaYY4KmHK9qg0A5NK49UCUfWV
         yGmetOEM0h2F8gzhgxnni8pOgY0+xCYrpPjyZTUZkQceFYpUZi/kHnlnnlKxiQNl5zyF
         oiUA+OrxbZrwPhkdTpkeAFKCKUvZaDQBMe5K3QVwLroCLFED96Q+vhKcA4rtSJ2VUMHt
         Xb5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781690630; x=1782295430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NavSmjCORSGnrcL8EH/P2IOvDWqUXT9HSOh3FGii4Es=;
        b=L1a8Soi57fiumVgzxWUfcNfs3kwh96pLANkcqdK4skZehwSXPZpYsr44CzVspx2Fb4
         TUePM0UzzUk/1h/w9Agj3oBlsfGbE8D3fxdo0sin4/tBSiLTOoLoiv8JS3Rbyz1Z2HbG
         xPVLM54kZpbZ87LtexU9rk/s11TE6oGo+DoZX04tOgaUJ7Sb6IFUw+ipviO71CTT+2Kg
         rX+RJvQcVGt+bD7an+Ez7OEsx7/oC4mdRutKk133MlIu4qVnXZFNOhPLYhxtQTfN4Md+
         YAUVEiqTG+xLPse0n+Un7K3WUNx6M3F3w+Hjmd1XlkbhhYHMdLQPJaixjaHM0agZFmnT
         vRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690630; x=1782295430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NavSmjCORSGnrcL8EH/P2IOvDWqUXT9HSOh3FGii4Es=;
        b=tX3KrFi7nahfK/NOAv9c49bWfdQomvWuUk8d0aVUY1aA/nYwaROcyt7rFzbAqeYeDJ
         g/qlLDR8vIb8kMfUs846jqW4Vc4VHcTESvcBV+LopbfRyKjSi4Zbu4qew47zV7ns+yQl
         bM5O6cWzwQUdk4nrPvErV1kN0rBBGrvhJCEHWTbXAodQt4d4/VBm+SEl0z+ks+oiSTDp
         0XFCWZAqnWoXEkXKQIjJ0EKpnoFSApcr+WqlWfxx78Na9Ne05iafHMKeqXAPfC7NMyKo
         4mnCmm/28cITSvyUzy2+wjXE36H2odItZcThj7I899UC6xeDEtPym2ByRS0hq9naFgfH
         2J2w==
X-Forwarded-Encrypted: i=1; AFNElJ+pBUsJtYV80YYRNeBDo3m2c7A/xaGkcVzj60xjSEtKe4nodBS2LwYrVas3Aqt7gU7HK98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ijs7qtqGm8b1Uvfd7+hRLd7O8VO065eK9vRWQ8ZlM1mQ+k5W
	udA2WHOfIsDL3nY93l+kJWqObznug0atzDj4FRqxbL74cU99pLo1ZQNuiIys9loYeGeBet/g4ab
	0tIYzlPQKv7jqF5R78MFm5Wb8NgCILcs=
X-Gm-Gg: AfdE7ckl1KZxuWeo9kmxfprX1zbUY2xSqFE0+Ph0L0Y1x5iWMlF3x6RVWLOYqe+8Odi
	KFQi6tifCu2jPsCseQl70fiU78/UsMCaOcfg2v2ziWhxFozFtud+ruYWKXr6V1zBauW6kuR+K8N
	HflptrpjWo7kx7VM/tyo4vU0CsoAoyHJIiMXuRZIv6ormMDoTBzYwVm7Gd8xFlKMa0VDaHQ7i3R
	CcX8wc9Nj/H2ykQuWNtVGoQYc1bras+weGGgxUd/61utoTm/2el7DFR/3scCl5ADIjoiyBRUWQY
	7NHii3dFJgxng5dS/5x8YzXSZ4TkMIvj3nFtEepYII1CRK0STnN91u/1F2qaBv9uW4SHgD8VEWq
	RaYmL4vT4tcE=
X-Received: by 2002:a05:6512:3c9b:b0:5aa:6dff:cf1f with SMTP id
 2adb3069b0e04-5ad46ffd388mr940205e87.45.1781690629647; Wed, 17 Jun 2026
 03:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com> <ajJsMj0QMOF5I8qq@boxer>
In-Reply-To: <ajJsMj0QMOF5I8qq@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Jun 2026 18:03:10 +0800
X-Gm-Features: AVVi8Cdp26ThLaA66Ypf5qUBe6fIsAARte4Jy6SOTxHSkFiChwA96WKCdQw9Ckk
Message-ID: <CAL+tcoD9yf9kTTK335RjTiFL5FrigXgNs650O2Lnu8_LxXRhwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tushar Vyavahare <tushar.vyavahare@intel.com>, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 5:43=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 17, 2026 at 07:39:06AM +0800, Jason Xing wrote:
> > Hi Tushar,
> >
> > On Tue, Jun 16, 2026 at 11:50=E2=80=AFPM Tushar Vyavahare
> > <tushar.vyavahare@intel.com> wrote:
> > >
> > > This series improves AF_XDP selftests by making timeout handling
> > > explicit and fixing sources of non-determinism in xsk timeout tests.
> > >
> > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > dependence on RX UMEM setup state for timeout behavior.
> > >
> > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > before worker startup, removing signal-based termination, and using
> > > barrier synchronization only for dual-thread runs.
> > >
> > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > configuration does not leak into subsequent cases on shared-netdev
> > > runs.
> > >
> > > Together these changes make timeout handling easier to follow and
> > > improve selftest stability, especially on real NIC runs.
> >
> > net-next is closed, but in the meantime I'll review the series ASAP.
> >
> > BTW, another thing about selftests I had in my mind is that are you
> > planning to work on this [1]?
>
> This one is on me. I took your changes Jason and aligned ZC batching side
> to this behavior, followed by xskxceiver adjustment. I am planning to sen=
d
> this today EOD, however let's see how badly internal Sashiko will kick my
> ass.

Thanks. We'll see :)

Thanks,
Jason

>
> >
> > [1]: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing=
@gmail.com/
> >
> > Thanks,
> > Jason
> >
> > >
> > > Tushar Vyavahare (3):
> > >   selftests/xsk: make poll timeout mode explicit
> > >   selftests/xsk: fix timeout thread harness sequencing
> > >   selftests/xsk: restore shared_umem after POLL_TXQ_FULL
> > >
> > >  .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++------=
--
> > >  .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
> > >  2 files changed, 56 insertions(+), 42 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
