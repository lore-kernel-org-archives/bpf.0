Return-Path: <SRS0=ey3N=6H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560B9C2BA19
	for <bpf@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D6321569
	for <bpf@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587628378;
	bh=YysVAHTZL2DdRaWv4GzJoGKVNXvuhJPVUeu35nNKt08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y1N8cj6lDa8O8mME5BI1hYhkRRcor1yIEQHhfI7GtuMCf/0nNkFxIb37BBgUndX0q
	 SdC7FRzq7cVeOJ8Qoy0s/seytHwCFJxng02cvnnxy72/tYZcGaM8Lgp7fO1WetW/wP
	 /cpiWnL7ENaVW+4zGIBFeaJ3gQ/nf4r7+q2BH+co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgDWHw5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:52:57 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:27683 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWHw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:52:57 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-03.nifty.com with ESMTP id 03N7eacC016165
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:41:18 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9Q000368;
        Thu, 23 Apr 2020 16:39:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9Q000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627579;
        bh=7kgkosREChyr2qCmSzOt/aUBMEboc1zZ/PX0XU3QyZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKQN27AzEg/soVyiQBKb0WjU8r030CFHBu+V93YqWFAzX21gotLPgG9GNx4G2mxix
         cXov2Dnt2dBtzW75by16g2pQfhe2GLq8Lpv0W2vBjbx+2FnuUuHXOySYX+Gh5oJPiw
         vIdnENi7VKVx8SLNf0TZ4viBV3xw7fyQqkFJdMGGCwQaG31iEOm4OdIQW5EkMwIxTr
         xM75nSIXGexHrJDDm36Sq7gSEMKDDEW+qtnxSqbN/km/xFhH/sqgcziTUs5lzOgS2A
         Ho+WFVIL/Ep9HcNfhAXEIbN8sErrwfDgCwSahv9Io4vaB/aVtYKZXTDinaIqzSP0Gi
         8WzQ/qET/PYfQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 05/16] samples: seccomp: build sample programs for target architecture
Date:   Thu, 23 Apr 2020 16:39:18 +0900
Message-Id: <20200423073929.127521-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These userspace programs include UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample programs must be built for
the target as well. Kbuild now supports the 'userprogs' syntax to
describe it cleanly.

I also guarded the CONFIG option by 'depends on CC_CAN_LINK' because
$(CC) may not necessarily provide libc.

The 'ifndef CROSS_COMPILE' is no longer needed.

BTW, the -m31 for s390 is left-over code. Commit 5a79859ae0f3 ("s390:
remove 31 bit support") killed it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 samples/Kconfig          |  2 +-
 samples/seccomp/Makefile | 42 +++-------------------------------------
 2 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 9d236c346de5..8949e9646125 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -126,7 +126,7 @@ config SAMPLE_PIDFD
 
 config SAMPLE_SECCOMP
 	bool "Build seccomp sample code"
-	depends on SECCOMP_FILTER && HEADERS_INSTALL
+	depends on SECCOMP_FILTER && CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 89279e8b87df..19a7b1125ddf 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,44 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef CROSS_COMPILE
-hostprogs := bpf-fancy dropper bpf-direct user-trap
+userprogs := bpf-fancy dropper bpf-direct user-trap
 
-HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
-HOSTCFLAGS_bpf-helper.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-helper.o += -idirafter $(objtree)/include
 bpf-fancy-objs := bpf-fancy.o bpf-helper.o
 
-HOSTCFLAGS_dropper.o += -I$(objtree)/usr/include
-HOSTCFLAGS_dropper.o += -idirafter $(objtree)/include
-dropper-objs := dropper.o
+user-ccflags += -I usr/include
 
-HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
-bpf-direct-objs := bpf-direct.o
-
-HOSTCFLAGS_user-trap.o += -I$(objtree)/usr/include
-HOSTCFLAGS_user-trap.o += -idirafter $(objtree)/include
-user-trap-objs := user-trap.o
-
-# Try to match the kernel target.
-ifndef CONFIG_64BIT
-
-# s390 has -m31 flag to build 31 bit binaries
-ifndef CONFIG_S390
-MFLAG = -m32
-else
-MFLAG = -m31
-endif
-
-HOSTCFLAGS_bpf-direct.o += $(MFLAG)
-HOSTCFLAGS_dropper.o += $(MFLAG)
-HOSTCFLAGS_bpf-helper.o += $(MFLAG)
-HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
-HOSTCFLAGS_user-trap.o += $(MFLAG)
-HOSTLDLIBS_bpf-direct += $(MFLAG)
-HOSTLDLIBS_bpf-fancy += $(MFLAG)
-HOSTLDLIBS_dropper += $(MFLAG)
-HOSTLDLIBS_user-trap += $(MFLAG)
-endif
-always-y := $(hostprogs)
-endif
+always-y := $(userprogs)
-- 
2.25.1

