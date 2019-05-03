Return-Path: <SRS0=eGwH=TD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76281C43219
	for <bpf@archiver.kernel.org>; Fri,  3 May 2019 00:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E982080C
	for <bpf@archiver.kernel.org>; Fri,  3 May 2019 00:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g3yvCIx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfECAIQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 May 2019 20:08:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfECAIP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 May 2019 20:08:15 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4308DQf022576
        for <bpf@vger.kernel.org>; Thu, 2 May 2019 17:08:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=USqjk3EJGRFLoec6O+/rFlqnlw84fmAE9AWomwTX9J0=;
 b=g3yvCIx3iwvXd4qFKGHX1IUxjJcw9iPkcQeCuiprmODRWwjl+YRI+DCTQm08T+qx7L8X
 uaNQsRYODhdan2oUd8xjC1WgUp3oSmysJqAsY4pPXhBAXTkSK80U53sFAzihpWfhq0J3
 Fml1Yt2/aWhZyxoVaSQi4sR61bqntN8cJ30= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s86r1gsn2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 May 2019 17:08:15 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 2 May 2019 17:08:09 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 302EA3702ACB; Thu,  2 May 2019 17:08:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH bpf-next v2 2/3] tools/bpf: sync bpf uapi header bpf.h
Date:   Thu, 2 May 2019 17:08:08 -0700
Message-ID: <20190503000808.1341077-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503000806.1340927-1-yhs@fb.com>
References: <20190503000806.1340927-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sync bpf uapi header bpf.h to tools directory.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/include/uapi/linux/bpf.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 72336bac7573..e3e824848335 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2667,6 +2667,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf-local-storage cannot be found.
+ *
+ * int bpf_send_signal(u32 pid, u32 sig)
+ *	Description
+ *		Send signal *sig* to *pid*.
+ *	Return
+ *		0 on success or successfully queued.
+ *
+ *		**-ENOENT** if *pid* cannot be found.
+ *
+ *		**-EBUSY** if work queue under nmi is full.
+ *
+ * 		Other negative values for actual signal sending errors.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2777,7 +2789,8 @@ union bpf_attr {
 	FN(strtol),			\
 	FN(strtoul),			\
 	FN(sk_storage_get),		\
-	FN(sk_storage_delete),
+	FN(sk_storage_delete),		\
+	FN(send_signal),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.17.1

