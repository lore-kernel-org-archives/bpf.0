Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8C1292D4
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670133; cv=none; b=sl3iI7h4qjJkHNUdfY3u6XlcCK9zpw10WZ5O42utuRYtg/+l9oUF8Y07q+xgc703/FjqFMRKc7j9X24IdbKEtKHljYJmzJ6e8Wxt2JN3jUu1s2F0d5jGk25GcxlhWk7SGbP1/i9UAAVeSdn8ccjtTsbMloR99Woae18SQlLC4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670133; c=relaxed/simple;
	bh=i3V0gLR3SP12B2O0H6u6DDKTqnwS4UTFM5nuFT2csu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmT4q13XviHG0idXz64gBPaT3n7W+ZdJP/PqpuG06cws6hSAkdwJUalNWXJbOKcx2nhT4x5r04y73Y4Be5U7HYU5ORtr3dP2KkwrXUOT2dU7c8la1x9SWfmygwp+qwQEYcYKJ+EWh88AJkvka+T1oVr1BnFgrVNn7yiyiA6HuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 06A2914A911F; Tue,  5 Mar 2024 12:22:01 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 1/5] bpf: Add link support for sk_msg prog
Date: Tue,  5 Mar 2024 12:22:00 -0800
Message-ID: <20240305202201.3891042-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305202155.3890667-1-yonghong.song@linux.dev>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add link support for sk_msg program. This will make user space
easy to manage as most common used programs have alrady have
link support.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h            |  13 +++
 include/uapi/linux/bpf.h       |   5 ++
 kernel/bpf/syscall.c           |   3 +
 net/core/skmsg.c               | 153 +++++++++++++++++++++++++++++++++
 net/core/sock_map.c            |   6 +-
 tools/include/uapi/linux/bpf.h |   5 ++
 6 files changed, 181 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 785660810e6a..a3112a295f5c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2982,10 +2982,14 @@ int sock_map_prog_detach(const union bpf_attr *at=
tr, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value=
, u64 flags);
 int sock_map_bpf_prog_query(const union bpf_attr *attr,
 			    union bpf_attr __user *uattr);
+int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
+			 struct bpf_prog *old, u32 which);
=20
 void sock_map_unhash(struct sock *sk);
 void sock_map_destroy(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
+
+int bpf_skmsg_link_create(const union bpf_attr *attr, struct bpf_prog *p=
rog);
 #else
 static inline int bpf_dev_bound_kfunc_check(struct bpf_verifier_log *log=
,
 					    struct bpf_prog_aux *prog_aux)
@@ -3080,6 +3084,15 @@ static inline int sock_map_bpf_prog_query(const un=
ion bpf_attr *attr,
 {
 	return -EINVAL;
 }
+int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
+			 struct bpf_prog *old, u32 which)
+{
+	return -EOPNOTSUPP;
+}
+int bpf_skmsg_link_create(const union bpf_attr *attr, struct bpf_prog *p=
rog)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a241f407c234..c7d2a5fcf37a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1129,6 +1129,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
+	BPF_LINK_TYPE_SK_MSG =3D 14,
 	__MAX_BPF_LINK_TYPE,
 };
=20
@@ -6699,6 +6700,10 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} netkit;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} skmsg;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b2750b79ac80..7fd3e6c93612 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5155,6 +5155,9 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		ret =3D netns_bpf_link_create(attr, prog);
 		break;
+	case BPF_PROG_TYPE_SK_MSG:
+		ret =3D bpf_skmsg_link_create(attr, prog);
+		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
 		ret =3D bpf_xdp_link_attach(attr, prog);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 4d75ef9d24bf..2e3d15294966 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1256,3 +1256,156 @@ void sk_psock_stop_verdict(struct sock *sk, struc=
t sk_psock *psock)
 	sk->sk_data_ready =3D psock->saved_data_ready;
 	psock->saved_data_ready =3D NULL;
 }
