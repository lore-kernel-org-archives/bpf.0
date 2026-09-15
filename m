Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838A3C8C7D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478271; cv=none; b=h/dh8ga/A46rZtLEOUK05MuQuDLqbOsnahSDmI9/i8gLdFEkysmJG+li4FF4E+hJeGfqTMEdRm4VatF7V+JZqX4/J1loH2bgSIU9p+8QlTQh1CiVDKNU19tDwBr46nCgVSY3mB9AMW5FLk7lRCPufjsyiU8M8RVKBvOulQHAEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478271; c=relaxed/simple;
	bh=4dQuHlI7KqFK9OlS3RCAgATHNrdOmuvuGUsCmQTn02w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUSjg+OVdhEujsO0+6NIN1aAq5/8GsT8XqB0ee8bFZgSXu0zzw4/i0Js7ICuGoP1intub1NVzJGvF39o625H6gockNVeMPlCPQTy9Ch9Gxa4o4f9xJ76Y9Uvgp1njt4xF/teHKIApAmaXGneotcGOWeN/gfaqB7RMr4SklY17Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=lC4DslFo; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="lC4DslFo"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f7a9afe43so298151d50.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478269; x=1790083069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6aaaKNzMayGmjMwZUrTAjDsf1dO37tc7Q4XOVkfUDkI=;
        b=lC4DslFo0ONKzz102J39d6o/XRoLTL4YaBOgKHhrkmFH9/+Oc603IMpBGpgyCRWeSu
         Dz5SNTbARSIjFElRePCAPH0BgeLyUI+tuIfgZslv9f+18XiiyHTp7EzMlX83CgyZkEWk
         kO68b9Ogi5iIU5yvq346XeK9B9pJFmB4caBWU9gXH97DVlxO0TYnovN0SRfp9EZFYWIz
         W7M39eX/kJhN3tleNHIP43axLsolzBl680ywgcBqXFXRlztK0Teg/N9nPG/F9URmITT0
         eUpo1sObBBxn+nXkCEplBHMbdZMUnhEuxWHaDwU20WiiIPQrVeUWYZiFpfSIL9b2LdVO
         6P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478269; x=1790083069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6aaaKNzMayGmjMwZUrTAjDsf1dO37tc7Q4XOVkfUDkI=;
        b=T2GCaVogjohgJnc9CDcX/XYCV6c6yXO8HjTeTJGXWjoiBY0c/XgArtS8HfLRFZLmh7
         5P08XwzuvvnZM4jH8//ABamm6vnzENppEwKdUAeIauMCthetOUCL14HikE7x1jj5fdyQ
         9tcqaIKXeChFQwmNs496PEX/e8ZwzFTLDxVVKOPdicNFKxfLkGFaZBWchTbnnMP948HS
         saVoNoq8kVbF5CpPm0MuHXh3qFXEx3Wto4T2hcbohwGSxmR79RDIgHVFraqyQyogsGRV
         1v4vdKqYngbLyRyghpQRb/EOkn26seLKONxrqDzgdcXiOeKXfhWEHfxJvxPS/DQekjBi
         LyVw==
X-Forwarded-Encrypted: i=1; AKwUvBwL0v4FxLMOcTm5X7k2BxwlLH1knCFYgdjlW2XYAedl68BsvPmrG+IXK/9HbFpopDEbMaQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mDqPvgcShEZ2gbU+sbgWOtP5OlTA7mRWb/h2AiS9fCaA6rQMP0
	EPwJCfI5hAbF0nuI6wcgfyy1tVoA79Uq6Pqxqbh2VwE2TPpPOTIvbhf0xxKV/xW6/M0=
X-Gm-Gg: AYBFou2JhG+52vx3XefwiFuyL0JhAL50OwLoNpt7UM1GNuEL1c5BWJaX0VLl/gxTB3t
	MuIycIUlLEBPF9RxOLhsfwBOF9pJT2thwGHQ+u5GFXvN2elwsFk65t5aMhpYmBnHl8Oh3x6cefk
	wjo3zed7brHvn8nJ0dOxSf/8HBSY1ARWwqHgJfyLeczfhHf0R8PXfiLdagY+pp2ObhzPWHGh1Y+
	VsHjDO36smTpigZzIeVFcOUBZyi+PtU76WwWChzZ0c3aB2fnlIsBDvq5ntXWc70XBR3UNwWR7e5
	eAGp1J7pXz8y+uo3aHJfKKDumDf5VgSU/7ljJKeqVU+Y1dovCvnrfb2tvU2Ys63oqhpLPLJEwwq
	68nl8MoiBHGcIHX3GrhnJph4Q9fh1ZI9HZIL2VXO9xUnTU/BWYu2n6iOeYyl9zyjyJIR27XWTKo
	fBraF9gLIIz5IBrD+9gqEcCDjn3EYnEjYxv9PA53oOJzucsswhPvJMeEeC4YrQ07THm2cZJqE7z
	Kkw56kPnMzwVQgBATXMIkG9ula8umsXy5C0dO1fXYSNpccNfdN5uCzY
X-Received: by 2002:a53:ac8d:0:b0:66f:c1bc:c08e with SMTP id 956f58d0204a3-6715cbfa390mr343734d50.86.1789478267673;
        Tue, 15 Sep 2026 06:17:47 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f2032d4sm120309036d6.5.2026.09.15.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:28 +0000
Subject: [PATCH RFC v3 01/13] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-1-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=4149;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4dQuHlI7KqFK9OlS3RCAgATHNrdOmuvuGUsCmQTn02w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEWkL7am6CPwY8WEkFAeUlQhZwIsKFKiG0LL4CTUEuVNlpBbsncWTVxiTecESmw1XMIxu5wivHh
 xkMDa7QjuUgk=
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
 include/linux/irq-entry-common.h | 12 ++++++------
 kernel/entry/common.c            |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

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
index 0bb6c03481fa..b811b469b0a7 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -346,21 +346,21 @@ typedef struct irqentry_state {
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
@@ -465,7 +465,7 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
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

