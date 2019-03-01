Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF95DC4360F
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2727218D8
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Crp0vzIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfCABhW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:37:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44906 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728521AbfCABhV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 20:37:21 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x211Yonp032318
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=BNQoqFnRGfB9qbV4MQVsT7mzeG8PLHicMg2BMAbrRkc=;
 b=Crp0vzIhXy4TCPdPybzci5hYBtvir9uW7fBaPm2R3gGE9Cuu/SnWXv7+4r96NJBJO1Tt
 UUxqAD3Kj4tGaCVcVntvSN/agv8buMW451s+SPDsqeo6klxLPTusk2GhT8wmk0AoQEw8
 X+Peq0Xa8oG6UMmZXhWb7d3LGHI+212Yp5M= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxqw2gmcy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:20 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 17:37:19 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 3CCB4C16CA39; Thu, 28 Feb 2019 17:37:19 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 4/4] bpf/verifier: fix minor typos in comments
Date:   Thu, 28 Feb 2019 17:37:16 -0800
Message-ID: <20190301013716.1370014-5-andriin@fb.com>
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

Few more minor fixes in comments.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c6911ede94af..0ee788bfd462 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -258,7 +258,7 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		log->ubuf = NULL;
 }
 
-/* log_level controls verbosity level of eBPF verifier.
+/* env->log.level controls verbosity level of eBPF verifier.
  * bpf_verifier_log_write() is used to dump the verification trace to the log,
  * so the user can figure out what's wrong with the program
  */
@@ -617,7 +617,7 @@ static int realloc_func_state(struct bpf_func_state *state, int stack_size,
 
 /* Acquire a pointer id from the env and update the state->refs to include
  * this new pointer reference.
- * On success, returns a valid pointer id to associate with the register
+ * On success, returns a valid pointer id to associate with the register.
  * On failure, returns a negative errno.
  */
 static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
@@ -714,7 +714,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
 
-	/* if dst has more stack frames then src frame, free them */
+	/* if dst has more stack frames than src frame, free them */
 	for (i = src->curframe + 1; i <= dst_state->curframe; i++) {
 		free_func_state(dst_state->frame[i]);
 		dst_state->frame[i] = NULL;
@@ -863,8 +863,7 @@ static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
 				    enum bpf_reg_type which)
 {
 	/* The register can already have a range from prior markings.
-	 * This is fine as long as it hasn't been advanced from its
-	 * origin.
+	 * This is fine as long as it hasn't been advanced from its origin.
 	 */
 	return reg->type == which &&
 	       reg->id == 0 &&
-- 
2.17.1

