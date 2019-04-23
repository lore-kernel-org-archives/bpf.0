Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09532C282E1
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB86E21738
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRPDTNZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfDWWHA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:07:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38827 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfDWWHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 18:07:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id s2so9220787vsi.5
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSxIGA8gUh/Ki1zPwTNkG4y9fyDrsJ7jFAaFBs+VOkQ=;
        b=dRPDTNZ5/nDge/MaqwsObHEqgu9g16gyDrl8IAYONtJplWS/Xx5TEe0TqTaTFIzEZt
         c3OY5+TSWczXDV1AG8OkrStxr4Sm+zDEu43v8729egQzabMCIS6cEZ0p08RJZGPl3OHd
         LHTAOacko1/529RbdqTQydTddkE8eMuhtYw+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSxIGA8gUh/Ki1zPwTNkG4y9fyDrsJ7jFAaFBs+VOkQ=;
        b=ZwcbsX3iWaTnKWM0y0ohYCOoZjZGJWcFI+S6/PBu29P1Twx1nBegRcKTVwvUGsLKQE
         15d5qtvYqVzuccgSJw3orMyK7votefUlMANGbVZpgWKGwLALtfpO6Frt4lS5vP7vSRP7
         7pJjqQjRB2I53dk+ZwWo7aft3A5se8Jy5DK44yf7lV/ruxbbr+oTIEu8s8B5ylRxFKtq
         6+czIU2ScV58qruuz8HW33MJH8NAh+yE7Tl6B1rxFCg7fg8pUDBJ46JAEhplA1nA2KOd
         2L1Iq13GHQr2OReZ4YDNqziC553bZ28Isqp0c5Fp0NDhY4biqf6TktbSi86bf7NHVae0
         jVjw==
X-Gm-Message-State: APjAAAUH2XdSC5ZsBPaUvE2m+UtzLgMcMVIICJr2h5XJIxwaz1fr04M0
        CEXoL3JtTJwD2xwlAo1REtUda0jwOCQ=
X-Google-Smtp-Source: APXvYqzodIEAaOYeJzjNY/A4EH4QTrlPJ8FGsYjSZkjiVp9EoE/pmJ3fYhwwVV5vd4Lv0J78dlv78A==
X-Received: by 2002:a67:c812:: with SMTP id u18mr14003352vsk.87.1556057218908;
        Tue, 23 Apr 2019 15:06:58 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 1sm3301095uax.3.2019.04.23.15.06.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:06:57 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id e2so9210659vsc.13
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 15:06:57 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr14860664vsp.188.1556057217005;
 Tue, 23 Apr 2019 15:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c8f45a0584e69ea9@google.com> <CAGXu5jLBd-u=ywxiEjmrLMj9TMRVnLOHHKfWKQ_fEosDFjPoog@mail.gmail.com>
 <20190423215127.GJ3758@cisco>
In-Reply-To: <20190423215127.GJ3758@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:06:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLmfN2jT0+V0RDwVZjBEw2Vm6QVH1KR_gykFg_b+3Wu7w@mail.gmail.com>
Message-ID: <CAGXu5jLmfN2jT0+V0RDwVZjBEw2Vm6QVH1KR_gykFg_b+3Wu7w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in seccomp_notify_release (2)
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        coreteam@netfilter.org, Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Martin KaFai Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Network Development <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>, wenxu@ucloud.cn,
        Yonghong Song <yhs@fb.com>,
        syzbot <syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 23, 2019 at 2:51 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Tue, Apr 23, 2019 at 02:39:52PM -0700, Kees Cook wrote:
> > On Mon, Mar 25, 2019 at 1:02 AM syzbot
> > <syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    1bdd3dbf Merge tag 'io_uring-20190323' of git://git.kernel..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12ae5b93200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b562969adb2e04af3442
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162ca25d200000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1733b53b200000
> > >
> > > The bug was bisected to:
> > >
> > > commit a799aea0988ea0d1b1f263e996fdad2f6133c680
> > > Author: wenxu <wenxu@ucloud.cn>
> > > Date:   Wed Jan 9 02:40:11 2019 +0000
> > >
> > >      netfilter: nft_flow_offload: Fix reverse route lookup
> >
> > This bisection looks bogus?
> >
> > However, I _can_ trigger the problem on this kernel version with this
> > config. (And not with Linus's latest tree.)
> >
> > The PoC is identical to the prior report[1] that we thought was fixed.
> > Perhaps the fix didn't actually fix it? (I mean
> > a811dc61559e0c8003f1086c2a4dc8e4d5ae4cb8) But it's been silent for 29
> > days now, so I'm not sure what's going on.
> >
> > Tycho are you able to reproduce this on the older tree?
>
> It looks like this case is using TSYNC and NEW_LISTENER together:
>
> syscall(__NR_seccomp, 1, 0xb, 0x20000140);

Ah, thanks. My eye-diff didn't work. :)

> and I did fix a uaf with TSYNC and NEW_LISTENER in this series:
>
> https://lore.kernel.org/lkml/20190306201413.14153-2-tycho@tycho.ws/T/#u
>
> which seems like it's probably related. I don't think the above ever
> got applied though?

Whoops, I lost this. Let me go dig that up. Thanks!

-- 
Kees Cook
