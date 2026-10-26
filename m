Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983856;
	b=2RA9qymUnvSN4fIR4l4hEXYHSiGoYplzF40kfEdDZ2F8SE0G2uG4Az+88we9W1GqlJgC
	 mld4f7bFaJv9xMNqzwqwl4GCEjBbXtEcNDhDmfFXUPpS7HTVe69pBcL8kRWqgaMotW6he
	 1CGANj3ZYRpcFXESTJCBvoZJJOPWJopLmK8DStizow0sPRyreQjb/zPaFBP2qiBGJ2rSJ
	 aXKl+uHp1ES+qGCegoEZXl9y7WN4WuBP2mpoNJwxvUMehmwE1BjFSVt09DPUG2EBjftvP
	 Dy1S3SxhUhAqsOKSxHhmBlOHKBnh7/sofQZJlSX2+c/wjsqXYGzJBd0qBEW2DhNcuTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MFY6aWaZUBbFSs8gQiCy8TeBtr7IAp11DL47hLwXjC4=;
	b=VEUyz9ewD8KvRIOI6S+yEed8vG/ycV6LyTOlHuC8MG2ARs0mjD18kPtMS3W1KK8Nc79n
	 OV7DMNuddMRcFVlyOvCiCENCu3aHJvMU7kc6a67DsgWtcbH0e/0BMXnf4IS+VTGlglnqN
	 DgOlAHP41OfSDw9ilI86RsK/B7X8U0He8mokSpN+3xqTnLd/tGhxEItK5kG9Pm8Z9Y38g
	 7TAdDUr/MoVRkUGLegdTxeDgtJ0ZGFbmRXAgKXBsEx/JI8bpNJrXPbJySo7ALFjyn2x/i
	 r/dZm4zoJ9LnZ0YgiEZ8rrj/oB09betf0h/lIZPSQzVl51j8kqFqOOC/0jfQwH7O18Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DP6HZ3Cf;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB6606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77EB6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DP6HZ3Cf
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso94850a12.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983856; x=1793588656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFY6aWaZUBbFSs8gQiCy8TeBtr7IAp11DL47hLwXjC4=;
        b=DP6HZ3CfYR0u0/MNl2Kndd76KmNb1m18FPk5qC7sE2uWJCWBqjYY2N4PEdciKLEGhb
         XYrz3/hIfIJesKtnGWSD/pYocNNNMQ99CY7WJBbDhV0k6uZWkNWnE64KiVZqYviY2WG+
         IKxKx02LJTyTDsoVn0TbPT0r4BIPRqZMFVp3VgCVpSLKaQ6fG3hy5zpkldPU9yIdso9x
         4ICtbWIgKF2XK99lMFqGSp1k5Q7bNZn86qN9USlY06W6iJzPud3IXtYrzHBjJaFp711L
         0tW0pMi1S2Ps47k/tmNgE4A/vj13TbMpK3rNzTDzWA5z+9c0pCZbgWoeZcUU0bY2YFQ6
         58xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983856; x=1793588656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MFY6aWaZUBbFSs8gQiCy8TeBtr7IAp11DL47hLwXjC4=;
        b=hbShLVm6AvJLyHvLKDHPJR+uDa06HNLyocq+911QKOc64T1vFA+M0eEBeXmEBiV/A2
         DL8pawTroR2lvHtLYfTFNe6Pv3Bguwc1hXvS4TTfrat3Cdz/AOB3LXx0SnujRk1xaqWy
         jTPWq8pLBFC6ovFj5K8y6tBta7ph2IrTcSREZTJZMlFId8qIAqmx9nByVLamJFVujsJt
         KtFWZICYpTAsSc5WE1x5gdoRgnpIcyToL0V+uCSVVjMKXfL8lmjuaIoZ7UtUxNsqgaY5
         6im9lLJZd4oX/s/Dlq9iT5XJTtfNm4i7ma2a8YTvYZCwhsor8ZHpV3TqTxemHufbc/eO
         92dA==
X-Gm-Message-State: AFq9FYLIvEOEhbGar5aGiA1jhJaNJYJM6RL8xrrOBO7WtMcx14fxl5ee
	uTevShYC0gM8SdjHo6GyzG2cvqPtJ3VF+9i2Jnwppu/iDhpFYIQpAKWmwQVCXA==
