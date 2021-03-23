Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9408C433DB
	for <bpf@archiver.kernel.org>; Tue, 23 Mar 2021 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93565619B8
	for <bpf@archiver.kernel.org>; Tue, 23 Mar 2021 18:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCWSBb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:01:31 -0400
Received: from outpost19.zedat.fu-berlin.de ([130.133.4.112]:45571 "EHLO
        outpost19.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhCWSBD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 14:01:03 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lOlFf-00217c-3X; Tue, 23 Mar 2021 18:55:35 +0100
Received: from mx.physik.fu-berlin.de ([160.45.64.218])
          by relay1.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_DHE_RSA_WITH_AES_128_CBC_SHA
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lOlFf-003u4O-0G; Tue, 23 Mar 2021 18:55:35 +0100
Received: from epyc.physik.fu-berlin.de ([160.45.64.180])
        by mx.physik.fu-berlin.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1lOlFQ-0000GW-Vz; Tue, 23 Mar 2021 18:55:20 +0100
Received: from glaubitz by epyc.physik.fu-berlin.de with local (Exim 4.94 #2 (Debian))
        id 1lOlFQ-003aAf-Mz; Tue, 23 Mar 2021 18:55:20 +0100
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] tools: Remove ia64-specific errno.h inclusion from errno.h header
Date:   Tue, 23 Mar 2021 18:55:11 +0100
Message-Id: <20210323175513.853947-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Originating-IP: 160.45.64.218
X-ZEDAT-Hint: VR
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no longer an ia64-specific version of the errno.h header
below arch/ia64/include/uapi/asm/, so trying to build tools/bpf
fails with:

  CC       /usr/src/linux/tools/bpf/bpftool/btf_dumper.o
In file included from /usr/src/linux/tools/include/linux/err.h:8,
                 from btf_dumper.c:11:
/usr/src/linux/tools/include/uapi/asm/errno.h:13:10: fatal error: ../../../arch/ia64/include/uapi/asm/errno.h: No such file or directory
   13 | #include "../../../arch/ia64/include/uapi/asm/errno.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

Thus, just remove the inclusion of the ia64-specific errno.h so that
the build will use the generic errno.h header on this target which was
used there anyway as the ia64-specific errno.h was just a wrapper for
the generic header.

Fixes: c25f867ddd00 ("ia64: remove unneeded uapi asm-generic wrappers")
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 tools/include/uapi/asm/errno.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/include/uapi/asm/errno.h b/tools/include/uapi/asm/errno.h
index 637189ec1ab9..d30439b4b8ab 100644
--- a/tools/include/uapi/asm/errno.h
+++ b/tools/include/uapi/asm/errno.h
@@ -9,8 +9,6 @@
 #include "../../../arch/alpha/include/uapi/asm/errno.h"
 #elif defined(__mips__)
 #include "../../../arch/mips/include/uapi/asm/errno.h"
-#elif defined(__ia64__)
-#include "../../../arch/ia64/include/uapi/asm/errno.h"
 #elif defined(__xtensa__)
 #include "../../../arch/xtensa/include/uapi/asm/errno.h"
 #else
-- 
2.31.0

