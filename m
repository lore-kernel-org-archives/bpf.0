Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD2DC10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B13420857
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 11:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIAP1w6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDILaE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:30:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46779 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDILaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 07:30:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so10010613otk.13;
        Tue, 09 Apr 2019 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/Bpzl0L/9Ftdco2uhXaOstGIkoxzc3umGAKwtRZufA=;
        b=XIAP1w6OvJtL7PnoR014ybO28AAJwMTlX/M5oDPIRr1KWlRqxxYoB9rWhWKKtYybnn
         E+pV8VaUo/xxp7J60Rw6W6CZHZQQCH6YOT9KPz9jtoPDXzpEFH4Xm+zLv2/Ut1j0VDKK
         K/ALdt97iMRp0hJNx9p+MuKoECuCpLnYDiMiub3M5soBc7vVNEUqp73W1Lap5216lg+m
         XyZmm8zMnL/+CPCgFKxEGhS2HT7JbSS4NAhpQdUb/VP3mns+r1Vij/a0Nxob8yHxk7db
         E4dxf7mb63RpNqVap1suxogBfbdjy22TL0cZVeyYPm4VnF389OP8LNc6YAiGwToNGf53
         0ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/Bpzl0L/9Ftdco2uhXaOstGIkoxzc3umGAKwtRZufA=;
        b=VptHnYhjYfSy/pr8pyX1EIzijG1a6UlavSEb7DGYqBXr4HWU4JaMH/ein3JVQVZkPH
         A2QHRN247vF18+7nktyegayml71Buy3HMX57rxZ+a0ZSiOQfNWa0pTS30wLpwhv7cp8C
         kXN4NUgLOLGfXp6jpfntC3WOBuRrmdaDjJHx/eYxug0TO42Or1d1reV3esQ9XITU3rgF
         D6gklnIaH7sEaw6bdG8FNuvFTtsML6GCYTuUHh1l35QgbyBJG8o7Afg3XFJ7Oc8rHZV/
         RvhmOhQzUEciFYVMJ4q/fhXdWFHKQiypM7twTzdwIdmZCuSnXJcRjEXS5MUZxoI+6XBh
         hakg==
X-Gm-Message-State: APjAAAWvQIPHiyTQt9qrH5l2ryOg4aQN66t2BxcH7Qzkyz+i2Uu3LoMV
        zVRBdU97ee8Mval2wr0waAiiHnn+cdmch//1sGs=
X-Google-Smtp-Source: APXvYqwcI9VBPZsNfHn/MeHFhNJOFwuSfVUgKPe4/ycqD0sgKdtWc2BLBgG01mZQSmIKxeKyPbnTVjXRa4zGaZprp4A=
X-Received: by 2002:a9d:560b:: with SMTP id e11mr23504313oti.60.1554809403324;
 Tue, 09 Apr 2019 04:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <1554792253-27081-1-git-send-email-magnus.karlsson@intel.com>
 <1554792253-27081-3-git-send-email-magnus.karlsson@intel.com> <621a9d70-5397-da90-a68c-6f12f5cbd3b2@iogearbox.net>
In-Reply-To: <621a9d70-5397-da90-a68c-6f12f5cbd3b2@iogearbox.net>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Tue, 9 Apr 2019 13:29:52 +0200
Message-ID: <CAJ8uoz2Cxkfv++znzzjZJ2=D0YbTJkf+BOH=y2nBEByiW8stdA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        Ye Xiaolong <xiaolong.ye@intel.com>, ferruh.yigit@intel.com,
        "Zhang, Qi Z" <qi.z.zhang@intel.com>, georgmueller@gmx.net,
        will.deacon@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 9, 2019 at 11:11 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 04/09/2019 08:44 AM, Magnus Karlsson wrote:
> > The use of smp_rmb() and smp_wmb() creates a Linux header dependency
> > on barrier.h that is uneccessary in most parts. This patch implements
> > the two small defines that are needed from barrier.h. As a bonus, the
> > new implementations are faster than the default ones as they default
> > to sfence and lfence for x86, while we only need a compiler barrier in
> > our case. Just as it is when the same ring access code is compiled in
> > the kernel.
> >
> > Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/lib/bpf/xsk.h | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> > index 3638147..317b44f 100644
> > --- a/tools/lib/bpf/xsk.h
> > +++ b/tools/lib/bpf/xsk.h
> > @@ -39,6 +39,21 @@ DEFINE_XSK_RING(xsk_ring_cons);
> >  struct xsk_umem;
> >  struct xsk_socket;
> >
> > +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
> > +# if defined(__i386__) || defined(__x86_64__)
> > +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
> > +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
> > +# elif defined(__aarch64__)
> > +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
> > +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> > +# elif defined(__arm__)
> > +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
> > +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> > +# else
> > +#  error Architecture not supported by the XDP socket code in libbpf.
> > +# endif
> > +#endif
>
> Hmm, bit unfortunate, but I can see why it's needed inside the header here
> as it's installed into the system and needs to be included by applications.
> Fine with me. In any case, I still think we should also fix it for tooling
> infra to avoid others running into the same issue, lemme resurrect [0] from
> back in the days.
>
> One question though regarding above arm32 implementation. You match these
> barriers against the ones from af_xdp in kernel. So smp_* variants from the
> arch/arm/include/asm/barrier.h header need to be matched. This selects the
> dmb(ish) and dmb(ishst) variant. The implementation of dmb() however is
> quite CPU dependent, the above assumes to match with __LINUX_ARM_ARCH__ >= 7.
> Perhaps this assumption needs at minimum a comment to make it clear for
> developers.

Good idea. I will put a comment in there to clarify this.

/Magnus

>   [0] https://lore.kernel.org/netdev/20181017144156.16639-2-daniel@iogearbox.net/
>
> >  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fill,
> >                                             __u32 idx)
> >  {
> > @@ -119,7 +134,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
> >       /* Make sure everything has been written to the ring before signalling
> >        * this to the kernel.
> >        */
> > -     smp_wmb();
> > +     bpf_smp_wmb();
> >
> >       *prod->producer += nb;
> >  }
> > @@ -133,7 +148,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
> >               /* Make sure we do not speculatively read the data before
> >                * we have received the packet buffers from the ring.
> >                */
> > -             smp_rmb();
> > +             bpf_smp_rmb();
> >
> >               *idx = cons->cached_cons;
> >               cons->cached_cons += entries;
> >
>
