Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F42284690
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246065; cv=none; b=M6Co/590VHmsPJsCI4wIl3NvFSL4qLfgGV/dO5DpOVq+u/Mixq0LvMB8Ot4YlKy6bkgMg6la1V1GQuhKblAgVzyjweTFlb/LacwIf3/nyikAYunt7gvPHswWo+hVxKMJRPtXAxSnmrIxczYoHz3jizOsAXkpmmBUBxm7MABfTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246065; c=relaxed/simple;
	bh=LRfd7S0laAVt4wwfY+rkKsCrjvIMOZr2/eVLA3RuO6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjLZFAqWprPCahCfpMVvtBDmqXFkT0/HyboVvujCQJPIASMXKOf2nAh5npD1W1rU5Vo1h852mywln10X602rfX/82FdytA3wPguMluigfAv85Hn7WESzA5OyRV/W1vo2LMFQXYxW90ASrbDwT4Z2SveXA+MzfXSzswiyFd3epPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2rWrFdg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2rWrFdg"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ab37e44643so17978177b3.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246062; x=1791850862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLy4nE9CuzwUwMoS4mLJGXfARLbBkX9lmDOg3mTSsz8=;
        b=q2rWrFdgbEBiqwUVthgPmiz6i+uMKJBT6BR5hNxTvqum9VZRNJmxbVUlXrMSt2JL98
         FohU4k+pzwrzll2lhNzr2DRE95/OpOpet/WaSTzODIE8FJU2ibg7RCOAA9UQpC9Yw+bc
         ErCJVoatR+GXca8VwdJ5erXzbF0yXWkUl9x2P6f3A3SI1N7oT2xHrz27wTEYEap1aSSm
         q2wvd7QspFVKFhEU9iA8ZVs7g4ZD9RG9fuxeZHstvMndAMYL1kei261j4FLsW5LuCeFc
         URl4+dP+KD71w/vHogJycJuvcgsHj7jWxHrfdecEXn9TEUei3kesPY7XJFVemYZJScxj
         NMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246062; x=1791850862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLy4nE9CuzwUwMoS4mLJGXfARLbBkX9lmDOg3mTSsz8=;
        b=rVDYijbpanklJuEJFfc9KpxGfK5p2eh2+4a33zJ8ZrEbcamAXQ8z+PhX0Jm8V76xvP
         9ZjkV8nOFv2Z8/902VQMVEMXvAesaJNVl9K9qsuR22Dyd9qx6PeC6WBkKEXA66rX5CS8
         8fhNm96M43ktEV6PsUeJZqwEwJuW7/8Mn0pOzs8nB8ff6xGgIZ59e2COa4+VTjeOvQXk
         LGnKF8rPNkGRVm35o4MNXGKqjKGT1KTaITBpXOkcYn5alMos1iWEbD33K0Pn30RJDNSl
         2XcYm8KoUvY98i0rxA8d7oXRf4F5RmW/+31xCwPRe2r3aanoE0Hc1IMDj+lVROI2TOuH
         yLqg==
X-Forwarded-Encrypted: i=1; AKwUvBxhu36XVC3PsiQAabW1fFMdCkP08rT8tDkV6xXxuR6aDS4XA7jtofvdTxyJtA+dja3OO9Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJQGmlq70NhDWY8MGNst+DZRfxqrXbCextOwxhtrjM73I/nS8M
	XUD3ExMtGpJF59mUdbFZ449pOY5bHhk/HC2ZoUnwnlT7M/nmC5ZWbYRD
X-Gm-Gg: AYBFou2bsJywM6j9zW9aMzJCsFQkoCrKkN4su+vJHw/rojvX6wBlT6D6IGm7dJTlr1s
	hpSoFHr8NaSH46d8vLxLFJJDpNUZu9E73eKKZUDXgTCDoPwrMSsvSKjSf0JZfv2T0XVhIEquYD+
	z9xsvUUVTrzdJRjQmLSuRpcPMtYDzjEe6loZIkHAEYqmGhuHjMsJ5vooWhAI/DI16AdeEa6cOvu
	TkdX7UMhNsxdSzOZvpoD8yV0pncUx6xskrhhDWgcUIC9glzmz7UCRG6gLoTsyYnGjxsr7hA+Kjo
	EBOV1v34yrmVNtZiiywa+he7kgiRtC5ZfoxnvFVra07MDNuvtS4FCLrLPlsGM/T2b20bdQ5rVPY
	n8i/eAPfaq5AjUSprYxUjHPT0LgmqvTYPmXW+TAgGf69tCQnI/DkLrEdYpkO2IsufkeIgpbDt8A
	sutKuY9fKuQL4uWcCfRU+VaA1PvjUewBpjTlDaPnw9sWin2Lf5ARZXqREkj45SX3dXqRDvI6ygu
	A==
X-Received: by 2002:a05:690c:ec9:b0:8ac:46ff:d360 with SMTP id 00721157ae682-8ae947e4e9amr39252687b3.0.1791246061641;
        Mon, 05 Oct 2026 17:21:01 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:21:01 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH bpf-next 11/12] bpf: add a lockless path ancestor iterator
