Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651E3FBB44;
	Wed, 27 May 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882108; cv=none; b=LCyHH6XMTy1KseEvgf9rIuFgNHjpJIyKPHhpcyFbbYDf31KZdLtoBeBLJQAPr1pNawCkxW2tYfwEnuRbhO1xxQADsQ3ldTdfDbJCS8h8jZpyxl0SDWAG79ekyJ2ApXNZwPwvaowMS5wdOVN6R6883Q/OkBEnXmq+vEFe8woxPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882108; c=relaxed/simple;
	bh=wBqBv9bywSVI1Oloaon+dNka8og4ZtoXW/HdQuR4qxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8BURbBkMraFae0rfwg7Tvl3L4hmk/qUVYWiLFLcJCq02nSdI8JRtO9FtrCnYpT49zmRBiOO3sv+P2OMc9TgVVn94m8TU/ay2Uqgzk3h2+sE5FoWZgwQD/4wvw2ufDB749LEYudgjOUuAeMK/K6Rkobrjz+9jYuRUOYTDZ94HiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odZseS9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odZseS9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2211F00A3A;
	Wed, 27 May 2026 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882100;
	bh=AzQUMTi7B706CZX/LLalu7vyh8VXVhjB83KpV8mTJmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odZseS9eSg6G2NTZMs+otK2bbBjBKbeGjZVPyJrrNOtw8xYZf7n0GYAgGoPD5w6qR
	 qsZtdtuY4ix+XENVtaKf+Nc7ugjKY9Vve14n8yoPc3ai/wILYlPZVZm+ngXc39mRN4
	 OaXHaS7E8dueIF3k4B19pEcbNLw/LlGrxGO9BygnajXxGAJnmbV81kcCD1uLIws/l8
	 ybfCvBwOSrAEROvCp/6Daq00lpUEP2e+y7hp+c50J4wVx0YYOtNY2ldUBq0uMAUPWU
	 rgZpL4U6cZqY/E1yO0cAbai/GQZEQPlRVOrb4VgtNq3kf6Km90xj/+Nlp3jmnP6Lfr
	 PT4oB5x5bILnQ==
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
Subject: [PATCHv6 bpf-next 09/29] bpf: Factor fsession link to use struct bpf_tramp_node
Date: Wed, 27 May 2026 13:39:31 +0200
Message-ID: <20260527113951.46265-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
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
index 36ee2a06eb15..8f2c5e39cc80 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1907,15 +1907,11 @@ struct bpf_shim_tramp_link {
 
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
index b0770b5203e5..435ae6efe961 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3686,21 +3686,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
@@ -3708,6 +3694,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
index 7f71f929fa6f..90c4cfd31b58 100644
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

