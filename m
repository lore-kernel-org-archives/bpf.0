Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FC42F6E4
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376656; cv=none; b=fwOpOT1YLO1XPyqHaHSM0OlfXT0bezeU95A7B2VuqovsX1/dl3DxPwDtWRQMly/Gkd/K1RGOiPEMrdYlvQ4zz9wDtMfOWBrulMdCRipPpmLS6sXGSyz/CIFqVN++eKD3XSSC8KDOxUwVuB24d6kml0S0HP5N8xdNccUk/pca340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376656; c=relaxed/simple;
	bh=cBzrQn4nFe3HI2uqgmIPywDhDoS2/GQhQAflPWf07o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfWgVQu7rgfUziQWtPX6Z7FSx6O/sRAuUV7Wn0H8GAr8alhxAMTtP2fw7b7zh2UP+SfmLojRii+90DknhxEMs2Fh8p8b4EfZZ5+pPXtzx+4Bf4mN2MGKfCKZTbFKt0aePNqnAPFyAC/F7JPt3Wp+5IpXSKh+jWUpaW8RuiIlP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=aIxfGyhp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="aIxfGyhp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384422b05b5so393000a91.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1783376652; x=1783981452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kT7T0HNBRxDmMz12cl1CtlcHuObMCiKxMK/p9Ya4GgM=;
        b=aIxfGyhpx70TLrsLLX9QdpEBJK6q3bgprQWEz+eDJWYpFeN+EOLn0Y+xtviJeszibf
         Psu+rJePGd6VCoIFZUbn/jRL21Xzf8sF6hz64jDjcVAK34UbIAl9PcpUlT1DD1iFOlYN
         AOXI4mWWecI0OtLO7SiX1/1O7/X4u+C/z3eIMrBawY+f6K8CWaQYl8dEnGm+6gjRNX5l
         i1PhiNv3bwQnl17nnJj8ZzzCgiaU6F/zc0YrI1IrFGOGgzXJfwNEKzb0qvuPFt61EWwF
         1bGijkPII3pFUQRDhGJ0jVkxgS+N6EaV4cay6eazbH8QZzxkcVwKi4IDZtQuZ4pa4HlU
         kUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376652; x=1783981452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kT7T0HNBRxDmMz12cl1CtlcHuObMCiKxMK/p9Ya4GgM=;
        b=ow/kmABcURIEDR02vovhH0drMqGcas/wz1Iopxj9npwhLdtyWiyfJeD7rOP4j8y1S4
         mtsOYzsKfT+X6jck+CFE+cIInVhM/hR+0xP8NP068C1F30Y75qK8xNAgC+kA/bWdsT0+
         1a/TOwz+le8N/KONmzNZYNBOnbkYIszvgaIM8MMMnTz2whcqYQTxv8vVnYg9LxJJBOU7
         809mJ6ByJ+UTsPOUPYCRksOZ501EhVdGhIRlMmDpVNey0ghaWZsVoi2+jH/U6cwukxKM
         IJqC4GXJcyPc9lVJ/CQyF6iRiAFRz7JhgzOX2ahx1gZH1AYYjpExhRhRXyAWPI5jp4GW
         +ZJw==
X-Forwarded-Encrypted: i=1; AHgh+RqN8ctreM/g9KgWXzKFu4a0AxkaezJR2HxZBsGuHI6l/Wt1NX36DPPZJ1fUanR/foKziEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqtMrC0MWflgqMMDiTMzkQ3o5iXdos24gyYMs0s/BUtbEt04l
	ZZWx0+lSfuFvjh/AgKcRIZzWzOwLvg/UYJwsw9lANI/V9q9QUTWoYidpxhPvA+MGy9A=
