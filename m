Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1723BCD3D
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535323; cv=none; b=aVusxCKcrexvx2H4PNR1tTyNzn7qBTwVE6+offU96RZMMx+uH5+TFVoCY4xUe8ro2hflleEg9WExwh0yyMu8iLUUMId3JcYKvF90SE+GLVSpLTM2QL0JJLgzxBtN7mEznPi5XoF0Ite0MKO/31bPJSrhlcLUHIvVM7WvIzg9Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535323; c=relaxed/simple;
	bh=UB21/AyuofSOIeKxw76qL3w7IAWRD0UVnVWEE1Xwr/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZAEMlm8ce2hetl5YEOTpdzlxecT99VsZveXdHbHAZDPITpVf0hbngw7mwzmlS2WIKkghHVCyC7469agjs2ieK++gp7RNyosFkVhUOhqa0DdIYOXQLy0jQBShr3Z7YLSKvUVbdduJgMXWiDeZQ4WkpRjtZi6eafK9YLB3Fa3w2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=toraEYyW; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="toraEYyW"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso463880a91.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535321; x=1790140121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qUFwUxK4/TM6HTUUp8+66unScxlhbbBKkxqY0gGyBO0=;
        b=toraEYyWOr29w79k0Zx6gPMqTjzyvKV5V4gSAw9t/9NIbwuvHcPCiwNiXpYJSfjkCi
         wZmVkegx0TEBX5mPDIZrscOmsjxcay82nA9kXz5GRW4XaVfAHIHCTR5xMiXFTp6rcJWD
         v/g+heQrXcDGwqKVZw4ty7yOLLk5cedPB8H5ZNhRdZoD020oCE2+wJCMNtgJcTmYBoR4
         EerUjaCGTzqHadsvSCFvSovjfacXPW8gZLLMBBmTT29KVpl5RhsmKTWadNbxB+dLa5yq
         fEGH25l6VRv81PtSLHm1jJ52NsbM69pjlrcL8K9e510UXfk9O7iwciczTfpf1OIfF+/l
         +/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535321; x=1790140121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qUFwUxK4/TM6HTUUp8+66unScxlhbbBKkxqY0gGyBO0=;
        b=W/kQufy5nTLRQdhR0ji5AO2qiU4nxBGkw8JMW9MM1tUxbTHoo6OlEDd1JWXRWtFxtk
         XApRqRPNSyJvyOVVA1/EoKCNUdq6+ATmOR2GTKmosHtmYPtr0FokRnix/ZJrpI5ofa9u
         D867u/7I32vwWy/20KfYFcr+WmX/w2r6t9cL2RxdLLk34FzS3hu0n3ksWtCbx5OHqod7
         N+gakK5DiXOA0+5/R7yOha5rSY8yHQydLRR/+13ClT8UNqKtussOFTUa4B1261B8PCjl
         pSyQy3snlK0vMfvlJVovc0V1T0JOqF/yYepATWd+suj7PNlyHQXGkDtT5sN6yV12x71A
         iD8A==
X-Gm-Message-State: AFuF++nxvT7FdAa5d3Vc5ClGDkDvaQ1jwRIUEgb0c5wimSPSUvgiu5Pg
	HBtm20oVOHHsZjAduO4FsE6EaEXJvA50U3jiKwqz11725quh2qr5YGPmyk8fce/Qyzi5iMiYyAT
	anuCE+eQ=
