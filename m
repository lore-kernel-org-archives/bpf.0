Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668821;
	b=gJZdC2+zNuT0m4Ba663msvD9Eq+UDCuwTACooOORD0f1euumcapeVGKO2wg1o05VxL1L
	 GuCTzaMauWNuZvntxlVU6LsJrYauofg5X3epswURLqVHa2QzvhrH2290kZ1vYfTg91JvQ
	 y+WDXotB2IF2t48ztkNjtXm8dcVAE+9dQHUyRN3XAfGHh9pHi8OatoaR8g2GMiN2hF/1b
	 tgh0Y9L78h3TqhMhAr6cDnkkKwE+UtQl9v/2YcRagkYdf9UUpakEWdu+mC2AsVcwWGmZt
	 hCTdoW0dlbcFp+OZYFmcblQkup3ZDom//ayzd4E8S9bkcWkTu8CJ51td2ZQ8ZuHfNfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668821;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DGLR2g+grGDFA6mww683bNHbdliifZC2jNLizybLrBc=;
	b=cRghWsPKLX6i54g9Xh6heP6ooa/mfnTtmLnaZG4ao0tDGHQOj13BXsqmqLfFBifFEB6f
	 AW+Y4hBvtmjKoMsUmA7Iih+g6e3l8X+7t5I5Jmt6tcFd2BmLrObuCxSoQ2N1KFo+e6+Al
	 LUqTp9rB0J/k1BBCR/uLplR/6ufsII6PNX4MwDE1A8dmgZNsQX2Ut2VoFcVNYVbqSiEIz
	 wq25yH9yDEy3hkgM+CIMrTSft1ksW0FIqTzEyTqSHHgxta/2yv8Uf0uac81rp0itcdgJH
	 jiebsOOhFGIo1OiMvWZSNlSxhpAj4LZ+rSAbyclEdczUsFDNFdkOCr4k1WHfSI4SVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kJkdcOe7;
	arc=none smtp.remote-ip=95.215.58.19
Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177A606A32D
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3177A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kJkdcOe7
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OsDn2NgZcK7uFq2CWRqSYfWahg+jy8jfQ3EupV12pRc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668819; v=1; x=1795273619;
 b=kJkdcOe7uQdcYWZBfEt300ds4ayajLhwAnGg5OHqelC1ftCxPVhx1I/9ha9nJrHSh5iCoRTh
 iyt38uURhdsPFFsuJT0SYmwHLFTR8RY3m9LhIRUm4F9kxjU5Kbv5Xm8GIBRE/kUvqW83lJ/5MZu
 sRw6Q8VPGYRiHn7eyYSBZEs4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f7b48eee75fc4284;
	Sat, 14 Nov 2026 15:06:59 +0000
X-Mizu-Trace-ID: f7b48eee75fc4284
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 4/9] bpf: Add log support for cgroup prog link_create
Date: Sat, 14 Nov 2026 23:06:05 +0800
Message-ID: <20261114150610.84507-5-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114150610.84507-1-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cgroup prog BPF_LINK_CREATE returns errors without explaining invalid
flags, target FDs, or relative attachment parameters. Revision mismatches,
cgroup hierarchy restrictions, conflicting attachment flags, and the
per-cgroup program limit can also cause unexplained failures.

Pass the BPF_LINK_CREATE log through the cgroup attachment helpers and
report these failures at the checks that reject the attachment. Diagnose
relative link attachments that omit BPF_F_LINK.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf-cgroup.h |  6 ++-
 kernel/bpf/cgroup.c        | 76 +++++++++++++++++++++++++++-----------
 kernel/bpf/syscall.c       |  4 +-
 3 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 02ef7f899b3d..684bd2cfda6f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -425,7 +425,8 @@ int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype, struct bpf_prog *prog);
 int cgroup_bpf_prog_detach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype);
-int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			   struct bpf_verifier_log *log);
 int cgroup_bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr, u32 uattr_size);
 
