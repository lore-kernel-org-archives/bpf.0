Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD48DDA0
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781175; cv=none; b=Jo02TMoo3F9HVP8TNVnzK+3JsRcnqzbzlf5+86fsY8vRP9mWzo7pe1NnMqV+XLShAV0jqpGcvfuDJznlmMb4ABYG+2SAY2qs5/r8/CbjaHfP50AIklkZSlLY/u2N5bOb5wpWBBNLhVMlcD9eXHjvFGwB43GvTtF3vdUF7o6wXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781175; c=relaxed/simple;
	bh=+L0EdhG1lJzIEcfLN+nHMAtbDjoCh7/CUD68fD8ZDVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Id0q6LCvKxceWXkEfE9YnMagAWsZUqt2gqMc6aWKdKxlGj6mHT8SCvXpUW+rbwjGdWgtXnA+opI/0zunNMXgn4YzmgXUlMXRKVU3guMw2+jzoMxsPdO28/yQO9AdHAzHjAS9tYJQgKaQL9XdWfumjt6wMkhSLZUBeeGjvuW0uSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAs1gO5f; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAs1gO5f"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so369227b3a.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 19:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781173; x=1710385973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou+etYFnc3ibpiL/LdevwQV7NT8tdYOvHQaDmdXfzqc=;
        b=MAs1gO5f8NM+2eUHOgzYuk7C/aC7ZLDjjeLPvOlJosDKdlXTVLIzItUlaah93ezEcI
         dmOJ98Os//z55cSG+cBME6xfczHLHbuYvbyGKPuhzZ6AZY3cOQbQY5O+HZyP3YqhRB7V
         m4mqMOMK8eqfAHrW/aW3eevQoo28mzPQPBzWOioy5Du7xDG1DCEAGuaweIHw8/GVbWfL
         xPI8bK9UrJ0n6g3lTHWECyQ4clVAC1w5qMidv4gC57hCiuM1Sy6bB2kJ1VszFPoKkJRd
         XUd0ixUFuB2CJOdwNQngOO0x7TVwMuviHi5oEqh6QgTwSFkl625m6zQH47HGWc8+9/J/
         kuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781173; x=1710385973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou+etYFnc3ibpiL/LdevwQV7NT8tdYOvHQaDmdXfzqc=;
        b=wNfZSu2krkNZkvsP3SQXcp5juNcbuhldv13WMssBe3l8StTJU7+GFjftHKQXYWuXan
         6QjFt7IEdYbduZ7VkCj796gaN3sGER1OC2fpyX0EaMTplcfgICo640BGr0MdNqO4SVpi
         aL2yPQyhrKJdPvtwOpK/MG/JTHCR1c+cgHxprVAvdpFEZhFRWR6tdAGHT9au+qJl813B
         xBwTPrq63MrLx7GPuK+BJLgs6zxPNkUgdtOi6H6b+l7TGCak3L2V8zWUzFIThc+3hTrP
         KJcCNeUsHUnLFKayU6yEheZP5rYxDKGY8LZOAIsLp87IeubEWUvV7/o7kGvMZzv3vUhJ
         IyoQ==
X-Gm-Message-State: AOJu0YzNV/V9Eo31dfR5tIqfh0qIecfeFyIBfZ2BvqQDNrnYmglW7+EY
	oBq9069F3xzseMZb2mYR86g8MXpSyGi3RYICZh/9s7fXcBYlMfDFXPFWm7qt
X-Google-Smtp-Source: AGHT+IHudPQ+6CUhy8HuBd97Wv4oqSap1uW5ljEhI/NAoi2h+awHqfEh63q0wSAnuQU/OnzswV1XWQ==
X-Received: by 2002:a05:6a00:2315:b0:6e6:5291:1779 with SMTP id h21-20020a056a00231500b006e652911779mr396850pfh.6.1709781172733;
        Wed, 06 Mar 2024 19:12:52 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dd40])
        by smtp.gmail.com with ESMTPSA id n39-20020a056a000d6700b006e57defe737sm11575038pfv.76.2024.03.06.19.12.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 19:12:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 5/6] bpftool: rename is_internal_mmapable_map into is_mmapable_map
Date: Wed,  6 Mar 2024 19:12:27 -0800
Message-Id: <20240307031228.42896-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
References: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

It's not restricted to working with "internal" maps, it cares about any
map that can be mmap'ed. Reflect that in more succinct and generic name.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 1f579eacd9d4..a3d72be347b0 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -248,7 +248,7 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
 	return NULL;
 }
 
-static bool is_internal_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
+static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 {
 	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 		return false;
@@ -274,7 +274,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 
 	bpf_object__for_each_map(map, obj) {
 		/* only generate definitions for memory-mapped internal maps */
-		if (!is_internal_mmapable_map(map, map_ident, sizeof(map_ident)))
+		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
 			continue;
 
 		sec = find_type_for_map(btf, map_ident);
@@ -327,7 +327,7 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
 
 	bpf_object__for_each_map(map, obj) {
 		/* only generate definitions for memory-mapped internal maps */
-		if (!is_internal_mmapable_map(map, map_ident, sizeof(map_ident)))
+		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
 			continue;
 
 		sec = find_type_for_map(btf, map_ident);
@@ -504,7 +504,7 @@ static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 		", obj_name);
 
 	bpf_object__for_each_map(map, obj) {
-		if (!is_internal_mmapable_map(map, map_ident, sizeof(map_ident)))
+		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
 			continue;
 
 		sec = find_type_for_map(btf, map_ident);
@@ -720,7 +720,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		const void *mmap_data = NULL;
 		size_t mmap_size = 0;
 
-		if (!is_internal_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
 
 		codegen("\
@@ -782,7 +782,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
 
-		if (!is_internal_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
 
 		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
@@ -871,7 +871,7 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped)
 			",
 			i, bpf_map__name(map), i, ident);
 		/* memory-mapped internal maps */
-		if (mmaped && is_internal_mmapable_map(map, ident, sizeof(ident))) {
+		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
 			printf("\ts->maps[%zu].mmaped = (void **)&obj->%s;\n",
 				i, ident);
 		}
@@ -1617,7 +1617,7 @@ static int do_subskeleton(int argc, char **argv)
 		/* Also count all maps that have a name */
 		map_cnt++;
 
-		if (!is_internal_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
 
 		map_type_id = bpf_map__btf_value_type_id(map);
@@ -1739,7 +1739,7 @@ static int do_subskeleton(int argc, char **argv)
 
 	/* walk through each symbol and emit the runtime representation */
 	bpf_object__for_each_map(map, obj) {
-		if (!is_internal_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
 
 		map_type_id = bpf_map__btf_value_type_id(map);
-- 
2.43.0

