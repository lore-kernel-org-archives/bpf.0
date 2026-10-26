Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983670;
	b=le/JiHyCXAG/Q4bRx0ZSJCo/+6gDntYzC1PMAuE6PGL7VxqP1itd4qpUaXgnG3wcOiAG
	 YJHacm6lHzkWJvlbScy3WE7Dmgkez2hmI3JlQqCngSlKW0LyLl/bV7qkgm9n0Be/+Hw15
	 CYUebNSg49dPtyWBlNnQN3A22iDLlWaapmeSaDZZicaEgb4F3GMc+qH0+nmrDC5CDGZ6H
	 N+kVQNL70de1vBoUpErJdaf2HmsD6tnWwUch/8P6RljZZXf2eljJ3mabpa3yKcKU19mve
	 vVvFSG5l1n55jmFw33Sy4HKwDv6aL6Bq8s4SwXNUZr9KEcJpiX1xvKNbI6FhCHmypQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AOSQkjhoVMy8EyUzvD1QjHa0DYIBzMXd9L1iKUI1e7U=;
	b=VYUf+PkX3ArfQhs9CoS0jkF06pZOdUEvxm3UM7qkwXMlNfq1OFu+Qty25DEVgA46vwMW
	 U2Qgk4CkUGliTAeljZ/O8XqdwozLTdZoDdDs5qbEJQ1Vd2ku/5/24mE/MY1x5LMqIrfCu
	 sAGGdjfVGP2AX7GsAwILEnaTiGZgrkVcnGcQOE/PyuNzX0+LdFB5+VUzllQthpDw4zMCA
	 /huReDgd8mhbgrTeZzEJxwI7CaknNIHRn1IkWzjkx4iSODo2UPn9dhXZIW1eFeId2fvNb
	 M1PjkmkLPGTuUVaSBS8p2GtefE5o6UcfJoCIFSIcRcjBrsT/ZvU1HHjktjiPQqQYjhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FJkgFRvj;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE0606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEDE0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FJkgFRvj
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1729424a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983669; x=1793588469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOSQkjhoVMy8EyUzvD1QjHa0DYIBzMXd9L1iKUI1e7U=;
        b=FJkgFRvjmD44C31QtLv83Oyikl9JpDBUarMJtSMSyp1dE3iANgtf+C0K/PiqjEbVWQ
         IQiQ5dnAPrRF5SEkYlaRqFy+r5Fri900ilao4ZCHZcZxHoeMqXUOrLG6WPGXRceuo59D
         3hbZxRSpTyfwr8j1y50JSP4ivXrSVhCdoahX++MG/B1aJZvFtLhXM294ebW3rStZAiHk
         BGfyIjyk/62JgEVCj82C3NiF8O/KsGi/DR9+8fKOxat+A2I0spo6IuiBbH9wD7yxu83p
         7SFuJ1I8UynOjmrcOKMTK6AMUpiuPtH25LXVFEgrwDCUh1jRPZ5217BfV+vRf4LZjzTy
         P+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983669; x=1793588469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOSQkjhoVMy8EyUzvD1QjHa0DYIBzMXd9L1iKUI1e7U=;
        b=v/Y8F8k4A+xI0Qd/D6q+xGzgycD51915Fns4jdFJ5Eq0ncMyVNHF5HohXUsez/BoAx
         1AFjH6bzOZlp12QjbzzUfGp9hZK8W/cYPuiK/LI9FirAgXx4dwv23fM06x5MGor0tPAs
         0vKDSkZW+IK7Jzy2qoNpULusNftiaBF8WLJUHs1H5SW+5qhgfAH3uYehs24A8/+qB+kJ
         bU10gDLkha5J1eGXfdMLPqi57lTQ7yMvqNp1dzF1GWCXp5jbYazzTVKR4cGX5R4DPnmb
         p90Xi7wrThM6ZfLxy4hkq3Bo4caZwv0MlKOnBTic+H2uNNSl4Son2gSwPDa8AExZBsb+
         Ky5A==
X-Gm-Message-State: AFq9FYIRNTLQ6tMKvybvkFkBGuHmdfOUWkFLdo/ggwBlwfR9BjpOHw8h
	j+vTH9yqQ9NO1P5MpLuNfSEANeEvbr/aEVpF9Hp7rQOlV0MVv6eO/OWZjXsqgg==
X-Gm-Gg: AYBFou0tyn5gW3dWTfkVwxEN3MMBP+RmuDoATBoJSblKGzGovlt9eKP1Jn0aePvT7b2
	iKwBUDJXezHcttp4SIaxsTn686pF4AQwK82eOetTrMttZSc+GGAClm8yYRWE3W/yWuD0WrSH+xX
	ZyFGjBYYXpQhw1SowuETej4ir6CX7C1KRSbsTFCzHXu5mqxZgO/JOw7y1CW4P9sOgAXGrV2EZfw
	65P9T/M1a3lgWgiJMdtO9QVbtPSQfWAmGklfwkB9NX5sF298+IGnF/sMjKFrhEHHYFkEppAfmIO
	P3r1A5VINd1bmyHRrMcbJwS/3TspQ5klpS7zymhMpN+UvdYJl5ILzs1LiNRzPjRO+lo12c44lHF
	adJTptJ/FzAP/fGOr1n7LTeGg2aczPCKwarEB+6GYAXENT0ZCVzLaqi+N7YkV7Dx7GRgcEMTNNo
	Yvv9IG0aJecEXsaHDY37YLXDpU17v0NQi2V3ahLeeOQ1MySj58YakUgBg0rQCkTkaevXLNkP8gO
	6R73gRkKJ8lIg5NRuPEZn/WV3vcrsDliZptmCBLj+X77gh/WRUa79841Xs7pE6mizvQSCOU8LNQ
	8CV85MiT7+J7CEXwPS/scUq9xdaN8QVRI0zSg3Cq24gIaS796XB6fGsJAD9zlS0mXOQrvBk/zmF
	z/6oBO9yqn7Zjqhccmfk02JNj
