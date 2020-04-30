Return-Path: <SRS0=Oi1G=6O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E36C83004
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 01:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C187120757
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 01:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Sf/SHdtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgD3BZ4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:25:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17864 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgD3BZz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 21:25:55 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U1EjCP008179
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 18:25:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=3+o7l02/rlglt5SdbycnrNsOMQZhnw7LzfBDqT6Y0rA=;
 b=Sf/SHdtzoJCD5puxSO5diXsluU7EFs7VP0fG6a9ogg9vDD+FV2FUJ36KWHQcNGFEUuNZ
 Tzi9RWIRZCtzhCvwUQIM+DIrmERsMhaZ/kMItxwvABXopZSX2H5qQNNWuhMedw90k11y
 fVeYTt/X0zlYizPEV4zHQKGfKal2e3qPJo4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30qd6htthd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 18:25:54 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 29 Apr 2020 18:25:52 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 79F5C2EC306A; Wed, 29 Apr 2020 18:25:45 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: fix false unused variable warning
Date:   Wed, 29 Apr 2020 18:25:44 -0700
Message-ID: <20200430012544.1347275-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_11:2020-04-29,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=8
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some versions of GCC falsely detect that vi might not be initialized. Tha=
t's
not true, but let's silence it with NULL initialization.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d86ff8214b96..977add1b73e2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5003,8 +5003,8 @@ static int bpf_object__collect_map_relos(struct bpf=
_object *obj,
 					 GElf_Shdr *shdr, Elf_Data *data)
 {
 	int i, j, nrels, new_sz, ptr_sz =3D sizeof(void *);
+	const struct btf_var_secinfo *vi =3D NULL;
 	const struct btf_type *sec, *var, *def;
-	const struct btf_var_secinfo *vi;
 	const struct btf_member *member;
 	struct bpf_map *map, *targ_map;
 	const char *name, *mname;
--=20
2.24.1

