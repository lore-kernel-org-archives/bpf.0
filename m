Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160757;
	b=D/dsVgvPqhe5sJ17iYP3qMeFHp1n0YZHJigpCmjK8LK8qSJsrKbc/sQ8JyBKHuGWRDnG
	 U6LK01ByhwAJZCQ8ysubEKe3MA2nITAduvRI8nY4Rky8UCUKhKeCfE1EluP26etPZbCnm
	 3tnfTXjJT+7Cs7jMG4yg0XEdUjASllkTKfkZtwPYN8BGQx5EwKiaIS1QT4fyEWy77sSOn
	 M/RTeizYb0z1mK6MJyTEuORlYZ0O4AAaMiywEBPhIv54ypkjpkw9KGJ2A9OfoATn7bPuE
	 n+kV8HYW20uTHnhwd4O7uwSNFjCva7g8G6AmddoUocqskuAEf2cEes41imqtAoLOfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7nuE0OicGT6skQx+efq859hcfBQbiiBXDjZoYyFs6WY=;
	b=t7YJ7BocBR3vJM2iEIQdxWjSJoHYvsPtBAXnXPpDApxYcuB2/Zits+UL+1Gy3DwrQP6S
	 Y6ZrkFh0c5ijJ3EeIziirOhI5QOS/0k6inEJZCD7PMNsoDUQ3p3sVaaaFHJIzbrT0nXgh
	 4GDz5r9quaPJBq+eh/V5eefA1zwQzd8PhubsHqooWwKGpg6zetP5EcNNWR3mfiGXHDE28
	 If5ysrTyMbEDw221hy44GkdyLIJ8dmu2B1TBQgA9kvfKsIBXEjCuTHugU3mEiNswaaztt
	 x4u9WKiZtdDDy03ibujBxUkpDnSjtdJiQ38QXv+KLb7B3J2cWh6NBPq9Xvh3rD6sCdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKIMIBqG;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C83606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C83606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKIMIBqG
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso441486a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160756; x=1795765556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7nuE0OicGT6skQx+efq859hcfBQbiiBXDjZoYyFs6WY=;
        b=qKIMIBqG2jsuOf95ONBAiFfSu0jnHqqPQ1rmTy6WJ1X/F4k0LuCkOthAcdPi2A1C/c
         MbofUXXiJ1hcYkaryEtS86OLHw5hrfJXtpOAmW+nQw/q8zc6ZtpS7xJvA50SstBsxr8F
         D2GJOC3xu6URs6D+FC6dT3TYHB/QPZu7T7mnXyWHjjo/RlkvjdKuGqwlYgvt4o5MWt4E
         ZiNmTxa8l7ceqnv1fuwetZudIFpBJtvS8inEiCIlBAHIPV4C/bzfCxi0QuVFO+Ai0NOZ
         36fXJgjXnF258x7uXVLpcSYrVVd3fAhJvTaPkI4hiSS8wTcPi2KrWIlYyF18vc+xodk0
         48gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160756; x=1795765556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7nuE0OicGT6skQx+efq859hcfBQbiiBXDjZoYyFs6WY=;
        b=2QLAXtOLK7zp1uSNKe5Uaz73Rm65Wbp2jfnhmOPar/eOj23AV/yaItNEj4s+A0GEln
         HX6sstJi9xO7v6OReM9kOmaTH2gV5UkObDs/oU1jjWNyZJ7EQrBvPrmeTosWr+H9Ye+H
         y8uCOVJLp9plNyQWpiJpZqFZ8aj+nXcZLQkkYLWLSgf1yFDEjLbXqEEATOgP8pF6oqQP
         /4KeMpNFxZa36RUeE78WBXbaHzOR8LStji2ZmRHf/Zv34sOeQU/jbpzXdMBfwBCzbb28
         WWK7fjVX4UgZN1e84yZDwC6Exg0p+2KDj81b+ymeq2bBxI9xQNULgjfK/uYTM33aFXT+
         K6jA==
X-Gm-Message-State: APuU4Z9IjY0+SD5J+nTXcdzVyd8dPwyzXSpByLqTJMRzyOUTCHMksaiD
	hWT+eTOppKORZtVM8KhDvEeu7JDP0A0FbajqUrIJlIn8QBbFd3Iwo8L8sgHknQ==
