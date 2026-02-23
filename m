Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C533971E
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868917; cv=none; b=WIJRhSeINFVnxOMnnkwe6JJZ7l33uSATZ+o8hh9iNDEHH42nZQCkeBaZ5ejtgx//g1QmtMjxuF8NORtV5cfpURNbLZsywo4jxrUAXFo/vtr1u5wZVF5D7XbBs55JUCib0qZkGIQFiOmAxffxqwlY75b1oS5hnLnBQj2n+3V7I98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868917; c=relaxed/simple;
	bh=iDIy5y2CZahUy3HCvPEt48bCegu3Vl2Z7Kff+DrxOpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jttEA3LOLP72MpcOKycgTxl42lH42gTFCVqaxcGMZ6ARWqJpGcYI0Ojn0XenasyWwaDm+/V2Q4n7N5SBrBi0zQFyDNPGrmJ9b9rwxmz3WcVNaltlCgUHoyeDFNgWAX3ADxpntTwfrl39DLKqP1QQsq/OeqfTqiq3Mc9Nu9zk/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmSsoCZ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmSsoCZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF9AC19421;
	Mon, 23 Feb 2026 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868917;
	bh=iDIy5y2CZahUy3HCvPEt48bCegu3Vl2Z7Kff+DrxOpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmSsoCZ+nNx9BvOvsoF+ul1KlTzczCwUYX/FRAuzLbebCQA16pMaKafILzQUYrUt1
	 QR3m6pleUxCHRCFPdl1eMj+Zrwl60jC4Y4xfQAL5WVuhRwWgzjElNDYTY8AKPGgL8n
	 Gy66JYUrYV3xgjM37cTg3RShwGSLs1KOiVs9ubxcGwXbJzwIzf74uVuqhCwU3SPc2j
	 eKmDr9/rYUXfqIJpyOfeZQUa7dU8AcQFBugNXqEOHFfqB9Aym+PbxR5EVuMym4gZrF
	 fmr/iTkDYs2v8AGO+ALa/Nu0GTklatxjEzoNuMUXYbOTZ57oqlAGyy0OXszZTplfKO
	 OZ7OG1OcWhiWw==
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
Subject: [PATCH bpf-next v3 2/6] bpf: consolidate sleepable context error message printing
Date: Mon, 23 Feb 2026 09:46:52 -0800
Message-ID: <20260223174659.2749964-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223174659.2749964-1-puranjay@kernel.org>
References: <20260223174659.2749964-1-puranjay@kernel.org>
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
index c693dd663cab..c2a63f8c8984 100644
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

