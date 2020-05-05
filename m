Return-Path: <SRS0=Qn19=6T=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD0AC47247
	for <bpf@archiver.kernel.org>; Tue,  5 May 2020 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22E4206CC
	for <bpf@archiver.kernel.org>; Tue,  5 May 2020 07:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgEEHo1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 May 2020 03:44:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbgEEHo0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 03:44:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28354A8E70AC4AE36D1B;
        Tue,  5 May 2020 15:44:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 15:44:14 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jeffrey.t.kirsher@intel.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kuba@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH net-next] ixgbe: Use true,false for bool variable in __ixgbe_enable_sriov()
Date:   Tue, 5 May 2020 15:43:37 +0800
Message-ID: <20200505074337.21477-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the following coccicheck warning:

drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:105:2-38: WARNING:
Assignment of 0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 537dfff585e0..d05a5690e66b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -102,7 +102,7 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
 		 * indirection table and RSS hash key with PF therefore
 		 * we want to disable the querying by default.
 		 */
-		adapter->vfinfo[i].rss_query_enabled = 0;
+		adapter->vfinfo[i].rss_query_enabled = false;
 
 		/* Untrust all VFs */
 		adapter->vfinfo[i].trusted = false;
-- 
2.21.1

