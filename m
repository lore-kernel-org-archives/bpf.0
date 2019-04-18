Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9627DC10F0B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 07:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534E0214DA
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 07:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HssdTDWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfDRHNB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:13:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36732 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfDRHNA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 03:13:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so842820oia.3;
        Thu, 18 Apr 2019 00:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsHdWsQPb+CI0ZI2w5TH+cuUXyRmt7PoCsiGEWmCn8o=;
        b=HssdTDWwRglrkx8K1e397FqGfNy7KZvVfHbJdCWvb6uwFy4hNulthb5zujygizosE5
         Rh4PR83wZru3+OYYAmJu7WHoLKnx9C1HYzd7gNCHnSkHf6iIixwQvhK+jGAGLKkPGq7W
         Q9oPz0vxa6AL7bL+8wmCFNgLj7Ssv7Rrij6R5GNEb26JXNwnOlc9q9WL5dz36cjv4lrd
         krZjIjoaiRpR+V0MQS0OL8JlgkCZv1jDUWwpJXVRrJLk4ipeJJvbtUPqEfuJy9tT2B3Q
         +my9w34Rsblj/tx14+cQzKyLuqwr24+E8+/My3rky0OrGurHzFzxco7ZAIqN4cZMCnTa
         A5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsHdWsQPb+CI0ZI2w5TH+cuUXyRmt7PoCsiGEWmCn8o=;
        b=NwoKCBDwOpJutIPC5HRNAVQnxsyF2weHwpzM7yDYtmZGSgEaQKtY5Uwv/Sd0t5uXcc
         7+AnhjVPzX2eAmFI4awB4LF7ii33I1H8UrrHeu3aUpbQRsSMi50mHYfV1YoK2Ia21IdW
         FDKtLKvh9dlL5PsE0fVxPxfc163VF2UklH5Wo53YANj6Xl3/bhEOkf8u+CZF+0cwqGrb
         93275oWAK8176D2IqS2Nmbe5+a5fERDdeqM7mpFaG+8g+f6PBpssHzIbIqMLRGnwLqhf
         NavQ41PpGLAyb5yEmExScUmAlCWYdeUWnLkNsjgBNwvgXPiMKsvL6vUXBtKtdSti3IVs
         w/RQ==
X-Gm-Message-State: APjAAAWIc4gB/D2xNVLf70MTazBoE5H8RtIpxXb0+bXwhC5CwjkgoE6z
        ZmB1NkWuKXBtCOESr9OoLAMAqecC7zRWu5g/jX0=
X-Google-Smtp-Source: APXvYqwICRvtI3hDfyw2wW9iotB3Guj/h5O5A/XoJrnkhf2pL+lsP+/qscy43OXZkjMgI9u0CZkKB9SoTfBRLlND5F8=
X-Received: by 2002:aca:7505:: with SMTP id q5mr993134oic.126.1555571579703;
 Thu, 18 Apr 2019 00:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190418115748.0b0aefdc@canb.auug.org.au> <CAJ8uoz1T5xzx+RhJ=NZQ-WJhawE765ncMQUPMD9uGWHMeiuqOQ@mail.gmail.com>
 <20190418061842.t6ohwq6u7m33hcpo@ast-mbp.dhcp.thefacebook.com>
 <CAJ8uoz12d6mWBpVzmkWDFrFtOkVEJsk70poqzs9Q6YpeQHkObA@mail.gmail.com> <20190418065127.exojundvv42i2cjx@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190418065127.exojundvv42i2cjx@ast-mbp.dhcp.thefacebook.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Thu, 18 Apr 2019 09:12:48 +0200
Message-ID: <CAJ8uoz2g_pnnra+T+rArZvh1gAzEm2gwXLM5sHAMsYRV7_yEoQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 8:51 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 18, 2019 at 08:25:22AM +0200, Magnus Karlsson wrote:
> > On Thu, Apr 18, 2019 at 8:18 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 18, 2019 at 07:55:30AM +0200, Magnus Karlsson wrote:
> > > > On Thu, Apr 18, 2019 at 3:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > After merging the bpf-next tree, today's linux-next build (powerpc perf)
> > > > > failed like this:
> > > > >
> > > > > In file included from xsk.c:32:
> > > > > libbpf_util.h:49:3: error: #warning Architecture missing native barrier functions in libbpf_util.h. [-Werror=cpp]
> > > > >  # warning Architecture missing native barrier functions in libbpf_util.h.
> > > > >    ^~~~~~~
> > > > > cc1: all warnings being treated as errors
> > > > >
> > > > > Caused by commit
> > > > >
> > > > >   b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
> > > > >
> > > > > I have applied the following patch for today ... please fix this.
> > > > >
> > > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > Date: Thu, 18 Apr 2019 11:54:56 +1000
> > > > > Subject: [PATCH] suppress warning in tools/lib/bpf/libbpf_util.h
> > > > >
> > > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > ---
> > > > >  tools/lib/bpf/libbpf_util.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
> > > > > index 172b707e007b..a54eb2cdbdd6 100644
> > > > > --- a/tools/lib/bpf/libbpf_util.h
> > > > > +++ b/tools/lib/bpf/libbpf_util.h
> > > > > @@ -46,7 +46,7 @@ do {                          \
> > > > >  # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
> > > > >  # define libbpf_smp_rwmb() libbpf_smp_mb()
> > > > >  #else
> > > > > -# warning Architecture missing native barrier functions in libbpf_util.h.
> > > > > +//# warning Architecture missing native barrier functions in libbpf_util.h.
> > > > >  # define libbpf_smp_rmb() __sync_synchronize()
> > > > >  # define libbpf_smp_wmb() __sync_synchronize()
> > > > >  # define libbpf_smp_mb() __sync_synchronize()
> > > > > --
> > > > > 2.20.1
> > > > >
> > > > > --
> > > > > Cheers,
> > > > > Stephen Rothwell
> > > >
> > > > My apologies, I will fix this. I just have two questions first so I do
> > > > not mess things up.
> > > >
> > > > * I see my commit in bpf-next but not in bpf. As I submitted it
> > > > against bpf, what was the reason it was applied to bpf-next instead?
> > > > Unfortunately, I forgot to add "Fixes" tags to the commits, so was
> > > > this the reason? I view 4 out of 5 of these patches as bug fixes, the
> > > > last one being an optimization.
> > >
> > > new macros that users still have to learn how to use are hardly fixes.
> >
> > That is fair.
> >
> > > I can toss it out of bpf-next if it's easier.
> >
> > How about you toss it out of bpf-next, then I resubmit the first two
> > patches (the barrier fixes) to bpf and the last three (new macros,
> > etc.) to bpf-next? Would that make it easier for you?
>
> the easiest is to do a trivial patch for bpf-next,
> but if you insist on first two as fixes that is ok as well.

Will submit a trivial patch. Thanks for your quick answers and help.

/Magnus
