Return-Path: <SRS0=9soK=TZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D695C07542
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BEB2085A
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dYUx5llN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfEYS56 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 25 May 2019 14:57:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34770 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbfEYS56 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 May 2019 14:57:58 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4PIvt5D019087
        for <bpf@vger.kernel.org>; Sat, 25 May 2019 11:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=MxshrTqJ1tg+MhJ29Zqgr/S0R9JGfxxn5YyX9W2lDL4=;
 b=dYUx5llNYxUG3jRLh3LJwGNR861qSoWCVbYFlUaGWrCDy8w9y2g8bsTFDqD8rmFCRqf2
 9/mmSbg/Z0TFt48KK/fI3hqVz/r36I9iiMbPrVYo8xY2nNeL06kMv+Je1d1W1RhqveVC
 1slNsVLvE9SCzgaEANjsJQopPinObelhrCo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sq3ha8vhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 25 May 2019 11:57:56 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sat, 25 May 2019 11:57:55 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 03D993701F13; Sat, 25 May 2019 11:57:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: check signal validity in nmi for bpf_send_signal() helper
Date:   Sat, 25 May 2019 11:57:53 -0700
Message-ID: <20190525185753.2467090-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-25_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905250134
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
introduced bpf_send_signal() helper. If the context is nmi,
the sending signal work needs to be deferred to irq_work.
If the signal is invalid, the error will appear in irq_work
and it won't be propagated to user.

This patch did an early check in the helper itself to
notify user invalid signal, as suggested by Daniel.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 70029eafc71f..fe73926a07cd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -600,6 +600,12 @@ BPF_CALL_1(bpf_send_signal, u32, sig)
 		return -EPERM;
 
 	if (in_nmi()) {
+		/* Do an early check on signal validity. Otherwise,
+		 * the error is lost in deferred irq_work.
+		 */
+		if (unlikely(!valid_signal(sig)))
+			return -EINVAL;
+
 		work = this_cpu_ptr(&send_signal_work);
 		if (work->irq_work.flags & IRQ_WORK_BUSY)
 			return -EBUSY;
-- 
2.17.1

