Return-Path: <SRS0=PQF5=6N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B6C83003
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E5221707
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588132007;
	bh=x7CoblpSCxPpd0ONmPcYMJidhqbYPEewMirmyRo982E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdDYWDgbj+YNLH8syqJYYpPL89K5ZLaqEErCpk7tzf5qlAsB3gAjop2+0pes3L4cN
	 mYXifR+KaNND8dESzbIeLAPsK7zU4HfYZL+pSv5WdM3hwTGDVjHDDiZER9k2dKIvjR
	 ZvVSVMnzxhf7iGYXcibwhsOjX6GsHMeo7UCVALKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD2Dqq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:46:46 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30986 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgD2Dqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:37 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlm020748;
        Wed, 29 Apr 2020 12:45:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlm020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131943;
        bh=3na9AccKI7BeroKtoUmbuMBkaCVwjqRyxXqT1udBYKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIiIsW0Ao7sC4hxrrV2+nPmDuPqI9XVqShBrLaMAalN/IhE1jROCyc3RqWzypheYU
         e1gExSWth7zkv5lSD7r43rLsUnzKjhL33c+6gU6MUW2pw3Ry7y3kJeMk1Bu161S5Ri
         jllK2gTGv92pBMRk7yYC4hCtz174WtdoACO2yCJTvkbNFPdqxnRQX0lVRogdOxMc8m
         KDn5QLMgEXPc+oA0PHNnfkaFMuWhoek7oS/5C5PCjQq0yuOW8De8WpxwTvlkaRF4RR
         CjGemF1s7lIb4ZrEcMcQL9hzPTctSXntpScqIv9ADzVzyte5ggGCcRve9cuasv1IW4
         NTSc/YAcUt/Iw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 11/15] samples: pidfd: build sample program for target architecture
Date:   Wed, 29 Apr 2020 12:45:23 +0900
Message-Id: <20200429034527.590520-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This userspace program includes UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample program should be built for
the target as well. Kbuild now supports 'userprogs' for that.

I also guarded the CONFIG option by 'depends on CC_CAN_LINK' because
$(CC) may not provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 samples/Kconfig        | 2 +-
 samples/pidfd/Makefile | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 831a7ecd3352..c68d391c0602 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -122,7 +122,7 @@ config SAMPLE_HIDRAW
 
 config SAMPLE_PIDFD
 	bool "pidfd sample"
-	depends on HEADERS_INSTALL
+	depends on CC_CAN_LINK && HEADERS_INSTALL
 
 config SAMPLE_SECCOMP
 	bool "Build seccomp sample code"
diff --git a/samples/pidfd/Makefile b/samples/pidfd/Makefile
index ee2979849d92..6e5b67e648c2 100644
--- a/samples/pidfd/Makefile
+++ b/samples/pidfd/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-hostprogs := pidfd-metadata
-always-y := $(hostprogs)
-HOSTCFLAGS_pidfd-metadata.o += -I$(objtree)/usr/include
-all: pidfd-metadata
+usertprogs := pidfd-metadata
+always-y := $(userprogs)
+
+userccflags += -I usr/include
-- 
2.25.1

