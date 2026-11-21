Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299262;
	b=4UNS7Nki8kDDWRPOdZsVbr3Q79atA8DqTNoor3qFMUG/QBrFT6+aHk3EzwNudUPmO3AF
	 ijCO04QRhivocYfnG5Q6XV56MTvOJr3Ot/irTuLf48VGRORTMAK36sd5PHNA7dFtZ/tJ7
	 OhealsVD0DMzovRmCeT5Un8UGXiPNWQrowyVvlzET6prt/d6v4HJU7nlm1h5tTsT8o7yb
	 S8eHbWX2rnQVEhzqLVqC4Qj420HjJfKh3ra2++C9Qk/mLjCxFZfGgrw/ks4V7i/Cp1Cij
	 V8RowOG9n+tkskLHftzsVbzm1zW8irT8ZEB8Kw0wSJiqCtXDavVognOO2toNMmEc1Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lmbQcSrIt1QyxZJyN3Bp5rBNYYBpKPLdMRVwT4RpfXQ=;
	b=Lm5c8Y4410M6qK2y/qEoWNbR+HsipJUkB7EXjecaZm31Mr+54oE4FqsZWQZM5dwyG8bl
	 dNDVOo7oc6bPpyhDVmu2DZR/dIUyEWbegVtNnd0WCf+hK0taF8QjGAiGUJxg8+XWHQVVu
	 WQj0u3Zkv0z+R6s9y5PiNM6b0RvGr559XlhSOSJ+2MnoBXD8IgOtewSTpb/XrTKIiTP2c
	 yUxeweKirfMzbsXm+dgFHeHJtmrFIYKGRLV35+Dp1jVYnVhSBspmo55bM7umr2aXRX4wx
	 YFtp9as38KU4iHMfTYmizOpN2ouZ6rb6qFRl9GqeZYiq5XPjFLAmoJGaysXutlC//AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2IJMtsA;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73168606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73168606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2IJMtsA
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso1550164a91.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299262; x=1795904062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmbQcSrIt1QyxZJyN3Bp5rBNYYBpKPLdMRVwT4RpfXQ=;
        b=B2IJMtsAeOX6GU3xiZeErrwUVPqh/FxgSdP9yBzd6T8wT1p2QAvzYAiBuQsHTfE6ti
         GPIccDoZ0aK2iWa9qO4qhsBvxG78/WOw2Y/+Ap/qL//NWMC+zVLmFT9hGetOvCYoOsRZ
         /ESOz/g41p5s+HWCBJk5lRTKrJyB6pKF/EKhC2oiYxfOQvX8/DbN9JYVmiVZqrumdrk3
         iOZiK9MopwAUsFUMyClJIWAHBDSCDGsRWvcel9xM1OtKttsdeyMCDx8vap2oAmRMGsae
         wvAAZkcvllPMcGCoaHhqMaQTPqqmw9RWdtdh8vsrP23fU1hY/pis7XT83r9WPMKHxaun
         riEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299262; x=1795904062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lmbQcSrIt1QyxZJyN3Bp5rBNYYBpKPLdMRVwT4RpfXQ=;
        b=QCFtSqogqMCVf1V5fS6BQSFjO9Tp+mbsXp9ZR6+TFn5GjiHC3EjQSb4CNBSF6xG/RU
         P9k45xurUCULzOA6Ef18M1T83jvcldbugzqArqELiocWJEj81NtpB+bgeM1G9+cjvIt1
         PQeiijc/e+VYEsyMUFR0YA+glcZ7CCW4+1yiBBjoFw7d1s0hGWtZm921ip4Yv+jEDSJs
         uASizQy6ZDTpK3vIw8f+OT5o4UiyUL7MH+em3kmhOKlOlLwGm/RStaoMLa21rL6To2Kr
         9HdGasc/EiShyz9MYwur6L4D9gdHHC9De8Epvgwg9IOtJCSVLGlbQP6x4grOs6mJ6H6p
         xYWw==
X-Gm-Message-State: APuU4Z8SDfN+YSD+3s98jImf13vYMoqaneP4m+xaBV3ZrNnQ4cW0BTwD
	El/zmK4wxzC7QFiojBfpaVcPfBoZJ6w7VfznHiAC9jRzW4khsSkQADD+vJF5yw==
X-Gm-Gg: AZFdTZdnI/JKdueKWSD0ahVJJk/nGBIzk6+waa/pxEqDSfbdY8M3e0MXnhV+N2sleEo
	YJL43qqijxqovuiRHcGT/Oy8P8dW2IalSVD6ztJc7Omsd+ACjAQQpmrBUwVRkKdpHBjVCIxxCa+
	ztrutq5Ofc+9LbfTbVNTkCp40ltKgeBAZxGhUDHlQOZ1fA6L274StCSGCXQWX80pvo7os79nTXg
	vMDL8V7CbLSfVXgftsJ+QzqEXTB6WvXeCvgCB71pguzb42icB+R6pgNhU1nhI6ehPBZ/GvdeGN2
	JZ68PCRXpDHjFWblmASTyKf2hPlVEMMUcXX8pz1S6fRKHd/iuAEpq3pviwdQz3eNZ/3mMhaI4DB
	v9DsH9z9d+Vp9FBpgyFWZhxU0ocEcFOK8gT/V0YcmoBU0HDR/rIzKfDQ8jMn+W7PVVCFJtUDf55
	IFJX8LAcaZJKj2Y1Z9pv+fGxz8MO6sgK+WajelEA1VPU6/wHPGKAOlOCgwg/1VVV929mIPa/iHR
	bE3W/YXTcaj/7pLXkNE+HnCkvcmfP6XOLH2OXSveaRm0HRMPO2EDzwh09Aa0Oi5YlzB1nv0/VHD
	axZs/FdpNvdWXsBTl3DWPeSgehxFFxO6IbGAtYKrLN/bQiK49Yn69UsL4X04ialGZBtWWEIbsDN
	jmbrB+JLA4Da228VTFOGNLLgwmfoXAuY6zjwXO2fzKD8CU8zD8C2ELkfOm2rfLEKppfOiNwKtcQ
	==