@@ -452,7 +453,8 @@ static inline int cgroup_bpf_prog_detach(const union bpf_attr *attr,
 }
 
 static inline int cgroup_bpf_link_attach(const union bpf_attr *attr,
-					 struct bpf_prog *prog)
+					 struct bpf_prog *prog,
+					 struct bpf_verifier_log *log)
 {
 	return -EINVAL;
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 57a785241d42..a4d49c4df712 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -854,7 +854,8 @@ static struct bpf_prog *bpf_get_anchor_prog(u32 flags, u32 id_or_fd)
 }
 
 static struct bpf_prog_list *get_prog_list(struct hlist_head *progs, struct bpf_prog *prog,
-					   struct bpf_cgroup_link *link, u32 flags, u32 id_or_fd)
+					   struct bpf_cgroup_link *link, u32 flags, u32 id_or_fd,
+					   struct bpf_verifier_log *log)
 {
 	bool is_link = flags & BPF_F_LINK, is_id = flags & BPF_F_ID;
 	struct bpf_prog_list *pltmp, *pl = ERR_PTR(-EINVAL);
@@ -867,20 +868,30 @@ static struct bpf_prog_list *get_prog_list(struct hlist_head *progs, struct bpf_
 	is_after = flags & BPF_F_AFTER;
 	if (is_link || is_id || id_or_fd) {
 		/* flags must have either BPF_F_BEFORE or BPF_F_AFTER */
-		if (is_before == is_after)
+		if (is_before == is_after) {
+			bpf_log(log, "Specify exactly one of BPF_F_BEFORE or BPF_F_AFTER.\n");
 			return ERR_PTR(-EINVAL);
-		if ((is_link && !link) || (!is_link && !prog))
+		}
+		if (is_link && !link)
+			return ERR_PTR(-EINVAL);
+		if (!is_link && !prog) {
+			bpf_log(log, "BPF_F_LINK is required for relative link attachment.\n");
 			return ERR_PTR(-EINVAL);
+		}
 	} else if (!hlist_empty(progs)) {
 		/* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
-		if (is_before && is_after)
+		if (is_before && is_after) {
+			bpf_log(log, "BPF_F_BEFORE and BPF_F_AFTER are mutually exclusive.\n");
 			return ERR_PTR(-EINVAL);
+		}
 	}
 
 	if (is_link) {
 		anchor_link = bpf_get_anchor_link(flags, id_or_fd);
-		if (IS_ERR(anchor_link))
+		if (IS_ERR(anchor_link)) {
+			bpf_log(log, "Invalid relative link %s.\n", is_id ? "ID" : "FD");
 			return ERR_CAST(anchor_link);
+		}
 	} else if (is_id || id_or_fd) {
 		anchor_prog = bpf_get_anchor_prog(flags, id_or_fd);
 		if (IS_ERR(anchor_prog))
@@ -905,13 +916,16 @@ static struct bpf_prog_list *get_prog_list(struct hlist_head *progs, struct bpf_
 	hlist_for_each_entry(pltmp, progs, node) {
 		if ((anchor_prog && anchor_prog == pltmp->prog) ||
 		    (anchor_link && anchor_link == &pltmp->link->link)) {
-			if (!!(pltmp->flags & BPF_F_PREORDER) != preorder)
+			if (!!(pltmp->flags & BPF_F_PREORDER) != preorder) {
+				bpf_log(log, "Relative attachment BPF_F_PREORDER mismatch.\n");
 				goto out;
+			}
 			pl = pltmp;
 			goto out;
 		}
 	}
 
+	bpf_log(log, "Relative attachment not found in target cgroup.\n");
 	pl = ERR_PTR(-ENOENT);
 out:
 	if (anchor_link)
@@ -923,11 +937,11 @@ static struct bpf_prog_list *get_prog_list(struct hlist_head *progs, struct bpf_
 
 static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_head *progs,
 			      struct bpf_prog *prog, struct bpf_cgroup_link *link,
-			      u32 flags, u32 id_or_fd)
+			      u32 flags, u32 id_or_fd, struct bpf_verifier_log *log)
 {
 	struct bpf_prog_list *pltmp;
 
-	pltmp = get_prog_list(progs, prog, link, flags, id_or_fd);
+	pltmp = get_prog_list(progs, prog, link, flags, id_or_fd, log);
 	if (IS_ERR(pltmp))
 		return PTR_ERR(pltmp);
 
@@ -952,6 +966,7 @@ static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_head *progs
  * @flags: Option flags
  * @id_or_fd: Relative prog id or fd
  * @revision: bpf_prog_list revision
+ * @log: Optional log for attachment errors
  *
  * Exactly one of @prog or @link can be non-null.
  * Must be called with cgroup_mutex held.
@@ -960,7 +975,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 			       struct bpf_prog *prog, struct bpf_prog *replace_prog,
 			       struct bpf_cgroup_link *link,
 			       enum bpf_attach_type type, u32 flags, u32 id_or_fd,
-			       u64 revision)
+			       u64 revision, struct bpf_verifier_log *log)
 {
 	u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
 	struct bpf_prog *old_prog = NULL;
@@ -991,23 +1006,33 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	atype = bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
 	if (atype < 0)
 		return -EINVAL;
-	if (revision && revision != cgrp->bpf.revisions[atype])
+	if (revision && revision != cgrp->bpf.revisions[atype]) {
+		bpf_log(log, "Cgroup revision mismatch: expected %llu, actual %llu.\n",
+			revision, cgrp->bpf.revisions[atype]);
 		return -ESTALE;
+	}
 
 	progs = &cgrp->bpf.progs[atype];
 
-	if (!hierarchy_allows_attach(cgrp, atype))
+	if (!hierarchy_allows_attach(cgrp, atype)) {
+		bpf_log(log, "Cgroup hierarchy does not allow attachment.\n");
 		return -EPERM;
+	}
 
-	if (!hlist_empty(progs) && cgrp->bpf.flags[atype] != saved_flags)
+	if (!hlist_empty(progs) && cgrp->bpf.flags[atype] != saved_flags) {
 		/* Disallow attaching non-overridable on top
 		 * of existing overridable in this cgroup.
 		 * Disallow attaching multi-prog if overridable or none
 		 */
+		bpf_log(log, "Attachment flags conflict with existing flags.\n");
 		return -EPERM;
+	}
 
-	if (prog_list_length(progs, NULL) >= BPF_CGROUP_MAX_PROGS)
+	if (prog_list_length(progs, NULL) >= BPF_CGROUP_MAX_PROGS) {
+		bpf_log(log, "Too many programs attached to cgroup (limit %u).\n",
+			BPF_CGROUP_MAX_PROGS);
 		return -E2BIG;
+	}
 
 	pl = find_attach_entry(progs, prog, link, replace_prog,
 			       flags & BPF_F_ALLOW_MULTI);
@@ -1029,7 +1054,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 			return -ENOMEM;
 		}
 
-		err = insert_pl_to_hlist(pl, progs, prog, link, flags, id_or_fd);
+		err = insert_pl_to_hlist(pl, progs, prog, link, flags, id_or_fd, log);
 		if (err) {
 			kfree(pl);
 			bpf_cgroup_storages_free(new_storage);
@@ -1089,13 +1114,14 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 			     struct bpf_prog *prog, struct bpf_prog *replace_prog,
 			     struct bpf_cgroup_link *link,
 			     enum bpf_attach_type type,
-			     u32 flags, u32 id_or_fd, u64 revision)
+			     u32 flags, u32 id_or_fd, u64 revision,
+			     struct bpf_verifier_log *log)
 {
 	int ret;
 
 	cgroup_lock();
 	ret = __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags,
-				  id_or_fd, revision);
+				  id_or_fd, revision, log);
 	cgroup_unlock();
 	return ret;
 }
