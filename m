Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773D38C410
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043933; cv=none; b=InABm2cBcmMUMe//mr5fGIqyeKiDMZL6XoXumlO8FD0vVoq5eh9jv7VYkN/y8cXyYaex1SU0JNAfINm0YFegFvm5sqdI0VPTE5tz3frJn4fWn/7qJpK5gqN5AOcUyL8+0rquZZVsuA15mLKUc5u4dlqDFH3R8DVVvC+JIxoHies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043933; c=relaxed/simple;
	bh=vAWpKfoMcBcYFQiIgPpQZt2gAuw45VdrXu4vr32WnR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUlwOm+63V+XrgCSt6RRoQUBrzltUI8SBCA5sm5zyrBinu8/Msu1zcq/444COJg7fpuIGQYnIbb6XIn3BR6v7+t0PLVc9ii9Ik84meiYK5FL5Cjkl/+UGARMcuG8lZgXNJNV8+N2WblocY7wZMoX9MoSEARAQs7HNMrABc6/AZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=LtyfqdJq; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="LtyfqdJq"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcc3e14so13271186d6.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790043930; x=1790648730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fr6kFLYx3hqPZHfOilkUN+oxGtJHBsVQ4xuLKdXd4To=;
        b=LtyfqdJqmY0e9ELL0ssGj0h7gUpGjOkkm70X85Gt+IkXbKkFbVpdREac17cbxynHk8
         2Ko6UALOcS1AMVly8SqrbniSteNnkxoai6dGRYwrkTtn/kIr1nwGTTUfTVFRfrqa8W6q
         MAIFjID8tKfIwkBuw2kRGoV99HBHkxWZcR6GvhW/nIXErVd4o41M/81OKAWZITsGlB7I
         q4Mjce36Twhvl3JOjdQYHfU5nJO3D9slnugJATmT9ZgVVoAjpoAtWx5csMA4pGcIqt+0
         yzCqcDPR9VNfBZyy1Q9bKmkVqkzRfy7JdywDXdr+upYi/mAO9Yyf68CWG4SYnkr8yDOX
         NZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043930; x=1790648730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr6kFLYx3hqPZHfOilkUN+oxGtJHBsVQ4xuLKdXd4To=;
        b=ip5F3Bk6QeLqHb6MerUDFN6TnaBNDwPB+wx490vSKpNOI667dZ27l7TwjbxKhY4Rqn
         ScrZV0JyIYFItCwrdYo/9SC+zJDslbf3dKvMXnbPaADwnqyJh7s4DHmipFJzYWWbJYG1
         nduFhVKeNEnNH/PH4idGjMfm2yFtJ8oSri3kRgIsYabjOc/us1OH1mbTH6HN3H9qeWuP
         gUqJgS1gNhB53pJHJPcw54UFGIWxfHEEUHDkVCKrP88rNOH7/K3Y9cpURPtF+H/GQVEN
         YBkJEF8mc7NFXL7L4N835Uj8Q1zcjQ8ON4HX2n5RQGbcAcP4rlR4BUzNOloz6k7vtizN
         rDLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwctYY+UCDwBLsvyZLV9asGKf53JDlySGjhMey4DJ2N5bU+PPOjMXQcmXCm5zQrzVY+zOg=@vger.kernel.org
X-Gm-Message-State: AFuF++k0X/dxg9W8TDQ6VRWOQ7R482HGXAhMN2kVi31Ohn+czNn3D7D0
	Yq5SOUxy6hIQuTLWhcSWnMizMq3NjKpoIq9LaLrKCFX5O8u4QuFAhW3SJWb63pvB0L4=
