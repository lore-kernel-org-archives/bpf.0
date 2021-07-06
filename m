Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5502C07E96
	for <bpf@archiver.kernel.org>; Tue,  6 Jul 2021 05:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C2561988
	for <bpf@archiver.kernel.org>; Tue,  6 Jul 2021 05:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhGFFwD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:52:03 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:33296 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhGFFwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 01:52:03 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 01:52:02 EDT
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 2C73D440A96;
        Tue,  6 Jul 2021 08:44:05 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] doc/af_xdp: fix bind flags option typo
Date:   Tue,  6 Jul 2021 08:44:00 +0300
Message-Id: <1656fdf94704e9e735df0f8b97667d8f26dd098b.1625550240.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use 'XDP_ZEROCOPY' as this options is named in if_xdp.h.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/networking/af_xdp.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 42576880aa4a..60b217b436be 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -243,8 +243,8 @@ Configuration Flags and Socket Options
 These are the various configuration flags that can be used to control
 and monitor the behavior of AF_XDP sockets.
 
-XDP_COPY and XDP_ZERO_COPY bind flags
--------------------------------------
+XDP_COPY and XDP_ZEROCOPY bind flags
+------------------------------------
 
 When you bind to a socket, the kernel will first try to use zero-copy
 copy. If zero-copy is not supported, it will fall back on using copy
@@ -252,7 +252,7 @@ mode, i.e. copying all packets out to user space. But if you would
 like to force a certain mode, you can use the following flags. If you
 pass the XDP_COPY flag to the bind call, the kernel will force the
 socket into copy mode. If it cannot use copy mode, the bind call will
-fail with an error. Conversely, the XDP_ZERO_COPY flag will force the
+fail with an error. Conversely, the XDP_ZEROCOPY flag will force the
 socket into zero-copy mode or fail.
 
 XDP_SHARED_UMEM bind flag
-- 
2.30.2

