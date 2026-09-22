Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B7566C74
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097652; cv=none; b=V8Bk4viZGGj3syniIOFlcBPm1keU6CfFWsRYThNj60NRwS7k0Ipbi9U0Fhq1pOZVbgxRWYB2WmhVdY0nec8U7i74g5mk50i6Hp+6AGi/++Zgbdnhf/7YZn1MFFi1C/xDAioZqG/8Ypcet4+P4SBeqyiuXUxTuGaeYMLvNl7ee+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097652; c=relaxed/simple;
	bh=vLbRLVhbj8RwxDK1glDhecQBCjjtE69Bi+W72zh7us0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/LFsxmpydm6AH8MoApxcJSpVy9P6DMgDPysv5JQoAb1UbSZynHa8Y/TUWX/Sx09woW7PYwylK3H6pqTtkq1r1466338JN7P4FWkc5WAMTuyGwka7tsrUHgYDr1Ydhu7HF7qoJiTgbvgfgJJJcmo+CPRC0n+4xTb+ZR0opFtgEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Y1aZFMnV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Y1aZFMnV"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so130841a91.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097646; x=1790702446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eeoRD0ZvaQHpJ2Mh9yIGiF9D5HUjmB+w4ge+o9sW4U4=;
        b=Y1aZFMnV35f3Aq8lTJEhAdadV66XfbtaQBG9MhrRLc+RjDMtIGfIiUZj89BCQifH6X
         LBTpeuVYf3to74xstaFY9Go09XPqJ3oJ8K5xd+7ZgUM+tEeOU2ESsroJEkSWNqIkfPJY
         96WHi74H4kTp0oKZ80jMlvsMF0l243W71mGBYEDc6LMhhbh14P7WFaMeDwXIJ/xMEOZJ
         Js23cIXJkEyjfTxt+byTet74Khlssb6MN+G9lqMca/cEr/+wC7YC6JyQO6F9aAL40Ms4
         PcZp3bhViTe2H1ZnTBdqBUw31RlAm+1XjtQPckGXOwM1LWEkir2Dk7PhAaWeYrVTxcqH
         RIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097646; x=1790702446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eeoRD0ZvaQHpJ2Mh9yIGiF9D5HUjmB+w4ge+o9sW4U4=;
        b=r4feZBeAmyBpYLx77e6/p4NtEoewwgaecttpqWQj5PWAwdJu56ANrHH+RfJf3YnIJf
         lGIktorKGGfJKVOr0uihMSMdvbWEarHSECBF7E22rxDN+/iZ0U2B7sGoNDtJdAps4cny
         pA1kg0TSr6AF2Rttg+PB31PrTEqLtKxT8jk4WWqkyip0YX7Z+4AuVhBeqhwqFdtpT8g0
         kOvADfivN7jgsnnB2m5HmVdzKknxiHXWZfScWsiZrm7Dmu0mb/mbzCpXSnQid1fUlVNx
         Au2ob+UrXF3v0X0U2HW1/7BSffK3p98ZwHqiQW7LMElBZKHJcTFyvB2ULwT5niScACzf
         Si/A==
X-Gm-Message-State: AFuF++m5SALbxn5io8KHrBNXLTVJLkL5xhUKvCXm0qB7AOpTOCqHOXQb
	LRW9aWKadkCVLAYV6jxQhk6bhJpyUjYpYaMVX9A9N8sZo3ndOyPy6Vfij9LErm6Pzq1bmgZ2lS5
	vFUCU
X-Gm-Gg: AYBFou0jsAzuzd9bHmlcXdtsxJpb7b/dnIqdTqeF8b+Q5b4a7HeFfbLV5PT8iceKQI+
	Wnp6Ybmdpz/e91oHQoesL9dBCJh3RnpNz4ZO5UELtXkUz3a5wH4frtjYqD9C6FGiwqCuvQ4lH09
	dHPzzrZeOK5pRz2SkAAOtklUtnm+Hi7cwXI4cNQtwmTh8htjrV3at38WXz5IJY9Vg3IDr9lPuec
	zeD6cjB1ANqGM4KqvkZPXlU3sj0GzO9wznILwCZ6hrnWZfjzKCHJ6brVYyRB3q7bZDxDPHw+/4F
	+G6lpaDvfeiJSSdC4BeDgzu/IeYIQIKk6AFSCK2e1iObFysThRN/C0KM1At4k1lzxYckQvmGorQ
	jodVsHWazMx940DfeJ5ixnmC+0abqAyWxAofOJZbFMqekW3+HR+c9/fCRZgmfwXrV8sanAs7HF9
	lvhBF74o38RNMzvyAzBu8Bd0SZwqp52nDGJjNMKTead7vVCH++GMYd+F/ybIyXsxHL7fwhTRbJI
	VMWbhjSbp5D4ZAR9FuEuNAQTMGpLtZ0l85sqgBFYg==
X-Received: by 2002:a17:90b:3806:b0:3a0:4146:2955 with SMTP id 98e67ed59e1d1-3a07e693c71mr116676a91.61.1790097646271;
        Tue, 22 Sep 2026 10:20:46 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:45 -0700 (PDT)
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
Subject: [PATCH bpf v2 07/11] bpf: Prevent variable arena/non-arena register contents
Date: Tue, 22 Sep 2026 17:20:24 +0000
Message-ID: <20260922172028.6269-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
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
index 92f528c45..be0ccad15 100644
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
index 71ad07a9d..cebed6c9d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16130,6 +16130,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
 	struct bpf_reg_state *ptr_reg = NULL, off_reg = {0};
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
+	struct bpf_insn_aux_data *aux = cur_aux(env);
 	u8 opcode = BPF_OP(insn->code);
 	int err;
 
@@ -16141,12 +16142,23 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
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
@@ -16159,6 +16171,16 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
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

