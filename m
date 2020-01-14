Return-Path: <SRS0=Nq9f=3D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD22C33CB1
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E279B24670
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 09:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgANJta (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:49:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:50971 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANJta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 04:49:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 01:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="372534591"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO VM.isw.intel.com) ([10.103.211.46])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2020 01:49:27 -0800
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com
Cc:     rgoodfel@isi.edu, bpf@vger.kernel.org
Subject: [PATCH bpf-next] xsk: support allocations of large umems
Date:   Tue, 14 Jan 2020 10:49:25 +0100
Message-Id: <1578995365-7050-1-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When registering a umem area that is sufficiently large (>1G on an
x86), kmalloc cannot be used to allocate one of the internal data
structures, as the size requested gets too large. Use kvmalloc instead
that falls back on vmalloc if the allocation is too large for kmalloc.

Also add accounting for this structure as it is triggered by a user
space action (the XDP_UMEM_REG setsockopt) and it is by far the
largest structure of kernel allocated memory in xsk.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reported-by: Ryan Goodfellow <rgoodfel@isi.edu>
---
 net/xdp/xdp_umem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 3049af2..f93e917 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -249,7 +249,7 @@ static void xdp_umem_release(struct xdp_umem *umem)
 	xdp_umem_unmap_pages(umem);
 	xdp_umem_unpin_pages(umem);
 
-	kfree(umem->pages);
+	kvfree(umem->pages);
 	umem->pages = NULL;
 
 	xdp_umem_unaccount_pages(umem);
@@ -409,7 +409,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (err)
 		goto out_account;
 
-	umem->pages = kcalloc(umem->npgs, sizeof(*umem->pages), GFP_KERNEL);
+	umem->pages = kvcalloc(umem->npgs, sizeof(*umem->pages),
+			       GFP_KERNEL_ACCOUNT);
 	if (!umem->pages) {
 		err = -ENOMEM;
 		goto out_pin;
@@ -419,7 +420,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (!err)
 		return 0;
 
-	kfree(umem->pages);
+	kvfree(umem->pages);
 
 out_pin:
 	xdp_umem_unpin_pages(umem);
-- 
2.7.4

