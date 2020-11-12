Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF920C2D0E4
	for <bpf@archiver.kernel.org>; Thu, 12 Nov 2020 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CDA216C4
	for <bpf@archiver.kernel.org>; Thu, 12 Nov 2020 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="GcXn6ijl";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwPvYmO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKLTNh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Nov 2020 14:13:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37469 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbgKLTNh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 14:13:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AC88849E;
        Thu, 12 Nov 2020 14:13:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 12 Nov 2020 14:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:subject:from
        :to:cc:date:message-id:in-reply-to; s=fm2; bh=lQuE8hIsyGPimE/WPT
        H85XmvdugpBfZsiVINhlZFDRk=; b=GcXn6ijlegQp2Qxhib/YQhm7TVomJD9TZS
        um2pfdjZKq4DOpc5T1TGQBwHLu59IKclpbnTqh/LFe5TG8CrsCh8E0uAKnCoTHB/
        KWDGdQBJpCaZtql+jF6a4Vubw84L1e0IPekDwRsKYQIejdy0KjGYh3vGHTIV2kC3
        K4OElGaUN042+Z5BaMdWW/NJ4XagkTgO7a6ZR04O7b8bjxqF3Cn2xZc28kRSBF9S
        OyeCH8x0SbOW2HKYtv7bTxqew1b+uumOk00UOrd47TL4HS9iGqykiWK4yLtzOfBW
        P+9FKy5uQGWcccnzAKxKIyWmekqC3PzPQXCUCdmP0oKl/Rus3GtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=lQuE8hIsyGPimE/WPTH85XmvdugpBfZsiVINhlZFDRk=; b=lwPvYmO5
        byrJDGTI0YrdmN6y62PMgKHoyWkBGvQ1iQznHX8enbiMBIWVf+oWLxhlfHYtItHF
        aT6BjbaVykZojJxXHG6dWgr6xgaIhez1BxcnHhXjkZg10BAEvc8u9GdNulZWjqr7
        Y5re4yz9HUtpC+SxNUY+dHZjeKwZTIovYV7+ovMioxYEVSUOik8700kjGZ+Fq3PU
        de1KM4I9QIHCAhClRIaGGhlc6gzau5LfYZhZIe1b1wNHw0N8wz08CWQjn1cr4wDd
        gyaSTQrBkZ2iE2jJqjcHZvC4ANeDkOS7QCjjj/GtDFJcwQcW2sfrGrggtSBMAQWI
        cjbhgwVKwrn/Dw==
X-ME-Sender: <xms:X4mtX1ppw2u_3XL8x92-lVboorsAL20YR72WRZrhjTp0S_EoLoXJjg>
    <xme:X4mtX3rTyOWPRd3x8VnkEgulpkuL0i9_u_c8y8vTUzet2_bqQ5lEKGgIqaRdtWjra
    gylZpNl3N9zDbjLbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvfedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpegggfgtuffhvfffkfgjsehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepjeefhfdufeefhfejvdevhfehudeltdeujeevudegvdejvdej
    leejgfegtdejjeevnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:X4mtXyP_Wfw68NRntXDX_lmRcNGdSFtBm368hxTmD4N6R1NE-FR5tg>
    <xmx:X4mtXw6AsiA-Zv7tvQOhvg4OaYvbAB-mLU4f1isXKo3ml9NAWPrQWg>
    <xmx:X4mtX07eOLiOacs3-tE8KCItDyoF9RiR0PH4IyWp0SZ_-C9q1JlXLQ>
    <xmx:YImtX_20MLw36rhBdgDlMZ2lmscKDQOaElPMiBaMDRIVdC-av8IT4w>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF0A7328005D;
        Thu, 12 Nov 2020 14:13:34 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH bpf v5 0/2] Fix bpf_probe_read_user_str() overcopying
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "bpf" <bpf@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Song Liu" <songliubraving@fb.com>,
        "Kernel Team" <kernel-team@fb.com>
Date:   Thu, 12 Nov 2020 11:10:59 -0800
Message-Id: <C71IU5Z0R6UI.29FQP3BCZ65ZC@maharaja>
In-Reply-To: <CAEf4BzZx=7N6dbKk8Eb_k-FA-PmmPFBJ=V-PLhbDu38wuXkOkw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed Nov 11, 2020 at 3:22 PM PST, Andrii Nakryiko wrote:
> On Wed, Nov 11, 2020 at 2:46 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user,
> > kernel}_str helpers") introduced a subtle bug where
> > bpf_probe_read_user_str() would potentially copy a few extra bytes afte=
r
> > the NUL terminator.
> >
> > This issue is particularly nefarious when strings are used as map keys,
> > as seemingly identical strings can occupy multiple entries in a map.
> >
> > This patchset fixes the issue and introduces a selftest to prevent
> > future regressions.
> >
> > v4 -> v5:
> > * don't read potentially uninitialized memory
>
> I think the bigger problem was that it could overwrite unintended
> memory. E.g., in BPF program, if you had something like:
>
> char my_buf[8 + 3];
> char my_precious_data[5] =3D {1, 2, 3, 4, 5};

How does that happen?

The

    while (max >=3D sizeof(unsigned long)) {
            /* copy 4 bytes */

            max -=3D sizeof(unsigned long)
    }

    /* copy byte at a time */

where `max` is the user supplied length should prevent that kind of
corruption, right?

[...]
