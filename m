Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612E31B10B;
	Fri, 20 Feb 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582088; cv=none; b=S1IH0WCbcANqaOS8qUzyp8t9br6kHLKzW46H4SVE0LztUeG1JKWEcKhOBuUpEBKRcKQEhTo1UUdpY9Zi3JoDSnbR3D2BV7/oDIYEgsLpZI6VsCoF4Xr4mBla1JPUaKiQYTeKVkj1ijSxj9dzTH2eq3610cpXcHyz9MKoi492Q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582088; c=relaxed/simple;
	bh=3HOb6xdaTrYWQ+HCh17YfdJLk3BE9piDdAUoLf61O/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7SmwZpUe94+R99dNwId6SMHVmRj7KDnaTMvNs3lURYrSsfMdBChsL5udLyQN0a43mCQIIVpM8sSZzYJYc0741JB9+v4CpX6/M7S2TQffPdMILKGmo9WPhe5YHoaJaxSH9msE9cf6o8FD1X9UUDG/1xQ7ie4Dwww3ekBrHI3dJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKZ6S2Lf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKZ6S2Lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF9AC116C6;
	Fri, 20 Feb 2026 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582088;
	bh=3HOb6xdaTrYWQ+HCh17YfdJLk3BE9piDdAUoLf61O/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKZ6S2LfMS/ml0Ft7EnIra4zjeoFLHEwQDZ9OnnNECS7sluh88morrVBewcdQAX+d
	 JCkow4cQ+UM88VJQmEqekYFtSHXQL7a1fDuNZYPFHOpMFkBFIYPPSHzgFGk81sl98J
	 ncKtKMFn8gN1etjI+OV2+MgLvzgBoGhhEUguwU28HWBsmixVT2sxf14FuoA/znhSEq
	 PzXmMg8OgUEW9y6zun7p3eydT7lmmq5vCs5IWrAjoLLVUfhhMe1w+2nMZEFn5/gQoe
	 HmfJkXWGDoVatGhXsHSejjIhizGNCn/M+A8Dqbo0joKqGQrqpe2/sblO+TqfSR73F/
	 xLamwWETnPbMQ==
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
Subject: [PATCH bpf-next 05/17] bpf: Factor fsession link to use struct bpf_tramp_node
Date: Fri, 20 Feb 2026 11:06:37 +0100
Message-ID: <20260220100649.628307-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
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
 kernel/bpf/trampoline.c | 14 +++++++-------
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c7f5ab3c7ce..d79951c0ab79 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1883,15 +1883,11 @@ struct bpf_shim_tramp_link {
 
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
index e9d482c59977..95a4bfbeab62 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3637,21 +3637,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
 	}
 
-	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
-		struct bpf_fsession_link *fslink;
-
-		fslink = kzalloc(sizeof(*fslink), GFP_USER);
-		if (fslink) {
-			bpf_tramp_link_init(&fslink->fexit, BPF_LINK_TYPE_TRACING,
-					    &bpf_tracing_link_lops, prog, attach_type,
-					    bpf_cookie);
-			link = &fslink->link;
-		} else {
-			link = NULL;
-		}
-	} else {
-		link = kzalloc(sizeof(*link), GFP_USER);
-	}
+	link = kzalloc(sizeof(*link), GFP_USER);
 	if (!link) {
 		err = -ENOMEM;
 		goto out_put_prog;
@@ -3659,6 +3645,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
index f4acf3771600..14fa7012738a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -827,7 +827,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 				      struct bpf_trampoline_ops *ops,
 				      void *data)
 {
-	struct bpf_fsession_link *fslink = NULL;
+	struct bpf_tracing_link *tr_link = NULL;
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_node *node_existing;
 	struct hlist_head *prog_list;
@@ -877,8 +877,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
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
@@ -888,7 +888,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		hlist_del_init(&node->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
 			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
-			hlist_del_init(&fslink->fexit.node.tramp_hlist);
+			hlist_del_init(&tr_link->fexit.tramp_hlist);
 			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		} else {
 			tr->progs_cnt[kind]--;
@@ -929,10 +929,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 		tgt_prog->aux->is_extended = false;
 		return err;
 	} else if (kind == BPF_TRAMP_FSESSION) {
-		struct bpf_fsession_link *fslink =
-			container_of(node, struct bpf_fsession_link, link.link.node);
+		struct bpf_tracing_link *tr_link =
+			container_of(node, struct bpf_tracing_link, link.node);
 
-		hlist_del_init(&fslink->fexit.node.tramp_hlist);
+		hlist_del_init(&tr_link->fexit.tramp_hlist);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		kind = BPF_TRAMP_FENTRY;
 	}
-- 
2.52.0

