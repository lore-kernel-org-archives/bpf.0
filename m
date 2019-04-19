Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F1AC282DA
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421F620643
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555700498;
	bh=nBA5UZFeRwbpTvnIZCuBcUVChD6lSdCvlgjEu1ufQTY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HrornDkj5/e7I+6iNUHE23aLqNa4Vh9KvdSHfaIP5xBsn17ek46tO0Khni5yIT4IH
	 cs/TIlZ42z0UKtjkBPBikX4212f1jJ0s3RNrvSqxU6BXqGRdF9piQQND1kBNkzu2kl
	 ZyumtoXGk3835qvt90qBsdNAzZ9DbXzU/keIK5Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfDSTBd convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 19 Apr 2019 15:01:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727445AbfDSTBc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Apr 2019 15:01:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JEj86X023535
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 07:45:33 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rxyd0tv1c-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 07:45:33 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 19 Apr 2019 07:44:58 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 7F0AF7605DE; Fri, 19 Apr 2019 07:44:57 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/2] bpf: remove global variables
Date:   Fri, 19 Apr 2019 07:44:54 -0700
Message-ID: <20190419144455.853134-2-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190419144455.853134-1-ast@kernel.org>
References: <20190419144455.853134-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move three global variables protected by bpf_verifier_lock into
'struct bpf_verifier_env' to allow parallel verification.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/verifier.c        | 25 +++++++++++++------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b3ab61fe1932..1305ccbd8fe6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -295,6 +295,11 @@ struct bpf_verifier_env {
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
+	struct {
+		int *insn_state;
+		int *insn_stack;
+		int cur_stack;
+	} cfg;
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
 	u32 insn_processed;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db301e9b5295..5f0eb5bd5589 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5369,10 +5369,6 @@ enum {
 
 #define STATE_LIST_MARK ((struct bpf_verifier_state_list *) -1L)
 
-static int *insn_stack;	/* stack of insns to process */
-static int cur_stack;	/* current stack index */
-static int *insn_state;
-
 /* t, w, e - match pseudo-code above:
  * t - index of current instruction
  * w - next instruction
@@ -5380,6 +5376,9 @@ static int *insn_state;
  */
 static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 {
+	int *insn_stack = env->cfg.insn_stack;
+	int *insn_state = env->cfg.insn_state;
+
 	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
 		return 0;
 
@@ -5400,9 +5399,9 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		/* tree-edge */
 		insn_state[t] = DISCOVERED | e;
 		insn_state[w] = DISCOVERED;
-		if (cur_stack >= env->prog->len)
+		if (env->cfg.cur_stack >= env->prog->len)
 			return -E2BIG;
-		insn_stack[cur_stack++] = w;
+		insn_stack[env->cfg.cur_stack++] = w;
 		return 1;
 	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
 		verbose_linfo(env, t, "%d: ", t);
@@ -5426,14 +5425,15 @@ static int check_cfg(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
+	int *insn_stack, *insn_state;
 	int ret = 0;
 	int i, t;
 
-	insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
 		return -ENOMEM;
 
-	insn_stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	insn_stack = env->cfg.insn_stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_stack) {
 		kvfree(insn_state);
 		return -ENOMEM;
@@ -5441,12 +5441,12 @@ static int check_cfg(struct bpf_verifier_env *env)
 
 	insn_state[0] = DISCOVERED; /* mark 1st insn as discovered */
 	insn_stack[0] = 0; /* 0 is the first instruction */
-	cur_stack = 1;
+	env->cfg.cur_stack = 1;
 
 peek_stack:
-	if (cur_stack == 0)
+	if (env->cfg.cur_stack == 0)
 		goto check_state;
-	t = insn_stack[cur_stack - 1];
+	t = insn_stack[env->cfg.cur_stack - 1];
 
 	if (BPF_CLASS(insns[t].code) == BPF_JMP ||
 	    BPF_CLASS(insns[t].code) == BPF_JMP32) {
@@ -5515,7 +5515,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 
 mark_explored:
 	insn_state[t] = EXPLORED;
-	if (cur_stack-- <= 0) {
+	if (env->cfg.cur_stack-- <= 0) {
 		verbose(env, "pop stack internal bug\n");
 		ret = -EFAULT;
 		goto err_free;
@@ -5535,6 +5535,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 err_free:
 	kvfree(insn_state);
 	kvfree(insn_stack);
+	env->cfg.insn_state = env->cfg.insn_stack = NULL;
 	return ret;
 }
 
-- 
2.20.0

