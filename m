Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37B7C10F06
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74392084B
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="RoDLjVv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbfCZSHK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:07:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55957 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbfCZSGq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so13648810wmf.5
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mudG8RvVsPscJFtOW94defIRDtY8/IaEfskGfsPcl3o=;
        b=RoDLjVv8hYngagCtjx7KodJXiPKWLHLjPxn6Ue9w0uV8JG5JbQC9nyYQL8KandEiI1
         XhfE0FjIlaCr7VkwdnEO8RNg/nOcixhAlc7nUEWLw4xzOgIJ/lxNye4/jps2PGfYW+4C
         NB9uxTHIlSTKdNrhjbxN0Otb5E25D+6ZzWIVVKVgyNPyKdkunkg3wUIx/QYpK4qHdz7L
         se2Mb5Tp5t314VzT1pehz/Ju5vBx0bysaRj8GrzhV4EnkHx8nDhBWpA1jmHLhW55L6Ov
         JoW19gXt8I1J10lxGPiLmJTQsne5Wxq6IBEcKAFKpF+g7UrEPif6v6//dByRiHH+Skdy
         9rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mudG8RvVsPscJFtOW94defIRDtY8/IaEfskGfsPcl3o=;
        b=JW12yFWLMLyZpPQp6DnP0Ohv0X5x3aXXm8qLSPxPTgestUVDpRrR6cF0FbKcQnmYPw
         IPGfhL2k5toTMFE6YQE8Baief+f4WCgLJlcj9Bg4veGBrGq2iKmjxokgBIs/7/kj3yD+
         3JxkzyFChHFbXrwU+qrg+7rgmCuBbtoSyFJuome8QioXcBmJ4oFivuiPKI0L9a3as7Ls
         MDZ9ZWUXZ182pG58RdGMXeSu83fxBDhpahqpEX+UZQws/60M4mtTFys1fv/qjAFJgFqY
         0aIyzIBNKtJlgTFkBigX4Ks8T0AlVatdScJYxdJzn0JLZohjDRydm6lSkDWAq1l0q+zq
         KGtQ==
X-Gm-Message-State: APjAAAVPvE1TUzU2Pt8EO69TWQbVISLz5qw50wH2YZoxSCQQPxPOy2Pu
        jS2Hbfdwv7/5JaOnqWOwkrqNtQ==
X-Google-Smtp-Source: APXvYqx7hzQuy2XOs/tEbBMoZ7LRcdI0dA/dKXAdi6lHD2QbOkBU5NjtCmAh6aKpIGVvTJCGp4AD5A==
X-Received: by 2002:a1c:3845:: with SMTP id f66mr10324433wma.41.1553623603801;
        Tue, 26 Mar 2019 11:06:43 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:42 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 07/16] bpf: insert explicit zero extension instructions when bpf_jit_32bit_opt is true
Date:   Tue, 26 Mar 2019 18:05:30 +0000
Message-Id: <1553623539-15474-8-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch implements the zero extension insertion pass using
bpf_patch_insn_data infrastructure.

Once zero extensions are inserted, tell JIT back-ends about this through
the new field env boolean "no_verifier_zext". We need this because user
could enable or disable the insertion pass as they like through sysctl
variable.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5616a58..3336f93 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -359,6 +359,7 @@ struct bpf_prog_aux {
 	u32 id;
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
+	bool no_verifier_zext; /* No zero extension insertion by verifier. */
 	bool offload_requested;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 83448bb..57db451 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7224,6 +7224,38 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int opt_subreg_zext(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i, delta = 0, len = env->prog->len;
+	struct bpf_insn *insns = env->prog->insnsi;
+	struct bpf_insn zext_patch[3];
+	struct bpf_prog *new_prog;
+
+	zext_patch[1] = BPF_ALU64_IMM(BPF_LSH, 0, 32);
+	zext_patch[2] = BPF_ALU64_IMM(BPF_RSH, 0, 32);
+	for (i = 0; i < len; i++) {
+		struct bpf_insn insn;
+
+		if (!aux[i + delta].zext_dst)
+			continue;
+
+		insn = insns[i + delta];
+		zext_patch[0] = insn;
+		zext_patch[1].dst_reg = insn.dst_reg;
+		zext_patch[2].dst_reg = insn.dst_reg;
+		new_prog = bpf_patch_insn_data(env, i + delta, zext_patch, 3);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		insns = new_prog->insnsi;
+		aux = env->insn_aux_data;
+		delta += 2;
+	}
+
+	return 0;
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -8022,7 +8054,18 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
-	/* instruction rewrites happen after this point */
+	/* Instruction rewrites happen after this point.
+	 * For offload target, finalize hook has all aux insn info, do any
+	 * customized work there.
+	 */
+	if (ret == 0 && bpf_jit_32bit_opt &&
+	    !bpf_prog_is_dev_bound(env->prog->aux)) {
+		ret = opt_subreg_zext(env);
+		env->prog->aux->no_verifier_zext = !!ret;
+	} else {
+		env->prog->aux->no_verifier_zext = true;
+	}
+
 	if (is_priv) {
 		if (ret == 0)
 			opt_hard_wire_dead_code_branches(env);
-- 
2.7.4

