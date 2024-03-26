Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431680C1F
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419732; cv=none; b=Yf2RUgk8TeVItQAURYonkGPV9+2QD24DhxCv9gE/BrtvemnLKJrCilJXtyHQ+LeLFlgnZbA4yp5Pshw0kXUA0ogvZ6/kUJhQiOTdqcT+oYrgcS7oyPxnvTaxN/Y9yyzLoSEpubgGLck34sOMlGzNKOgQsCC3/1YtX2QPNu03iuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419732; c=relaxed/simple;
	bh=9HwmBjKXDOIghNoZwv9vqX8a0AG8b4y0AA7yLYyZGfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fc5lhL8wcGvfAOkC1xDkq4IV8WSqgI5FHifCMoOzjPNHs2lHzMCmWTDRwTTzBixRwYmsTciuivilO+XMTvlcBkUxBzDKNKoFnvaZxmJHigwT/vbjCId40kyXEomCrh/AJJeNtirTSoRA9E9bt35AsNCGt7mbgqqc7VHtDBsEZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C6D6424DD200; Mon, 25 Mar 2024 19:21:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Mon, 25 Mar 2024 19:21:58 -0700
Message-ID: <20240326022158.656285-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326022153.656006-1-yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
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
 include/linux/bpf.h            |   6 +
 include/linux/skmsg.h          |   4 +
 include/uapi/linux/bpf.h       |   5 +
 kernel/bpf/syscall.c           |   4 +
 net/core/sock_map.c            | 263 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |   5 +
 6 files changed, 279 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 62762390c93d..5034c1b4ded7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2996,6 +2996,7 @@ int sock_map_prog_detach(const union bpf_attr *attr=
, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value=
, u64 flags);
 int sock_map_bpf_prog_query(const union bpf_attr *attr,
 			    union bpf_attr __user *uattr);
+int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *pr=
og);
=20
 void sock_map_unhash(struct sock *sk);
 void sock_map_destroy(struct sock *sk);
@@ -3094,6 +3095,11 @@ static inline int sock_map_bpf_prog_query(const un=
ion bpf_attr *attr,
 {
 	return -EINVAL;
 }
+
+static inline int sock_map_link_create(const union bpf_attr *attr, struc=
t bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
=20
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index e65ec3fd2799..9c8dd4c01412 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -58,6 +58,10 @@ struct sk_psock_progs {
 	struct bpf_prog			*stream_parser;
 	struct bpf_prog			*stream_verdict;
 	struct bpf_prog			*skb_verdict;
+	struct bpf_link			*msg_parser_link;
+	struct bpf_link			*stream_parser_link;
+	struct bpf_link			*stream_verdict_link;
+	struct bpf_link			*skb_verdict_link;
 };
=20
 enum sk_psock_state_bits {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9585f5345353..31660c3ffc01 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1135,6 +1135,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
+	BPF_LINK_TYPE_SOCKMAP =3D 14,
 	__MAX_BPF_LINK_TYPE,
 };
=20
@@ -6720,6 +6721,10 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} netkit;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} sockmap;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e44c276e8617..7d392ec83655 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5213,6 +5213,10 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		ret =3D netns_bpf_link_create(attr, prog);
 		break;
+	case BPF_PROG_TYPE_SK_MSG:
+	case BPF_PROG_TYPE_SK_SKB:
+		ret =3D sock_map_link_create(attr, prog);
+		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
 		ret =3D bpf_xdp_link_attach(attr, prog);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..dafc9aa6e192 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -24,8 +24,12 @@ struct bpf_stab {
 #define SOCK_CREATE_FLAG_MASK				\
 	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
=20
+static DEFINE_MUTEX(sockmap_prog_update_mutex);
+static DEFINE_MUTEX(sockmap_link_mutex);
+
 static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *pr=
og,
-				struct bpf_prog *old, u32 which);
+				struct bpf_prog *old, struct bpf_link *link,
+				u32 which);
 static struct sk_psock_progs *sock_map_progs(struct bpf_map *map);
=20
 static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
@@ -71,7 +75,7 @@ int sock_map_get_from_fd(const union bpf_attr *attr, st=
ruct bpf_prog *prog)
 	map =3D __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	ret =3D sock_map_prog_update(map, prog, NULL, attr->attach_type);
+	ret =3D sock_map_prog_update(map, prog, NULL, NULL, attr->attach_type);
 	fdput(f);
 	return ret;
 }
@@ -103,7 +107,7 @@ int sock_map_prog_detach(const union bpf_attr *attr, =
enum bpf_prog_type ptype)
 		goto put_prog;
 	}
=20
-	ret =3D sock_map_prog_update(map, NULL, prog, attr->attach_type);
+	ret =3D sock_map_prog_update(map, NULL, prog, NULL, attr->attach_type);
 put_prog:
 	bpf_prog_put(prog);
 put_map:
