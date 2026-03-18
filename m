Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514CE2EC0B5
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855824; cv=none; b=fxl3AJIeIPuu+Ad9RIkYnFcfXuwnRy4jjX0rAtEPHy1eQrDvRQZ7piMTG652ZL42bh/2Ql93ieLZvBqrK5YvxtQncrjltKsc+9ai5JaWYVf21fXz9oke1WgIRFQz9nvgiUzJToEnhRczRcsmb+cAnum7d/ixwrukDuPGOQZWYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855824; c=relaxed/simple;
	bh=aQTbmS2gxFSdEIKQ8rQH+UvTkDaTu811NaDRg0mdQZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gj3S2IfuEJwjvwnYDhVHkw/7nXVHdU94PrX2FDKLWuZQJOZLvCIAGTNLTHsAaKdTkj0mEdSY68BVjysXvlMqLZi/q6jTb/ChT/cbrtLkM0FnVwNMYObFkpTGfWfHoGibS+tGL8h8W/eST70px1zZ7hxbgsvCNg3MBFjh4qW24J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1o5GXdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1o5GXdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7860C19421;
	Wed, 18 Mar 2026 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773855824;
	bh=aQTbmS2gxFSdEIKQ8rQH+UvTkDaTu811NaDRg0mdQZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1o5GXdiuaO63VL/uskQgvPWpOnKjKIlVrgG1Nj0ieIgAZc06sCeo+td/LOaVizmm
	 KYFQ5MM2Mm9vqn0Qo4iUIhGm8A+wQAMFzp/GxI8eZvV65QtpTmkOEay2YwDSLd2mAG
	 zYHdrHdUlu8iYHwuyb/eLtMUz+IdrVyj6R7rSGM2wNv7YujujPupwSwREVrdbgD5F8
	 B5tA1xJTzO4F2RunmHkJFko3M37KwLillFNk8wr6BMmdNfGYvYFtK/f8U+VEmAF7JD
	 VoXxh9WHFHyf6Iw2IYe9CWyOgnbIoV8Kfdo+cWAEqALfEBHynU/hLcH4EWO7vWSjyA
	 JGQ7lQzQPMFlg==
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
Subject: [PATCH bpf-next 2/3] bpf: Consolidate sleepable checks in check_kfunc_call()
Date: Wed, 18 Mar 2026 10:43:25 -0700
Message-ID: <20260318174327.3151925-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318174327.3151925-1-puranjay@kernel.org>
References: <20260318174327.3151925-1-puranjay@kernel.org>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e0f6be5d2d5..a9130c4888f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14276,34 +14276,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
2.52.0

