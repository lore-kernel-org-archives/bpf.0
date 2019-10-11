Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CAC47404
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 22:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529AC21A4A
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 22:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="d9cte7sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfJKWTG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:19:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57182 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729124AbfJKWTG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Oct 2019 18:19:06 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BMGQfk006881
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 15:19:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=VoDEj23fzofbPx+FUBCrFd5Bx8lK3uAoE0lXwiLOJoo=;
 b=d9cte7sMDdWxeBURlZXRiQanJQ7h7Q9cD4nCw+H+545biw+H4UtTtN0PRwMgDDKZ/cUV
 KyhrfuDP4hubus3tS4p9cFfve+QgmTNKj37egpKHl+nsIhWczYkkfSb/pQtZDpB1xr9A
 3zgHcATp3CQfkmoJaGqL44m/TSk2Rl/U0lo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vjqxgb3nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 15:19:05 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 11 Oct 2019 15:19:04 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id E318B861869; Fri, 11 Oct 2019 15:01:49 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 1/2] selftests/bpf: enforce libbpf build before BPF programs are built
Date:   Fri, 11 Oct 2019 15:01:45 -0700
Message-ID: <20191011220146.3798961-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011220146.3798961-1-andriin@fb.com>
References: <20191011220146.3798961-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_11:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 mlxlogscore=541 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=8
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910110179
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Given BPF programs rely on libbpf's bpf_helper_defs.h, which is
auto-generated during libbpf build, libbpf build has to happen before
we attempt progs/*.c build. Enforce it as order-only dependency.

Fixes: 24f25763d6de ("libbpf: auto-generate list of BPF helper definitions")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 40552fb441e5..f958643d36da 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -256,7 +256,8 @@ ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
 endif
 
-$(OUTPUT)/%.o: progs/%.c
+# libbpf has to be built before BPF programs due to bpf_helper_defs.h
+$(OUTPUT)/%.o: progs/%.c | $(BPFOBJ)
 	($(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) -O2 -target bpf -emit-llvm \
 		-c $< -o - || echo "clang failed") | \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
-- 
2.17.1

