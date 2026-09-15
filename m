Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13554A3F17
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478295; cv=none; b=T7CNeIVVp1oHUVxgHwsPlg17DlFsIY9mXGozdPbTTZuWz0YO3hFefGy/YJsfatBs6CyIh8s7Ae5OtJD86vrhEPS+Pzcl8cun5jJzkwtv0MYctvKZHyJrTVcSpRNkwQAZxQ2lZ7TLBteLNuEvXtHAR0rH7PjUQtcjN6i1XztJKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478295; c=relaxed/simple;
	bh=a8x0095kiaPfODWOL6BE+0O7E5TXMNLRrf+m1qUM63A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTlQyaiEVldp9LayZfnExhOLcngGFe+K3QVVbvNovW1r0PKJ3kOxNEP93sqMrQDR3/dG6riiovu/K4FpA1S+3a6nOqCcVhTK4Jul+oCZBVjC/dTwL4Lol/1KL2FG6d7UgWYrlRWWmflQbyJr/VvBLUEkhk2PiJH7KKnNHLJIGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=GcHM5kne; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="GcHM5kne"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d0so33567751cf.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478290; x=1790083090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AdtdE/dNeJhNnC7k2tL4hzZr80UNkNMTy9M8Z5zSRM=;
        b=GcHM5knei46u64fvgeHMLZZx4CC/aABYu/dUG4fLhVq+Hn1pHHoaqKChILqst+JnJN
         QFv+pN4eoXxbWbi+yd75J4Fc4Lp00WxoeewVk7ba5YRVhHCVSSsQZhSCbyJvltk0ruC9
         bzdeWyGSqWxVM3VY6BwDOQLyNbqZ7tBsAs3bx5RjawGGHkUx+Zo+EwHsgKa1yWCWiULQ
         sATFcDXQYBW0UHT+wz0aTjzmxw6UOhYRywOrto5iu92XbxS67ZrLuHb+vnaa4rmeqkIv
         gNOe4L7qpas5zIicX/Ty0gHI2mMIGfHFVK8OqCjUosGmtLdzfKPM76jbdHpQu0dDtCgk
         NpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478291; x=1790083091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AdtdE/dNeJhNnC7k2tL4hzZr80UNkNMTy9M8Z5zSRM=;
        b=GavphWcaFLs02aUnyQVBsvHxbypZtjWXXWgUM0iWvEE387zrLfsyXAbKoPVyiWNHOy
         xD9G7VHjTf+2rQT5iAJiQifYeivw7XDtfZQdH6bxU00ewObeRFbE5brIWUBu8+O3Oop0
         0m3gYhasWOGtlQmOJxGNkQU+gGnd4nRdkop1vdlDoqzMk6tA6bwxKGMJI71o7I3gwebh
         vP6qXhzzx5D2n/oCtvCE3d178TGRY3my8g1L2AMj9RSoDRJyNzCw3ae+AIoAIefl3Rri
         PPvQvs1KbsI9S/t/gT9yZHapsdQSYyL7NReXLeFVTPTR0ptXO8u85D61QDa3pfq0dE9R
         tLAA==
X-Forwarded-Encrypted: i=1; AKwUvBxRHl8QiR9nJUsEHq+hzkqB/ifiFqP9I40sXzjHZuH6vCubH1nECw+MoH+wZbzYTEFhbto=@vger.kernel.org
X-Gm-Message-State: AFuF++n09Y/z11wkLc0DG2odsExwG3JG5/rpxtSWCZcvw0Ddf5bsG9JB
	Edg3KTAsfw+BitI0Cjt2qpSG7RB+KRF2KaojOwWWkNSvEWKRHiWpnNtf+E7lwE45pgc=
X-Gm-Gg: AYBFou3HyBo661eNcsiiPht5uAGeYy3Mup1mOauemtONJJ1vNzaSJQqY6ViLhRbhuyC
	3W+2aJhUoZjA7HEvNqHZkU+zpsiMGrOchmSq3lHvUvU9ZY2ipnl2naGBiCeVvF+a4vxOjjVIYzU
	4vxmEQ2KxQ8G71Ysd0Oe7+OCdJQvsGGRrBzaTVMHVIZVI0wfH5bdt1Hz7l91Uf02rtOaFFOat/i
	9Q3O59qx8DrUvWqmvOitJZR+HXITG0DwY+xU4RwpWOAN1Q9pBk3R3IPLoeXA3yooKkbWq3bvA2O
	Rs+uDer6D34gS/vE1QYunEBB/4s7oC6YzESvjEhtjfFeQ12XUv5u74KTQGtw6AIsazZSaClbzoP
	KF8eZ6nA+C6/UHJz3MC9i6nWVlmihZlR03HwRPk2vUvzpI/JCzGt2bBbskwYjxZSIPlgcQAQXq7
	uE81G5appe7F+JB2QWZ4MIjRy7r2VCgRqy9qqOqoINtMy61dBSjCLVUeCoMSOLyuP3Z/bdxMOff
	6C0lBmgYJSpdqRygd7FDw5pAli6ZWqxDoaKJuV+YHICOCQ8GUt4cAI2
X-Received: by 2002:ac8:5705:0:b0:530:e6b9:f5d9 with SMTP id d75a77b69052e-5310cf60dcamr104610221cf.20.1789478290432;
        Tue, 15 Sep 2026 06:18:10 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53104165737sm56777241cf.27.2026.09.15.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:18:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:39 +0000
Subject: [PATCH RFC v3 12/13] rcu-tasks-trace: Assert no reader is held on
 return to userspace
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-12-0ad30c4c5ee7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=2589;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=a8x0095kiaPfODWOL6BE+0O7E5TXMNLRrf+m1qUM63A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNQ+h4Rgq+uBTWY42BKURCuzv1XjZ1QDbD5nWJycO3HnjSRSDGwSoVc9aADl5pV0kBRcRtS0O1v
 XzhUhrtoXcQU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With trampolines and their glue now taking rcu_read_lock_trace() from
assembly and from several C paths, an unbalanced reader would silently
turn every later Tasks Trace grace period on that task into a stall.
No task can legitimately reach userspace with current->trc_reader_nesting
non-zero, so under CONFIG_PROVE_RCU check it in the generic entry
code's return-to-user validation, next to the existing kmap and lockdep
assertions.  Compiles away otherwise.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/irq-entry-common.h | 2 ++
 include/linux/rcupdate_trace.h   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index b811b469b0a7..58086cc1140c 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking.h>
 #include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
@@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
 {
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
+	rcu_tasks_trace_assert_idle();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 4035054309d7..f5a51de4a4ef 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -209,6 +209,12 @@ unsigned long rcu_tasks_trace_batches_completed(void);
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
 
+/* A task must never reach userspace inside an rcu_read_lock_trace() reader. */
+static inline void rcu_tasks_trace_assert_idle(void)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(current->trc_reader_nesting));
+}
+
 #else
 static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0; }
 /*
@@ -218,6 +224,7 @@ static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0;
 static inline void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func) { BUG(); }
 static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
+static inline void rcu_tasks_trace_assert_idle(void) { }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 DEFINE_LOCK_GUARD_0(rcu_tasks_trace,

-- 
2.55.0

