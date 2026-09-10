Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC257D20A
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066262; cv=none; b=c/0j/30P9oGjXiDSbAQoVymzjogNulCLk9jZJxnqJ63jet8C0QxJeipFxVdrsN+w7FdA4KPesU0MPXjPSNO7APyPt9TTMKuAJbUXjLPL3Z0zWbVzhvSu2YvE0kIMJso7OV4ocEX8W1D8SfrQS9DBy6LmXM0+cCfvBr9cS0CZHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066262; c=relaxed/simple;
	bh=lYdFz9QIpBbv18s7vNFL415owdJ/HvkbTUnKX5a6LVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUzhLStJqias5t/1dQXfrcbO5BEHfJ/i989c/N7bX83SSse7qh6JkXP0UpXEW0xAh60i8g+X2dSMKBu5tuhk2CSWobEbPLFnZGrlGDcp2im+cOIKc4jDzyJzJIVNvLJYhZq14R3eArWQlJfYkSojVQu1+NsmHpOYDtqi9aL3AnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZTFsEcMs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZTFsEcMs"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90cc0ebbf4bso278546d6.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066255; x=1789671055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxBJRgyuHY3W/iJApny4mLX1c4wnn/TYh39J8mu564M=;
        b=ZTFsEcMsBBq2ulmPb/BCrMfdkASo0w8240Jh0XomclfIovxMdLGkkwRDpL2Xi9sRBM
         yks9hjEOCb8ZaeXAZPTi/g5x5RHucCIvIWWKpRuByBFJ503E9Ufb9Z8ugl/d9o5EhJD4
         RItdJ0JzZcRrZI+uP+nv9HZBuaU7We4jWpLZGLvMoUhmnCrreCmQbTZWoEc73GIom8v0
         t/jN7fuXqCsvCmztVVHSd8hnOqHzRC37fw33186SJVTM4YVUZI7c1FqS0UXlXfm6OSgo
         PHrd4W/6LRiMVK6CcbC1MX0TO7isQnFcm2FQZxZTDWA71Gq3yURC+BldsyFKyg2eU6vZ
         8G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066255; x=1789671055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxBJRgyuHY3W/iJApny4mLX1c4wnn/TYh39J8mu564M=;
        b=AJooA5wbfAX88rvxFixM6zM7FnLuESy3yHTEDfhmK+MkQ/aJ6SLL3rhzmCJESw4SEr
         j2Dolpgqo7MZLOgIdiqrxRGffygVS+nlqwgPCoPOkWpbN+gfjGhHUlyKTEOXuHVf97Wz
         2U040LfERGZNYREw7PZ+zUSUgioKqu8wZLyvCvEwzuhzVKWcDxfg6e1+YVfIgWuTo5Uo
         u212VKAnYlLxI0eVfvyPBkBDlhVoWxGo9OsLFHegZbXSwcW8Bwzt2EgCASE85Vii6PoD
         61j0dXGYooyaF8W5kkQg9wZgSKfW2TYc4UVGxU+LHsg+/VLKkT52uLLZ0NTnJbLA6aWG
         vskg==
X-Forwarded-Encrypted: i=1; AKwUvByZ4fn3YTEsdG1MMJVVgg3BDNXENZJ47HUZVeXh/s0L1tfIu7tVu53gdkgQIV6V5qsNqxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k68csTzzn3+WiGD9XOlpL31629+NOqoS0qguaOeGGh0jigJKXQ
	XJ04WrURc4gWPWvwIzLRzg62BzmBpUTVZSjcovbPMRhQSMnhlKL5TIbMr+8s7bo9NwA=
X-Gm-Gg: AYBFou1uFddMCecx8wRKBVFQMJsHilfpR46ajT2tqVpdHwAdA5hBTRDiaWuYVjMiueE
	MT4mE5WGrLQXEn1k4+1Rv5UTBMBZgtv4GX30cPTpF3e6q/D/36SaWxxZp+k5ehcFJoZrOWTamu3
	emjCny8Rl1Fujaha4yCwYiFuVdlrS2+PHGRn0FqbD7KE0QI/ZGYKwBTh9e3Hk9CO6b1N7iy8+dL
	R2GPmgytsqeJVr973ZdJedD1EK4Gu0+nO+Vc1ypyIocrN4ZmxLpuoyroWbU7TLxizeQqJMhzWu6
	ZMFmbMAgpLnVVVtJjVj/daGqG5y1MCgcRkec18J8oTyEMLZnEnzR4eHvKfbqMSOZ6GKNiWzBpn+
	Fesudqm+CuVtUyOk0UFWx4xo8m+/CSKklVNB5j3HHI/RUsZdB2c9yCBKIoxC+w8KP1zMxVaszH9
	YqGuZL8Fs6ZJ46KC/uclL8LfbHHZe/LkXAdpjomLEPaE5SkROBozcj+P7BNoX8JappbQ17Jz9Ym
	IqK1esWXiujzf5LEzoz1s6HnJrIg8O8IP/H6TuHntf5vC7x7AhjyqxL
X-Received: by 2002:a05:620a:280d:b0:939:78ab:3c5f with SMTP id af79cd13be357-939ea0137a8mr26249085a.9.1789066254480;
        Thu, 10 Sep 2026 11:50:54 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8bf9d51sm34965885a.14.2026.09.10.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:50:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:25 +0000
Subject: [PATCH RFC 02/13] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-2-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
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
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2

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
index 8da571622000..fc04725ae46b 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -348,21 +348,21 @@ typedef struct irqentry_state {
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
@@ -467,7 +467,7 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
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

