Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B893BBA0F
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879648; cv=none; b=cDqbL5kTFGHrw+zUoTvQ3RDLQ/a52nRZqLNQGoUbmrRelVFdpjawlHmLGgdzBgGhgN8ioUUThVW62YWJXXdCZg2zZyuC5ShYOF8v7qBHbfjcbb/UapNiK1oOFeNL9EQeGHrm1NgHm7GRmxoUcQ9s48mebnlaJyPZ6fXyly9Y46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879648; c=relaxed/simple;
	bh=j7QDNzz93v0lrJROacxtpXe0gdYLlRBTItmaqrdShNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2wLt3mr0eVAFvUx7GLM22Pc4Gm2QOkXFO6Dvs4Z1l/t91Rb3Zvbkg/qjhB9syQCMji5NTI7BEMs5OMMHhikiVClrAW0u3JUjAw1bYphIo+NR5tcLmaWJIK7MO0yckcBstt81A3hWqLq/DczJaHa8850XY67VKjx1O75GXAH5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqpC926J; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqpC926J"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4a24c19feacso901914fac.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879645; x=1792484445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJ89DZMwdBsv7X/0PseavmgAJyW5aD4mGQW3M4O2jRE=;
        b=lqpC926JabQ7O6IuJ9EAW/yYrP20rJoArDNt9A+4rCOnPSjmpFTfQy8Z/1tk/X2bZP
         5wH9lJIh++nvbDMPpQWmuuyEruVR+qSsI4dn2T1eVICGtxP6tlGD7O7W+YvfnkKc7vjY
         YLHdjGq2rcnxlEkWMaLhzcyJXUVM4gmRUJ5hptFBm0Z/6IV9yYvDvQM2UmSMkJ00pW61
         /vgbNUtSe/5sz+kTJhp0HfbgfpMtRWLCZFTJMK0uJ0eTcBKQMoWriVwIEL2k446OKeci
         fOPE3qTm2E4+tkGTa2fxrfKsgsz5u4BBbpkuOG9Efys4o7AJ4GKiBAPKGob6i4sRCWxx
         0F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879645; x=1792484445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LJ89DZMwdBsv7X/0PseavmgAJyW5aD4mGQW3M4O2jRE=;
        b=qvdGLtdOJfgRtvmMwNjirG3SH/aq972qGuqJo8CrnhkKRiW6hSP8V7aySEbuS+0MQq
         buAkpAfsnRoa4q8h0/coO/JAIFH1buFGa9oHZD6S+570D8WvrzUNTS9AzR23nVJvKiEG
         01GrVMlapeOahIKgG3Jm1jE23VdsOaQzK/R6dNPNP7fBlW0o+S+Iud7gtn8C2xyU+x7i
         mf81WX5KqLwI4Wn1mWQnzOqOf2nsMnD/OYl3rnhLjzZDIwYHvbvAfWamOSHmLl5F8GKc
         H6wWAxEjH9kNSfWZNirykQJk1VTYzdkD51eix0Eg0fAXMIjiQ2DSy9WJCQlZpeKcUIzB
         nAaQ==
X-Gm-Message-State: AFq9FYLM/AH/0lKlZkkBwZImgTkSI68LoU4o8CFM6tpb82/A6ZE9um7m
	owwQWJ9TTZ7jjUJMQQcsWzrnjFWCjt+AlhSWHf7YCmt2nZtMC1H1U8t+G3OmVycWYXs=
