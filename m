Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983974;
	b=aHZdveSWIPz8z5jxgDmqfttyhZjLc81kp602AwuTuc02BRj89k3T7MUuAhV1SS84kVAP
	 u7wylYDMEURR7VKBfoJ469gfWs+FuT2uBLNcjdpeTXXAkYeG5amYJZkYBnXS6Pa55SIhB
	 60hicg3L66iBYSc/7SRE8G+7FVNyZlUnJkLf3tnYTIifvGHxNBb208mfQLhMIS6I9HZVo
	 IJP9CStvSwM69d8oJoGuaHqMCkcvueg5q0U92yBi7RoNFWtcoZRnCUuJRdU2zpqSAR0W3
	 UApFz4X5N4YTK+b/KdX7NDAgpCyNKUeKVt2LvYNICivU/yVNYkUpR24huw5zBXFjYSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U7hujXAEy0UHcP0/9JKOkmRTmDQsSvqPL8aMqoGCr+o=;
	b=PXFQn8IWO50nzgYA1ShGWqfiBKn+K+gMSSLEWjiSvPUqnLjdm5S6rVORAPXLi8IhyzyI
	 mPQWElIRwGXKDdd4SXrN/XvpzVSzxyhQWyc+CbMlmD7AnJ2bOppKnd73kjobWaGb/LCrf
	 AykqYYqd0gzqwh29LLmo42IFG+RR7rvx3bCYI1xRNkR/JAVNLc1uDo/Kq/V5+iQ42rmMD
	 zVVLVwbiQLcQ2JiA1icCVKQ7TJh7K6F9tcBRLWcdPBMQ6zlm3Xa/0Cy7PRA6ON94VAeWo
	 h3kIPh9Yzml7vCAreTGOAH9YcxKzDaKkvDlgOieKM3oX2DlELwWM/deyVeWiP+cvSrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rAOdBM7O;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7A606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F7A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rAOdBM7O
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1041966b3a.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983973; x=1793588773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7hujXAEy0UHcP0/9JKOkmRTmDQsSvqPL8aMqoGCr+o=;
        b=rAOdBM7O7A52QUoBQseiaTV3bZVCCz1e34aWkSElhM8TbKmKn1lQN74ZToQuJGwP4t
         9UoWtdRzsyDESpxDceE+XiD7GrYEKR3+MBA278KKwRK1Rvacg5dapceJrPfJRBAvliGE
         ARuzFoespsaD5u5ipSOT8zdchw4qKNvhsjx2cHAQFo3sFW3D1hWFF6AwZtXJd+NVvjxL
         WJj0SD/g7asNimPjOB1+Q4j0ACSWf/Q0CihCK22RCEKUoxWHJxvPHhmojkpVhZWulwR5
         MRaA1RMrFf5fGj5IsCZVr76gmuDk2Mqz76DfkOiwrnJfek+LSmjtBH67BUipUpiK7yNk
         9yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983973; x=1793588773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7hujXAEy0UHcP0/9JKOkmRTmDQsSvqPL8aMqoGCr+o=;
        b=IjBgRxavbyNaoZdZsnvT50wU8zo/alR/pkGEMQT++kZm6lP13P/E36Pk4MqUVuqfcm
         pI15HOCa9Mu3Pv99IBXnJiUv0IPiRycrG9uxu2Y8OROPmWNQ426c5K13pv5MNQBLCLh2
         ZROmBCVfi3Y+58lev2hjMqCA8C3FiLUAEESTq5R6bQwZ0tfFRmUs3fEl6NdjGnbNP7aM
         YWoBRpQfbv8CMy2sESjqXKTMJEraaNjJSZRFrriwHQ6klx0bR4N6lR/D1RERSsTJhxqs
         2F5Zr2NlNwlglQW9dHGY+4zaUFmHIUROVbZgIReBtfMjVHuaOksdAFcqBGONGqoQcoZN
         3MVw==
X-Gm-Message-State: AFq9FYKRdsBY5tfAtIUAbvM9fRTpvc9pvSzpst2xb4aMPGd+5TDC47Nz
	eHHlLlycAPxONMXnsAL+kga/YTv7JtCtoE17zOpLpZICXtcBNznyH0W1uMO/fQ==
