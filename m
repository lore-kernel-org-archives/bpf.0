Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30270657BD
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619825; cv=none; b=g0g0WGb8tlHk6zAmdqbVkD5HNvHj3AOeYmFf7U+94F62ULAtlAIlMPXGKhBkxMxtQo+DHJod0so+P+P/RxdTqx4f4pwNoZpxAbZJtXgvAfuor6Pl0aqtY+4ebimD7CPlPSveeWkd+BkkhUXjZr9nPP9xr2ZybfmT2cB3wnvBK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619825; c=relaxed/simple;
	bh=kfQwd9dnYccpYR3X434eeW8ynOtMyp/LZb6SZjOjEkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3fagX9E1QOZhM/m+MQxoESSOmpwGB+hOQ+rV7+IDOr2K3RJpcdujk1MfbExti0X6l0KbAnuFXsB90Wk5I7S/FgGyEteBtbSV2NJlzqB4tJhqV3Nqanid7zQFEyyIMgJyLQGeemSO5/Xbf0EuC+hrMGYi2UDzFVp6QAEUCz+gOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=YCAcLIv9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YCAcLIv9"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso7966631fa.3
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711619821; x=1712224621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GeDRkOuZc+1pJREINI73rlwAX5+zgKb+h3LyrDO+EO0=;
        b=YCAcLIv9HWqAGS19TbavzhIzrfXNEzBttICiMyNZoet0qVhuqmT+ug28k5YMAM285l
         ym8fmAhSTdlqJ9AroyAJ31A4rfrNmicDELM2Ofi8Bjw2ULiGpqiniNAnJA8vtKTdKOzc
         QT8phf9k3oL0EmBJRcx979m3LrwjxD52LFxunakt+pABJe8nzAhed22ivfgeXr9izoKd
         8LcQ/6qZR2NK4EvS+Fup7PQ7eMxzrn573ANoYGs81FGgHHoXsin9kgMJnKy5r70ig26b
         vyCXq+zwzvKGUxesw1yBQtD2SxSyL5mg8EB9ZrM8m+/sisDVm6ms2OkOlQoNOtl7o0pD
         Rv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619821; x=1712224621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeDRkOuZc+1pJREINI73rlwAX5+zgKb+h3LyrDO+EO0=;
        b=W1kXKQgYJLhp4Pl+d7dK/tfbW8eRFfbcJtjKS1CgFDcj+73CGI6Ls4mh+R0cqMDPZ7
         AJvm50TExwHRnwW0nAS+UiqmY+9tnc4qeo777TKlMuuPeTQelblUdZMlxg9HeDhgEOBH
         bHnBn45JRp09XqTqqBVlSpEljHail4+lpx3Fsf2SgoPy6HZr76YGUj8sLDqEeIK7y8ZA
         Bqwovuf2gAl3n9vCECkWqmcQKZ9y7R+1uTZcuVLF/xo6y19E7nFfuZxVxQ24R9nAWCne
         +e97iQq1Kvtysmx92ghGJzJb9kFoqEs+5goquFKXo2YuZG3WZR0qTbkn2kKGPkkRRdA2
         ulcw==
X-Forwarded-Encrypted: i=1; AJvYcCWiuBLteD/WrvZvuXjOIafs5FZrG+Ojvj/qJdQGlc9t2f380dv/Hlbv0ZwyQcTH7M2Mj2bPRk0CIUPXl/ZG0NPnALCS
X-Gm-Message-State: AOJu0Yyue5JBlc5KNiVuCoKar8CZ6xVItx0/sLhqghZK/290CtjCpnkK
	aDFh7rPmEKK7dg/GQ4KIEeL1qGpcrRrbkffEn3sCdlSDKutmh4VHMV+SGkXkaXU=
X-Google-Smtp-Source: AGHT+IFbtFowa5nBQJZWrM4SlmUATORLD0mIO1dsxjjFCZZa8DTYVqVOQid11b1k28HayQLDTtaX+A==
X-Received: by 2002:a2e:9acd:0:b0:2d2:4108:72a with SMTP id p13-20020a2e9acd000000b002d24108072amr1845690ljj.12.1711619821167;
        Thu, 28 Mar 2024 02:57:01 -0700 (PDT)
Received: from lavr.home ([2a02:168:f656:0:6017:91c3:e5e1:b05])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b0041493615585sm1754437wmb.39.2024.03.28.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:57:00 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 1/1] bpf: fix possible file descriptor leaks in verifier
Date: Thu, 28 Mar 2024 10:56:57 +0100
Message-Id: <20240328095657.1995763-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resolve_pseudo_ldimm64() function might have leaked file
descriptors when BPF_MAP_TYPE_ARENA was used in a program (some
error paths missed a corresponding fdput).

Fix leaks and also extract code which adds maps to env->used_maps
into a separate function. This simplifies code of resolve_pseudo_ldimm64
and makes it possible to reuse this code later.  While at it, also add a
verifier verbose message when the maps usage limit is reached.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/verifier.c | 150 ++++++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 71 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a1a96ba867d9..0a9c8cd3b01b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18099,6 +18099,12 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
 	}
 }
 
+static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
+{
+	return (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
+		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+}
+
 static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 					struct bpf_map *map,
 					struct bpf_prog *prog)
