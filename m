Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01434F96BA
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743027; cv=none; b=TConxNWBsQx+JQ20z7e96ilKfo0+bMV2StzwnC25FZIppYhTFbF8VnuFTO3iMWjrX5XjkDnpPaGp9C+2CmoUOl9y/Ue37CazZ7l17+Uq58eqbaf/ddUuWJN2EcggQVF7pz2VYwG4zA70W7oXrFrkZMLxQi3BifSA30Y4oQKuhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743027; c=relaxed/simple;
	bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQKDEEClIbbyadIepvmItVQtZRKbQqz5Wylc7UwUNQqiOaaXYEQNGPXV6H3oNe7yWmvUef6uUY//u8/ETWNM8/IPU0PNg8dNI/1mnE0XHg4qlWXGrAKXhJfBNtTB+Btgxo9deGLOWEqneqC+Ak/e7G2WVAXXyO6UqCXE9jc+qSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FMenZX4f; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FMenZX4f"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso7068866d6.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789743005; x=1790347805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=FMenZX4fA7IYYaGVRJ74JORgL+Hbw07S5YoZW625s6FlgiimPPEplqFaCu1De7ETu4
         I56W5/QhtPJLAVld/nTmIBJ790mBWOk4n7LzyWhs6fxs4yoGOGz8+bA413+8tWlDifNi
         eGaqh5ZQLGJv6ATyMyx69py90tY3ihIdArxWnxgWnx20AoCpfJOmLXHZ6jPiqjewxtkl
         4hHaFlHfDqpjuhO/JTWOc9DzQIA5MDDBdiuvZ4pA2o70a/HyAJCwStZ7YEx1/81uitv+
         nayrgUTXY2IEJbJmPVoTWY8y9BjR4RcTR4F4zbD1VBRDOG+k+5ZFEiAh9VvJzwwtR+xc
         41bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743005; x=1790347805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=mu+S+nxxv5VYZoF35yfqqSUujUAYxxC9keACvA9eQCXWWwoBNeTCgqjluN6Nm8s5jS
         IUYgY950UEmNl3zrMixWUpLzJ5vCcA01BbckXkO4s4i039Df7JVdi0bv2A5fVqP20TRs
         XTwx2VMSuoN4KICFdyQdIp3rVj4YjlNcMlrVH2PjAiEf6rEr87pnYe/jBDtEPcOY7JQi
         IpeyEqWnWGX0wbByMJ7MrrEzXXvuFFJlyyK+Wl38VwhlUoqpPCJr0D4QMJlegK3B54K2
         dcUxFc+UGTwO1PvE6tcYTRt03G5cIb7jiQTvNGFaekmDORxz/6zYSesnXTIUSgs1YUvQ
         p+3g==
X-Forwarded-Encrypted: i=1; AKwUvByJyYwGakzdiv4muWREvwp4gT3bEAUC683uuZsV/ra7pQHAUuBZ4QBZa19UKJAJDYhGsYU=@vger.kernel.org
X-Gm-Message-State: AFuF++nIvZAeBZxNsIa5GiIBeCcsFDG7CWTtwrxT/6tN1MmMzXQLDVyv
	dWWY3sj/JOzibsLWnGF609IoP1w2cn/3zo9X5QDd1MUAPsAjeey4iaC/Eh7zSNIHV4w=
X-Gm-Gg: AYBFou39Q1lZTQ32V3GXqsnZvatcE3Dq1HOUnmVBcFWWO4TR2th/3aVgwtF100OVg2G
	YvPJ/yCY19lWF5IUwea4GfrdIL1Utezv92R+fhxhNRxLHtA0OOOy+izYI/deiPUxejAOj9bBzl6
	5U9p7OghPMkfs/1ST36+syuPdeOV4BhZbDYq53VSub9j5kmKMapnrmiyM1qgjmu8Agf1Tvy9SV4
	Z/V5QyAwgsEdbF1Rpyn1eExnYsgZGuL/22wX5gBCgjG1aGvaLbXHSlU4gN7UBZZOx2FhDVnL5as
	fzZzGwJJMVagbrCIVm4feRG0RasTII9pQ2gZ3tKGdjoxqMhZwf6mzncmpBXT/CSxsM6SAFLxj/u
	/pLTHQlWc1HFA8L/oTeEDnA8+wXpBbjCi66jwb2Uxh5Kluv7d9HLKVQxO11X3rg2kCY0THkwWgg
	Dm+8dvNajpM/Gs8+pR7bZD+ccVRzJJ9MzCwympnQTgU0pMcTLllzBXvbPqAEfmkJnrxLH097z8s
	GjT3QA4WTnbql7yrUO2xDtegSZaMSESxW0/v2cqKgNcpW+x1w9Iid51
X-Received: by 2002:a05:6214:1307:b0:910:4a86:5969 with SMTP id 6a1803df08f44-91254bd5293mr46077526d6.23.1789743004909;
        Fri, 18 Sep 2026 07:50:04 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91258056195sm14090716d6.29.2026.09.18.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:50:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:30 +0000
Subject: [PATCH RFC v4 11/13] rcutorture: Make Tasks RCU readers Tasks
 Trace readers where required
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-11-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=1716;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCK2SKWNSvb8uUIHABRfNQrEJPCWCZeIZnAqX/3f5X/BpUmomCy4y1MVWrdYzX/ihyvEJhShdIA
 kincQ831+1ws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rcutorture's "tasks" flavor has empty readlock/readunlock hooks because
a classic Tasks RCU reader is simply code that does not block.  Under
CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption outside trampoline text
is also a quiescent state, and the thing real readers (trampolines) do
to stay protected across their call-outs is take rcu_read_lock_trace(),
so have the torture readers do the same there.  Otherwise a preempted
torture reader would rightly be treated as quiescent and the test would
report false-positive too-short grace periods.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..ab870ef09af0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1142,13 +1142,23 @@ static struct rcu_torture_ops trivial_preempt_ops = {
  * Definitions for RCU-tasks torture testing.
  */
 
+/*
+ * A classic Tasks RCU reader is any stretch of kernel code that does not
+ * voluntarily block.  With CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption
+ * outside trampoline text also ends it, and what a trampoline does to stay
+ * protected across its call-out is take a Tasks Trace reader, so model that.
+ */
 static int tasks_torture_read_lock(void)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_lock_trace();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_unlock_trace();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