Date: Mon,  5 Oct 2026 20:20:18 -0400
Message-ID: <20261006002020.2890858-12-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a second variant of the ancestor iterator that drives the walk's
rcu mode: bpf_iter_path_ancestors_rcu is KF_RCU_PROTECTED, so the whole
iteration sits in one RCU read-side critical section - implicit in
non-sleepable programs, bpf_rcu_read_lock() in sleepable ones - within
which the verifier already rejects everything sleepable.  This is what
makes a path-based policy expressible from the non-sleepable LSM hooks,
and it drops the per-position reference traffic for the sleepable ones.

Positions come borrowed rather than acquired here: a lockless iteration
holds no reference to pass on, so bpf_iter_path_ancestors_rcu_next()
hands out the walk's own position, valid until the next step.  That is
what RCU protection buys and all it buys: the dentry cannot be freed
under the iteration, but nothing read out of the position may be passed
to a kfunc demanding a trusted argument.

A lockless iteration that loses a race ends with
BPF_PATH_ANCESTORS_RETRY readable through
bpf_path_ancestors_rcu_pos_flags(); the program discards what it
derived from the walk and retries on the referenced variant, so one
lockless attempt bounds the retries.

Escalation mirrors unlazy_walk(): bpf_path_ancestors_legitimize()
acquires the lockless iteration's current position straight into a
referenced iterator the program declared on its stack.  Nothing is
allocated, so nothing can fail for want of memory inside the RCU
read-side critical section, and the escalated position needs no
lifetime of its own: it is the resumed iteration's first position, held
by its reference, yielded by a bpf_iter_path_ancestors_next() that is
sleepable and so necessarily runs after the program has left the
critical section.  That ordering is the whole discipline, and the
verifier enforces it without being told to.

The handover cannot be an iterator constructor - KF_ITER_NEW binds a
type to a single bpf_iter_<type>_new() - so its destination argument is
one of the previous patch's "__uninit" iterator arguments.  Nothing
else is needed: the source argument's ordinary "__iter" classification
already rejects a handover from an iterator whose RCU read-side
critical section has ended.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 105 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 265cb414a08a..9dad65df4267 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -505,16 +505,19 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
 __bpf_kfunc_end_defs();
 
 enum bpf_path_ancestors_flag {
-	/* bpf_path_ancestors_pos_flags() bits */
+	/* bpf_path_ancestors[_rcu]_pos_flags() bits */
 	BPF_PATH_ANCESTORS_DISCONNECTED	= (1 << 0),
 	/* the position is a mountpoint a mount crossing landed on */
 	BPF_PATH_ANCESTORS_MOUNTPOINT	= (1 << 1),
 	/* the iteration ended on a failed allocation, not at the root */
 	BPF_PATH_ANCESTORS_NOMEM	= (1 << 2),
+	/* the lockless iteration lost a race and reached no conclusion */
+	BPF_PATH_ANCESTORS_RETRY	= (1 << 3),
 };
 
 /*
- * Walks over a path's ancestors.
+ * Walks over a path's ancestors, in two variants differing in how
+ * positions are kept alive:
  *
  * bpf_iter_path_ancestors runs with references.  Its kfuncs are
  * sleepable, so the iteration may sleep between positions.
@@ -525,11 +528,25 @@ enum bpf_path_ancestors_flag {
  * dentry saved for later, or the path a sleepable kfunc is still working
  * on - has to be kept alive by the program's reference rather than by the
  * iterator's.
+ *
+ * bpf_iter_path_ancestors_rcu runs lockless over one RCU read-side
+ * critical section, which the verifier enforces around the whole
+ * iteration and within which sleeping is impossible.  Its positions are
+ * borrowed, not acquired: they are only valid until the next step, and
+ * nothing derived from one may be passed to a kfunc demanding a trusted
+ * argument.  A lost race ends the iteration with
+ * BPF_PATH_ANCESTORS_RETRY set; the program discards what it derived
+ * from the walk and retries, typically on the referenced variant, or
+ * escalates mid-walk with bpf_path_ancestors_legitimize().
  */
 struct bpf_iter_path_ancestors {
 	__u64 __opaque[5];
 } __aligned(8);
 
