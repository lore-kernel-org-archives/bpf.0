Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460CC10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DD920830
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UIToFUT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDJTvX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53916 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDJTux (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so3899797wmj.3
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsnTnWMLFlcUEYVlg2aJmqMzdicYkQExuUgQyT6LC7Q=;
        b=UIToFUT33Cag+d5ieM6egGBLq64mL+OO92WAdi8TXVygnI/REzyE4l/7+OddK+/Ees
         LuEVWt3iKXzZJgeYDqQipRr2i1JNQ+pz7kCqitn578GjNZhIW3Rgctcqxgmsr/jHIrCM
         aDGD6sRjNQ81kd2NOequbYc6X5NQ8YdVj+odIh0DozXusa30pJp0dlpZSBHeCkfSgcTm
         QXa84BZXuuy2InQZd8x0kdQW1WoIzMWa7LEr90beU5+iQ4c14aeu0GIrht3KRdM8LTVJ
         NvgTfk7Ysm4TvIxRMwTY8t2yLwcJwrBrmecOJ8zMPvLQbZH0JnOcAiM07hTkxP4wTaNV
         P7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsnTnWMLFlcUEYVlg2aJmqMzdicYkQExuUgQyT6LC7Q=;
        b=GZAqQ5FcQWzI+yQ73BJmB6/ORRVC26AGyTQosi1PLEa6j+kpUHo6lBRxybEde4pZzK
         GrJYye5a8Nq6/nds9HqwNiAVV/uqfYUZvSf1Z4l07P5xkaZ44J8VBCaG3ATtftzAJl4j
         mX1mHxrf73s1ASa965TWJ574891Q/0oaUTFr0JO8wCX4XvFba8yj9OErLHYxbzVMrs2V
         zYP3xPhJu/UtQnnpXYL0C8uLy6b1WJ0S5k6VUVZewMYkFZHXKwnJ9BrprWBRWmO0RT1C
         WxH1Uk4MhLKX3RQk5s+4hbbLEsf9wD8hs9U/LsVwv1J5MXiSza3l9HzLZIodA6Di9U1A
         KpJw==
X-Gm-Message-State: APjAAAWpmvn0gHTp5pMXWBdUTtN6Cu0P+VUN60ckf9ivGbZhQYRW4Zry
        4d4ulce3x9Md+ys0Pa9B6W5dEA==
X-Google-Smtp-Source: APXvYqyKhv/1zQgeNcdpNzY2gXQx+TV9yixGxlB0jCUiWWXrlZ+mjGtMQ/gcfMNdm2oTuVfp3us45A==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr3948485wma.25.1554925850973;
        Wed, 10 Apr 2019 12:50:50 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:50 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 10/19] bpf: randomize high 32-bit when BPF_F_TEST_RND_HI32 is set
Date:   Wed, 10 Apr 2019 20:50:24 +0100
Message-Id: <1554925833-7333-11-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch randomizes high 32-bit of a definition when BPF_F_TEST_RND_HI32
is set.

