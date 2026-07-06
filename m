Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DB3B38BF
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358396; cv=none; b=eB8XbObcTQ873G1VXleJy7QCpH9TKEXwvlT8Aab9c+3/aASrBpdRpBTBPuJSinh5JiDgizUmHSpkEJWgdGL2nvRVMMwZgkWMkAbiONLWZsk9+vmWdscckCUp+QNwdm22OJ7KJHcN1Uu3h1TzqCwAMiIY31D5v+by4mJcjlIKvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358396; c=relaxed/simple;
	bh=9CepVR+uZEeDvw7aOlOydoeIQrBDU7U+vGioXfpa6TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scA0qAEd/+ouT9PowNOGCVKn6IW1RHIuMPRH74eKCGESOIzzvUQtqHp8XoK9hJH0xzwRQ0OqI1Q6MYPYUQmh7KMhxLW7K3qLdNXNRPnoUpD245/RWbDsRWbVRYBM0uMTQrduRGgL7ltZkl7hm9+kGDDUmDFelOwb8An0/b231WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQGoYBPp; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQGoYBPp"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1591718a34.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358394; x=1783963194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zw0ul3r9uurmivTAMJzrSCwIa6lOVXAFgXsTJKFsusI=;
        b=YQGoYBPpEHKN+944PXuUMat3uquxqkElQAMWoqfYrUhFU6WDyNjX4jU+qCWLi+XR1V
         MvWNAWDmkuo0p5wtm9QG6eu5B+buvarRInNZVTh0wuxxkaoM7m9/k15XxXF41jdUhkID
         1cud+GG5lJhst7uMXN1bbl470OER7NzEFkT/4WPnEo/4u6lap8srSsBnTcfbeacr4aZe
         DDHqpgub/YDoQyMchyGhjTXbA9XmSzw7FLZTKSSuglagtnQObOJLJLEw0t7hAzcEA0il
         APrFv5tO6jP0P7MMuKSOL6uJZa3dzQrA17zU5sePg6EuuftL74iJuhRaH/GgaIn0IY4y
         uNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358394; x=1783963194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zw0ul3r9uurmivTAMJzrSCwIa6lOVXAFgXsTJKFsusI=;
        b=lmsz7w5HKxoU8CvsWV2qeWR79x9+ut+7PMurmonp8qfHYqswGj++t48g19rha/I5OA
         ZaxpZX7jyzr9wbSRFFU5WqBFUKmZjthMATGM7mx7d0Zl4u74CCVa+TSuGM2zlGWbiEQZ
         9fqyx7xxKJfN630UQApetn3qH3H4ExyL14FLOHuaY8Ghd49IUjn6Gn6pjsTqPRXWBgPj
         AmkZEO7wcgMaWkoo2SEWlKx02d8e1s5nxysjMsCc2GNLMaBRYCqKSN/rZ2jvYzWM+xRT
         zO1iwWKzNnjyqArFtBwWLfxTG6mhJ1Sny3XttzHHsaNnJXSGWzQC1S3s+7Mh+x2mM/Ro
         mEkg==
X-Gm-Message-State: AOJu0Yykfz3xFXa5xYK1MqsLArwlnsEyc7znPS52/PL1l28SHTRBHUWd
	dMEf8MHl9Mh0+x2njEwl9ywxzf3A86I7Yi+kUJfviQVUP93UU3Izg83PvOY/9A==
X-Gm-Gg: AfdE7cnQnCBJmHseeh3vnAnW2ZdPSsg0SnM+iM2VpwEyHSfezA8VZAm4RNCEmenTaJj
	eZBOr4RMUgYhlkG7cSGGQhQBS9NkgYjKjN4wUO/bPixuwj9Dk/SKGnHqG7qgG1qbT7/1nuoakiJ
	7ZSpFUiVOKi4vIzIkYhGxYmNR4v37PHoBppRunJ5uxPjkZZYQrEDf9XmSYIXDa+7EDUODb5BeRf
	uPlEm/Lde6xXIpZ8rj43U8LuLawS/4Oj/ipuJKZr9ln29xGNTQmznGZGzQBIbQoBhocEReY0Krp
	JEmrhex3KaCTLhHxWV2i9ICR/5KDkqlYFkZK3osT6xhYHmGeCmXMi0ZhwFliHNbAPuKrYtBb8D5
	AwVXN4lvqgJLxpgcE7PbucPSCL59yniuAV2TmyjsXpGqrOx0rT185mY+VdAUGLpGIX9Hx5ZXeIW
	FYIA==
X-Received: by 2002:a05:6830:6414:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7ebb2176e5cmr890737a34.1.1783358393886;
        Mon, 06 Jul 2026 10:19:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb540b19f9sm12083689a34.0.2026.07.06.10.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 13/15] libbpf: Support attaching struct_ops to a cgroup
Date: Mon,  6 Jul 2026 10:19:15 -0700
Message-ID: <20260706171918.317102-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to a cgroup
through a BPF link.

Also extend struct bpf_prog_query_opts with a type_id field so a
BPF_STRUCT_OPS query on a cgroup can select the struct_ops type to
enumerate.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      |  2 ++
 tools/lib/bpf/bpf.h      |  3 +-
 tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  3 ++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 96819c082c77..a9de7f107cf7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -934,6 +934,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 	case BPF_LSM_CGROUP:
+	case BPF_STRUCT_OPS:
 		relative_fd = OPTS_GET(opts, cgroup.relative_fd, 0);
 		relative_id = OPTS_GET(opts, cgroup.relative_id, 0);
 		if (relative_fd && relative_id)
@@ -1056,6 +1057,7 @@ int bpf_prog_query_opts(int target, enum bpf_attach_type type,
 	attr.query.attach_type		= type;
 	attr.query.query_flags		= OPTS_GET(opts, query_flags, 0);
 	attr.query.count		= OPTS_GET(opts, count, 0);
+	attr.query.type_id		= OPTS_GET(opts, type_id, 0);
 	attr.query.prog_ids		= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
 	attr.query.link_ids		= ptr_to_u64(OPTS_GET(opts, link_ids, NULL));
 	attr.query.prog_attach_flags	= ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7534a593edae..490e8cb4ba53 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -637,9 +637,10 @@ struct bpf_prog_query_opts {
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
index 7162146280a8..50a83b9217e4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14104,6 +14104,70 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
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
+	if (!(map->def.map_flags & BPF_F_LINK)) {
+		pr_warn("map '%s': can't attach to cgroup without BPF_F_LINK\n", map->name);
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
index b965ad571540..0e5f4e9bba41 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -960,6 +960,9 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
+LIBBPF_API struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map,
+							int cgroup_fd,
+							const struct bpf_cgroup_opts *opts);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
 struct bpf_iter_attach_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b731df19ae69..5131fdb979b7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -461,4 +461,5 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clone;
 		btf__new_empty_opts;
+		bpf_map__attach_cgroup_opts;
 } LIBBPF_1.7.0;
-- 
2.52.0

