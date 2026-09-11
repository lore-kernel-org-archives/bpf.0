Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02C36EAB1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135825; cv=none; b=X0gVXvdN/j02eNLvw5U86xbutWBeXf0k20kFTrW5W5yQmjMWuBhPDqxkryLLDNq+XetS9nUaVBbSp/waD9/moRNzw0/+/rb/xb5f0+XdjNNLe+EUuEIAaBkeZGF72BvdmVMvOC9+3SwGrehW9DL7r9M2BmHP6X4RaH09JQV1wEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135825; c=relaxed/simple;
	bh=c9hUQ9kAAl2b2IbncqDZq1k2ejJxuc1g83EyvfAIkis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwFqxGaWT6BlxMUTjyK7SLKRC30SCjtJLLMeXapk8i/ZGit7i5I4ZalOcmrbtLg4/XTGFkzbvbFPTyKDM1486Y1fcHyXUcgJHXSEy2hgKb8D+MQ+R/jKplqxLmYzqv71n14rEZWA31rXuXy/13awcTPrTcYyZ6FNxyfpb0Pqli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=VNKysXO3; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="VNKysXO3"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so93512685a.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135821; x=1789740621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=VNKysXO35hDRh0I5aaik3B+ZyQfCj/A/akUeSWwO4t2rLjIxuWhPn+XPKU7gnGywL3
         lG8fEKUQC7QElqObZ/b7r5Ip7EIJO13BG03nXDxPK2pGwu8aeUNKR93XiG4KF0VzFvws
         nlCDPYyeCxTBoVXwy/8O2LmEYq0pnIuyJ+tKpthhet9V30qNJXTmbhJgiRASHmq6cfbS
         Q/coTcxK4ImFJ2+MaByBx8YRIUAo0f0lnheaKFvC1i2EQ2TFNZlBVQ9LvXPZKPBALc4h
         X1/IYd9gJBBR8JgQ7InEmdp4f+BNcd7l6jbrB1/TTUmuDzCUYJq+0KZMA9NtqZnErt1h
         gqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135821; x=1789740621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=L01IRhU9iFxFcAYuEXQ+vnABIO180o2zexDNcGfDIn/aBgj6iO1inZr3FyOMHsERmM
         4JV4DuTqf0VHA+Q4rU+uDj8zh2ySVD8otH0r/pXRU4JGLQNeABivyWKptBX3MRXCpe7v
         q4qwNJMQZLPPyG4i1d1GOC6Rn9SpBA3ws7+SsrV9YdAGnpsKnX2DhCHX4KDeWhO7FeRF
         Vh1TU5omPawMhp6eUhBIcR/9CHF2lFEMb3+mS1YU++YH/efEwsYS6beUnqSE0UFxceoD
         gia3MZggFiHPRhj9kM+uK01WZxZYtrVbSST4dBBhbykUliRbcJ5zpUP2WS+ovAiHw5Ts
         Qurg==
X-Forwarded-Encrypted: i=1; AKwUvBwLsjCy3I5PDGm9tdV9N8QutBhZH1rBM37Rm0OhLdXpOPo76i3s++0n/TGQ8JB987xlc5A=@vger.kernel.org
X-Gm-Message-State: AFuF++kByW02IVgvZ8XEumN5GdpG8isljWO2jIApZYPbebaW1prIyDZ+
	VS+2d1T3zTRXDKwYdA8cUS9zlM8t6K7YCV8ABJ6idB6sMUWC/DiO6PfD9F63bScC+vM=
X-Gm-Gg: AYBFou3v+/eHhVPZV2iH6hZn4WQ4mlN82gWK6MOyBIt3IbF2ZQ3zcY5cNIqd11pxq75
	zsCnYshNXMFcaYZpXgcjeEXAjAqFQ5nWIL2scxCGqJWlCNL7fhwLhTaqENaqkzholRCByda9SB9
	JTvVkn+67tK23qXJd0mffMa/iCSIdQEJqycLW7VV48+Bo5icgJkJFfpKo0/gF3ssoTOvZ4CuU3r
	OQy7+1Ph6j7vOt1ztOu2GBiq0OOhzNRAU3dGezwvHaLQlx063ApaJMaQ1Bo4I61CKEBI5IW4Umw
	1T06vgdwEFl0OoF/5z699jBzXVsN5Mb9nazJUpmu/mohDDwUkKglyjR+Tu30pelmyWNkd24yWvZ
	HR2UtALZBne7Ckn8hAcImQyJ7KJ86w7tODCwKyIhlPiR/F28UG2fOKZW0SDb21/jkkOu6HdaqXE
	hHouwJChhBQ6zOBd4rFFs85tNtwVjk1/FOUEzOwr61+Djr6iyWa3BTuJlRr5Gsg7twbVtbzjVsT
	HyxpElP/G7NrnkLzKdUjBOVFGrwJTCqfpt/tl99vgMKCJMYkca66g5O
X-Received: by 2002:a05:620a:690e:b0:939:639b:2e1f with SMTP id af79cd13be357-939ea04922amr525733885a.7.1789135821311;
        Fri, 11 Sep 2026 07:10:21 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80dc002sm248697485a.39.2026.09.11.07.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:50 +0000
Subject: [PATCH RFC v2 12/15] rcutorture: Bracket Tasks RCU readers with
 trampoline nesting
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-12-eaaa61ed2da4@toxicpanda.com>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135737; l=1492;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=c9hUQ9kAAl2b2IbncqDZq1k2ejJxuc1g83EyvfAIkis=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDpeCdAsuDTbsWwi8oqAy5KN1IjS7Ye/ysM/qLEJAJ0SGsvHuCkttXUFQ2AlX09A0IwbwXmGUQ4
 qHaGMzc7/Vgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rcutorture's tasks flavor models a Tasks RCU reader as "any stretch of
kernel code", and rcu_read_delay() deliberately preempts inside it to
check that a preemption does not end the read-side critical section.
Once preemption outside a trampoline becomes a quiescent state that
model no longer matches what Tasks RCU protects, and the readers would
report false too-short grace periods.

Have tasks_torture_read_lock()/unlock() raise and drop
current->rcu_tramp_nesting so the reader models a trampoline, which is
the thing Tasks RCU actually guards; the deliberate preemption inside it
then continues to be, correctly, not a quiescent state.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..df6dd708cea7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1144,11 +1144,17 @@ static struct rcu_torture_ops trivial_preempt_ops = {
 
 static int tasks_torture_read_lock(void)
 {
+	/*
+	 * Model a trampoline: with CONFIG_RCU_TASKS_PREEMPT_QS a preemption is
+	 * otherwise a quiescent state and rcu_read_delay() preempts on purpose.
+	 */
+	rcu_tasks_trampoline_enter();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	rcu_tasks_trampoline_exit();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

