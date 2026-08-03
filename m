Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D903932F6
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761726; cv=none; b=C1u5+5tdra8duOCBZ4h4AHT0/aH5De/l0/56XUuJ8k1xO6amoqbFvKF50ZEr4RkfWItWtLZid4P2YFqJUWyxNH/sWIqmTIF+fE9ObfLYysMALA7LsDZv3L44QcpsIK99NBjmGvbTTKXPbUToD3XPnPPYErZ2rk2q9JLJqmKxKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761726; c=relaxed/simple;
	bh=DBK2U0Fw8mNaQ7z9CPkbfPCO3ANYFttPj5gy23CUJRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCSfmUyLqq63hwQ8/EEzwfZeNZdJ0fi8/dsvAqUICw9KXPBloWQirYySA/1natgW+S8MEFcliJjgw46BLlyIBPp2cFJImy5Nqs4KEDRlRBlvzHh3vM91Mr1BE0WziYg4KadLEyYQnEUn7RUru0il/nCdUbY7p4YBSwI3qAnQ6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peTNcuEG; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peTNcuEG"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so3582995e9.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761723; x=1786366523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbThS1PrxyBxNcEQm80yHHaj46Ueb887tHYIj0MKP9U=;
        b=peTNcuEGqn19yJF8AKo5xM3OmmQAXMneqflzn9XU1Z1vYfKBjGLE7ORlPx7nQuPGeA
         +G9pqxgBDc1RAiIRKZjT91nxNpksrluBSh5X4SNKdBvbx6z6Sro+9VtUpFYD66ts5M/j
         A1IS4hkLw2hko611MTZGAZDce9G5sSmUvRwc7pJYcOTz75XRRcSDwWLqn0u94szksv6K
         B/FysXIN3y13uxyjiXGKdt/Q14ZYCSFw5p1o+uTVp9JVuyUIjNbHEhn2+H6vo5G11J/T
         6XTBwvvd2tMDfxq8Qpa6ZoYEckF2keUjtLsubo+dutag1XXaLwxyeZTMvY0banbuogBZ
         fADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761723; x=1786366523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbThS1PrxyBxNcEQm80yHHaj46Ueb887tHYIj0MKP9U=;
        b=DCsj6oLTqno+EBCcax5SNWcl0R8dxY/7H4fn+XEUWXWpc2vpW1QPIZuwPsUEAR7S2h
         aHb7S+RgtWITVSfeZm1U08+NJuHIhF0/wnWnugNCpxiPH0rnerqeXk7D/kC3BBm7jCEN
         5qclcnPVfDe+VpKrRhWKIXhn5yssJfhBkS3/wDDWZ+ypzzYLBIVDxB2gSejtp1NPn0WC
         UEMJmc1o+8osTpddVJ/aoH9qqR+yj9RHCRB42/Z+P9gCfqz7Sa7j5fLFrO9dzRmS/FU1
         vNo983ARmKM+M5yj04E0hhDTvHIMKh7pqxKc5CIHVRNTay220ADX6DRecvhLyLnZQE+m
         2PCw==
X-Gm-Message-State: AOJu0YwkHCk6bLI37iyrXT1urXZgUIqXuUJ3aN9RUdMtUHxYkPc0wQoG
	t76NoM/kolhDON5Y1QPQzEsfRzFtn4tS68a40HWJKAQN8d6H0KVlPUW2
X-Gm-Gg: AR+sD12x66RVzwuqN+HQqOXBIjkrVTio7x83n0R2MgBVFU2xTvISkXy4nF66rh8Tlhe
	lpOpqLwioBP1sQyXUITbHjrVEqkULrw4hFEOe+dxKi6DDrHlIzEVC4KemqU7uClY8s/v617lwAj
	pLeyOb8WAg+Wbg9zeYRjTQQ1mHK8KXyKvuxvb+WDO8wUTN7/DTmnBK8koDVsRPog/VhRWDlfYtR
	6+1EyOWk42dsBgzSFBZzHxoB1He4kbhKjAq0d5TSpGRk1arH5b1E1LnV1YMOvCcDaws13Za7v41
	a0sXGuEsFId/G/i7vNlZdD+xCoS791mXaNJ/Ll05w2urfgVMR0DuTndjeSO6BDr4+zvQzhFEH/R
	mLqXNOw0u713muCf+AxBLKv6L4ENFakLSdl0AAPSwqp32Ei093IklnzF7BuYxXukbuEksYHovow
	WID0GZ07a8Z2mZT4Xwzsi+VCVKo19GrWg8Smt1A7dMvrWX4GiSWj3ryIkBfCyNqVfZN1jqkCwuG
	+7RmlDfsRGqJaDQxqcbA/VIsC1cr/lh1TDDIRx5eVhJZejNGQJqPYszb6Gr/UFquz8i1NXFXuCg
	Gg/excRYEEXHPXrO4frPUFj+b5Mom8wKtllSPw==
