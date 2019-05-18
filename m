Return-Path: <SRS0=h6Pc=TS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03080C04AAF
	for <bpf@archiver.kernel.org>; Sat, 18 May 2019 08:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E9A20872
	for <bpf@archiver.kernel.org>; Sat, 18 May 2019 08:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acZYIvrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfERIuH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 18 May 2019 04:50:07 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36094 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERIuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 May 2019 04:50:07 -0400
Received: by mail-ot1-f46.google.com with SMTP id c3so8878716otr.3;
        Sat, 18 May 2019 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uhNAFNwyN2giSl8NmeogH/ZaSSnt4O29xUvEg2ZSpc=;
        b=acZYIvrzg2aQ+j4T56VqFgtj0CCzC/86Trkl71kBg88O0LYX/CaaZudI9cRc0AmaBk
         x25RZx+VaC0RINN0hjTKghQ73Xm/H0fHxppX9aF+KwkfRGtCdRkHdt5/V8+UzJj3ZKD3
         XmIWKo746KuJQ/ck7WBaRxEZ8BRgiUZr5/U4iSalcAtupEaCx2I9xw2H6du4uXvcD0Fe
         eT5NevJtywhWbssJuKXLvLBxSmmhN35Dk7YKrjmjaxCu4O+KLHzp0vLzrqWko2/HW4C6
         WDZI6w88V4m6TmfyTfDUqF6999nIxK11MvnkgR9oLQmy65GQN9XJ3La0nxi4Dr/V9wBT
         J/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uhNAFNwyN2giSl8NmeogH/ZaSSnt4O29xUvEg2ZSpc=;
        b=SaqR3e/CGHsi9IIlM4tsFenClxwf7SA0d2JwZxSoOvGZ8Js4IYKNGP1AK+JCYejSvI
         3ANsokRZ3FaJh/VY2HK65drhRGrDpgaScPlksBVs77tklGoDpyIKQ+Hnh8sPdLKjP7lh
         tZbo8aBWPBvwO9xNka7ZUql3NgEKIUSRUB4uoCq9kXoq0HaIzD+F9lv/mwnskZUxrgqb
         hdKmLeaJHmmweXU+pDujjpFjUheN15ip/8GbzpXwTdiUu7oD1FpGc6mj7+zfSF9+fggK
         YcPPiF/rPdRjAYwbO8HSc2u1DeG+FGns7py4ysI3Dv1FDsU6kKwzzuhzVWolldMsZBkK
         08FA==
X-Gm-Message-State: APjAAAVoMk8PL3PdKhgx6DvRMwnIr25QzKD8b3VFgKmUCcx+XWcQx2K+
        whU/fROWzWuL0iYAcH2iIDSBpV+NOs0XvXig5Sc=
X-Google-Smtp-Source: APXvYqxU6m+LCQmv+CIK6cRcDEwi7PCakyLvGEbrW+Fnf1iSP8gsl4L32Okog+BMnxEZVx2wQLqF8Gd/K668+//sQC0=
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr2884906otg.30.1558169406272;
 Sat, 18 May 2019 01:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <1556786363-28743-1-git-send-email-magnus.karlsson@intel.com>
 <20190506163135.blyqrxitmk5yrw7c@ast-mbp> <CAJ8uoz2MFtoXwuhAp5A0teMmwU2v623pHf2k0WSFi0kovJYjtw@mail.gmail.com>
 <20190507182435.6f2toprk7jus6jid@ast-mbp> <CAJ8uoz24HWGfGBNhz4c-kZjYELJQ+G3FcELVEo205xd1CirpqQ@mail.gmail.com>
 <CAJ8uoz1i72MOk711wLX18zmgo9JS+ztzSYAx0YS0VKxkbvod-w@mail.gmail.com> <20190517112003.02b130b2@cakuba.netronome.com>
In-Reply-To: <20190517112003.02b130b2@cakuba.netronome.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Sat, 18 May 2019 10:49:55 +0200
Message-ID: <CAJ8uoz2bEM2LvYWvMLHhYiVjt=ZYzkBku7Zuy8Oeri3BcVFLAg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/7] busy poll support for AF_XDP sockets
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Jonathan Lemon <bsd@fb.com>,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 17, 2019 at 8:20 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Thu, 16 May 2019 14:37:51 +0200, Magnus Karlsson wrote:
> >                                       Applications
> > method  cores  irqs        txpush        rxdrop      l2fwd
> > ---------------------------------------------------------------
> > r-t-c     2     y           35.9          11.2        8.6
> > poll      2     y           34.2           9.4        8.3
> > r-t-c     1     y           18.1           N/A        6.2
> > poll      1     y           14.6           8.4        5.9
> > busypoll  2     y           31.9          10.5        7.9
> > busypoll  1     y           21.5           8.7        6.2
> > busypoll  1     n           22.0          10.3        7.3
>
> Thanks for the numbers!  One question that keeps coming to my mind
> is how do the cases compare on zero drop performance?
>
> When I was experimenting with AF_XDP it seemed to be slightly more
> prone to dropping packets than expected.  I wonder if you're seeing
> a similar thing (well drops or back pressure to the traffic generator)?
> Perhaps the single core busy poll would make a difference there?

Good question. I will run the experiments and see what we get.

/Magnus
