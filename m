Return-Path: <SRS0=PQF5=6N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13738C83009
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65B020775
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588132028;
	bh=ZMHUFOzjMKmHaBY86nqRN13bAbe1H5JyDFaKwM09lww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CFyX9N2embd26xK2xbHPLlwS16GA33mnyIobtjjU0IhxLelfaWXD+nB1k29YgATMX
	 0O+nnVmSaT7QYFLCoGtCTOTB6OFubHdMaddUe4yGtf8qaelr50lc/9UWuZAs/GYflG
	 L4peeSISObed+yrsLeyS93n9PQTSe2+G6Jx0mpS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgD2Dqr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:46:47 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30976 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgD2Dqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:37 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXln020748;
        Wed, 29 Apr 2020 12:45:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXln020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131943;
        bh=O4L7XF+xZH3Fa+t8uXqe3t5Njxb0XPvUWzwpGlKOHhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euNQVcgUDchAg9Axw45cSEgaFg3cACAdtfJGPWOQ1pZQ/XfLL1l3NkwTV4fgxlL1V
         4+dHKwta+O9PBXHkAJkfJT34QKmeNW+MBj2uJ1iw3c27TtRzAw+S0Y8ByLPvr8UQAI
         E9zAOjfIZG1M73Z+v36ozzpNKuRQKUHQ7Z6yEVp7C4I3LeHqSvclzkRXUcGLCEwVKW
         CIxYbV4hXWTY2QUi7R85umqJ38wsiYo28eKcAZMAsjlvUDb4ui1eCMjzzx2ODx3Nch
         yOC0YOsAJzbFnM4xekuAtgJWNj0aqHTVPwFJgTGsSrmV4oA87x1/9H+AY0CAQgGvsO
         W2PJMtZcx6rrg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 12/15] samples: mei: build sample program for target architecture
Date:   Wed, 29 Apr 2020 12:45:24 +0900
Message-Id: <20200429034527.590520-13-masahiroy@kernel.org>
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

 samples/Kconfig      | 1 +
 samples/mei/Makefile | 9 +++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index c68d391c0602..69699db49675 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -193,6 +193,7 @@ config SAMPLE_VFS
 config SAMPLE_INTEL_MEI
 	bool "Build example program working with intel mei driver"
 	depends on INTEL_MEI
+	depends on CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  Build a sample program to work with mei device.
 
diff --git a/samples/mei/Makefile b/samples/mei/Makefile
index f5b9d02be2cd..329411f82369 100644
--- a/samples/mei/Makefile
+++ b/samples/mei/Makefile
@@ -1,10 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
 
-hostprogs := mei-amt-version
+userprogs := mei-amt-version
+always-y := $(userprogs)
 
-HOSTCFLAGS_mei-amt-version.o += -I$(objtree)/usr/include
-
-always-y := $(hostprogs)
-
-all: mei-amt-version
+userccflags += -I usr/include
-- 
2.25.1

