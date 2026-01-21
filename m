Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456251A5BB4
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012523; cv=pass; b=sxqNlJTgb/8BqnC3KZ6V701kwpx21znw7oHDcXEhCSia8ROh0aIdyGCbyDro2HQ6jnyL/tt5N/L0WLy5kXcW20VnEa10YAbT8rjfmRZ/rE82FDjNK723eTeudXX6NDUQWsIRXiixi2jBNsAy1/36zufY2aepPclNrOTgM0Zcixs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012523; c=relaxed/simple;
	bh=N8yg0sA6xeaJapH8x7dXFOQ5ATlqTNmQkFmcpp80GVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzgRpvLQZMwI+myTxI7WlcxGXQc0TCg+4xId4B13WA2GJhcQ7MPLa3pdLPIPI6tPTDuvpiCWC2KSou93Y5a8wfJ6c/EOn/kXPz7v6zN00pPQskBmgMHjIBaZmusdMvYB+pNR6NlBKA+kfeZdbFiho4nLbZbd8cNuur8vRxCP8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBmNGOYV; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBmNGOYV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-501511aa012so115661cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 08:22:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012520; cv=none;
        d=google.com; s=arc-20240605;
        b=OFhmYgJ4RsqA2+UiS33aIO/YR2pWp06XwIIRh6B9xgL4W90uHt3qx1grFhADxomDu2
         ZYwjrmy8cGqJ2Lxmi6xZIsnp4l4Abri7aY1AL69OLAzpTW0nuFCUJHaZE+qQImQMgSMe
         p2zuc6VZJ0b1GKnibJazV9+KzIOUS0IED8EaPc8CSpSLcLxAUIYFgnLnxQ/75gMo5v4v
         QETWefslca5KWAJUh1txCN20r+sWcNBMlqfSp++3PLR7cpa5Yp24d04soc9g/Id0PzAI
         c42XGnSh6aQKo+3ySV9feRgDVHGYk9QhZ0FE6qSracyQT9wbHIui65BmBuc2CSab9Mbv
         iV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VdVLEMD28EfX+5P0zrv2LIUEohcfDySK6bn0IJ0lRR4=;
        fh=IQAMgJzVRvGPozQ5ioWmZfdRIPy30mjz73dRtC2DGIg=;
        b=hpuFz5Ztc614Ngx/2POg2eZLKYk1EprPOLXvQ2MmPpph36BERghE1PX3heUdeaddtL
         aTCbj218SDSElHGmv/TRmwkot7xIZLVWe5oi5Tf6Mz8EupPFebDmkSyzlvbGOoiIJSCH
         qD3H+Z/WYBYFZoAzD6o2Qm61v9gItlnK02NC6FZRRmmV55GsUMSL/U/UbOM5+g7EqXbr
         XPWvDY/45MA2nEAKMnm/cdBtkIbn8DQzoftkst7MqoYSHzmHca4ra3wtyhWUcZDs+GrV
         wsC8ZRyFEah7h8Y2TNcfqDtIIvKCcxPB39kLK9mUxMDteIJptTbxe8mCBvse+q/EYhGa
         NluA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012520; x=1769617320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdVLEMD28EfX+5P0zrv2LIUEohcfDySK6bn0IJ0lRR4=;
        b=SBmNGOYVIsROjbnqf5SnxcCTmmwhAear0K0lDUiKvFSt4Lp/73z2oEuAtdg7VMSsg7
         gRyMwO4JFYTCCykRBklcZZvcKUIdoAAaqakGZIUvFoJka4TADgWOn82l4Jkf8C0DqafD
         SEe1EtkUB9qQwa2zZAD/Sqnkar6h9P0oNgdPaouK3yTqU4mUwkx/vNz+WsihupTIB3Nb
         z/LjpKVuoUp3Q64pzzCmdrhJZcN/bQk/r8XU/xs423LrJ6LbVxSYFfSe1sdyL98pyKhm
         Zare/pbeWmTOmEXqyIzoIjgnMK8PcAJorXKWSS5L9/VxOxTzg809xNCdIDPG4lx8442b
         drdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012520; x=1769617320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdVLEMD28EfX+5P0zrv2LIUEohcfDySK6bn0IJ0lRR4=;
        b=SGKNj8ySWQpf9F2P7iMdv7H0i6u0hUN0Vil5jzSscksQdRfnL8mg2MD2+hk39NwZix
         9VKyiTH/qT/Y6wdmdjwQzbywLfkvuUsiRHKAV3LJ3otH9UU7R8VbVzg818v4tA4vY2py
         swUHaSCiGCJs/Wewja4ljbCyfuqkNFYrt6MWVe/+sDhEAL+YSaCh1MfzxNt/5aR6mirW
         twsMcf4/mXEymz2QVf7hUrXkk38dave3gbLQqycwJd1zuGOqK3vCpijAa/1heSrdVKFn
         BIP2vudRcNFqUvlmOpgPQJrUimvmfqYSMu33aDttsEmmuslisffYWGUEsngUL5SccVaS
         NN1w==
