Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F65EC433E0
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 02:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282992076C
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 02:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Yk6FfY4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgF3CFr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:05:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbgF3CFr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Jun 2020 22:05:47 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05U23JTv023278
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 19:05:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=AQbyH6FhX7YokLQGzHLfntIs/WN/l6/Es650iL5gwoo=;
 b=Yk6FfY4JxRpwscSoPQneiDznSQ1VEchqMR4c57Y2xVTaG4ljY64U1zYd8fhPd8V45gp8
 t9NqafVf2pG3Jwu+jSEW/eobT5J15iWgmrgERuIq8K6GVfQEYyYDj7SR1XwSuxaKVIsm
 VxxpIoa3fwb2jo5+ZBrfZXTdKVFze5Y9iho= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31ykcj2kbh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 19:05:46 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 19:05:44 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 92E072EC3BFB; Mon, 29 Jun 2020 19:05:40 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: make bpf_endian co-exist with vmlinux.h
Date:   Mon, 29 Jun 2020 19:05:38 -0700
Message-ID: <20200630020539.787781-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=405 clxscore=1015 suspectscore=8 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300013
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Copy over few #defines from UAPI swab.h header to make all the rest of
bpf_endian.h work and not rely on any extra headers. This way it can be u=
sed
both with linux header includes, as well with a vmlinux.h. This has been
a frequent complaint from users, that need this header.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/bpf_endian.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_endian.h b/tools/lib/bpf/bpf_endian.h
index fbe28008450f..a4be8a70845c 100644
--- a/tools/lib/bpf/bpf_endian.h
+++ b/tools/lib/bpf/bpf_endian.h
@@ -2,8 +2,26 @@
 #ifndef __BPF_ENDIAN__
 #define __BPF_ENDIAN__
=20
-#include <linux/stddef.h>
-#include <linux/swab.h>
+/* copied from include/uapi/linux/swab.h */
+#define ___constant_swab16(x) ((__u16)(				\
+	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
+	(((__u16)(x) & (__u16)0xff00U) >> 8)))
+
+#define ___constant_swab32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
+	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
+	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
+	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
+
+#define ___constant_swab64(x) ((__u64)(				\
+	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
+	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
+	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
+	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
+	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
+	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
+	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
+	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
=20
 /* LLVM's BPF target selects the endianness of the CPU
  * it compiles on, or the user specifies (bpfel/bpfeb),
--=20
2.24.1

