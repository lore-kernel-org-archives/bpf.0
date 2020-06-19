Return-Path: <SRS0=nKFI=AA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD4C433E0
	for <bpf@archiver.kernel.org>; Fri, 19 Jun 2020 22:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F3622283
	for <bpf@archiver.kernel.org>; Fri, 19 Jun 2020 22:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kTtCrxBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgFSWU3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:20:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729164AbgFSWU3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 18:20:29 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05JM3rp3003952
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 15:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=WK7HQ/LBtBVqfsOLYU2138qi2tabx0PY8d+lO7GdfPw=;
 b=kTtCrxBxxWJydKbiIw5mbeZiwB4KATttln/6aNYMxmkpJX4mGj4OKLuJUV3iKrVTTBu1
 DocId9BikxiikIpIpzK0GeL0anILrccYn0QOEW95UbX3oZMju7eM/yf5VpdTQW8xlyYl
 c9/pvxi3Rm1PTvL3hi218vRTG0P+2CKB1q4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31q64572nx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 15:20:28 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 15:20:26 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DE7EB2EC3537; Fri, 19 Jun 2020 15:20:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] tools/bpftool: relicense bpftool's BPF profiler prog as dual-license GPL/BSD
Date:   Fri, 19 Jun 2020 15:20:24 -0700
Message-ID: <20200619222024.519774-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 suspectscore=8 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=623 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190155
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Relicense it to be compatible with the rest of bpftool files.

Cc: Song Liu <songliubraving@fb.com>
Suggested-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftoo=
l/skeleton/profiler.bpf.c
index 20034c12f7c5..c9d196ddb670 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2020 Facebook
 #include "profiler.h"
 #include <linux/bpf.h>
@@ -116,4 +116,4 @@ int BPF_PROG(fexit_XXX)
 	return 0;
 }
=20
-char LICENSE[] SEC("license") =3D "GPL";
+char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
--=20
2.24.1

