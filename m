Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88D33A9C4
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968372; cv=none; b=ibrspMUuwoRP9CGaSuRE7fsMXOPxj40XoO8Cl/yNEKPzYpq8jE9eWN2ZYI5bm6Qp0LR3665QjSKsMYIvVKUpcuF5C7Yw06H3c1v4yw7Q3ZyAKXKsjGXIl8bH8xuTq002C3x1sGRvDXOfVvrzCJ6D5scC0Csg0GruAznEFlwi1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968372; c=relaxed/simple;
	bh=54uFfSNythuH4ejOHT1Ster2bVPkSxr2piIQSbmC2qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBl6FAiHhENTgJUYm3zg/IjDp2YuQqzrdvJQgSSbOxyZ8TCzP1HsX/J4acLFM9rpCq54PCZB3zKyy4lTOmHgzV03/7rpm3YRjovdiqeW8tb+d5M6o3v7X9aAkefqxOEjMmuB6IHlU4KjYdz1BNd+Zsz4xS36NHLlxiirY1WTZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1113AHI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1113AHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3300AC116D0;
	Tue, 24 Feb 2026 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968372;
	bh=54uFfSNythuH4ejOHT1Ster2bVPkSxr2piIQSbmC2qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1113AHIMjdRFsTd4fxhBx8zd4BK+u6+PHFD2miRIu68Ym5Z4qtCKyx4J6JJfv+v4
	 Ftaq36rxCBwsITDGrw/GWtrK4rOuvD/JjxhQ4iRwpF6YR5FSGRKpODzDqNvUMFH45R
	 re3LYHglUk0lzoE/iTRZFkinRziGN3StUEeeXdb6mU/hNAWbqVVysExpNh19WFmfh4
	 dmsW6Td+kecTwfJZEChQgPEFPT7HfjBN6xapsE3v/5uty8jOnAmSacGahkpwURsGzf
	 5EoVVNuzEkzm6hIq89wsymcCqlrA0mCHAka1F6AruhtHWIWJl+kR8HWg2eQwTJRxb8
	 mV/7Kndb1Ae3A==
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
Subject: [PATCH bpf-next v4 3/7] bpf: consolidate sleepable checks in check_kfunc_call()
Date: Tue, 24 Feb 2026 13:25:25 -0800
Message-ID: <20260224212535.1165151-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224212535.1165151-1-puranjay@kernel.org>
References: <20260224212535.1165151-1-puranjay@kernel.org>
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
preempt_enable checks for underflow and decrements, and the sleepable
check uses in_sleepable_context() which covers all non-sleepable
contexts uniformly.

No functional change since in_sleepable_context() checks all the same
state (active_rcu_locks, active_preempt_locks, active_locks,
active_irq_id, in_sleepable).

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddfb88b8ddd2..d54a04871c44 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14185,34 +14185,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+	} else if (sleepable && !in_sleepable_context(env)) {
+		verbose(env, "kernel func %s is sleepable within %s\n",
+			func_name, non_sleepable_context_description(env));
+		return -EACCES;
 	}
 
-	if (env->cur_state->active_irq_id && sleepable) {
-		verbose(env, "kernel func %s is sleepable within IRQ-disabled region\n", func_name);
+	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
 		return -EACCES;
 	}
 
-- 
2.47.3

