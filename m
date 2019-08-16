Return-Path: <SRS0=Gny/=WM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700C9C3A59C
	for <bpf@archiver.kernel.org>; Fri, 16 Aug 2019 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECAA20644
	for <bpf@archiver.kernel.org>; Fri, 16 Aug 2019 10:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHPK0Y (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:26:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:12004 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHPK0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Aug 2019 06:26:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 03:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="328646255"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.252.52.109])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2019 03:26:21 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] libbpf: remove zc variable as it is not used
Date:   Fri, 16 Aug 2019 12:26:11 +0200
Message-Id: <1565951171-14439-1-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The zc is not used in the xsk part of libbpf, so let us remove it. Not
good to have dead code lying around.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reported-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/xsk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 680e630..9687da9 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -65,7 +65,6 @@ struct xsk_socket {
 	int xsks_map_fd;
 	__u32 queue_id;
 	char ifname[IFNAMSIZ];
-	bool zc;
 };
 
 struct xsk_nl_info {
@@ -608,8 +607,6 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		goto out_mmap_tx;
 	}
 
-	xsk->zc = opts.flags & XDP_OPTIONS_ZEROCOPY;
-
 	if (!(xsk->config.libbpf_flags & XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD)) {
 		err = xsk_setup_xdp_prog(xsk);
 		if (err)
-- 
2.7.4

