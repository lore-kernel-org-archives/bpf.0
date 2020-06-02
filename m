Return-Path: <SRS0=Pto2=7P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77281C433E0
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 09:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AA2206C3
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 09:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFBJTK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:19:10 -0400
Received: from mx57.baidu.com ([61.135.168.57]:28967 "EHLO
        tc-sys-mailedm05.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgFBJTK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Jun 2020 05:19:10 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2020 05:19:10 EDT
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm05.tc.baidu.com (Postfix) with ESMTP id F2C0C1EBA004;
        Tue,  2 Jun 2020 17:12:28 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] i40e: fix wrong index in i40e_xsk_umem_dma_map
Date:   Tue,  2 Jun 2020 17:12:28 +0800
Message-Id: <1591089148-959-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes: 0a714186d3c0 "(i40e: add AF_XDP zero-copy Rx support)"
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 0b7d29192b2c..c926438118ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -37,9 +37,9 @@ static int i40e_xsk_umem_dma_map(struct i40e_vsi *vsi, struct xdp_umem *umem)
 
 out_unmap:
 	for (j = 0; j < i; j++) {
-		dma_unmap_page_attrs(dev, umem->pages[i].dma, PAGE_SIZE,
+		dma_unmap_page_attrs(dev, umem->pages[j].dma, PAGE_SIZE,
 				     DMA_BIDIRECTIONAL, I40E_RX_DMA_ATTR);
-		umem->pages[i].dma = 0;
+		umem->pages[j].dma = 0;
 	}
 
 	return -1;
-- 
2.16.2

