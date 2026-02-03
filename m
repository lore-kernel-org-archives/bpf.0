Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C1309EF7;
	Tue,  3 Feb 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111531; cv=none; b=tz/6IWgpU6O5hkLgcWgPAGQmj7H7dLNyECyjxAHmxApTIkimB4E3zktPMmaRUAk2nt4v3MiUDuIIwB41Yb4MuGvuTRqA8r5+7BvnocWo77uJ3imUa4bio9DMIdLFphJ+ykUd516Tkw6r2wI63BD71Hy9bxyiDOp63fIW0PCNBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111531; c=relaxed/simple;
	bh=YOv2VO4cikt8VIaAznMOFRBBYzJ17APi4Fw0P9gizs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZNI7Ywmel7ZFlrz8XvYuyqHrcLphPvac7H0ugJJhJacrncAh870K9BC4v8lVuT3yvZ4gzPZ7BKDco3PkjTnXnUb2RG5Ct4drmvlJRAHmf1b/wY4O+MBwjFnO1w9i/IhyV9NgZ4o0C+/HVpmxmAvR3THPjD0AJ68Bhre0EobzYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ+7nDdP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ+7nDdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF63C116D0;
	Tue,  3 Feb 2026 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111531;
	bh=YOv2VO4cikt8VIaAznMOFRBBYzJ17APi4Fw0P9gizs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQ+7nDdP5+0QsM/ejMQvvlGk8WIS7sADnf31KqY06sXglG9sjpFF0NEOcJF0P/I2W
	 QNpCvhxTWKoqR62I6yAL4RIMKqn4rC/kfNVXghG3wbLD+MUh/SuOvGHSp5m5vvUpqX
	 8Nn7UGHKT/gEJPB1K4qMcR8+uTeHOAYH2AySFJwgFklNtXrdX5NyHhCSaSvy9ccLtF
	 O+0jXjSK/RPnt88HHQEVx3H+MydMmQGbEckucs96P+xnTdTbByQh0FNvGDtjIhkGZB
	 OuXImapdWtd4tzOEH3BbdGW6VlAbrYqDpcVb55TYckGdHSAqDIwYOMQT7eczRTa1rL
	 b/Ap52f8Q3pbw==
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
Subject: [RFC bpf-next 02/12] bpf: Add struct bpf_trampoline_ops object
Date: Tue,  3 Feb 2026 10:38:09 +0100
Message-ID: <20260203093819.2105105-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In following changes we will need to change ftrace direct attachment
logic. In order to do that adding struct bpf_trampoline_ops object
that defines 3 callbacks that follow ftrace attachment functions:

   register_fentry
   unregister_fentry
   modify_fentry

The new struct bpf_trampoline_ops object is passed as an argument to
__bpf_trampoline_link_prog function.

At the moment the default trampoline_ops is set to the current ftrace
direct attachment functions, so there's no change for current code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 53 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 952cd7932461..ec9c1db78f47 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -30,6 +30,13 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline tables */
 static DEFINE_MUTEX(trampoline_mutex);
 
+struct bpf_trampoline_ops {
+	int (*register_fentry)(struct bpf_trampoline *tr, void *new_addr, void *data);
+	int (*unregister_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr, void *data);
+	int (*modify_fentry)(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr, void *new_addr,
+			     bool lock_direct_mutex, void *data);
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
@@ -387,7 +394,7 @@ static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flag
 }
 
 static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
-			     void *old_addr)
+			     void *old_addr, void *data)
 {
 	int ret;
 
@@ -401,7 +408,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 
 static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 			 void *old_addr, void *new_addr,
-			 bool lock_direct_mutex)
+			 bool lock_direct_mutex, void *data __maybe_unused)
 {
 	int ret;
 
@@ -415,7 +422,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 }
 
 /* first time registering */
-static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
+static int register_fentry(struct bpf_trampoline *tr, void *new_addr, void *data __maybe_unused)
 {
 	void *ip = tr->func.addr;
 	unsigned long faddr;
@@ -437,6 +444,12 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
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
@@ -604,7 +617,8 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	return ERR_PTR(err);
 }
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+static int bpf_trampoline_update_ops(struct bpf_trampoline *tr, bool lock_direct_mutex,
+				     struct bpf_trampoline_ops *ops, void *data)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_links *tlinks;
@@ -617,7 +631,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tlinks);
 
 	if (total == 0) {
-		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
+		err = ops->unregister_fentry(tr, orig_flags, tr->cur_image->image, data);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
 		goto out;
@@ -688,11 +702,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
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
@@ -722,6 +736,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	goto out;
 }
 
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+{
+	return bpf_trampoline_update_ops(tr, lock_direct_mutex, &trampoline_ops, NULL);
+}
+
 static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
@@ -766,7 +785,9 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 				      struct bpf_trampoline *tr,
-				      struct bpf_prog *tgt_prog)
+				      struct bpf_prog *tgt_prog,
+				      struct bpf_trampoline_ops *ops,
+				      void *data)
 {
 	struct bpf_fsession_link *fslink = NULL;
 	enum bpf_tramp_prog_type kind;
@@ -824,7 +845,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	} else {
 		tr->progs_cnt[kind]++;
 	}
-	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	err = bpf_trampoline_update_ops(tr, true /* lock_direct_mutex */, ops, data);
 	if (err) {
 		hlist_del_init(&link->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
@@ -845,14 +866,16 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
+	err = __bpf_trampoline_link_prog(link, tr, tgt_prog, &trampoline_ops, NULL);
 	mutex_unlock(&tr->mutex);
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
@@ -877,7 +900,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	return bpf_trampoline_update_ops(tr, true /* lock_direct_mutex */, ops, data);
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
@@ -888,7 +911,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog);
+	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog, &trampoline_ops, NULL);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
@@ -1019,7 +1042,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL);
+	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL, &trampoline_ops, NULL);
 	if (err)
 		goto err;
 
-- 
2.52.0

