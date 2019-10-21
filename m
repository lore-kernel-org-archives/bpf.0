Return-Path: <SRS0=mFv6=YO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03658CA9EAB
	for <bpf@archiver.kernel.org>; Mon, 21 Oct 2019 03:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DFD21897
	for <bpf@archiver.kernel.org>; Mon, 21 Oct 2019 03:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fD5UuvRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfJUDjQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:39:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbfJUDjN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 20 Oct 2019 23:39:13 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9L3T3f9030471
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2019 20:39:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=y4wpV9YLaCWZlZnj83j8v5D7586y6yoLiL+Z047JbDg=;
 b=fD5UuvRf1x217f7MMCzndH2QhbQ6RjYkHSdTyxgb+sHA8LOghg+RmCZUJezPGjOIKjg/
 9MfjgMzimEiln0KRy8HikIqeNcMJsxZMWeDpW80AvjfDUrVN2NiOAx7dMYyuTeg/nT4E
 SQhvnWltrc7ZMVTKNNAbYHfzYW9ZGIcqBhE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vrjt2afm5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2019 20:39:12 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Oct 2019 20:39:10 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id EAB3D861976; Sun, 20 Oct 2019 20:39:07 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/7] tools: sync if_link.h
Date:   Sun, 20 Oct 2019 20:38:56 -0700
Message-ID: <20191021033902.3856966-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021033902.3856966-1-andriin@fb.com>
References: <20191021033902.3856966-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_01:2019-10-18,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=858 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210029
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync if_link.h into tools/ and get rid of annoying libbpf Makefile warning.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/include/uapi/linux/if_link.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 4a8c02cafa9a..8aec8769d944 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -167,6 +167,8 @@ enum {
 	IFLA_NEW_IFINDEX,
 	IFLA_MIN_MTU,
 	IFLA_MAX_MTU,
+	IFLA_PROP_LIST,
+	IFLA_ALT_IFNAME, /* Alternative ifname */
 	__IFLA_MAX
 };
 
-- 
2.17.1

