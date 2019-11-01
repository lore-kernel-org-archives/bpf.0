Return-Path: <SRS0=TYu4=YZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27AFCA9ECF
	for <bpf@archiver.kernel.org>; Fri,  1 Nov 2019 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47A320679
	for <bpf@archiver.kernel.org>; Fri,  1 Nov 2019 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBm4KvWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKAUli (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:41:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36638 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKAUli (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 16:41:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id a6so4726582lfo.3;
        Fri, 01 Nov 2019 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KN4Jdtp9LUapC9U+M7QUkcIF7BvznNwkZ3XCYterB2M=;
        b=ZBm4KvWO5GSv0xZ+bwoi/rFzx9sA+RUjwql+qHoWDoQXeX9Fs8JmzpRL/FRLvsBaZ1
         yumoEfD512+PXAFQNtkpbX8iZtEiAGbZFeAYxHJE9tvGxSLuSBUW67LN5Zl5tKWTs5H/
         zuEkgTa+GAe5y7IxeDfoct7EveB8fum3VG9chLcLMHJ0+O/Nv0/N+Ub+IuD3TM/sKGJ7
         3Z0qMlt1EcF2pXC5T8v2YURrwnsCngBWdkZvn7y1uMMpltsN0J+aaU0J78HoWYOhsYOm
         Mbr+iJ3U9o+I7NJe/16zBjHgojX7Wiu0dk8XHCFKffaA+6bjody3eI+0jnGEVLM4CVpe
         YLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KN4Jdtp9LUapC9U+M7QUkcIF7BvznNwkZ3XCYterB2M=;
        b=RmsmjNHsv1Sr4IRAEj434vV3SkA7DThvvh/0z/9/r2QJ2qjiw/+w6VRZguonjP0fz8
         /fRSFnxKcMuOGfO50Hbcfzmr4jieAq72nNcsgDtSx1Le4UyukKaGOC5OBke6XrshUsa7
         3z/hRRgXemZwYC6fuzHJJ7pwZH8cdUOvC4sO+eXFPWCp/IXhfjYQLeHQMmyzgZnfJAOY
         MPO6rXYFBMRfTrZq+HQffpl+KeDxxfyCzs1GW8pVinoN0ZVMkVRab1fBHJygolLf1NO2
         WeNib9DcIlHpmbr6I0dFbKTQZeik1MAkaQRVBO2VShcliFkgKAl9RkdU4vhY4GZlrLaa
         cVPA==
X-Gm-Message-State: APjAAAV4NPRmOR8PXWTRTqN/LRYj9xCvuEb11M+yMo8CseYDYnBJa4sF
        qKw0jDhFPF5Xqpyn8QYmbm9C7j7QibeWolU0/iY=
X-Google-Smtp-Source: APXvYqyIYo5QWsf8JxGf8lW+UP37uYwWzet4QW/bTEtiR5QXnpPDQ14lc9CqYXWbdNtJEMqSUOSPmSmyYNxoi2PFjTo=
X-Received: by 2002:a19:7511:: with SMTP id y17mr8743962lfe.19.1572640895611;
 Fri, 01 Nov 2019 13:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <87lft1ngtn.fsf@toke.dk> <CAADnVQLrg6f_zjvNfiEVfdjcx9+DW_RFjVGetavvMNo=VXAR+g@mail.gmail.com>
 <87imo5ng7w.fsf@toke.dk> <CAADnVQLJ2JTsbxd2am6XY0EiocMgM29JqFVRnZ9PBcwqd7-dAQ@mail.gmail.com>
 <87d0ednf0t.fsf@toke.dk> <CAADnVQ+V4OMjJqSdE_OQ1Vr99kqTF=ZB3UUMKiCSg=3=c+exqg@mail.gmail.com>
 <20191031174208.GC2794@krava> <CAADnVQJ=cEeFdYFGnfu6hLyTABWf2==e_1LEhBup5Phe6Jg5hw@mail.gmail.com>
 <20191031191815.GD2794@krava> <CAADnVQJdAZS9AHx_B3SZTcWRdigZZsK1ccsYZK0qUsd1yZQqbw@mail.gmail.com>
 <20191101072707.GE2794@krava> <CAADnVQJnTuADcPizsD+hFx4Rvot0nqiX83M+ku4Nu_qLh2_vyg@mail.gmail.com>
 <87bltvmlsr.fsf@toke.dk>
In-Reply-To: <87bltvmlsr.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 1 Nov 2019 13:41:23 -0700
Message-ID: <CAADnVQJJcx8NszLBMSN0wiR43UEgGki38u0etnWvpMVG=8+ngg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: fix compatibility for kernels without need_wakeup
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        bpf <bpf@vger.kernel.org>, degeneloy@gmail.com,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 1, 2019 at 12:36 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Nov 1, 2019 at 12:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >>
> >> On Thu, Oct 31, 2019 at 01:39:12PM -0700, Alexei Starovoitov wrote:
> >> > On Thu, Oct 31, 2019 at 12:18 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >> > > >
> >> > > > yes. older vmlinux and newer installed libbpf.so
> >> > > > or any version of libbpf.a that is statically linked into apps
> >> > > > is something that libbpf code has to support.
> >> > > > The server can be rebooted into older than libbpf kernel and
> >> > > > into newer than libbpf kernel. libbpf has to recognize all these
> >> > > > combinations and work appropriately.
> >> > > > That's what backward and forward compatibility is.
> >> > > > That's what makes libbpf so difficult to test, develop and code =
review.
> >> > > > What that particular server has in /usr/include is irrelevant.
> >> > >
> >> > > sure, anyway we can't compile following:
> >> > >
> >> > >         tredaell@aldebaran ~ $ echo "#include <bpf/xsk.h>" | gcc -=
x c -
> >> > >         In file included from <stdin>:1:
> >> > >         /usr/include/bpf/xsk.h: In function =E2=80=98xsk_ring_prod=
__needs_wakeup=E2=80=99:
> >> > >         /usr/include/bpf/xsk.h:82:21: error: =E2=80=98XDP_RING_NEE=
D_WAKEUP=E2=80=99 undeclared (first use in this function)
> >> > >            82 |  return *r->flags & XDP_RING_NEED_WAKEUP;
> >> > >         ...
> >> > >
> >> > >         XDP_RING_NEED_WAKEUP is defined in kernel v5.4-rc1 (77cd0d=
7b3f257fd0e3096b4fdcff1a7d38e99e10).
> >> > >         XSK_UNALIGNED_BUF_ADDR_MASK and XSK_UNALIGNED_BUF_OFFSET_S=
HIFT are defined in kernel v5.4-rc1 (c05cd3645814724bdeb32a2b4d953b12bdea5f=
8c).
> >> > >
> >> > > with:
> >> > >   kernel-headers-5.3.6-300.fc31.x86_64
> >> > >   libbpf-0.0.5-1.fc31.x86_64
> >> > >
> >> > > if you're saying this is not supported, I guess we could be postpo=
ning
> >> > > libbpf rpm releases until we have the related fedora kernel releas=
ed
> >> >
> >> > why? github/libbpf is the source of truth for building packages
> >> > and afaik it builds fine.
> >>
> >> because we will get issues like above if there's no kernel
> >> avilable that we could compile libbpf against
> >
> > what is the issue again?
> > bpf-next builds fine. github/libbpf builds fine.
> > If distro is doing something else it's distro's mistake.
>
> With that you're saying that distros should always keep their kernel
> headers and libbpf version in sync. Which is fine in itself; they can
> certainly do that.

No. I'm not suggesting that.
distro is free to package whatever /usr/include headers.
kernel version is often !=3D /usr/include headers

> The only concern with this is that without a flow of bugfixes into the
> 'bpf' tree (and stable), users may end up with buggy versions of libbpf.
> Which is in no one's interest. So how do we avoid that?

As I explained earlier. There is no 'bpf' tree for libbpf. It always
moves forward.