X-Forwarded-Encrypted: i=1; AJvYcCXRKTcGMl+kAUEd6lfkARR57p43oBCLu4QIxKiZ/SPSe5khjc8xxcZ3RN02SAWAsCitJN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAFhbnqxHQynLD1v3qJtDgC689bC5MNlMHBu3S5XwEXXwxwgx
	ZOpxFzlVNWTeHvTM+ecA1rtm1FyPHCc1wbUm8LNCGOPK9I/0WKDMwxSJJK0Pm7N+ayVGJ4XET+J
	FccIALKh2El0EF/7UZpOysxHkv3QszDkJoyCM82LV
X-Gm-Gg: AZuq6aJFqWRl4tYF5fr1ZkwrYAkyEdg21vvRchxoxdzdc9Q7/6ZOUofI0dnYgFmpJLS
	K3UrAS8axgIjPvuBZ/L4FCzodYu0xy4bWFsxGHqCG1w0mCZMFANYkASfzgsOFv40eRjAFQUXubT
	b/7+OKmrj0d1tSQsqI6UV1iRDSQ4G1sgb9wgrNSMdbB8BQnqIbLzyOJIfdLpBl2N9Gd6yZDHjfr
	cVZgCflb7BQ4+xk29MFfSlWcpwuM1EmU5YjthGeA9vqwnKUDQqAyM0XqhUBNEsvUXTav4kT9mkN
	4QQeANdgPeb13QTl7RB+Hysrp5ZeeScOhg==
X-Received: by 2002:a05:622a:1998:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-502e1a7f7b3mr11247441cf.7.1769012519794; Wed, 21 Jan 2026
 08:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz> <CAJuCfpHaSg2O0vZhfAD+61i7Vq=T3OeQ=NXirXMd-2GCKRAgjg@mail.gmail.com>
 <aXAkwLsGP9rqamKL@hyeyoo>
In-Reply-To: <aXAkwLsGP9rqamKL@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:21:47 +0000
X-Gm-Features: AZwV_QhmIp5S8mEMP1h6Gx-TWCdfCxovy5QQV_d0u6153x3grZV0j2owhClsj2k
Message-ID: <CAJuCfpFiLnvXF-yOVmLDNqQ9ZoJC1uKz3J7UNawhp5Epev=eNQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:59=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Tue, Jan 20, 2026 at 10:25:27PM +0000, Suren Baghdasaryan wrote:
> > On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > > @@ -5744,10 +5553,9 @@ static void __slab_free(struct kmem_cache *s, =
struct slab *slab,
> > >
> > >         /*
> > >          * Objects left in the slab. If it was not on the partial lis=
t before
> > > -        * then add it. This can only happen when cache has no per cp=
u partial
> > > -        * list otherwise we would have put it there.
> > > +        * then add it.
> > >          */
> > > -       if (!IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && unlikely(was_full=
)) {
> > > +       if (unlikely(was_full)) {
> >
> > This is not really related to your change but I wonder why we check
> > for was_full to detect that the slab was not on partial list instead
> > of checking !on_node_partial... They might be equivalent at this point
> > but it's still a bit confusing.
>
> If we only know that a slab is not on the partial list, we cannot
> manipulate its list because it may be on a linked list that cannot
> handle list manipulation outside function
> (e.g., pc.slabs in __refill_objects()).
>
> If it's not on the partial list, we can safely manipulate the list
> only when we know it was full. It's safe because full slabs are not
> supposed to be on any list (except for debug caches, where frees are
> done via free_to_partial_list()).

Ack. I guess I'm reading the above comment too literally. Thanks!

>
> --
> Cheers,
> Harry / Hyeonggon
