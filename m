Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B36C433E0
	for <bpf@archiver.kernel.org>; Sun, 10 Jan 2021 07:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6055227BF
	for <bpf@archiver.kernel.org>; Sun, 10 Jan 2021 07:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbhAJHE2 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 10 Jan 2021 02:04:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbhAJHE2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 10 Jan 2021 02:04:28 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10A6vVRw009762
        for <bpf@vger.kernel.org>; Sat, 9 Jan 2021 23:03:47 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35y9dgjyt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 09 Jan 2021 23:03:47 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 9 Jan 2021 23:03:46 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 43F102ECD3D6; Sat,  9 Jan 2021 23:03:45 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Christopher William Snowhill <chris@kode54.net>
Subject: [PATCH bpf 1/2] bpf: allow empty module BTFs
Date:   Sat, 9 Jan 2021 23:03:40 -0800
Message-ID: <20210110070341.1380086-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-09_13:2021-01-07,2021-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxlogscore=831 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101100043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some modules don't declare any new types and end up with an empty BTF,
containing only valid BTF header and no types or strings sections. This
currently causes BTF validation error. There is nothing wrong with such BTF,
so fix the issue by allowing module BTFs with no types or strings.

Reported-by: Christopher William Snowhill <chris@kode54.net>
Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8d6bdb4f4d61..84a36ee4a4c2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4172,7 +4172,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 		return -ENOTSUPP;
 	}
 
-	if (btf_data_size == hdr->hdr_len) {
+	if (!btf->base_btf && btf_data_size == hdr->hdr_len) {
 		btf_verifier_log(env, "No data");
 		return -EINVAL;
 	}
-- 
2.24.1

