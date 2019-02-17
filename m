Return-Path: <SRS0=ogH5=QY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B80C43381
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 08:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE05921A4A
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 08:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lx/DeEcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBQIU1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:20:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbfBQIU1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Feb 2019 03:20:27 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1H8Jis5018999
        for <bpf@vger.kernel.org>; Sun, 17 Feb 2019 00:20:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+ezkC4wM+BkI8pl9mlJoTFbOCbesQ1ti8Boa9jf2BxY=;
 b=lx/DeEcHDfOkbsZsRix39Bl6Y/Phhoz53/rL7uzm+Eaa0OYvDR4A3g/ufnUtTWMQOwHR
 PQ5B4skTj+TVxsiCWMq88k7dvLApsDDFZ+nOz3uL3N8yI/XDZD1AdvXh8YlBzVcpE+p7
 BzyG1W7XYUk2ACMopUY83Eh+m2Eg254ypfg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qq16hg8f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 17 Feb 2019 00:20:26 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Sun, 17 Feb 2019 00:20:25 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 43246B10C286; Sun, 17 Feb 2019 00:20:25 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <acme@kernel.org>, <ast@fb.com>, <dwarves@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 1/2] libbpf: pull latest libbpf and build libbpf as shared lib
Date:   Sun, 17 Feb 2019 00:20:17 -0800
Message-ID: <20190217082018.1008069-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190217082018.1008069-1-andriin@fb.com>
References: <20190217082018.1008069-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-17_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bring in latest changes from libbpf which allow to use btf__dedup() for
big binaries (e.g., linux kernel image).

This patch also changes CMakeLists.txt to build libbpf as shared
library to satisfy libdwarves shared library compilation.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 CMakeLists.txt | 13 +++++++++----
 lib/bpf        |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 0cc383a..d6929b4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -72,9 +72,14 @@ if (NOT HAVE_REALLOCARRAY_SUPPORT)
 endif()
 
 file(GLOB libbpf_sources "lib/bpf/src/*.c")
-add_library(bpf STATIC ${libbpf_sources})
-set_target_properties(bpf PROPERTIES OUTPUT_NAME bpf)
-target_include_directories(bpf PRIVATE
+add_library(bpf-static STATIC ${libbpf_sources})
+set_target_properties(bpf-static PROPERTIES OUTPUT_NAME bpf)
+target_include_directories(bpf-static PRIVATE
+			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
+			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+add_library(bpf-shared SHARED ${libbpf_sources})
+set_target_properties(bpf-shared PROPERTIES OUTPUT_NAME bpf)
+target_include_directories(bpf-shared PRIVATE
 			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
 			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
 
@@ -84,7 +89,7 @@ set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
 add_library(dwarves SHARED ${dwarves_LIB_SRCS})
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
-target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf)
+target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf-shared)
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
 add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
diff --git a/lib/bpf b/lib/bpf
index b19c6dc..d5fa415 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit b19c6dcf623a7adc9e538ddbe2964c2f58dd2417
+Subproject commit d5fa4150f0c3a36e3ce458e1301531bd2edbf74d
-- 
2.17.1

