Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2F3375CF;
	Fri, 20 Feb 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582061; cv=none; b=IUMpQXyAOlu3kW5423H0xDyGnngFid+BD6M+L2icu2mEgiAbipR4TFRmtQka45HH3p7k1zCfHEru5y4BUidYuIb70QMcgXEpPcrKbVEMqdywLBPjrb5YGRSXSUcD9LmOsn5ODcO6RFdftQ4cmBnDbLTZhhZO2gPBjZCqgIoJaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582061; c=relaxed/simple;
	bh=oEzWY1enjZZ3TO/AM8tT2ojQne+3CTpsf5sIdSTTPxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWIf1gxn6JuBz8BN/bbQxia2hA/oUnOzlNBZjJ/Idq7IIshvjIqZ4qjhuX5LdROkcgeFYcTfpg8KDhGkxn5DiArKrFxMbz3P22Ovjjpv89flo32+k7fl6CC3o3W4V9lzuqpCgL44eLb/szg87IB4FV1C7WjTqIGtQPRfFNrThwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWqgAohd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWqgAohd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94933C116C6;
	Fri, 20 Feb 2026 10:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582061;
	bh=oEzWY1enjZZ3TO/AM8tT2ojQne+3CTpsf5sIdSTTPxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWqgAohdzRmW/AC3y70dtZRsr7nQIVKMpX9dvwB0b26zyElYRLD488fJDL1LAk6fr
	 McEI1YLaCqH+OXyD80/mOHu5VxmQS2HtN/Rf3Ac2Ull0yCjHR1KaLuCcrF/JcFN0se
	 kQQeB5mY7BxX6TrSSolUCR5sufSCCkQ0qBLqqxIFHw4awS3a2CrI4v6n82uIY0ksxg
	 OJW3MV/kvtbHsdUNWinqS/7VCpEE+Wzm70wp5WLDusK7nWVW23L5gg1tB7Zk/YjmKM
	 StvtZfD/9sXXsbBO4PgO8h9gOPhkamEdkTJH6A2cJdBAozDJ9mH4/f2LkQriwrfp08
	 cntm48WNn5Gpg==
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
Subject: [PATCH bpf-next 03/17] bpf: Add struct bpf_trampoline_ops object
Date: Fri, 20 Feb 2026 11:06:35 +0100
Message-ID: <20260220100649.628307-4-jolsa@kernel.org>
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
 kernel/bpf/trampoline.c | 54 +++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 05dc0358654d..e9f0152289a4 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -69,6 +69,14 @@ static int __init trampoline_locks_init(void)
 	return 0;
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
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
@@ -425,7 +433,7 @@ static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flag
 }
 
 static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
-			     void *old_addr)
+			     void *old_addr, void *data)
 {
 	int ret;
 
@@ -439,7 +447,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 
 static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 			 void *old_addr, void *new_addr,
-			 bool lock_direct_mutex)
+			 bool lock_direct_mutex, void *data __maybe_unused)
 {
 	int ret;
 
@@ -453,7 +461,7 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 }
 
 /* first time registering */
-static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
+static int register_fentry(struct bpf_trampoline *tr, void *new_addr, void *data __maybe_unused)
 {
 	void *ip = tr->func.addr;
 	unsigned long faddr;
@@ -475,6 +483,12 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
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
@@ -642,7 +656,8 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	return ERR_PTR(err);
 }
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+static int bpf_trampoline_update_ops(struct bpf_trampoline *tr, bool lock_direct_mutex,
+				     struct bpf_trampoline_ops *ops, void *data)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_links *tlinks;
@@ -655,7 +670,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tlinks);
 
 	if (total == 0) {
-		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
+		err = ops->unregister_fentry(tr, orig_flags, tr->cur_image->image, data);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
 		goto out;
@@ -726,11 +741,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
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
@@ -760,6 +775,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
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
@@ -804,7 +824,9 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 				      struct bpf_trampoline *tr,
-				      struct bpf_prog *tgt_prog)
+				      struct bpf_prog *tgt_prog,
+				      struct bpf_trampoline_ops *ops,
+				      void *data)
 {
 	struct bpf_fsession_link *fslink = NULL;
 	enum bpf_tramp_prog_type kind;
@@ -862,7 +884,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	} else {
 		tr->progs_cnt[kind]++;
 	}
-	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	err = bpf_trampoline_update_ops(tr, true /* lock_direct_mutex */, ops, data);
 	if (err) {
 		hlist_del_init(&link->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
@@ -883,14 +905,16 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
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
@@ -915,7 +939,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	return bpf_trampoline_update_ops(tr, true /* lock_direct_mutex */, ops, data);
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
@@ -926,7 +950,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	int err;
 
 	trampoline_lock(tr);
-	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog);
+	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog, &trampoline_ops, NULL);
 	trampoline_unlock(tr);
 	return err;
 }
@@ -1058,7 +1082,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL);
+	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL, &trampoline_ops, NULL);
 	if (err)
 		goto err;
 
-- 
2.52.0

