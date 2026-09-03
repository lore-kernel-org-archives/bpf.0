Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45C435501
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469119; cv=none; b=ZiTTmtyIxeqrwoFcuxiO2ajNcuAaLR4yFTEUm0WP7SO/5FebpXFwXyF4Vh1h6UJQeCby0hGrNgjo2Tpy43FgBg+cFZE2AhhamFfC0yfHt0P4pKV0/hLMOTXzexyHtFF/aWKWCimoCU4eifu8os69aptjeBdetWcmYFY4QpH6og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469119; c=relaxed/simple;
	bh=7Xphu41X/kOQdxAlYCSgWGvf5hD3yL0DovtxTWwjWAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9GReL1ydFIBgtz8ONDgvAFbGhd6WXXhSDopxy9/FYgvFRSqJZ7xBWvI64N5t8RO7n1hGvJ1qhERfGrvm3dFi+EaM/ZmuO58wl8/44ch9u1Lwt+0Y7d2jcU4s1z+7O9xvKxtLozNpsDbEQojvwoHqvcFB5kmY6OS4uGTjtsILdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+RvXaed; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+RvXaed"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so192852a91.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788469110; x=1789073910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rsMyDrWjLkdY3BQwnMyVLNCXejLL4InSybKjHlGj5Pw=;
        b=s+RvXaedsBND2wM/9DPCTOeVJmxQS27OIWmxVVBsRfPPresUpT4IaTwr4hMlnuyD/X
         LsS7y+0B/+BIKOzu64mQBodsL5NmytUJWG1UzjXtt/F9oW1ZT1/fpjQHWA+yQeSW+BEi
         BLLm8gbmKOKbH3KeAY5+qhBYWT6mzdGs3oe1S9QSbVYK5Pu+6emOV7H7v9KSMIR7ufBS
         6FNVeTdF9HrVFdbi+y1uFE691yKIiRRzLlXWMgbUFvYUGQEjJmS8OEYxYuKKgZ66tncu
         SKK2NlUos+lyK25YftOdrUZhjOpZXZ3WxTcmGESNDdeRVRDkDVIZ+Uad3MVDenE3kste
         OLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469110; x=1789073910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsMyDrWjLkdY3BQwnMyVLNCXejLL4InSybKjHlGj5Pw=;
        b=a/VyVyeQOI+pqC5b01kid7rjDMH1Y4GxtmCrEgA/yCnZXcWXrDkwIO/Dgc6FnA5bms
         MYNwwGqQzwwclQJ+vwQwmkuBqET7aXxUiNO0L4GB5DIaR2V3JU4Na0sPwhYM7JqcTJ3t
         m5FJKOv6uodPAOB7Qag6c4aovFoTLTErUBtKalisSop7tm3rMnh09c2d0VOI/N3yJDaI
         5D3RiZ3n65Ft4HaYcH9MpnQl1Fz3o25kDGx7kLKOmCBzoTjgbaPBCDZwoIWpr09ql+E4
         X+qZN7sF/MjIQPuYdAeBrlymYUu9bOXDk8ZkG9iepax1RqP2Jc8QCG69gmGUe4yShU3J
         CpBw==
X-Gm-Message-State: AFuF++ku3DqJJbvWQm+5MiJs0kzwLpfAueE4kogQCInXhbGLWM9gsDyi
	eJ00VGQQw4G9ysmMzoRvFoyYGV7fgYlmxe2c/YVIyQecQ5hk1PFAE2JrPxNDag==