@@ -18170,13 +18176,77 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
+	if (bpf_map_is_cgroup_storage(map) &&
+			bpf_cgroup_storage_assign(env->prog->aux, map)) {
+		verbose(env, "only one cgroup storage of each type is allowed\n");
+		return -EBUSY;
+	}
+
+	if (map->map_type == BPF_MAP_TYPE_ARENA) {
+		if (env->prog->aux->arena) {
+			verbose(env, "Only one arena per program\n");
+			return -EBUSY;
+		}
+		if (!env->allow_ptr_leaks || !env->bpf_capable) {
+			verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
+			return -EPERM;
+		}
+		if (!env->prog->jit_requested) {
+			verbose(env, "JIT is required to use arena\n");
+			return -EOPNOTSUPP;
+		}
+		if (!bpf_jit_supports_arena()) {
+			verbose(env, "JIT doesn't support arena\n");
+			return -EOPNOTSUPP;
+		}
+		env->prog->aux->arena = (void *)map;
+		if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
+			verbose(env, "arena's user address must be set via map_extra or mmap()\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
+static int env_record_map(struct bpf_verifier_env *env, struct bpf_map *map,
+			  int *map_index_ptr)
 {
-	return (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
-		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	int map_index;
+	int err;
+
+	/* check whether we recorded this map already */
+	for (map_index = 0; map_index < env->used_map_cnt; map_index++) {
+		if (env->used_maps[map_index] == map)
+			goto ret_index;
+	}
+
+	err = check_map_prog_compatibility(env, map, env->prog);
+	if (err)
+		return err;
+
+	if (env->used_map_cnt >= MAX_USED_MAPS) {
+		verbose(env, "The map usage limit of %u is reached\n",
+			MAX_USED_MAPS);
+		return -E2BIG;
+	}
+
+	if (env->prog->sleepable)
+		atomic64_inc(&map->sleepable_refcnt);
+
+	/* hold the map. If the program is rejected by verifier,
+	 * the map will be released by release_maps() or it
+	 * will be used by the valid program until it's unloaded
+	 * and all maps are released in bpf_free_used_maps()
+	 */
+	bpf_map_inc(map);
+
+	env->used_maps[env->used_map_cnt++] = map;
+
+ret_index:
+	if (map_index_ptr)
+		*map_index_ptr = map_index;
+	return 0;
 }
 
 /* find and rewrite pseudo imm in ld_imm64 instructions:
@@ -18190,7 +18260,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	int i, j, err;
+	int i, err;
 
 	err = bpf_prog_calc_tag(env->prog);
 	if (err)
@@ -18278,13 +18348,12 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return PTR_ERR(map);
 			}
 
-			err = check_map_prog_compatibility(env, map, env->prog);
-			if (err) {
-				fdput(f);
+			aux = &env->insn_aux_data[i];
+			err = env_record_map(env, map, &aux->map_index);
+			fdput(f);
+			if (err < 0)
 				return err;
-			}
 
-			aux = &env->insn_aux_data[i];
 			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
 			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
 				addr = (unsigned long)map;
@@ -18293,13 +18362,11 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 
 				if (off >= BPF_MAX_VAR_OFF) {
 					verbose(env, "direct value offset of %u is not allowed\n", off);
-					fdput(f);
 					return -EINVAL;
 				}
 
 				if (!map->ops->map_direct_value_addr) {
 					verbose(env, "no direct value access support for this map type\n");
-					fdput(f);
 					return -EINVAL;
 				}
 
@@ -18307,7 +18374,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				if (err) {
 					verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
 						map->value_size, off);
-					fdput(f);
 					return err;
 				}
 
@@ -18318,66 +18384,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			insn[0].imm = (u32)addr;
 			insn[1].imm = addr >> 32;
 
-			/* check whether we recorded this map already */
-			for (j = 0; j < env->used_map_cnt; j++) {
-				if (env->used_maps[j] == map) {
-					aux->map_index = j;
-					fdput(f);
-					goto next_insn;
-				}
-			}
-
-			if (env->used_map_cnt >= MAX_USED_MAPS) {
-				fdput(f);
-				return -E2BIG;
-			}
-
-			if (env->prog->sleepable)
-				atomic64_inc(&map->sleepable_refcnt);
-			/* hold the map. If the program is rejected by verifier,
-			 * the map will be released by release_maps() or it
-			 * will be used by the valid program until it's unloaded
-			 * and all maps are released in bpf_free_used_maps()
-			 */
-			bpf_map_inc(map);
-
-			aux->map_index = env->used_map_cnt;
-			env->used_maps[env->used_map_cnt++] = map;
-
-			if (bpf_map_is_cgroup_storage(map) &&
-			    bpf_cgroup_storage_assign(env->prog->aux, map)) {
-				verbose(env, "only one cgroup storage of each type is allowed\n");
-				fdput(f);
-				return -EBUSY;
-			}
-			if (map->map_type == BPF_MAP_TYPE_ARENA) {
-				if (env->prog->aux->arena) {
-					verbose(env, "Only one arena per program\n");
-					fdput(f);
-					return -EBUSY;
-				}
-				if (!env->allow_ptr_leaks || !env->bpf_capable) {
-					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
-					fdput(f);
-					return -EPERM;
-				}
-				if (!env->prog->jit_requested) {
-					verbose(env, "JIT is required to use arena\n");
-					return -EOPNOTSUPP;
-				}
-				if (!bpf_jit_supports_arena()) {
-					verbose(env, "JIT doesn't support arena\n");
-					return -EOPNOTSUPP;
-				}
-				env->prog->aux->arena = (void *)map;
-				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
-					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
-					return -EINVAL;
-				}
-			}
-
-			fdput(f);
 next_insn:
+			/* jump over insn[1] */
 			insn++;
 			i++;
 			continue;
-- 
2.34.1

