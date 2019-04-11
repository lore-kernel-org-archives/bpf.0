Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A46C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8F2217D4
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 07:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWWH5EUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfDKHyb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:54:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36389 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKHya (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 03:54:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id o74so4423885ota.3;
        Thu, 11 Apr 2019 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OWm0341RtKWyZhzEi13FMkZCraojRDXIZyZDudd8oMQ=;
        b=BWWH5EUkRt1AujCy2AeEK5+6PJPuUl98UwvOkuGoEau15t1yy4fsE8newsm1eHbg4q
         A5RAy+/NYlzofgO/SOP9Q13CVHI5izb8tVtORzhaRc5w2h3q1htf8aJ0iAxHmB1Soub8
         mQ9Ur6Bptbm/1+SOH5JPeWXDsEC2gl7F8q9ARJjwFpJY+pc2eDEetaxBxbQHxgvgp+ae
         ECtoTP68HicbQydSFGFNogHeNfpfRdKnanD9NrkZQsg6mpsheP3m+sr+dpnxeeme1xGL
         5N3NQvfCwmkcLWhcZXbA08IDqGiqBdiSq9AEVP1WsULIgBMbLxhDwEmvyDYq+Cdx9KOB
         R11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OWm0341RtKWyZhzEi13FMkZCraojRDXIZyZDudd8oMQ=;
        b=SCMwy3IeQ21LuylsoxVJi/z+Ez90/3gaZs2LqlRlYbngoLuNE2SEaqM8bFOFRxPbJK
         mZecT6g/LCVd/oD3cS9/87ZoUcKoe+q8CrMqrupkd5QpG34ikGVZ9iM7A8RZ2IklreT7
         kCvblOhkDt/rjRk3Suwvww2gKRvwwY2sQzvuC9YxJDJX2xGbRjxTYB4e51SjL6ZUvq/I
         btsxUww1VVMM0NnriCnEzFdA4KIUaPMBEvON79+/uhaFggRAG7AZJkQnaZaP5uxfdKTL
         wJvFNHATkw9zF/y5vAYyfprYEoOB75Kq8xsI+jjwH5MnjcVdW3Xuxr6SgkoJwv1NGxw5
         THqA==
X-Gm-Message-State: APjAAAUKD2t+hi8Gas7FBep0reCEySBOPYblEmfUYlkUP7yRoPQyE8xo
        dym5+TLMjcngjxdoSXM4a77rld7eDhN5COPxJwU=
X-Google-Smtp-Source: APXvYqyDo3a8ua6xC/zkDgzgcMgilUtecOOkbSorRIVpbgmbF6BfkzDD5rPtW9LMzulB/r4XRUBf6CGzgRbWOt5Sxbs=
X-Received: by 2002:a9d:63d5:: with SMTP id e21mr29580922otl.288.1554969269313;
 Thu, 11 Apr 2019 00:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com>
 <1554880154-30791-3-git-send-email-magnus.karlsson@intel.com> <CAH3MdRX64deNto0avW3XfexMLhNS+r75x3yea6ko+hmHrOE3aw@mail.gmail.com>
In-Reply-To: <CAH3MdRX64deNto0avW3XfexMLhNS+r75x3yea6ko+hmHrOE3aw@mail.gmail.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Thu, 11 Apr 2019 09:54:18 +0200
Message-ID: <CAJ8uoz0suybHMmTGvRRU==L09j3h-dBAE5QeRuzqCqnTrYwK8A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     Y Song <ys114321@gmail.com>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        bruce.richardson@intel.com, ciara.loftus@intel.com,
        ilias.apalodimas@linaro.org, Ye Xiaolong <xiaolong.ye@intel.com>,
        ferruh.yigit@intel.com, "Zhang, Qi Z" <qi.z.zhang@intel.com>,
        georgmueller@gmx.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 10, 2019 at 9:08 PM Y Song <ys114321@gmail.com> wrote:
>
> On Wed, Apr 10, 2019 at 12:21 AM Magnus Karlsson
> <magnus.karlsson@intel.com> wrote:
> >
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
> >  tools/lib/bpf/xsk.h | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> > index 3638147..69136d9 100644
> > --- a/tools/lib/bpf/xsk.h
> > +++ b/tools/lib/bpf/xsk.h
> > @@ -39,6 +39,22 @@ DEFINE_XSK_RING(xsk_ring_cons);
> >  struct xsk_umem;
> >  struct xsk_socket;
> >
> > +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
>
> Maybe add some comments to explain the different between bpf_smp_{r,w}mb
> and smp_{r,w}mb so later users will have a better idea which to pick?

Ouch, that is a hard one. I would just recommend people to read
Documentation/memory-barriers.txt. My attempt at explaining all this
would not be pretty and likely sprinkled with errors ;-).

> > +# if defined(__i386__) || defined(__x86_64__)
> > +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
> > +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
> > +# elif defined(__aarch64__)
> > +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
> > +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> > +# elif defined(__arm__)
> > +/* These are only valid for armv7 and above */
> > +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
> > +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> > +# else
> > +#  error Architecture not supported by the XDP socket code in libbpf.
> > +# endif
> > +#endif
>
> Since this is generic enough and could be used by other files as well,
> maybe put it into libbpf_util.h?

Good question. Do not know. Daniel suggested introducing [0] and
perhaps that can be used by the broader libbpf code base? The
important part for this patch set is that these operations match the
ones in the kernel on the other end of the ring.

[0] https://lore.kernel.org/netdev/20181017144156.16639-2-daniel@iogearbox.=
net/

> > +
> >  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fi=
ll,
> >                                               __u32 idx)
> >  {
> > @@ -119,7 +135,7 @@ static inline void xsk_ring_prod__submit(struct xsk=
_ring_prod *prod, size_t nb)
> >         /* Make sure everything has been written to the ring before sig=
nalling
> >          * this to the kernel.
> >          */
> > -       smp_wmb();
> > +       bpf_smp_wmb();
> >
> >         *prod->producer +=3D nb;
> >  }
> > @@ -133,7 +149,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk=
_ring_cons *cons,
> >                 /* Make sure we do not speculatively read the data befo=
re
> >                  * we have received the packet buffers from the ring.
> >                  */
> > -               smp_rmb();
> > +               bpf_smp_rmb();
>
> Could you explain why a compiler barrier is good enough here on x86? Note=
 that
> the load cons->cached_cons could be reordered with earlier
> non-overlapping stores
> at runtime.

The bpf_smp_rmb() is there to protect the data in the ring itself to
be read by the consumer before the producer has signaled that it has
finished =E2=80=9Cproducing=E2=80=9D them by updating the producer (head) p=
ointer. As
stores are not reordered with other stores on x86 (nor loads with
other loads), the update of the producer pointer will always be
observed after the writing of the data in the ring, as that is done
before the update of the producer pointer in xsk_ring_prod__submit().
One side only updates and the other side only reads. cached_cons is a
local variable and only for operations done by another core can we
observe loads being reordered with older stores to different
locations. Since no one else is touching cached_cons, this will not
happen.

/Magnus

> >
> >                 *idx =3D cons->cached_cons;
> >                 cons->cached_cons +=3D entries;
> > --
> > 2.7.4
> >