X-Received: by 2002:a17:90b:2244:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3adead5159dmr5341145a91.24.1792983669077;
        Sun, 25 Oct 2026 20:01:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0dda7sm4657981a91.4.2026.10.25.20.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:08 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 14/81] bpf: Fix a false verifier bug in the clamp of scalar evolution
Date: Mon, 26 Oct 2026 02:58:35 +0000
Message-ID: <20261026025943.404450-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier rejects a valid prog with -EFAULT and a WARN:

    r6 = 0
    r7 = 0
  1:
    if r7 != 9 goto 2f
    r7 += 1
    r6 += 1
    if r6 < 10 goto 1b
  2:
    exit

  verifier bug: scev clamp produced empty range for r7

Scalar evolution describes each variable of a loop separately. It does not
know that r6 and r7 are always equal.

                                    r6        r7
  a run of the prog, at 1:          k         k
  the verifier, at 1:               0..9      0..9
  after 'if r7 != 9':               0..9      9       r6 < 9 never occurs
  back at 1:                        1..9      10      not in 0..9

When a state comes back to the loop head, bpf_clamp_scev_regs() intersects
each variable with its calculated range. For r7 the result is empty, and
the verifier reports a bug.

A range has three parts: 64 bits, 32 bits and the step. The verifier
examines only the 64 bits. When a different part makes the result empty,
the prog gets a second message:

  verifier bug: REG INVARIANTS VIOLATION (bpf_set_reg_range)

This is not a bug. No run of the prog gets to this state. Thus each range
is correct for r7. Give r7 the range that it has at the loop head, and
continue. The verifier continues to compare the other parts of the state
with the state at the loop head. Thus it does not hide a real problem on
such a path.

Each pair of the three parts can have numbers in common when all three have
none. Thus new bpf_reg_range_is_empty() examines the three parts together.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/scev.c            | 19 ++++++++++++++-----
 kernel/bpf/verifier.c        | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index de301b32015d..7030b997ce2c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1895,6 +1895,7 @@ bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 			    const struct bpf_reg_state *reg_b);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
+bool bpf_reg_range_is_empty(struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		  const struct bpf_reg_state *src);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 4266651e3fe4..6330deb2d3f2 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2869,6 +2869,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	struct linear_coefs coefs;
 	struct env *header_env;
 	struct bounds bounds;
+	struct cnum64 r64;
+	struct cnum32 r32;
 	u32 r;
 	int err;
 
@@ -2892,11 +2894,18 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			continue;
 
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
-		bounds.r64 = cnum64_intersect(reg->r64, bounds.r64);
-		bounds.r32 = cnum32_intersect(reg->r32, bounds.r32);
-		if (cnum64_is_empty(bounds.r64)) {
-			verifier_bug(env, "scev clamp produced empty range for r%d", r);
-			return -EFAULT;
+		r64 = cnum64_intersect(reg->r64, bounds.r64);
+		r32 = cnum32_intersect(reg->r32, bounds.r32);
+		/*
+		 * The state at the head doesn't know how the variables depend on each other.
+		 * It lets r6 = 0, r7 = 9 into the loop when both count from 0, and r7 = 10
+		 * comes back. No run gets here like that, so any range is right for r7.
+		 * Take the one it has at the head: the rest of the state is still compared
+		 * with the head, and what was pruned on the way here relies on that.
+		 */
+		if (!bpf_reg_range_is_empty(r64, r32, bounds.base, bounds.step)) {
+			bounds.r64 = r64;
+			bounds.r32 = r32;
 		}
 		if (log->level & BPF_LOG_LEVEL2) {
 			bpf_log(log, "loop header at %d, clamping ", insn_idx);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c93ef399c420..84f722bac539 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17739,6 +17739,25 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
 }
 
+/* Is there no number that is in @r64, in @r32 and equal to @base + k * @step? */
+bool bpf_reg_range_is_empty(struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
+{
+	struct bpf_reg_state reg = {
+		.type = SCALAR_VALUE,
+		.r64 = cnum64_intersect_linear(r64, base, step),
+		.r32 = r32,
+		.base = base,
+		.step = step,
+		.var_off = tnum_unknown,
+	};
+
+	if (range_bounds_violation(&reg))
+		return true;
+	/* Each pair of the three can have numbers in common when all three have none. */
+	reg_bounds_sync(&reg);
+	return range_bounds_violation(&reg);
+}
+
 /*
  * Checks if pointer and packet metadata matches between two registers.
  * For use with bpf_reg_union().
-- 
2.55.0

