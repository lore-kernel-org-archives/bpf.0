Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795846826;
	b=bOwk6hkW+Ydw1ul3udjKjl1/8eZYmDnTdoE2Y9YV+TCuXnN/7mVJ7AKs128lvVBUE4pg
	 5lFAKJdhUNtz5dwNZ7GLOHKXnQSvwQrt9DRczvUd1KIYgZbfVdg8eH7ovJWpTo+ChhbWP
	 ht/R/Nb6F/SSr0bgLpi1ZCUXTI2x1qCzEtOk8yas505M5alFgpns2zyxKRpHIQwYW2TkJ
	 4BDFGZUazH+IKHauPe9ZtWjRHMbZkYitZtDi8+C50O0eZeYbw2INyHNw6ynU51rZPZaw4
	 3V7HASRR7p2EeWi488eQMVeTIfR9RPwcX1QL1SdmydRFGh52HrH054/rBFjCSv5oSVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795846826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2hMGbCM5tB70FBdwb9zAs1NZJOT/JT/9Od6CekBUEzc=;
	b=xmkxigYstZ9jR35uA/Gi9PlLJBO6moWyCFfYg5ISoEu+HUS66BcnFRz5jg1TIbVBZLJK
	 8a17yWNQHbkHiLeOU7G8u3rh0xC1dentoFoYis+zYv3hvaiB63PK/SIcZp0Tz8jPkhXSX
	 NLZlq2KSy9fGIkFndzUeGKsqZhVAbO6avQhOEhfnYs9e2VbXIfW9hFAs5ViAzFLrmklgr
	 SvXRSZRSXV1zoIc5eM9nPDXJ4WMgP+0CdaTS1+FTS26M8zbZ3xHXjgYJySxUeELcobWL1
	 0+99RNuegJ30ufcejHc0SadqwAy17642yjhRp/my4B2NFJzN5PFq45FiQROqXGQRixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Prak9o+R;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27C606A31E
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 06:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB27C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Prak9o+R
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso7474932a91.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 22:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795846825; x=1796451625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hMGbCM5tB70FBdwb9zAs1NZJOT/JT/9Od6CekBUEzc=;
        b=Prak9o+RMwLOyAisXlGs9WAiPIXX6RSG2RFdsICD7cJpTtubAiSuZz1Vksg4WpjDc8
         BRWsJaaPbG7XoLe92Mv+C/BXf8THgs0uJ0uZpMFeYYhUHMm2p7WO+1mbddZvAj1uVVJ3
         SP8VWqY8VwZKpE0PqKNsQpvxDLHd6PXX1bq77qBbAzFGACnrS4/+biDTl57BCbmMSdNI
         mkohNqR4Mh0GoyX+Z+O1XVXXk+1QZxEPIcjWEvf7aXM3MyLwFuWYndrx5Ty9MFquX0y6
         0/BlJHEo615HqfrTEsJvEwTRL7sjxW1TPCqsWclVlmktRoBMt8foNPajsfbDGUDqn2/o
         n0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795846825; x=1796451625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hMGbCM5tB70FBdwb9zAs1NZJOT/JT/9Od6CekBUEzc=;
        b=S8fauXasrXAsqFJaU4bZDjUua5rPgrLIdr4dgQ9eSj+7jzEDCkIUjPDs64494YFa7x
         7N9w4jse9e2LVuVfUCQvk5IHLlyX3u7fUKoaJKyZYHaqISUSCUnjHMpe6TSDMYRO3UfT
         vhARuBvYemK/IXDMoV60Wvwo3hXQCj0Jr/tHZaRYLn3YsWd0yRliJZpvD/QqPfIQDGp+
         JCvAHvUFD+iqL+3oHRdT9CU1AwSLyohJoV7KbGsRRUIzbiTuIcOjR5d0b5v9KhIb3Bsa
         IraOnj8h9yBOsAhLv9r1GaQAhNDIwTVCchAJ3wPNXFKyGj+LzbZMlu9aAIEeFbDG+X5N
         +JCA==
X-Forwarded-Encrypted: i=1; AL+hErGPFYGTZs/bRYnHp1snCpiUCf9V7pCZQq8KcLpRBLyOSmhUANREzn0ch/9xmYNkKIcQqFc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pDSereK0Iex3+3mYHKehlv5lVf8loO562gWR+Irm+QsXEjfs/
	BLpEnbAZzcPVLXwl7qTO5fcu8CS/Z7mcE/bvEbqtwm9mugD2TUmwM8Yh
