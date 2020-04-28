Return-Path: <SRS0=8xVa=6M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC1C83000
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 06:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7142051A
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 06:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgD1Gdg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:33:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbgD1Gdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 02:33:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E2568747B62372AF1AB;
        Tue, 28 Apr 2020 14:33:27 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:33:19 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tsbogend@alpha.franken.de>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <andriin@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>, <linux-mips@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] KVM: MIPS/TLB: Remove Unneeded semicolon in tlb.c
Date:   Tue, 28 Apr 2020 14:32:45 +0800
Message-ID: <20200428063245.32776-1-yanaijie@huawei.com>
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

arch/mips/kvm/tlb.c:472:2-3: Unneeded semicolon
arch/mips/kvm/tlb.c:489:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/mips/kvm/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 7cd92166a0b9..5d436c5216cc 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -469,7 +469,7 @@ void kvm_vz_local_flush_guesttlb_all(void)
 		cvmmemctl2 |= CVMMEMCTL2_INHIBITTS;
 		write_c0_cvmmemctl2(cvmmemctl2);
 		break;
-	};
+	}
 
 	/* Invalidate guest entries in guest TLB */
 	write_gc0_entrylo0(0);
@@ -486,7 +486,7 @@ void kvm_vz_local_flush_guesttlb_all(void)
 	if (cvmmemctl2) {
 		cvmmemctl2 &= ~CVMMEMCTL2_INHIBITTS;
 		write_c0_cvmmemctl2(cvmmemctl2);
-	};
+	}
 
 	write_gc0_index(old_index);
 	write_gc0_entryhi(old_entryhi);
-- 
2.21.1

