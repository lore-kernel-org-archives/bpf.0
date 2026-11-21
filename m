Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288463;
	b=xMUANc9p6rxbcDyItapMV/0fpjprOvjfISFfbzUFpYftt3h361W7shYZpVUWaY0JB3f1
	 zK3yEe7Ux+lOHtjRO65cB+BMDVlEBqslI0RCuULjbww5nQUHCTWxZbysyeBZz5PA9eVZO
	 Zi8S2xnhqjWvlNcuHICEsniqnW+NZqDYUgOMvJ9dfpCLsn4EX6+5AtjHPRaS9Z8E7iDYC
	 0NJbXwVKMOflYBYGs7SUa3Dy8RwaRrAfbaGMAhg4NEeuQamSjSMD3kbJdj171lAdn9zvi
	 gatGRbHBPnfjShmUd6BXPz5H+GxMPUgThmORVFE4WYrziz3XrXy11KkZ8G51J6yPCYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SZPa2GvyM1XdOt04poqvCMbjyJYTGc2Z7+dhh4e/6Js=;
	b=DdWjziSf2SiaYgWtnKqO+sHshU2GqJEO4bNjol1zIgufdfqk/rGkCKra/72jRBOr++oG
	 VLGld3QUV+dTBDaWLMXrzc9znfmMnaO4t6EPXkTzzg+0a/ZD32eFlQvc6ULA8YMKJSX7e
	 l26MmrCg9IjpvDJ43JjS1sEsPJMWNpxVh875vje3DnAsbJo9IleDHqsNZG+SgtjTdS8Jw
	 JoQPOJxLkbgik7HxxDyudrYTVFd8kip8/4Z7BfCMEtdy5Xc0d49SnqbyvHG0pIxHIwt0P
	 OcQeLWFW2utJTIXwnGSJemylBuxu9zmPM/74CN43sjGDWXzpShA2sxtH3Zao1z7vkbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3ZlFE+X;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD11606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD11606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3ZlFE+X
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f0621eec70so7115415ad.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288462; x=1795893262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZPa2GvyM1XdOt04poqvCMbjyJYTGc2Z7+dhh4e/6Js=;
        b=t3ZlFE+XciUd17dfAhUOtAUnX8/XgLEh3BlZ+sj8Sux2DgZqZs7FwC5HIfKHlkg2gS
         W0Bzcz2xWGxigYF8T1+jDHRBsrO3UKqq0YfaGYVrszQNdCOACQXS6x6yE93MQCMotInS
         fl+9e2wxuZh5DO2V9Ft3Y2EhCDmxuHvGLmpIgWHLHNrrGosk/LXJ+3fQTCDWLFFDB2Um
         FH2fnY41KtcJ+TmDYJMi6vHzuVuIXii5K2GyOw73Hc6zVWi3CV7WrsDVziJ8WuMPsOsk
         TaD1MRHJ+6L1ldc5ywF1i/1Qq3rR65fHXodZKY1tnbCjVuISg2c4CWE3d+yxKUWwcf/Q
         Uszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288462; x=1795893262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SZPa2GvyM1XdOt04poqvCMbjyJYTGc2Z7+dhh4e/6Js=;
        b=Scosw7unOtZzz1upR+2SLskp88RZY4T5nPjndNdhgAZ1mpsz0ZnnAERnAd5uKNuyWY
         3cKvE9oVNL0WO9Y+L+6/mea/KEvQ6s5se8NFAVgQiJoAjXguFVulTy/BFTediiYqIJbv
         h69xf35tS+maQedDcavnJjN/BcJ7/IAMwNqz/gaRJIHnC1ZrUlxkaWQnwDqUAL2lha94
         6GAWCDQvDHcIpY1mhfbFGSC42fgp5UwmZdU6Ix/lR3VW/l+IiOBg8BGdjIfYEKov0b2f
         R9dJRETbGFVy8OS5PtDjbS4niEJGViDFVdq9AZKbG0e4mXqzKB7T7m15b6Qeqy6Tbyga
         rmIg==
X-Gm-Message-State: APuU4Z/q/MiJwqkDDQfFM7hg3ql08PB/yfLGieiEFMnYoqCV1liqfQKm
	n7x3oKM7ApF/3anhRYy+FSeo0ayUR6x/m54EIKdU889xkxayD47C7zPLY4B/lQ==
X-Gm-Gg: AZFdTZfRAYKwqhfmldLACHsygasnL0CbM6akCHh1btIWpFg1GgQIdph/7T3ZtVmWr9Y
	rOP104Krf1JOyFP5Pk3zKzOxCPv5xq6agxFUjduy4O/yQD/DibG0v9KsfK1RNm7OcdEjyiGqrK7
	sDkRJHw8k1eauRrdxQX2//ofHlD4ZaWNOvXfAYKDqiRdTQbJ6IQzJ1i8THd03Nn1Fjl+Wqo0u+t
	tf5lBGXaeVnF/DPIhWhktl2VUmgiRnNRm3ahhe5/zjEQdAi2t1yCjWkqip4zn09wqQhjV9PaNdc
	GJFUeKh80ihUQEnJp1C/CpLAT/WtsWn8WEamBJM3Usoj/c9se7q1dQBqQmd0OID2ryycNB7HVCt
	7biVQxguTVZCcJuCo+rhOBESRuRDk5qC1VJJdKPvVooBnqcKHNtY9sl8EiUbmmjZN+fjXev88Cu
	xmZsDKIZYg6ZFFURNhQ9iHsWR9Hvf/Q0LVIAE5kX4GFe9KX7AKORe2CeRwBUtkV0DzqlnuRyqM9
	xJjnkGFyoi0dcXRg0ygl2xAAeBJZhn+xcxHDOs2cykVumgjI6VaWuhbV/yDf0ZWCOHepxsQiSbI
	1pVFjutKxuMQEsvR6TlpCUS9l+cHE+8VOJGjSGpB1R2p0bvUTPLomZgUmZJNdznxLa34X64/nMl
	YZRrm73F39Hww08GIm+UtbDq8hCWqUXc4x/Y4Ni8EZNaw57EvV/VDJrOcTvnpr/SelyioeVaOpw
	eo6V5Lb08UnhhDDuVimAc=
X-Received: by 2002:a17:90a:d2cf:b0:3b3:ffb2:6ae3 with SMTP id 98e67ed59e1d1-3b41c902f49mr6450182a91.32.1795288462313;
        Sat, 21 Nov 2026 11:14:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm10099942a91.16.2026.11.21.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:14:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 6/7] bpf: Return -ENOMEM if the next partition has no memory
Date: Sat, 21 Nov 2026 19:13:41 +0000
Message-ID: <20261121191343.3670609-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
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
index 942629cc49..f569080e23 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1789,7 +1789,7 @@ int bpf_partition_for_pessimized(struct bpf_verifier_env *env);
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
index f0334f782a..d7aa01d63d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23685,8 +23685,13 @@ static int do_check_all(struct bpf_verifier_env *env)
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

