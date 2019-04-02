Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC8C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F7020883
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179287;
	bh=njhWFeKbUrEhTDMUsx/3r8U4dzXzXUyvaJwp5Q4zNsU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0BwTd5iIl1qyKdYkMViEB9eNmmr4neJ9ziSi4Fx6fmmSGaqZgGL/XLkkMryuacxnf
	 olnZe1qZYWJO/asesjQYUNYte3AX4XV9KF3u73I7WXSbdUm2HlyPd6uOzHR/OEcKiz
	 QIqXi3aVPJFvpeplh+K7PBR+T1L8IhR3o5F+8/E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfDBE2F convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:28:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728859AbfDBE2B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:28:01 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x324RoUs031546
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:28:00 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rkysbr4jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:28:00 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:27:59 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id C306E760E11; Mon,  1 Apr 2019 21:27:59 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 05/10] bpf: verbose jump offset overflow check
Date:   Mon, 1 Apr 2019 21:27:44 -0700
Message-ID: <20190402042749.3670015-6-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190402042749.3670015-1-ast@kernel.org>
References: <20190402042749.3670015-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Larger programs may trigger 16-bit jump offset overflow check
during instruction patching. Make this error verbose otherwise
users cannot decipher error code without printks in the verifier.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c     | 11 ++++++-----
 kernel/bpf/verifier.c |  7 ++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ff09d32a8a1b..2966cb368bf4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -438,6 +438,7 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	u32 insn_adj_cnt, insn_rest, insn_delta = len - 1;
 	const u32 cnt_max = S16_MAX;
 	struct bpf_prog *prog_adj;
+	int err;
 
 	/* Since our patchlet doesn't expand the image, we're done. */
 	if (insn_delta == 0) {
@@ -453,8 +454,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	 * we afterwards may not fail anymore.
 	 */
 	if (insn_adj_cnt > cnt_max &&
-	    bpf_adj_branches(prog, off, off + 1, off + len, true))
-		return NULL;
+	    (err = bpf_adj_branches(prog, off, off + 1, off + len, true)))
+		return ERR_PTR(err);
 
 	/* Several new instructions need to be inserted. Make room
 	 * for them. Likely, there's no need for a new allocation as
@@ -463,7 +464,7 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 	prog_adj = bpf_prog_realloc(prog, bpf_prog_size(insn_adj_cnt),
 				    GFP_USER);
 	if (!prog_adj)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	prog_adj->len = insn_adj_cnt;
 
@@ -1096,13 +1097,13 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
 			continue;
 
 		tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
-		if (!tmp) {
+		if (IS_ERR(tmp)) {
 			/* Patching may have repointed aux->prog during
 			 * realloc from the original one, so we need to
 			 * fix it up here on error.
 			 */
 			bpf_jit_prog_release_other(prog, clone);
-			return ERR_PTR(-ENOMEM);
+			return tmp;
 		}
 
 		clone = tmp;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad3494a881da..6dcfeb44bb8e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6932,8 +6932,13 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	struct bpf_prog *new_prog;
 
 	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
-	if (!new_prog)
+	if (IS_ERR(new_prog)) {
+		if (PTR_ERR(new_prog) == -ERANGE)
+			verbose(env,
+				"insn %d cannot be patched due to 16-bit range\n",
+				env->insn_aux_data[off].orig_idx);
 		return NULL;
+	}
 	if (adjust_insn_aux_data(env, new_prog->len, off, len))
 		return NULL;
 	adjust_subprog_starts(env, off, len);
-- 
2.20.0