X-Gm-Gg: AYBFou2GW4qGHq0vrO4EeOdjKwnAU5xHOMU06K1ReSt3xCIYpsO4yjjELDTf7RrzqpA
	pFhR9Jq80nXhATl1qIVWQwSjCY0K5heAjNbuL3LwSsKED7Numh8EuVAGuQ1epvPO8c9IllIDJnn
	Wv9ifbIxhaja9aUkNF+Ngy0tbMVcHyBaBClVo+WQPtxIKJSYJXjX+N9R+IBXFFpYWHQHIVNp1Pl
	OE4M86XZH6Ta1M9bsH9MGv2qA0TXhGSz7IUt7rMPPIHYMpUM3LjI1GY4qKGhazlg4inAUdDuq2Y
	B4TnYGk6/sO2URGUQ3b6+8ODUtHwfzM8aPp7Xaztiq5HkL6OmIVxc3G8R6YZqL72uv5hJXOEXSE
	K6zlgAbqwYkXyaKExCgQJZaPduEAsADaVGiB4bM6lF3JJOHaHTfGpzvlbEdFqrl9xON4rDE/UVX
	NyIyFz/k4qAJOWlcXoCJMaI4Cig53/apuqJXw72epTd/eK7odrFXJTOd8g+OlJR9OXooa3fyEeV
	v1pv0s5/Jm5B5k=
X-Received: by 2002:ad4:5d44:0:b0:911:2a7e:abbb with SMTP id 6a1803df08f44-913ff001c87mr26718046d6.14.1790043930382;
        Mon, 21 Sep 2026 19:25:30 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914025165e2sm4420596d6.46.2026.09.21.19.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:25:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:20 +0000
Subject: [PATCH v5 01/13] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-1-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=4297;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=vAWpKfoMcBcYFQiIgPpQZt2gAuw45VdrXu4vr32WnR0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCPeuFAp5uVxV2kH2vDDmkA4ssSDw+6kXcs/1v8hvtFa+fEUwj418WQRUH5jUvQqcwsIafENDDP
 8QcAKkovgmQk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The irq-exit preemption path is about to need the interrupted context's
registers to decide whether the preemption may be reported to Tasks RCU
as a quiescent state.  irqentry_exit_to_kernel_mode_preempt() already
has them; hand them down through irqentry_exit_cond_resched(), its
PREEMPT_DYNAMIC static-call and static-key variants, and
raw_irqentry_exit_cond_resched().  The only caller outside the generic
entry code is Xen PV's upcall handler, which has regs as well.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/xen/enlighten_pv.c      |  2 +-
 include/linux/irq-entry-common.h | 13 +++++++------
 kernel/entry/common.c            |  6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 2c64b388f616..3d85035f5624 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -739,7 +739,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		irqentry_exit_cond_resched();
+		irqentry_exit_cond_resched(regs);
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 0bb6c03481fa..e19b41ee6b18 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -343,24 +343,25 @@ typedef struct irqentry_state {
 
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
+ * @regs:	Pointer to pt_regs of interrupted context
  *
  * Conditional reschedule with additional sanity checks.
  */
-void raw_irqentry_exit_cond_resched(void);
+void raw_irqentry_exit_cond_resched(struct pt_regs *regs);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
-#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
+#define irqentry_exit_cond_resched(regs)	static_call(irqentry_exit_cond_resched)(regs)
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_irqentry_exit_cond_resched(void);
-#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
+void dynamic_irqentry_exit_cond_resched(struct pt_regs *regs);
+#define irqentry_exit_cond_resched(regs)	dynamic_irqentry_exit_cond_resched(regs)
 #endif
 #else /* CONFIG_PREEMPT_DYNAMIC */
-#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#define irqentry_exit_cond_resched(regs)	raw_irqentry_exit_cond_resched(regs)
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /**
@@ -465,7 +466,7 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
 		return;
 
 	if (IS_ENABLED(CONFIG_PREEMPTION))
-		irqentry_exit_cond_resched();
+		irqentry_exit_cond_resched(regs);
 }
 
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e3d381fd3d25..e4acd50bd81a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -134,7 +134,7 @@ static inline bool arch_irqentry_exit_need_resched(void);
 static inline bool arch_irqentry_exit_need_resched(void) { return true; }
 #endif
 
-void raw_irqentry_exit_cond_resched(void)
+void raw_irqentry_exit_cond_resched(struct pt_regs *regs)
 {
 	if (!preempt_count()) {
 		/* Sanity check RCU and thread stack */
@@ -150,11 +150,11 @@ void raw_irqentry_exit_cond_resched(void)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_irqentry_exit_cond_resched(void)
+void dynamic_irqentry_exit_cond_resched(struct pt_regs *regs)
 {
 	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
 		return;
-	raw_irqentry_exit_cond_resched();
+	raw_irqentry_exit_cond_resched(regs);
 }
 #endif
 #endif

-- 
2.55.0