X-Gm-Gg: AYBFou0V5DgbmvfOtrGCoTjXQiz9h3QE1vAW0jLnCV4UEVBBTxcxd/uIp3NYj2Gr/hb
	ZCs7j/KHQbbjVLqpNYU1/9QCjZ78P49CYlwyuACxvaSZf/+yn3T5XJ/N2Sj697IyBUn20oOC69I
	QgazGAr106zoxdBOIZcpIertlklMKkNZTGMRklyN3oQ06EB6mKA7SHKsAjY+WKamFeY20Tz/Ror
	VVodVBI92g8IOokMuyTNGRDdBr1V/CvWLmIJawkNJVSfctu27u8jAQ1fSpMv2++D9xnVgXpMKzP
	w00MfJyVkX2+P4Y4iwEdknkXDbGTR9lCWhIn/wtQ0ErruDhv3ia8DAFAlLSs91MQ5c+y1zGlJkY
	xGfu5/u1KmoZJ9YAoejVXKYa2KVKXTJLwbZFSDdUs9/jY30SLFblgSSN8azIrD/eYKGEf/EfCiE
	kpk78+5Kj9gsQIZqr43m1qY4XFmZrN0NMpCKCggn88cvJMTQu+d9sUWP4uCrImFN7yiV7mwZycj
	XgjM0PL4IQZHacqKyu9YGz1yvEGcxwEkquJsgGstc1XAg==
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39b26277b88mr1880180a91.24.1788469109690;
        Thu, 03 Sep 2026 13:58:29 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333959d5f69sm1383588eec.0.2026.09.03.13.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:58:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 1/2] bpf: don't rewrite bpf_fastcall patterns entered by a jump
Date: Thu,  3 Sep 2026 13:58:19 -0700
Message-ID: <20260903205820.1743087-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mark_fastcall_pattern_for_call() must ensure that matched
"spill; call; fill" instruction series is not interrupted by a jump.
Otherwise the rewrite applied by bpf_remove_fastcall_spills_fills()
is not sound.

Record the instructions targeted by jumps in
insn_aux_data[*].jump_target when the CFG is built and use this flag
to stop growing a pattern at such an instruction. Jumps to the first
spill are fine.

Note that existing insn_aux_data[*].jmp_point field can't be reused,
as it marks subprogram return instructions.

Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 12 ++++++++++++
 kernel/bpf/cfg.c             |  3 +++
 kernel/bpf/verifier.c        |  8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5fad59fdab0d..1339c2f028db 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -706,6 +706,8 @@ struct bpf_insn_aux_data {
 	 */
 	u32 calls_callback:1;
 	u32 indirect_target:1; /* if it is an indirect jump target */
+	/* true if some jump or call instruction targets this instruction */
+	u32 jump_target:1;
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
@@ -1142,6 +1144,16 @@ static inline void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].jmp_point = true;
 }
 
+static inline void mark_jump_target(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].jump_target = true;
+}
+
+static inline bool bpf_is_jump_target(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].jump_target;
+}
+
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 0f13c13f4133..842c7d1eabcc 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -125,6 +125,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		/* mark branch target for state pruning */
 		mark_prune_point(env, w);
 		mark_jmp_point(env, w);
+		mark_jump_target(env, w);
 	}
 
 	if (insn_state[w] == 0) {
@@ -403,6 +404,7 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 		}
 
 		mark_jmp_point(env, w);
+		mark_jump_target(env, w);
 
 		/* EXPLORED || DISCOVERED */
 		if (insn_state[w])
@@ -564,6 +566,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 
 		mark_prune_point(env, t + off + 1);
 		mark_jmp_point(env, t + off + 1);
+		mark_jump_target(env, t + off + 1);
 
 		return ret;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e64035683795..fad774890953 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17631,6 +17631,10 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
  *   r0 = *(u64 *)(r10 - 8);             r0 += r1;
  *   r0 += r1;                           exit;
  *   exit;
+ *
+ * Both uses of the marks assume that a pattern is entered at its first
+ * spill and thus executes as a unit, hence a pattern is not grown past
+ * an instruction targeted by a jump.
  */
 static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 					   struct bpf_subprog_info *subprog,
@@ -17669,6 +17673,10 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	for (i = 1, off = lowest_off; i <= ARRAY_SIZE(caller_saved); ++i, off += BPF_REG_SIZE) {
 		if (insn_idx - i < 0 || insn_idx + i >= env->prog->len)
 			break;
+		/* stx/ldx/call must not be a jump targets, a jump to the first stx is fine */
+		if (bpf_is_jump_target(env, insn_idx - i + 1) ||
+		    bpf_is_jump_target(env, insn_idx + i))
+			break;
 		stx = &insns[insn_idx - i];
 		ldx = &insns[insn_idx + i];
 		/* must be a stack spill/fill pair */
-- 
2.55.0

