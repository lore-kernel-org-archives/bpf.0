Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D708C282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEAF2173C
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qVqLhDu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDPVSI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:18:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40888 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfDPVSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 17:18:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so25049779qts.7
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rXXSvI6oNoyQK8aQO/UjpFHju3BpjEpUWaQ3xz1dKEE=;
        b=qVqLhDu+gq/gbumIACPP4rOlzPr2Qjg9Qof9Rq5heiLb2S3YgNeMK0PBpic65A5B2U
         UsgZxE0PNCJeZp5j33kAq+eCk3XHn+KwrF3ctPMDfWnvV+b25xZIuUGaa/hptx39vFWv
         obWtPZ55OoiyawNMQFzN+8PIT7E1TwSgYlXphK52pyE8Wf/Q89aoBu9hVqG78VxalQE6
         wrj2+N0Hb9JDgv5lk0Rb+G44fhj9PeP5JsR+8MRgV6qXOA+fhsWelEmt+L7sM8cWqFq8
         lGuhPKDW06TYTi9Sk/cick0tnFPOcRo4ZiYPvv08RQlChxg8ZFUdNbD3fWoAr5+71XvW
         i7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rXXSvI6oNoyQK8aQO/UjpFHju3BpjEpUWaQ3xz1dKEE=;
        b=rtK8Uf5ZOCneTqmvhVCt+iu1GoZhGnil/niUBP8jSOsyxf77I8xHGkratQAiswWruM
         SYL2mU2DIH0GLyWHT19g6bZCQSAFIf+4G+ackBoALDwgMv19mlCs9jstovplGRoxg60E
         vx14hquChzxCZii9Ztd1C+xHEfFxsao5kmCWu5EA1pOoUqiFKVUV+rTENocP7tHnoiSQ
         rCGLxx/ZAQ4OqJiMDqTrAXE6cFamgNMkf8x7+0sUs9/Dk7F4fK+xxBN3f/hERL2zajUv
         3z5yCn69k9nvkiYpQgklHH+S25J4E9NWLpQN1gmus0EEWbGfrU97iDeF59gJISPuKS1p
         kS0A==
X-Gm-Message-State: APjAAAWQrRDvw6wo6k/aMgCkIxSZmX4PUC8eN7gXjS/Juv+rMlzj4h0o
        zeQhGuivc+ohOGC5c42GtPRdEg==
X-Google-Smtp-Source: APXvYqySF5TFRLcQHH3OzhJl/dAVueks4HbicEEsmTii2+bzzxR8qFiQ4FVDFDgm5+3EyzMuQmjm5Q==
X-Received: by 2002:ac8:1967:: with SMTP id g36mr48621397qtk.323.1555449485874;
        Tue, 16 Apr 2019 14:18:05 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c207sm30127943qkg.14.2019.04.16.14.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 14:18:05 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:17:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBl?= =?UTF-8?B?bA==?= 
        <bjorn.topel@intel.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?= =?UTF-8?B?bg==?= 
        <toke@redhat.com>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        maciej.fijalkowski@intel.com, Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>,
        Jonathan Lemon <bsd@fb.com>
Subject: Re: Per-queue XDP programs, thoughts
Message-ID: <20190416141759.309f6435@cakuba.netronome.com>
In-Reply-To: <CAJ+HfNiBcR4yOBXFM3h9RG_bpu25YGcJtT=dqV1WwNaFmCf77A@mail.gmail.com>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
        <20190405131745.24727-2-bjorn.topel@gmail.com>
        <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
        <20190415183258.36dcee9a@carbon>
        <20190415154932.79bc3b57@cakuba.netronome.com>
        <CAJ+HfNiBcR4yOBXFM3h9RG_bpu25YGcJtT=dqV1WwNaFmCf77A@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Apr 2019 09:45:24 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > > > If we'd like to slice a netdevice into multiple queues. Isn't macvl=
an
> > > > or similar *virtual* netdevices a better path, instead of introduci=
ng
> > > > yet another abstraction? =20
> >
> > Yes, the question of use cases is extremely important.  It seems
> > Mellanox is working on "spawning devlink ports" IOW slicing a device
> > into subdevices.  Which is a great way to run bifurcated DPDK/netdev
> > applications :/  If that gets merged I think we have to recalculate
> > what purpose AF_XDP is going to serve, if any.
>=20
> I really like the subdevice-think, but let's have the drivers in the
> kernel. I don't see how the XDP view (including AF_XDP) changes with
> subdevices. My view on AF_XDP is that it's a socket that can
> receive/send data efficiently from/to the kernel. What subdevice
> *might* change is the requirement for a per-queue XDP program.

My worry is that the sockets are not expressive enough.  You can't have
a flower rule that forwards to a socket.  You can't have a flower rule
which forwards to an RSS context (AFAIK).  We have a model for doing
those things with port netdevs (A(incorrectly)KA representors).

> > > That is actually the reason I want XDP per-queue, as it is a way to
> > > offload the filtering to the hardware.  And if the per-queue XDP-prog
> > > becomes simple enough, the hardware can eliminate and do everything in
> > > hardware (hopefully).
> > > =20
> > > > The control plane should IMO be outside of the XDP program. =20
> >
> > ENOCOMPUTE :)  XDP program is the BPF byte code, it's never control
> > plance.  Do you mean application should not control the "context/
> > channel/subdev" creation? =20
>=20
> Yes, but I'm not sure. I'd like to hear more opinions.
>=20
> Let me try to think out loud here. Say that per-queue XDP programs
> exist. The main XDP program receives all packets and makes the
> decision that a certain flow should end up in say queue X, and that
> the hardware supports offloading that. Should the knobs to program the
> hardware be in via BPF or by some other mechanism (perf ring to
> userland daemon)? Further, setting the XDP program per queue. Should
> that be done via XDP (the main XDP program has knowledge of all
> programs) or via say netlink (as XDP is today). One could argue that
> the per-queue setup should be a map (like tail-calls).

This is a philosophical discussion reminiscent of Saeed's control map
proposal.

I don't like the idea of purposefully shoehorning the networking
configuration into special maps.  It should probably be judged on
patch-by-patch basis, tho.

> > You're not saying "it's not the XDP program
> > which should be making the classification", no?  XDP program
> > controlling the classification was _the_ reason why we liked AF_XDP :) =
=20
>=20
> XDP program not doing classification would be weird. But if there's a
> scenario where *everything for a certain HW filter* end up in an
> AF_XDP queue, should we require an XDP program. I've been going back
> and forth here... :-)
