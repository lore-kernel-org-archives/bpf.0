Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160914;
	b=k2he+XmmzOe3oXSRYPLobVre+qtEyBqaXWORZufdhxLJSbHgn2AY67PHeDkSToGZwgfO
	 yYldLYLmQRnK4LYdnIqlaEUM/X/3Q35rTfMjTWG51oFBB3A5gzJIIcRj6AlbU7scdmSjW
	 fL2uBShkcKBWgpBqibUWHpewxIDp3cUiPf5WpM2BwqdNkdBNZlWCc6P/1oGe3Sgd6ne3C
	 5aFRcnRhBIxtt52RFb2+HaySHuEhWVMYCdwowl9DynUhn5E7pJbghud5oOxF26tId8zSD
	 pZqWtD8CxMYUpuW7FsY8nLPl/8AMLHeZ3VJoSoWFZsl6wH6lQH7ycSLwKFqTDN+Sevw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3hG08dChh684jKMRA4EehSENN1r8Me7ST0KotaAOP5c=;
	b=Sk+rMBnYxuqcfjKgIb12risor5NDt/X+B6zzmxI0KLslm9oWdCr4d5HYr64meoMwLe3F
	 f9r11PYGq81FQl8Vy2M9hYjPwv6WAiAVRSQYqFmfrv9/OcjH0um/o+T4kImW3hBJA/q0B
	 /uAvvzXBP7UgBTZeyb744m/i4fYR9pLAuveiZMmv2BifbmGv9iGIqpnnGe/wocVF/aDAd
	 iQCOobKrTug+87zGMGcQuZh1mWZDU+aff0SsrHi11J5bykro/ZPRHM4jV1d7scH181FyE
	 nI/oEf1zqvrJtnij/TNwlZYi5vgMmDWVLXmcoUVomDXtx/HxCEr4a7w19yk/mwhoCjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLFmtULV;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71368606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71368606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLFmtULV
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f0213202fdso3133305ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160914; x=1795765714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hG08dChh684jKMRA4EehSENN1r8Me7ST0KotaAOP5c=;
        b=hLFmtULVdNNKCxplwkV6p9fyRxoq2w4xa7bhOX2UUPmc1hsHQJNDveoSA7lYJ6csE8
         4QfuBRmsam1sKhZsis+PV8LN9vshETkTKy9VgZ3nlUhWhqdy8Gvoy7ydoljIRj5nCS/d
         BEiTPA9LdXjR/gHYg3dbYqvehx5UB14KfT0ZXXIRa877UsxFBEliqxvcruYlYeSuQVDG
         XFKdksBYc/brHx9Rhe0cHZS5XsJ7XQJYfESckIV0As8CwuaERxYBv8AOnZ1d8WUAToYn
         qoJmFScGO6ZP8GI59+URSM7lT6MGnKiTeMpn5aRcy7tTIxfjFV1OIu1/8PesDuWWS/8h
         9Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160914; x=1795765714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hG08dChh684jKMRA4EehSENN1r8Me7ST0KotaAOP5c=;
        b=Z6xwnKIU/NIXjPKTv9QJxEbwpsyKRCA3uEpBmdhOtneYlHHqqNUnucFjcx+M2aGQnE
         PuRqO+KVHiwPs3pZTnTpiOdgfBixVy90rznigLh+RMQcQZpoJkTkyXWYHZUb/SEGwbGO
         IHqYjOnqbZad10F4Tltzhs/SnrnLRbB8uNowTBA5/OQt2UsZQUYAyfTumXigqTAGftSu
         f/iYroCL184dfZONojgTKw7I5bmGsGpJJZcuGr4MK8mc4I5k7/ql+9T/+LeLn9b+hYkr
         alJTfgO3chvzj8UKlMPCYlXZTv/hk8+udDiwfSkTlX3Z7jzDp7ZhugqfJ2antgeSDcYF
         xE2A==
X-Gm-Message-State: APuU4Z8ILVrRQDwaqrPdCYPP5kh3pYamq4vUh9tbQ1uax1soDgCtVAXP
	bgcrekh7fjY8C6hu6nOjyvkdI4lr1ZdhAqeU17pZ/4dcx5H2WupfXkAJOMfUtQ==
