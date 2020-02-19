Return-Path: <SRS0=4hUP=4H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A62C34031
	for <bpf@archiver.kernel.org>; Wed, 19 Feb 2020 00:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A014D24654
	for <bpf@archiver.kernel.org>; Wed, 19 Feb 2020 00:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rhqZGQn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgBSAmn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:42:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32256 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbgBSAmn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Feb 2020 19:42:43 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01J0PsVo011255
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 16:42:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=isfm9XXKWnu4wosNCV4Z1GE7af5vYK9maPpLca25oA4=;
 b=rhqZGQn7jH/yO4Tg/pWRu2tBmEju8fOFzeJPJtnH2F+/PX4YQJthBtazCedJrjZlgJff
 3WXwLHCsfhImuQUb/NNLgU5jwQ6dTlh5Vp0mxI86r4gbh+N7XqJhQPV/f2I4xZ1+x2z7
 H+I07KCaHUL+4DF3UrMtKOxB3LBVbIBbY40= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8jtdjmen-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 16:42:41 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 18 Feb 2020 16:42:40 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id DE0963703779; Tue, 18 Feb 2020 16:42:36 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] selftests/bpf: change llvm flag -mcpu=probe to -mcpu=v3
Date:   Tue, 18 Feb 2020 16:42:36 -0800
Message-ID: <20200219004236.2291125-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_08:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=13 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The latest llvm supports cpu version v3, which is cpu version v1
plus some additional 64bit jmp insns and 32bit jmp insn support.

In selftests/bpf Makefile, the llvm flag -mcpu=probe did runtime
probe into the host system. Depending on compilation environments,
it is possible that runtime probe may fail, e.g., due to
memlock issue. This will cause generated code with cpu version v1.
This may cause confusion as the same compiler and the same C code
generates different byte codes in different environment.

Let us change the llvm flag -mcpu=probe to -mcpu=v3 so the
generated code will be the same regardless of the compilation
environment.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 257a1aaaa37d..2a583196fa51 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -209,7 +209,7 @@ define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
 	($(CLANG) $3 -O2 -target bpf -emit-llvm				\
 		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -mattr=dwarfris -march=bpf -mcpu=probe $4 -filetype=obj -o $2
+	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
@@ -223,7 +223,7 @@ define CLANG_NATIVE_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
 	($(CLANG) $3 -O2 -emit-llvm					\
 		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -march=bpf -mcpu=probe $4 -filetype=obj -o $2
+	$(LLC) -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
-- 
2.17.1

