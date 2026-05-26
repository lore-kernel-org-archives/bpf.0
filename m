Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A763AA4E4
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824256; cv=none; b=H/9lGxSsybHIqssVWEgSpPSgMZJjrCkfRmSpGptPgtI95PRJheuusUMTjKFKkBsZIf8CDoQrEoRj6XRH1GAwKQ4C6PjLI7rqcru7SNvAAwqGZw8C0DkW4Bxv6hDroLaN1eLrs/cAwKUB0Y3Fcqm0zQP00FJC4onzA6y3w2+qbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824256; c=relaxed/simple;
	bh=qxUU4NsEs7k2OTqrY1S+ckPHLEWT4E9usme9KiPGmaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzMJMTSBG7SZ7Nh/tyvljLfumoGBwEd6g5MY5iD0LgyTKrFPMUYjBC3sgR/VMiKGvgVlzkPE+OWV4MWz/lu8kakf84lZEztFZGIXmvxYRq1Fcl4pR7H1VeCmxAEcbI7xYw8jfxj9fkAGxq80KLzYXuiHU20f0axpiNhBwPQkr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2z9RjZx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2z9RjZx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so9834175a91.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779824254; x=1780429054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyAytekswurD/SjpVDxfarR+cCcDe+YITeUIACrXm6I=;
        b=F2z9RjZxjlo5vIaoi31JIGVUdAwSjOFF/kX+DIQsHXXSnlQmjzEK5udKrpef+CCqIU
         wU0Ds8sixrAKxm/U/1+K1t+ZOKdLNrHr0/HHE0X7aeRmTgEvoKGDjT/L/43l88bRn2Rz
         aMn1CzLUXuDJZz7STojFtBPrwkRD2Cw2QPlytTxjzlEWyg7T3bsHfwHS3EI9FRULJshr
         WoOLpazVKPR9M5QBn8BTkHbel2WYAw1v31SaGS5nBxuBUB8v+bQUk/T11Ld+eamMaSSD
         3m890ftpSrr3fAIGPJBd4puF1DHtDDgdejQKZgHYxUTta+mwAx9Ou3/UvlDJB76XS/L3
         8lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824254; x=1780429054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyAytekswurD/SjpVDxfarR+cCcDe+YITeUIACrXm6I=;
        b=n4yKfk9EqWZpXyh/kJqi394N1FWXt/uMUXfeVibabCKWY6KhhRDh6Jcpg8ew1lnt7V
         K7CijHyUm06jfVq+T8LqO5t4JSafi1ajINrj9p/0//ZapKaHb03cdTiaV4EIS/hqGguz
         l36Q3z+qOOS6xvr2USdS5RErB7+bssv6cGwNvbfLA5eHMak9iiduqC1jobIFNNW8eooW
         TvQdn8hH4WwiOoc9TN9pKSNuXfMO8glbaEaKFpNb+sUk38l1QyAafifuqiqWBEgLy/gg
         A3kyOow3u87m6NIbjJWQZYfgRlj0KKrFy9QOamObXc0ZIkutm5uMJcdS+0VkW08IDduC
         inTQ==
X-Gm-Message-State: AOJu0YzFXg9gSR4cGnWIvUefajoNTWPNBNVRRuPuno7Jep8OCWKSJYi+
	4XYy+tU7a5mkzcp17Cc7hieMwf5vQpmXe/irCKQ7Z9GXcHFLe7NHr6MubLKzKKaK8wU=
X-Gm-Gg: Acq92OGcxKwR25kEJ62Yi9ZN4EAkyb7wC0gCJRjxhKX8k0sg3sh3u1aVGPXhrR7wVbE
	20iLT/iOhU31Rqy4OSNwBvfj/0E1Q/fJoSFUFdKeRw5yRF2VqC4BUi7/CKQL1grmLFr4A305HZN
	cbWt383kpgEfxS8pRUIrQcLZ0+NC2ckRkHw6VsnnHWBqOXehIF7+Q5K8p3hwyo/k+QzCntdUL9k
	V6q/CPnIWrwvtfoF6+5DXxsMdcNECUHzQpnya0DSASkHcT/F7P/ZwBZYBpCrkABQL8rNkQIT3D7
	AK7N4zfqlm0aHxYKyOJQ0xw1TeEAdKbI+zDj37vL2W+irQoMj2iX6v4I82qP5BnLQlXQGPnjw0/
	h6oxmUomgFAYrDnSabBS0y5l3xvc/X2m2WuFiIyBR5GjeabUlJWoq7F+nMA5fPhDVHhK4839q1Q
	3al8ZEhHMJhkGpcSSveMEkzcHL3zy/o1NT4wVfty3ZpYxUSzXBqtCjRfQH9yycnw+VIJ4=
