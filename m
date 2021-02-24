Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B40C433E0
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDB164F0C
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 21:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhBXV0U (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Feb 2021 16:26:20 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54081 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234055AbhBXV0T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 16:26:19 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 04F425C01A9;
        Wed, 24 Feb 2021 16:25:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Feb 2021 16:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenhack.net; h=
        message-id:from:date:subject:to; s=fm2; bh=hLRGjG8FS3qHNvLTm7qJ3
        e/6MQkgxK8tqPU2KaknprQ=; b=BGP+c6BCvc/Wzn3JuTgRi8R9EF7QIbFdS8CUZ
        vEgVG9Ffi4hZObyufQHOoQBfZ0NSekR1IDY3BGpSlyz3GDToc7GV/7fyzJOkP0OE
        nLjn0kWcd2ffiRdONmFwv3aD3Oisqs9+NoQITVcFKTALb2OaXK1xsy1TQZqd4ERp
        0VPMoLpYU9EZxwD/JMw3bQ1Ek0of3oVAXOP4EK0j7F2guPcTPE3Vs6e6zaCTtCnl
        pjcc/TVxZoc3sH4sQ22PKQW+m18vIKNdXwR68p9479F2or/pe2QZDDOu230jn6hW
        tIKvVanQrjK10nrebJ+SAOlkSp6C5TFl4TagzlyW0HGvOMjdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=hLRGjG8FS3qHNvLTm7qJ3e/6MQkgxK8tqPU2KaknprQ=; b=ScH3LhTf
        KFV0I/51IBB6S8GpLl/YQ/Y1I/cJs5aPzFsw6foaZ828wAReucN//EPu0NtiC9Wo
        XtMe88ILVcaz6LeITx6gOGmzyUQEjkcZrrKtQu7OAIgpJiT60CRQddhxzCIkZ1pr
        YW0MJrLF7IiYTZgnQelA64Sb6kayryycB2ROe4jlcQc4Fz6jmYuxGdhwZBQ8Hfwi
        weObJ7y6CIXwFm13+0vqc2GLx/DOUohy2rj8zFuiDReVH6Jf6lIhKK00VV4WzGRb
        42teyToF9zdGDAPj33nmYNas1oKlPnn+GtUv2bOUa/OQkGTqzVtCaJmzajXGN30Y
        nF/aEXGna0SJZw==
X-ME-Sender: <xms:TcQ2YLclg1LOh9yYxx0L_2MF-RT6YuJtJcB8sK0eC0FjPi5reF193g>
    <xme:TcQ2YIpwPx6OoL-QuuppIV4a-gLFYkjlJPTj08oGkB0SEi1MUKoV2Ft23o7O7Pzwf
    rUevspxXs7i96abRLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkhfffuffvsedttdertddttddtne
    cuhfhrohhmpefkrghnucffvghnhhgrrhguthcuoehirghnseiivghnhhgrtghkrdhnvght
    qeenucggtffrrghtthgvrhhnpeduteeghefgvedtffelgefgheekkeekffffvdelvdetgf
    egfffggfeljedutdffueenucffohhmrghinhepvghrrhhorhhsrdhtohholhhsnecukfhp
    pedutddtrddtrdefjedrvddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehirghnseiivghnhhgrtghkrdhnvght
X-ME-Proxy: <xmx:TcQ2YB7v1H9OnRCAa6-Ae90LzaEUsUAPwjvFvT2JmQfWuEwxMxOy7Q>
    <xmx:TcQ2YGpH8RiN-s3E4nIKS8PkMXNjdJvcIAS1zOaLSONTZLP6YVVpTQ>
    <xmx:TcQ2YLgf_pDZ68HgPonOfeDUpQ9isZVlrM817WmNjQ_yD6eEC3PgdA>
    <xmx:TsQ2YIyd_xKQk0BXTXLIbFLvktU1iVvYoXDXCuwXCi9YF8UdkaD7Tw>
Received: from localhost (pool-100-0-37-221.bstnma.fios.verizon.net [100.0.37.221])
        by mail.messagingengine.com (Postfix) with ESMTPA id 868891080057;
        Wed, 24 Feb 2021 16:25:33 -0500 (EST)
X-Mailbox-Line: From b0bea780bc292f29e7b389dd062f20adc2a2d634 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1614201868.git.ian@zenhack.net>
From:   Ian Denhardt <ian@zenhack.net>
Date:   Wed, 24 Feb 2021 16:24:28 -0500
Subject: [PATCH 0/2] More strict error checking in bpf_asm (v3).
To:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gah, managed to typo my own name in the v2 patch >.<

This one should be good :/

Ian Denhardt (2):
  tools, bpf_asm: Hard error on out of range jumps.
  tools, bpf_asm: exit non-zero on errors.

 tools/bpf/bpf_exp.y | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--
2.30.1