X-Gm-Gg: AZFdTZdiEwseJOjb72R2GMcoi7XOmtSHCB236YBtwl7cLSM1n4ImsahSGIthNGOTHH2
	a9zpj9Ptwk6VPQ1Rtl6FSCR1H0hIjzH347zxERviz+BG46fw6QazWZMPm8S5FDXmRuKdsdso364
	Ia1pY0Y6rs1ETuTL+dzp3fiVTNd96yVJPSGWOpmKyNGl0HddMtgdCwKkOhbaLqQW3KjOk118PlG
	ksTvHBoJJ65m2bcg0MECIIfnrysr5uEFyNnsxxRhHgw8m1GgQO/McadoY37tORigazts1776eCt
	uo3zA7pk6Bvl6DxCBr9wRJXgMRJF72uUdRO04m0lOdZeTRIyikjVeOQo0IOVsnMeF9T95l8w1Ep
	PVvbdZ7uqDdeJTRHQNRkYDV2DB9EIHrtpjoLPwZSeAuN5g1WLp5J9C96CHZ9g6LILDN617ygjAF
	TEzeStl/TM40GKR+ZAPCWSxtS/0bhTeEqjC+Y0fs9KcDND1GHNDBR53+hE+JU0NfW6Z5kSSvHm0
	rA3EXRx6bF/udnd2ZOibfoXSIXRiIrWwNRDppWDvaXY0tog9PZ8F64ZrQFbWySXgipDdOskAZI9
	NF2xjFeoruwaREzJy2xPistXq803ir0V4vqRCE0W5zUny614fX9hFgq5qssCWvCfbOpAclWOveB
	XFLxq0h9EGD4btCsvgnr1NdWHCzo2vwZOBQrpQE/mxyTGeHtUtZ1gB8f+MqCJy5cVGeErIoc8Bg
	==
X-Received: by 2002:a17:90b:3d92:b0:3ac:7842:bd50 with SMTP id 98e67ed59e1d1-3b41c8dd1a2mr2077678a91.15.1795160913521;
        Thu, 19 Nov 2026 23:48:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ffa98esm6222981a91.17.2026.11.19.23.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:48:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 41/49] bpf: Refine the copies of a number that AND or OR splits
Date: Fri, 20 Nov 2026 07:42:13 +0000
Message-ID: <20261120074430.2704488-42-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

maybe_fork_scalars() splits the state when AND or OR reads a number
that is 0 or -1. The copies of the number are not split. The two states
forget that the copies go with the result:

  w8 = 0 or -1
  w2 = w8; w2 &= 255          state A: w2 = 255   state B: w2 = 0
  if w2 > 9 goto out          only B continues, w8 is still 0 or -1
  r2 = r8; r2 &= 255          split again, a use of r2 = 255 fails

A split is a jump that is not in the program. Refine the related
numbers as after a jump: w8 is -1 in A and 0 in B.

Without bypass_spec_v1 a join does not relate two constants again. So
the copies are not refined there.

A program with this code in a loop goes from 11 passes to 1.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/equation.c        | 18 ++++++++++++++++++
 kernel/bpf/verifier.c        |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 16eac538f43..5ceb141e4ae 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2532,6 +2532,8 @@ void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_
 void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 			bool taken);
 u16 bpf_args_with_equation(const struct bpf_verifier_state *st);
+void bpf_equations_fork(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			const struct scalar *part);
 void bpf_equations_next_trip(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			     u32 depth);
 bool bpf_equations_subsume(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index 4216fd00879..65f101c5e6e 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -1040,6 +1040,24 @@ void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state
 		refine_diff(env, st, &untruncated[0], &untruncated[1], op, true);
 }
 
+/*
+ * The insn is checked in parts. In @st the operand that it overwrites is in @part.
+ * Without bypass_spec_v1 a join does not relate the constants again, see join_expr().
+ */
+void bpf_equations_fork(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			const struct scalar *part)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct scalar bounds = *part;
+
+	if (!eq_env || !env->bypass_spec_v1 || !eq_env->has_expr[0] ||
+	    !eq_env->operand_expr[0].coef)
+		return;
+	scalar_bounds_sync(&bounds);
+	refine_sym(env, &st->equations, eq_env->operand_expr[0], bounds, 1);
+	propagate_bounds(env, st, false);
+}
+
 /* The largest sum of two arguments of a call: numbers, or offsets of pointers. Modulo 2^64. */
 s64 bpf_equations_max_sum(struct bpf_verifier_env *env, int regno1, int regno2)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e29a72eba02..9aa6b331768 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17619,6 +17619,8 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 		__mark_reg_known(reg, 0);
 		__mark_reg_known(dst_reg, -1ull);
 	}
+	bpf_equations_fork(env, branch, scalar_of(reg));
+	bpf_equations_fork(env, env->cur_state, scalar_of(dst_reg));
 	/*
 	 * The insn is done with in the branch too, and what gets to the next insn is a state
 	 * like any other. At this insn the branch is a part of the state that is looked at:
-- 
2.55.0

