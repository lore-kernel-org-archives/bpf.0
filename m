Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0049D5BB
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742989; cv=none; b=SB4yf39/l9ZvqGYAyNlZFl3qsmahnEdLkuByYvqDG83nEs51rD8iY1UFqgQYRQFeR59WWTE2hg1WUyFFndANL9c0ZlvtqS/AHg9qxovfRJIWkdX4htpgi8l/ru8DttIXRfUuvEZG94LLhpt/vF/sDzRWk53Rc87KYId0m1uSCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742989; c=relaxed/simple;
	bh=vAWpKfoMcBcYFQiIgPpQZt2gAuw45VdrXu4vr32WnR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3DXxK7kywnip3S8E8whvzVcBRR2CvNpe578WTKxCuVlFFVHbb4EbI16A+weaQEQ3mQa4vRyJdc8yDKAyw0+dgI7NRzacg7K1elbCrlW0DKLkQhOl5Z2UHZ1Z4VViXxKMxxnbs7L3ceaW50r1aTugJWqrkTPgoFkMiM/vpXb6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=EGgWMV6z; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="EGgWMV6z"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76bcb1fso8330231cf.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789742986; x=1790347786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fr6kFLYx3hqPZHfOilkUN+oxGtJHBsVQ4xuLKdXd4To=;
        b=EGgWMV6z55IWJOyB4m5gstrvtiOTmMAqGfGnjHURxdaGzeYa03npTcSQXQNWsp1OpG
         1yWwSagHCAftWamOKnzrLXSxGiJylsxr1dLNHVkGrloWdpP39BYC3mezixCFJZcO5nwC
         WOOeu7aVYfU+EWYnCT3JXk5/BvlWKWuC4ejairXDOeZAb+z2Ay6+XhvEEYdYgMQBHtnY
         q6Pq/0g8lBxdkrvDj8N3hYyKwWUBzRvMrMDdE7Kf/m22XebcYb6bjfU0nC4Lses4n2sm
         J6geooV1c7gyLOcNoH9XvntGJiknXX/ERvaJHLTq1AObEkkRg2wtIx2owDlnuJjjmjJ0
         4TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742986; x=1790347786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr6kFLYx3hqPZHfOilkUN+oxGtJHBsVQ4xuLKdXd4To=;
        b=vZrHkxinhoLjyy/BD9qwv43eHOqnlgPnq859iYMCLpDCBMpq9qEq5oxD/gX7OesTwa
         aDQUwmIdZb95t7QquubdmX199fxLmzk4O9JXxazun9WwMj56FVeoJU7/N4hVFhMcwaqO
         +f04v3cs6vcHvrS04G4sH/8tLGxj+gdOM7lmKMSby/kmvPLipP/HBTFONTC1LdzSRM76
         urfZpJll95u9/VoBaP0gmk1EPMkddCbhjfERViz/c3qBFccJq+zDoGhB9CrC4wzwG7eW
         PBG7ae634IaoU/JY1uWz+z9+jz/co9PGX/EgWUjCjBx4VNKm+Mcq98DR9QWyrMuf2Q1P
         7ZbA==
X-Forwarded-Encrypted: i=1; AKwUvByZ+7ZmAsT+1pJ7kvBFbeghDVMcRZ/3zH4d+CvSTM56sUnj35qTe0IiKbB4KCNtp6KxRWI=@vger.kernel.org
X-Gm-Message-State: AFuF++k4cor0wIgbUf4CLbK0Zps/66sveOR2EpcDnrjScPe4F0nDwYLf
	tA8RctzCIDT+xXTDBejGJzNGR68JrPb6GZw9xOKqIBv6oeD6f4UgD0+pyjW1afNk7o4=
X-Gm-Gg: AYBFou3FW/s1pkmMxttyuUk5cTrZs/H4UE8MYvkQOfoG/9DTtbQTwJJza5ypO2AfUJF
	xuUpxpoW+sdvOSsKfuHtlHb8gFYO6EI37YNcB+UgNbYsgsEds8HMDOyt4W3q8jdQVVCXmtXUXa3
	pIofQ24pQvJv4B0ib4beldM+nbtxSw3QOGGQjkDbqc/zt8RhsvzNyzpTdKlKJuneMPvkvL0db+Z
	N99/F6REf8ioe4XU0sTyp4IUKs8i9wAi2A8oFT5fvGj/PPEsP6G17fvCVm5vogW7Cc32fHPhMRm
	Ro4nY6Xd+q0fqRcz71InKRckTeRLEMOzohXd6DxvUmKF/OXQYg4UpYjcYxnUbELaUxNdkYHfqvL
	ybksm96KIWSf3tXY3wpNWtI3lYq4buXgMVfFkMy301xR0GE5a0MLamyAFhWXUMpuCQrFgWL5LUW
	fx2yoe9D2YKYSO4YDoOwKLqi47ivvB56HGvUJG8QFxNzdvvhXibYbNsDpNh6bFAsQDSmi12od2v
	XMkery1d2gIPlkHjlHhEmwACqv5C1hr6TRz/6fU94eVZFJq3FzcC5miJklyHvM67vs=
X-Received: by 2002:a05:622a:652:b0:530:efbc:9a8e with SMTP id d75a77b69052e-5329e3767camr46085191cf.5.1789742985599;
        Fri, 18 Sep 2026 07:49:45 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532abe9a4f4sm3338251cf.0.2026.09.18.07.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:20 +0000
Subject: [PATCH RFC v4 01/13] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-1-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742979; l=4297;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=vAWpKfoMcBcYFQiIgPpQZt2gAuw45VdrXu4vr32WnR0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLUE3k3CkS2ybrdoKxDg2rM2yr7vcCp6RSWtB3hgoOxoISfCxswmRrxWH4MEQd0eZavwNPRgmIn
 mcD0WDNOMyg4=
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

