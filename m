Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B521B87C0
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122530; cv=none; b=FsKMmXaBwofeJs1x5ubMgRQUMRx2Iu98rTZFUtyCI+VmmNVt/JTIoZWR0CriVR1H+jojEGHynl4bWWtnWlNTsZUi6dScXUUrzJywounlb+6C93gzjbx9SkW4UGz9jgvgx4Q/iebZMSWHEzZTSrNX6FCNv0QV/QjyrsJ5hfzXddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122530; c=relaxed/simple;
	bh=Nqj7QxV0BkJER8IBn+1E0lzkwqK5txdWmC1QHqfF8rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTGhuwv8NzcAAgCFyitsDN0lEno5YIgxrFRe9y6+ZvsTWv/Ror2lstWLPvGRZrn+CUtE/T2bHJpntDhi0AeZH4A7YyVi+eD5dSzjYPlFzWKE1cn8jtpNXVhISoGB/zwMVACHJKLIzAbaHaP2K7azi/Tz5yEEv8tBY18phC+VeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP6ix10I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP6ix10I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F215DC116C6;
	Thu, 26 Feb 2026 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122530;
	bh=Nqj7QxV0BkJER8IBn+1E0lzkwqK5txdWmC1QHqfF8rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VP6ix10ITRssHkim7Y3/SzkhWEnIVADzM1LJwz03zCxO+RkiQd7lrqvlimW4GveY8
	 +lRzC5mo1OfcdIZRP43gLGzoszKmuiQzIR2BE2kH+6ZagfoYUNB54p3oOKo1YmfPKP
	 8TKen4G8KfzuGd/b9z9OUbIyLzjZo2SHeaAg0yb5B07LH3BFpkiGGqd4L6e0iLlCZH
	 jWoi0kmRZgf2W420HJzYjiXaiea0sxJLXZGultIMvY5glWxtTO1hx6UYIV1fl0+Wr+
	 rhMGeOOOKlNTRIS7PQuTFOKx4YPEjktMb9KYASEFM3kOxJPz+/rnHaXMS7c3KMi9oS
	 YT+hTNod/Kvqw==
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
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf v5 3/8] bpf: consolidate sleepable checks in check_kfunc_call()
Date: Thu, 26 Feb 2026 08:14:52 -0800
Message-ID: <20260226161500.775715-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226161500.775715-1-puranjay@kernel.org>
References: <20260226161500.775715-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_call() has multiple scattered checks that reject sleepable
kfuncs in various non-sleepable contexts (RCU, preempt-disabled, IRQ-
disabled). These are the same conditions already checked by
in_sleepable_context(), so replace them with a single consolidated
check.

This also simplifies the preempt lock tracking by flattening the nested
if/else structure into a linear chain: preempt_disable increments,
preempt_enable checks for underflow and decrements. The sleepable check
is kept as a separate block since it is logically distinct from the lock
accounting.

No functional change since in_sleepable_context() checks all the same
state (active_rcu_locks, active_preempt_locks, active_locks,
active_irq_id, in_sleepable).

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d7f1b5c439a..270d45b345a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14192,34 +14192,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				}
 			}));
 		}
-	} else if (sleepable && env->cur_state->active_rcu_locks) {
-		verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
-		return -EACCES;
-	}
-
-	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
-		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
-		return -EACCES;
-	}
-
-	if (env->cur_state->active_preempt_locks) {
-		if (preempt_disable) {
-			env->cur_state->active_preempt_locks++;
-		} else if (preempt_enable) {
-			env->cur_state->active_preempt_locks--;
-		} else if (sleepable) {
-			verbose(env, "kernel func %s is sleepable within non-preemptible region\n", func_name);
-			return -EACCES;
-		}
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
 	} else if (preempt_enable) {
-		verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
-		return -EINVAL;
+		if (env->cur_state->active_preempt_locks == 0) {
+			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
+			return -EINVAL;
+		}
+		env->cur_state->active_preempt_locks--;
 	}
 
-	if (env->cur_state->active_irq_id && sleepable) {
-		verbose(env, "kernel func %s is sleepable within IRQ-disabled region\n", func_name);
+	if (sleepable && !in_sleepable_context(env)) {
+		verbose(env, "kernel func %s is sleepable within %s\n",
+			func_name, non_sleepable_context_description(env));
+		return -EACCES;
+	}
+
+	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
 		return -EACCES;
 	}
 
-- 
2.47.3

