Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CD2D060D
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330639; cv=none; b=AGFlshk7uGpC6LQWFmkzwa3y/p5x/+E2iR38gydkj/BYXXVwlmqxRlVaQOOZdxqT01+USEheqRSwA2slF4r8RDkunHW0aAGs11lw66WFQjyf/iAK6C/Pc2XDq+YDuM0UoSxWuO59K0xh6DWNqFPXdc4PI/RtEyuCnVMlAfJ1xK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330639; c=relaxed/simple;
	bh=dfiJmNLHMOX3zU/mwkfT6hvb6DEunLZtzXh9pWRH0u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5lAMioidVUFknmUS0fahb76J3XohnfRqBFE11gAk88/1jF/eMkX7FmQQ/FPhAzqn8k7Zen9KVfr4oJSSotVrL1aSD/Ps5nT+Fn/v+6CB4w4proz86QmEE/2GxnyFLJDyCwTEzXckWipw4UROQKNBxmihdCSJRHLwGEUlshPdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DOjEINj8; arc=none smtp.client-ip=95.215.58.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DOjEINj8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dfiJmNLHMOX3zU/mwkfT6hvb6DEunLZtzXh9pWRH0u8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790330634; v=1; x=1790935434;
 b=DOjEINj8C2Vv3HClVWhdd2rMXUOc9m63oIhAszv8XN1V5hEYWAUXCbnMWW8qVzxc5O7Iblic
 QSCFgOvmDjZ28otVcXhjmpplNu8m76tFHJ2uWMa4whUVNjdzuiruaXrd2a/bip6CM5/wgkHkAQH
 LKdtRpZkYXxRxfDGNkQFIWmU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6c555714e503276f;
	Fri, 25 Sep 2026 10:03:54 +0000
X-Mizu-Trace-ID: 6c555714e503276f
X-Migadu-Flow: FLOW_OUT
From: "Florent Revest (Anthropic)" <florent.revest@linux.dev>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Junseo Lim <zirajs7@gmail.com>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v4 1/3] bpf: Wait for an RCU tasks grace period before freeing trampoline progs
Date: Fri, 25 Sep 2026 10:03:30 +0000
Message-ID: <20260925100342.481242-2-florent.revest@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925100342.481242-1-florent.revest@linux.dev>
References: <20260925100342.481242-1-florent.revest@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a prog is detached from a trampoline, it is freed after an RCU
grace period, or an RCU tasks trace one if it is sleepable. This covers
the tasks that are running the prog, since the prog's enter helper takes
the matching read lock before the prog is called. On a preemptible
kernel, it doesn't cover a task that was preempted in the trampoline
just before the enter helper. That task holds no lock yet, and it calls
the prog after it was freed:

  BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0x3a5/0x3f0
  Read of size 8 at addr ffffc90000055040 by task candidate/110
  CPU: 1 UID: 0 PID: 110 Comm: candidate Not tainted 7.3.0-rc2-00014-g15071f2a1263-dirty #2 PREEMPT(full)
  Call Trace:
   <TASK>
   __bpf_prog_enter_recur+0x3a5/0x3f0
   bpf_trampoline_6442509193+0x37/0xf1
   __x64_sys_futex+0x9/0x410
   do_syscall_64+0xb0/0x530
   ...

Wait for an RCU tasks grace period before the existing one when freeing
a prog that was linked to a trampoline. An RCU tasks grace period only
ends once the tasks that were preempted have run again, and
bpf_tramp_image_put() already relies on it to free the image. It doesn't
wait for tasks that sleep in the trampoline, the next commit takes care
of those.

Only progs that were linked to a trampoline can be called this way, so
bpf_trampoline_add_prog() marks them and other progs are still freed as
before.

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Reported-by: Junseo Lim <zirajs7@gmail.com>
Closes: https://lore.kernel.org/bpf/aqdrwVpanH3WGurX@omen-arch/
Assisted-by: Claude:unspecified
Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
---
 include/linux/bpf.h     |  1 +
 kernel/bpf/syscall.c    | 19 ++++++++++++++++++-
 kernel/bpf/trampoline.c |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1d2676782d70..d4f732996b47 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1770,6 +1770,7 @@ struct bpf_prog_aux {
 	bool offload_requested; /* Program is bound and offloaded to the netdev. */
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
 	bool attach_tracing_prog; /* true if tracing another tracing program */
+	bool tramp_linked; /* true if it was ever called from a trampoline */
 	bool func_proto_unreliable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 244a939b9d2d..96217b99399d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2448,6 +2448,21 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	bpf_prog_free(aux->prog);
 }
 
+/*
+ * Progs called from a trampoline can also be reached by a task that was
+ * preempted in the trampoline before the prog's enter helper took its RCU
+ * read lock, wait for those first.
+ */
+static void __bpf_prog_put_rcu_tasks(struct rcu_head *rcu)
+{
+	struct bpf_prog *prog = container_of(rcu, struct bpf_prog_aux, rcu)->prog;
+
+	if (prog->sleepable)
+		call_rcu_tasks_trace(rcu, __bpf_prog_put_rcu);
+	else
+		call_rcu(rcu, __bpf_prog_put_rcu);
+}
+
 static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
 	bpf_prog_kallsyms_del_all(prog);
@@ -2461,7 +2476,9 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 		btf_put(prog->aux->attach_btf);
 
 	if (deferred) {
-		if (prog->sleepable)
+		if (IS_ENABLED(CONFIG_TASKS_RCU) && prog->aux->tramp_linked)
+			call_rcu_tasks(&prog->aux->rcu, __bpf_prog_put_rcu_tasks);
+		else if (prog->sleepable)
 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
 		else
 			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 90b70ea0d370..9d69c066a817 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -907,6 +907,7 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 	}
 
 	hlist_add_head(&node->tramp_hlist, prog_list);
+	node->link->prog->aux->tramp_linked = true;
 	if (kind == BPF_TRAMP_FSESSION) {
 		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
 		fexit = fsession_exit(node);
-- 
2.55.0

