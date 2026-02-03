Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279D378830
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137486; cv=none; b=Ll+VJoGCirTmBXDELpEwkjNWg+ojTCxFzUcC2M852oFckvV2j0bOHaeRtn6q3Yqv+fHscwmJ3M5cpr8SD3lwc60+Z05FN2YE0GJ7f4GGLPx9qetQBQn4lVjPOlKRuSpyQWaxBCktf1ty65P9kIgt5YThOyJ11NUTmDI8EDrjRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137486; c=relaxed/simple;
	bh=TJEIoSQaA6vpmeda6hsnIhgd81BSJmFAXhCPx0lgB+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lInFd1Q8CiiB+FvBm9BCJJIOXn/a/CZpMsa/JPwTn8V7r/96QCnIvYK3jt/GjHsBlOYZIAQ7qsCLgNSwOksuszvgQNRiJAH+DEx9d9BbUzgbC12U4UKz7TQT655u+rMLME3SGC2BtwzFu/A0+or/RtPSCcRDPsbBXhbdvbz7pJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C085MorL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C085MorL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9B3C116D0;
	Tue,  3 Feb 2026 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137486;
	bh=TJEIoSQaA6vpmeda6hsnIhgd81BSJmFAXhCPx0lgB+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C085MorL4+baKVuDHol+Fh7QCKFKmG0y5QLefo0aFHB3gjPh8jhn+vqemcUW9Jdxo
	 UTLUAbY6IDwvf1gdkvtmzxZ0PvKWKtt4h7z6WAUe/2yOhX7VK32NtseZ+7vDjuAJ5F
	 9IgGEjiVq3I8Cbx/nfj7x2B7mAR+ymRnvy2v+I/JJ9e2Uf8CxbeKNS/RAYiL7+WBCW
	 RWFsIc8NIxLKDloSlQ8x0pBpaeuD+wZIyFSEV9gwrTPF3HQcobjL9heNHQiBZoYYBP
	 pd7a6/XPPA16dBkNsFJ8+EOLrItkP2U8gokhY/+a7/q9gBaXgdl+uovvYepk8x+VrV
	 GJQNfp8iqQwpg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v3 3/5] bpf: verifier: Relax maybe_widen_reg() constraints
Date: Tue,  3 Feb 2026 08:50:59 -0800
Message-ID: <20260203165102.2302462-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203165102.2302462-1-puranjay@kernel.org>
References: <20260203165102.2302462-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maybe_widen_reg() function widens imprecise scalar registers to
unknown when their values differ between the cached and current states.
Previously, it used regs_exact() which also compared register IDs via
check_ids(), requiring registers to have matching IDs (or mapped IDs) to
be considered exact.

For scalar widening purposes, what matters is whether the value tracking
(bounds, tnum, var_off) is the same, not whether the IDs match. Two
scalars with identical value constraints but different IDs represent the
same abstract value and don't need to be widened.

Introduce scalars_exact_for_widen() that only compares the
value-tracking portion of bpf_reg_state (fields before 'id'). This
allows the verifier to preserve more scalar value information during
state merging when IDs differ but actual tracked values are identical,
reducing unnecessary widening and potentially improving verification
precision.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92e10d4c2cc..dfb9fffbd141 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8995,15 +8995,23 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
 		       struct bpf_idmap *idmap);
 
+/* Check if scalar registers are exact for the purpose of not widening.
+ * More lenient than regs_exact()
+ */
+static bool scalars_exact_for_widen(const struct bpf_reg_state *rold,
+				    const struct bpf_reg_state *rcur)
+{
+	return !memcmp(rold, rcur, offsetof(struct bpf_reg_state, id));
+}
+
 static void maybe_widen_reg(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur,
-			    struct bpf_idmap *idmap)
+			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur)
 {
 	if (rold->type != SCALAR_VALUE)
 		return;
 	if (rold->type != rcur->type)
 		return;
-	if (rold->precise || rcur->precise || regs_exact(rold, rcur, idmap))
+	if (rold->precise || rcur->precise || scalars_exact_for_widen(rold, rcur))
 		return;
 	__mark_reg_unknown(env, rcur);
 }
@@ -9015,7 +9023,6 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 	struct bpf_func_state *fold, *fcur;
 	int i, fr, num_slots;
 
-	reset_idmap_scratch(env);
 	for (fr = old->curframe; fr >= 0; fr--) {
 		fold = old->frame[fr];
 		fcur = cur->frame[fr];
@@ -9023,8 +9030,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 		for (i = 0; i < MAX_BPF_REG; i++)
 			maybe_widen_reg(env,
 					&fold->regs[i],
-					&fcur->regs[i],
-					&env->idmap_scratch);
+					&fcur->regs[i]);
 
 		num_slots = min(fold->allocated_stack / BPF_REG_SIZE,
 				fcur->allocated_stack / BPF_REG_SIZE);
@@ -9035,8 +9041,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 
 			maybe_widen_reg(env,
 					&fold->stack[i].spilled_ptr,
-					&fcur->stack[i].spilled_ptr,
-					&env->idmap_scratch);
+					&fcur->stack[i].spilled_ptr);
 		}
 	}
 	return 0;
-- 
2.47.3