X-Gm-Gg: AYBFou1t/Wa5hljZ+fcZ0tCyWvoqqaFdMQBtijvrm/sI3BvWkc8mNdgKRl5L/7AVd8b
	adMwKrCZQJ/T278Z3wkotWaFkfFi6MPplkDIjiexJKqOWT9an0rhZxsIRAGuUnzjxf7r50goMhI
	cqwruzV/Ah+TiYEbwwufkEcamowQjC54K2TCH48RdxFXvE08ixCWcYhQlnZlANOj8ePM89Y8lH7
	FIDq4v0CTHmd0pm4mon/1JiPwDsMZ1eqzro1+iPL0fBcyf32bEIfzuxbGsrGTFHXKR0e/ogUPeZ
	pndyz4D1j0KhUPYfXd0B+EXnr3S9CxTLuGgKBB8eZ+gVO5euCd2HtVaRT86i5Z38jCF4eWmvgwX
	B2ded5tFOTliSHcFPEJ7hEnB8Lju/Kl1SC/GtWCCloQFvZGT28OKsc0MqR9ItWIlCom5/bvBFhr
	yHcGbsVcb6FBkmr/WX6YES7mTBEH0wwqgbMHkE4uI7vk3FAVpp4EDBSFNZcv6P4Og5ZU7v194y7
	BwjiQ4mfMz8zhRfTUs/pFMZPiVnV6x+prMM9GKPg2KPjbbT
X-Received: by 2002:a17:90b:4987:b0:39e:1633:d29e with SMTP id 98e67ed59e1d1-39e1e27af3bmr3157394a91.5.1789535321195;
        Tue, 15 Sep 2026 22:08:41 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf 07/11] bpf: Prevent variable arena/non-arena register contents
Date: Wed, 16 Sep 2026 05:08:25 +0000
Message-ID: <20260916050830.8774-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier marks ALU instructions that include at least
one arena operand with needs_zext: These instructions are
fixed up after verification to be ALU32 instructions to
ensure that the result is a valid offset into an arena.
However, different code paths may provide two non-arena
64-bit arguments to the same instruction. The result of
the operation in that code path is wrong, since it is
now unexpectedly truncated to 32 bits and zero-extended.

Add logic to the verifier to ensure every instruction either
always has at least one PTR_TO_ARENA argument, or never does.
Since needs_zext already tracks the first scenario, add a
prevent_zext field in bpf_insn_aux to track the latter.
Reject instructions that use arena arguments and have prevent_zext
set, or do not have arena arguments and have needs_zext set.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cf85141ea..d5b4ab0ba 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -679,6 +679,7 @@ struct bpf_insn_aux_data {
 	bool nospec_result; /* result is unsafe under speculation, nospec must follow */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
+	bool prevent_zext; /* alu op cannot be zext (already used with 64-bit scalars) */
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 507bc14b4..2c08ea94d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16056,6 +16056,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
 	struct bpf_reg_state *ptr_reg = NULL, off_reg = {0};
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
+	struct bpf_insn_aux_data *aux = cur_aux(env);
 	u8 opcode = BPF_OP(insn->code);
 	int err;
 
@@ -16067,12 +16068,23 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	/* Case where at least one operand is an arena. */
 	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA)) {
-		struct bpf_insn_aux_data *aux = cur_aux(env);
 
 		if (dst_reg->type != PTR_TO_ARENA)
 			*dst_reg = *src_reg;
 
 		if (BPF_CLASS(insn->code) == BPF_ALU64) {
+			/*
+			 * Only arena pointers set needs_zext, but doing so
+			 * modifies the instruction at fixup time to an ALU32
+			 * and makes it unsuitable for 64-bit scalar args. We
+			 * prevent zext from being set if the instruction has
+			 * been previously called with non-arena registers.
+			 */
+			if (aux->prevent_zext) {
+				verbose(env, "same insn cannot be used with and without arena pointer\n");
+				return -EINVAL;
+			}
+
 			/*
 			 * 32-bit operations zero upper bits automatically.
 			 * 64-bit operations need to be converted to 32.
@@ -16085,6 +16097,16 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		return 0;
 	}
 
+	/* Prevent the instruction from being used with arena pointers (see above). */
+	if (env->prog->aux->arena && BPF_CLASS(insn->code) == BPF_ALU64) {
+		if (aux->needs_zext) {
+			verbose(env, "same insn cannot be used with and without arena pointer\n");
+			return -EINVAL;
+		}
+
+		aux->prevent_zext = true;
+	}
+
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
 
-- 
2.54.0

