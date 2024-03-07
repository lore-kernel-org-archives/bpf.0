Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7363C7
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781171; cv=none; b=CJer4esxqmAiNIby0F63rAE/LOdasjyBQrDrcnzlMXxH0SufwZvKDctpJ+8moPaCBn/tPCa73tUuKQEJQY9WvPrlaXWS5NkN4vqIHHpPF2Ri8y+p8kCdeunpQw/vN3nUPhZKr2vmHUJPfF2FZgQl/RbkYfUS/SX2Dw90eJGJjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781171; c=relaxed/simple;
	bh=3Vo7RtddkovaUNsfGME8tOTBMZHDqvOqepWoD6kN7E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+kfOVXAcAP4G1fRvPhx3N67sSDyzOhndHDkGFfCVsbaC8wuj1j6Glkey9l9TGqBV3IcSs5EkCrXA9JexMBJ36k6RNZbszFyYKsIKq5d4SVIjFN+Cls/uwDCKxcBhnguYIQlW69SXtCzmlTyrO3JTI3KyTRYgW/m/OETuZN3FhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hcc9YQuo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcc9YQuo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e617b39877so347781b3a.3
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 19:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781169; x=1710385969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m020q1Q9X28dNr+XufqionpS1OXGz7hwSYjHovEffwo=;
        b=Hcc9YQuowPz0pss6LAjrzjlnMgSt0fMfu0d+WbZiR6wU9jQcOEpXjoKcNCvnp4LtTb
         iHMGxz09aEw9I7jYOEuileUCvdlf7pqknyRg+U5GCgwsdG29PUeiAX+l+MuGVJ/wNI2M
         H831Zf5fQXkpo7fEEiOMr+GJYHqBzJ1Byt461ItYt+ku5FPE1Oi+XLU5gJ6UjMoTbmTE
         TDgGqzK4fxmSBzbit6r0Yk1/YEfFwCa3zU3QWkwnDiQeT787ZmiaaBjcthF9ZeOjr1V5
         6Eg8M76MsCwYftxMQxH46PseAq05DRFSzJhzQiWLdUUd93diUknajjY8gwgaHIy6arE1
         A6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781169; x=1710385969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m020q1Q9X28dNr+XufqionpS1OXGz7hwSYjHovEffwo=;
        b=RVIBY2ZwDAioUX8W+7m4oerFZeOFlc4jIL6GyVJ2RptE4vl+JiFbU567T4SAzZm0is
         q4hAyL0EV9GV8u8KWx5WQOACw/QOCNGZIX0H2U4RLUZDlOeUHJT69x5l1cV1WgtG0J/G
         rVMylgvC89l/WcaJW8rCmN1bheM1JKnOcLUZEb+0lIKcQVLFa20Z3VwCI9pM7ubwPUzm
         o+PDLhUKLTTZJxr9AuJreM5yl9Wh5tAaH9LpmKgAzKvYEVwS4Za47ddwUH+huAhKmmA1
         foPRUiZxPRmMX87plqrnmyxm4FAVSU/F/3xBfq9QlybS87coNI2uxBiMQYSaam1w18dS
         5n8A==
X-Gm-Message-State: AOJu0YwWtvtw3R0QtNhFjYxP76nfQzPVliNnS9nHoTbdzd+Uc0I/dJEU
	Rz2V1YG3vY2f/xSlAvQrxIC7fIqj16yrKTjEPisfnaMS6FrdcJ3z8y+TthrJ
X-Google-Smtp-Source: AGHT+IFOgF8VAZmNjlmcLDJ8CsRLseZfZcPuVBXkDztlWPpO+lXh4JziHztmdWMianpPYahMuEOSVQ==
X-Received: by 2002:a05:6a00:22c4:b0:6e4:e7dc:25a4 with SMTP id f4-20020a056a0022c400b006e4e7dc25a4mr22261771pfj.23.1709781168726;
        Wed, 06 Mar 2024 19:12:48 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dd40])
        by smtp.gmail.com with ESMTPSA id s18-20020a056a0008d200b006e5af565b1dsm3615615pfu.201.2024.03.06.19.12.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 19:12:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 4/6] libbpf: Allow specifying 64-bit integers in map BTF.
Date: Wed,  6 Mar 2024 19:12:26 -0800
Message-Id: <20240307031228.42896-5-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

__uint() macro that is used to specify map attributes like:
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __uint(map_flags, BPF_F_MMAPABLE);
It is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements"
field in "struct btf_array".

Introduce __ulong() macro that allows specifying values bigger than 32-bit.
In map definition "map_extra" is the only u64 field, so far.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h |  1 +
 tools/lib/bpf/libbpf.c      | 44 +++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 79eaa581be98..112b1504e072 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -13,6 +13,7 @@
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) typeof(val) *name
 #define __array(name, val) typeof(val) *name[]
+#define __ulong(name, val) enum { ___bpf_concat(__unique_value, __COUNTER__) = val } name
 
 /*
  * Helper macro to place programs, maps, license in
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 672fca94ff53..567ad367e7aa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2335,6 +2335,46 @@ static bool get_map_field_int(const char *map_name, const struct btf *btf,
 	return true;
 }
 
+static bool get_map_field_long(const char *map_name, const struct btf *btf,
+			       const struct btf_member *m, __u64 *res)
+{
+	const struct btf_type *t = skip_mods_and_typedefs(btf, m->type, NULL);
+	const char *name = btf__name_by_offset(btf, m->name_off);
+
+	if (btf_is_ptr(t)) {
+		__u32 res32;
+		bool ret;
+
+		ret = get_map_field_int(map_name, btf, m, &res32);
+		if (ret)
+			*res = (__u64)res32;
+		return ret;
+	}
+
+	if (!btf_is_enum(t) && !btf_is_enum64(t)) {
+		pr_warn("map '%s': attr '%s': expected ENUM or ENUM64, got %s.\n",
+			map_name, name, btf_kind_str(t));
+		return false;
+	}
+
+	if (btf_vlen(t) != 1) {
+		pr_warn("map '%s': attr '%s': invalid __ulong\n",
+			map_name, name);
+		return false;
+	}
+
+	if (btf_is_enum(t)) {
+		const struct btf_enum *e = btf_enum(t);
+
+		*res = e->val;
+	} else {
+		const struct btf_enum64 *e = btf_enum64(t);
+
+		*res = btf_enum64_value(e);
+	}
+	return true;
+}
+
 static int pathname_concat(char *buf, size_t buf_sz, const char *path, const char *name)
 {
 	int len;
@@ -2568,9 +2608,9 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 			map_def->pinning = val;
 			map_def->parts |= MAP_DEF_PINNING;
 		} else if (strcmp(name, "map_extra") == 0) {
-			__u32 map_extra;
+			__u64 map_extra;
 
-			if (!get_map_field_int(map_name, btf, m, &map_extra))
+			if (!get_map_field_long(map_name, btf, m, &map_extra))
 				return -EINVAL;
 			map_def->map_extra = map_extra;
 			map_def->parts |= MAP_DEF_MAP_EXTRA;
-- 
2.43.0

