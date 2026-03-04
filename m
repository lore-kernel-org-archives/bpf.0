Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42401EDA32;
	Wed,  4 Mar 2026 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662964; cv=none; b=alY4+RsY4ElYJ6ikj8vgOl8iRtu9f9zGmnfyAw4LhIcxIWWS7kGQnC+OekLWMgXJoeB8gnarnzM96xVcUICaaCNIB+3Ihl8HazKLxZQykNXYAWZDW84gxkH6pPkSrzmLj9oBNLgU9I3Z15kNmwe4MB2JJ7I9Vf0CDV7P0Ag/5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662964; c=relaxed/simple;
	bh=8eoGHnbCKjd7ZgewDePcuhE1IbvOyTN0lKmBqxXTEcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO2+c+tH0//oPit6coAYgn5GV2/nMtv0/v604EhdeEf1/QG37quuzDk3OqHVEjlJ7D+mjt/OjFY9bXCC5EwH5tRlw0DZNcrWHs8e6MiJaNjXrGEwcK3llTY9Zi7iruJMB5TnaosUXSYfPEO3f6iykfiw7ibd+BMLFT7+7KZZwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUEsVZHB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUEsVZHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CF4C19425;
	Wed,  4 Mar 2026 22:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662964;
	bh=8eoGHnbCKjd7ZgewDePcuhE1IbvOyTN0lKmBqxXTEcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUEsVZHBX3XvUi5cncN8W5LaRiYr6snIi9b6Tfg2jOXUW7FpTXZJ+6nigAo7rXADn
	 QTxWtfnQ9nkjdzfKS5iC1zpAuOq90HyOS3v/kxuZeMXVYwKJceJO5rI7Ax0iQZGYK8
	 QNrNxL+N+/tda517RrViRpWHv3oc4xtvU/6+mmaxekhQUmeTCv1e0WSHppdBO8RJNF
	 3Chshy0Vo0GARRgKOw0J84q+8rY/42p7eSxBlq/z+/c/vpkNhuOw6UkkcLC9+Jla68
	 yAPQCbpPrvzKD0Zu2rncIXHi4IcY0UTw+EmmVfw9F9d5llU+pvz/ZqLetDtIkobg0D
	 /EPJ8d6K+ioig==
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
Subject: [PATCHv2 bpf-next 05/23] bpf: Factor fsession link to use struct bpf_tramp_node
Date: Wed,  4 Mar 2026 23:21:23 +0100
Message-ID: <20260304222141.497203-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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
index f97aa34ee4c2..d536640aef41 100644
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
index 6db6d1e74379..003ad95940c9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3637,21 +3637,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
index dfbc190056f2..2de81e4369a1 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -815,7 +815,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 				      struct bpf_trampoline_ops *ops,
 				      void *data)
 {
-	struct bpf_fsession_link *fslink = NULL;
+	struct bpf_tracing_link *tr_link = NULL;
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_node *node_existing;
 	struct hlist_head *prog_list;
@@ -865,8 +865,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
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
@@ -876,7 +876,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		hlist_del_init(&node->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
 			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
-			hlist_del_init(&fslink->fexit.node.tramp_hlist);
+			hlist_del_init(&tr_link->fexit.tramp_hlist);
 			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		} else {
 			tr->progs_cnt[kind]--;
@@ -917,10 +917,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
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
2.53.0