X-Received: by 2002:a17:90b:4a47:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b41c8fe84amr7230442a91.10.1795299261663;
        Sat, 21 Nov 2026 14:14:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm9654429a91.3.2026.11.21.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:14:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 6/7] bpf: Return -ENOMEM if the next partition has no memory
Date: Sat, 21 Nov 2026 22:13:43 +0000
Message-ID: <20261121221344.3958866-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

This fixes the error code after a failed allocation. No unsafe program
is accepted.

If a pass is over its budget, bpf_undo_precision() undoes the last
partition and calls partition_next() to select another one. That call
can fail with -ENOMEM. bpf_undo_precision() returns bool, so the error
becomes "there is no other partition". If the pass had no other error,
the load fails with -E2BIG. The log has an error of a less precise pass
and "the limit on cost or memory ended pass N". If the program is
valid, the user looks for a problem that is not there.

Return the value of partition_next(), and end the load with -ENOMEM.
Do that also if the pass had another error. Before, the verifier tried
the allocation again, and the program could load. If an earlier pass
was good, the program still loads with that pass.

Fixes: ecb43124db39 ("bpf: Partition the states after an error")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/precision.c       | 19 +++++++++++--------
 kernel/bpf/verifier.c        |  7 ++++++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 05a52913ae..151b578160 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1792,7 +1792,7 @@ int bpf_partition_for_pessimized(struct bpf_verifier_env *env);
 void bpf_restore_precision(struct bpf_verifier_env *env);
 bool bpf_same_insns_unproven(struct bpf_verifier_env *env);
 int bpf_partition_more(struct bpf_verifier_env *env);
-bool bpf_undo_precision(struct bpf_verifier_env *env);
+int bpf_undo_precision(struct bpf_verifier_env *env);
 void bpf_precision_new_pass(struct bpf_verifier_env *env);
 u64 bpf_pass_max_cost(struct bpf_verifier_env *env);
 u64 bpf_precision_budget(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index c53099a82a..e6dfb9f4bd 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1440,7 +1440,10 @@ static void keep_precision(struct bpf_precision *prec, bool keep)
 	}
 }
 
-/* The first partition that adds something. If all others are too costly, start again. */
+/*
+ * The first partition that adds something. If all others are too costly, start again.
+ * Returns 1 if the next pass has a new partition, barrier or budget, else 0 or an error.
+ */
 static int partition_next(struct bpf_verifier_env *env)
 {
 	struct bpf_precision *prec = env->precision;
@@ -1500,8 +1503,8 @@ static bool partition_helped(struct bpf_verifier_env *env)
 		 !prec->this_pass.over_budget));
 }
 
-/* The pass is over its budget. Returns true if another partition replaces the last one. */
-bool bpf_undo_precision(struct bpf_verifier_env *env)
+/* If the pass is over its budget, undo the last partition. Returns as partition_next(). */
+int bpf_undo_precision(struct bpf_verifier_env *env)
 {
 	struct bpf_precision *prec = env->precision;
 	bool over_budget = false, again = false;
@@ -1511,11 +1514,11 @@ bool bpf_undo_precision(struct bpf_verifier_env *env)
 	prec->this_pass.over_budget = env->over_limit;
 	prec->this_pass.calls_joined = env->calls_joined;
 	if (!env->over_limit || env->cost > env->max_cost)
-		return false;
+		return 0;
 	if (prec->partitioned_by <= BIT(PARTITION_ADD_DEPS) ||
 	    (env->err && (prec->last_pass.over_budget || partition_helped(env)))) {
 		env->over_limit = !env->err;
-		return false;
+		return 0;
 	}
 	env->over_limit = false;
 	prec->live_types_over = false;
@@ -1540,7 +1543,7 @@ bool bpf_undo_precision(struct bpf_verifier_env *env)
 	}
 	if (partition_by[__ffs(prec->partitioned_by)] != partition_suspect_loops && !again)
 		prec->too_costly |= prec->partitioned_by;
-	return partition_next(env) > 0;
+	return partition_next(env);
 }
 
 /*
@@ -1569,7 +1572,7 @@ bool bpf_undo_precision(struct bpf_verifier_env *env)
  *       |             v
  *       +--- budget *= 4, undo all since one helped, see keep_precision()
  *
- * Returns 1 if more is kept apart.
+ * Returns as partition_next().
  */
 int bpf_partition_more(struct bpf_verifier_env *env)
 {
@@ -1629,7 +1632,7 @@ int bpf_partition_more(struct bpf_verifier_env *env)
 /*
  * The pass has no error. But an imprecise state can raise a bound that is checked at attach
  * time or at run time. It can also ask for a barrier. Partition as if such an insn is
- * unproven. Returns 1 if more is kept apart.
+ * unproven. Returns as partition_next().
  */
 int bpf_partition_for_pessimized(struct bpf_verifier_env *env)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fe6209c166..dea18409f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23684,8 +23684,13 @@ static int do_check_all(struct bpf_verifier_env *env)
 			err = ret;
 			break;
 		}
-		if (bpf_undo_precision(env))
+		more = bpf_undo_precision(env);
+		if (more > 0)
 			continue;
+		if (more == -ENOMEM && !good_pass) {
+			err = more;
+			break;
+		}
 		if (ret && good_pass) {
 			restore_snapshot(env, good_pass);
 			err = 0;
-- 
2.55.0

