Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99279524B03
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910136; cv=none; b=P1gimRmY95wqeyVmxGMyw6iZrVo6utnqfeqDbuLpqws4l5TG4v1f0WFYz+i+VDWvH9Ed/FHn5S7x4lb0mhjZUKXta+xBvBnaJi96ZPvJcoiml3xKQ6JubkXxSTwk0VLUu/PPnCHqOhAxDvFaEqRIoN/zASEigfEHlmq2m062mo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910136; c=relaxed/simple;
	bh=itcj3zMtZyusCQjuK0/rgA4bixYi9zcedOl5LukxqHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcDdIxJwbo7k5L//JwzMcm6U43DHvEQhCguPuuy6v8y+rD0sWUHZB7q7D7V4BTMZ/Suk7YRwZsDQy/JdcrxlOIkZt2HJ9l7DtdSob/q56AnPj3vNAYOY+lV442ezRvnhcpP1pmMldeFTF+iRd+0zI6sE0lF1NMUhd2G536gD8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxUP6hRt; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxUP6hRt"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67489c8202cso2468709d50.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910133; x=1792514933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=euHxc4TbGYlRYcVyaJ8wPS0K4KqqpW2SK2+rrBRi91Q=;
        b=IxUP6hRtsqe/A4q8a8K+6pL0r9ZqZJ1UkNoZ6QHFjOLiK3BzAkd0bqfPjU4118mkmu
         HeQ6vKwAbKjdZmc8VU5eBq0GjG+WEBOI/PpabQPfDT6zHyxaU5gpvccf7g2CI9aDSg9L
         w2CDAPKRQ1BwuLg0fhuafj1HpNcvReyGnMyyQYc3RaGAzd5md4+aiXT7WbHTioMzqRSJ
         J79CypdrJbYzaAxVqxiJvLGXegBZy9m8zyH60Ro1MiqMX4Ae3ShUvDzCY3xdy6Bz7nMM
         mc+Qog30BgGx/VUjVU1CX+Y0w4qmQcq2tejgQMhCuqjhy31FLqUYd0/JHCsqiTcK+Lyz
         0a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910133; x=1792514933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=euHxc4TbGYlRYcVyaJ8wPS0K4KqqpW2SK2+rrBRi91Q=;
        b=B/s2TNmMGdMLvoP1/RNK6wGkFCfjYSvNVjqp9+U/v32p8Fq1X84duXZVl8bJUPVOdp
         OFyh0iNKZHjN2n3UdYdD7bDpSzQO9V30qGYj+Yza/06srLzFXEHKGENlyQt5phBICX1l
         1WMsgSBNZjsG2MCqKPa9VBEUhDoNg+2nGa/+VB5lKOBcjYM+oXqtHuq3ia5f1gi3hLRj
         uPkAP3jm4PHNqR9xVDYes1JGNMTDP+as4+o4fR5KS9m20q4iSeJgt2cm7F0IWRCH97kc
         BBSBxq48KCyHC2Z5HhHjykauNDSPxlSzC9KDNtRNyD0qn+x5Epzw91uYyeXjeyXHRLEJ
         9PwQ==
X-Forwarded-Encrypted: i=1; AKwUvBysMjgZBotfx8GdLS5KFhIRcu6aaP4fRcf7/pa0/MwVN2fBFssyhSUfU8WwMxYWKKIb3cU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr9FQ92FqlrUlPTa64ZFYIevranj/nXgjDqV/k7frNv1XyDlEX
	8kJE1Oq+NxrivJIm0foQqWmTKRm522swYS91f3YLgnDuHse4cqj7ebnN
X-Gm-Gg: AYBFou3a++oE799TC2NTeku+WtG6oxAiavHNJDrxfDmjWh6aZwXOFCDr2dBXvcNmtuI
	bC+L2BdHRVp2YwIYdpNEzv4rHRgdkKN9fnODmujDYW3s8CC0rNhg+up9IkVBESausIILv81iAZL
	z4JtDHs4Om5dnuWqiOcAt0+VmuDfPUFy70JrTTGVGOGNOJRQJVkYIDxRP/idTOP+841G5yK2E0k
	ZUE3kEMiVGoXquysBYK+IJGIrlgMK5Jr+28SzaPcDFW2HpTIshQ+AEy0ppQS6/SBdrlFlgNCbXZ
	K5JKOsTrOvc+84nUxbZaKTb0u584sybVgErtILA33fURVVACnsNMRLkusBz/w8/YbVxCkmiJClv
	I7Eb9rGhpXOkolKvr3Xlb41U5csaU+TLRDk7z7epX0MXxf+m26DNmHCNX+WGm8kkOvwa34KoFlv
	8OFxODqrc603E4MJQqrCtORH+4wUF5qFYyD0m2SQqYlL1cMGTRAa+3EPaHP1qlzcIfNaW1RjHq
X-Received: by 2002:a05:690e:43cb:b0:674:e07:5498 with SMTP id 956f58d0204a3-67936298dc4mr3322176d50.48.1791910133262;
        Tue, 13 Oct 2026 09:48:53 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 10/11] bpf: add a lockless path ancestor iterator
Date: Tue, 13 Oct 2026 12:47:59 -0400
Message-ID: <20261013164800.2906577-11-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
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
index 02398f5a46d5..b4bcdcf13ce0 100644
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
+ * Return: 0; -%ENOENT if the lockless iteration was drained (the resumed
+ * walk then yields no position, pos_flags 0); -%ECHILD on a lost race,
+ * flagged %BPF_PATH_ANCESTORS_RETRY on both iterators.  @it__uninit is
+ * initialized either way, so a program need not branch on the result.
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
+
+	/* Drained: nothing to hand over. */
+	if (rcu_kit->step == 1) {
+		kit->step = 1;
+		return -ENOENT;
+	}
+	/* A lost race carries over: the resumed iterator reports RETRY. */
+	if (rcu_kit->step || !vfs_walk_handover(&kit->aw, &rcu_kit->aw)) {
+		rcu_kit->step = -ECHILD;
+		kit->step = -ECHILD;
+		return -ECHILD;
+	}
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

