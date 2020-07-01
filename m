Return-Path: <SRS0=pDiR=AM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1918C433E1
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 15:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB51A207D0
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 15:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgGAP2E (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:28:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732091AbgGAP2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 11:28:04 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D3A14C9271524C7A94B;
        Wed,  1 Jul 2020 23:27:57 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 23:27:48 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <hulkci@huawei.com>, Ariel Elior <aelior@marvell.com>,
        <GR-everest-linux-l2@marvell.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next] qed: Make symbol 'qed_hw_err_type_descr' static
Date:   Wed, 1 Jul 2020 23:38:03 +0800
Message-ID: <20200701153803.69360-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hulk Robot <hulkci@huawei.com>

Fix sparse build warning:

drivers/net/ethernet/qlogic/qed/qed_main.c:2480:6: warning:
 symbol 'qed_hw_err_type_descr' was not declared. Should it be static?

Signed-off-by: Hulk Robot <hulkci@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 11367a248d55..0a23b788b842 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -2477,7 +2477,7 @@ void qed_schedule_recovery_handler(struct qed_hwfn *p_hwfn)
 		ops->schedule_recovery_handler(cookie);
 }
 
-char *qed_hw_err_type_descr[] = {
+static char *qed_hw_err_type_descr[] = {
 	[QED_HW_ERR_FAN_FAIL]		= "Fan Failure",
 	[QED_HW_ERR_MFW_RESP_FAIL]	= "MFW Response Failure",
 	[QED_HW_ERR_HW_ATTN]		= "HW Attention",

