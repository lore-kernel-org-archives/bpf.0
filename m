Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4090CCA47B
	for <bpf@archiver.kernel.org>; Fri,  3 Jun 2022 02:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiFCCAc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Jun 2022 22:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiFCCAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 22:00:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8FD396A1
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 19:00:30 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2530qf3j004392
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 19:00:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qva6/2xAg9ElVHAksJQo7a/qeFCJ8algssTBFifePkE=;
 b=c61ajKIStVd0qSeeJ44+BZIBNyuzyTQvNnrox+vhMl5GDTAPBlnGpMXY7vJ5Rk9O2UXt
 vLlnqgQcLwZm3NEODfjo+2sfJAtVS0hXOyKD9JflabCwrmsJnFCPlk6uscaM2+GApgM8
 MJI5EwWUKkxTb+TIiCA81vyngfQvgYUzRQ8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3geu05da23-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 19:00:30 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 19:00:27 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 87409B29A00D; Thu,  2 Jun 2022 19:00:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 17/18] selftests/bpf: Clarify llvm dependency with possible selftest failures
Date:   Thu, 2 Jun 2022 19:00:24 -0700
Message-ID: <20220603020024.1195174-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603015855.1187538-1-yhs@fb.com>
References: <20220603015855.1187538-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7GRvFHl82qco0tKPYtmp95y2VyDdESts
X-Proofpoint-ORIG-GUID: 7GRvFHl82qco0tKPYtmp95y2VyDdESts
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Certain subtests in selftests core_reloc and core_reloc_btfgen
requires llvm ENUM64 support in llvm15. If an older compiler
is used, these subtests will fail. Make this requirement clear
in selftests README.rst file.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index eb1b7541f39d..a83d78a58014 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -266,3 +266,21 @@ from running test_progs will look like:
   test_xdpwall:FAIL:Does LLVM have https://reviews.llvm.org/D109073? unexp=
ected error: -4007
=20
 __ https://reviews.llvm.org/D109073
+
+ENUM64 support and Clang version
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+There are a few selftests requiring LLVM ENUM64 support. The LLVM ENUM64 is
+introduced in `Clang 15` [0_]. Without proper compiler support, the follow=
ing selftests
+will fail:
+
+.. code-block:: console
+
+  #45 /73    core_reloc/enum64val:FAIL
+  #45 /74    core_reloc/enum64val___diff:FAIL
+  #45 /75    core_reloc/enum64val___val3_missing:FAIL
+  #46 /73    core_reloc_btfgen/enum64val:FAIL
+  #46 /74    core_reloc_btfgen/enum64val___diff:FAIL
+  #46 /75    core_reloc_btfgen/enum64val___val3_missing:FAIL
+
+.. _0: https://reviews.llvm.org/D124641
--=20
2.30.2

