Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6883DC27C76
	for <bpf@archiver.kernel.org>; Fri, 20 Jan 2023 20:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjATUJw convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 20 Jan 2023 15:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjATUJv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:51 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACBB2E0D9
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:50 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDb3aW019632
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n7gdede80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:49 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub203.TheFacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:48 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:47 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 663CF25B4B0FD; Fri, 20 Jan 2023 12:09:44 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 14/25] libbpf: define i386 syscall regs spec in bpf_tracing.h
Date:   Fri, 20 Jan 2023 12:09:03 -0800
Message-ID: <20230120200914.3008030-15-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4sqXIXo5RYdclyJvqY4NZuGtbmC4EdUo
X-Proofpoint-ORIG-GUID: 4sqXIXo5RYdclyJvqY4NZuGtbmC4EdUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Define explicit table of registers used for syscall argument passing.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 5fd498821c29..4d04c63fda27 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -115,6 +115,14 @@
 #define __PT_PARM1_REG eax
 #define __PT_PARM2_REG edx
 #define __PT_PARM3_REG ecx
+/* i386 syscall ABI is very different, refer to syscall(2) manpage */
+#define __PT_PARM1_SYSCALL_REG ebx
+#define __PT_PARM2_SYSCALL_REG ecx
+#define __PT_PARM3_SYSCALL_REG edx
+#define __PT_PARM4_SYSCALL_REG esi
+#define __PT_PARM5_SYSCALL_REG edi
+#define __PT_PARM6_SYSCALL_REG ebp
+
 #define __PT_RET_REG esp
 #define __PT_FP_REG ebp
 #define __PT_RC_REG eax
-- 
2.30.2

