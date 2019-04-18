Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18CCC10F0B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 06:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02532184B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 06:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqC5Fgn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfDRGZe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:25:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32987 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbfDRGZe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 02:25:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id e5so775212oii.0;
        Wed, 17 Apr 2019 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CdZYoW5MNChnJssdrQmXwmarE7Uapcp/UR7ZYd5yEc=;
        b=EqC5Fgn25tocypyBXi5sWJ/kEdsA/F3nJELFDqDup3jZRpANdpISAE6k6KlTjK1MDr
         LG58Pg3g+BfQ69IO00+69bZXC5ZM2orxxBrk+ece1qYTy8JC3t+zkLAHlV9g3/h1+R/K
         yiUknieQ9/1UKJZiKxMN29PBPyUt3IbxFQGIykTBrqC9jCz4lhiLpvmwlxY6rPlMla/Z
         aw83yWnqyJu7ElXL2h8WlsaHVjVQ7wbk0R6KTcYFA4zwCKa72B85kE5Cou2pABix0Jd3
         LLTTo4+BscxbYtU5VKntJgzNLF1pjMfdgOlcCM6+6G+Yj7QWR+nrlIoBIRbhJ3JUrMix
         dM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CdZYoW5MNChnJssdrQmXwmarE7Uapcp/UR7ZYd5yEc=;
        b=Unm9x+s6Ack85ekOHyY9xA/HIbkIHBnj+DPXQGkWS/RR6BxgybRgRInIFzSa3GIQ8C
         gWck2ng9BU7DwRtwjTDwWYTiFjoxKHRAGhDTt8K6zSw4QYzcQH6KY0ny0zeuJ0UCDHKC
         PHAiUE+i/5RzMYb2BCYyS6G3fDzT45IOvshA633X4MmLOpJdeqJGwGy+3GDiVECQYiUz
         SlpxBp1NDe1XFpxZE/q2bRKZgLxLGB6SY8sfqu9FxGPiB8XDoc86KHHV3jKBEBf919po
         GuJuOucWRWXtgUkebjkgakbiemMwt5atq43UPZF0R7i20DUlVQy8EeoCNVKMqGddRI4G
         s+DA==
X-Gm-Message-State: APjAAAUaulaPA+/luuajKC//xlJa8QM+sIpHHUKwpSpMPN4sk3U8lYP1
        0V3iuj9c1POmcUieIU2+EpI7Kgz4L5YcCu7D/cFJRQ0N
X-Google-Smtp-Source: APXvYqzzN95YJvQ8eZLg2U4pcnnv3PSfONrZKiwfgZfH5lv7APC80c8EZ3dip41vJdggX0TyKV2mev/RONGVr0zU2pA=
X-Received: by 2002:aca:4e50:: with SMTP id c77mr882402oib.109.1555568733306;
 Wed, 17 Apr 2019 23:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190418115748.0b0aefdc@canb.auug.org.au> <CAJ8uoz1T5xzx+RhJ=NZQ-WJhawE765ncMQUPMD9uGWHMeiuqOQ@mail.gmail.com>
 <20190418061842.t6ohwq6u7m33hcpo@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190418061842.t6ohwq6u7m33hcpo@ast-mbp.dhcp.thefacebook.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Thu, 18 Apr 2019 08:25:22 +0200
Message-ID: <CAJ8uoz12d6mWBpVzmkWDFrFtOkVEJsk70poqzs9Q6YpeQHkObA@mail.gmail.com>
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

On Thu, Apr 18, 2019 at 8:18 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 18, 2019 at 07:55:30AM +0200, Magnus Karlsson wrote:
> > On Thu, Apr 18, 2019 at 3:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the bpf-next tree, today's linux-next build (powerpc perf)
> > > failed like this:
> > >
> > > In file included from xsk.c:32:
> > > libbpf_util.h:49:3: error: #warning Architecture missing native barrier functions in libbpf_util.h. [-Werror=cpp]
> > >  # warning Architecture missing native barrier functions in libbpf_util.h.
> > >    ^~~~~~~
> > > cc1: all warnings being treated as errors
> > >
> > > Caused by commit
> > >
> > >   b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
> > >
> > > I have applied the following patch for today ... please fix this.
> > >
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Thu, 18 Apr 2019 11:54:56 +1000
> > > Subject: [PATCH] suppress warning in tools/lib/bpf/libbpf_util.h
> > >
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  tools/lib/bpf/libbpf_util.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
> > > index 172b707e007b..a54eb2cdbdd6 100644
> > > --- a/tools/lib/bpf/libbpf_util.h
> > > +++ b/tools/lib/bpf/libbpf_util.h
> > > @@ -46,7 +46,7 @@ do {                          \
> > >  # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
> > >  # define libbpf_smp_rwmb() libbpf_smp_mb()
> > >  #else
> > > -# warning Architecture missing native barrier functions in libbpf_util.h.
> > > +//# warning Architecture missing native barrier functions in libbpf_util.h.
> > >  # define libbpf_smp_rmb() __sync_synchronize()
> > >  # define libbpf_smp_wmb() __sync_synchronize()
> > >  # define libbpf_smp_mb() __sync_synchronize()
> > > --
> > > 2.20.1
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell
> >
> > My apologies, I will fix this. I just have two questions first so I do
> > not mess things up.
> >
> > * I see my commit in bpf-next but not in bpf. As I submitted it
> > against bpf, what was the reason it was applied to bpf-next instead?
> > Unfortunately, I forgot to add "Fixes" tags to the commits, so was
> > this the reason? I view 4 out of 5 of these patches as bug fixes, the
> > last one being an optimization.
>
> new macros that users still have to learn how to use are hardly fixes.

That is fair.

> I can toss it out of bpf-next if it's easier.

How about you toss it out of bpf-next, then I resubmit the first two
patches (the barrier fixes) to bpf and the last three (new macros,
etc.) to bpf-next? Would that make it easier for you?

Thanks: Magnus


/Magnus
