Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78B4C10F00
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EEF218AE
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dx6qQvHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbfCABh0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:37:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387430AbfCABhX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 20:37:23 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x211XUtd020349
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=fDuiMJp0EM52IeS6Q0DaEQzISY+CapjhLoPEmQXOSmw=;
 b=dx6qQvHibSstVHjSDAisnyg+EicfzhTs1JGquwL8otfJQ+X8am1Em4SRGLmCz8qcw4wr
 9ytx9xTwo2qEM7qVDUGJPQS9fJ2p4CLKr174u06v4/VPtNk1lezNghMIG8neeNMNEvCY
 EZqYLVnbxt/trDmXy3cjKwqUk6NCQDDmWaw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxtp7r36w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:22 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 28 Feb 2019 17:37:21 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 34A23C16CA35; Thu, 28 Feb 2019 17:37:19 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/4] bpf/verifier: fix code formatting
Date:   Thu, 28 Feb 2019 17:37:14 -0800
Message-ID: <20190301013716.1370014-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190301013716.1370014-1-andriin@fb.com>
References: <20190301013716.1370014-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few formatting problems.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0e4edd7e3c5f..c09ec3222d13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -389,7 +389,7 @@ static bool is_release_function(enum bpf_func_id func_id)
 static bool is_acquire_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_lookup_tcp ||
-		func_id == BPF_FUNC_sk_lookup_udp;
+	       func_id == BPF_FUNC_sk_lookup_udp;
 }
 
 /* string representation of 'enum bpf_reg_type' */
@@ -559,39 +559,39 @@ COPY_STATE_FN(reference, acquired_refs, refs, 1)
 COPY_STATE_FN(stack, allocated_stack, stack, BPF_REG_SIZE)
 #undef COPY_STATE_FN
 
-#define REALLOC_STATE_FN(NAME, COUNT, FIELD, SIZE)			\
-static int realloc_##NAME##_state(struct bpf_func_state *state, int size, \
-				  bool copy_old)			\
-{									\
-	u32 old_size = state->COUNT;					\
-	struct bpf_##NAME##_state *new_##FIELD;				\
-	int slot = size / SIZE;						\
-									\
-	if (size <= old_size || !size) {				\
-		if (copy_old)						\
-			return 0;					\
-		state->COUNT = slot * SIZE;				\
-		if (!size && old_size) {				\
-			kfree(state->FIELD);				\
-			state->FIELD = NULL;				\
-		}							\
-		return 0;						\
-	}								\
+#define REALLOC_STATE_FN(NAME, COUNT, FIELD, SIZE)			     \
+static int realloc_##NAME##_state(struct bpf_func_state *state, int size,    \
+				  bool copy_old)			     \
+{									     \
+	u32 old_size = state->COUNT;					     \
+	struct bpf_##NAME##_state *new_##FIELD;				     \
+	int slot = size / SIZE;						     \
+									     \
+	if (size <= old_size || !size) {				     \
+		if (copy_old)						     \
+			return 0;					     \
+		state->COUNT = slot * SIZE;				     \
+		if (!size && old_size) {				     \
+			kfree(state->FIELD);				     \
+			state->FIELD = NULL;				     \
+		}							     \
+		return 0;						     \
+	}								     \
 	new_##FIELD = kmalloc_array(slot, sizeof(struct bpf_##NAME##_state), \
-				    GFP_KERNEL);			\
-	if (!new_##FIELD)						\
-		return -ENOMEM;						\
-	if (copy_old) {							\
-		if (state->FIELD)					\
-			memcpy(new_##FIELD, state->FIELD,		\
-			       sizeof(*new_##FIELD) * (old_size / SIZE)); \
-		memset(new_##FIELD + old_size / SIZE, 0,		\
-		       sizeof(*new_##FIELD) * (size - old_size) / SIZE); \
-	}								\
-	state->COUNT = slot * SIZE;					\
-	kfree(state->FIELD);						\
-	state->FIELD = new_##FIELD;					\
-	return 0;							\
+				    GFP_KERNEL);			     \
+	if (!new_##FIELD)						     \
+		return -ENOMEM;						     \
+	if (copy_old) {							     \
+		if (state->FIELD)					     \
+			memcpy(new_##FIELD, state->FIELD,		     \
+			       sizeof(*new_##FIELD) * (old_size / SIZE));    \
+		memset(new_##FIELD + old_size / SIZE, 0,		     \
+		       sizeof(*new_##FIELD) * (size - old_size) / SIZE);     \
+	}								     \
+	state->COUNT = slot * SIZE;					     \
+	kfree(state->FIELD);						     \
+	state->FIELD = new_##FIELD;					     \
+	return 0;							     \
 }
 /* realloc_reference_state() */
 REALLOC_STATE_FN(reference, acquired_refs, refs, 1)
-- 
2.17.1

