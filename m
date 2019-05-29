Return-Path: <SRS0=eg6P=T5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD0BC04AB6
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 01:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BB2208C3
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 01:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ipur/ulv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfE2BOo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 May 2019 21:14:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfE2BOn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 May 2019 21:14:43 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T1DHaJ030282
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=GE4BTLxl3WgGlk4EgqMUIJD1pqnmU4e32ecwnEY/jts=;
 b=ipur/ulvgL8Mwh7X5UTLClEnjXsjlfyBus5/D1ipoANHwX8pR1gpGl7AKYaZwtmUeQRZ
 HjlkHmfK227EcBI23M4xKBZ/4YgayWfdIHaNihbEHdnQARkImGs2svbxu4k76xnqO3UL
 6bXQG4urR0rEFwos6FT3nMrpJgrm8naBjq8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ss6cst7pg-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:42 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 May 2019 18:14:41 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 14F228617AA; Tue, 28 May 2019 18:14:39 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 5/9] libbpf: fix error code returned on corrupted ELF
Date:   Tue, 28 May 2019 18:14:22 -0700
Message-ID: <20190529011426.1328736-6-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529011426.1328736-1-andriin@fb.com>
References: <20190529011426.1328736-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All of libbpf errors are negative, except this one. Fix it.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7abe71ee507a..9c45856e7fd6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1221,7 +1221,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
 
 	if (!obj->efile.strtabidx || obj->efile.strtabidx >= idx) {
 		pr_warning("Corrupted ELF file: index of strtab invalid\n");
-		return LIBBPF_ERRNO__FORMAT;
+		return -LIBBPF_ERRNO__FORMAT;
 	}
 	if (btf_data) {
 		obj->btf = btf__new(btf_data->d_buf, btf_data->d_size);
-- 
2.17.1

