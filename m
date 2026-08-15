Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ADD39CD13
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776389; cv=none; b=W4JXFwzrC3T9d0mtoBkUgmwfAe4MMMP5W0L01xUZiht9J7rjKX4RlpkEE5d5aBg6SrqmjlOYTJvZazd5Y88WsxzAPsiawHfVG/f/OHwf5NWeP1PlxdHltf1Y34hd0E+BQQwGGxMXLnQpflq5E9ubolnUdh2+RcclBhA6G0MHF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776389; c=relaxed/simple;
	bh=rgCbHehKGIYh6mlG3MRresi/3QFSP4i/c2cZZe544MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZTPAPwMJfRJhzKKWy5849OYwnWL+1OyzUUjeyyoeKVUF+mi8Rzr7FemGfTXjSW+2aPTTQXRENaFMJffY6kfJvPDN9ZF3bLUM67lhgDHF7y8vPrPRQiZYREe8xvs6rw2EXOA2YnSZgDnuoZTB94uguPGA0h1B6kpo1V7Kj46Bkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaMCDdp+; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaMCDdp+"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so7427305e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776379; x=1787381179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrIIi2a5wdNCizOr8oJT7mVONXeRPFfOQ9DzG0Sw4Ok=;
        b=OaMCDdp+EIk9AAHf33tbjJ3h1YZnL4Tnkq0HuXFiIwjhB9AZ+1gzZiNitNZ2smMM/i
         SDcx/wvwlbFPAXJ8hLWj9m0Cq52PCquS/UzDRDalf0RhWJQui8cdoM5BsX0fEmlNSc8L
         nYi2qopccXr0+/l85oOZ3f6Qck2Ar9HI2T3Pzyb3EFBnNSn12RCw0ujmn6NnSQf5KGeO
         eaBQFxWUyDuMJZA/nzv+0gI68R3eQZwQiTc6PDdJfkuP50EkOdUQ8yVdnJEl/rNJtS0q
         o3pl2UgxE5KIah+wZPaoTv01YNjYcHKrlpIUg6BkQvh3SPXXMU5FSW8iCPvCAGBjWS00
         LPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776379; x=1787381179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrIIi2a5wdNCizOr8oJT7mVONXeRPFfOQ9DzG0Sw4Ok=;
        b=YgBZYmEtiYSjuDhQBp0L86ywH7HAT1KKi6SSOKUp2o++dcEgtEHqnmuceIOe4dBvVT
         ZWIxmibg8v7HnL/O7bIYZTKMbBXZLQ9kVpLNJekfiip/nvx3nR7HZj6R9tvYKjipf5d+
         wGdQs0IsT44otlQRe605Rjic7Zio/fGRYpnWdeDQlLLrW1m3CUfTErrS+HMNr8zPtJOR
         vqgBF9g6e+q3R+0GYlz4rjSH2178jvdt8eutMRdOekjzNPI5PMte6NjRkjgiD4drQXyi
         BhHZpFz23gjZ7Isg7hYmwogcLmTtt+sbfavJYaNWWLEdqpiwP4OIG/bSipythCA6fPq3
         O1Jw==
X-Gm-Message-State: AOJu0Yy+XxiRD+IbNjGQXUo+WfPXcPuYCJplzIIG8SzylkzpWtbgUxlH
	Tk+31hPK6HtJNwWQkQzibHhBtUSOgl2kRslsIRhrf2eVhM7/meLLd1JrfFSuVnrr
X-Gm-Gg: AR+sD11/cThoaT2QqaYeoKtJAYZ7oBBsXGemeNXxCAvSv0cXrBdECOTQW3cTISZFTMD
	ZjlQpiCjm2HY0yPjqZRjJr81+hjeg9aVGVasDTwbIUO97Z1eq1zF1xjpm2Hxp8pZRpORLtj/fhk
	bYAunQ6+5t26MQpj/ah071XiGcPbsJcz3dOAanZ6J6Be93sqHeGiL+xS8T3OXUb2iw86TSr14or
	Q+1G4iyEp5COe8ey93G2Q/SMBhYc1d3qtExq5UYGAPhaKzuvmNGch6AISFAO4SOTq/6/RXmrAm8
	MK0XfCP7GVRGdb6svgDEi1zqXoxZfU8HFVjO/mR9LJEwH7YMVEDi1P+kT35xnjIUH+2FYBkPqNN
	/rLny6mAkVRmckR9BYYZPZfD2lzHbfRmprpB9lmlvKXL06R5zo9SX6MzCtpkCsmKUo4Rl1m53/w
	Zi1ul3/4UB75xbxwiK23tORicn93OEoVzQWsrgipleLqWiPsRlnUGTd+r6q8O0q3xlAoS8MnGiz
	Nm6DRhTV6oTr8FreL2GSXIdLVW8Y1Q/7WS5s36ngyV+SUrWrXONHfpQEf2PBVNT+xTKagJo21xm
	wUQSKaSEFcWts/XDSIeAxsHg78g=
X-Received: by 2002:a05:600c:a4d:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49987981e52mr160622205e9.19.1786776379505;
        Fri, 14 Aug 2026 23:46:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49989ae1d36sm78421275e9.11.2026.08.14.23.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 04/14] bpf: Prune verifier diagnostics when switching paths
Date: Sat, 15 Aug 2026 08:45:59 +0200
Message-ID: <20260815064612.378577-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=memxor@gmail.com; h=from:subject; bh=rgCbHehKGIYh6mlG3MRresi/3QFSP4i/c2cZZe544MU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy+vNJAGLppBZ5/9VxS46uUEuK21t7Q97rmuFTStyX l9772rXUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImcu8PIcH/PoW67NRszemRv z039fnftlpPeisKcGU+u3t6evPDdBC+Gfwo6LrM3hzGfeJV3+RPjBVvmCqsrwRw6Xz2viK1p7WF mYwQA
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
index 60dcb87a2417..db644690ac4b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -194,6 +194,7 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_stack_elem *next;
 	/* length of verifier log at the time this state was pushed on stack */
 	u32 log_pos;
+	u64 diag_log_pos;
 };
 
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
@@ -1700,6 +1701,7 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
 		err = bpf_copy_verifier_state(cur, &head->st);
 		if (err)
 			return err;
+		bpf_diag_event_log_restore(env, head->diag_log_pos);
 	}
 	if (pop_log)
 		bpf_vlog_reset(&env->log, head->log_pos);
@@ -1743,6 +1745,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_save(env);
 	env->head = elem;
 	env->stack_size++;
 	err = bpf_copy_verifier_state(&elem->st, cur);
@@ -2264,6 +2267,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	elem->log_pos = env->log.end_pos;
+	elem->diag_log_pos = bpf_diag_event_log_save(env);
 	env->head = elem;
 	env->stack_size++;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
@@ -18635,8 +18639,11 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	ret = do_check(env);
 out:
 	account_current_path(env);
-	if (!ret && pop_log)
-		bpf_vlog_reset(&env->log, 0);
+	if (!ret) {
+		if (pop_log)
+			bpf_vlog_reset(&env->log, 0);
+		bpf_diag_event_log_restore(env, 0);
+	}
 	free_states(env);
 
 	/*
-- 
2.53.0

