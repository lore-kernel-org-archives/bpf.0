Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA43ECBD8
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227968; cv=none; b=fo8PoI6hSVa1eSNlKcb8D2BtC3z5Ce2FqpYliVhp1ze87abP9kJLCR79D8B17rbH5G7eG7OZ2AjcDDYdiCfiKPdq5a6W6b4cLgHNoUawrsYZMwkF4Gug0g6TJbK/o9K/lY0SG/0A6Mr7+AaHUxqkLW+wHKygmbCAWNP5gQjhbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227968; c=relaxed/simple;
	bh=KbbAM0mj6/aRRnhCQl2ScYgvfak0wniX0/ziQFNzcUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZqvjwlAjaOAXd+URtzR7CHv65SAbdlSY6aOajCX+OhmTuttukTWI9lf95ygBUCmzAnDaC61U5k8Qa12usReAlRR7wEpxNvRxoGtnrfSOQajMMvzk3Wf6FmKcI606+mLeXrtTNhGVeJ3031UQPlXn412ODbvGRgmXnjB91oBjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UnVFdd2r; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UnVFdd2r"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWXbnJzmDhj8u9ou8+MqYXsqjC+2oOvux4/h9GZrb9w=;
	b=UnVFdd2rvPWgVkbLdI2GzNulOZ0tcdlwAmn9y4U/uQUpR1RpL8FLGB71TLbym48uyHcuxc
	/faQBLNKDHJf31lyJRIR5vI5WloS8SNP/ifQDHfHX30cpFXXnjV7U2XNMpUixEmDqqWvXO
	28dCWTvFVSGpvbI70AUeXR0BOC7Z8LY=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 11/12] libbpf: Support attaching struct_ops to a cgroup
Date: Tue, 19 May 2026 14:58:18 -0700
Message-ID: <20260519215841.2984970-12-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

Add bpf_map__attach_cgroup_opts.

Make bpf_prog_query_opts support type_id.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/lib/bpf/bpf.c            |  2 ++
 tools/lib/bpf/bpf.h            |  3 +-
 tools/lib/bpf/libbpf.c         | 59 ++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h         |  3 ++
 tools/lib/bpf/libbpf.map       |  5 +++
 tools/lib/bpf/libbpf_version.h |  2 +-
 6 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 483c02cf21d1..0be1fc5a64e9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -919,6 +919,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 	case BPF_LSM_CGROUP:
+	case BPF_STRUCT_OPS:
 		relative_fd = OPTS_GET(opts, cgroup.relative_fd, 0);
 		relative_id = OPTS_GET(opts, cgroup.relative_id, 0);
 		if (relative_fd && relative_id)
@@ -1041,6 +1042,7 @@ int bpf_prog_query_opts(int target, enum bpf_attach_type type,
 	attr.query.attach_type		= type;
 	attr.query.query_flags		= OPTS_GET(opts, query_flags, 0);
 	attr.query.count		= OPTS_GET(opts, count, 0);
+	attr.query.type_id		= OPTS_GET(opts, type_id, 0);
 	attr.query.prog_ids		= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
 	attr.query.link_ids		= ptr_to_u64(OPTS_GET(opts, link_ids, NULL));
 	attr.query.prog_attach_flags	= ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2312900a3263..aabac85399b4 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -631,9 +631,10 @@ struct bpf_prog_query_opts {
 	__u32 *link_ids;
 	__u32 *link_attach_flags;
 	__u64 revision;
+	__u32 type_id;
 	size_t :0;
 };
-#define bpf_prog_query_opts__last_field revision
+#define bpf_prog_query_opts__last_field type_id
 
 /**
  * @brief **bpf_prog_query_opts()** queries the BPF programs and BPF links
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ab2071fdd3e8..7ac48b7eea6c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13736,6 +13736,65 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 	return &link->link;
 }
 
+struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map, int cgroup_fd,
+					     const struct bpf_cgroup_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
+	struct bpf_link_struct_ops *link;
+	__u32 relative_id, zero = 0;
+	int err, fd, relative_fd;
+
+	if (!OPTS_VALID(opts, bpf_cgroup_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't attach BPF map without FD (was it created?)\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	relative_id = OPTS_GET(opts, relative_id, 0);
+	relative_fd = OPTS_GET(opts, relative_fd, 0);
+
+	if (relative_fd && relative_id) {
+		pr_warn("map '%s': relative_fd and relative_id cannot be set at the same time\n",
+			map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	link_create_opts.cgroup.expected_revision = OPTS_GET(opts, expected_revision, 0);
+	link_create_opts.cgroup.relative_fd = relative_fd;
+	link_create_opts.cgroup.relative_id = relative_id;
+	link_create_opts.flags = OPTS_GET(opts, flags, 0);
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-ENOMEM);
+
+	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
+	if (err && err != -EBUSY) {
+		free(link);
+		return libbpf_err_ptr(err);
+	}
+
+	link->link.detach = bpf_link__detach_struct_ops;
+
+	fd = bpf_link_create(map->fd, cgroup_fd, BPF_STRUCT_OPS, &link_create_opts);
+	if (fd < 0) {
+		free(link);
+		return libbpf_err_ptr(fd);
+	}
+
+	link->link.fd = fd;
+	link->map_fd = map->fd;
+
+	return &link->link;
+}
+
 /*
  * Swap the back struct_ops of a link with a new struct_ops map.
  */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index bba4e8464396..33274f6f5710 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -945,6 +945,9 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
+LIBBPF_API struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map,
+							int cgroup_fd,
+							const struct bpf_cgroup_opts *opts);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
 struct bpf_iter_attach_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index dfed8d60af05..38b49bbe3193 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -461,3 +461,8 @@ LIBBPF_1.8.0 {
 		bpf_program__clone;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
+
+LIBBPF_1.9.0 {
+	global:
+		bpf_map__attach_cgroup_opts;
+} LIBBPF_1.8.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index c446c0cd8cf9..57b74ef3618c 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 8
+#define LIBBPF_MINOR_VERSION 9
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.53.0-Meta