X-Gm-Gg: AfdE7clxQXNGJRzIOux1KNQgZ2VN7jBmHJmBIk2HfaBswNmxppEBfm6J9W+LDV5OaPc
	lL/3aSqiVHm5u6lxNdo7FglvLzy8u6cOF3/Pcj2ng5SjRklsS5/HRYLhavVKS7pg30w+7sT55m9
	V+3TBJQ+x14ny4jmVau+5PB3JLQFDdtEYy0SmOjumMcnqrY9/sI8juYBaC60VBALcmr9zPccezV
	CQvUrq1tzxeFkbCzZw7WiepSZ6+0pmje6SSXqdgAlG+gcViv3Q9tznqqCf8SqADdSAAsn4SQ/y5
	+3dArbhzp59LPryJ/phK4iG1MI9LnOlzGp9zdmczlTdX0xozmm3DRUH2EiDqnIrqYDiAFkhT1z5
	s/kogYgtmt/c5RglWuFmM/6zAM3aQvr7rx9JgUKMQ5t0rhBkra7MBHLnWQiVUSYGyJo2Z/wyHOA
	==
X-Received: by 2002:a17:90b:3888:b0:37e:2053:3489 with SMTP id 98e67ed59e1d1-387e2f3f6c9mr18141a91.3.1783376652369;
        Mon, 06 Jul 2026 15:24:12 -0700 (PDT)
Received: from t14 ([2001:5a8:47ec:d700:d75e:d3a7:98ad:d3a2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm916548eec.2.2026.07.06.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:24:12 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:24:09 -0700
From: Jordan Rife <jordan@jrife.io>
To: Amery Hung <ameryhung@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, sashiko-reviews@lists.linux.dev, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: reject mini-sockets in bpf_sock_destroy()
Message-ID: <cbg32g2k5xvg6xnf3pkqn6gd6mgvb7pbgibiyrrgtlue3o35ys@bdgwlx7mz5q5>
References: <20260702224519.800135-1-xmei5@asu.edu>
 <20260702230504.0E65E1F000E9@smtp.kernel.org>
 <e6ec128e-1acf-4dc7-8884-e4d7ed14d25b@linux.dev>
 <po6jpmx5q72uvblx23atsbwvxhoszpmrlkjd6txljljufnjeqj@v3yov32574sm>
 <CAMB2axN8r-B1gc4f-BSh5d=VFttxGLu+ubB_53nzpAqvYd0HVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axN8r-B1gc4f-BSh5d=VFttxGLu+ubB_53nzpAqvYd0HVA@mail.gmail.com>

On Mon, Jul 06, 2026 at 11:11:59AM -0700, Amery Hung wrote:
> On Sun, Jul 5, 2026 at 10:45 PM Jordan Rife <jordan@jrife.io> wrote:
> >
> > On Fri, Jul 03, 2026 at 10:15:27AM +0800, Jiayuan Chen wrote:
> > >
> > > On 7/3/26 7:05 AM, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > >
> > > > New issues:
> > > > - [High] The patch causes a functional regression by completely disabling bpf_sock_destroy() for TCP mini-sockets (TIME_WAIT and NEW_SYN_RECV).
> > > >
> > > > Pre-existing issues:
> > > > - [High] The helpers bpf_tcp_check_syncookie and bpf_tcp_gen_syncookie suffer from the same type confusion and out-of-bounds read as bpf_sock_destroy, but remain unfixed.
> > > > --
> > > >
> > > > commit cf46da8728e7f1fca4584ccdb089c82b7fd3061f
> > > > Author: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > > >
> > > > bpf: reject mini-sockets in bpf_sock_destroy()
> > > >
> > > > The patch tries to fix a KASAN slab-out-of-bounds read in
> > > > bpf_sock_destroy() by checking sk_fullsock(sk) before accessing
> > > > sk->sk_protocol. It casts sock_common to sock and early exits if it is
> > > > a mini-socket.
> > > >
> > > > Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
> > > > Reported-by: AutonomousCodeSecurity@microsoft.com
> > > > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > > >
> > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > index b446aa8be5c37..3e70c8ab5aab1 100644
> > > > > --- a/net/core/filter.c
> > > > > +++ b/net/core/filter.c
> > > > > @@ -12665,6 +12665,9 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> > > > >   {
> > > > >           struct sock *sk = (struct sock *)sock;
> > > > > + if (!sk_fullsock(sk))
> > > > > +         return -EOPNOTSUPP;
> > > >          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > [Severity: High]
> > > > Does this unconditionally reject mini-sockets?
> > > >
> > > > The commit message states that mini-sockets have no diag_destroy() handler,
> > > > but as documented in the original commit 4ddbcb886268, request sockets are
> > > > explicitly supported because their protocol diag_destroy handler
> > > > (tcp_abort) correctly handles TCP_TIME_WAIT and TCP_NEW_SYN_RECV states.
> > > >
> > > > If we unconditionally reject non-full sockets, wouldn't this break BPF
> > > > programs that rely on bpf_sock_destroy() to forcefully terminate pending
> > > > connections or TIME_WAIT sockets?
> > >
> > > It's true. Please also include a selftest to reproduce the issue and,
> > > another one to cover the non-full socket.
> >
> > +1 to the selftests.
> >
> > I'd just extend tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> >
> > Considering the original intent was to support request sockets and time
> > wait sockets and tcp_abort already supports both, perhaps something like
> > this would be better.
> >
> > __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> >  {
> > +       int (*diag_destroy)(struct sock *sk, int err);
> >         struct sock *sk = (struct sock *)sock;
> >
> >         /* The locking semantics that allow for synchronous execution of the
> > @@ -12672,11 +12674,16 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> >          * Supporting protocols will need to acquire sock lock in the BPF context
> >          * prior to invoking this kfunc.
> >          */
> > -       if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
> > -                                          sk->sk_protocol != IPPROTO_UDP))
> > +       if (!sk_fullsock(sk))
> > +               diag_destroy = tcp_abort;
> > +       else if(sk->sk_prot->diag_destroy &&
> > +               (sk->sk_protocol == IPPROTO_TCP ||
> > +                sk->sk_protocol == IPPROTO_UDP))
> > +               diag_destroy = sk->sk_prot->diag_destroy;
> > +       else
> >                 return -EOPNOTSUPP;
> >
> > -       return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> > +       return diag_destroy(sk, ECONNABORTED);
> >  }
> >
> > (Note: I haven't tested this)
> >
> 
> Looks correct to me but I think it would be cleaner if we just guard
> sk->sk_protocol with sk_fullsock().
> 
> -       if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
> -                                          sk->sk_protocol != IPPROTO_UDP))
> +       if (!sk->sk_prot->diag_destroy)
> +               return -EOPNOTSUPP;
> +
> +       if (sk_fullsock(sk) && sk->sk_protocol != IPPROTO_TCP &&
> +           sk->sk_protocol != IPPROTO_UDP)
>                 return -EOPNOTSUPP;
> 

