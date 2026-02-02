Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126735BDB8
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029104; cv=none; b=V0R9tRCMPw5UJ0INB9KqQ4TjS0pGRjAiOWjRjAmXfKowFMhPt4jERagwwFFGmTV4uokYimsG2ya6QKylucFD6MI9jA1YeIJeB7XY+xi89iBGinq6xHwyOIdNTDUTadR0T8qrIDviRuWHDkQx38bTpzV0hKENN7dl+9nUY8rMIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029104; c=relaxed/simple;
	bh=0YOOWOa5EH3TRq6bvNh9BUbAeyNKIMD/m6Et7m7IHOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4vPGAE/jbmkSUEJVpgVeztNeJdpSIz8Mel713gY01PudnTMuL2LJPaKMLgH86vcoKJsMEqrGx3rfBdy/6vtZvgAyNTpHG9Cjp/T5YNmI1p0eBDirqmwPJBPdGaYORommfqHWCx17ssywxWJXo5t+U78CQyHs2FoY1PvFwud9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBySo02v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBySo02v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF6C116C6;
	Mon,  2 Feb 2026 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770029103;
	bh=0YOOWOa5EH3TRq6bvNh9BUbAeyNKIMD/m6Et7m7IHOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBySo02vjEr6hqXDvLwSarjkNLuSxEpRIniW99JpE1r1rj0pWbRM6M6HbdUr2961s
	 ZWTydV7YxDyLlSvZFm7+EmNcK6GSYMeePKrBppxE29Y2EIYPxuDlVfLxYgaaXqdOHl
	 sHGXn1MJpE8ATPjzAw9ZJZUA4TE4CGnGic/3QChP8DRv+F/v+8lOkHhAcYyfPeSiaz
	 La4KVhcNZTbs34aIMhJAi+69AhQZL6F4Ih2glhLT6f/IPhMsCwQ1pY+ID34LYubsal
	 MsLpYsLNor6tUJbUENDxb4ZaMG4VO7juTzIAkUNXhwUR3/X3LcVSgzw91os6jQ963m
	 Nr8w71VAozoyg==
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
Subject: [PATCH bpf-next 3/4] bpf: verifier: relax maybe_widen_reg() constraints
Date: Mon,  2 Feb 2026 02:44:05 -0800
Message-ID: <20260202104414.3103323-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202104414.3103323-1-puranjay@kernel.org>
References: <20260202104414.3103323-1-puranjay@kernel.org>
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
 kernel/bpf/verifier.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9324d96aae92..9c14dbe7c10d 100644
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
@@ -9023,8 +9031,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 		for (i = 0; i < MAX_BPF_REG; i++)
 			maybe_widen_reg(env,
 					&fold->regs[i],
-					&fcur->regs[i],
-					&env->idmap_scratch);
+					&fcur->regs[i]);
 
 		num_slots = min(fold->allocated_stack / BPF_REG_SIZE,
 				fcur->allocated_stack / BPF_REG_SIZE);
@@ -9035,8 +9042,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 
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

