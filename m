Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F742F709
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577619; cv=none; b=o+J68wU/BqQQIlnobyRlIHZTf00xlxHJcOm1cOfJ1im1ihboSTaGQhYTPDU4wux/yMXA0vGd9Ueat1Dz6I+Cvqp7NYHlwdV/AlQlqBDRpzW2Dxi8nG1pcRG+lymmrSszB5f57HrbMIbFKbJge8rI5gWsCmxcp1lNyDEFNJ8mZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577619; c=relaxed/simple;
	bh=DjEH7VGAloTPmIHs7zsrTr9z6mDCGH+WJq/nDl5M7C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGde8pEgHyfJPwSZUWitYGsTIz7zKcCW6BiGT2ww7o4Qi6nHWmLLiAuk/ZgFkv3uE6M80tAYV0N5VXK4J6qvMXdr8178ejgIQHUjOsZFz9mR/032tTNcJZYi3XkQZsi3KSmxr/R8lUHuAuQw0jr883m6K+7DXERtr4YLLZispJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPnHg+j5; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPnHg+j5"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so343598f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577615; x=1787182415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QgNKW6lF1zOWsOBOpw9kU94ghz69xjJeE7r5VrbIW8=;
        b=UPnHg+j5VhtZY+21aldtrhS6DtaraEjd7VF9tf3qE4p06zXlWVnSNFdc+QyE23lqBu
         Jc9oNatgWo6tbiS4RmQW4QMRezKa5L41twirXP40akSs/4cyz3R3qiJvJ/Zb+H0PDzXR
         Dz/Eih0II4AU0pEgI4O3s0F4L1Du+61zqZxqhTR1+roEN3rRih6270A/UJ2KL3cJff7C
         M01bhc7yN+inETc91LBRgDMbjF2GKMYWe4lqyzuqz5LHsuw49+UalPX/r5WbxYTqMaij
         ybH4zeuYna3/+MYx7gbNmtpa1eMn9ZSoIxleS0gl8egTSj9XABfsXcLbOvJfbZTgltLD
         WE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577615; x=1787182415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3QgNKW6lF1zOWsOBOpw9kU94ghz69xjJeE7r5VrbIW8=;
        b=UCz/GjFNuFEGEnXI8FSw1r998P+FlroHyAeAPtvXS/9HdobM0ak4NMtR0zxGUoisll
         uMDHrAGf3dkJGBBvfOC1R7NaDggnUbpSUD/C6xERetAjvl373PxgI0ZBiGeBEkINmk/Z
         dsZqa2ohP0/zi+Sla/lq2piUWT5T2PFq4xsfYBojvdxIt9+j/gfbtiV9V+ZKjQAZN9Ve
         QAQbNHI57uh8if/eEJh3sfLv3p5tV35Bk4JCuZe8kTq7RB1MYFatGx/G0GtFf2lYVARU
         dwNtkfw6FP5E9lXlVj0/M9ScCBGQ5wWq9DXqK22bmKyu/B3OlbGVZR1b4zSaKlwFmM/R
         XSaw==
X-Gm-Message-State: AOJu0Yx6unYtJgu0C77sYiU+qG5HwNv/PIAKpnPz7Z96QgKHATqu4QvW
	D9Po76eAUA3N985rkDZ5kcONJZJIXCj9pwAlB+ayNqF8OcZfp45vsu3shwKVb7Tc
X-Gm-Gg: AR+sD13dzX3T8Xhvr/lKfk+GIhQi5jsSaNH7KcDsyz6lUAtDbYNqe9ciDIyZkvc/dui
	ENOV0vsX2oE3JFZ7rvqRUlNbnIeukxys1XxJsLJSStebFhNo2qE+rKZX5SbsBo/crhiMbYtWk18
	ea/PkeP+r4m8g2LPUNPb6lASO5F0vGx3jAGNUBeALdyYy+xtseC6V49K57vN9YoNYQ2C0CeNgEX
	9IUaYpssE3iQkkth+cA1PKXPcIBPKfcVQB59VahWSAVGxzZHTefP7Al2H7N5R+p1Iqg90kfLquK
	ZsU6NJJ2WLFmAimMpcSNgglGTDkhkfptHLcC5RRnIdlPxIHowhRudybd0B5hua9K6G/yES2IUHU
	wICSSv1x8TNYdH14ZmZZriIWgpnlgnA5gHlYK2sEKnEf9lhItAO0Fzlw3n3/TEYhbjTuCQ1cmoc
	LPuwTqcRSK0EahaHyMp0QJPHIZBJ+LJP9LxkvBwwa30i9Oh4KoFem9VNDy4KU8mKt5FwR8IZ5Fh
	3Hk4uqLw8c8xoVjrXQgaqD99Ixy+w07GuzF0DMT4KSMEFl1Jx2bqMBYh0JiKoCCgEk+xtkAyEBP
	6agmkXawECM476H2l9dzSSiNtto=
X-Received: by 2002:a05:6000:41f6:b0:47f:86af:8fdd with SMTP id ffacd0b85a97d-48159ed68d4mr2304293f8f.3.1786577615383;
        Wed, 12 Aug 2026 16:33:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5612d0sm1244095f8f.2.2026.08.12.16.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 04/16] bpf: Prune verifier diagnostics when switching paths
Date: Thu, 13 Aug 2026 01:33:07 +0200
Message-ID: <20260812233326.3575958-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=memxor@gmail.com; h=from:subject; bh=DjEH7VGAloTPmIHs7zsrTr9z6mDCGH+WJq/nDl5M7C4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQavhSFHTw7om/UtsDTyn+1dZ8T4Sy7wpVnKhe+vfl j1FMU4dpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMi0Kwz/Sy/MfcXi787HF62/ qfOacBp/KENG5sUzkw5ck88W+3tImJHhsaiSVqP79CML/Xn+LbM+tuu6ptUcz/qJf6dNkenv1bF gBAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Save the diagnostic event-log position with each verifier stack entry and
reset the environment-owned stream together with the normal verifier log
when a queued state is popped. Also reset the diagnostic stream after
successful subprogram verification even when level-2 logging preserves the
normal verifier log.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6ca366ff5037..2e915292265b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -194,6 +194,7 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_stack_elem *next;
 	/* length of verifier log at the time this state was pushed on stack */
 	u32 log_pos;
+	u32 diag_log_pos;
 };
 
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
@@ -1700,6 +1701,7 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 		err = bpf_copy_verifier_state(cur, &head->st);
 		if (err)
 			return err;
+		bpf_diag_event_log_reset(env, head->diag_log_pos);
 	}
 	if (pop_log)
 		bpf_vlog_reset(&env->log, head->log_pos);
@@ -1743,6 +1745,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_pos(env);
 	env->head = elem;
 	env->stack_size++;
 	err = bpf_copy_verifier_state(&elem->st, cur);
@@ -2264,6 +2267,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_pos(env);
 	env->head = elem;
 	env->stack_size++;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
@@ -18566,8 +18570,11 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
-	if (!ret && pop_log)
-		bpf_vlog_reset(&env->log, 0);
+	if (!ret) {
+		if (pop_log)
+			bpf_vlog_reset(&env->log, 0);
+		bpf_diag_event_log_reset(env, 0);
+	}
 	free_states(env);
 	return ret;
 }
-- 
2.53.0

