Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A511E884
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487669; cv=none; b=TiWjQCwYvNzAdfrehUy4vKw6qE5xb+/gdKHhLHw7h6l1dJIP/Sd9CrsMsj7NK+jOnN53vvjEogda40d0K0GXo12q71/X9ox5D47jTG9m6WGrm9fmsg+hwHSks+Jlw5vAGnUlJI4LshKEWUyC4Ya2wq2divdILs9c8u14UkM+zps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487669; c=relaxed/simple;
	bh=58aFIKSi458V7TUHnLL5RqixIfUfVYXZDpEdTaGJsQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPL3xTYZ7Rl2fzCOIE82J/zom7OeFwtITMI7Ol1MzIMfpoyn5Md9yUQvxTfcPDh0eI0J5qzNc5qn0mR0b5ReEIX3HcIALdTkUhSDHub8CzRJ7bnlIXRI4gWLuFoEZgU0zJCONwaEJ6vcMfFLXm/zlK956hyzVEytFtA60pokvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTXzrs+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTXzrs+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ED6C433C7;
	Tue, 26 Mar 2024 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487669;
	bh=58aFIKSi458V7TUHnLL5RqixIfUfVYXZDpEdTaGJsQc=;
	h=From:To:Cc:Subject:Date:From;
	b=CTXzrs+0l/1V1j90RaVVT/iFIB2VyeE1ocZwuLphbHXWRBcVhx5rAnCNoDdIKvEIA
	 alyLMVgzNBmUemC1vDaOrGfAEK+PBllxxMSznHeidA25EJFv5C0vQlEswwob4WpNMi
	 cZZO0vizH0SfzZ9bWK8oQHyBJRkTa66qwpADwDtMCdPKrW3cdDg79Kbll/0daTCsgO
	 geDAAHflnHxp6QXTtzjT+131CYEh9Ih9T5FcQSOTg5OR01mroq0B6WN/HMQnjLH5sB
	 8gRSj3ZiUbr52djPQHwWVz2VKCmLeC21jLlTDgJYAhukmjq46ptgaeBgbPr0OI3XlH
	 FjU7xrdl78Slw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com,
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com,
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Subject: [PATCH bpf-next] bpf: support deferring bpf_link dealloc to after RCU grace period
Date: Tue, 26 Mar 2024 14:14:27 -0700
Message-ID: <20240326211427.1156080-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF link for some program types is passed as a "context" which can be
used by those BPF programs to look up additional information. E.g., for
BPF raw tracepoints, link is used to fetch BPF cookie value, similarly
for BPF multi-kprobes and multi-uprobes.

Because of this runtime dependency, when bpf_link refcnt drops to zero
there could still be active BPF programs running accessing link data
(cookie, program pointer, etc).

This patch adds generic support to defer bpf_link dealloc callback to
after RCU GP, if requested. This is done by exposing two different
deallocation callbacks, one synchronous and one deferred. If deferred
one is provided, bpf_link_free() will schedule dealloc_deferred()
callback to happen after RCU GP.

BPF is using two flavors of RCU: "classic" non-sleepable one and RCU
tasks trace one. The latter is used when sleepable BPF programs are
used. bpf_link_free() accommodates that by checking underlying BPF
program's sleepable flag, and goes either through normal RCU GP only for
non-sleepable, or through RCU tasks trace GP *and* then normal RCU GP
(taking into account rcu_trace_implies_rcu_gp() optimization), if BPF
program is sleepable.

We use this for raw tracepoint, multi-kprobe, and multi-uprobe links,
all of which dereference link during program run.

Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggering raw tracepoint")
Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h      | 16 +++++++++++++++-
 kernel/bpf/syscall.c     | 35 ++++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c |  4 ++--
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 62762390c93d..e52d5b3ee45e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1573,12 +1573,26 @@ struct bpf_link {
 	enum bpf_link_type type;
 	const struct bpf_link_ops *ops;
 	struct bpf_prog *prog;
-	struct work_struct work;
+	/* rcu is used before freeing, work can be used to schedule that
+	 * RCU-based freeing before that, so they never overlap
+	 */
+	union {
+		struct rcu_head rcu;
+		struct work_struct work;
+	};
 };
 
 struct bpf_link_ops {
 	void (*release)(struct bpf_link *link);
+	/* deallocate link resources callback, called without RCU grace period
+	 * waiting
+	 */
 	void (*dealloc)(struct bpf_link *link);
+	/* deallocate link resources callback, called after RCU grace period;
+	 * if underlying BPF program is sleepable we go through tasks trace
+	 * RCU GP and then "classic" RCU GP
+	 */
+	void (*dealloc_deferred)(struct bpf_link *link);
 	int (*detach)(struct bpf_link *link);
 	int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_prog,
 			   struct bpf_prog *old_prog);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e44c276e8617..c0f2f052a02c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3024,17 +3024,46 @@ void bpf_link_inc(struct bpf_link *link)
 	atomic64_inc(&link->refcnt);
 }
 
+static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
+{
+	struct bpf_link *link = container_of(rcu, struct bpf_link, rcu);
+
+	/* free bpf_link and its containing memory */
+	link->ops->dealloc_deferred(link);
+}
+
+static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		bpf_link_defer_dealloc_rcu_gp(rcu);
+	else
+		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
+}
+
 /* bpf_link_free is guaranteed to be called from process context */
 static void bpf_link_free(struct bpf_link *link)
 {
+	bool sleepable = false;
+
 	bpf_link_free_id(link->id);
 	if (link->prog) {
+		sleepable = link->prog->sleepable;
 		/* detach BPF program, clean up used resources */
 		link->ops->release(link);
 		bpf_prog_put(link->prog);
 	}
-	/* free bpf_link and its containing memory */
-	link->ops->dealloc(link);
+	if (link->ops->dealloc_deferred) {
+		/* schedule BPF link deallocation; if underlying BPF program
+		 * is sleepable, we need to first wait for RCU tasks trace
+		 * sync, then go through "classic" RCU grace period
+		 */
+		if (sleepable)
+			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
+		else
+			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
+	}
+	if (link->ops->dealloc)
+		link->ops->dealloc(link);
 }
 
 static void bpf_link_put_deferred(struct work_struct *work)
@@ -3539,7 +3568,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
 	.release = bpf_raw_tp_link_release,
-	.dealloc = bpf_raw_tp_link_dealloc,
+	.dealloc_deferred = bpf_raw_tp_link_dealloc,
 	.show_fdinfo = bpf_raw_tp_link_show_fdinfo,
 	.fill_link_info = bpf_raw_tp_link_fill_link_info,
 };
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6d0c95638e1b..98eacfacb73a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2740,7 +2740,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
-	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
 	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
@@ -3254,7 +3254,7 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
-	.dealloc = bpf_uprobe_multi_link_dealloc,
+	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
 	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
 };
 
-- 
2.43.0

