Return-Path: <SRS0=PQF5=6N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77541C8300B
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5587C2076A
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588131991;
	bh=tLJXYb3DP+NFaGZ12BrTDQFNme8j82/mANf74a1uVyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vqREKaMV4vUniqELm8zLtxGmvmjW+REu6YFH3ue5HZIaVodgB+VSCF67GSmPOH6ys
	 voOTLTrHCQO2/3lFqp/nw3wzmSwmWM+0gW6v2Q5EQmb0Ftc9flVoimIpHsoc5SHbkx
	 Qq7iECFfSsJI+kxpCZAdD8/jvnX90sWC9VqOt5y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgD2Dqa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:46:30 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30766 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgD2Dq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:29 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXle020748;
        Wed, 29 Apr 2020 12:45:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXle020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131936;
        bh=zkicMK33vrZ+2mcVDCQ4bNubmTaMglTOCSUSPXTsbGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXxMZGnBEBMRh5cBuiELkk0avNmZSVsJrJ8iOmV0n7omfIMnkQWNVefaMm/yBc8iq
         w6uiunEbIwWOofw+zNeWiCENo/XOWO2hAd2uT/BwnyU1djmV3oj+dP26Y/Bvlhm8k+
         syTtkIojWQwvD6t/v6lqmV72S0NPVtwa+0mTYp5yaXAPp2banFV3jRu3g8WL/XRKiM
         s80VpmXHz0a9XEQcO4aXPPvGXu+Cm5BEAXR0XpM8EPcIeHN0OBIDGSZpZI0xmNJXDO
         WktoSX55+c2zymk0LOBrcsseoTvq16puUj950Idxv4awCGWi/vsvhQ1bB9MU8iWpeg
         yI0pOhZJd6L2A==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 03/15] bpfilter: use 'userprogs' syntax to build bpfilter_umh
Date:   Wed, 29 Apr 2020 12:45:15 +0900
Message-Id: <20200429034527.590520-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The user mode helper should be compiled for the same architecture as
the kernel.

This Makefile reused the 'hostprogs' syntax by overriding HOSTCC with CC.
Use the new syntax 'userprogs' to fix the Makefile mess.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 net/bpfilter/Makefile | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index f6209e4827b9..f23b53294fba 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -3,18 +3,14 @@
 # Makefile for the Linux BPFILTER layer.
 #
 
-hostprogs := bpfilter_umh
+userprogs := bpfilter_umh
 bpfilter_umh-objs := main.o
-KBUILD_HOSTCFLAGS += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
-			$(filter -m32 -m64, $(KBUILD_CFLAGS))
-HOSTCC := $(CC)
+userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
 
-ifeq ($(CONFIG_BPFILTER_UMH), y)
-# builtin bpfilter_umh should be compiled with -static
+# builtin bpfilter_umh should be linked with -static
 # since rootfs isn't mounted at the time of __init
 # function is called and do_execv won't find elf interpreter
-KBUILD_HOSTLDFLAGS += -static $(filter -m32 -m64, $(KBUILD_CFLAGS))
-endif
+userldflags += -static
 
 $(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
 
-- 
2.25.1

