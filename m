Return-Path: <SRS0=IKg2=DM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19E1C4363A
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D87206BE
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601937423;
	bh=AKU4qBEXVWgF4Fb3zy2dc2UKBvi5VHhJrPqOnYONOuo=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=ZT8utOvnB7G0leCG1ZVaMcizuhSm/91QsNSgeZ4pw4W1GscsiXjtZBUR8EXuCsLxi
	 e2famUOsDGxGeaABvJ+coc4zDYbAl/i5jlKbbVHkkhuF6BNt13SIKtGODGs3quzN8R
	 MfUw6nEmAs6BOavEBP22OQY9xvkP8dN1kBpL0QSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgJEWhD convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 5 Oct 2020 18:37:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8160 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbgJEWhD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Oct 2020 18:37:03 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095MOOJB012231
        for <bpf@vger.kernel.org>; Mon, 5 Oct 2020 15:37:02 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33xptn1xds-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 15:37:01 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 5 Oct 2020 15:36:59 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id C33D42EC7A13; Mon,  5 Oct 2020 15:36:58 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpf, doc: Update Andrii's email in MAINTAINERS
Date:   Mon, 5 Oct 2020 15:36:48 -0700
Message-ID: <20201005223648.2437130-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_16:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=699 clxscore=1011 suspectscore=9 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050157
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update Andrii Nakryiko's reviewer email to kernel.org account. This optimizes
email logistics on my side and makes it less likely for me to miss important
patches.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1e946606dce..fd5d5507d229 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3258,7 +3258,7 @@ M:	Daniel Borkmann <daniel@iogearbox.net>
 R:	Martin KaFai Lau <kafai@fb.com>
 R:	Song Liu <songliubraving@fb.com>
 R:	Yonghong Song <yhs@fb.com>
-R:	Andrii Nakryiko <andriin@fb.com>
+R:	Andrii Nakryiko <andrii@kernel.org>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@chromium.org>
 L:	netdev@vger.kernel.org
-- 
2.24.1

