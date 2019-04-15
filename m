Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D8AC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550852077C
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qr4cMdKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfDOR0o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:26:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46037 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfDOR0n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so22973537wra.12
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F3IQdRy82Sws5VQv+L8cpFUINUDPBEmOgKCAbvoUTJY=;
        b=qr4cMdKML3i5juO46c1WsG7Fv7jE2MWV3oudyjRzhVt/tuPGhhwBNjdW5OKWUEcpXY
         ZXqT/yTdalJCdcdo6A6d2F33M/ThCithmoYYAh/l/t/rSsrthBdqG7rxoR7OZuFC+yLM
         Hgj5/iJJbDcPD68oXKL2WwCIuzztD00qfBRIqKbPMWoHYasL/WO3U0AI26/uPGctMyMd
         2o6h5z3eq/uEfNrgM+2KXMWvqLGQSEHPcRaAarbn8eYdvOEVOPVvuZQkrdR30ZP1nf+9
         HatV549uGv7oNOwR5PvGkgI4dub1x67s/hHNmRjFiHSO1vuEtErp7SlUh2ftmtGHrNcA
         VfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F3IQdRy82Sws5VQv+L8cpFUINUDPBEmOgKCAbvoUTJY=;
        b=fH1FvurkWKHhCEKg6VflMLFz+wZ6jeFLbtDgreSZwf7SajkHK81XeqeblM+x1XTDvK
         IMMxoutkq+5iH/dCodWNKrODpXt4p7Bi2QxwypCneqvSCwU8/LdUdeyaWKff9aXNpvAc
         PZinEBBmuF9tgvtd2oodHa4D9nEyN+moKPRuhdSdb0aQcfOlOVwqDSl85jc+ec54Y01+
         ocUD6cKm9JWYtdygO6VqrptFPLG0Qsd8BDFNInzTYMDwze5iuBTp1Ulp42NWrKAoQXzC
         VB1bRSmYHLjvSz58gK6ftKpFgYKnPXShWerz0aaErUH/RRe6DF4kxLrN+B0fR7D+phOa
         O7NA==
X-Gm-Message-State: APjAAAWZDCWgr2NndIlX90+kQQyAzeLGuKeyISYPqgyCmKWJsrQMB42a
        uZOG4fNu7bB3Nol/sZh8xCgrQA==
X-Google-Smtp-Source: APXvYqwK2mBf+bZVXqSKid7m7jwBiYPll8IGIyVz2n7ZkhlTu2HSuv8lVRz0fTALhw/04MMss3iovg==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr24665450wro.144.1555349200481;
        Mon, 15 Apr 2019 10:26:40 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:39 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v4 bpf-next 04/15] bpf: insert explicit zero extension insn when hardware doesn't do it implicitly
Date:   Mon, 15 Apr 2019 18:26:14 +0100
Message-Id: <1555349185-12508-5-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After previous patches, verifier has marked those instructions that really
need zero extension on dst_reg.

It is then for all back-ends to decide how to use such information to
eliminate unnecessary zero extension code-gen during JIT compilation.

One approach is:
  1. Verifier insert explicit zero extension for those instructions that
     need zero extension.
  2. All JIT back-ends do NOT generate zero extension for sub-register
     write any more.

The good thing for this approach is no major change on JIT back-end
interface, all back-ends could get this optimization.

However, only those back-ends that do not have hardware zero extension
want this optimization. For back-ends like x86_64 and AArch64, there is
hardware support, so zext insertion should be disabled.

This patch introduces new target hook "bpf_jit_hardware_zext" which is
default true, meaning the underlying hardware will do zero extension
implicitly, therefore zext insertion by verifier will be disabled. Once a
back-end overrides this hook to false, then verifier will insert zext
sequence to clear high 32-bit of definitions when necessary.

