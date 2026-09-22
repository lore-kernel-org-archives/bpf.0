Received: from mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE111285061
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039051; cv=none; b=pIq3QOyWAu+IcOXCiTymsv3r9g9miEfcNqyUkP/h/cGrH4Dvz1jPODlC3ot8yZMINScg89wydN7onAdbz7FyV6+UAqgELhnlbVNQJN1I2c2w8s+4m9OpbomWWVlBFY2/zojoV/pe66F14+dUZqntxFLM9aUcwVlGOw76fuEsVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039051; c=relaxed/simple;
	bh=BZocnogs0CgdLwdI0RpXwNe1/4+SbNzNm3pVU9Fn/kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBWj0ySKhxwqLVZtAy4h6CZWkNYdB8hP0aNfylZFnbxp8kRjgphHSAZvrc79op+5ewh0NBrb7nowNC2+2rbH0utbBCvj/ajvlpRz1oTNXbYQKM7rku1/SlQs371KiwI5xPrAfVOLFw1EckpcsuS6KARtQMtLWdwf8JGf4ugzobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HMXR3sCx; arc=none smtp.client-ip=91.218.175.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HMXR3sCx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BZocnogs0CgdLwdI0RpXwNe1/4+SbNzNm3pVU9Fn/kU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790039047; v=1; x=1790643847;
 b=HMXR3sCx5v7J29GB7uodGr8n+vrP9R0UB9qxGFjCfzi8bT23dimfxvUdVtkXKIeCEqpzSNKq
 uEelYB1haW5wLh4hL8t0b1UGvRmH0jVlH4lBBPiXtvkeBZzGJxJ1nXvaPXQ5ZINBawpN5jCaMyX
 0NLTLvWg04LvkLoz8XluOsAY=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 15fce196c86a403b;
	Tue, 22 Sep 2026 01:04:07 +0000
X-Mizu-Trace-ID: 15fce196c86a403b
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/6] bpf: Name the callback in frame-release diagnostics
Date: Mon, 21 Sep 2026 18:03:30 -0700
Message-ID: <20260922010333.1226537-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A frame-owned reference is dropped through the same descendant walk as a
program-owned one, so a program that uses a callback argument after the
callback returns is told "resource release invalidated this value".
No resource was released, and nothing the program did caused it.

Add __release_reference() with the reason parameter.

The message names the callback rather than the frame because a
callback is the only thing that declares a frame-scoped argument
today, and it is what the program author recognises.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/diagnostics.c |  3 +++
 kernel/bpf/diagnostics.h |  1 +
 kernel/bpf/verifier.c    | 18 +++++++++++-------
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 5ecfa86ed49f..0610c3f6b334 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -2233,6 +2233,9 @@ static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_h
 								   "resource release invalidated "
 								   "this value";
 		break;
+	case BPF_DIAG_MOD_FRAME_RELEASE:
+		reason = "the callback that owned this value returned";
+		break;
 	case BPF_DIAG_MOD_PKT_DATA_CHANGE:
 		reason = "packet data may have moved";
 		break;
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index a4102fb049ec..b5cab4d79c1a 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -22,6 +22,7 @@ enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_SPILL,
 	BPF_DIAG_MOD_VAR_WRITE,
 	BPF_DIAG_MOD_REF_RELEASE,
+	BPF_DIAG_MOD_FRAME_RELEASE,
 	BPF_DIAG_MOD_PKT_DATA_CHANGE,
 	BPF_DIAG_MOD_NON_OWN_REF,
 	BPF_DIAG_MOD_CALLER_SAVED,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9775a6d38d3b..ba0c8c27b45f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10169,7 +10169,8 @@ static int idstack_pop(struct bpf_idmap *idmap)
 }
 
 /* Release id and objects derived from it iteratively in a DFS manner */
-static int release_reference(struct bpf_verifier_env *env, int id)
+static int __release_reference(struct bpf_verifier_env *env, int id,
+			       enum bpf_diag_mod_reason reason)
 {
 	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -10224,14 +10225,12 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 
 				if (reg->dynptr.first_slot)
 					dyn_stack--;
-				bpf_diag_record_scrub(env, &dyn_stack[0].spilled_ptr,
-						      BPF_DIAG_MOD_REF_RELEASE);
-				bpf_diag_record_scrub(env, &dyn_stack[1].spilled_ptr,
-						      BPF_DIAG_MOD_REF_RELEASE);
+				bpf_diag_record_scrub(env, &dyn_stack[0].spilled_ptr, reason);
+				bpf_diag_record_scrub(env, &dyn_stack[1].spilled_ptr, reason);
 				invalidate_dynptr(env, dyn_stack);
 				continue;
 			}
-			bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_REF_RELEASE);
+			bpf_diag_record_scrub(env, reg, reason);
 			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
 				mark_reg_invalid(env, reg);
 		}));
@@ -10240,6 +10239,11 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	return 0;
 }
 
+static int release_reference(struct bpf_verifier_env *env, int id)
+{
+	return __release_reference(env, id, BPF_DIAG_MOD_REF_RELEASE);
+}
+
 /* Find the first reference owned by frame @frameno, or 0 if it owns none. */
 static u32 frame_reference_id(struct bpf_verifier_state *state, u32 frameno)
 {
@@ -10265,7 +10269,7 @@ static int release_frame_reference(struct bpf_verifier_env *env, int id)
 		break;
 	}
 
-	return release_reference(env, id);
+	return __release_reference(env, id, BPF_DIAG_MOD_FRAME_RELEASE);
 }
 
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
-- 
2.55.0

