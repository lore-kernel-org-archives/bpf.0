Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC1FC433E0
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 06:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB0E206BE
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 06:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VzXZ7sST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgF3GHu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:07:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728749AbgF3GHu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 02:07:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05U67nqY010819
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:07:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=q7qW3J2JQaE057qj6hFj2gzPwTp9dGWKC6KPKKNW9ak=;
 b=VzXZ7sSTuF+h/kbuFjwv8+/n9vXe25gzsEu0KCcsiOWzOxMTV2PG1W1zYlb8LApJjLhV
 Yb6o6Vaj6hmPqeBWvHdsHv8dlKCXSfHpkR5uZI7Ja4gXIOPgRu7GOGGf7UXfPMqYwDK1
 zFKhl9VSuw0+yYeFKMzt1HleO+cdl0XbYwc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31ykcj39p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 23:07:49 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 23:07:47 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D432A2EC2E95; Mon, 29 Jun 2020 23:07:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add byte swapping selftest
Date:   Mon, 29 Jun 2020 23:07:39 -0700
Message-ID: <20200630060739.1722733-3-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630060739.1722733-1-andriin@fb.com>
References: <20200630060739.1722733-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=942 clxscore=1015 suspectscore=8 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add simple selftest validating byte swap built-ins and compile-time macro=
s.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../testing/selftests/bpf/prog_tests/endian.c | 53 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_endian.c | 37 +++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/endian.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_endian.c

diff --git a/tools/testing/selftests/bpf/prog_tests/endian.c b/tools/test=
ing/selftests/bpf/prog_tests/endian.c
new file mode 100644
index 000000000000..1a11612ace6c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/endian.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include <test_progs.h>
+#include "test_endian.skel.h"
+
+static int duration;
+
+#define IN16 0x1234
+#define IN32 0x12345678U
+#define IN64 0x123456789abcdef0ULL
+
+#define OUT16 0x3412
+#define OUT32 0x78563412U
+#define OUT64 0xf0debc9a78563412ULL
+
+void test_endian(void)
+{
+	struct test_endian* skel;
+	struct test_endian__bss *bss;
+	int err;
+
+	skel =3D test_endian__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+	bss =3D skel->bss;
+
+	bss->in16 =3D IN16;
+	bss->in32 =3D IN32;
+	bss->in64 =3D IN64;
+
+	err =3D test_endian__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	usleep(1);
+
+	CHECK(bss->out16 !=3D OUT16, "out16", "got 0x%llx !=3D exp 0x%llx\n",
+	      (__u64)bss->out16, (__u64)OUT16);
+	CHECK(bss->out32 !=3D OUT32, "out32", "got 0x%llx !=3D exp 0x%llx\n",
+	      (__u64)bss->out32, (__u64)OUT32);
+	CHECK(bss->out64 !=3D OUT64, "out16", "got 0x%llx !=3D exp 0x%llx\n",
+	      (__u64)bss->out64, (__u64)OUT64);
+
+	CHECK(bss->const16 !=3D OUT16, "const16", "got 0x%llx !=3D exp 0x%llx\n=
",
+	      (__u64)bss->const16, (__u64)OUT16);
+	CHECK(bss->const32 !=3D OUT32, "const32", "got 0x%llx !=3D exp 0x%llx\n=
",
+	      (__u64)bss->const32, (__u64)OUT32);
+	CHECK(bss->const64 !=3D OUT64, "const64", "got 0x%llx !=3D exp 0x%llx\n=
",
+	      (__u64)bss->const64, (__u64)OUT64);
+cleanup:
+	test_endian__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_endian.c b/tools/test=
ing/selftests/bpf/progs/test_endian.c
new file mode 100644
index 000000000000..1d37d93102a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_endian.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define IN16 0x1234
+#define IN32 0x12345678U
+#define IN64 0x123456789abcdef0ULL
+
+__u16 in16;
+__u32 in32;
+__u64 in64;
+
+__u16 out16;
+__u32 out32;
+__u64 out64;
+
+__u16 const16;
+__u32 const32;
+__u64 const64;
+
+SEC("raw_tp/sys_enter")
+int sys_enter(const void *ctx)
+{
+	out16 =3D __builtin_bswap16(in16);
+	out32 =3D __builtin_bswap32(in32);
+	out64 =3D __builtin_bswap64(in64);
+	const16 =3D ___bpf_swab16(IN16);
+	const32 =3D ___bpf_swab32(IN32);
+	const64 =3D ___bpf_swab64(IN64);
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.24.1