X-Received: by 2002:a05:600c:214d:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4980c653c0cmr162429085e9.9.1785761722771;
        Mon, 03 Aug 2026 05:55:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808690ffbsm258552165e9.10.2026.08.03.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:55:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from suffixes
Date: Mon,  3 Aug 2026 14:55:18 +0200
Message-ID: <20260803125518.2279340-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel verifier recognizes __arena and __arena_nullable parameter
suffixes for registered kfuncs. These arguments need the matching
address_space(1) BTF type attribute so bpftool emits usable declarations.

Extend the existing KF_ARENA_ARG1/2 handling to select arguments by either
the legacy flag or either suffix. Iterate over all parameters, allowing the
suffix convention at any argument position and avoiding duplicate tags when
a flag and suffix select the same argument.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 btf_encoder.c | 38 ++++++++++++++++++++++++++++----------
 dutil.h       | 13 +++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 4b422e09800f..07ca4f41ac32 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -42,6 +42,8 @@
 #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
 #define BTF_FASTCALL_TAG       "bpf_fastcall"
 #define BPF_ARENA_ATTR         "address_space(1)"
+#define BPF_ARENA_SUFFIX       "__arena"
+#define BPF_ARENA_NULLABLE_SUFFIX "__arena_nullable"
 
 /* kfunc flags, see include/linux/btf.h in the kernel source */
 #define KF_FASTCALL   (1 << 12)
@@ -808,12 +810,32 @@ static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state
 	return id;
 }
 
-/* Modifies state->ret_type_id and state->parms[i].type_id for flagged kfuncs */
+static bool btf__is_bpf_arena_arg(const struct btf *btf,
+				  const struct btf_encoder_func_state *state, int idx)
+{
+	uint32_t flags = state->elf->kfunc_flags;
+	const char *name;
+	size_t name_len;
+
+	if ((idx == 0 && (flags & KF_ARENA_ARG1)) ||
+	    (idx == 1 && (flags & KF_ARENA_ARG2)))
+		return true;
+
+	name = btf__name_by_offset(btf, state->parms[idx].name_off);
+	if (!name)
+		return false;
+	name_len = strlen(name);
+	return (name_len > sizeof(BPF_ARENA_SUFFIX) - 1 && strends(name, BPF_ARENA_SUFFIX)) ||
+	       (name_len > sizeof(BPF_ARENA_NULLABLE_SUFFIX) - 1 &&
+		strends(name, BPF_ARENA_NULLABLE_SUFFIX));
+}
+
+/* Modifies state->ret_type_id and state->parms[i].type_id for arena kfuncs */
 static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
 {
 	uint32_t flags = state->elf->kfunc_flags;
 	int ret_type_id;
-	int err;
+	int err, i;
 
 	if (!btf__add_type_attr) {
 		fprintf(stderr, "btf__add_type_attr is not available, is libbpf < 1.6?\n");
@@ -830,14 +852,10 @@ static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func
 		state->ret_type_id = ret_type_id;
 	}
 
-	if (KF_ARENA_ARG1 & flags) {
-		err = btf__tag_bpf_arena_arg(btf, state, 0);
-		if (err < 0)
-			return err;
-	}
-
-	if (KF_ARENA_ARG2 & flags) {
-		err = btf__tag_bpf_arena_arg(btf, state, 1);
+	for (i = 0; i < state->nr_parms; i++) {
+		if (!btf__is_bpf_arena_arg(btf, state, i))
+			continue;
+		err = btf__tag_bpf_arena_arg(btf, state, i);
 		if (err < 0)
 			return err;
 	}
diff --git a/dutil.h b/dutil.h
index 603556fa0308..d55d01abc842 100644
--- a/dutil.h
+++ b/dutil.h
@@ -335,6 +335,19 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
+/**
+ * strends - does @str end with @suffix?
+ * @str: string to examine
+ * @suffix: suffix to look for.
+ */
+static inline bool strends(const char *str, const char *suffix)
+{
+	size_t str_len = strlen(str);
+	size_t suffix_len = strlen(suffix);
+
+	return suffix_len <= str_len && strcmp(str + str_len - suffix_len, suffix) == 0;
+}
+
 void *zalloc(const size_t size);
 
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
-- 
2.53.0