X-Gm-Gg: AYBFou084WeR+mUNi8zpVUNh+hXkDxyAMQjig48Pahvt67o5G8/DpUOKULWuPEohXu/
	IooGUkeiah8jLt3JMWTKrjFNiMmizICPIETkmrWg+xVQj1RCY4m3orSpeGLVrx5WKO8at+HdLhC
	QDKrHRi6F1tK3n5FeDqFooOXDNvivGG6z04HNuCM5McJvzbnRnORHEL6Wo1lysPTVmyr6D8We7e
	4Klft341bLKTFw2/PoOJ2WGWbEnzBFq6lwwahq8sRYgF5xcnKmKO8A7BPl6D8LRX8FiVCI2eUEi
	cScT1LWACUbQ9Bq34tbkWmEixcU4G75jx5fcD35mEEOyVCK/4Vp1xFTnyW5Bq475so0ZXjIq4A9
	P+SkgZE45/40DDBHSXzB1zYab11Q2xuIpM+51/tW9LEkdGuD6JTSebsnwGol0r0QsxocLmAOSBx
	U6hthT0yqBV/Lqzu2lXTmsjqqYKXl2rt8Ln8jX0yzoOZJSVHK5TYesSubSWY7KjNvCxT6OCtSPr
	/LUOwOOSJpdpA3T5RFqN4FaiI98jG6CIXV7Rmof3RfIYTQf6CiJLAY3kQvQUsOc0LtZJc2NJYXu
	kzPcE8kbTlD5haSw
X-Received: by 2002:a05:6870:b2f2:b0:494:73e0:eeb9 with SMTP id 586e51a60fabf-4a2a8b451a7mr10377261fac.47.1791879645538;
        Tue, 13 Oct 2026 01:20:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a8592e2dsm11095333fac.13.2026.10.13.01.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:44 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/13] libbpf: Bind the arena of an object to every program in it
Date: Tue, 13 Oct 2026 10:20:03 +0200
Message-ID: <20261013082012.1107446-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7772; h=from:subject; bh=j7QDNzz93v0lrJROacxtpXe0gdYLlRBTItmaqrdShNc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy/kaxzeYvey/uqGJMy/xwf9TTmn/vuq+7l5g+ebgjX+X vSe7dZSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAi948zMhx8s9I7SD9n1+7eLEcrqb cecStPL3ay3nBnxZzdL1sOP85h+Cus9DNPIdB3Z4DcPzG2nRuVb+ydv0gl5ua+z3//LtizLpMTAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A program has an arena only when one of its insns refers to the arena
map. The kernel can hand a program arena pointers all the same: as
__arena struct_ops arguments, through __arena struct members and as
kfunc return values. The verifier rejects those in a program without an
arena, since it has nowhere to place them, and so a struct_ops callback
that touches nothing but its arguments fails to load until it refers to
the arena artificially, e.g. with asm volatile("" :: "r"(&arena)).

Bind the arena of an object to every program loaded from it. The kernel
binds the maps of a continuous fd_array (fd_array_cnt) like maps an insn
refers to, so pass the arena in slot 0, which is free: a kfunc insn with
offset 0 names vmlinux BTF rather than a slot. The module BTF slots that
follow stay as they are. A feature probe keeps older kernels, which
reject a non-zero fd_array_cnt, on the previous behavior.

An object has at most one arena, libbpf refuses a second one, so there
is no ambiguity about which arena a program gets. Programs that never
touch the arena pay for the binding with the arena base setup in their
JIT prologue and with the arena showing up among their maps, and the
arena now lives as long as any program of the object. Where the JIT
is disabled or the loader lacks CAP_PERFMON, every program of such an
object now fails to load, since an arena needs both, where before only
the programs using the arena did. bpf_program__clone() binds the arena
the same way, so a program loads through veristat as it does through
bpf_object__load(). The light skeleton loader is left alone.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/features.c        | 40 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 55 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 9f589980beef..71c6a666afcb 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -77,6 +77,43 @@ static int probe_kern_global_data(int token_fd)
 	return probe_fd(ret);
 }
 