It does this once the flag set no matter there is hardware zero extension
support or not. Because this is a test feature and we want to deliver the
most stressful test.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 85 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9141a9a..33407c5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7520,24 +7520,70 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int opt_subreg_zext_lo32(struct bpf_verifier_env *env)
+static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
+					 const union bpf_attr *attr)
 {
 	struct bpf_insn_aux_data orig_aux, *aux = env->insn_aux_data;
+	struct bpf_insn *patch, zext_patch[3], rnd_hi32_patch[4];
+	int i, patch_len, delta = 0, len = env->prog->len;
 	struct bpf_insn *insns = env->prog->insnsi;
-	int i, delta = 0, len = env->prog->len;
-	struct bpf_insn zext_patch[3];
 	struct bpf_prog *new_prog;
+	bool rnd_hi32;
+
+	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
 
 	zext_patch[1] = BPF_ALU64_IMM(BPF_LSH, 0, 32);
 	zext_patch[2] = BPF_ALU64_IMM(BPF_RSH, 0, 32);
+	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
+	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
+	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
 	for (i = 0; i < len; i++) {
 		int adj_idx = i + delta;
 		struct bpf_insn insn;
 
-		if (!aux[adj_idx].zext_dst)
+		insn = insns[adj_idx];
+		if (!aux[adj_idx].zext_dst) {
+			u8 code, class;
+			u32 imm_rnd;
+
+			if (!rnd_hi32)
+				continue;
+
+			code = insn.code;
+			class = BPF_CLASS(code);
+			/* Insns doesn't define any value. */
+			if (class == BPF_JMP || class == BPF_JMP32 ||
+			    class == BPF_STX || class == BPF_ST)
+				continue;
+
+			/* NOTE: arg "reg" is only used for BPF_STX, as it has
+			 *       been ruled out in above check, it is safe to
+			 *       pass NULL here.
+			 */
+			if (is_reg64(env, &insn, insn.dst_reg, NULL, DST_OP)) {
+				if (class == BPF_LD &&
+				    BPF_MODE(code) == BPF_IMM)
+					i++;
+				continue;
+			}
+
+			/* ctx load could be transformed into wider load. */
+			if (class == BPF_LDX &&
+			    aux[adj_idx].ptr_type == PTR_TO_CTX)
+				continue;
+
+			imm_rnd = get_random_int();
+			rnd_hi32_patch[0] = insns[adj_idx];
+			rnd_hi32_patch[1].imm = imm_rnd;
+			rnd_hi32_patch[3].dst_reg = insn.dst_reg;
+			patch = rnd_hi32_patch;
+			patch_len = 4;
+			goto apply_patch_buffer;
+		}
+
+		if (bpf_jit_hardware_zext())
 			continue;
 
-		insn = insns[adj_idx];
 		/* "adjust_insn_aux_data" only retains the original insn aux
 		 * data if insn at patched offset is at the end of the patch
 		 * buffer. That is to say, given the following insn sequence:
@@ -7580,15 +7626,18 @@ static int opt_subreg_zext_lo32(struct bpf_verifier_env *env)
 		zext_patch[0] = insns[adj_idx];
 		zext_patch[1].dst_reg = insn.dst_reg;
 		zext_patch[2].dst_reg = insn.dst_reg;
+		patch = zext_patch;
+		patch_len = 3;
+apply_patch_buffer:
 		memcpy(&orig_aux, &aux[adj_idx], sizeof(orig_aux));
-		new_prog = bpf_patch_insn_data(env, adj_idx, zext_patch, 3);
+		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = new_prog;
 		insns = new_prog->insnsi;
 		aux = env->insn_aux_data;
 		memcpy(&aux[adj_idx], &orig_aux, sizeof(orig_aux));
-		delta += 2;
+		delta += patch_len - 1;
 	}
 
 	return 0;
@@ -8425,16 +8474,18 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
-	/* Instruction rewrites happen after this point.
-	 * For offload target, finalize hook has all aux insn info, do any
-	 * customized work there.
-	 */
-	if (ret == 0 && !bpf_jit_hardware_zext() &&
-	    !bpf_prog_is_dev_bound(env->prog->aux)) {
-		ret = opt_subreg_zext_lo32(env);
-		env->prog->aux->no_verifier_zext = !!ret;
-	} else {
-		env->prog->aux->no_verifier_zext = true;
+	/* Instruction rewrites happen after this point. */
+	if (ret == 0) {
+		if (bpf_prog_is_dev_bound(env->prog->aux)) {
+			/* For offload target, finalize hook has all aux insn
+			 * info, copy the analysis result at there.
+			 */
+			env->prog->aux->no_verifier_zext = true;
+		} else {
+			ret = opt_subreg_zext_lo32_rnd_hi32(env, attr);
+			env->prog->aux->no_verifier_zext =
+				bpf_jit_hardware_zext() ? true : !!ret;
+		}
 	}
 
 	if (is_priv) {
-- 
2.7.4

