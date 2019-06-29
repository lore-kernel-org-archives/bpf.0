Return-Path: <SRS0=toPo=U4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56448C4321A
	for <bpf@archiver.kernel.org>; Sat, 29 Jun 2019 03:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EC12075B
	for <bpf@archiver.kernel.org>; Sat, 29 Jun 2019 03:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BkaZqphq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF2DtX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 28 Jun 2019 23:49:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbfF2DtW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Jun 2019 23:49:22 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5T3eInM002584
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 20:49:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=GrdcN3lNuRmhbU4usBWfWIeDtUK+6XIcFMFVaBeCs0U=;
 b=BkaZqphq9+e2BKe1dAkBXPB6HrLhgrf3yLEwqJ40w5qjRBa6byLhWLmuy3PBEoGPlDmJ
 jIFe26ewbE6hyRmNKXoKj7cBNfJGS/Nw4LRJi4m6ayqFLcRjngDwLzvAqeUI4d4SzGuN
 W8rNk/7WOiOMZvj9mzM/aJnqfzEDlbER7vQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tdsd0s5q3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 20:49:21 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Jun 2019 20:49:11 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id AB1198613F5; Fri, 28 Jun 2019 20:49:09 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <sdf@fomichev.me>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 1/9] libbpf: make libbpf_strerror_r agnostic to sign of error
Date:   Fri, 28 Jun 2019 20:48:58 -0700
Message-ID: <20190629034906.1209916-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629034906.1209916-1-andriin@fb.com>
References: <20190629034906.1209916-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=776 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906290043
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's often inconvenient to switch sign of error when passing it into
libbpf_strerror_r. It's better for it to handle that automatically.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 tools/lib/bpf/str_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 00e48ac5b806..b8064eedc177 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -11,7 +11,7 @@
  */
 char *libbpf_strerror_r(int err, char *dst, int len)
 {
-	int ret = strerror_r(err, dst, len);
+	int ret = strerror_r(err < 0 ? -err : err, dst, len);
 	if (ret)
 		snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
 	return dst;
-- 
2.17.1

