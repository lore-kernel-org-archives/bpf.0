Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FE3793B4;
	Sat,  6 Jun 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749693; cv=none; b=ovai54xuascZ8HJfDD4IMPjTRq72gd9PA16GzaukXfB5aUNjsVpXYswqXm0QVEakl1j9vtwQq92/tQvhoBugRb2MlBpKD8ZdTOh1mJYNJE5c1Ugnu2ThdJbopSPo14Ppa8FW500iJ2Ww07Ms/Ytef/rxOBOeTh33/79iukCCJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749693; c=relaxed/simple;
	bh=O1Pc5lcLWE2pSd2wOXc116jeUH8rDngK8L1skWPnly0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQJgunT+zECTk+tFQ5pj7l2tTQOz0ZPADYUEtKAMDq+QQKR4yeBc6NelrzxqZl9JfMqvEZGfmql9133lr1ydYVm1Wu83YXUDOeMEFMB58i+LGGRdoR4GrIfxMU34RhYFJo6PFlRatmo3cTyin5I2azSbRaYIUwRWz7Wko/r+ORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7JeD4VU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7JeD4VU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC1C1F00893;
	Sat,  6 Jun 2026 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749692;
	bh=DeKecUQt28dZDycLC5NiginJqqmE4FbAC9UTHOPM+5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7JeD4VUyr+zlUQsk7Ke9NxLFeDLrQZ0Jg+8vWhQhXxiI3fm0aZMILKryxhhZS2rl
	 WRsYR6bat/pOFDeqGRVwkkPfzlnA/8hFDOEJlAA6mUbpEpZjwMmPrqZ19tX1KJGS25
	 AxNWZ0xfrnYU2nVUfQS0shANfP/PWLDeBihpkd6sjpeL47pTd/xipYGXym0HvcEGuN
	 KFE3rtLZy4OjbNcpK8Rb8Vr8H7vOFdET/VSMMiCli5LqSyx6RBGpYNxziL0JQjSuXc
	 oRU9nbKkiZXI02ugRZwQKa3/vZo3PU6K/Fj2RDvdkcUls4LrcdAm7TkzLfRDQEyEdT
	 G2zL15VviF2aQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 09/29] bpf: Factor fsession link to use struct bpf_tramp_node
Date: Sat,  6 Jun 2026 14:39:34 +0200
Message-ID: <20260606123955.345967-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we split trampoline attachment object (bpf_tramp_node) from
the link object (bpf_tramp_link) we can use bpf_tramp_node as fsession's
fexit attachment object and get rid of the bpf_fsession_link object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  6 +-----
 kernel/bpf/syscall.c    | 21 ++++++---------------
 kernel/bpf/trampoline.c | 12 ++++++------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6ff35491d9c0..428789a9e736 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1927,15 +1927,11 @@ struct bpf_shim_tramp_link {
 
 struct bpf_tracing_link {
 	struct bpf_tramp_link link;
+	struct bpf_tramp_node fexit;
 	struct bpf_trampoline *trampoline;
 	struct bpf_prog *tgt_prog;
 };
 
-struct bpf_fsession_link {
-	struct bpf_tracing_link link;
-	struct bpf_tramp_link fexit;
-};
-
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fd69fdb9290b..0cfc8bcb3dc9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3730,21 +3730,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
 	}
 
-	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
-		struct bpf_fsession_link *fslink;
-
-		fslink = kzalloc_obj(*fslink, GFP_USER);
-		if (fslink) {
-			bpf_tramp_link_init(&fslink->fexit, BPF_LINK_TYPE_TRACING,
-					    &bpf_tracing_link_lops, prog, attach_type,
-					    bpf_cookie);
-			link = &fslink->link;
-		} else {
-			link = NULL;
-		}
-	} else {
-		link = kzalloc_obj(*link, GFP_USER);
-	}
+	link = kzalloc_obj(*link, GFP_USER);
 	if (!link) {
 		err = -ENOMEM;
 		goto out_put_prog;
@@ -3752,6 +3738,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	bpf_tramp_link_init(&link->link, BPF_LINK_TYPE_TRACING,
 			    &bpf_tracing_link_lops, prog, attach_type, bpf_cookie);
 
+	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		link->fexit.link = &link->link.link;
+		link->fexit.cookie = bpf_cookie;
+	}
+
 	mutex_lock(&prog->aux->dst_mutex);
 
 	/* There are a few possible cases here:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 6a45c09fc0d8..5776d2b8e36e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -823,7 +823,7 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 				   struct bpf_tramp_node *node,
 				   int cnt)
 {
-	struct bpf_fsession_link *fslink = NULL;
+	struct bpf_tracing_link *tr_link = NULL;
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_node *node_existing;
 	struct hlist_head *prog_list;
@@ -850,8 +850,8 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 	hlist_add_head(&node->tramp_hlist, prog_list);
 	if (kind == BPF_TRAMP_FSESSION) {
 		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
-		fslink = container_of(node, struct bpf_fsession_link, link.link.node);
-		hlist_add_head(&fslink->fexit.node.tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		tr_link = container_of(node, struct bpf_tracing_link, link.node);
+		hlist_add_head(&tr_link->fexit.tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
 	} else {
 		tr->progs_cnt[kind]++;
@@ -862,13 +862,13 @@ static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
 static void bpf_trampoline_remove_prog(struct bpf_trampoline *tr,
 				       struct bpf_tramp_node *node)
 {
-	struct bpf_fsession_link *fslink;
+	struct bpf_tracing_link *tr_link;
 	enum bpf_tramp_prog_type kind;
 
 	kind = bpf_attach_type_to_tramp(node->link->prog);
 	if (kind == BPF_TRAMP_FSESSION) {
-		fslink = container_of(node, struct bpf_fsession_link, link.link.node);
-		hlist_del_init(&fslink->fexit.node.tramp_hlist);
+		tr_link = container_of(node, struct bpf_tracing_link, link.node);
+		hlist_del_init(&tr_link->fexit.tramp_hlist);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		kind = BPF_TRAMP_FENTRY;
 	}
-- 
2.54.0

