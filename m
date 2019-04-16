Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F6C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB9C2075B
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="g9MK7Hr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDPV2S (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:28:18 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39918 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPV2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 17:28:17 -0400
Received: by mail-qt1-f180.google.com with SMTP id t28so25106428qte.6
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=39g6Hhllvi1gCzbEu1a/yyesKfhE72xLHmScXalWd/w=;
        b=g9MK7Hr8smvyXYSofzC3Uchubpqipw4oW6ELhkJ0xpicaI6ZBLHAMkn0KufWgFHZr2
         CAdE24f9gfzppcLOKjST/ql29uDWLe0uBlXkD6arpiGJnUB2QUmt9BoKI+EGda0kci3x
         j4Uv4Ly1nGZWDzYXu27NiADcJCvRi4zUXsDaFVgZYJ14NY04h6cVfBO4r1FlQ7GTa26e
         YOxiltCZQQ00B6OrXBanB8NsAmnyXEjkGajQfC5VCxN6bxs45YOpkRq/rcpbj9bloN94
         s6D+ENcakpDf4Xee6J+CZLpuBd2h05FbbiNN4nqcGwY2vclQbRVSNpao+FmVoj3xfxo0
         9QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=39g6Hhllvi1gCzbEu1a/yyesKfhE72xLHmScXalWd/w=;
        b=RyBshwnWOr2yYgKw6xFrzhsYQWNwhggZCWgbeE3JT7G2KGPyZ2n5qJ3mAs+NPoAZ2G
         skmIoP0xgtBp/+yUYJtc3VLsv0GxtiuQjUZbfsWvCA0md1xKsF9ErZX7wiZqmWZaTA5N
         pB8SRVpRjXHCUvuK9FHcw+A4dJEBR//YyLlBDpVURcPMmY0FBwO0ZzlL0ej+btxtE6p3
         wgPmECw5rGX8yncvIuEXqZwAz7sd425naebjQVJ9lsq5zuei4KIgSZFeE4TZy4YUrFdv
         g04ui4B1g+2KM4D5GAZOWyiIGQ2nVNvSgRBWGk6IGSBgLQzSqiBHsj1MpeUAh8vcj07b
         vydA==
X-Gm-Message-State: APjAAAWGAlNeyzIBi2P2wd7Hw8V99UF2bSyiAj8vaHLyUMcge70UGP9i
        nZ+RvsZfhEXlfm9CpiFmi8BIuA==
X-Google-Smtp-Source: APXvYqzbumkJtSkVnI1AQmqB8LkoDBJRYFWgmraivx78sDNdUVJUSNKBiww2Zl9YxKkAXWK2yD6fVg==
X-Received: by 2002:a0c:874a:: with SMTP id 10mr69777453qvi.164.1555450097036;
        Tue, 16 Apr 2019 14:28:17 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y55sm35084276qtk.13.2019.04.16.14.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 14:28:16 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:28:11 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ilias.apalodimas@linaro.org, toke@redhat.com,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: Per-queue XDP programs, thoughts
Message-ID: <20190416142811.3b3e3c16@cakuba.netronome.com>
In-Reply-To: <20190416155446.00472ad1@carbon>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
        <20190405131745.24727-2-bjorn.topel@gmail.com>
        <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
        <20190415183258.36dcee9a@carbon>
        <20190415154932.79bc3b57@cakuba.netronome.com>
        <20190416155446.00472ad1@carbon>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Apr 2019 15:55:23 +0200, Jesper Dangaard Brouer wrote:
> On Mon, 15 Apr 2019 15:49:32 -0700
> Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
>=20
> > On Mon, 15 Apr 2019 18:32:58 +0200, Jesper Dangaard Brouer wrote: =20
> > > On Mon, 15 Apr 2019 13:59:03 +0200 Bj=C3=B6rn T=C3=B6pel <bjorn.topel=
@intel.com> wrote:   =20
> > > > Hi,
> > > >=20
> > > > As you probably can derive from the amount of time this is taking, =
I'm
> > > > not really satisfied with the design of per-queue XDP program. (Tha=
t,
> > > > plus I'm a terribly slow hacker... ;-)) I'll try to expand my think=
ing
> > > > in this mail!   =20
> >=20
> > Jesper was advocating per-queue progs since very early days of XDP.
> > If it was easy to implement cleanly we would've already gotten it ;) =20
>=20
> (I cannot help to feel offended here...  IMHO that statement is BS,
> that is not how upstream development work, and sure, I am to blame as
> I've simply been to lazy or busy with other stuff to implement it.

Sincere apologies, definitely not what I was trying to say.

> It is not that hard to send down a queue# together with the XDP attach
> command.)=20

That part is not hard, agreed.

> I've been advocating for per-queue progs from day-1, since this is an
> obvious performance advantage, given the programmer can specialize the
> BPF/XDP-prog to the filtered traffic.  I hope/assume we are on the same
> pages here, that per-queue progs is a performance optimization.
>=20
> I guess the rest of the discussion in this thread is (1) if we can
> convince each-other that someone will actually use this optimization,
> and (2) if we can abstract this away from the user.

Yes, agreed.