X-Gm-Gg: AYBFou1tRhfhYjj1vmdVSs81BNS1mW0DcFDqga7dKfT1zKmE9WHcfpp+vhm+xfdnxmG
	RlBE/wZDot3cWZf6Y/sYJ1gXFjvXYeEvgNAv7DNF5U7gMYg8KCCtoIsQbGNeNQEYsV3DhjVkepo
	LJu90KcHjOWmreTswNgGvs+dbnWyU0rv6TXJwtX1iiruJ6atammb0PzUBNM6Dryud/dqAmpI5eA
	fjhQL8ZgH/QsrBuWa+SosSz20z+yNEvZfk/G7+TGr41u0wfm+9v9npbl1hyGZ7S34yR3GWG4Ubp
	iVDtlERs4TVDqE0y/W7czNLgtUweiM1RguTD1bVqz3d1PTkrSjfSOMlKT/KsTDPHvp+/MojKlS5
	g0Gy2mISweNMTSwdHnwfzXRq4jpeEHQ8qFZxCBMuX0eDVeDhlNVtqDEtXxQqIhpRVOfj7eMaxwA
	xIA64BZBHh2rVCQHW7Ib07EuVaNghqQbYweV0EZahiSc19m//VNjgwpZMaXRMQHZFNsOEcLMq+K
	+5WVQlMWHZmxIA9Eb3C9a74+vvkDIGaGOjwbp5kEKOfkmMTVduLpy2kip2Ho3t7smHLVHSjRRQ9
	UQUM85ZIyFhW6hXZ8IVXQd9/Km6NDy/O1shOYeDYSFHNuKmCSIXlsXq0ja5lEyyDPfUM5ZldvBT
	xRnY5GZCoI9QA2oBJ9yEhJDB8nA==
X-Received: by 2002:a05:6a00:853:b0:8a0:8848:8c28 with SMTP id d2e1a72fcca58-8a364f5a23cmr3963450b3a.2.1792983973145;
        Sun, 25 Oct 2026 20:06:13 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b37287bsm814952b3a.25.2026.10.25.20.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 66/81] bpf: Remove iter.depth
Date: Mon, 26 Oct 2026 02:59:27 +0000
Message-ID: <20261026025943.404450-67-alexei.starovoitov@gmail.com>
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

The state of an open-coded iterator has a counter, iter.depth. The verifier
increments it at each bpf_iter_*_next() that returns an element. The
counter had one user: the check for infinite loops in is_state_visited().
That check rejected a prog when a path came back to an insn in an identical
state. In a loop with an iterator this is not an error, because the
iterator stops the loop. A different depth told the check that this is a
new iteration.

"bpf: Remove is_state_visited()" removed the check. The comparison of
states and the join of states ignore depth. Remove it. The verifier log
does not print "depth=" for an iterator.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 4 +---
 kernel/bpf/join.c            | 1 -
 kernel/bpf/log.c             | 5 ++---
 kernel/bpf/states.c          | 7 -------
 kernel/bpf/verifier.c        | 3 ---
 5 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d02f6938c2e1..f46963591e18 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -104,9 +104,7 @@ struct bpf_reg_state {
 			 */
 			struct btf *btf;
 			u32 btf_id;
-			/* packing following two fields to fit iter state into 16 bytes */
-			enum bpf_iter_state state:2;
-			int depth:30;
+			enum bpf_iter_state state;
 		} iter;
 
 		/* For irq stack slots */
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index dde40dc4ff4f..477fe159811b 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -346,7 +346,6 @@ static bool join_special_slot(struct bpf_join_state *js, const struct bpf_stack_
 			return false;
 		break;
 	case STACK_ITER:
-		/* iter.depth is not a part of the state, see stacksafe() */
 		if (ra->type != rb->type || ra->iter.btf != rb->iter.btf ||
 		    ra->iter.btf_id != rb->iter.btf_id || ra->iter.state != rb->iter.state)
 			return false;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 1c7a13bfee87..0013ab01e72d 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -767,11 +767,10 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			if (!reg->id)
 				continue;
 
-			verbose(env, " fp%d=iter_%s(id=%d,state=%s,depth=%u)",
+			verbose(env, " fp%d=iter_%s(id=%d,state=%s)",
 				(-i - 1) * BPF_REG_SIZE,
 				iter_type_str(reg->iter.btf, reg->iter.btf_id),
-				reg->id, iter_state_str(reg->iter.state),
-				reg->iter.depth);
+				reg->id, iter_state_str(reg->iter.state));
 			break;
 		case STACK_MISC:
 		case STACK_ZERO:
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5487987b2441..91c3a23b6e12 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -501,17 +501,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		case STACK_ITER:
 			old_reg = &old_slot->spilled_ptr;
 			cur_reg = &cur_slot->spilled_ptr;
-			/* iter.depth is not compared between states as it
-			 * doesn't matter for correctness and would otherwise
-			 * prevent convergence; we maintain it only to prevent
-			 * infinite loop check triggering, see
-			 * iter_active_depths_differ()
-			 */
 			if (old_reg->type != cur_reg->type ||
 			    old_reg->iter.btf != cur_reg->iter.btf ||
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
-			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
 			    !check_ids(old_reg->id, cur_reg->id, idmap))
 				return false;
 			break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2e46287deb08..17a9d1bf5318 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1053,7 +1053,6 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		st->iter.btf = btf;
 		st->iter.btf_id = btf_id;
 		st->iter.state = BPF_ITER_STATE_ACTIVE;
-		st->iter.depth = 0;
 
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_ITER;
@@ -8703,13 +8702,11 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
-		queued_iter->iter.depth++;
 
 		queued_fr = queued_st->frame[queued_st->curframe];
 		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
 	}
 
-	/* switch to DRAINED state, but keep the depth unchanged */
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
 	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
-- 
2.55.0

