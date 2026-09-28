Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF937E5DC
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619266; cv=none; b=Yf9AjA5b1G8HjZ5O7LHexqVAVNBSrV3zQwe51hr8GZVVWoLQlWQSabc6mXtjyT0fNc9MzcajuU6D35FcjxvtHGeSXW456vB4g1ZAItP1Kg9coMtBXhK2+SQQEdjX127FlA2XfKEXNq7JyRlgxJtkTBpiO5vAR62Lc2IqS9QLJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619266; c=relaxed/simple;
	bh=mSjbLiF7FFcysdEglneYgoVqpsXO/Rx8BWy5Z0he5VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9pNQdrbCwLQRHBuA06qCi65DS41TL6V9wjmNhnXtTTsWBuAGnNMk8FGSvYH3HaGUmrD2sUEyLjxn0qhDm2KWzHj4jpX70his6iUZRlPL74ETx/JA9TRXipKzlbFhhSTyzMnn+zqCpjXWsgkDKCEr04K+CiBpigsnlOdmNDXrMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jggVrfAT; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jggVrfAT"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d77aa5735aso1194771eaf.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619263; x=1791224063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5URxU7i1pcwBZA4Md2jFKcVdJh3bp/xLesnwtcQ3gXU=;
        b=jggVrfATtnVWjV37b3ber27/UUYR0lqibMuuEW+lFvn7PjMZpJ4o/rzcTHXyjIcNCW
         mMvUNXAJUOqjvKQmXj5GYkhJe1wTjCLjPdYtV1uelRs8+RxpvQjcac6Xo/UyJ0CBQuur
         dVyAogLttUmUqDuJ2kB8q3HzDubZScPmi2U7L3RMQyYM/gn4zmZAWaifaTTgDai9/iPe
         rCRUbXVtroatuoYrxpPDr5wKZMPc7wLYMJhhkCnfJ+WGokrMTwlg1rRd5ba3HYV3AXn8
         pDzNXdKrTjO0HGVBfJh8+mgPEs0QV3x38tDo2/fu5t3WA0+qwdTWjG0QOimOdAQz1s5S
         xzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619263; x=1791224063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5URxU7i1pcwBZA4Md2jFKcVdJh3bp/xLesnwtcQ3gXU=;
        b=OZBOZEppr8tqn6vI2T3l4DnDhQwYiiPdMSuOluBqPlDXv0hU1yULF1wqGC+BrDu/NL
         nFZPhqqJjhsEiFgELRB6ab30kSo1DiC+XH8eFJKTSnpDrWgWn/zQOEEOeJ5EQMx1wv+f
         VJA1ND/kdolGz+YlS6ygMTbaM5e+y74FnFectE/nidxw4OCxzhpTJKCU2VtIkVvKiIkr
         bFilr3HPEx653VoktA6h7wVeUm/jwVdGYN3bMGntMplRxovzvDlv5zCHQ1Zo/XIY6rUM
         KyHNXbRVnGkqz/AcXZJ15oqDUqaPncxu2PqLlj/9xfiCDe+GOZTE7rbKj12NnAj2u7Yw
         SVgQ==
X-Gm-Message-State: AFuF++kZ6+1qRyypUSB2ZdG4jTlyk32oZPvZ3wNLlqsU/tUD+mn9gqIk
	kM5rhr1E3BURamReIYIDKKmoVAege7l2hXMzVZxdi5tDB6mHmok21lGK8u7MfQ==
X-Gm-Gg: AYBFou1GOdwlEueySkLHtBR+GFs1aF57mU2Q22fU0HyP7emzARd4kSTmbiLQRcPXFzJ
	htrfnTBqkLY+oeykACPHweG665QPkzVcgQ+A4uprZ/cW9TUmMnbW3/BIF6u+MGg1H1S3H7eEg3A
	UZl5i7wXYLmqr/RM/QHg4ZHhsH/TJRzZG8goVkdZdYNykrwLwie02eUBgE6f/gKWbzbxSeoy0XS
	EgOALlQilMhfijCnneL+6oYwuIADiY4s+etiMHUh5WOvw40Bj0Y4d7YV5/75tjsDVEfNXah0F+t
	GAWEm8cvoq9nQw4S4AQjonRhGVuBtR8HuayDvT71+YsXETSNmog2TEjZkPYmPsYLTKL5+3ChQ5V
	j9EHEU1SR6hTCz1LIW7nuEb8BFEUYm9RBfO9S7abA/WeLwJ0WDAaGS1Df40YEiF6L0SE6O69ZK9
	zhhmXAoSCe5uG2lWrD99qgIgH675LUSGLXc2WedqQmVM8bv+P3hQBuv+yIeoD+CA==
X-Received: by 2002:a05:6820:f00a:b0:6c0:f44d:fb9c with SMTP id 006d021491bc7-6d4410d9bf5mr13446301eaf.47.1790619263420;
        Mon, 28 Sep 2026 11:14:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d58b094fesm2179044a34.20.2026.09.28.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 06/11] bpf: Check subprog context arguments in the common path
Date: Mon, 28 Sep 2026 11:14:08 -0700
Message-ID: <20260928181414.644158-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subprog and helper/kfunc context arguments require PTR_TO_CTX with an
acceptable offset. Route subprog context arguments through
check_func_arg() and update the verifier-log expectation.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                             | 15 ++-------------
 .../selftests/bpf/progs/test_global_func5.c       |  2 +-
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd51df530e62..47ad4f92ef67 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10879,22 +10879,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		nslots = btf_arg_slots(t);
 
-		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE) {
+		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
+		    arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (arg_type == ARG_PTR_TO_CTX) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
-			if (ret < 0)
-				return ret;
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type != PTR_TO_CTX) {
-				bpf_log(log, "%s expects pointer to ctx\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
 			if (ret < 0)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tools/testing/selftests/bpf/progs/test_global_func5.c
index 257c0569ff98..4573ecd96aa0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -26,7 +26,7 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-__failure __msg("expects pointer to ctx")
+__failure __msg("R2 type=fp expected=ctx")
 int global_func5(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
-- 
2.52.0

