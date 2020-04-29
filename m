Return-Path: <SRS0=PQF5=6N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA6C83006
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D789F20757
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 03:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588132030;
	bh=qP9CKE+rRvAcPQvcvA29d+My/LIXCY+NPrCSdJmoHE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cEKrixL4/wj1XMSikxw7Qu08/houHbXa6T81Hawv1l0K86y33GcDTVxhJoqVdPl/O
	 KW7kIUBaYvcdRvRapmA28NTgh4C6xHcS0JnGeeDGUjkGBhe6+ZYapbiB9hNUfF2DpZ
	 GCPENyboejTHG1I+oyv/kHdLYIfzxl2PmpLhCzbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgD2DrJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:47:09 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30962 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgD2Dqg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:36 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlk020748;
        Wed, 29 Apr 2020 12:45:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlk020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131941;
        bh=u410bS8SBcQcLE4Navba3842b4GW6OHIpnykGKU+fMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHkVStjDSR9ov3KqInZ32P1GYR2zFSDRaMQ0gmpe98SyO6T9eItCCj3khRkNXqTUn
         ZJr0v4W4be2pq/EHpD0cvI6YNXOWQnR60KYXb7qRBRdULkbTJYm0VCIEywjll6ZxXw
         9BTCjm3fU2+iIh2k2lCvbKSr3177Oy6g6d4vmLuwPnKjwUe4efF46LvCM3YnfnfQ+9
         ABdSqPCG0IjwiHTm7S6eO30P/10kEIXdJwtfQC4l19syAlRMpRb796oQbQtUalq8Sf
         Ag377QFrKTTmZ2es+UJ0jBOH6tUwbhmYo0qtemwX8UJVzjqNPdiYSfW2LixQJR258n
         oPIPxkLoeyZ7g==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 09/15] samples: connector: build sample program for target architecture
Date:   Wed, 29 Apr 2020 12:45:21 +0900
Message-Id: <20200429034527.590520-10-masahiroy@kernel.org>
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

$(CC) can always compile cn_text.o since it is the kenrel-space code,
but building ucon requires libc.

I guarded it by:

  always-$(CONFIG_CC_CAN_LINK) := $(userprogs)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 samples/connector/Makefile | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/samples/connector/Makefile b/samples/connector/Makefile
index b785cbde5ffa..50cb40e09a7b 100644
--- a/samples/connector/Makefile
+++ b/samples/connector/Makefile
@@ -1,13 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SAMPLE_CONNECTOR) += cn_test.o
 
-# List of programs to build
-hostprogs := ucon
-always-y := $(hostprogs)
+userprogs := ucon
+always-$(CONFIG_CC_CAN_LINK) := $(userprogs)
 
-HOSTCFLAGS_ucon.o += -I$(objtree)/usr/include
-
-all: modules
-
-modules clean:
-	$(MAKE) -C ../.. M=$(CURDIR) $@
+userccflags += -I usr/include
-- 
2.25.1

