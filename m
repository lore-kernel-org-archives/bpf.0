Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED315D723
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403506; cv=none; b=gvfgzVzg284PA5pNgvSJRHflAD8jXbAwidSr39s9262BNe+Z9EhNEi4Cbp6aTFglWiHsJEBm0VUu6FkTxUx1ndxhQRurJ8ELj6m0Boxmc7GpZ52/H4tpjNscd9bOF/Pog1zP3+anxi34/sgxdeH/Wpo9lfyTN/gb1HlArOt8Jlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403506; c=relaxed/simple;
	bh=MIR1MjX6ng1gKHee2a5R5770ndkV58F1dCoJiFcEgYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUaFEhwGfOqmmtf1rhHBNrVmtmtqv3qDtSsnSExC0itPaEwNRtfpmJAJv7KtLWDzKf3Z11NTHpzbEP3x2wpKJ9SB72S5ehlhMTMrkmtV/TUBE9Dzn5UQOSQnD9WT7kNebgoSL84VvdAJcAcWNl1t4UnY4B0bmhovM97ntOtZnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlNwVC6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlNwVC6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A97C43390;
	Mon, 25 Mar 2024 21:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711403506;
	bh=MIR1MjX6ng1gKHee2a5R5770ndkV58F1dCoJiFcEgYw=;
	h=From:To:Cc:Subject:Date:From;
	b=YlNwVC6FknjM64W0+5m7tsB2CMrBAkNB4xaoQQ0vWybijBaceNVgsv0zgGDjoeUGK
	 vYoJCUfZ4Da8KU97eSp966fHjeJmluXRGgSFLaKkXWDhhudEBSEeT00uGqoAeWunXm
	 F5hKZCHyIW7pw2QVa2HxXEbIBifz3qRV4lYHTcK9tRgmkQV3xAvX247JX3vN0Cop4m
	 f6eplmczqtddTv2GTfaghOWuuOx4zlarwm9x65B9LwbY+uSZ5w7lAC6E0be7WoUjSg
	 CKq1x9+nBdFutmoBHBXrKyxQwAxDDMOA7KvX9MNZBHIjObijL9MKPn2Pe/eLZO1eoS
	 LZvsJSb/I2B0Q==
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
Subject: [PATCH RFC bpf-next] bpf: defer bpf_link dealloc to after RCU grace period
Date: Mon, 25 Mar 2024 14:51:44 -0700
Message-ID: <20240325215144.3786732-1-andrii@kernel.org>
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
that could be still active BPF programs running accessing link data
(cookie, program pointer, etc).

This patch accommodates this by delaying freeing memory to after RCU GP,
which will fix BPF raw tp, multi-kprobe, and non-sleepable multi-uprobe.

Perhaps a better approach would be to have a per-link flag specifying
desired behavior: no delay, RCU delay, or task_trace RCU delay? So
sending this as an RFC fix to discuss desired final solution.

Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggering raw tracepoint")
Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h  |  8 +++++++-
 kernel/bpf/syscall.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 62762390c93d..d73a8978c800 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1573,7 +1573,13 @@ struct bpf_link {
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e44c276e8617..af1591af10bb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3024,6 +3024,14 @@ void bpf_link_inc(struct bpf_link *link)
 	atomic64_inc(&link->refcnt);
 }
 
+static void bpf_link_dealloc_deferred(struct rcu_head *rcu)
+{
+	struct bpf_link *link = container_of(rcu, struct bpf_link, rcu);
+
+	/* free bpf_link and its containing memory */
+	link->ops->dealloc(link);
+}
+
 /* bpf_link_free is guaranteed to be called from process context */
 static void bpf_link_free(struct bpf_link *link)
 {
@@ -3033,8 +3041,8 @@ static void bpf_link_free(struct bpf_link *link)
 		link->ops->release(link);
 		bpf_prog_put(link->prog);
 	}
-	/* free bpf_link and its containing memory */
-	link->ops->dealloc(link);
+	/* schedule BPF link deallocation after RCU grace period */
+	call_rcu(&link->rcu, bpf_link_dealloc_deferred);
 }
 
 static void bpf_link_put_deferred(struct work_struct *work)
-- 
2.43.0

