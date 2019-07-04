Return-Path: <SRS0=LNRn=VB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950DAC0651F
	for <bpf@archiver.kernel.org>; Thu,  4 Jul 2019 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1BB21852
	for <bpf@archiver.kernel.org>; Thu,  4 Jul 2019 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="USLsSejG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGDV1Q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:27:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33787 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfGDV1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jul 2019 17:27:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so7888623wru.0
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2019 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rBAvqk5Lee9P3/iFEoKbYrpRp6bOz8xfKO0gRnG7T/A=;
        b=USLsSejGFH1AyitieoHpiakUDgruq8zdcSMHXAYW3oFfV1GCkTnFP95OUEaa7eGN52
         efK1b+fqoFvW+M54eOiG9wm1WNXJkReW4WSHGPMcMhGWFO2IQhJDkwS3sgCuby1o9/uL
         r9hkrfNgBkwOFNvkBRQjw03vEKVZ47wJxUw/At3FbHL9lXXTK72Fw0Dv76umNXUHvwRR
         vIbqHYh6Q/Gy2o+SMVegPb1vLUrauIEf5irMqmVyxyILZHWUsBuAu5Rj7WZnGRjKu/7I
         FTQAY4Kt7mPhLI4JoB4MwxErt3zlnt5fIf04GCE+a8yCKHHv6z8Vu87W/BsWQIre0hO2
         Y3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rBAvqk5Lee9P3/iFEoKbYrpRp6bOz8xfKO0gRnG7T/A=;
        b=UX1UcgAV8ferTZzzq2NaTcqKZ1lCGVvCEfE7u9mSutp8wHHBWFMyUMciLMN0/HeOVN
         w8oe/Tns5CdS0Hcg1NZ+IjNKXbtK5ftuFHlitI/r/26mOEEKTNZuxaqt0s0Db5gZlL5+
         a1RCD3o1IUDJqg+5cY7n5MEvZjSE/dAUTcN5oarCmAanajnE84EdoJaMZH3CBpuzfPuI
         UmhctDc4UkLA4HMWFEJuHMdPrgObKphhXpqO8+eLLjJkge0Bae8EgCyBUPVU4rmylHjy
         dNjtkFr6H4hEg3/CPOyCz9+SkH2S00hTX83gQtDFK+Kles9dhjLnPA+lG54NGPn3xR+9
         MD2Q==
X-Gm-Message-State: APjAAAVbTeo6hls6yB7D0NLTTPdkx2RwylAnZTunOyAS8AGZ8MUjFaMn
        6qxBRADi3lG0icx4uW+MFSt3Ig==
X-Google-Smtp-Source: APXvYqwDNXYvNH5AjI0e1o3E6zlAtQBclKtGaxRxbSYcLYaArr2Rfg+Q6LInHw+FEayzR568IDvj6Q==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr358930wrh.135.1562275630883;
        Thu, 04 Jul 2019 14:27:10 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t17sm9716654wrs.45.2019.07.04.14.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 14:27:10 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     ecree@solarflare.com, naveen.n.rao@linux.vnet.ibm.com,
        andriin@fb.com, jakub.kicinski@netronome.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [RFC bpf-next 7/8] bpf: migrate insn remove to list patching infra
Date:   Thu,  4 Jul 2019 22:26:50 +0100
Message-Id: <1562275611-31790-8-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562275611-31790-1-git-send-email-jiong.wang@netronome.com>
References: <1562275611-31790-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch migrate dead code remove pass to new list patching
infrastructure.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 59 +++++++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58d6bbe..abe11fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8500,49 +8500,30 @@ verifier_linearize_list_insn(struct bpf_verifier_env *env,
 	return ret_env;
 }
 
-static int opt_remove_dead_code(struct bpf_verifier_env *env)
+static int opt_remove_useless_code(struct bpf_verifier_env *env)
 {
-	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	int insn_cnt = env->prog->len;
-	int i, err;
-
-	for (i = 0; i < insn_cnt; i++) {
-		int j;
-
-		j = 0;
-		while (i + j < insn_cnt && !aux_data[i + j].seen)
-			j++;
-		if (!j)
-			continue;
-
-		err = verifier_remove_insns(env, i, j);
-		if (err)
-			return err;
-		insn_cnt = env->prog->len;
-	}
-
-	return 0;
-}
-
-static int opt_remove_nops(struct bpf_verifier_env *env)
-{
-	const struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
-	struct bpf_insn *insn = env->prog->insnsi;
-	int insn_cnt = env->prog->len;
-	int i, err;
+	struct bpf_insn_aux_data *auxs = env->insn_aux_data;
+	const struct bpf_insn nop =
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+	struct bpf_list_insn *list, *elem;
+	int ret = 0;
 
-	for (i = 0; i < insn_cnt; i++) {
-		if (memcmp(&insn[i], &ja, sizeof(ja)))
+	list = bpf_create_list_insn(env->prog);
+	if (IS_ERR(list))
+		return PTR_ERR(list);
+	for (elem = list; elem; elem = elem->next) {
+		if (auxs[elem->orig_idx - 1].seen &&
+		    memcmp(&elem->insn, &nop, sizeof(nop)))
 			continue;
 
-		err = verifier_remove_insns(env, i, 1);
-		if (err)
-			return err;
-		insn_cnt--;
-		i--;
+		elem->flag |= LIST_INSN_FLAG_REMOVED;
 	}
 
-	return 0;
+	env = verifier_linearize_list_insn(env, list);
+	if (IS_ERR(env))
+		ret = PTR_ERR(env);
+	bpf_destroy_list_insn(list);
+	return ret;
 }
 
 static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
@@ -9488,9 +9469,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		if (ret == 0)
 			opt_hard_wire_dead_code_branches(env);
 		if (ret == 0)
-			ret = opt_remove_dead_code(env);
-		if (ret == 0)
-			ret = opt_remove_nops(env);
+			ret = opt_remove_useless_code(env);
 	} else {
 		if (ret == 0)
 			sanitize_dead_code(env);
-- 
2.7.4

