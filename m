Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A022638
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860128; cv=none; b=lr6K9v3cFvU2D5YGqZlFQahdU19lK7BTMFreqZHlyFUOxiwe+FyaLI6rBjvSGNTDFg0mtAMKyKOMgNzIwd4qKrvwzTh6h6dpFyLWtZGrlv92PW1m8jsCvy56kTU4WhmmIYdp13/qORquJ1mQOH7diwA/0zddDAdlOeAp9P6WmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860128; c=relaxed/simple;
	bh=9gvfpyZfiypr9xCNkOwEjG5wiRxz9y5RUqrXxPfdBKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6cVBDfHikTRe9SO2qUAcpK1jfUaf1JUXn6u1imOjFTbgZWsOctzhNgUidw0otNYxKCO9ZQ08IoKBVSEY7lxVGEY6Fc6jYPcJRmJJ39rxW8aKqnKubbpaDp4FjAZxH1X0jymcNYrjcl4SeD2yGS+mA2QQ8AdvR47VQGkAAlJdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUwXYVhz; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUwXYVhz"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21eea6aab5eso817874fac.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860124; x=1710464924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ3wipPJkzBXkAf+0tGonUTvUit9U85GVfiOeVf+bQg=;
        b=KUwXYVhzY2sTJRIbxG2c9yBfvIzn27SSBI2FwttOoOELuRYNGLW8AR679sTvmi9PUa
         4MliJBNqcNellqWKtccgBLazBSTPC+V0IQEk7+mFSZ6h9rDaoJVM8AILMocG41HlmdLs
         0/6DJCiqge4sDBMDz9G0RpVhVU5jgONd1AinWOXq1S6+3ZqVT14DuA21PJwlu5bW0M7y
         xyK+xTkJNC/nngWvEkgD97rxxSxB7G9qGtidAGzIef8sR+PDvOHZauiTUvZRUsAGfcgN
         bYQJmJ9SThHK8H49NdLtp0knrCkLDR2CTJilSZgQdHw7meRQUf8WKu+3tQaXlpxXuJt4
         bdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860124; x=1710464924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ3wipPJkzBXkAf+0tGonUTvUit9U85GVfiOeVf+bQg=;
        b=uIZ5ve31G1QYhh7/WBhMetPBLH9kFpUdnVRs9TJRFw4f3p54OjIKCUiljlvOqRUOUa
         hChtZH2nI1YPohdaujnuLbVCmMP92GTHwCpQR8JFnyAnrct/RHc7GJ6yxHFeg9ewIEj7
         O7gJHlI/DKJ8FGGX+ggAM2K/GK/4H4SF5jwI2MHQcm9ENo9ohsgyPTQcmaOGNPEOj461
         EmY6BbK4aXah7FyFBXDd66iTqnop3qG5ePwA29gu+jtidfIbU9x2xCslTo/7bgk6rMLx
         ruUryo7WR6lCcT5JxrdBICbhre/O+1zCu4M/d9bg24EQNFS9t5ucXJz3KII4c1J20QUb
         l3PQ==
X-Gm-Message-State: AOJu0YzPX7ORE2B7aIzdmMrltBurxbWnxYzuqeSIBAYekcLJc+wV+wzc
	a2FG89BApBaw8/IbweP6f45TbRZ9Q9afnC/lJm5xod8W1YX9Iktp6fBcQwC/
X-Google-Smtp-Source: AGHT+IEHBzX1FEefqo9orjWOgHuRn9YByzCkzqsCH0sciZEM8nYEiDIls562lf4GmBYo0ky+H2anKA==
X-Received: by 2002:a05:6871:411:b0:220:8ddb:3f6 with SMTP id d17-20020a056871041100b002208ddb03f6mr1832565oag.12.1709860124584;
        Thu, 07 Mar 2024 17:08:44 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id k30-20020a63ba1e000000b005d6b5934deesm11679456pgf.48.2024.03.07.17.08.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 08/14] libbpf: Add support for bpf_arena.
Date: Thu,  7 Mar 2024 17:08:06 -0800
Message-Id: <20240308010812.89848-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

mmap() bpf_arena right after creation, since the kernel needs to
remember the address returned from mmap. This is user_vm_start.
LLVM will generate bpf_arena_cast_user() instructions where
necessary and JIT will add upper 32-bit of user_vm_start
to such pointers.

