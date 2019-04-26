Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A643C4321A
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A6820869
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TcgFFPd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfDZXjx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:39:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53748 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727194AbfDZXjv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 19:39:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3QNYXQT016525
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=BB//rPv3drHd4TNZsH/ERVDG4lK9bpVssnH3aqIfAPw=;
 b=TcgFFPd1KxIlSBH+0i5lwxSZbc6lzRKzjdxvwJsEHIJLvXsMeNMR9I2bzDDPT+lYPex7
 oXjtzJsLmBcqQWQiG91fIRaOlKGzahrpoHsRKHxnEuDcP2nUbHwrQw5P7NiAy2J9HEA2
 oK2DHWaTfNIEg43WV2uLcz8qeOLhIwRliBo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2s44jgsf1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:50 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 26 Apr 2019 16:39:48 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id AECCE29425A9; Fri, 26 Apr 2019 16:39:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 4/7] bpf: Refactor BTF encoding macro to test_btf.h
Date:   Fri, 26 Apr 2019 16:39:46 -0700
Message-ID: <20190426233946.1330696-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426233938.1330361-1-kafai@fb.com>
References: <20190426233938.1330361-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor common BTF encoding macros for other tests to use.
The libbpf may reuse some of them in the future  which requires
some more thoughts before publishing as a libbpf API.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/test_btf.c | 63 +----------------------
 tools/testing/selftests/bpf/test_btf.h | 69 ++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_btf.h

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index f8eb7987b794..42c1ce988945 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -24,6 +24,7 @@
 
 #include "bpf_rlimit.h"
 #include "bpf_util.h"
+#include "test_btf.h"
 
 #define MAX_INSNS	512
 #define MAX_SUBPROGS	16
@@ -58,68 +59,6 @@ static int __base_pr(enum libbpf_print_level level __attribute__((unused)),
 	return vfprintf(stderr, format, args);
 }
 
-#define BTF_INFO_ENC(kind, kind_flag, vlen)			\
-	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
-
-#define BTF_TYPE_ENC(name, info, size_or_type)	\
-	(name), (info), (size_or_type)
-
-#define BTF_INT_ENC(encoding, bits_offset, nr_bits)	\
-	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
-#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz)	\
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz),	\
-	BTF_INT_ENC(encoding, bits_offset, bits)
-
-#define BTF_FWD_ENC(name, kind_flag) \
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FWD, kind_flag, 0), 0)
-
-#define BTF_ARRAY_ENC(type, index_type, nr_elems)	\
-	(type), (index_type), (nr_elems)
-#define BTF_TYPE_ARRAY_ENC(type, index_type, nr_elems) \
-	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ARRAY, 0, 0), 0), \
-	BTF_ARRAY_ENC(type, index_type, nr_elems)
-
-#define BTF_STRUCT_ENC(name, nr_elems, sz)	\
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, nr_elems), sz)
-
-#define BTF_UNION_ENC(name, nr_elems, sz)	\
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_UNION, 0, nr_elems), sz)
-
-#define BTF_VAR_ENC(name, type, linkage)	\
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), type), (linkage)
-#define BTF_VAR_SECINFO_ENC(type, offset, size)	\
-	(type), (offset), (size)
-
-#define BTF_MEMBER_ENC(name, type, bits_offset)	\
-	(name), (type), (bits_offset)
-#define BTF_ENUM_ENC(name, val) (name), (val)
-#define BTF_MEMBER_OFFSET(bitfield_size, bits_offset) \
-	((bitfield_size) << 24 | (bits_offset))
-
-#define BTF_TYPEDEF_ENC(name, type) \
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0), type)
-
-#define BTF_PTR_ENC(type) \
-	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), type)
-
-#define BTF_CONST_ENC(type) \
-	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_CONST, 0, 0), type)
-
-#define BTF_VOLATILE_ENC(type) \
-	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_VOLATILE, 0, 0), type)
-
-#define BTF_RESTRICT_ENC(type) \
-	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_RESTRICT, 0, 0), type)
-
-#define BTF_FUNC_PROTO_ENC(ret_type, nargs) \
-	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, nargs), ret_type)
-
-#define BTF_FUNC_PROTO_ARG_ENC(name, type) \
-	(name), (type)
-
-#define BTF_FUNC_ENC(name, func_proto) \
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), func_proto)
-
 #define BTF_END_RAW 0xdeadbeef
 #define NAME_TBD 0xdeadb33f
 
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
new file mode 100644
index 000000000000..2023725f1962
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 Facebook */
+
+#ifndef _TEST_BTF_H
+#define _TEST_BTF_H
+
+#define BTF_INFO_ENC(kind, kind_flag, vlen)			\
+	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
+
+#define BTF_TYPE_ENC(name, info, size_or_type)	\
+	(name), (info), (size_or_type)
+
+#define BTF_INT_ENC(encoding, bits_offset, nr_bits)	\
+	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
+#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz)	\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz),	\
+	BTF_INT_ENC(encoding, bits_offset, bits)
+
+#define BTF_FWD_ENC(name, kind_flag) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FWD, kind_flag, 0), 0)
+
+#define BTF_ARRAY_ENC(type, index_type, nr_elems)	\
+	(type), (index_type), (nr_elems)
+#define BTF_TYPE_ARRAY_ENC(type, index_type, nr_elems) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ARRAY, 0, 0), 0), \
+	BTF_ARRAY_ENC(type, index_type, nr_elems)
+
+#define BTF_STRUCT_ENC(name, nr_elems, sz)	\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, nr_elems), sz)
+
+#define BTF_UNION_ENC(name, nr_elems, sz)	\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_UNION, 0, nr_elems), sz)
+
+#define BTF_VAR_ENC(name, type, linkage)	\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), type), (linkage)
+#define BTF_VAR_SECINFO_ENC(type, offset, size)	\
+	(type), (offset), (size)
+
+#define BTF_MEMBER_ENC(name, type, bits_offset)	\
+	(name), (type), (bits_offset)
+#define BTF_ENUM_ENC(name, val) (name), (val)
+#define BTF_MEMBER_OFFSET(bitfield_size, bits_offset) \
+	((bitfield_size) << 24 | (bits_offset))
+
+#define BTF_TYPEDEF_ENC(name, type) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0), type)
+
+#define BTF_PTR_ENC(type) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), type)
+
+#define BTF_CONST_ENC(type) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_CONST, 0, 0), type)
+
+#define BTF_VOLATILE_ENC(type) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_VOLATILE, 0, 0), type)
+
+#define BTF_RESTRICT_ENC(type) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_RESTRICT, 0, 0), type)
+
+#define BTF_FUNC_PROTO_ENC(ret_type, nargs) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, nargs), ret_type)
+
+#define BTF_FUNC_PROTO_ARG_ENC(name, type) \
+	(name), (type)
+
+#define BTF_FUNC_ENC(name, func_proto) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), func_proto)
+
+#endif /* _TEST_BTF_H */
-- 
2.17.1

