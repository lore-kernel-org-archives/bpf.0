Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838092375B
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870861; cv=none; b=nQzTbJOLUNUhboH++7C1zHTQSed7Qw4+z9oebPoZQEMuSb1iGI2rs2IQgfphBhqLIKqRRJXAOfCWuSq/vs4AoH2v9O53eFWkVRGEbwZR3eoFN121YS0A9Ixd4j+YyDC71GSa90hdmf2G5bwGgv1BIKupWD9MZLFpa7nR+2soZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870861; c=relaxed/simple;
	bh=BWD+RxBGtVBK6879C8Q0gE4YTcZw9tHbq7DphUwSx5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhZm+tUIwYWHKwLaBH1QSLSaQUdTyXGOPq7azjBXadW5IN7SjTyTyjlQfUPwhmRbgxvxP4QY3kkZjmSWemwVhyalV8Ppo0oe9PwXRrN4gfM4OnyqHX66vSn3NSYrofX4HYMdQHFrix3H965+MZX05Fy8WemhYdB4JDcDYAED+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E24BD206A7E3; Tue, 19 Mar 2024 10:54:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/6] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Tue, 19 Mar 2024 10:54:06 -0700
Message-ID: <20240319175406.2940628-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319175401.2940148-1-yonghong.song@linux.dev>
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add bpf_link support for sk_msg and sk_skb programs. We have an
internal request to support bpf_link for sk_msg programs so user
space can have a uniform handling with bpf_link based libbpf
APIs. Using bpf_link based libbpf API also has a benefit which
makes system robust by decoupling prog life cycle and
attachment life cycle.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h            |  13 +++
 include/uapi/linux/bpf.h       |  10 ++
 kernel/bpf/syscall.c           |   4 +
 net/core/skmsg.c               | 164 +++++++++++++++++++++++++++++++++
 net/core/sock_map.c            |   6 +-
 tools/include/uapi/linux/bpf.h |  10 ++
 6 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 17843e66a1d3..8dabd47d3668 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2990,10 +2990,14 @@ int sock_map_prog_detach(const union bpf_attr *at=
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
+int bpf_sk_msg_skb_link_create(const union bpf_attr *attr, struct bpf_pr=
og *prog);
 #else
 static inline int bpf_dev_bound_kfunc_check(struct bpf_verifier_log *log=
,
 					    struct bpf_prog_aux *prog_aux)
@@ -3088,6 +3092,15 @@ static inline int sock_map_bpf_prog_query(const un=
ion bpf_attr *attr,
 {
 	return -EINVAL;
 }
+static inline int sock_map_prog_update(struct bpf_map *map, struct bpf_p=
rog *prog,
+			 struct bpf_prog *old, u32 which)
+{
+	return -EOPNOTSUPP;
+}
+static inline int bpf_sk_msg_skb_link_create(const union bpf_attr *attr,=
 struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3c42b9f1bada..c5506cfca4f8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1135,6 +1135,8 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
+	BPF_LINK_TYPE_SK_MSG =3D 14,
+	BPF_LINK_TYPE_SK_SKB =3D 15,
 	__MAX_BPF_LINK_TYPE,
 };
=20
@@ -6718,6 +6720,14 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} netkit;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} skmsg;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} skskb;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ae2ff73bde7e..3d13eec5a30d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		ret =3D netns_bpf_link_create(attr, prog);
 		break;
+	case BPF_PROG_TYPE_SK_MSG:
+	case BPF_PROG_TYPE_SK_SKB:
+		ret =3D bpf_sk_msg_skb_link_create(attr, prog);
+		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
 		ret =3D bpf_xdp_link_attach(attr, prog);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 4d75ef9d24bf..1aa900ad54d7 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1256,3 +1256,167 @@ void sk_psock_stop_verdict(struct sock *sk, struc=
t sk_psock *psock)
 	sk->sk_data_ready =3D psock->saved_data_ready;
 	psock->saved_data_ready =3D NULL;
 }
