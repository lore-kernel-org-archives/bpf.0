Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A657C433B4
	for <bpf@archiver.kernel.org>; Thu,  8 Apr 2021 05:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAE561181
	for <bpf@archiver.kernel.org>; Thu,  8 Apr 2021 05:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhDHFwV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Apr 2021 01:52:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:3077 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhDHFwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 01:52:19 -0400
IronPort-SDR: ZaQgM1ejEwtJIk8AF+PBgRegPi9GDvBWlEG3gPdkQTagr33ATK1MGGWkFN/9vtcmi+nlvZJjzd
 VGjFNGuZigQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="278734387"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="278734387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 22:52:09 -0700
IronPort-SDR: PDzAcQJrClzh+hDXaDPniBIfC6mgRI8Tx0tySBC9TYggltVf3v8yBjZERyZFZilFMQEG+LBcro
 DmHpBE7hf72Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="441609624"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.142])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2021 22:52:07 -0700
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, bjorn@kernel.org,
        andrii.nakryiko@gmail.com, alexei.starovoitov@gmail.com
Cc:     Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf] libbpf: fix potential NULL pointer dereference
Date:   Thu,  8 Apr 2021 05:20:09 +0000
Message-Id: <20210408052009.7844-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wait until after the UMEM is checked for null to dereference it.

Fixes: 43f1bc1efff1 ("libbpf: Restore umem state after socket create failure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 tools/lib/bpf/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index d24b5cc720ec..770040d1f893 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -858,12 +858,14 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 	struct xsk_socket *xsk;
 	struct xsk_ctx *ctx;
 	int err, ifindex;
-	bool unmap = umem->fill_save != fill;
+	bool unmap;
 	bool rx_setup_done = false, tx_setup_done = false;
 
 	if (!umem || !xsk_ptr || !(rx || tx))
 		return -EFAULT;
 
+	unmap = umem->fill_save != fill;
+
 	xsk = calloc(1, sizeof(*xsk));
 	if (!xsk)
 		return -ENOMEM;
-- 
2.17.1

