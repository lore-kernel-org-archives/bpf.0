Return-Path: <SRS0=s4C/=BH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF1C433E1
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 19:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5A92074F
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M6B/2vwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgG1TFi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:05:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729217AbgG1TFh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 15:05:37 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06SJ3Rap017406
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 12:05:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=dokCYr0Heq2KU3GFLypgUYG1uu3V7zp2F9pmu0AG1R0=;
 b=M6B/2vwnJVjXZBygU8IfH7XZz3atwX4lECAROYzWk0V2keG7F1XdKkUyaXP5XMyAMkMs
 dR0DuqabhstGTY144mhTS46g4mSQSzJjcQxM0EK1fbR2g7/3tvvaKuQFi37fhgvLI0ZH
 ZaZ43n6I8i6FKNFt2xM7qR9nXH6FUqzP9oQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32ggdmp1mu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 12:05:36 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 12:05:34 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0C2E42EC4C42; Tue, 28 Jul 2020 12:05:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <rdunlap@infradead.org>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: fix build without CONFIG_NET when using BPF XDP link
Date:   Tue, 28 Jul 2020 12:05:27 -0700
Message-ID: <20200728190527.110830-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_15:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=864
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=8
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007280135
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Entire net/core subsystem is not built without CONFIG_NET. linux/netdevic=
e.h
just assumes that it's always there, so the easiest way to fix this is to
conditionally compile out bpf_xdp_link_attach() use in bpf/syscall.c.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: aa8d3a716b59 ("bpf, xdp: Add bpf_link-based XDP attachment API")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0e8c88db7e7a..cd3d599e9e90 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3923,9 +3923,11 @@ static int link_create(union bpf_attr *attr)
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		ret =3D netns_bpf_link_create(attr, prog);
 		break;
+#ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
 		ret =3D bpf_xdp_link_attach(attr, prog);
 		break;
+#endif
 	default:
 		ret =3D -EINVAL;
 	}
--=20
2.24.1

