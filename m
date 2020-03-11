Return-Path: <SRS0=y2jO=44=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4396C2BAEE
	for <bpf@archiver.kernel.org>; Wed, 11 Mar 2020 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CCD206BE
	for <bpf@archiver.kernel.org>; Wed, 11 Mar 2020 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iv/VNX7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgCKSx7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:53:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31402 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730927AbgCKSx6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Mar 2020 14:53:58 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BIheYO001529
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 11:53:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=agaD1L6x13VFkiieNxYQs4HHP2Frm3fHVTIhAYCNKC8=;
 b=iv/VNX7yc7oEp5rE1tStjfyKA1LtPr0AiBZYcKZ1Dnroh8S9SANpQuRPfKJ9MVn+dLp5
 k3CvoxNxaycFRKXju6AT6Bax07hh4xV7I92yuh0HvVzG9fTqMMZ71Cd9/C9b6wDAz/qZ
 NJj7kzGbTd0bAAxXTLJhSdaBSQketpt5cSE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yp7t2rkdy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 11:53:57 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 11:53:55 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 1C66E2EC2DD2; Wed, 11 Mar 2020 11:53:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Julia Kartseva <hex@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] selftests/bpf: guarantee that useep() calls nanosleep() syscall
Date:   Wed, 11 Mar 2020 11:53:45 -0700
Message-ID: <20200311185345.3874602-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_09:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 suspectscore=8
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110106
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some implementations of C runtime library won't call nanosleep() syscall from
usleep(). But a bunch of kprobe/tracepoint selftests rely on nanosleep being
called to trigger them. To make this more reliable, "override" usleep
implementation and call nanosleep explicitly.

Cc: Julia Kartseva <hex@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index a969c77e9456..2b0bc1171c9c 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -29,6 +29,15 @@ struct prog_test_def {
 	int old_error_cnt;
 };
 
+/* Override C runtime library's usleep() implementation to ensure nanosleep()
+ * is always called. Usleep is frequently used in selftests as a way to
+ * trigger kprobe and tracepoints.
+ */
+int usleep(useconds_t usec)
+{
+	return syscall(__NR_nanosleep, usec * 1000UL);
+}
+
 static bool should_run(struct test_selector *sel, int num, const char *name)
 {
 	int i;
-- 
2.17.1

