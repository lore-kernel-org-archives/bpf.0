Return-Path: <SRS0=/x2n=CN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F43EC433E2
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 04:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647F020748
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 04:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ECHunJtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIDEQZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:16:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgIDEQZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Sep 2020 00:16:25 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0844DXEh027673
        for <bpf@vger.kernel.org>; Thu, 3 Sep 2020 21:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=n3DyQ6hup2hgi3k95ilMSadcTvm3ef7F/g6ukHpZaoU=;
 b=ECHunJtm1CeHT+LMklmv+sEnQgdrgu9Zw3kemuKxe6w6yJaOUjk0+TmTHSncfHbMI+Gh
 OePuHjOSSgupJZKhiQhBa7eSmZPmirJOjJQ/8a0aEWHZTTv8WvHRujfv9S+fobDpXWI+
 WZllFIxaUusO25CKQUXiJyR4OGPljcOfxsI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33am8efr34-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 21:16:24 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 21:16:23 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0FFE82EC6841; Thu,  3 Sep 2020 21:16:17 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next 2/2] libbpf: fix potential multiplication overflow
Date:   Thu, 3 Sep 2020 21:16:11 -0700
Message-ID: <20200904041611.1695163-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200904041611.1695163-1-andriin@fb.com>
References: <20200904041611.1695163-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_02:2020-09-03,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=8 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=851 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040038
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Detected by LGTM static analyze in Github repo, fix potential multiplicat=
ion
overflow before result is casted to size_t.

Fixes: 8505e8709b5e ("libbpf: Implement generalized .BTF.ext func/line in=
fo adjustment")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 53be32a2b9fc..550950eb1860 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5802,7 +5802,7 @@ static int adjust_prog_btf_ext_info(const struct bp=
f_object *obj,
 		/* append func/line info of a given (sub-)program to the main
 		 * program func/line info
 		 */
-		old_sz =3D (*prog_rec_cnt) * ext_info->rec_size;
+		old_sz =3D (size_t)(*prog_rec_cnt) * ext_info->rec_size;
 		new_sz =3D old_sz + (copy_end - copy_start);
 		new_prog_info =3D realloc(*prog_info, new_sz);
 		if (!new_prog_info)
--=20
2.24.1