+struct bpf_iter_path_ancestors_rcu {
+	__u64 __opaque[5];
+} __aligned(8);
+
 struct bpf_path_ancestors_kern {
 	struct vfs_ancestor_walk aw;
 	int step;	/* last vfs_walk_next() result, or -ENOMEM */
@@ -543,6 +560,10 @@ static int bpf_path_ancestors_new(struct bpf_path_ancestors_kern *kit,
 		     sizeof(struct bpf_iter_path_ancestors));
 	BUILD_BUG_ON(__alignof__(struct bpf_path_ancestors_kern) !=
 		     __alignof__(struct bpf_iter_path_ancestors));
+	BUILD_BUG_ON(sizeof(struct bpf_iter_path_ancestors) !=
+		     sizeof(struct bpf_iter_path_ancestors_rcu));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_path_ancestors) !=
+		     __alignof__(struct bpf_iter_path_ancestors_rcu));
 
 	if (flags) {
 		/* A zeroed walk makes destroying the iterator a no-op. */
@@ -570,6 +591,8 @@ static u32 bpf_path_ancestors_flags(const struct bpf_path_ancestors_kern *kit)
 
 	if (kit->step == -ENOMEM)
 		return BPF_PATH_ANCESTORS_NOMEM;
+	if (kit->step == -ECHILD)
+		return BPF_PATH_ANCESTORS_RETRY;
 	if (!kit->step) {
 		if (kit->aw.pos_flags & VFS_WALK_POS_DISCONNECTED)
 			flags |= BPF_PATH_ANCESTORS_DISCONNECTED;
@@ -633,6 +656,79 @@ bpf_path_ancestors_pos_flags(struct bpf_iter_path_ancestors *it__iter)
 	return bpf_path_ancestors_flags((void *)it__iter);
 }
 
+__bpf_kfunc int
+bpf_iter_path_ancestors_rcu_new(struct bpf_iter_path_ancestors_rcu *it,
+				struct path *path, u64 flags)
+{
+	return bpf_path_ancestors_new((void *)it, path, flags, VFS_WALK_RCU);
+}
+
+/*
+ * Unlike the referenced variant, this hands out the walk's own position:
+ * a lockless iteration holds no references to pass on, and the verifier
+ * keeps the whole of it inside one RCU read-side critical section.
+ */
+__bpf_kfunc struct path *
+bpf_iter_path_ancestors_rcu_next(struct bpf_iter_path_ancestors_rcu *it)
+{
+	return bpf_path_ancestors_step((void *)it);
+}
+
+__bpf_kfunc void
+bpf_iter_path_ancestors_rcu_destroy(struct bpf_iter_path_ancestors_rcu *it)
+{
+	vfs_walk_end(&((struct bpf_path_ancestors_kern *)it)->aw);
+}
+
+__bpf_kfunc u32
+bpf_path_ancestors_rcu_pos_flags(struct bpf_iter_path_ancestors_rcu *it__iter)
+{
+	return bpf_path_ancestors_flags((void *)it__iter);
+}
+
+/**
+ * bpf_path_ancestors_legitimize - hand a lockless iteration over to references
+ * @it__uninit: referenced ancestor iterator to begin at @rcu_it__iter's
+ *              current position; destroy it with
+ *              bpf_iter_path_ancestors_destroy() whether this succeeds or not
+ * @rcu_it__iter: lockless ancestor iterator, on the position to escalate at
+ *
+ * Mirrors unlazy_walk(): acquires the lockless iteration's current position
+ * and leaves @it__uninit ready to continue from it with references, which
+ * its first bpf_iter_path_ancestors_next() then yields - necessarily after
+ * the program has left its RCU read-side critical section, since that kfunc
+ * is sleepable.  Sleepable work on the escalated position therefore happens
+ * on the iteration's own reference, and nothing is allocated here.
+ *
+ * Return: 0, -%ENOENT if the lockless iteration was not on a position, or
+ * -%ECHILD if it lost the race to acquire one; %BPF_PATH_ANCESTORS_RETRY is
+ * then also flagged, and the program has reached no conclusion about the
+ * ancestry.  @it__uninit is initialized whatever this returns, so a program
+ * need not branch on the result: a walk that could not be escalated simply
+ * yields no position.
+ */
+__bpf_kfunc int
+bpf_path_ancestors_legitimize(struct bpf_iter_path_ancestors *it__uninit,
+			      struct bpf_iter_path_ancestors_rcu *rcu_it__iter)
+{
+	struct bpf_path_ancestors_kern *rcu_kit = (void *)rcu_it__iter;
+	struct bpf_path_ancestors_kern *kit = (void *)it__uninit;
+
+	/* A zeroed walk makes destroying the iterator a no-op. */
+	memset(kit, 0, sizeof(*kit));
+	kit->step = 1;
+
+	/* Drained, or already failed: nothing to hand over. */
+	if (rcu_kit->step)
+		return -ENOENT;
+	if (!vfs_walk_handover(&kit->aw, &rcu_kit->aw)) {
+		rcu_kit->step = -ECHILD;
+		return -ECHILD;
+	}
+	kit->step = 0;
+	return 0;
+}
+
 __bpf_kfunc void bpf_path_put(struct path *path)
 {
 	path_put(path);
@@ -659,6 +755,11 @@ BTF_ID_FLAGS(func, bpf_iter_path_ancestors_next,
 	     KF_ITER_NEXT | KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_path_ancestors_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_path_ancestors_pos_flags)
+BTF_ID_FLAGS(func, bpf_iter_path_ancestors_rcu_new, KF_ITER_NEW | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_path_ancestors_rcu_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_path_ancestors_rcu_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_path_ancestors_rcu_pos_flags)
+BTF_ID_FLAGS(func, bpf_path_ancestors_legitimize)
 BTF_ID_FLAGS(func, bpf_path_put, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-- 
2.55.0

