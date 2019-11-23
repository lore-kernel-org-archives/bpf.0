Return-Path: <SRS0=Pk2X=ZP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE4BC432C3
	for <bpf@archiver.kernel.org>; Sat, 23 Nov 2019 20:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D671A204FD
	for <bpf@archiver.kernel.org>; Sat, 23 Nov 2019 20:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKWUhg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:37:36 -0500
Received: from www62.your-server.de ([213.133.104.62]:60912 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWUhg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 15:37:36 -0500
Received: from 11.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.11] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iYc9u-0003mc-0E; Sat, 23 Nov 2019 21:37:34 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     jakub@cloudflare.com, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next] bpf: add bpf_jit_blinding_enabled for !CONFIG_BPF_JIT
Date:   Sat, 23 Nov 2019 21:37:31 +0100
Message-Id: <40baf8f3507cac4851a310578edfb98ce73b5605.1574541375.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25642/Sat Nov 23 10:55:42 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a definition of bpf_jit_blinding_enabled() when CONFIG_BPF_JIT is not set
in order to fix a recent build regression:

  [...]
  CC      kernel/bpf/verifier.o
  CC      kernel/bpf/inode.o
kernel/bpf/verifier.c: In function ‘fixup_bpf_calls’:
kernel/bpf/verifier.c:9132:25: error: implicit declaration of function ‘bpf_jit_blinding_enabled’; did you mean ‘bpf_jit_kallsyms_enabled’? [-Werror=implicit-function-declaration]
 9132 |  bool expect_blinding = bpf_jit_blinding_enabled(prog);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~
      |                         bpf_jit_kallsyms_enabled
  CC      kernel/bpf/helpers.o
  CC      kernel/bpf/hashtab.o
  [...]

Fixes: bad63c9ea554 ("bpf: Constant map key tracking for prog array pokes")
Reported-by: Jakub Sitnicki <jakub@cloudflare.com>
Reported-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/filter.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 796b60d8cc6c..1b1e8b8f88da 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1053,6 +1053,11 @@ static inline bool ebpf_jit_enabled(void)
 	return false;
 }
 
+static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
+{
+	return false;
+}
+
 static inline bool bpf_prog_ebpf_jited(const struct bpf_prog *fp)
 {
 	return false;
-- 
2.21.0

