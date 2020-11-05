Return-Path: <SRS0=NbGg=EL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E5C2D0A3
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 02:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8DA20780
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 02:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="AlohzBKg";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhHsiIyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgKEC0I (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Nov 2020 21:26:08 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34633 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbgKEC0I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 21:26:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E44BE5C006F;
        Wed,  4 Nov 2020 21:26:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 04 Nov 2020 21:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=hgGjVTTMyQ2M6dgmkNIb7vTvWh
        zzwCqkk8tLANTN3tM=; b=AlohzBKgqvEmuR9NLV0Hma4CpSlClNx5iXiZI+OLFn
        kh+qKtOXCZdqu+0FZnS0MUHhHS5OLtWzr0dNgzyoru33ynZoCY1aTAbN2je7TGaW
        HQO24PU3V4Wdc4SN4KPenjLs5Ll8IpapCaWKJ/9cNdKEYKNO858HSh2DGpFdDaHS
        MTgZEmm8pm4K3ICEKrR+DXDlMIGhUYhZ3Ltd0KdBUVvJHiU9F566GoDZ03gIMVZa
        bXJXr+Bo8YQTCwuwE5b+oQlip2YtZcC0pl91C0TCIx+qgpmo86AFnlFp615gF4X8
        hVgk7FjE94MexrzdKN9NUusQrgEw4o+61aku8kECMt8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hgGjVTTMyQ2M6dgmk
        NIb7vTvWhzzwCqkk8tLANTN3tM=; b=RhHsiIyJ9qOEOLktr13mM5HdaJubYEfDd
        ik6tvR8l+Ytp7xuNg7ZIo7ePAPYveMd+THe8TnTg4vCOZsiOvkkectqYNnLfT0/X
        iWrldAuLR75Dn/f3IM/zt2iXVMPATBj6nOClxd6dZ1lty9kYckfj9wwT7qBNP0kB
        bi68z2HPcGpcwQ9wonnrkV5fo/kp2cNkPaWOqqQscpiIwjgI7qRNMy6M13GFlh0c
        EpJWndK86Hspj9JkyaGmrxSK7umgKJW0AN+0OztRS3yrLBSNaQ3PpsibPo1J49pk
        TqhtnevexoBkyyvvTHV0/5UeB3QnkELhD9esjfo20jGdxDdTongWQ==
X-ME-Sender: <xms:vmKjX5KCk4FWNUJtCH2OuqbWXAGsnWRHkXX8NfYN0hBnlYqY96mXYQ>
    <xme:vmKjX1Lgq_VxVh4kZkzyV03_NvZoNXGAeBoZmFeAUyEt57pMO7ZEvy7s79JTn6hhB
    bhz-eAxWSe1JkD7Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucfkphepieelrddukedurddutdeh
    rdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:vmKjXxuHsORsa5aGCtNMKfYZS1DUYG9PvsXG3Ok4YU094ug0dN_0VQ>
    <xmx:vmKjX6Y0UzQgtHRWFDw0iWl8WkBgwXeF8lKrBAArpZMbFJ7tcwQVgA>
    <xmx:vmKjXwZTBsJ2znBnaPYreuuia1ly4hJj58e18WiwVgf9I8CNkptbLg>
    <xmx:vmKjX4EbfaT7lEdBvHOhKRTvHpEcmNlG8R84YNF1FeIXU_YyJDDhWA>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 130F33280222;
        Wed,  4 Nov 2020 21:26:06 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v2 0/2] Fix bpf_probe_read_user_str() overcopying
Date:   Wed,  4 Nov 2020 18:25:36 -0800
Message-Id: <cover.1604542786.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user,
kernel}_str helpers") introduced a subtle bug where
bpf_probe_read_user_str() would potentially copy a few extra bytes after
the NUL terminator.

This issue is particularly nefarious when strings are used as map keys,
as seemingly identical strings can occupy multiple entries in a map.

This patchset fixes the issue and introduces a selftest to prevent
future regressions.

Daniel Xu (2):
  lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
  selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes
    after NUL

 lib/strncpy_from_user.c                       |  9 ++-
 .../bpf/prog_tests/probe_read_user_str.c      | 60 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 34 +++++++++++
 3 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

-- 
2.28.0

