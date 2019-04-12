Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E33BC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83372083E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 09:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOlj+gpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDLJB6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:01:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38952 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfDLJB6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 05:01:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so7343249oih.6;
        Fri, 12 Apr 2019 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/n1US8BwhLiKpoaWjq4aZBM9PxAmXIpRr3vqvQBh2sA=;
        b=IOlj+gpDibV43lAA6b1HkxwLpM90Wem8SxRD+pDDqiaKHvAWod5HKDZiiRlLI+By9H
         D4NAgLhY3Hl16SjZr+CX3YRg5O4gHynOT2DehK5FEeknYxckDSGIOvBYLGUlvFWscRuW
         D0eddG59GDvVfy4CZUxsPlm+Oy2Zf1X8Oh/IdpvhjMJLiR6Is8qnBBfv1kmpbPICUCu8
         at98OJEMpavwfbrexqfUEonF01tFGc94g7vKFqLeijWAlfBstEeaHBWg8I+swDAyyWCk
         ZV3bxVDCHBpk5g23pwWZiMEqrh7ERRO/Tm2ikD93mGqyWKsD5KEBgJbIsSNfv/GhNQQS
         9gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/n1US8BwhLiKpoaWjq4aZBM9PxAmXIpRr3vqvQBh2sA=;
        b=bAgMW/XNv5E3D06ci3BbEKdJFLhfXUF/ZzH8Qey7pOTz1dkj3FHgwTiYM3jcHygERj
         iBRZorPh3Lc5hOuWfPYDRBbcaECr/Gl+BXf4O66lqDNAunb/fwDgChDCI0TOJnkaBYL3
         cdnzN1n0Z2J+SojxEWAm6+Uni4TDtyXIQNv6Q6g/UMI7VfJcm4+3oiEn9XznWkmbrL7w
         D1/6b/t2tQowJxeYTYEVRV/SW3Q7bkgd4hlEuLafjJE1/+kM8tPW0Ma0zYL0nhSUu6lO
         pRVtB2hdM7RgXenj/jbpy+o0cJ5CBJYJP5Phkixcr8AaE+hN84E9ZNdTE3mnLJh6YQwW
         lQXQ==
X-Gm-Message-State: APjAAAVtEqYVtn6RZfq6JkT5WpVuxbHuk3Hg/wbIVRVbND8S+vlnVXVb
        MrZVyAIZuRvZZObCCdcGygxE2ct159FWGrNxFAE=
X-Google-Smtp-Source: APXvYqz9MpCihJtoorn5p1q3LtFsRZW8167JYwG3VYNvPE0u7006RjuLXraBbtmPKlKal23OXS536z1M/HC51vVLalA=
X-Received: by 2002:aca:4e50:: with SMTP id c77mr9244035oib.109.1555059717189;
 Fri, 12 Apr 2019 02:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com>
 <1554880154-30791-3-git-send-email-magnus.karlsson@intel.com>
 <CAH3MdRX64deNto0avW3XfexMLhNS+r75x3yea6ko+hmHrOE3aw@mail.gmail.com>
 <CAJ8uoz0suybHMmTGvRRU==L09j3h-dBAE5QeRuzqCqnTrYwK8A@mail.gmail.com> <9c517998-ee4e-cf22-8dd4-c0808a1f2d47@iogearbox.net>
In-Reply-To: <9c517998-ee4e-cf22-8dd4-c0808a1f2d47@iogearbox.net>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Fri, 12 Apr 2019 11:01:45 +0200
Message-ID: <CAJ8uoz1SASFenj80Cy3Fdb4VuK_=8henXioKS43Og1fwUVFpRQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Y Song <ys114321@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Apr 11, 2019 at 10:23 PM Daniel Borkmann <daniel@iogearbox.net> wro=
te:
>
> On 04/11/2019 09:54 AM, Magnus Karlsson wrote:
> > On Wed, Apr 10, 2019 at 9:08 PM Y Song <ys114321@gmail.com> wrote:
> >> On Wed, Apr 10, 2019 at 12:21 AM Magnus Karlsson
> >> <magnus.karlsson@intel.com> wrote:
> >>>
> >>> The use of smp_rmb() and smp_wmb() creates a Linux header dependency
> >>> on barrier.h that is uneccessary in most parts. This patch implements
> >>> the two small defines that are needed from barrier.h. As a bonus, the
> >>> new implementations are faster than the default ones as they default
> >>> to sfence and lfence for x86, while we only need a compiler barrier i=
n
> >>> our case. Just as it is when the same ring access code is compiled in
> >>> the kernel.
> >>>
> >>> Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
> >>> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> >>> ---
> >>>  tools/lib/bpf/xsk.h | 20 ++++++++++++++++++--
> >>>  1 file changed, 18 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> >>> index 3638147..69136d9 100644
> >>> --- a/tools/lib/bpf/xsk.h
> >>> +++ b/tools/lib/bpf/xsk.h
> >>> @@ -39,6 +39,22 @@ DEFINE_XSK_RING(xsk_ring_cons);
> >>>  struct xsk_umem;
> >>>  struct xsk_socket;
> >>>
> >>> +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
> >>
> >> Maybe add some comments to explain the different between bpf_smp_{r,w}=
mb
> >> and smp_{r,w}mb so later users will have a better idea which to pick?
> >
> > Ouch, that is a hard one. I would just recommend people to read
> > Documentation/memory-barriers.txt. My attempt at explaining all this
> > would not be pretty and likely sprinkled with errors ;-).
>
> I think Yonghong meant here place a comment wrt when to use the below ver=
sus
> when to use smp_{r,w}mb(). Both are essentially the same just that the ma=
in
> difference here would be that this header needs to be installed in the sy=
stem
> so users need to have it. I think it indeed makes sense to add a comment =
about
> this specific fact otherwise we might forget about it in few months.

