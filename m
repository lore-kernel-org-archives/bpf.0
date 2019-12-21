Return-Path: <SRS0=01yY=2L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD86C2D0D2
	for <bpf@archiver.kernel.org>; Sat, 21 Dec 2019 06:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBD221D7E
	for <bpf@archiver.kernel.org>; Sat, 21 Dec 2019 06:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZL12zYzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfLUG0G (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 21 Dec 2019 01:26:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47080 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfLUG0G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 21 Dec 2019 01:26:06 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBL6OGNc018086
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 22:26:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=VUoucxNvoU04kxSwC0y7LXEFAnHiltIJycpH3IypH+g=;
 b=ZL12zYzw+ZRE4PT8WyqUkDV4BWx1byrjLqvMaMcFjRSQWxa8CUnvvPlNC0NNzRNgW8wb
 scOIGcLEcW8Qr4SNLoZoi/ibqDTM6EJpocFwnqf2Nvj9Vvv6EgZExQYri+j4q75fNgwH
 jIpMfolkxh4bYY+Rgc5t1qL5U0GRAq7VCNk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2x0m9ypfn5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 22:26:05 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Dec 2019 22:26:04 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 2C28F2946127; Fri, 20 Dec 2019 22:26:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 03/11] bpf: Add enum support to btf_ctx_access()
Date:   Fri, 20 Dec 2019 22:26:02 -0800
Message-ID: <20191221062602.1182627-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221062556.1182261-1-kafai@fb.com>
References: <20191221062556.1182261-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-21_01:2019-12-17,2019-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 mlxlogscore=833 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=13 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912210054
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It allows bpf prog (e.g. tracing) to attach
to a kernel function that takes enum argument.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 88359a4bccb0..6e652643849b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3676,7 +3676,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	/* skip modifiers */
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
-	if (btf_type_is_int(t))
+	if (btf_type_is_int(t) || btf_type_is_enum(t))
 		/* accessing a scalar */
 		return true;
 	if (!btf_type_is_ptr(t)) {
-- 
2.17.1

