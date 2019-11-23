Return-Path: <SRS0=Pk2X=ZP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C446C432C0
	for <bpf@archiver.kernel.org>; Sat, 23 Nov 2019 21:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF22F2068F
	for <bpf@archiver.kernel.org>; Sat, 23 Nov 2019 21:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3PQeCH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfKWVxB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:53:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33631 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKWVxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 16:53:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id y39so12431303qty.0;
        Sat, 23 Nov 2019 13:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUIN6i06YclLfLY+yq4nzxe+SXxsGD7HMrIGxaIkbrc=;
        b=m3PQeCH7PiE2l4+pydstckjBYY0pmov6QLK3NW7iP/kvfj0Y06KHCIk5KEVgAiv4GX
         N7abMPFRkaPnsChs5PqCRiOLCcVd9hE/gQOyx9pHjeVlpJ/PnU8ijdl4qfahGtjInwZ+
         J68b4LVdggqhiFy7wOVI/TCmtKeKQ/JhkBRW06k6a5kUoSzFcxXdd1dVrAYUIQych3B4
         Pe++xkvbORxKlH11bOLHzTPfoEAahFiiLAO5iBMf2W+BjnFwAEuCBLWYGQDbrkSkk7Tl
         MdXRrd7QsK/W4KZ2h5GHfrf2QbeDSANQXoVBSG0Rzywrd9XiPXwON3b0Xuo3aCu5aaza
         rw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUIN6i06YclLfLY+yq4nzxe+SXxsGD7HMrIGxaIkbrc=;
        b=DlfVlJmk+rVux16I83yidnIwCbhHbP7ix6vNMHwn7mRdaWT91adQXeQAoLdkKaJ7Al
         HoBZxDLPHoQ49xXJKez/jM3SUY7/DuRL0xNRemvCPmB58pK3Og80DIRgKeeKGzT+eDOM
         jEBUVuSfbHUmfHzKFaqIXwr+6AykfWUSFTTFfMDhvxG+eEMJEicOI0F0pCG1GhKH8waZ
         7dK9vYovXZ0lfVTETsLY9aO6TxaGElojMQa67jbYlsW5mcQe4N6p9zzMkF/JdDdX375q
         r5fYdxC0RVDscmiZ9+LccsLUdTBRYpJwGKA4cbUTgVOMJY68oMplWIbhJg0rU951lQKA
         ApWw==
X-Gm-Message-State: APjAAAWzzj5zCVqUkwe14onwzY4ZRGZPhvnb5541flZglj7CvjgkJRAS
        Y4vrpUkEXgy7EU5GOPakiUFbOVsvNj8LV0V8/SY=
X-Google-Smtp-Source: APXvYqxjM+imOEA+wl39rQvoqSkblPVf8poHVHjf8wA61Jf9YmgMq+EA8Wgy2y8Gd0kRNiAybN0QuNkw0bdua2WvSic=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr4947560qtl.171.1574545978630;
 Sat, 23 Nov 2019 13:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20191123205628.828920-1-andriin@fb.com> <8bd4fa74-0f71-81b3-1dcd-ab09a695a763@iogearbox.net>
In-Reply-To: <8bd4fa74-0f71-81b3-1dcd-ab09a695a763@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 23 Nov 2019 13:52:47 -0800
Message-ID: <CAEf4BzYYSSqVTE606nmZPU0sShXf+CAk8g9pZhCjSmGkWWAAtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fail mmap without CONFIG_MMU
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 23, 2019 at 1:15 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/23/19 9:56 PM, Andrii Nakryiko wrote:
> > mmap() support for BPF array depends on vmalloc_user_node_flags, which is
> > available only on CONFIG_MMU configurations. Fail mmap-able allocations if no
> > CONFIG_MMU is set.
> >
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >   kernel/bpf/syscall.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index bb002f15b32a..242a06fbdf18 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -156,8 +156,12 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
> >       }
> >       if (mmapable) {
> >               BUG_ON(!PAGE_ALIGNED(size));
> > +#ifndef CONFIG_MMU
> > +             return NULL;
> > +#else
> >               return vmalloc_user_node_flags(size, numa_node, GFP_KERNEL |
> >                                              __GFP_RETRY_MAYFAIL | flags);
>
> Hmm, this should rather live in include/linux/vmalloc.h, otherwise every future
> user of vmalloc_user_node_flags() would need to add this ifdef? vmalloc.h has
> the below, so perhaps this could be added there instead:

Ok, I finally untangled this all. The real fix is to implement
vmalloc_user_node_flags() in mm/no_mmu.c. Took me a bit to understand
how all this stuff is supposed to compile. If you take a look at
vmalloc.h, you'll see that most variants of vmalloc() are not
conditionally defined like __vmalloc_node_flags_caller. I'll send a
different patch with proper fix in few minutes.

>
> [..]
> #ifndef CONFIG_MMU
> extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
> static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,
>                                                  gfp_t flags, void *caller)
> {
>          return __vmalloc_node_flags(size, node, flags);
> }
> #else
> extern void *__vmalloc_node_flags_caller(unsigned long size,
>                                           int node, gfp_t flags, void *caller);
> #endif
> [..]
>
> > +#endif
> >       }
> >       return __vmalloc_node_flags_caller(size, numa_node,
> >                                          GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> >
>