+
+struct bpf_sk_msg_skb_link {
+	struct bpf_link link;
+	struct bpf_map *map;
+	enum bpf_attach_type attach_type;
+};
+
+static DEFINE_MUTEX(link_mutex);
+
+static struct bpf_sk_msg_skb_link *bpf_sk_msg_skb_link(const struct bpf_=
link *link)
+{
+	return container_of(link, struct bpf_sk_msg_skb_link, link);
+}
+
+static void bpf_sk_msg_skb_link_release(struct bpf_link *link)
+{
+	struct bpf_sk_msg_skb_link *sk_link =3D bpf_sk_msg_skb_link(link);
+
+	mutex_lock(&link_mutex);
+	if (sk_link->map) {
+		(void)sock_map_prog_update(sk_link->map, NULL, link->prog,
+					   sk_link->attach_type);
+		bpf_map_put_with_uref(sk_link->map);
+		sk_link->map =3D NULL;
+	}
+	mutex_unlock(&link_mutex);
+}
+
+static int bpf_sk_msg_skb_link_detach(struct bpf_link *link)
+{
+	bpf_sk_msg_skb_link_release(link);
+	return 0;
+}
+
+static void bpf_sk_msg_skb_link_dealloc(struct bpf_link *link)
+{
+	kfree(bpf_sk_msg_skb_link(link));
+}
+
+static int bpf_sk_msg_skb_link_update_prog(struct bpf_link *link,
+					   struct bpf_prog *new_prog,
+					   struct bpf_prog *old_prog)
+{
+	const struct bpf_sk_msg_skb_link *sk_link =3D bpf_sk_msg_skb_link(link)=
;
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
+	ret =3D sock_map_prog_update(sk_link->map, new_prog, old_prog,
+				   sk_link->attach_type);
+	if (!ret)
+		bpf_prog_inc(new_prog);
+
+out:
+	mutex_unlock(&link_mutex);
+	return ret;
+}
+
+static int bpf_sk_msg_skb_link_fill_info(const struct bpf_link *link,
+					 struct bpf_link_info *info)
+{
+	const struct bpf_sk_msg_skb_link *sk_link =3D bpf_sk_msg_skb_link(link)=
;
+	u32 map_id =3D 0;
+
+	mutex_lock(&link_mutex);
+	if (sk_link->map)
+		map_id =3D sk_link->map->id;
+	mutex_unlock(&link_mutex);
+
+	if (link->type =3D=3D BPF_LINK_TYPE_SK_MSG) {
+		info->skmsg.map_id =3D map_id;
+		info->skmsg.attach_type =3D sk_link->attach_type;
+	} else {
+		info->skskb.map_id =3D map_id;
+		info->skskb.attach_type =3D sk_link->attach_type;
+	}
+	return 0;
+}
+
+static void bpf_sk_msg_skb_link_show_fdinfo(const struct bpf_link *link,
+					    struct seq_file *seq)
+{
+	const struct bpf_sk_msg_skb_link *sk_link =3D bpf_sk_msg_skb_link(link)=
;
+	u32 map_id =3D 0;
+
+	mutex_lock(&link_mutex);
+	if (sk_link->map)
+		map_id =3D sk_link->map->id;
+	mutex_unlock(&link_mutex);
+
+	seq_printf(seq, "map_id:\t%u\n", map_id);
+	seq_printf(seq, "attach_type:\t%u (...)\n", sk_link->attach_type);
+}
+
+static const struct bpf_link_ops bpf_sk_msg_skb_link_ops =3D {
+	.release =3D bpf_sk_msg_skb_link_release,
+	.dealloc =3D bpf_sk_msg_skb_link_dealloc,
+	.detach =3D bpf_sk_msg_skb_link_detach,
+	.update_prog =3D bpf_sk_msg_skb_link_update_prog,
+	.fill_link_info =3D bpf_sk_msg_skb_link_fill_info,
+	.show_fdinfo =3D bpf_sk_msg_skb_link_show_fdinfo,
+};
+
+int bpf_sk_msg_skb_link_create(const union bpf_attr *attr, struct bpf_pr=
og *prog)
+{
+	struct bpf_link_primer link_primer;
+	struct bpf_sk_msg_skb_link *sk_link;
+	enum bpf_attach_type attach_type;
+	enum bpf_link_type link_type;
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
+	sk_link =3D kzalloc(sizeof(*sk_link), GFP_USER);
+	if (!sk_link) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	if (prog->type =3D=3D BPF_PROG_TYPE_SK_MSG)
+		link_type =3D BPF_LINK_TYPE_SK_MSG;
+	else
+		link_type =3D BPF_LINK_TYPE_SK_SKB;
+
+	attach_type =3D attr->link_create.attach_type;
+	bpf_link_init(&sk_link->link, link_type, &bpf_sk_msg_skb_link_ops, prog=
);
+	sk_link->map =3D map;
+	sk_link->attach_type =3D attach_type;
+
+	ret =3D bpf_link_prime(&sk_link->link, &link_primer);
+	if (ret) {
+		kfree(sk_link);
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
index 3c42b9f1bada..c5506cfca4f8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1135,6 +1135,8 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
+	BPF_LINK_TYPE_SK_MSG =3D 14,
+	BPF_LINK_TYPE_SK_SKB =3D 15,
 	__MAX_BPF_LINK_TYPE,
 };
=20
@@ -6718,6 +6720,14 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} netkit;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} skmsg;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} skskb;
 	};
 } __attribute__((aligned(8)));
=20
--=20
2.43.0

