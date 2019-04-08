Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D5C282CE
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05820663
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDHNyi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:54:38 -0400
Received: from www62.your-server.de ([213.133.104.62]:46108 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfDHNyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 09:54:04 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDUii-0003fd-5v; Mon, 08 Apr 2019 15:53:56 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 04/16] bpf: add syscall side map freeze support
Date:   Mon,  8 Apr 2019 15:53:36 +0200
Message-Id: <02cc454f12646ae96647457d64d41ba3577e3ae5.1554731339.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25413/Mon Apr  8 09:56:28 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a new BPF_MAP_FREEZE command which allows to
"freeze" the map globally as read-only / immutable from syscall
side.

Map permission handling has been refactored into map_get_sys_perms()
and drops FMODE_CAN_WRITE in case of locked map. Main use case is
to allow for setting up .rodata sections from the BPF ELF which
are loaded into the kernel, meaning BPF loader first allocates
map, sets up map value by copying .rodata section into it and once
complete, it calls BPF_MAP_FREEZE on the map fd to prevent further
modifications.

Right now BPF_MAP_FREEZE only takes map fd as argument while remaining
bpf_attr members are required to be zero. I didn't add write-only
locking here as counterpart since I don't have a concrete use-case
for it on my side, and I think it makes probably more sense to wait
once there is actually one. In that case bpf_attr can be extended
as usual with a flag field and/or others where flag 0 means that
we lock the map read-only hence this doesn't prevent to add further
extensions to BPF_MAP_FREEZE upon need.

A map creation flag like BPF_F_WRONCE was not considered for couple
of reasons: i) in case of a generic implementation, a map can consist
of more than just one element, thus there could be multiple map
updates needed to set the map into a state where it can then be
made immutable, ii) WRONCE indicates exact one-time write before
it is then set immutable. A generic implementation would set a bit
atomically on map update entry (if unset), indicating that every
subsequent update from then onwards will need to bail out there.
However, map updates can fail, so upon failure that flag would need
to be unset again and the update attempt would need to be repeated
for it to be eventually made immutable. While this can be made
race-free, this approach feels less clean and in combination with
reason i), it's not generic enough. A dedicated BPF_MAP_FREEZE
command directly sets the flag, allows all pending operations to
finish and caller has the guarantee that map is immutable from
syscall side upon successful return, which is also more intuitive
from an API point of view. A command name such as BPF_MAP_LOCK has
been avoided as it's too close with BPF map spin locks (which already
has BPF_F_LOCK flag). BPF_MAP_FREEZE is so far only enabled for
privileged users.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h      |  3 ++-
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/syscall.c     | 67 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be20804..65f7094 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -87,7 +87,8 @@ struct bpf_map {
 	struct btf *btf;
 	u32 pages;
 	bool unpriv_array;
-	/* 51 bytes hole */
+	bool frozen; /* write-once */
+	/* 48 bytes hole */
 
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d275446..af1cbd9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -105,6 +105,7 @@ enum bpf_cmd {
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
+	BPF_MAP_FREEZE,
 };
 
 enum bpf_map_type {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0c9276b..959620c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -355,6 +355,18 @@ static int bpf_map_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
+{
+	fmode_t mode = f.file->f_mode;
+
+	/* Our file permissions may have been overridden by global
+	 * map permissions facing syscall side.
+	 */
+	if (READ_ONCE(map->frozen))
+		mode &= ~FMODE_CAN_WRITE;
+	return mode;
+}
+
 #ifdef CONFIG_PROC_FS
 static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 {
@@ -376,14 +388,16 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "max_entries:\t%u\n"
 		   "map_flags:\t%#x\n"
 		   "memlock:\t%llu\n"
-		   "map_id:\t%u\n",
+		   "map_id:\t%u\n"
+		   "frozen:\t%u\n",
 		   map->map_type,
 		   map->key_size,
 		   map->value_size,
 		   map->max_entries,
 		   map->map_flags,
 		   map->pages * 1ULL << PAGE_SHIFT,
-		   map->id);
+		   map->id,
+		   READ_ONCE(map->frozen));
 
 	if (owner_prog_type) {
 		seq_printf(m, "owner_prog_type:\t%u\n",
@@ -727,8 +741,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_READ)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -857,8 +870,7 @@ static int map_update_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -969,8 +981,7 @@ static int map_delete_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -1021,8 +1032,7 @@ static int map_get_next_key(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_READ)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -1089,8 +1099,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-
-	if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -1132,6 +1141,37 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	return err;
 }
 
+#define BPF_MAP_FREEZE_LAST_FIELD map_fd
+
+static int map_freeze(const union bpf_attr *attr)
+{
+	int err = 0, ufd = attr->map_fd;
+	struct bpf_map *map;
+	struct fd f;
+
+	if (CHECK_ATTR(BPF_MAP_FREEZE))
+		return -EINVAL;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	if (READ_ONCE(map->frozen)) {
+		err = -EBUSY;
+		goto err_put;
+	}
+	if (!capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
+	WRITE_ONCE(map->frozen, true);
+	synchronize_rcu();
+err_put:
+	fdput(f);
+	return err;
+}
+
 static const struct bpf_prog_ops * const bpf_prog_types[] = {
 #define BPF_PROG_TYPE(_id, _name) \
 	[_id] = & _name ## _prog_ops,
@@ -2735,6 +2775,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_MAP_GET_NEXT_KEY:
 		err = map_get_next_key(&attr);
 		break;
+	case BPF_MAP_FREEZE:
+		err = map_freeze(&attr);
+		break;
 	case BPF_PROG_LOAD:
 		err = bpf_prog_load(&attr, uattr);
 		break;
-- 
2.9.5

