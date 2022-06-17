Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A139AC433EF
	for <bpf@archiver.kernel.org>; Fri, 17 Jun 2022 04:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiFQEzl convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 17 Jun 2022 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiFQEzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 00:55:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E464D13
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 21:55:40 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25GMYm46000816
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 21:55:39 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gpw7rqdpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 21:55:39 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 16 Jun 2022 21:55:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 247B51B50524D; Thu, 16 Jun 2022 21:55:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: don't force lld on non-x86 architectures
Date:   Thu, 16 Jun 2022 21:55:12 -0700
Message-ID: <20220617045512.1339795-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wa9NWvndy2IO3otHBPvToK1kPjExv-SB
X-Proofpoint-ORIG-GUID: wa9NWvndy2IO3otHBPvToK1kPjExv-SB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_03,2022-06-16_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM's lld linker doesn't have a universal architecture support (e.g.,
it definitely doesn't work on s390x), so be safe and force lld for
urandom_read and liburandom_read.so only on x86 architectures.

This should fix s390x CI runs.

Fixes: 3e6fe5ce4d48 ("libbpf: Fix internal USDT address translation logic for shared libraries")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8b30bb743e24..cb8e552e1418 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -168,18 +168,25 @@ $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
+# LLVM's ld.lld doesn't support all the architectures, so use it only on x86
+ifeq ($(SRCARCH),x86)
+LLD := lld
+else
+LLD := ld
+endif
+
 # Filter out -static for liburandom_read.so and its dependent targets so that static builds
 # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
 	$(call msg,LIB,,$@)
 	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)   \
-		     -fuse-ld=lld -Wl,-znoseparate-code -fPIC -shared -o $@
+		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -fPIC -shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
 	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     liburandom_read.so $(LDLIBS)			       \
-		     -fuse-ld=lld -Wl,-znoseparate-code	       		       \
+		     -fuse-ld=$(LLD) -Wl,-znoseparate-code		       \
 		     -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
-- 
2.30.2

