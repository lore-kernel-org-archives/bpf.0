Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CF2701B6
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246056; cv=none; b=bDwPIsrXCPc2thPXNe3mwtud33ilqRVLsRxVvsbukdQJFSoc6xp22HLCbUPnyBsK2cquBF69wxP9m+vBbl9MZmbf8Ot2858GBsLzskk1Emwu+gZCmBwf0jwgp/AtpA+xxkcNbEBkq8Cnf6UGUJ3MK1YgyuKkKXCvP/9j7ubuu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246056; c=relaxed/simple;
	bh=jlzmzVUZatc66HPQV+KRZVQKntcM2EXkVs5FTJwJSp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/6bwS6D69NQy8dQWjmxS1jrCImCCRcMxUE/OVFojfgfM7gRvzMbrVM11FMz7rr+I2Y5c9dQJys9jkzcZNSAdWwTIlkIC5GXImjigKHg/02J4kuq29EFuDYHIMU655E77yzfWHuBQRSlXOiU+W5OBMGNi9uH9sHGAreCllFe3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppf+DIku; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppf+DIku"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac8a2ac52bso3549537b3.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246051; x=1791850851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TeNSAJLFPq7jjMeEaP2RymD5KGPr8j5TQzJn1I+wbQ4=;
        b=ppf+DIkuzcwF/DSvKYymITFgXHUOkLm5RteZj/beYEKhbNjFg77e+WTtI/K5Y0duk8
         mZmk25NL6+gf+umOtSIczNFOBlQExc+Zv6vqTS3tDJDegtAOYnK/dOtHifBFgs0vxpne
         INwC21+Byf4Gw4dJq8PRipaWywe+m1Clfgd5qiOoFuj2kvBiZIpA9U8HL5T7Hjl/LtNn
         ZqSymt+3DECkagQb4z7IAgvwk/Pb4d1oRjsJ5uyZGNbC4q9r1Z9Lyb+VBHdZTE+2oRVO
         g9QDDEQP0sHA5L4+Sgo0lbiP0wHwavy7bzovjcXA84NWXITnbL75wcTIoW6HwjxDWPPQ
         REHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246051; x=1791850851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TeNSAJLFPq7jjMeEaP2RymD5KGPr8j5TQzJn1I+wbQ4=;
        b=nnk3rdL8aghBHt0rIEIpzgN+wpPda1RNza6TAoVjUw02LWCkEGzSBVoJNXW24GcwZv
         g1Ug8mXATWheRX0+tWkUs8H+f3qWBBvWHE4GePkeJx7DLzi2CjiUxg+nyNWh+Fz76AdT
         9vvFUBJO5snmDgSJQYIkv9lR7vKXALG3eL4HVPFgHSIdOsryIdbSNRDbCUCZbXGNy1Xn
         zG4/Wy5uAtXBArtloFQ3KA8nm3gtq1ia6zIVLOPBwpKM5gYARSjFovVm1TlewvkoM7k1
         16EGSQSHJpgRNBBJooKnP8ocGU6jslQaS/7MFDF6bI7iWs6HARhTYCGwQ1pAUMN3wqlv
         6ayw==
X-Forwarded-Encrypted: i=1; AKwUvBwo7NOPKfZygHDxXnPBHxhvmfncuYERQpTINwCm4JcINNVx6f4uKP1I6chXcL5tPJpM5qE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmob9msV3WxC/RxMN52aARF+Y88mBhHO8hhnaDnGN+U03CIuEQ
	s7jKdhBC5s2j0I+6nMYbav69YIjc6/IGzYCjLeaW9OFq4Kjn3vYroh3Y
X-Gm-Gg: AYBFou1T035K48cRxk8nSKbjCT3Jpv9aHnH4v1OFP/UFGazhmM7w0d01QABkz5rqDzR
	owepX5SmemJcgNdMgHkdclkqOaXgAJrkJK1tm2pPA2J/QiGITCr5TJGUJknjb7w0990rBu1XgIB
	M/9+Oe+wVg3Rhy+KzNlp0i0nE60EXP4ROEIVEn/y818e9ZS03+1J+AbjBRyAPaZ+57g3wbf6+e/
	+MDMSwjKhB1ZwQa7N/VfCWsu3vGPkHkDREkbPGRTW4ZOKKhkkRYx+RpYmz8CFq4DRyEwB4U4Tks
	V4gFQCUebXzYE2dsPge3XUbVJZfq/cSW2O7ThKjj7tj3rH1WsdA4GfaGNArZQQb+soBLEC+GTQE
	PlKzdrR5WiKkvxTgwCSbqBltR+smQOKzhSyf4QaAVjCUhXlurriRLe0UYmZcfvTZygeXsHi5V62
	eGuP4sOXkli3uc7714x2xXcEXVCkNyKe5AEfOWgVHXqpVOpO8kt0zXC5cTA3uvmCrrdh8h2EgBO
	g==
X-Received: by 2002:a05:690c:ec9:b0:8a8:4d6:22ec with SMTP id 00721157ae682-8af71ff7827mr5781577b3.7.1791246051523;
        Mon, 05 Oct 2026 17:20:51 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:50 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 08/12] fs: add mnt_undo_legitimize()
