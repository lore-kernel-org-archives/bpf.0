Return-Path: <SRS0=idkB=R7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486BC10F03
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EDB20823
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 15:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfC1Pxm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:53:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:57170 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfC1Pxm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Mar 2019 11:53:42 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h9XLY-0005wz-Jn; Thu, 28 Mar 2019 16:53:40 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf, libbpf: fix quiet install_headers
Date:   Thu, 28 Mar 2019 16:53:37 +0100
Message-Id: <9c98d4498ec2209a879b04a8f9385b70e28e2114.1553788223.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25402/Thu Mar 28 08:54:39 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both btf.h and xsk.h headers are not installed quietly due to
missing '\' for the call to QUIET_INSTALL. Lets fix it.

Before:

  # make install_headers
    INSTALL  headers
  if [ ! -d '''/usr/local/include/bpf' ]; then install -d -m 755 '''/usr/local/include/bpf'; fi; install btf.h -m 644 '''/usr/local/include/bpf';
  if [ ! -d '''/usr/local/include/bpf' ]; then install -d -m 755 '''/usr/local/include/bpf'; fi; install xsk.h -m 644 '''/usr/local/include/bpf';
  # ls /usr/local/include/bpf/
  bpf.h  btf.h  libbpf.h  xsk.h

After:

  # make install_headers
    INSTALL  headers
  # ls /usr/local/include/bpf/
  bpf.h  btf.h  libbpf.h  xsk.h

Fixes: a493f5f9d8c2 ("libbpf: Install btf.h with libbpf")
Fixes: 379e2014c95b ("libbpf: add xsk.h to install_headers target")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 7beec4d..8e7c56e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -220,8 +220,8 @@ install_lib: all_cmd
 install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,bpf.h,$(prefix)/include/bpf,644); \
-		$(call do_install,libbpf.h,$(prefix)/include/bpf,644);
-		$(call do_install,btf.h,$(prefix)/include/bpf,644);
+		$(call do_install,libbpf.h,$(prefix)/include/bpf,644); \
+		$(call do_install,btf.h,$(prefix)/include/bpf,644); \
 		$(call do_install,xsk.h,$(prefix)/include/bpf,644);
 
 install: install_lib
-- 
2.9.5