Offload targets do not use this native target hook, instead, they could
get the optimization results using bpf_prog_offload_ops.finalize.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf.h    |  1 +
 include/linux/filter.h |  1 +
 kernel/bpf/core.c      |  8 +++++
 kernel/bpf/verifier.c  | 87 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 884b8e1..bdab6e7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -368,6 +368,7 @@ struct bpf_prog_aux {
 	u32 id;
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
+	bool no_verifier_zext; /* No zero extension insertion by verifier. */
 	bool offload_requested;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fb0edad..8750657 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -821,6 +821,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
+bool bpf_jit_hardware_zext(void);
 bool bpf_helper_changes_pkt_data(void *func);
 
 static inline bool bpf_dump_raw_ok(void)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2792eda..1c54274 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2091,6 +2091,14 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
 	return false;
 }
 
+/* Return TRUE is the target hardware of JIT will do zero extension to high bits
+ * when writing to low 32-bit of one register. Otherwise, return FALSE.
+ */
+bool __weak bpf_jit_hardware_zext(void)
+{
+	return true;
+}
+
 /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
  * skb_copy_bits(), so provide a weak definition of it for NET-less config.
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 388a583..33d7e54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7555,6 +7555,80 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int opt_subreg_zext_lo32(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data orig_aux, *aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int i, delta = 0, len = env->prog->len;
+	struct bpf_insn zext_patch[3];
+	struct bpf_prog *new_prog;
+
+	zext_patch[1] = BPF_ALU64_IMM(BPF_LSH, 0, 32);
+	zext_patch[2] = BPF_ALU64_IMM(BPF_RSH, 0, 32);
+	for (i = 0; i < len; i++) {
+		int adj_idx = i + delta;
+		struct bpf_insn insn;
+
+		if (!aux[adj_idx].zext_dst)
+			continue;
+
+		insn = insns[adj_idx];
+		/* "adjust_insn_aux_data" only retains the original insn aux
+		 * data if insn at patched offset is at the end of the patch
+		 * buffer. That is to say, given the following insn sequence:
+		 *
+		 *   insn 1
+		 *   insn 2
+		 *   insn 3
+		 *
+		 * if the patch offset is at insn 2, then the patch buffer must
+		 * be the following that original insn aux data can be retained.
+		 *
+		 *   {lshift, rshift, insn2}
+		 *
+		 * However, zero extension needs to be inserted after insn2, so
+		 * insn patch buffer needs to be the following:
+		 *
+		 *   {insn2, lshift, rshift}
+		 *
+		 * which would cause insn aux data of insn2 lost and that data
+		 * is critical for ctx field load instruction transformed
+		 * correctly later inside "convert_ctx_accesses".
+		 *
+		 * The simplest way to fix this to build the following patch
+		 * buffer:
+		 *
+		 *   {lshift, rshift, insn-next-to-insn2}
+		 *
+		 * Given insn2 defines a value, it can't be a JMP, hence there
+		 * must be a next insn for it otherwise CFG check should have
+		 * rejected this program. However, insn-next-to-insn2 could
+		 * be a JMP and verifier insn patch infrastructure doesn't
+		 * support adjust offset for JMP inside patch buffer. We would
+		 * end up with a few insn check and offset adj code outside of
+		 * the generic insn patch helpers if we go with this approach.
+		 *
+		 * Therefore, we still use {insn2, lshift, rshift} as the patch
+		 * buffer, we copy and restore insn aux data for insn2
+		 * explicitly. The change looks simpler and smaller.
+		 */
+		zext_patch[0] = insns[adj_idx];
+		zext_patch[1].dst_reg = insn.dst_reg;
+		zext_patch[2].dst_reg = insn.dst_reg;
+		memcpy(&orig_aux, &aux[adj_idx], sizeof(orig_aux));
+		new_prog = bpf_patch_insn_data(env, adj_idx, zext_patch, 3);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		insns = new_prog->insnsi;
+		aux = env->insn_aux_data;
+		memcpy(&aux[adj_idx], &orig_aux, sizeof(orig_aux));
+		delta += 2;
+	}
+
+	return 0;
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -8386,7 +8460,18 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
-	/* instruction rewrites happen after this point */
+	/* Instruction rewrites happen after this point.
+	 * For offload target, finalize hook has all aux insn info, do any
+	 * customized work there.
+	 */
+	if (ret == 0 && !bpf_jit_hardware_zext() &&
+	    !bpf_prog_is_dev_bound(env->prog->aux)) {
+		ret = opt_subreg_zext_lo32(env);
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

