Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC963D1CAA
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027416; cv=none; b=eghelSyu4jDZX9iGplDplrwnpiJoSg+zp+NAuphY2W+iYLgiPSlzcz7Q6JJmh2OL1MIE7Ji1tQryfU4edpDf+7dNITwnEHRQ1+7+Xjtm1N0+pJEwEAnaA/zAxAopfjjdNDO1CDiwpldYVebgClfRf7cTLYz6OPf9GagaWPNiwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027416; c=relaxed/simple;
	bh=XdkFv8THPOie/296pE+CVB1asKJ1JaEzkhxX+iyyQYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGJkJ4nMuGiQTMA4+75WnbvxTkcpJZt2GCImtrPl11QyyvRiwZDI2DDu9rFSiqEXYbHrvPC/T6G5wdRpJjBpkHEUB24tQ9+N1n/GkCIEeOmfMYGnrDX1ymvRvnETXAwVPjg2ZW/sIH0eqjfWO+3/UsD9kC20F0LHhtO0nk77prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhrQR8ec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhrQR8ec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F683C116D0;
	Wed, 25 Feb 2026 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027415;
	bh=XdkFv8THPOie/296pE+CVB1asKJ1JaEzkhxX+iyyQYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhrQR8ecY+P8G6iNRYVZ7d83tdAYAz4XhWIhKbJB4k7hmyYSRYC8MubSWzttHdbMr
	 CQy6fqO3FtxlPN768aq/ij5175/DYE1C7kCypNIv0p6V7CNVwJOES/ZVfU7ayZjyxT
	 TimpZvKcfgz6r83TqLsaB0LwSOBjTsXdWK5+ngXvy2bxc1FejMXh3MYXp2wGswQwr5
	 Lb9tLnmCcfgyV4WndENXqHN0JJkoo2mUgO7AP7TkflPDD4q3z35feqWts2Yg4p7wr4
	 B4oEAqZieVVkMo+1yESHcaav8AeJr7C79BgMUiYfJDrvLZ+uLXNvZ3IBtslVh+TTqd
	 tGvXtTns+qZxg==
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
Subject: [PATCH bpf-next 2/2] bpf: Consolidate sleepable checks in check_kfunc_call()
Date: Wed, 25 Feb 2026 05:49:49 -0800
Message-ID: <20260225134950.2781351-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225134950.2781351-1-puranjay@kernel.org>
References: <20260225134950.2781351-1-puranjay@kernel.org>
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
 kernel/bpf/verifier.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8c4a5f8520d..c26139b96c6a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14153,34 +14153,23 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n",
+				func_name);
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

