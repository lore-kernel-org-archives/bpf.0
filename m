Return-Path: <SRS0=zD4z=YI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62A2ECE59E
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B08021928
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 22:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Cuvy2F3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbfJOWEY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:04:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2294 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733240AbfJOWEY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Oct 2019 18:04:24 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9FM490B024845
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 15:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ByfYLCb6h9/BEOoxMnnUD6GqZG1xo51d7GnHSDVBwuU=;
 b=Cuvy2F3mu7vUiomPADo7/337sNKsb9+8KHWVej1cbmPpXv9/706uL+nh8Gd01pTBRnrC
 85ThR2DiLjIbKgUkEabdfm/vGkoW8j5M1WuOsYHOZA/PYPmwexYRXErOOtPvKV+KUpyo
 kqcB3lSlg8sf8xW9VVinKEwQWoOZCN601js= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vmtajfgsh-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 15:04:22 -0700
Received: from 2401:db00:30:6007:face:0:1:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Oct 2019 15:04:08 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 93934861987; Tue, 15 Oct 2019 15:04:06 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 6/6] selftests/bpf: move test_queue_stack_map.h into progs/ where it belongs
Date:   Tue, 15 Oct 2019 15:03:52 -0700
Message-ID: <20191015220352.435884-7-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015220352.435884-1-andriin@fb.com>
References: <20191015220352.435884-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_08:2019-10-15,2019-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 mlxlogscore=898 suspectscore=8 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910150189
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_queue_stack_map.h is used only from BPF programs. Thus it should be
part of progs/ subdir. An added benefit of moving it there is that new
TEST_RUNNER_DEFINE_RULES macro-rule will properly capture dependency on
this header for all BPF objects and trigger re-build, if it changes.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/Makefile                           | 3 ---
 tools/testing/selftests/bpf/{ => progs}/test_queue_stack_map.h | 0
 2 files changed, 3 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/test_queue_stack_map.h (100%)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1c321caf2d64..fa6a40d679d9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -154,9 +154,6 @@ CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
 
-$(OUTPUT)/test_queue_map.o: test_queue_stack_map.h
-$(OUTPUT)/test_stack_map.o: test_queue_stack_map.h
-
 $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
 
 # Build BPF object using Clang
diff --git a/tools/testing/selftests/bpf/test_queue_stack_map.h b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
similarity index 100%
rename from tools/testing/selftests/bpf/test_queue_stack_map.h
rename to tools/testing/selftests/bpf/progs/test_queue_stack_map.h
-- 
2.17.1