+/*
+ * A continuous fd_array binds every map in it to the program, whether an
+ * insn refers to the map or not. Kernels without the attribute reject a
+ * non-zero fd_array_cnt.
+ */
+static int probe_kern_fd_array_cnt(int token_fd)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+		.fd_array_cnt = 1,
+	);
+	int ret, map, insn_cnt = ARRAY_SIZE(insns);
+
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), sizeof(int), 1,
+			     &map_opts);
+	if (map < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
+		return ret;
+	}
+
+	prog_opts.fd_array = &map;
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	close(map);
+	return probe_fd(ret);
+}
+
 static int probe_kern_btf(int token_fd)
 {
 	static const char strs[] = "\0int";
@@ -742,6 +779,9 @@ static struct kern_feature_desc {
 	[FEAT_PERCPU_DATA] = {
 		"kernel supports percpu data", probe_kern_percpu_data,
 	},
+	[FEAT_FD_ARRAY_CNT] = {
+		"continuous fd_array (fd_array_cnt)", probe_kern_fd_array_cnt,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fcedb78abe00..0cd2c25a120d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8804,6 +8804,46 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
 
+/*
+ * Bind the arena of the object to the program about to be loaded. A program
+ * has an arena only when an insn refers to the map, but the kernel can hand
+ * it arena pointers all the same, as struct_ops arguments, through tagged
+ * struct members or as kfunc return values, and the verifier rejects those
+ * when the program has no arena to place them in. A continuous fd_array
+ * binds every map in it, the arena takes slot 0, which is free: a kfunc insn
+ * with offset 0 names vmlinux BTF rather than a slot.
+ */
+static int bpf_object__bind_arena(struct bpf_object *obj, struct bpf_program *prog,
+				  struct bpf_prog_load_opts *load_attr)
+{
+	struct bpf_map *map;
+	int err;
+
+	if (obj->arena_map_idx < 0 || !kernel_supports(obj, FEAT_FD_ARRAY_CNT))
+		return 0;
+	map = &obj->maps[obj->arena_map_idx];
+	/*
+	 * Nothing to bind when the arena is not created, when it is exclusive
+	 * to another program, or for an offloaded program, which the kernel
+	 * does not let near an arena.
+	 */
+	if (!map->autocreate || (map->excl_prog && map->excl_prog != prog) ||
+	    load_attr->prog_ifindex)
+		return 0;
+
+	if (!obj->fd_array_used) {
+		err = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int), 1);
+		if (err)
+			return err;
+		obj->fd_array_used = 1;
+	}
+	obj->fd_array[0] = map->fd;
+	load_attr->fd_array = obj->fd_array;
+	/* with slot 0 filled every slot handed out is valid, so the array can go with a count */
+	load_attr->fd_array_cnt = obj->fd_array_used;
+	return 0;
+}
+
 static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 				struct bpf_insn *insns, int insns_cnt,
 				const char *license, __u32 kern_version, int *prog_fd)
@@ -8867,6 +8907,11 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (obj->data_in_arena)
 		load_attr.prog_flags |= BPF_F_ARENA_SCALAR;
 	load_attr.fd_array = obj->fd_array;
+	if (!obj->gen_loader) {
+		err = bpf_object__bind_arena(obj, prog, &load_attr);
+		if (err)
+			return err;
+	}
 
 	load_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
@@ -9966,8 +10011,10 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
 
 static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 {
-	/* clean up fd_array */
+	/* clean up fd_array, and the slots handed out with it */
 	zfree(&obj->fd_array);
+	obj->fd_array_cap = 0;
+	obj->fd_array_used = 0;
 
 	/* clean up BTF */
 	bpf_object_cleanup_btf(obj);
@@ -10946,6 +10993,12 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	attr.kern_version = OPTS_GET(opts, kern_version, 0) ?: obj->kern_version;
 	attr.fd_array = OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
 	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
+	/* the arena of the object goes with the program, as in bpf_object__load() */
+	if (!obj->gen_loader && !OPTS_GET(opts, fd_array, NULL)) {
+		err = bpf_object__bind_arena(obj, prog, &attr);
+		if (err)
+			return libbpf_err(err);
+	}
 	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
 	if (attr.token_fd)
 		attr.prog_flags |= BPF_F_TOKEN_FD;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4e45dfacb548..22d9fe512ea1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -404,6 +404,8 @@ enum kern_feature_id {
 	FEAT_BPF_SYSCALL_COMMON_ATTRS,
 	/* Kernel supports percpu data */
 	FEAT_PERCPU_DATA,
+	/* Kernel binds every map in a continuous fd_array (fd_array_cnt) to the program */
+	FEAT_FD_ARRAY_CNT,
 	__FEAT_CNT,
 };
 
-- 
2.53.0-Meta

