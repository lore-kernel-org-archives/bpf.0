Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E53B6364;
	Fri, 17 Apr 2026 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454015; cv=none; b=Jodrst2Xk+aIk7mO/8jGSnGLPq9EQ4pY63qxxqUCQjpKxzZJhP5kX6JpR7huAhnrrYTCUyzd3r1bu1Wnq0+rqhY8H5pp04aDinbY7cQk8ZXWcXNGejW4HokdefIbXVLjHcar1hvCLf7igM87JvZBmbS+4UCjx3hdsBZ/mzE9oBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454015; c=relaxed/simple;
	bh=+LjxbyRR1PQsy1ltWfaGO3lTrt0uS+0F71AaMdNgQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLNluNAsPMSUvtFZIX72NsxrS48pTEXhAVecEtSEHrgyB+l3PJYhO9Q4U9QXAVE02wWaiMriE3diubbt6zeklqd2XIv8z4qJcq4bYZNJPZzlPnY8Zu05jnJBrgH8jDw0MopjV5p8jnAuLUhXaqw56S4Soo0Cu1qjGToFZSV5h8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfgcZcrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfgcZcrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7E1C19425;
	Fri, 17 Apr 2026 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454014;
	bh=+LjxbyRR1PQsy1ltWfaGO3lTrt0uS+0F71AaMdNgQy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfgcZcrswqOXAZNjLqatVypXQ659KJ9u2bhmo8Mh8Tf5bkDBkl+dxcHrsIsvTr4UN
	 gWPXwtZCH2oXVjkrU6PehkCjkDb0LIJndBrkkdGhcTWPo+scdnkjCaqSXtf8Nb/INC
	 HvDx/zHhDuHvh39R5V58jPcPKvhoOayPM61wKU2zjtdBH/e8fb5Xf7kgLU+na1AjUj
	 e5SxgUg8byosdjN3CiAUow6TOOmkNxligUC8GNz3rp8hTNukI0gxYkPbRRO5XMTtj4
	 4eZFtv1/5OKozeSn333WPNyA2EiBUzQNTH1NsTCBPt/hR9hrbpdzWvJgOijohylBrk
	 fcoipttnrJMZg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv5 bpf-next 09/28] bpf: Factor fsession link to use struct bpf_tramp_node
Date: Fri, 17 Apr 2026 21:24:43 +0200
Message-ID: <20260417192502.194548-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
index f826b65e4f68..79e31fcab2c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1887,15 +1887,11 @@ struct bpf_shim_tramp_link {
 
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
index fe00221de45c..4ad41656fc8d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3644,21 +3644,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
@@ -3666,6 +3652,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
index 452b82c654e9..91c380c34fcd 100644
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
2.53.0