Fix up bpf_map_mmap_sz() to compute mmap size as
map->value_size * map->max_entries for arrays and
PAGE_SIZE * map->max_entries for arena.

Don't set BTF at arena creation time, since it doesn't support it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c        | 47 +++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf_probes.c |  7 ++++++
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 567ad367e7aa..34b722071874 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -185,6 +185,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
+	[BPF_MAP_TYPE_ARENA]			= "arena",
 };
 
 static const char * const prog_type_name[] = {
@@ -1684,7 +1685,7 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 	return map;
 }
 
-static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
+static size_t array_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
 {
 	const long page_sz = sysconf(_SC_PAGE_SIZE);
 	size_t map_sz;
@@ -1694,6 +1695,20 @@ static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)
 	return map_sz;
 }
 
+static size_t bpf_map_mmap_sz(const struct bpf_map *map)
+{
+	const long page_sz = sysconf(_SC_PAGE_SIZE);
+
+	switch (map->def.type) {
+	case BPF_MAP_TYPE_ARRAY:
+		return array_map_mmap_sz(map->def.value_size, map->def.max_entries);
+	case BPF_MAP_TYPE_ARENA:
+		return page_sz * map->def.max_entries;
+	default:
+		return 0; /* not supported */
+	}
+}
+
 static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t new_sz)
 {
 	void *mmaped;
@@ -1847,7 +1862,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
 		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
 
-	mmap_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
+	mmap_sz = bpf_map_mmap_sz(map);
 	map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
 			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 	if (map->mmaped == MAP_FAILED) {
@@ -5017,6 +5032,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_QUEUE:
 	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_ARENA:
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
@@ -5261,7 +5277,19 @@ bpf_object__create_maps(struct bpf_object *obj)
 				if (err < 0)
 					goto err_out;
 			}
-
+			if (map->def.type == BPF_MAP_TYPE_ARENA) {
+				map->mmaped = mmap((void *)map->map_extra, bpf_map_mmap_sz(map),
+						   PROT_READ | PROT_WRITE,
+						   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
+						   map->fd, 0);
+				if (map->mmaped == MAP_FAILED) {
+					err = -errno;
+					map->mmaped = NULL;
+					pr_warn("map '%s': failed to mmap arena: %d\n",
+						map->name, err);
+					return err;
+				}
+			}
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
 				err = init_map_in_map_slots(obj, map);
 				if (err < 0)
@@ -8761,7 +8789,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 	if (map->mmaped) {
 		size_t mmap_sz;
 
-		mmap_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
+		mmap_sz = bpf_map_mmap_sz(map);
 		munmap(map->mmaped, mmap_sz);
 		map->mmaped = NULL;
 	}
@@ -9995,11 +10023,14 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 		return libbpf_err(-EBUSY);
 
 	if (map->mmaped) {
-		int err;
 		size_t mmap_old_sz, mmap_new_sz;
+		int err;
+
+		if (map->def.type != BPF_MAP_TYPE_ARRAY)
+			return -EOPNOTSUPP;
 
-		mmap_old_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
-		mmap_new_sz = bpf_map_mmap_sz(size, map->def.max_entries);
+		mmap_old_sz = bpf_map_mmap_sz(map);
+		mmap_new_sz = array_map_mmap_sz(size, map->def.max_entries);
 		err = bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
 		if (err) {
 			pr_warn("map '%s': failed to resize memory-mapped region: %d\n",
@@ -13530,7 +13561,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 
 	for (i = 0; i < s->map_cnt; i++) {
 		struct bpf_map *map = *s->maps[i].map;
-		size_t mmap_sz = bpf_map_mmap_sz(map->def.value_size, map->def.max_entries);
+		size_t mmap_sz = bpf_map_mmap_sz(map);
 		int prot, map_fd = map->fd;
 		void **mmaped = s->maps[i].mmaped;
 
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index ee9b1dbea9eb..302188122439 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -338,6 +338,13 @@ static int probe_map_create(enum bpf_map_type map_type)
 		key_size = 0;
 		max_entries = 1;
 		break;
+	case BPF_MAP_TYPE_ARENA:
+		key_size	= 0;
+		value_size	= 0;
+		max_entries	= 1; /* one page */
+		opts.map_extra	= 0; /* can mmap() at any address */
+		opts.map_flags	= BPF_F_MMAPABLE;
+		break;
 	case BPF_MAP_TYPE_HASH:
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PROG_ARRAY:
-- 
2.43.0