X-Gm-Gg: AZFdTZcRzISYut3SxT2eXSmfJSCkKSzLk0Ix0ZEcUDvy396ANHywDDULbAzdW/0MdGc
	R9NGsKXI/UVV2pj3mCHDWvU2ofwBZ0vJO7fWAHzUjgtDRQSaupT/73QMAz+e1QEXIM+4dRli2X/
	UZcGp7hbak6sJRjKYNtm7JJRDh+bjXmG0q4XDJUh7aS9LuaFTM4+1e24zZW4s+FjkYRoveik6Ak
	3GLMft62ciAeGcrt4a4E41z83I3/r6QfdLFdk4EWA235/rnd2mRpIKGUh3D93rss5lJRvGKFkGU
	7A1AuDAiyrAiGslzUaMtcIc9mdq4B0s++3lMVEZbImmR+qGJRvvTW5rKXTEzTY8fxkI7eiQl+mI
	vJq7vPtzWACGw0ABEiAgMM76wId5smpk/yEhLiEm/iWtHEGws3kkNaSum0zBxrJTXH6zlm8Fhr+
	nzwU8Cy0GenVCePeNNCbP1HVf22vDBlriNR7MWE/YeXm1ZD9yfLxgoxqI6G0cfOA4sypi6a7GZP
	1xE3SmgxOFwE3H7VhFEQP1Dx0S+6MSAVKtGQYoDs9x2Z5VhXCai4ahaS5W8GuTd07AG3f30xkO8
	/DjIigddJlPfqHhQKGH1wvVS1BaX46/dwrlk2pxrT+wMOsLSdeDssLFf06Z6WESXghIo32xTurt
	Wcu05bmZRziJk9WsOxZQNOHO9HHaSZ5xuZLsB4T/Y8QW7yBd8P6h25ag6O41OlYW+SFbhfijzsG
	I=
X-Received: by 2002:a17:90b:2c86:b0:3ac:9c37:9430 with SMTP id 98e67ed59e1d1-3b41c9b2bbfmr1992039a91.21.1795160755973;
        Thu, 19 Nov 2026 23:45:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfbaf2bsm1294249a91.2.2026.11.19.23.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:45:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 14/49] bpf: Mark a state that no run of the program has
Date: Fri, 20 Nov 2026 07:41:46 +0000
Message-ID: <20261120074430.2704488-15-alexei.starovoitov@gmail.com>
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

A jump can leave an xreg without a value: the ranges and the known bits
have no number in common. No run of the program has such a state.

  jump -> range is empty -> infeasible -> a pass:              continues
                                          a run without joins: drops it

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ed15e63456f..cc90e237d53 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -522,6 +522,8 @@ struct bpf_verifier_state {
 	struct bpf_reference_state *refs;
 	u32 insn_idx;
 	u32 curframe;
+	/* an xreg has no value: unreachable. Only a path-sensitive run drops such a state. */
+	bool infeasible;
 
 	struct_group(held,
 	void *active_lock_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8377d15b02..1523ae1be51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1808,6 +1808,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
 	dst_state->unwound = src->unwound;
 	dst_state->changed_pkt_data = src->changed_pkt_data;
 	dst_state->flow_entry = src->flow_entry;
+	dst_state->infeasible = src->infeasible;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
 	dst_state->last_insn_idx = src->last_insn_idx;
@@ -2437,6 +2438,7 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 		reg->base, reg->step);
 	if (env->test_reg_invariants)
 		return -EFAULT;
+	env->cur_state->infeasible = true;
 	__mark_scalar_unbounded(s);
 	scalar_step_reset(s);
 	return 0;
@@ -18947,8 +18949,8 @@ static bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b,
 
 /*
  * The values of @dst and @src are equal in their low @bits bits: @dst becomes the intersection.
- * False: @dst is left as it is. Fewer than 32 bits say nothing about a range. Or the intersection
- * is empty: no execution gets here with these values, the path is infeasible.
+ * Fewer than 32 bits say nothing about a range. Returns false if the intersection is empty.
+ * Then no execution gets here with these values, and @dst does not change.
  */
 bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits)
 {
@@ -18957,12 +18959,8 @@ bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits)
 
 	if (scalars_fit_in_bits(dst, src, bits))
 		bits = 64;
-	if (bits < 32)
-		return false;
-	if (bits < 64) {
-		a = tnum_subreg(a);
-		b = tnum_subreg(b);
-	}
+	if (bits < 64)
+		b = tnum_or(tnum_cast(b, bits / BITS_PER_BYTE), tnum_lshift(tnum_unknown, bits));
 	/* tnum_intersect() of two tnums that don't overlap is not empty */
 	if (!tnum_overlap(a, b))
 		return false;
@@ -19000,6 +18998,7 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
 			      struct bpf_reg_state *reg1, struct bpf_reg_state *reg2)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
+	bool empty;
 	int err;
 
 	/* is_branch_taken() knew the branch before it refined anything */
@@ -19010,7 +19009,9 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * The fall-through branch of JSET forgets the ranges. Or this branch is dead too: the path
 	 * is infeasible. The registers are left as they are.
 	 */
-	if (BPF_OP(insn->code) == BPF_JSET || reg_is_empty(reg1) || reg_is_empty(reg2))
+	empty = reg_is_empty(reg1) || reg_is_empty(reg2);
+	env->cur_state->infeasible |= empty;
+	if (BPF_OP(insn->code) == BPF_JSET || empty)
 		return 0;
 	err = reg_bounds_sanity_check(env, reg1, "live_reg1");
 	err = err ?: reg_bounds_sanity_check(env, reg2, "live_reg2");
-- 
2.55.0