@@ -1488,21 +1492,90 @@ static int sock_map_prog_lookup(struct bpf_map *m=
ap, struct bpf_prog ***pprog,
 	return 0;
 }
=20
+static int sock_map_link_lookup(struct bpf_map *map, struct bpf_link ***=
plink,
+				struct bpf_link *link, bool skip_check, u32 which)
+{
+	struct sk_psock_progs *progs =3D sock_map_progs(map);
+
+	switch (which) {
+	case BPF_SK_MSG_VERDICT:
+		if (!skip_check &&
+		    ((!link && progs->msg_parser_link) ||
+		     (link && link !=3D progs->msg_parser_link)))
+			return -EBUSY;
+		*plink =3D &progs->msg_parser_link;
+		break;
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	case BPF_SK_SKB_STREAM_PARSER:
+		if (!skip_check &&
+		    ((!link && progs->stream_parser_link) ||
+		     (link && link !=3D progs->stream_parser_link)))
+			return -EBUSY;
+		*plink =3D &progs->stream_parser_link;
+		break;
+#endif
+	case BPF_SK_SKB_STREAM_VERDICT:
+		if (!skip_check &&
+		    ((!link && progs->stream_verdict_link) ||
+		     (link && link !=3D progs->stream_verdict_link)))
+			return -EBUSY;
+		*plink =3D &progs->stream_verdict_link;
+		break;
+	case BPF_SK_SKB_VERDICT:
+		if (!skip_check &&
+		    ((!link && progs->skb_verdict_link) ||
+		     (link && link !=3D progs->skb_verdict_link)))
+			return -EBUSY;
+		*plink =3D &progs->skb_verdict_link;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/* Handle the following four cases:
+ * prog_attach: prog !=3D NULL, old =3D=3D NULL, link =3D=3D NULL
+ * prog_detach: prog =3D=3D NULL, old !=3D NULL, link =3D=3D NULL
+ * link_attach: prog !=3D NULL, old =3D=3D NULL, link !=3D NULL
+ * link_detach: prog =3D=3D NULL, old !=3D NULL, link !=3D NULL
+ */
 static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *pr=
og,
-				struct bpf_prog *old, u32 which)
+				struct bpf_prog *old, struct bpf_link *link,
+				u32 which)
 {
 	struct bpf_prog **pprog;
+	struct bpf_link **plink;
 	int ret;
=20
+	mutex_lock(&sockmap_prog_update_mutex);
+
 	ret =3D sock_map_prog_lookup(map, &pprog, which);
 	if (ret)
-		return ret;
+		goto out;
=20
-	if (old)
-		return psock_replace_prog(pprog, prog, old);
+	if (!link || prog)
+		ret =3D sock_map_link_lookup(map, &plink, NULL, false, which);
+	else
+		ret =3D sock_map_link_lookup(map, &plink, NULL, true, which);
+	if (ret)
+		goto out;
+
+	if (old) {
+		ret =3D psock_replace_prog(pprog, prog, old);
+		if (!ret)
+			*plink =3D NULL;
+		goto out;
+	}
=20
 	psock_set_prog(pprog, prog);
-	return 0;
+	if (link)
+		*plink =3D link;
+
+out:
+	mutex_unlock(&sockmap_prog_update_mutex);
+	return ret;
 }
=20
 int sock_map_bpf_prog_query(const union bpf_attr *attr,
@@ -1657,6 +1730,180 @@ void sock_map_close(struct sock *sk, long timeout=
)
 }
 EXPORT_SYMBOL_GPL(sock_map_close);
