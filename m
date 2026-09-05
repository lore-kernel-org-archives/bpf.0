Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23221DF75B
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566793; cv=none; b=tljYpzkanmfN9QM8v5AcEBurzpKx0ZtPfXaseWZEu9Ivx+GSj9yysklvUHsyhxCV6mTV9U8gndQCYIIQcEGENq5HGwE2B2qnOqIR65mt+2gXtrWkOzWrhhQwLvwe21pbT2+qmHc23/G3mwxoOXPatNdAgQY7JTTyiPrFzycBuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566793; c=relaxed/simple;
	bh=VSP49arisSqaQuNKWNna4M/WB41JaFwkIK9y78cY4gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6lXw46plUXrEWj1XSyvrRJUygUNnStzAvyalU0deyQ5mWv2uC8fN35tmBR/yRYgGEQ/XV0lUqmi/rcmN7bo7J1vCl3W60qvidSkhwS9LLpoUAvIsgJ2oOF8NN7MjplqxnCGUMxzHeQMImDjQRrUClIdcgTwZlbfPgwhMCKjiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rleiulni; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rleiulni"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d7195706f1so18468405ad.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566790; x=1789171590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f3pEGjDpPuQdFUetAARTQgC9NgWXVFOyCJE+lHgQhW4=;
        b=rleiulnioQIdvUgORUCdk/oQLGWf3hfyUKO9IJlGAirJS1qjKN3ia16oOxiDF7RQOH
         Tg/Lf3ZQ9xqH6uJjiO+6E9eTOjp7CJYXv3UkiMrUtYpaENZamIgE9J++CJp9t1ZAHcbG
         bPf/ajjvuieWKpm84lqpgugLKS0LLy9OLF97VhzvhZcOmfYMEO/kBJVi/w6z0PTLOrjb
         D4gToKbpSn8b5DbYX7Pt3Y7fjLSBUQnKxuv/xTRoU0Pkbt3rI+q8ovjlmE5c3R0caXw8
         L3lPunWWlveOGFEXNkIEHN2joypiUXIQy7XraMwMgb65bKap8yzZ+4wcmn5rmntZoGTn
         c9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566790; x=1789171590;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f3pEGjDpPuQdFUetAARTQgC9NgWXVFOyCJE+lHgQhW4=;
        b=ezC4ve2ig2QW5dggHh/mrkj/78PYggPrx0qdljGUu5+K0+u67XLrkN9ZH3xYXBtUJ+
         9WR+NlmJ9jzOp1lM1teVLR26XeoZKgzZKiERBlkYCKNcwG4NO76nkP3JpbEcxOAumlkK
         4YW5WQvcEcj/Fc+V9BsMGUCNfADwFICaSyEZ18jnekv7vXM56mKvlR9wZ3wdQTLXvzAd
         r1pBaMaho7Yta1m6+OX58eLsRvXu8a95pwoUHJn8eZBEuvuiYEED2o+o61qen3+4kb4M
         ewWwFcsSf+dW10/0LbTVenKuB4mYZfZFr8nlpOECvFRqQlSFQNUY8uKm8Rm1eTmXuOwI
         3LpA==
X-Gm-Message-State: AFuF++nQs+067QtQ6Who+knTFOw9Ma7r8BiCdi32TnehlHiu6uYbAyw5
	FGZ4sX+7C67Zn0//Auk8Idp4PjtEgITqB2URx5sb9hT7K38OMkYccqnSv+IzdedOdf8=
X-Gm-Gg: AYBFou2PRTH1Tb5zYLBFl9Zt+eNk/tqflxSpfrdP1NW8MnXoe8CrPVLEi73VOuGfTq9
	pbtaaJWQrj1+0HYQMaND4GsywmWx7aKaFnQzsG0gUhv2+A5Roy5eWR/wrQ69Me+Ep8nAZgIe6bJ
	GL6qHoqj2yIilspGGUkNpmwH1xvhAVA2dItfb7oC72fBsqSugBvFjHkQMPciF+M6uQyV8AxLZE4
	tiO7b3Z7I6J9f58NYNFHODXNoROVqHgwMo88XYQXefgVTz5mb2gqRw11Xd7EEFcObGfhC1CLxy/
	dXXgNGGKLC4SH0rsF9YpMFw7vgdHczG76yYhtigeajQBaRBmUhx/LnEMLrCl//PbbIMhz7GnqHR
	PvZABimMMJwqYTOiGX+4oxUdNcpbvWfs9EZei4MAl/SYtnM1D3cU0Z4oVhlNmb6x3p3aEZRt4N8
	YMZT2SnEBdo4zQ4yD+EXnXMx8VbYhK+WYVi4p49/Mq2/vrfWYiTKX09rjl5v7qord4fy1rtqv8K
	Oqkwc7vhipQ03cTLoE542Aj6BD8Obst6kCE/PlacbeH+w==
X-Received: by 2002:a17:902:bb88:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2db1261df71mr105253675ad.6.1788566789715;
        Fri, 04 Sep 2026 17:06:29 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 09/10] bpf: propagate mark_chain_precision() errors out of loop_flag_is_zero()
Date: Fri,  4 Sep 2026 17:06:00 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-9-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Stop verification if mark_chain_precision() fails when called from
loop_flag_is_zero(). No functional change intended for the paths where
backtracking succeeds.

Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c3575215899..dc1fef1ef1ef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10685,33 +10685,45 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 	return &env->insn_aux_data[env->insn_idx];
 }
 
-static bool loop_flag_is_zero(struct bpf_verifier_env *env)
+/* Returns 1 if R4 is a known zero, 0 if it is not, a negative errno on error. */
+static int loop_flag_is_zero(struct bpf_verifier_env *env)
 {
 	struct bpf_reg_state *reg = reg_state(env, BPF_REG_4);
-	bool reg_is_null = bpf_register_is_null(reg);
+	int err;
 
-	if (reg_is_null)
-		mark_chain_precision(env, BPF_REG_4);
+	if (!bpf_register_is_null(reg))
+		return 0;
 
-	return reg_is_null;
+	err = mark_chain_precision(env, BPF_REG_4);
+	if (err)
+		return err;
+	return 1;
 }
 
-static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
+static int update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
 {
 	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
+	int flag_is_zero;
 
 	if (!state->initialized) {
+		flag_is_zero = loop_flag_is_zero(env);
+		if (flag_is_zero < 0)
+			return flag_is_zero;
 		state->initialized = 1;
-		state->fit_for_inline = loop_flag_is_zero(env);
+		state->fit_for_inline = flag_is_zero;
 		state->callback_subprogno = subprogno;
-		return;
+		return 0;
 	}
 
 	if (!state->fit_for_inline)
-		return;
+		return 0;
 
-	state->fit_for_inline = (loop_flag_is_zero(env) &&
+	flag_is_zero = loop_flag_is_zero(env);
+	if (flag_is_zero < 0)
+		return flag_is_zero;
+	state->fit_for_inline = (flag_is_zero &&
 				 state->callback_subprogno == subprogno);
+	return 0;
 }
 
 /* Returns whether or not the given map can potentially elide
@@ -10943,7 +10955,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
-		update_loop_inline_state(env, meta.subprogno);
+		err = update_loop_inline_state(env, meta.subprogno);
+		if (err)
+			return err;
 		/* Verifier relies on R1 value to determine if bpf_loop() iteration
 		 * is finished, thus mark it precise.
 		 */

-- 
2.55.0
