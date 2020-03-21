Return-Path: <SRS0=ZqvJ=5G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11992C4332D
	for <bpf@archiver.kernel.org>; Sat, 21 Mar 2020 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC327206F9
	for <bpf@archiver.kernel.org>; Sat, 21 Mar 2020 23:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+rKcv6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCUXER (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 21 Mar 2020 19:04:17 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41828 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCUXER (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Mar 2020 19:04:17 -0400
Received: by mail-yb1-f193.google.com with SMTP id d5so4773796ybs.8;
        Sat, 21 Mar 2020 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKwVDcJTc5OYl4qzqMEeBAMQqTUE8Dy2xO4au+/6vDg=;
        b=s+rKcv6ki5eKZyqMg2bIh5SNrDYr31656rsq2vgC8lrwJwBoemQgfvoDP1EALwK9WH
         R10+90HltsorVO4sPT/IeD0WxT5a1MFTu/Px6D7Q/cJJ3Edble+4I7OWMPVIDRDQThbh
         Lpc5BOlQZCOWi3s7l/6v55QtS4FO7l2kAVyD0PuTJ6RbIqlXBs1npMqaBK+aPQmZUaj1
         5xydSNle2/Dx6ShJH2MPul+Prrk0arulUM+XGhruclkAGaX8aU53jH1tBhA18cN/tkA3
         4LUNXM6Fsuk5aGMX0COaaKtrah8gTWYqnzLMcAjy7YJpE7Xq1A4IwoEup07whRX1qfI3
         cbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKwVDcJTc5OYl4qzqMEeBAMQqTUE8Dy2xO4au+/6vDg=;
        b=HTsl23sw9sbQZpXn+qyeT+22cKE8VqAPyVqXhc/8TUDgeQD5UJzj2fGE3DMiWf1VSp
         b3c1gNDS7ZlGJBilKJcZj2RcHZmYWROWJy/MpKiIFBHortKNbIOBfIw5riag4XV/bYHX
         gOfbAbD7KUaBYeEuH32JUGoXj1B2MUllok6JsUh1fH7cP4HbO1MvuSyD4SJN9teBn73g
         MsLHSmIkp0l9vKloZWycMbZgYB76oYeUT5hqxJS0yltRBW4jiz1HiDKyy0IncazymSbN
         OftZhSWdWg2KIjkG5MtgQcjjo1A3gjBtBY3OB7oQ8/W1/vNeiwS0ny3n924Bo3x2fibe
         /VRg==
X-Gm-Message-State: ANhLgQ17PxdjWFJ4eAKA8HsbsZLrp0ifbDorcqI4y01Dux3seBHR0q4u
        moJxbsLlROutkonIelppvnZLmJ1MlGKne7gC+S8xEE7EZ4RnbrM=
X-Google-Smtp-Source: ADFU+vsT3/Cskft+q40iRMRORcO9BPukQLWXjAMsKcgZHMSv8A2+ON3IokMs3jjGwQ4WijnD08VV9UAOtyaQEwMyM2M=
X-Received: by 2002:a25:684:: with SMTP id 126mr24406132ybg.164.1584831855783;
 Sat, 21 Mar 2020 16:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200321100424.1593964-1-danieltimlee@gmail.com>
 <20200321100424.1593964-3-danieltimlee@gmail.com> <CAEf4BzbTYyBG4=Muj5EOqtNxkivtT9Bn5+ibmp3e-BLBybQO1A@mail.gmail.com>
In-Reply-To: <CAEf4BzbTYyBG4=Muj5EOqtNxkivtT9Bn5+ibmp3e-BLBybQO1A@mail.gmail.com>
From:   "Daniel T. Lee" <danieltimlee@gmail.com>
Date:   Sun, 22 Mar 2020 08:03:59 +0900
Message-ID: <CAEKGpzjpHGiR3NQwcW_-z=_p2TBc=_qU6XQspF8wBE=ez6oMNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] samples: bpf: refactor perf_event user
 program with libbpf bpf_link
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you for your time and effort for the review :)

Best,
Daniel

On Sun, Mar 22, 2020 at 4:43 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Mar 21, 2020 at 3:04 AM Daniel T. Lee <danieltimlee@gmail.com> wrote:
> >
> > The bpf_program__attach of libbpf(using bpf_link) is much more intuitive
> > than the previous method using ioctl.
> >
> > bpf_program__attach_perf_event manages the enable of perf_event and
> > attach of BPF programs to it, so there's no neeed to do this
> > directly with ioctl.
> >
> > In addition, bpf_link provides consistency in the use of API because it
> > allows disable (detach, destroy) for multiple events to be treated as
> > one bpf_link__destroy. Also, bpf_link__destroy manages the close() of
> > perf_event fd.
> >
> > This commit refactors samples that attach the bpf program to perf_event
> > by using libbbpf instead of ioctl. Also the bpf_load in the samples were
> > removed and migrated to use libbbpf API.
> >
> > Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
> >
> > ---
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
> > Changes in v2:
> >  - check memory allocation is successful
> >  - clean up allocated memory on error
> >
> > Changes in v3:
> >  - Improve pointer error check (IS_ERR())
> >  - change to calloc for easier destroy of bpf_link
> >  - remove perf_event fd list since bpf_link handles fd
> >  - use newer bpf_object__{open/load} API instead of bpf_prog_load
> >  - perf_event for _SC_NPROCESSORS_ONLN instead of _SC_NPROCESSORS_CONF
> >  - find program with name explicitly instead of bpf_program__next
> >  - unconditional bpf_link__destroy() on cleanup
> >
> > Changes in v4:
> >  - bpf_link *, bpf_object * set NULL on init & err for easier destroy
> >  - close bpf object with bpf_object__close()
> >
> > Changes in v5:
> >  - on error, return error code with exit
> >
> >  samples/bpf/Makefile           |   4 +-
> >  samples/bpf/sampleip_user.c    |  98 +++++++++++++++--------
> >  samples/bpf/trace_event_user.c | 139 ++++++++++++++++++++++-----------
> >  3 files changed, 159 insertions(+), 82 deletions(-)
> >
>
> [...]
