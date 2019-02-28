Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4CC10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB42206B8
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367388;
	bh=Z5+rDUULjVujJ0pOmcJhH2eynq6PMvgP+zIvZu7OM10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=efuiVmjhqkbcWGAt5CcFQCLwsq8LP0DnR6RpSwlmOC4UHTkJy+zNwxzkWgZDjiCsH
	 ZZRIy0NAS6dOwoIthdJGwxqoPTg3R5j3zCjAxL1pvsSGiykcC8QVoNOD1R6ZcL/EuJ
	 0+l0yz+JFcemqTRgnJShGH/wIJv/j3hdDRXnHcWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfB1PW5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388462AbfB1PNd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43ED2218EA;
        Thu, 28 Feb 2019 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366812;
        bh=Z5+rDUULjVujJ0pOmcJhH2eynq6PMvgP+zIvZu7OM10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXxs5GO+Uye6YCVubsBi/CYWo0zIWeLs2//YGeo1B3NDdVsDpoBy7FuLOEDGPbza0
         Ejs8hRF0q+LegMcM2Jn30tpDCMxXOgUEUgqfVtxv2XHv2Id4FAT3Ttfkp6aw6AqxjV
         e7a02/jK8Emyo9Y/+f8NQwDWKWpY05jq9StdH85E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 62/64] qed: Consider TX tcs while deriving the max num_queues for PF.
Date:   Thu, 28 Feb 2019 10:11:03 -0500
Message-Id: <20190228151105.11277-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sudarsana Reddy Kalluru <skalluru@marvell.com>

[ Upstream commit fb1faab74ddef9ec2d841d54e5d0912a097b3abe ]

Max supported queues is derived incorrectly in the case of multi-CoS.
Need to consider TCs while calculating num_queues for PF.

Signed-off-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 67c02ea939062..bde6f5f3bf8f7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2207,7 +2207,7 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 			u16 num_queues = 0;
 
 			/* Since the feature controls only queue-zones,
-			 * make sure we have the contexts [rx, tx, xdp] to
+			 * make sure we have the contexts [rx, xdp, tcs] to
 			 * match.
 			 */
 			for_each_hwfn(cdev, i) {
@@ -2217,7 +2217,8 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 				u16 cids;
 
 				cids = hwfn->pf_params.eth_pf_params.num_cons;
-				num_queues += min_t(u16, l2_queues, cids / 3);
+				cids /= (2 + info->num_tc);
+				num_queues += min_t(u16, l2_queues, cids);
 			}
 
 			/* queues might theoretically be >256, but interrupts'
-- 
2.19.1

