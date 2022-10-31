Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D8AFA3744
	for <bpf@archiver.kernel.org>; Mon, 31 Oct 2022 22:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJaW0G convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 31 Oct 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJaW0E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 18:26:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9562140A6
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:02 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VMPCrX021865
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kjk60t974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:02 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 15:26:01 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 14D99F0CC5BD; Mon, 31 Oct 2022 15:25:52 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <dave.hansen@intel.com>, <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v1 RESEND 2/5] x86/alternative: support vmalloc_exec() and vfree_exec()
Date:   Mon, 31 Oct 2022 15:25:38 -0700
Message-ID: <20221031222541.1773452-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221031222541.1773452-1-song@kernel.org>
References: <20221031222541.1773452-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MQfI-EEZHq-wa6QD17v1VtKe96LHs-sq
X-Proofpoint-ORIG-GUID: MQfI-EEZHq-wa6QD17v1VtKe96LHs-sq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement arch_vcopy_exec() and arch_invalidate_exec() to support
vmalloc_exec.

arch_vcopy_exec() copies dynamic kernel text (such as BPF programs) to
RO+X memory region allocated by vmalloc_exec().

arch_invalidate_exec() fills memory with 0xcc after it is released by
vfree_exec().

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/kernel/alternative.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea035e0..73d89774ace3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1270,6 +1270,18 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
 	return addr;
 }
 
+void *arch_vcopy_exec(void *dst, void *src, size_t len)
+{
+	if (text_poke_copy(dst, src, len) == NULL)
+		return ERR_PTR(-EINVAL);
+	return dst;
+}
+
+int arch_invalidate_exec(void *ptr, size_t len)
+{
+	return IS_ERR_OR_NULL(text_poke_set(ptr, 0xcc, len));
+}
+
 /**
  * text_poke_set - memset into (an unused part of) RX memory
  * @addr: address to modify
-- 
2.30.2

