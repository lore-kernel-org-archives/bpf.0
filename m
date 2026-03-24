Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522035DA6D;
	Tue, 24 Mar 2026 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340380; cv=none; b=fXLs8zDfbAe7M9qT5BXmPjYHl3WsjLQULkF5iRhyIdl+MK6NNAWlRP0Kh25Mh5OSmOmp9MQ8RpzfLVZ+v8C0i8kEUTJhGMzSor0DqFeyUsewSSoA3jY7NG/79Kk1GiA+/imfs1c74XM5rgoXcTnUT4ZpMgKGmXHzL3LHTLTv3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340380; c=relaxed/simple;
	bh=vpCsmUe4fe7OFYizTEQtudFnxWFxzmt1FUoP1uzGxVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SalJMliEt7IFHtNate3SNYUsuWehGFYLtkoJx91+WMD0WofA2bnMhyD6NIcToplq6xU0X3WlFJy+Y9QaSUiZ/A5lG0sC6H7BWJZcN2Q/lJ0ClnMTz+rph4yv5L5qrVgO4db16GSmMFQggCGlTDDjXppcL0beAWa8jH/ay7vdqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYcnRyhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYcnRyhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7392BC19424;
	Tue, 24 Mar 2026 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340380;
	bh=vpCsmUe4fe7OFYizTEQtudFnxWFxzmt1FUoP1uzGxVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYcnRyhdw8/OSVDnUwd7H8BdUk0iZffsqK88pN14uU/uwaRobAAWrMfRWQLpW/k4E
	 YNeDHzCrhuziMI215N9T3rACTHCMhQ2+RVt4VXzkiVuTeCmCIce6cc5q/xHRwgyVqI
	 FHED/W3mNpdcZ80Pd2gKS2gUr3GYEkSFXEoV5vUQzvmTYZTI8pUl9g9aR5/eIs/ALo
	 9oIVXkYcA8S4e6Sg9W1/qt9zXZ72jmNzlGDghJIKGnEcglwvLwch4MfbQyS1ransUC
	 vmTi50Fur8xOUZZo+GDa4KKwpvoVjVYzPOV6HAGYXe+gf/gyX6ui0MKQcvi+EMj2tg
	 Dov1YR4/qHA/g==
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
Subject: [PATCHv4 bpf-next 04/25] bpf: Add struct bpf_trampoline_ops object
Date: Tue, 24 Mar 2026 09:18:25 +0100
Message-ID: <20260324081846.2334094-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In following changes we will need to override ftrace direct attachment
behaviour. In order to do that we are adding struct bpf_trampoline_ops
object that defines callbacks for ftrace direct attachment:

   register_fentry
   unregister_fentry
   modify_fentry

The new struct bpf_trampoline_ops object is passed as an argument to
__bpf_trampoline_link/unlink_prog functions.

At the moment the default trampoline_ops is set to the current ftrace
direct attachment functions, so there's no functional change for the
current code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 59 ++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index eb4ea78ff77f..a76e093c9092 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -58,8 +58,18 @@ static void trampoline_unlock(struct bpf_trampoline *tr)
 	mutex_unlock(select_trampoline_lock(tr));
 }
 
+struct bpf_trampoline_ops {
+	int (*register_fentry)(struct bpf_trampoline *tr, void *new_addr, void *data);
+	int (*unregister_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
+				 void *data);
+	int (*modify_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
+			     void *new_addr, bool lock_direct_mutex, void *data);
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
+				 struct bpf_trampoline_ops *ops, void *data);
+static struct bpf_trampoline_ops trampoline_ops;
 
 #ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
 static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
@@ -144,13 +154,15 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 
 		if ((tr->flags & BPF_TRAMP_F_CALL_ORIG) &&
 		    !(tr->flags & BPF_TRAMP_F_ORIG_STACK))
-			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */);
+			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */,
+						    &trampoline_ops, NULL);
 		break;
 	case FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY_PEER:
 		tr->flags &= ~BPF_TRAMP_F_SHARE_IPMODIFY;
 
 		if (tr->flags & BPF_TRAMP_F_ORIG_STACK)
-			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */);
+			ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */,
+						    &trampoline_ops, NULL);
 		break;
 	default:
 		ret = -EINVAL;
@@ -414,7 +426,7 @@ static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flag
 }
 
 static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
-			     void *old_addr)
+			     void *old_addr, void *data)
 {
 	int ret;
 
@@ -428,7 +440,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 
 static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 			 void *old_addr, void *new_addr,
-			 bool lock_direct_mutex)
+			 bool lock_direct_mutex, void *data __maybe_unused)
 {
 	int ret;
 
@@ -442,7 +454,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 }
 
 /* first time registering */
-static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
+static int register_fentry(struct bpf_trampoline *tr, void *new_addr, void *data __maybe_unused)
 {
 	void *ip = tr->func.addr;
 	unsigned long faddr;
@@ -464,6 +476,12 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	return ret;
 }
 
+static struct bpf_trampoline_ops trampoline_ops = {
+	.register_fentry   = register_fentry,
+	.unregister_fentry = unregister_fentry,
+	.modify_fentry     = modify_fentry,
+};
+
 static struct bpf_tramp_links *
 bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
 {
@@ -631,7 +649,8 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	return ERR_PTR(err);
 }
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex,
+				 struct bpf_trampoline_ops *ops, void *data)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_links *tlinks;
@@ -644,7 +663,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tlinks);
 
 	if (total == 0) {
-		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
+		err = ops->unregister_fentry(tr, orig_flags, tr->cur_image->image, data);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
 		goto out;
@@ -715,11 +734,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
-		err = modify_fentry(tr, orig_flags, tr->cur_image->image,
-				    im->image, lock_direct_mutex);
+		err = ops->modify_fentry(tr, orig_flags, tr->cur_image->image,
+					 im->image, lock_direct_mutex, data);
 	else
 		/* first time registering */
-		err = register_fentry(tr, im->image);
+		err = ops->register_fentry(tr, im->image, data);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	if (err == -EAGAIN) {
@@ -793,7 +812,9 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 				      struct bpf_trampoline *tr,
-				      struct bpf_prog *tgt_prog)
+				      struct bpf_prog *tgt_prog,
+				      struct bpf_trampoline_ops *ops,
+				      void *data)
 {
 	struct bpf_fsession_link *fslink = NULL;
 	enum bpf_tramp_prog_type kind;
@@ -851,7 +872,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	} else {
 		tr->progs_cnt[kind]++;
 	}
-	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
 	if (err) {
 		hlist_del_init(&link->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
@@ -872,14 +893,16 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	int err;
 
 	trampoline_lock(tr);
-	err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
+	err = __bpf_trampoline_link_prog(link, tr, tgt_prog, &trampoline_ops, NULL);
 	trampoline_unlock(tr);
 	return err;
 }
 
 static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 					struct bpf_trampoline *tr,
-					struct bpf_prog *tgt_prog)
+					struct bpf_prog *tgt_prog,
+					struct bpf_trampoline_ops *ops,
+					void *data)
 {
 	enum bpf_tramp_prog_type kind;
 	int err;
@@ -904,7 +927,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
@@ -915,7 +938,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	int err;
 
 	trampoline_lock(tr);
-	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog);
+	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog, &trampoline_ops, NULL);
 	trampoline_unlock(tr);
 	return err;
 }
@@ -1044,7 +1067,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL);
+	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL, &trampoline_ops, NULL);
 	if (err)
 		goto err;
 
-- 
2.53.0

