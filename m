Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B0C43334
	for <bpf@archiver.kernel.org>; Fri, 22 Jul 2022 17:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiGVRTE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jul 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiGVRTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:19:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9A76555B
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:19:00 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGMQ6wWDz67KmH;
        Sat, 23 Jul 2022 01:17:06 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:18:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 01/15] bpftool: Attempt to link static libraries
Date:   Fri, 22 Jul 2022 19:18:22 +0200
Message-ID: <20220722171836.2852247-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722171836.2852247-1-roberto.sassu@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce the BPFTOOL_STATIC make variable, to let users build bpftool with
static libraries (when set to 1). This increases the portability of the
binary, especially for testing.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/bpf/bpftool/Makefile | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4b09a5c3b9f1..4628df456245 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -98,6 +98,13 @@ FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z \
 FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z \
 		  disassembler-four-args libcap clang-bpf-co-re
 
+ifeq ($(BPFTOOL_STATIC),1)
+FEATURE_CHECK_LDFLAGS-libbfd = -static
+FEATURE_CHECK_LDFLAGS-libbfd-liberty = -static
+FEATURE_CHECK_LDFLAGS-libbfd-liberty-z = -static
+FEATURE_CHECK_LDFLAGS-libcap = -static
+endif
+
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
 ifdef MAKECMDGOALS
@@ -122,8 +129,12 @@ LIBS = $(LIBBPF) -lelf -lz
 LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
 ifeq ($(feature-libcap), 1)
 CFLAGS += -DUSE_LIBCAP
+ifeq ($(BPFTOOL_STATIC),1)
+LIBS += -l:libcap.a
+else
 LIBS += -lcap
 endif
+endif
 
 include $(wildcard $(OUTPUT)*.d)
 
@@ -133,6 +144,16 @@ BFD_SRCS = jit_disasm.c
 
 SRCS = $(filter-out $(BFD_SRCS),$(wildcard *.c))
 
+ifeq ($(BPFTOOL_STATIC),1)
+ifeq ($(feature-libbfd),1)
+  LIBS += -l:libbfd.a -ldl -l:libopcodes.a
+else ifeq ($(feature-libbfd-liberty),1)
+  LIBS += -l:libbfd.a -ldl -l:libopcodes.a -l:libiberty.a
+else ifeq ($(feature-libbfd-liberty-z),1)
+  LIBS += -l:libbfd.a -ldl -l:libopcodes.a -l:libiberty.a -l:libz.a
+  LIBS := $(filter-out -lz, $(LIBS))
+endif
+else
 ifeq ($(feature-libbfd),1)
   LIBS += -lbfd -ldl -lopcodes
 else ifeq ($(feature-libbfd-liberty),1)
@@ -140,6 +161,7 @@ else ifeq ($(feature-libbfd-liberty),1)
 else ifeq ($(feature-libbfd-liberty-z),1)
   LIBS += -lbfd -ldl -lopcodes -liberty -lz
 endif
+endif
 
 ifneq ($(filter -lbfd,$(LIBS)),)
 CFLAGS += -DHAVE_LIBBFD_SUPPORT
-- 
2.25.1

