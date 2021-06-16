Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A0C49EA3
	for <bpf@archiver.kernel.org>; Wed, 16 Jun 2021 21:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0793613AE
	for <bpf@archiver.kernel.org>; Wed, 16 Jun 2021 21:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhFPVyk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:54:40 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45331 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234164AbhFPVyj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 17:54:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4EE73189F;
        Wed, 16 Jun 2021 17:52:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 16 Jun 2021 17:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=qAmxux+NK8Xjulz/AXkRZOc3UO
        M34ivSKOKfO2DMln0=; b=H4KRtJuhb3Dd2yov30R1j4pxqvZbGkeITfVSh4AbT7
        4U9TTMxGLV4p5jov6deRrq73Nb8mFeU1jA+rW4GNNQuFJXihcxx4weDGWt+ZojS4
        9fFQRXGrNQw9QHohKfp7EvLQAuwUMftD6fRMb6r2ymKBcwnoAgj5mophz2AIu2GQ
        BrJp7lLdXC6TY+re7zGWyyHVP+0Bc7mYfK7HgIgKXFS6v1H7KP8Qd+Oexk1/U2nf
        C7Dgb9+MeVFpYk7UnUs+Hvaq90zzJSKltDrmHFs1aMbJTH2Iq8O/gg0Xg3FUARBw
        FxI8R+tEXFCS5cFhGDxB/x46mszK7bKMlGmVrSZOCfPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qAmxux+NK8Xjulz/A
        XkRZOc3UOM34ivSKOKfO2DMln0=; b=IIcQDhlx3kZEGGIddbtr7cdzEtcxM1irI
        aVPmeNXjfv4QUGF3xX6a6TUggaHv5qCfUnhy28f6qSEwJtFnZ8SEe/itEdvwZXLO
        QOZ1npNb8/HVGpGqUL0gxrXiqJDcHA4IQgJ/Cle6BQORm8iFBtOTul6xxwUfu9fx
        GpG0LtgL8m6AsQZcHnzFnhyYavtKApKTAtIsLaGrV5PNx/fAdTzOcS8mp5GrCoWa
        3jJUwVAtgByI9G9v7ECKTo0MLnPrEgCy/Zqg2W90ndWhEuzlDQwTxMBVSnbATDXb
        FGmTT4EOen3h8OlxqNvYtCAAqJ1MhmBcW/KCPVqomQxyezl0e1WgA==
X-ME-Sender: <xms:nnLKYCsHMiKMc5nqfIGefCYWwSmF0cdDoqxLDt9y9_fBZ0XhXp8VFw>
    <xme:nnLKYHfLV6-4WPxqmrZWrUM1A7LXHjyYnaCOIuIS1IzebBrhTogpe8m42xQOyeO-X
    guiC7ojdIDkW17oDw>
X-ME-Received: <xmr:nnLKYNzjQkSOcdri_shW0h-BiQ3kwrzlFclRYwrHoU88VmVmYAyGZ806chVGupiAjjmHrh8YVaEXTrvA2lc6J5R9zesd1WxzLwObsOndDJJrOnVe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeftdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvufffkf
    foggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugig
    uhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeejudehlefgtddukeeijefgge
    ehheejgfeijeevveetieevueekgfehkeejnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugi
    husegugihuuhhurdighiii
X-ME-Proxy: <xmx:nnLKYNMY5kTH-Iu9XRWKdTur3DAF1KAU-T82K-32eIey1Ve1pp3A2g>
    <xmx:nnLKYC_oDSnj6Owv3WE_4vBhox_4J2RCnSUjwVPqBm-tocu-5Ke1Ig>
    <xmx:nnLKYFWywEeXw1HyilLK0fAgE_B6NN1P0z-dQ94KMww-YmJU99QUJQ>
    <xmx:nnLKYEIslmo8By48K3vcAzS15S9lRHkyzBicaOtHpMyOh-zMPv0_9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 17:52:30 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, andrii.nakryiko@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf] bpf: selftests: Whitelist test_progs.h from .gitignore
Date:   Wed, 16 Jun 2021 14:52:11 -0700
Message-Id: <a46f64944bf678bc652410ca6028d3450f4f7f4b.1623880296.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Somehow test_progs.h was being included by the existing rule:

    /test_progs*

This is bad because:

    1) test_progs.h is a checked in file
    2) grep-like tools like ripgrep[0] respect gitignore and
       test_progs.h was being hidden from searches

[0]: https://github.com/BurntSushi/ripgrep

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/
general rule")

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4866f6a21901..d89efd9785d8 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -10,6 +10,7 @@ FEATURE-DUMP.libbpf
 fixdep
 test_dev_cgroup
 /test_progs*
+!test_progs.h
 test_verifier_log
 feature
 test_sock
-- 
2.31.1

