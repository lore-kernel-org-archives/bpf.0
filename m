Return-Path: <SRS0=c2E3=Q2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD1BC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 03:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D6C21848
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gsUUoLzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbfBSDCP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:02:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34642 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfBSDCO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Feb 2019 22:02:14 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1J2qbpM026446
        for <bpf@vger.kernel.org>; Mon, 18 Feb 2019 19:02:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Bh0e7N4woPjtNpUv1IrtiJ3b3TMX9tL6f3QRxKBlJeE=;
 b=gsUUoLzLaiwg5+MiczovCF1tgygb4q6ds8v2IkDSASLg6jmTMgo8/Banyfuq02yGilr/
 Ub7C/VibXEZz2DHAGH9PIKfpcmtUNW7iqYe1V+i1d79lB06udgInI2ou5IC1nP+TxWiA
 H+A+hSOJJ05YtHjNJi6V9kEMjWWpiFHXj7w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qr7t8078r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Feb 2019 19:02:13 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 18 Feb 2019 19:02:11 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 53A60B227727; Mon, 18 Feb 2019 19:02:10 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <acme@kernel.org>, <ast@fb.com>, <dwarves@vger.kernel.org>,
        <bpf@vger.kernel.org>, <yst@fb.com>, <arnaldo.melo@gmail.com>,
        <Kernel-team@fb.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <wangnan0@huawei.com>, <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole] libbpf: build as PIC and statically link into libdwarves
Date:   Mon, 18 Feb 2019 19:02:08 -0800
Message-ID: <20190219030208.3903269-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As libbpf is not yet widely available, it's safer to statically link it
into libdwarves for now. Easiest way to define that in cmake is through
OBJECT library with PIC.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 CMakeLists.txt | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index d6929b4..e0fdaf7 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,5 +1,5 @@
 project(pahole C)
-cmake_minimum_required(VERSION 2.4.8)
+cmake_minimum_required(VERSION 2.8.8)
 cmake_policy(SET CMP0005 NEW)
 
 INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
@@ -72,24 +72,19 @@ if (NOT HAVE_REALLOCARRAY_SUPPORT)
 endif()
 
 file(GLOB libbpf_sources "lib/bpf/src/*.c")
-add_library(bpf-static STATIC ${libbpf_sources})
-set_target_properties(bpf-static PROPERTIES OUTPUT_NAME bpf)
-target_include_directories(bpf-static PRIVATE
-			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
-			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
-add_library(bpf-shared SHARED ${libbpf_sources})
-set_target_properties(bpf-shared PROPERTIES OUTPUT_NAME bpf)
-target_include_directories(bpf-shared PRIVATE
+add_library(bpf OBJECT ${libbpf_sources})
+set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
+target_include_directories(bpf PRIVATE
 			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
 			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
 
 set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
 		     ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
 		     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
-add_library(dwarves SHARED ${dwarves_LIB_SRCS})
+add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
-target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf-shared)
+target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
 add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
-- 
2.17.1