+
+struct bpf_skmsg_link {
+	struct bpf_link link;
+	struct bpf_map *map;
+	enum bpf_attach_type attach_type;
+};
+
+static DEFINE_MUTEX(link_mutex);
+
+static struct bpf_skmsg_link *bpf_skmsg_link(const struct bpf_link *link=
)
+{
+	return container_of(link, struct bpf_skmsg_link, link);
+}
+
+static void bpf_skmsg_link_release(struct bpf_link *link)
+{
+	struct bpf_skmsg_link *skmsg_link =3D bpf_skmsg_link(link);
+
+	mutex_lock(&link_mutex);
+	if (skmsg_link->map) {
+		(void)sock_map_prog_update(skmsg_link->map, NULL, link->prog,
+					   skmsg_link->attach_type);
+		bpf_map_put_with_uref(skmsg_link->map);
+		skmsg_link->map =3D NULL;
+	}
+	mutex_unlock(&link_mutex);
+}
+
+static int bpf_skmsg_link_detach(struct bpf_link *link)
+{
+	bpf_skmsg_link_release(link);
+	return 0;
+}
+
+static void bpf_skmsg_link_dealloc(struct bpf_link *link)
+{
+	kfree(bpf_skmsg_link(link));
+}
+
+static int bpf_skmsg_link_update_prog(struct bpf_link *link,
+				      struct bpf_prog *new_prog,
+				      struct bpf_prog *old_prog)
+{
+	const struct bpf_skmsg_link *skmsg_link =3D bpf_skmsg_link(link);
+	int ret =3D 0;
+
+	mutex_lock(&link_mutex);
+	if (old_prog && link->prog !=3D old_prog) {
+		ret =3D -EPERM;
+		goto out;
+	}
+
+	if (link->prog->type !=3D new_prog->type) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D sock_map_prog_update(skmsg_link->map, new_prog, old_prog,
+				   skmsg_link->attach_type);
+	if (!ret)
+		bpf_prog_inc(new_prog);
+
+out:
+	mutex_unlock(&link_mutex);
+	return ret;
+}
+
+static int bpf_skmsg_link_fill_info(const struct bpf_link *link,
+				    struct bpf_link_info *info)
+{
+	const struct bpf_skmsg_link *skmsg_link =3D bpf_skmsg_link(link);
+	u32 map_id =3D 0;
+
+	mutex_lock(&link_mutex);
+	if (skmsg_link->map)
+		map_id =3D skmsg_link->map->id;
+	mutex_unlock(&link_mutex);
+
+	info->skmsg.map_id =3D map_id;
+	info->skmsg.attach_type =3D skmsg_link->attach_type;
+	return 0;
+}
+
+static void bpf_skmsg_link_show_fdinfo(const struct bpf_link *link,
+				       struct seq_file *seq)
+{
+	const struct bpf_skmsg_link *skmsg_link =3D bpf_skmsg_link(link);
+	u32 map_id =3D 0;
+
+	mutex_lock(&link_mutex);
+	if (skmsg_link->map)
+		map_id =3D skmsg_link->map->id;
+	mutex_unlock(&link_mutex);
+
+	seq_printf(seq, "map_id:\t%u\n", map_id);
+	seq_printf(seq, "attach_type:\t%u (...)\n", skmsg_link->attach_type);
+}
+
+static const struct bpf_link_ops bpf_skmsg_link_ops =3D {
+	.release =3D bpf_skmsg_link_release,
+	.dealloc =3D bpf_skmsg_link_dealloc,
+	.detach =3D bpf_skmsg_link_detach,
+	.update_prog =3D bpf_skmsg_link_update_prog,
+	.fill_link_info =3D bpf_skmsg_link_fill_info,
+	.show_fdinfo =3D bpf_skmsg_link_show_fdinfo,
+};
+
+int bpf_skmsg_link_create(const union bpf_attr *attr, struct bpf_prog *p=
rog)
+{
+	struct bpf_link_primer link_primer;
+	struct bpf_skmsg_link *skmsg_link;
+	enum bpf_attach_type attach_type;
+	struct bpf_map *map;
+	int ret;
+
+	if (attr->link_create.flags)
+		return -EINVAL;
+
+	map =3D bpf_map_get_with_uref(attr->link_create.target_fd);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	skmsg_link =3D kzalloc(sizeof(*skmsg_link), GFP_USER);
+	if (!skmsg_link) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	attach_type =3D attr->link_create.attach_type;
+	bpf_link_init(&skmsg_link->link, BPF_LINK_TYPE_SK_MSG, &bpf_skmsg_link_=
ops, prog);
+	skmsg_link->map =3D map;
+	skmsg_link->attach_type =3D attach_type;
+
+	ret =3D bpf_link_prime(&skmsg_link->link, &link_primer);
+	if (ret) {
+		kfree(skmsg_link);
+		goto out;
+	}
+
+	ret =3D sock_map_prog_update(map, prog, NULL, attach_type);
+	if (ret) {
+		bpf_link_cleanup(&link_primer);
+		goto out;
+	}
+
+	bpf_prog_inc(prog);
+
+	return bpf_link_settle(&link_primer);
+
+out:
+	bpf_map_put_with_uref(map);
+	return ret;
+}
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..63372bc368f1 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -24,8 +24,6 @@ struct bpf_stab {
 #define SOCK_CREATE_FLAG_MASK				\
 	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
=20
-static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *pr=
og,
-				struct bpf_prog *old, u32 which);
 static struct sk_psock_progs *sock_map_progs(struct bpf_map *map);
=20
 static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
@@ -1488,8 +1486,8 @@ static int sock_map_prog_lookup(struct bpf_map *map=
, struct bpf_prog ***pprog,
 	return 0;
 }
=20
-static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *pr=
og,
-				struct bpf_prog *old, u32 which)
+int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
+			 struct bpf_prog *old, u32 which)
 {
 	struct bpf_prog **pprog;
 	int ret;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index a241f407c234..c7d2a5fcf37a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1129,6 +1129,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
+	BPF_LINK_TYPE_SK_MSG =3D 14,
 	__MAX_BPF_LINK_TYPE,
 };
=20
@@ -6699,6 +6700,10 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} netkit;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} skmsg;
 	};
 } __attribute__((aligned(8)));
=20
--=20
2.43.0

