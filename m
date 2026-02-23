Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D71EFFA1
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862629; cv=none; b=Q3nYmuvkcauYNDbLFD567vMxBt+DzzWMlHIooB8VhG52mqTY9vxwu3LhhWVj6TWElpl5NgVzfTZ4b+TKtCreb8t0uGKxtzRN0sebIO7otPipq2qcgh4Ya5gsRw9m07dL1eaFhR8wYC2FkMjnoOvvQrKpl9xvR7Y+L5VDrxYZv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862629; c=relaxed/simple;
	bh=OwoyLPEQ2Rt4/IHcX0SNL/8HAiWjpAOEfu35z+0Or2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMBU835IlxOkvgKG7Y6Kx0XUTsFeF9Pohn7twHIQcHA7AXHigXjP5CkxwGgfyvJm3a/dvzJqCRW7uBfxCLgHYmUhC7YoHbwxMwwuZZB2CEQB1iq8w/3uClsxTzPP6Tk9tLabWdQ62A3dC3FP/+voEJjdRj+l96/fcY/WRzzVDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4LUlL0g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4LUlL0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9156C116C6;
	Mon, 23 Feb 2026 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862629;
	bh=OwoyLPEQ2Rt4/IHcX0SNL/8HAiWjpAOEfu35z+0Or2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4LUlL0gy31puCuRXMGHh7WYjZPQaWp01MDxI/Dp5q1VyXv8w//ztJnBbUKA02sTr
	 gWyya4rfVCoNuuysfTuXGdOM/DH8sEtxAVJomgsR1cQHGjb4QVxDH3zUh2dqOKWB5q
	 nYYuG+OnU6t0bwnI3db24eUVBX5/DreSe9R68a4r9ssCt8PyhC49kqYB6U7JmFq9dU
	 oJrpAYM8hnfLjMndEfzOKTHP31OVyEzExQ4DwbNWCbNCwcEPZu750F2qIeOUZoneKV
	 /O5f/vyft7FjGt6jHT+KZUsi1iATngPIqmIjoANIYClagukMLCmpYSbl78wgT6E6OR
	 jufOJxGIfpN9A==
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/6] bpf: consolidate sleepable context error message printing
Date: Mon, 23 Feb 2026 08:02:50 -0800
Message-ID: <20260223160300.2109907-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223160300.2109907-1-puranjay@kernel.org>
References: <20260223160300.2109907-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_helper_call() prints the error message for every
env->cur_state->active* element when calling a sleepable helper.
Consolidate all of them into a single print statement.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3b652aa5f245..c6e7c438b0f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11574,6 +11574,19 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 	       in_sleepable(env);
 }
 
+static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
+{
+	if (env->cur_state->active_rcu_locks)
+		return "rcu_read_lock region";
+	if (env->cur_state->active_preempt_locks)
+		return "non-preemptible region";
+	if (env->cur_state->active_irq_id)
+		return "IRQ-disabled region";
+	if (env->cur_state->active_locks)
+		return "lock region";
+	return "non-sleepable context";
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -11634,28 +11647,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
-	if (env->cur_state->active_rcu_locks) {
-		if (fn->might_sleep) {
-			verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
-				func_id_name(func_id), func_id);
-			return -EINVAL;
-		}
-	}
-
-	if (env->cur_state->active_preempt_locks) {
-		if (fn->might_sleep) {
-			verbose(env, "sleepable helper %s#%d in non-preemptible region\n",
-				func_id_name(func_id), func_id);
-			return -EINVAL;
-		}
-	}
-
-	if (env->cur_state->active_irq_id) {
-		if (fn->might_sleep) {
-			verbose(env, "sleepable helper %s#%d in IRQ-disabled region\n",
-				func_id_name(func_id), func_id);
-			return -EINVAL;
-		}
+	if (fn->might_sleep && !in_sleepable_context(env)) {
+		verbose(env, "sleepable helper %s#%d in %s\n",
+			func_id_name(func_id), func_id,
+			non_sleepable_context_description(env));
+		return -EINVAL;
 	}
 
 	/* Track non-sleepable context for helpers. */
-- 
2.47.3

