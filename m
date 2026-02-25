Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6A33890B
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027412; cv=none; b=QWVKSlL6cW5WXj+wxf0rjMSzSqvO1qZtJR4oIWTwIpiPTXswJ6g8WA+fPb9X9OKMV1y5cZBU/Xhqj0LkvojCr/ybgDot/YwYuhzCa6huYxPppJ6iVDNm6n1mdK749WrUPGDbu1CGQ5vjYjkKI8rwTQTOGGIf5dfflBbYnbBKZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027412; c=relaxed/simple;
	bh=k7OL4Ho3Zh+g/dPKV4RhS2+mSUBpIC3EAhma7eGVWSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lc58VX2qWRVt0LMavzNkCTC0nM3HCMih9Ar4J0zbZ3jSz6XSHFaVJeTbwBjM1iuXDeBbCOb9qWexxAx00JLEXMCl9nA4PTLUVP2X20vFMRyE/CYtx2KeQVYYMgVhmmmhgMl2M2A4ZXl9ux8W/9scNFMD7AaYkuJHY1a/fX/wEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muDU7TFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muDU7TFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ED7C116D0;
	Wed, 25 Feb 2026 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027411;
	bh=k7OL4Ho3Zh+g/dPKV4RhS2+mSUBpIC3EAhma7eGVWSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=muDU7TFbmQoyH99KTFeqYZsTYOF4FJYryruCP0YLT+AYCWlDDtrdzc4so2EJZ53tP
	 MKn0JfdTyTLNZLSPL6dX4uG7YXwbcGRusWwwEeP+2rd4z6azaiqmffTmmLCxyo5pjj
	 L3EDWa1Mb9baG98nu2Mkx/+7ZhT5hKhZUmF9PCI8lpTYBBgkU51IywOYjr+TtYHsmm
	 skpPhvR3s1sRNXzEVnUPhciQG2IcYd2ryiI3qBr6GLWXVp439VIgKxd1eRdaKBBICV
	 DiaKo+zY2m4FZhf6QuPnSsC8L9xbLzeP9AAczxWM04pW4/UwUz/wEeo6HSrNgIDzCC
	 b/sLwLumOWPjw==
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
Subject: [PATCH bpf-next 1/2] bpf: Consolidate sleepable checks in check_helper_call()
Date: Wed, 25 Feb 2026 05:49:48 -0800
Message-ID: <20260225134950.2781351-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
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

The check for env->cur_state->active_locks was not part of the removed
print statements and will not be triggered with the consolidated print
as well because it is checked in do_check() before check_helper_call()
is even reached.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1153a828ce8d..e8c4a5f8520d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11549,6 +11549,19 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
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
@@ -11609,28 +11622,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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

base-commit: f620af11c27b8ec9994a39fe968aa778112d1566
-- 
2.47.3

