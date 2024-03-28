Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D31D304
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603471; cv=none; b=gODYoRN+Z9IAB43i2oSTU5TPBCOxXu4r/vIBxMddrta6NtvSrG+Y3ska070oQ1fA9oLBXrjUCdxjLV+vc3/5gM+2ZwxDMqh0cU0nPKUXMu/zG27NFNjlus95dsuVLEjbZ5x9rAEZHY+pSh7+0cBQ3ft2Xh4SPNUrv+aHpvl9evI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603471; c=relaxed/simple;
	bh=VvTxEpRDHenVal2cnBP1M/liz0uUT8yfZ/ZDo3VNSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH1snWiVTQalmWuhqC44VjP+x3UrE1D41UyGZtGzlJ4hL49e05QJfRWP4UnVWa2OMKLKFVTJTuOqGIMZdnMW5oRB0M2XeXLocsKOmyJholnw1FeiwxDrZrSI5vGcKFwFDRgjUNw4H7djR3yIUTBSanTobmpCKPp7TKskcPAawDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icOXT7ze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icOXT7ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27435C433F1;
	Thu, 28 Mar 2024 05:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711603471;
	bh=VvTxEpRDHenVal2cnBP1M/liz0uUT8yfZ/ZDo3VNSRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icOXT7zebcEs7AeJ6bsrdYLEiEtGYq90f6CVQ8rWRCcXVKMhNzYPdOqbrtVUiwk/y
	 ZazJSVenUITcTXBlaAEoAX22+vz8mKvb8MI4y+raC2EvtMg/23cYpxuHju71rvKxzC
	 bKDMgz9l31IN+AGcJq2q5w4mZA7sfi8QsTAiHacaUrhTdxUfcCCiF/kP5hCioZQEZH
	 5YbeL6DQWFKrYXYsYAUXANhXH9cFkKCHsRF2NqTSgklNAKCgW1PkEx2rZDTpLNQvbh
	 0cSKLYdf37sZdWFNJM65UPxS35p579UulFlNNA3uEmk1uqW6eoaVowWb17tRR7hyXT
	 P84ds63mKybFQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com,
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com,
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Subject: [PATCH bpf 2/2] bpf: support deferring bpf_link dealloc to after RCU grace period
Date: Wed, 27 Mar 2024 22:24:26 -0700
Message-ID: <20240328052426.3042617-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328052426.3042617-1-andrii@kernel.org>
References: <20240328052426.3042617-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF link for some program types is passed as a "context" which can be
used by those BPF programs to look up additional information. E.g., for
multi-kprobes and multi-uprobes, link is used to fetch BPF cookie values.

Because of this runtime dependency, when bpf_link refcnt drops to zero
there could still be active BPF programs running accessing link data.

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

We use this for multi-kprobe and multi-uprobe links, which dereference
link during program run. We also preventively switch raw_tp link to use
deferred dealloc callback, as upcoming changes in bpf-next tree expose
raw_tp link data (specifically, cookie value) to BPF program at runtime
as well.

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
index 4f20f62f9d63..890e152d553e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1574,12 +1574,26 @@ struct bpf_link {
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
index ae2ff73bde7e..c287925471f6 100644
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
@@ -3544,7 +3573,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
 	.release = bpf_raw_tp_link_release,
-	.dealloc = bpf_raw_tp_link_dealloc,
+	.dealloc_deferred = bpf_raw_tp_link_dealloc,
 	.show_fdinfo = bpf_raw_tp_link_show_fdinfo,
 	.fill_link_info = bpf_raw_tp_link_fill_link_info,
 };
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b73fe5f7206..9dc605f08a23 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2728,7 +2728,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
-	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
 	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
@@ -3242,7 +3242,7 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
-	.dealloc = bpf_uprobe_multi_link_dealloc,
+	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
 	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
 };
 
-- 
2.43.0