Yep, this is better. For some reason I thought sk->sk_prot->diag_destroy
wasn't set for request sockets.

> > >
> > > >
> > > > [Severity: High]
> > > > This is a pre-existing issue, but does this same type confusion exist
> > > > in bpf_tcp_check_syncookie() and bpf_tcp_gen_syncookie()?
> > > >
> > > > Both of those helpers take ARG_PTR_TO_BTF_ID_SOCK_COMMON and cast it to
> > > > a full struct sock *. They then immediately dereference sk->sk_protocol
> > > > without an sk_fullsock() check:
> > > >
> > > > net/core/filter.c:bpf_tcp_check_syncookie() {
> > > >      ...
> > > >     if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
> > > >             return -EINVAL;
> > > >      ...
> > > > }
> > > >
> > > > If an XDP or TC BPF program passes a tw_sock or req_sock from
> > > > bpf_skc_lookup_tcp(), won't this result in the same KASAN
> > > > slab-out-of-bounds read since sk_protocol resides outside the bounds
> > > > of struct sock_common?
> > > >
> > > > > +
> > > > >           /* The locking semantics that allow for synchronous execution of the
> > > > >            * destroy handlers are only supported for TCP and UDP.
> > > > >            * Supporting protocols will need to acquire sock lock in the BPF context
> >
> > Jordan
> >