X-Received: by 2002:a17:90b:3744:b0:36a:bfe3:3d7 with SMTP id 98e67ed59e1d1-36abfe3080bmr7358473a91.14.1779824254097;
        Tue, 26 May 2026 12:37:34 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm12617283a91.15.2026.05.26.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:37:33 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next v2 1/6] bpf: move live registers and scc printout to a standalone function
Date: Tue, 26 May 2026 12:37:15 -0700
Message-ID: <20260526-better-1m-reporting-v2-1-e7ec61c45d41@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
References: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Tests for multiple analyses performed by the verifier need the
verifier log to contain analysis results alongside the program
disassembly. This patch moves log level 2 program dump from
bpf_compute_live_registers() to a standalone function called from
bpf_check(), in order to provide a common logging function for such
analyses (and thus avoid printing program disassembly multiple times).

This is a preparatory refactoring, subsequent commit extends this log
with loop hierarchy.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c                              | 22 +--------------
 kernel/bpf/verifier.c                              | 31 ++++++++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |  2 +-
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..16d030fdd83a 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2209,7 +2209,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
-	int err = 0, i, j;
+	int err = 0, i;
 	bool changed;
 
 	/* Use the following algorithm:
@@ -2270,26 +2270,6 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; ++i)
 		insn_aux[i].live_regs_before = state[i].in;
 
-	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "Live regs before insn:\n");
-		for (i = 0; i < insn_cnt; ++i) {
-			if (env->insn_aux_data[i].scc)
-				verbose(env, "%3d ", env->insn_aux_data[i].scc);
-			else
-				verbose(env, "    ");
-			verbose(env, "%3d: ", i);
-			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
-				if (insn_aux[i].live_regs_before & BIT(j))
-					verbose(env, "%d", j);
-				else
-					verbose(env, ".");
-			verbose(env, " ");
-			bpf_verbose_insn(env, &insns[i]);
-			if (bpf_is_ldimm64(&insns[i]))
-				i++;
-		}
-	}
-
 out:
 	kvfree(state);
 	return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..3d569e36128c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19619,6 +19619,34 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+/* Various log level 2 information about the program */
+static void log_program(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	u32 insn_cnt = env->prog->len;
+	u32 i, j;
+
+	verbose(env, "Program dump (scc? insn#: live_regs_before):\n");
+	for (i = 0; i < insn_cnt; ++i) {
+		verbose_linfo(env, i, "    ; ");
+		if (env->insn_aux_data[i].scc)
+			verbose(env, "%3d ", env->insn_aux_data[i].scc);
+		else
+			verbose(env, "    ");
+		verbose(env, "%3d: ", i);
+		for (j = BPF_REG_0; j < BPF_REG_10; ++j)
+			if (insn_aux[i].live_regs_before & BIT(j))
+				verbose(env, "%d", j);
+			else
+				verbose(env, ".");
+		verbose(env, " ");
+		bpf_verbose_insn(env, &insns[i]);
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+	}
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	      struct bpf_log_attr *attr_log)
 {
@@ -19771,6 +19799,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		log_program(env);
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 401152b2b64f..923572df4bbf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -64,7 +64,7 @@ SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#0 must_write_not_same_slot (d0,cs0):")
 __msg("6: (7b) *(u64 *)(r2 +0) = r0{{$}}")
-__msg("Live regs before insn:")
+__msg("Program dump")
 __naked void must_write_not_same_slot(void)
 {
 	asm volatile (

-- 
2.54.0
