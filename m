Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A822C10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1161F206B8
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367183;
	bh=8E6k2FzRtsTViumB/9A54g9dWIRV6iQjnr9AuDu8ZKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c97p1sEs/mcz1tq7kCcrjXHLjPNYpXuC5W1KZ0lmQo/fFQIql5DyBWexeuM7wreyV
	 TbBU5athOfsHKcomaKWXxsrVkWb4UEmwk2RPWlZto4F0oB2khM8oQUHaDp+25vgTLb
	 tmT1Ch2ZR57CAnJHPonacolcQnuKO5tVwK6ugVYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfB1PPV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388801AbfB1PPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 10:15:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F44218D8;
        Thu, 28 Feb 2019 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366914;
        bh=8E6k2FzRtsTViumB/9A54g9dWIRV6iQjnr9AuDu8ZKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGVN7IfQJbGacU4pGv6gYzHydy8o3I+4TD39Sb/BzVieu7GjBJDf3fUmkO0cidqY6
         qUQc00YyOn+sbxiCiV2cQl3gPteQC8Jc+fkLCs5y6vRV9njUDi7pLytHXDQyuz968q
         u38RU0cAEdqtlSBCLXjdbIkzvWtjnh3k9CI833Hc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 36/36] qed: Consider TX tcs while deriving the max num_queues for PF.
Date:   Thu, 28 Feb 2019 10:13:37 -0500
Message-Id: <20190228151337.12176-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
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
index 83c1c4fa102b7..13db311c16e5e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2161,7 +2161,7 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 			u16 num_queues = 0;
 
 			/* Since the feature controls only queue-zones,
-			 * make sure we have the contexts [rx, tx, xdp] to
+			 * make sure we have the contexts [rx, xdp, tcs] to
 			 * match.
 			 */
 			for_each_hwfn(cdev, i) {
@@ -2171,7 +2171,8 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 				u16 cids;
 
 				cids = hwfn->pf_params.eth_pf_params.num_cons;
-				num_queues += min_t(u16, l2_queues, cids / 3);
+				cids /= (2 + info->num_tc);
+				num_queues += min_t(u16, l2_queues, cids);
 			}
 
 			/* queues might theoretically be >256, but interrupts'
-- 
2.19.1

