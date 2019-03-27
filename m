Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F04DC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0A12064A
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713861;
	bh=Y8IqOOQiRInxcECn8A9wf9S4T57fqM7rE0mVXgDmTug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cAPFVTsIxl1lEuh+DoJ/ofmAhQa4TMA2sX6cafahfJoKzs7E+PAlkaJgxyzSC710l
	 9qaCkdAM1pmM4QRa8RQ76k2XOQiUgBi2XdL+JDM1Ng2cbfXQ5S4OcxzvwKuP8DFk2P
	 j2zpMH3SlOCXoe+83LVaPMVZVbjx263fg8GC/jE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfC0SKt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfC0SKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034FD21855;
        Wed, 27 Mar 2019 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710247;
        bh=Y8IqOOQiRInxcECn8A9wf9S4T57fqM7rE0mVXgDmTug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVkvPo6Mjj2zgvQ34K7B5J0sJuD/rR9+xrpxeXIBQpRK6wJKMlkPXJl73FY244uYd
         F0t+8Ji7ypeypZcfMc6n2lo0+D1YdIpgLyjd57+6SLD9Z5kSGYx9yUJffnFHDTVbJJ
         P40cDyOy68eHi6ixMhcVbYt48I710wn0NNOdUQfY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 015/192] libbpf: force fixdep compilation at the start of the build
Date:   Wed, 27 Mar 2019 14:07:27 -0400
Message-Id: <20190327181025.13507-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 8e2688876c7f7073d925e1f150e86b8ed3338f52 ]

libbpf targets don't explicitly depend on fixdep target, so when
we do 'make -j$(nproc)', there is a high probability, that some
objects will be built before fixdep binary is available.

Fix this by running sub-make; this makes sure that fixdep dependency
is properly accounted for.

For the same issue in perf, see commit abb26210a395 ("perf tools: Force
fixdep compilation at the start of the build").

Before:

$ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=/tmp/bld -C tools/lib/bpf/

Auto-detecting system features:
...                        libelf: [ on  ]
...                           bpf: [ on  ]

  HOSTCC   /tmp/bld/fixdep.o
  CC       /tmp/bld/libbpf.o
  CC       /tmp/bld/bpf.o
  CC       /tmp/bld/btf.o
  CC       /tmp/bld/nlattr.o
  CC       /tmp/bld/libbpf_errno.o
  CC       /tmp/bld/str_error.o
  CC       /tmp/bld/netlink.o
  CC       /tmp/bld/bpf_prog_linfo.o
  CC       /tmp/bld/libbpf_probes.o
  CC       /tmp/bld/xsk.o
  HOSTLD   /tmp/bld/fixdep-in.o
  LINK     /tmp/bld/fixdep
  LD       /tmp/bld/libbpf-in.o
  LINK     /tmp/bld/libbpf.a
  LINK     /tmp/bld/libbpf.so
  LINK     /tmp/bld/test_libbpf

$ head /tmp/bld/.libbpf.o.cmd
 # cannot find fixdep (/usr/local/google/home/sdf/src/linux/xxx//fixdep)
 # using basic dep data

/tmp/bld/libbpf.o: libbpf.c /usr/include/stdc-predef.h \
 /usr/include/stdlib.h /usr/include/features.h \
 /usr/include/x86_64-linux-gnu/sys/cdefs.h \
 /usr/include/x86_64-linux-gnu/bits/wordsize.h \
 /usr/include/x86_64-linux-gnu/gnu/stubs.h \
 /usr/include/x86_64-linux-gnu/gnu/stubs-64.h \
 /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h \

After:

$ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=/tmp/bld -C tools/lib/bpf/

Auto-detecting system features:
...                        libelf: [ on  ]
...                           bpf: [ on  ]

  HOSTCC   /tmp/bld/fixdep.o
  HOSTLD   /tmp/bld/fixdep-in.o
  LINK     /tmp/bld/fixdep
  CC       /tmp/bld/libbpf.o
  CC       /tmp/bld/bpf.o
  CC       /tmp/bld/nlattr.o
  CC       /tmp/bld/btf.o
  CC       /tmp/bld/libbpf_errno.o
  CC       /tmp/bld/str_error.o
  CC       /tmp/bld/netlink.o
  CC       /tmp/bld/bpf_prog_linfo.o
  CC       /tmp/bld/libbpf_probes.o
  CC       /tmp/bld/xsk.o
  LD       /tmp/bld/libbpf-in.o
  LINK     /tmp/bld/libbpf.a
  LINK     /tmp/bld/libbpf.so
  LINK     /tmp/bld/test_libbpf

$ head /tmp/bld/.libbpf.o.cmd
cmd_/tmp/bld/libbpf.o := gcc -Wp,-MD,/tmp/bld/.libbpf.o.d -Wp,-MT,/tmp/bld/libbpf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wshadow -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3 -Werror -Wall -fPIC -I. -I/usr/local/google/home/sdf/src/linux/tools/include -I/usr/local/google/home/sdf/src/linux/tools/arch/x86/include/uapi -I/usr/local/google/home/sdf/src/linux/tools/include/uapi -fvisibility=hidden -D"BUILD_STR(s)=$(pound)s" -c -o /tmp/bld/libbpf.o libbpf.c

source_/tmp/bld/libbpf.o := libbpf.c

deps_/tmp/bld/libbpf.o := \
  /usr/include/stdc-predef.h \
  /usr/include/stdlib.h \
  /usr/include/features.h \
  /usr/include/x86_64-linux-gnu/sys/cdefs.h \
  /usr/include/x86_64-linux-gnu/bits/wordsize.h \

Fixes: 7c422f557266 ("tools build: Build fixdep helper from perf and basic libs")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index d49902e818b5..3624557550a1 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -149,7 +149,8 @@ CMD_TARGETS = $(LIB_FILE)
 
 TARGETS = $(CMD_TARGETS)
 
-all: fixdep all_cmd
+all: fixdep
+	$(Q)$(MAKE) all_cmd
 
 all_cmd: $(CMD_TARGETS)
 
-- 
2.19.1