=20
+struct sockmap_link {
+	struct bpf_link link;
+	struct bpf_map *map;
+	enum bpf_attach_type attach_type;
+};
+
+static struct sockmap_link *get_sockmap_link(const struct bpf_link *link=
)
+{
+	return container_of(link, struct sockmap_link, link);
+}
+
+static void sock_map_link_release(struct bpf_link *link)
+{
+	struct sockmap_link *sockmap_link =3D get_sockmap_link(link);
+
+	mutex_lock(&sockmap_link_mutex);
+	if (sockmap_link->map) {
+		(void)sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
+					   sockmap_link->attach_type);
+		bpf_map_put_with_uref(sockmap_link->map);
+		sockmap_link->map =3D NULL;
+	}
+	mutex_unlock(&sockmap_link_mutex);
+}
+
+static int sock_map_link_detach(struct bpf_link *link)
+{
+	sock_map_link_release(link);
+	return 0;
+}
+
+static void sock_map_link_dealloc(struct bpf_link *link)
+{
+	kfree(get_sockmap_link(link));
+}
+
+/* Handle the following two cases:
+ * case 1: link !=3D NULL, prog !=3D NULL, old !=3D NULL
+ * case 2: link !=3D NULL, prog !=3D NULL, old =3D=3D NULL
+ */
+static int sock_map_link_update_prog(struct bpf_link *link,
+				     struct bpf_prog *prog,
+				     struct bpf_prog *old)
+{
+	const struct sockmap_link *sockmap_link =3D get_sockmap_link(link);
+	struct bpf_prog **pprog;
+	struct bpf_link **plink;
+	int ret =3D 0;
+
+	mutex_lock(&sockmap_prog_update_mutex);
+
+	/* If old prog not NULL, ensure old prog the same as link->prog. */
+	if (old && link->prog !=3D old) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+	/* Ensure link->prog has the same type/attach_type as the new prog. */
+	if (link->prog->type !=3D prog->type ||
+	    link->prog->expected_attach_type !=3D prog->expected_attach_type) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D sock_map_prog_lookup(sockmap_link->map, &pprog,
+				   sockmap_link->attach_type);
+	if (ret)
+		goto out;
+
+	/* Ensure the same link between the one in map and the passed-in. */
+	ret =3D sock_map_link_lookup(sockmap_link->map, &plink, link, false,
+				   sockmap_link->attach_type);
+	if (ret)
+		goto out;
+
+	if (old)
+		return psock_replace_prog(pprog, prog, old);
+
+	psock_set_prog(pprog, prog);
+
+out:
+	if (!ret)
+		bpf_prog_inc(prog);
+	mutex_unlock(&sockmap_prog_update_mutex);
+	return ret;
+}
+
+static u32 sock_map_link_get_map_id(const struct sockmap_link *sockmap_l=
ink)
+{
+	u32 map_id =3D 0;
+
+	mutex_lock(&sockmap_link_mutex);
+	if (sockmap_link->map)
+		map_id =3D sockmap_link->map->id;
+	mutex_unlock(&sockmap_link_mutex);
+	return map_id;
+}
+
+static int sock_map_link_fill_info(const struct bpf_link *link,
+				   struct bpf_link_info *info)
+{
+	const struct sockmap_link *sockmap_link =3D get_sockmap_link(link);
+	u32 map_id =3D sock_map_link_get_map_id(sockmap_link);
+
+	info->sockmap.map_id =3D map_id;
+	info->sockmap.attach_type =3D sockmap_link->attach_type;
+	return 0;
+}
+
+static void sock_map_link_show_fdinfo(const struct bpf_link *link,
+				      struct seq_file *seq)
+{
+	const struct sockmap_link *sockmap_link =3D get_sockmap_link(link);
+	u32 map_id =3D sock_map_link_get_map_id(sockmap_link);
+
+	seq_printf(seq, "map_id:\t%u\n", map_id);
+	seq_printf(seq, "attach_type:\t%u\n", sockmap_link->attach_type);
+}
+
+static const struct bpf_link_ops sock_map_link_ops =3D {
+	.release =3D sock_map_link_release,
+	.dealloc =3D sock_map_link_dealloc,
+	.detach =3D sock_map_link_detach,
+	.update_prog =3D sock_map_link_update_prog,
+	.fill_link_info =3D sock_map_link_fill_info,
+	.show_fdinfo =3D sock_map_link_show_fdinfo,
+};
+
+int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *pr=
og)
+{
+	struct bpf_link_primer link_primer;
+	struct sockmap_link *sockmap_link;
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
+	sockmap_link =3D kzalloc(sizeof(*sockmap_link), GFP_USER);
+	if (!sockmap_link) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	attach_type =3D attr->link_create.attach_type;
+	bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_map_lin=
k_ops, prog);
+	sockmap_link->map =3D map;
+	sockmap_link->attach_type =3D attach_type;
+
+	ret =3D bpf_link_prime(&sockmap_link->link, &link_primer);
+	if (ret) {
+		kfree(sockmap_link);
+		goto out;
+	}
+
+	ret =3D sock_map_prog_update(map, prog, NULL, &sockmap_link->link, atta=
ch_type);
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
+
 static int sock_map_iter_attach_target(struct bpf_prog *prog,
 				       union bpf_iter_link_info *linfo,
 				       struct bpf_iter_aux_info *aux)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 9585f5345353..31660c3ffc01 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1135,6 +1135,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
+	BPF_LINK_TYPE_SOCKMAP =3D 14,
 	__MAX_BPF_LINK_TYPE,
 };
=20
@@ -6720,6 +6721,10 @@ struct bpf_link_info {
 			__u32 ifindex;
 			__u32 attach_type;
 		} netkit;
+		struct {
+			__u32 map_id;
+			__u32 attach_type;
+		} sockmap;
 	};
 } __attribute__((aligned(8)));
=20
--=20
2.43.0