Date: Mon,  5 Oct 2026 20:20:15 -0400
Message-ID: <20261006002020.2890858-9-utilityemal77@gmail.com>
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

A failed __legitimize_mnt() can oblige its caller to mntput() the
mount, which may be the final put and so may sleep: legitimize_mnt()
leaves the RCU read-side critical section it ran under to do it.  A
caller that cannot leave its critical section - a BPF program driving
a lockless walk, which only the verifier ends - needs that put to be
callable from inside it.

Add mnt_undo_legitimize(), which drops the count and, when the count
turns out to be the mount's last, keeps it and hands the mount to
delayed_mntput() for the sleepable final put.  delayed_mntput() then
tells the two queue populations apart by MNT_DOOMED rather than by an
unlocked mnt_get_count() read, which a concurrent failed
__legitimize_mnt() could transiently inflate.  legitimize_mnt()
switches to it as well, retiring its
rcu_read_unlock/mntput/rcu_read_lock dance.

Unlike mntput(), mnt_expiry_mark is left alone: a walker that failed
to legitimize a mount never used it.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/mount.h     |  1 +
 fs/namespace.c | 63 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 94fcc306d21e..e714040f8e8f 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -140,6 +140,7 @@ static inline int is_mounted(struct vfsmount *mnt)
 extern struct mount *__lookup_mnt(struct vfsmount *, struct dentry *);
 
 extern int __legitimize_mnt(struct vfsmount *, unsigned);
+void mnt_undo_legitimize(struct mount *mnt);
 
 static inline bool __path_is_mountpoint(const struct path *path)
 {
diff --git a/fs/namespace.c b/fs/namespace.c
index 580877e46b1a..920b8a85f9fa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -767,11 +767,8 @@ static bool legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	int res = __legitimize_mnt(bastard, seq);
 	if (likely(!res))
 		return true;
-	if (unlikely(res < 0)) {
-		rcu_read_unlock();
-		mntput(bastard);
-		rcu_read_lock();
-	}
+	if (unlikely(res < 0))
+		mnt_undo_legitimize(real_mount(bastard));
 	return false;
 }
 
@@ -1330,8 +1327,19 @@ static void delayed_mntput(struct work_struct *unused)
 	struct llist_node *node = llist_del_all(&delayed_mntput_list);
 	struct mount *m, *t;
 
-	llist_for_each_entry_safe(m, t, node, mnt_llist)
-		cleanup_mnt(m);
+	llist_for_each_entry_safe(m, t, node, mnt_llist) {
+		/*
+		 * MNT_DOOMED is only ever set on the mounts
+		 * mntput_no_expire_slowpath() queues here, never on the
+		 * kept-count ones mnt_undo_legitimize() queues.  Route on it
+		 * rather than on mnt_get_count(), which a concurrent failed
+		 * __legitimize_mnt() can transiently inflate.
+		 */
+		if (m->mnt.mnt_flags & MNT_DOOMED)
+			cleanup_mnt(m);
+		else
+			mntput(&m->mnt);	/* kept by mnt_undo_legitimize() */
+	}
 }
 static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
@@ -1423,6 +1431,47 @@ void mntput(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(mntput);
 
+/**
+ * mnt_undo_legitimize - drop a count __legitimize_mnt() asked us to put
+ * @mnt: the mount __legitimize_mnt() failed on
+ *
+ * Like the mntput() that a failed __legitimize_mnt() normally obliges,
+ * but callable from the RCU read-side critical section the legitimization
+ * ran under: when the count turns out to be the mount's last, it is kept
+ * and the mount handed to delayed_mntput() for the sleepable final put.
+ * Unlike mntput(), mnt_expiry_mark is left alone: a walker that failed
+ * to legitimize the mount never used it.
+ */
+void mnt_undo_legitimize(struct mount *mnt)
+{
+	if (likely(READ_ONCE(mnt->mnt_ns))) {
+		/* Not the final count, as in mntput_no_expire(). */
+		mnt_add_count(mnt, -1);
+		return;
+	}
+	lock_mount_hash();
+	/*
+	 * As in mntput_no_expire(): make sure that if a concurrent
+	 * __legitimize_mnt() has not seen us grab mount_lock, we'll see
+	 * its refcount increment here.
+	 */
+	smp_mb();
+	if (likely(mnt_get_count(mnt) > 1)) {
+		mnt_add_count(mnt, -1);
+		unlock_mount_hash();
+		return;
+	}
+	unlock_mount_hash();
+	/*
+	 * Ours is the last count: nothing else can reach the mount any
+	 * more, which makes its mnt_llist ours to use.  delayed_mntput()
+	 * tells our kept-count mount from the doomed ones by MNT_DOOMED.
+	 */
+	WARN_ON_ONCE(mnt->mnt.mnt_flags & MNT_DOOMED);
+	if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
+		schedule_delayed_work(&delayed_mntput_work, 1);
+}
+
 struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
-- 
2.55.0

