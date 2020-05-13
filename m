Return-Path: <SRS0=dL5Z=63=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FABC433E0
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F997205CB
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l8pHy1wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389963AbgEMSCY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 May 2020 14:02:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11730 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733070AbgEMSCX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 14:02:23 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DHx4Ns001688
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 11:02:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PvfIhdWfOZOrtP16E1ASSKrtM4pY3Vhw9fXC3Qn8mEM=;
 b=l8pHy1whRYwT7AVdKNQVRWyDeTUqaSoWIFdtaAr1Q8aKx9OE8g6ujA3cMLJeESJMTiPP
 BDzXkQJ1X7TExiN7s9QvtqIT6BhdNmZ4cihpPUZlZjsutJHm+c75ts4Zze1ldpu8zwXK
 SSB4pFvTYt7ff0L8DkqN9lWU1px/hWmWeSw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x26cwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 11:02:21 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 11:02:20 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B133B3700A26; Wed, 13 May 2020 11:02:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 1/7] tools/bpf: selftests : explain bpf_iter test failures with llvm 10.0.0
Date:   Wed, 13 May 2020 11:02:15 -0700
Message-ID: <20200513180215.2949237-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200513180215.2949164-1-yhs@fb.com>
References: <20200513180215.2949164-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_08:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 cotscore=-2147483648
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130153
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 6879c042e105 ("tools/bpf: selftests: Add bpf_iter selftests")
added self tests for bpf_iter feature. But two subtests
ipv6_route and netlink needs llvm latest 10.x release branch
or trunk due to a bug in llvm BPF backend. This patch added
the file README.rst to document these two failures
so people using llvm 10.0.0 can be aware of them.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/README.rst

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selft=
ests/bpf/README.rst
new file mode 100644
index 000000000000..0f67f1b470b0
--- /dev/null
+++ b/tools/testing/selftests/bpf/README.rst
@@ -0,0 +1,43 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+BPF Selftest Notes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Additional information about selftest failures are
+documented here.
+
+bpf_iter test failures with clang/llvm 10.0.0
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+With clang/llvm 10.0.0, the following two bpf_iter tests failed:
+  * ``bpf_iter/ipv6_route``
+  * ``bpf_iter/netlink``
+
+The symptom for ``bpf_iter/ipv6_route`` looks like
+
+.. code-block:: c
+
+  2: (79) r8 =3D *(u64 *)(r1 +8)
+  ...
+  14: (bf) r2 =3D r8
+  15: (0f) r2 +=3D r1
+  ; BPF_SEQ_PRINTF(seq, "%pi6 %02x ", &rt->fib6_dst.addr, rt->fib6_dst.p=
len);
+  16: (7b) *(u64 *)(r8 +64) =3D r2
+  only read is supported
+
+The symptom for ``bpf_iter/netlink`` looks like
+
+.. code-block:: c
+
+  ; struct netlink_sock *nlk =3D ctx->sk;
+  2: (79) r7 =3D *(u64 *)(r1 +8)
+  ...
+  15: (bf) r2 =3D r7
+  16: (0f) r2 +=3D r1
+  ; BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
+  17: (7b) *(u64 *)(r7 +0) =3D r2
+  only read is supported
+
+This is due to a llvm BPF backend bug. The fix=20
+  https://reviews.llvm.org/D78466
+has been pushed to llvm 10.x release branch and will be
+available in 10.0.1. The fix is available in llvm 11.0.0 trunk.
--=20
2.24.1

