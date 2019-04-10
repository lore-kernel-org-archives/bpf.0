Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFDC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 06:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5090F2083E
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 06:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDJGyl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:54:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:21903 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfDJGyl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 02:54:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 23:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="290252677"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO VM.isw.intel.com) ([10.103.211.40])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2019 23:54:38 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2] libbpf: fix crash in XDP socket part with new larger BPF_LOG_BUF_SIZE
Date:   Wed, 10 Apr 2019 08:54:16 +0200
Message-Id: <1554879256-30587-1-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit da11b417583e ("libbpf: teach libbpf about log_level bit 2"),
the BPF_LOG_BUF_SIZE was increased to 16M. The XDP socket part of
libbpf allocated the log_buf on the stack, but for the new 16M buffer
size this is not going to work. Change the code so it uses a 16K buffer
instead.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
v2: simplified code as suggested by Daniel Borkmann

 tools/lib/bpf/xsk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 8d0078b..557ef8d 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -259,7 +259,8 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area, __u64 size,

 static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 {
-	char bpf_log_buf[BPF_LOG_BUF_SIZE];
+	static const int log_buf_size = 16 * 1024;
+	char log_buf[log_buf_size];
 	int err, prog_fd;

 	/* This is the C-program:
@@ -308,10 +309,10 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);

 	prog_fd = bpf_load_program(BPF_PROG_TYPE_XDP, prog, insns_cnt,
-				   "LGPL-2.1 or BSD-2-Clause", 0, bpf_log_buf,
-				   BPF_LOG_BUF_SIZE);
+				   "LGPL-2.1 or BSD-2-Clause", 0, log_buf,
+				   log_buf_size);
 	if (prog_fd < 0) {
-		pr_warning("BPF log buffer:\n%s", bpf_log_buf);
+		pr_warning("BPF log buffer:\n%s", log_buf);
 		return prog_fd;
 	}

--
2.7.4