Will do.

> >>> +# if defined(__i386__) || defined(__x86_64__)
> >>> +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
> >>> +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
> >>> +# elif defined(__aarch64__)
> >>> +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
> >>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> >>> +# elif defined(__arm__)
> >>> +/* These are only valid for armv7 and above */
> >>> +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
> >>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> >>> +# else
> >>> +#  error Architecture not supported by the XDP socket code in libbpf=
.
> >>> +# endif
> >>> +#endif
> >>
> >> Since this is generic enough and could be used by other files as well,
> >> maybe put it into libbpf_util.h?
>
> Hmm, maybe a good point. We could place it into libbpf.h as there is alre=
ady
> various misc helpers and xsk.h includes it anyway. But: if we do that, th=
en
> the above 'else' part would need some generic fallback (__sync_synchroniz=
e()
> plus a warning?) as otherwise compilation would break for everyone with '=
error'.
> Ideally this should then cover as much as possible from mainstream archs =
though.

I will give this a stab for the mainstream archs then fall back and
warn as you suggests. Will use the libbpf_ prefix.

> > Good question. Do not know. Daniel suggested introducing [0] and
> > perhaps that can be used by the broader libbpf code base? The
> > important part for this patch set is that these operations match the
> > ones in the kernel on the other end of the ring.
>
> Yeah, it can be used generally except for headers that are going to be
> installed where these are present in inline helper functions.
>
> > [0] https://lore.kernel.org/netdev/20181017144156.16639-2-daniel@iogear=
box.net/
> >
> >>> +
> >>>  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *=
fill,
> >>>                                               __u32 idx)
> >>>  {
> >>> @@ -119,7 +135,7 @@ static inline void xsk_ring_prod__submit(struct x=
sk_ring_prod *prod, size_t nb)
> >>>         /* Make sure everything has been written to the ring before s=
ignalling
> >>>          * this to the kernel.
> >>>          */
> >>> -       smp_wmb();
> >>> +       bpf_smp_wmb();
> >>>
> >>>         *prod->producer +=3D nb;
> >>>  }
> >>> @@ -133,7 +149,7 @@ static inline size_t xsk_ring_cons__peek(struct x=
sk_ring_cons *cons,
> >>>                 /* Make sure we do not speculatively read the data be=
fore
> >>>                  * we have received the packet buffers from the ring.
> >>>                  */
> >>> -               smp_rmb();
> >>> +               bpf_smp_rmb();
> >>
> >> Could you explain why a compiler barrier is good enough here on x86? N=
ote that
> >> the load cons->cached_cons could be reordered with earlier
> >> non-overlapping stores
> >> at runtime.
> >
> > The bpf_smp_rmb() is there to protect the data in the ring itself to
> > be read by the consumer before the producer has signaled that it has
> > finished =E2=80=9Cproducing=E2=80=9D them by updating the producer (hea=
d) pointer. As
> > stores are not reordered with other stores on x86 (nor loads with
> > other loads), the update of the producer pointer will always be
> > observed after the writing of the data in the ring, as that is done
> > before the update of the producer pointer in xsk_ring_prod__submit().
> > One side only updates and the other side only reads. cached_cons is a
> > local variable and only for operations done by another core can we
> > observe loads being reordered with older stores to different
> > locations. Since no one else is touching cached_cons, this will not
> > happen.
>
> From perf RB side, I found this one kernel/events/ring_buffer.c +72 to
> be very helpful. It's independent of this series, but I would appreciate
> if you could make similar scheme / comment somewhere in the AF_XDP code
> such that all barriers in there can be more easily followed wrt how they
> pair to user space.

That was very useful indeed and as we have the same structure this
also uncovered that we are missing an smp_mb in the (D) location below
for the ring to work on PPC64 and likely ARM too. On x86, it will work
without one since stores are not reordered with older loads (as
observed from another core), but there is only rmb, wmb and mb in
Linux (no rwmb or wrmb), so we are going to take a hit on x86 here.
But correctness for everyone always goes first. Will submit a new
patch set with this fix in the kernel also. The question is, can I
just refer to the perf_ring comments in the xsk.h code, or should I
largely copy it into the xsk code so it is there too?

As an optimization for the future, maybe we could do something along
the lines of Documentation/core-api/circular-buffers.rst, where
load_aqcuire and store_release are used instead of expensive memory
barriers. Do you guys have any experience using these primitives
instead and their performance on various platforms?

from kernel/events/ring_buffer.c:
*   kernel                             user
*
*   if (LOAD ->data_tail) {            LOAD ->data_head
*                      (A)             smp_rmb()       (C)
*      STORE $data                     LOAD $data
*      smp_wmb()       (B)             smp_mb()        (D)
*      STORE ->data_head               STORE ->data_tail
*   }
*
* Where A pairs with D, and B pairs with C.


> Thanks,
> Daniel
>
> > /Magnus
> >
> >>>
> >>>                 *idx =3D cons->cached_cons;
> >>>                 cons->cached_cons +=3D entries;
> >>> --
> >>> 2.7.4
> >>>
>