@@ -1572,7 +1598,7 @@ int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 
 	ret = cgroup_bpf_attach(cgrp, prog, replace_prog, NULL,
 				attr->attach_type, attr->attach_flags,
-				attr->relative_fd, attr->expected_revision);
+				attr->relative_fd, attr->expected_revision, NULL);
 
 	if (replace_prog)
 		bpf_prog_put(replace_prog);
@@ -1702,19 +1728,24 @@ static const struct bpf_link_ops bpf_cgroup_link_lops = {
 	 BPF_F_PREORDER |	\
 	 BPF_F_LINK)
 
-int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			   struct bpf_verifier_log *log)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_cgroup_link *link;
 	struct cgroup *cgrp;
 	int err;
 
-	if (attr->link_create.flags & (~BPF_F_LINK_ATTACH_MASK))
+	if (attr->link_create.flags & (~BPF_F_LINK_ATTACH_MASK)) {
+		bpf_log(log, "Invalid flags.\n");
 		return -EINVAL;
+	}
 
 	cgrp = cgroup_get_from_fd(attr->link_create.target_fd);
-	if (IS_ERR(cgrp))
+	if (IS_ERR(cgrp)) {
+		bpf_log(log, "Invalid target_fd.\n");
 		return PTR_ERR(cgrp);
+	}
 
 	link = kzalloc_obj(*link, GFP_USER);
 	if (!link) {
@@ -1734,7 +1765,7 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	err = cgroup_bpf_attach(cgrp, NULL, NULL, link,
 				link->link.attach_type, BPF_F_ALLOW_MULTI | attr->link_create.flags,
 				attr->link_create.cgroup.relative_fd,
-				attr->link_create.cgroup.expected_revision);
+				attr->link_create.cgroup.expected_revision, log);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_cgroup;
@@ -3184,7 +3215,8 @@ int cgroup_bpf_struct_ops_attach(struct bpf_map *map, const union bpf_attr *attr
 	cgrp->bpf.flags[atype] = BPF_F_ALLOW_MULTI;
 
 	err = insert_pl_to_hlist(pl, progs, NULL, link,
-				 flags | BPF_F_ALLOW_MULTI, attr->link_create.cgroup.relative_fd);
+				 flags | BPF_F_ALLOW_MULTI,
+				 attr->link_create.cgroup.relative_fd, NULL);
 	if (err)
 		goto unlock;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9627dfc982ff..35f8a71b5786 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5908,7 +5908,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-		ret = cgroup_bpf_link_attach(attr, prog);
+		ret = cgroup_bpf_link_attach(attr, prog, log);
 		break;
 	case BPF_PROG_TYPE_EXT:
 		ret = bpf_tracing_prog_attach(prog,
@@ -5931,7 +5931,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		else if (prog->expected_attach_type == BPF_TRACE_ITER)
 			ret = bpf_iter_link_attach(attr, uattr, prog, log);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
-			ret = cgroup_bpf_link_attach(attr, prog);
+			ret = cgroup_bpf_link_attach(attr, prog, log);
 		else if (is_tracing_multi(prog->expected_attach_type))
 			ret = bpf_tracing_multi_attach(prog, attr, log);
 		else
-- 
2.55.0

