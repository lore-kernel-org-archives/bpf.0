Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C80BC10F0F
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B910214AF
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 21:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfCKVvo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:51:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:41104 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKVvn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 17:51:43 -0400
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3Spe-0003N3-SW; Mon, 11 Mar 2019 22:51:38 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, yhs@fb.com, andrii.nakryiko@gmail.com,
        jakub.kicinski@netronome.com, tgraf@suug.ch, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH rfc v3 bpf-next 3/9] bpf: add syscall side map lock support
Date:   Mon, 11 Mar 2019 22:51:19 +0100
Message-Id: <20190311215125.17793-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190311215125.17793-1-daniel@iogearbox.net>
References: <20190311215125.17793-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25385/Mon Mar 11 08:43:35 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a new BPF_MAP_LOCK command which allows to lock the
map globally as read-only/immutable from syscall side. Map permission
handling has been refactored into map_get_sys_perms() and drops
FMODE_CAN_WRITE in case of locked map. Main use case is to allow
for setting up .rodata sections from the BPF ELF which are loaded
into the kernel, meaning BPF loader first allocates map, sets up
map value by copying .rodata section into it and once complete, it
calls BPF_MAP_LOCK on the map fd to prevent further modifications.
Given maps can be shared, we only grant the original creator of
the map the ability to lock it as syscall-side read-only or only
priviledged users otherwise.

Right now BPF_MAP_LOCK only takes map fd as argument while remaining
bpf_attr members are required to be zero. I didn't add write-only
locking here as counterpart since I don't have a concrete use-case
for it on my side, and I think it makes probably more sense to wait
once there is actually one. In that case bpf_attr can be extended
as usual with a flag field and/or others where flag 0 means that
we lock the map read-only hence this doesn't prevent to add further
extensions to BPF_MAP_LOCK upon need.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h      |  5 ++-
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/syscall.c     | 72 +++++++++++++++++++++++++++++++++-------
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bb80c78924b0..6b9717b430ff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -87,7 +87,10 @@ struct bpf_map {
 	struct btf *btf;
 	u32 pages;
 	bool unpriv_array;
-	/* 51 bytes hole */
+	/* Next two members are write-once. */
+	bool sys_immutable;
+	struct task_struct *creator;
+	/* 40 bytes hole */
 
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e64fd9862e68..5eb59f05a147 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -105,6 +105,7 @@ enum bpf_cmd {
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
+	BPF_MAP_LOCK,
 };
 
 enum bpf_map_type {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ba2fe4cfad09..b5ba138351e1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -328,6 +328,8 @@ static int bpf_map_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_map *map = filp->private_data;
 
+	if (READ_ONCE(map->creator))
+		cmpxchg(&map->creator, current, NULL);
 	if (map->ops->map_release)
 		map->ops->map_release(map, filp);
 
@@ -335,6 +337,18 @@ static int bpf_map_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
+{
+	fmode_t mode = f.file->f_mode;
+
+	/* Our file permissions may have been overridden by global
+	 * map permissions facing syscall side.
+	 */
+	if (READ_ONCE(map->sys_immutable))
+		mode &= ~FMODE_CAN_WRITE;
+	return mode;
+}
+
 #ifdef CONFIG_PROC_FS
 static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 {
@@ -356,14 +370,16 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "max_entries:\t%u\n"
 		   "map_flags:\t%#x\n"
 		   "memlock:\t%llu\n"
-		   "map_id:\t%u\n",
+		   "map_id:\t%u\n"
+		   "sys_immutable:\t%u\n",
 		   map->map_type,
 		   map->key_size,
 		   map->value_size,
 		   map->max_entries,
 		   map->map_flags,
 		   map->pages * 1ULL << PAGE_SHIFT,
-		   map->id);
+		   map->id,
+		   READ_ONCE(map->sys_immutable));
 
 	if (owner_prog_type) {
 		seq_printf(m, "owner_prog_type:\t%u\n",
@@ -533,6 +549,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_nouncharge;
 
+	WRITE_ONCE(map->creator, current);
 	atomic_set(&map->refcnt, 1);
 	atomic_set(&map->usercnt, 1);
 
@@ -707,8 +724,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_READ)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -837,8 +853,7 @@ static int map_update_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -949,8 +964,7 @@ static int map_delete_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -1001,8 +1015,7 @@ static int map_get_next_key(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_READ)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -1069,8 +1082,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -1112,6 +1124,39 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	return err;
 }
 
+#define BPF_MAP_LOCK_LAST_FIELD map_fd
+
+static int map_lock(const union bpf_attr *attr)
+{
+	int err = 0, ufd = attr->map_fd;
+	struct bpf_map *map;
+	struct fd f;
+
+	if (CHECK_ATTR(BPF_MAP_LOCK))
+		return -EINVAL;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	if (READ_ONCE(map->sys_immutable)) {
+		err = -EBUSY;
+		goto err_put;
+	}
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE) ||
+	    (!capable(CAP_SYS_ADMIN) &&
+	     READ_ONCE(map->creator) != current)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
+	WRITE_ONCE(map->sys_immutable, true);
+	synchronize_rcu();
+err_put:
+	fdput(f);
+	return err;
+}
+
 static const struct bpf_prog_ops * const bpf_prog_types[] = {
 #define BPF_PROG_TYPE(_id, _name) \
 	[_id] = & _name ## _prog_ops,
@@ -2715,6 +2760,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_MAP_GET_NEXT_KEY:
 		err = map_get_next_key(&attr);
 		break;
+	case BPF_MAP_LOCK:
+		err = map_lock(&attr);
+		break;
 	case BPF_PROG_LOAD:
 		err = bpf_prog_load(&attr, uattr);
 		break;
-- 
2.17.1

