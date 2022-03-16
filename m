Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25676C433F5
	for <bpf@archiver.kernel.org>; Wed, 16 Mar 2022 01:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353007AbiCPBuG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Mar 2022 21:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347548AbiCPBuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 21:50:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1D55777
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:48:52 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FNkfrn008445
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:48:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=oWGowfhR43DgSIbGEp+xPgfNisThXgwvlaSGCBum1BU=;
 b=e8WPYOtQxp0S6CFdHIeGh4l9gpFfn4g6F0/4EmFhkXwC/6JjjjjxrfJ1bf+vqhDMAsxB
 s/inAVHsJPouQKiARzuAzb3N4TWpsqK8ODZiCybVJ4Kzw5vioQtFyZCz1I2LLpiiDLCI
 vUiqYOzpW6jwbiyulkpwJvfClNCNJJlX4y4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3etac8bgc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 18:48:52 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 18:48:50 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 0CB802103FA0; Tue, 15 Mar 2022 18:48:47 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: selftests: Add helpers to directly use the capget and capset syscall
Date:   Tue, 15 Mar 2022 18:48:47 -0700
Message-ID: <20220316014847.2256135-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316014841.2255248-1-kafai@fb.com>
References: <20220316014841.2255248-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TXSo7Bq9rHvYjsqYl6c5w9Vu78c646kt
X-Proofpoint-ORIG-GUID: TXSo7Bq9rHvYjsqYl6c5w9Vu78c646kt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After upgrading to the newer libcap (>=3D 2.60),
the libcap commit aca076443591 ("Make cap_t operations thread safe.")
added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
shift that breaks the assumption made in the "struct libcap" definition
in test_verifier.c.

The bpf selftest usage only needs to enable and disable the effective
caps of the running task.  It is easier to directly syscall the
capget and capset instead.  It can also remove the libcap
library dependency.

The cap_helpers.{c,h} is added.  One __u64 is used for all CAP_*
bits instead of two __u32.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/cap_helpers.c | 68 +++++++++++++++++++++++
 tools/testing/selftests/bpf/cap_helpers.h | 10 ++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cap_helpers.c
 create mode 100644 tools/testing/selftests/bpf/cap_helpers.h

diff --git a/tools/testing/selftests/bpf/cap_helpers.c b/tools/testing/se=
lftests/bpf/cap_helpers.c
new file mode 100644
index 000000000000..e83eab902657
--- /dev/null
+++ b/tools/testing/selftests/bpf/cap_helpers.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/capability.h>
+#include "cap_helpers.h"
+
+/* Avoid including <sys/capability.h> from the libcap-devel package,
+ * so directly declare them here and use them from glibc.
+ */
+int capget(cap_user_header_t header, cap_user_data_t data);
+int capset(cap_user_header_t header, const cap_user_data_t data);
+
+int cap_enable_effective(__u64 caps, __u64 *old_caps)
+{
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
+	struct __user_cap_header_struct hdr =3D {
+		.version =3D _LINUX_CAPABILITY_VERSION_3,
+	};
+	__u32 cap0 =3D caps;
+	__u32 cap1 =3D caps >> 32;
+	int err;
+
+	err =3D capget(&hdr, data);
+	if (err)
+		return err;
+
+	if (old_caps)
+		*old_caps =3D (__u64)(data[1].effective) << 32 | data[0].effective;
+
+	if ((data[0].effective & cap0) =3D=3D cap0 &&
+	    (data[1].effective & cap1) =3D=3D cap1)
+		return 0;
+
+	data[0].effective |=3D cap0;
+	data[1].effective |=3D cap1;
+	err =3D capset(&hdr, data);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int cap_disable_effective(__u64 caps, __u64 *old_caps)
+{
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
+	struct __user_cap_header_struct hdr =3D {
+		.version =3D _LINUX_CAPABILITY_VERSION_3,
+	};
+	__u32 cap0 =3D caps;
+	__u32 cap1 =3D caps >> 32;
+	int err;
+
+	err =3D capget(&hdr, data);
+	if (err)
+		return err;
+
+	if (old_caps)
+		*old_caps =3D (__u64)(data[1].effective) << 32 | data[0].effective;
+
+	if (!(data[0].effective & cap0) && !(data[1].effective & cap1))
+		return 0;
+
+	data[0].effective &=3D ~cap0;
+	data[1].effective &=3D ~cap1;
+	err =3D capset(&hdr, data);
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/cap_helpers.h b/tools/testing/se=
lftests/bpf/cap_helpers.h
new file mode 100644
index 000000000000..0bf29ecd338c
--- /dev/null
+++ b/tools/testing/selftests/bpf/cap_helpers.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CAP_HELPERS_H
+#define __CAP_HELPERS_H
+
+#include <linux/types.h>
+
+int cap_enable_effective(__u64 caps, __u64 *old_caps);
+int cap_disable_effective(__u64 caps, __u64 *old_caps);
+
+#endif
--=20
2.30.2