X-Gm-Gg: AZFdTZcA52HexjCkIGp7Z0qbk7zIg/7BfL4kO7hAYGmplPS1je/BNhlq8UnYWUKG6uJ
	gXsoCaTI4ikh91jeUUUfX25PwxT9K4lchS/qT51Ti57bjZuRe+3OaLVL8GxROp17Qo/oqgBnAqG
	q361f4Ygn3o+xT4iI7xd1FE99uYGRW8eG3LubX1MIJfE4fDH1LbwBubrMsLJyWQidwuiMkS2bUn
	79fsHbkFqmra3qI38eNyV5nUcqDMDOpguVs35wI0QtnKL2aa7cpqHrMEVKvRNyAPGA0ffPjblB2
	knRqtiGFkqwpAgSjKeyBDYa0PclyLX20LnK8m8fLTULz8QYhPbjibKe0Fw+zBkkU5B/sfSIV48I
	qTuq8PrflY7a+tVvGO9YxGXPo6AnOWTPJYjl/P3dQW6anYcWXYC/Qkfn5Lbitl16Z/oGBPzZJE5
	RVOVDTvnH1gvKaJj8fDocWdqrKSqCUS4GFdHHQfK5W7XV1DvF/bCtFqsBSLzZ61kIn+HUu1RirR
	LDMS5vLV5N3tj2h1w0xOHk8iScsl/hGvJvyiF5qk+7FjZBzOwH+bMRga6znAYSU9L+QCC8NdKr3
	kdve1QyBSu+G3gpRszq7L2XBTMsqrIHL0eOZ0V1/qRj1F5CHi4F9S9cHn3f7giSb
X-Received: by 2002:a17:90b:5350:b0:3b3:b414:9aaf with SMTP id 98e67ed59e1d1-3b41c93b4admr17215431a91.27.1795846825015;
        Fri, 27 Nov 2026 22:20:25 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm32008126a91.9.2026.11.27.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:20:24 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bradley Morgan <bradley.morgan@linux.dev>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] rcu: Mark rcu_read_unlock_special() notrace
Date: Sat, 28 Nov 2026 06:19:26 +0000
Message-ID: <20261128061955.174288-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The BPF trampoline takes and drops the RCU read lock itself. When the
outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
calls rcu_read_unlock_special(). If an fentry program is attached to
rcu_read_unlock_special(), the unlock on the trampoline exit path still
sees .s set and calls rcu_read_unlock_special() again, which recurses
until the stack overflows:

  BUG: TASK stack guard page was hit at ffffc90001657ff8
  ...
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   __rcu_read_unlock+0x9c/0x120
   rcu_read_unlock_migrate+0x93/0x220
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   ...

With fexit it recurses even earlier, from percpu_ref_get() in
__bpf_tramp_enter(), which takes and drops the RCU read lock before the
program runs.

Mark rcu_read_unlock_special() notrace. rcu_unlock_needs_exp_handling()
also runs with .s set, so mark it notrace too.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v4:
- Go back to notrace as in v1
- Also mark rcu_unlock_needs_exp_handling() notrace (Alexei)

v3: https://lore.kernel.org/bpf/20261125055359.2715140-1-rhkrqnwk98@gmail.com/
v2: https://lore.kernel.org/bpf/20261125040106.2200628-1-rhkrqnwk98@gmail.com/
v1: https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/

 kernel/rcu/tree_plugin.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3500e4874833..9c1b227f5fa0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -689,10 +689,10 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  *
  * Returns true if expedited processing of the rcu_read_unlock() is needed.
  */
-static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
-				      struct rcu_data *rdp,
-				      struct rcu_node *rnp,
-				      bool irqs_were_disabled)
+static notrace bool rcu_unlock_needs_exp_handling(struct task_struct *t,
+						  struct rcu_data *rdp,
+						  struct rcu_node *rnp,
+						  bool irqs_were_disabled)
 {
 	/*
 	 * Check if this task is blocking an expedited grace period. If the
@@ -746,7 +746,7 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static notrace void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
 	bool irqs_were_disabled;

base-commit: 2348d158c7fcc2c9557b2fb550ee841c62942fbd
-- 
2.56.1