X-Gm-Gg: AYBFou3G7e0U5eT1SaBSxxdxjBDeBVJGFSOHojmZ9zy01Dpm8CV+Bf6HdspNUMkhqrS
	RIy4WiUPtx6edS0qShNJTW2DPjMxjDpFVihsXPpPCjfnZWyAhNRi+FfLmTQ3HdWSm3HRi1AYO0o
	/tZWQlnxLPR02BDeD4L+JcCuD+dwCXom26b83rTzTyVrRG3Jw/J2wWoPic6quvUjKhbBoGHmRZE
	qVw89Ahy30DYnWevUAcazM2okLH63syXLYe5RKRhLmqsy81MUU6v0aRAGkgBSBuTe1s3wMFkwbi
	nb/jREwoXs1I0/069+Yi5j3Zm8fNVn8oyLEU9fuMEmjzb+QX/w1Ijz+/83yCx7DWJbG5P2FV4mn
	v2VUgGeNGW+mx8wG+Nq9w7TLOECG1c1rDJ1wty0ISpbgnirjPrbS7U9av9hLnAvZQ7+XGgT/wi6
	xlM2wjExJ5h4bk1+8Qn7SJKB/9ikYQIZT13ySzdI5sIv+cjq+QRp56DbY/LE4e0b7+dL62OCJup
	ofb2H+oiNK261JB9GEctHypY7dMfbM7FnGIpqeWksf2ombT8l/5QH9KJuRcfd55sS7/9RDtG5nK
	i06qV5AYLqtoho/+SCn9h0kaq8KZaDC+1jRuketHXlPJ5yeZ7xKZMhjipyF7gm0Xhkk5MIH/QfI
	X8HMyDgrKNNpWB9QhbZxgUbXHjl9oCFgCveU/tYgdjh9qjQ==
X-Received: by 2002:a17:90b:2f90:b0:3ad:50ef:f5ff with SMTP id 98e67ed59e1d1-3adeafa0efcmr4557826a91.37.1792983855644;
        Sun, 25 Oct 2026 20:04:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm6318957a91.8.2026.10.25.20.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 46/81] bpf: Finish the insn in the state that maybe_fork_scalars() splits off
Date: Mon, 26 Oct 2026 02:59:07 +0000
Message-ID: <20261026025943.404450-47-alexei.starovoitov@gmail.com>
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

When a register is -1 or 0, maybe_fork_scalars() splits the state in two
before an 'and' or an 'or' with a constant. The result is more accurate for
each value alone. The verifier continues with -1. It pushes a copy of the
state with 0 and verifies the copy later, from the same insn.

           today                              this patch

  N:   r1 &= 8    r1 is -1 or 0      N:   r1 &= 8    r1 is -1 or 0
        /     \                            /     \
    r1 = -1   r1 = 0                   r1 = -1   r1 = 0
    r1 &= 8   push to N                r1 &= 8   r1 &= 8
       |                                  |      push to N+1
  N+1: ...                           N+1: ...

At insn N the copy is a part of the state that it came from. If pruning
compared the two states, it would drop the copy, and no one would verify
the case r1 = 0. Today that does not occur for one reason only: the first
state has branches that are not explored, and pruning does not use such
states.

Do not depend on that. Do the insn in the copy too, and push the copy to
the next insn. All other code that pushes a state does the same.

No verdict changes in selftests, Cilium and scx. Each fork processes one
insn less, and the sequence in which the verifier explores states changes
slightly. 68 of 144 progs of Cilium process a different number of insns,
from -4.8% to +3.3%. The total is 1151838 -> 1151493.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f065e7e829c6..b44a5c63a922 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17372,11 +17372,14 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	}
 }
 
+static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				      struct bpf_reg_state *dst_reg, struct bpf_reg_state src_reg);
+
 static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			      struct bpf_reg_state *dst_reg)
+			      struct bpf_reg_state *dst_reg, const struct bpf_reg_state *src_reg)
 {
 	struct bpf_verifier_state *branch;
-	struct bpf_reg_state *regs;
+	struct bpf_reg_state *reg;
 	bool alu32;
 
 	if (reg_smin(dst_reg) == -1 && reg_smax(dst_reg) == 0)
@@ -17386,19 +17389,25 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	else
 		return 0;
 
-	branch = push_stack(env, env->insn_idx, env->insn_idx, false);
+	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
 
-	regs = branch->frame[branch->curframe]->regs;
+	reg = &branch->frame[branch->curframe]->regs[insn->dst_reg];
 	if (alu32) {
-		__mark_reg32_known(&regs[insn->dst_reg], 0);
+		__mark_reg32_known(reg, 0);
 		__mark_reg32_known(dst_reg, -1ull);
 	} else {
-		__mark_reg_known(&regs[insn->dst_reg], 0);
+		__mark_reg_known(reg, 0);
 		__mark_reg_known(dst_reg, -1ull);
 	}
-	return 0;
+	/*
+	 * The insn is done with in the branch too, and what gets to the next insn is a state
+	 * like any other. At this insn the branch is a part of the state that is looked at:
+	 * it must not be compared with it.
+	 */
+	clear_scalar_id(reg);
+	return adjust_scalar_min_max_vals(env, insn, reg, *src_reg);
 }
 
 /* WARNING: This function does calculations on 64-bit values, but the actual
@@ -17503,7 +17512,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_AND:
 		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg);
+			ret = maybe_fork_scalars(env, insn, dst_reg, &src_reg);
 			if (ret)
 				return ret;
 		}
@@ -17514,7 +17523,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_OR:
 		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg);
+			ret = maybe_fork_scalars(env, insn, dst_reg, &src_reg);
 			if (ret)
 				return ret;
 		}
-- 
2.55.0

