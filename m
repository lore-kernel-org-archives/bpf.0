Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D13B47FF;
	Sat, 27 Jun 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571980; cv=none; b=D/5PXtpTtnhSiryIZvIzYihHjbpkX/3v/KYdMTGlQ/KhWd615q2nSBVqrm7UzFqNnuq82w7NssZPq6209sYOb59Tr5vol6kdvIlK7BbbUCOy9FRpJtFgnLFIlNw3OCAB3vKJuLLWz120frGRkFZuoo4merxcnzlEjT0LJKWH+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571980; c=relaxed/simple;
	bh=ZwKsvVvWgExkmPwmELKiA+kBr5AMM3KNewkdrMNESl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0SvXD9hbXdZGZo5lfHlkQy+mw0nJ5YtpZrf48geZRNByMMYHG8mFixWwITWDrlU7anzz0lC5jMherGIYV2vXxD7JY9J5q2xGmZH8X7JsbAn8xbZmRHNp5jWxS+UOg5P/1mCjuNe4Uwcd3Pjh4Nc8d5yKps6DiokC2dc3/qWlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB346pyzKHMMy;
	Sat, 27 Jun 2026 22:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E3CEB40635;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S6;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 04/12] bpf: Create insn_array map for bpf SDT probe
Date: Sat, 27 Jun 2026 22:51:38 +0000
Message-ID: <809bd2ae46a0505a1f8fdaeacb4e1db489bfa641.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S6
X-Coremail-Antispam: 1UD129KBjvAXoW3KFyUXFyfKr45Kw1rAF1fJFb_yoW8GFyUJo
	WIgr45GF48G34xAFW8Jrn3GFZ5Zay8K39rJr4aqrn8Xa45G3sY9r4fGw4xZ3W2v348JF17
	uF97Aas5Zws5CFyfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOf7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8Xw
	A2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28l
	Y4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr
	1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl
	6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv04
	87Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jVUDXUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Create one BPF_MAP_TYPE_INSN_ARRAY map per program from the parsed
SDT entries. Each map is tagged with BPF_F_INSN_ARRAY_SDT and
populated with the instruction offset, argument count, and per-argument
registers.

Since the SDT map is not explicitly referenced by any instruction in the
bpf program, add a new sdt_map_fd attr field to pass the map fd to the
kernel, so the verifier can bind it to the program's used_maps.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h       |  11 ++-
 kernel/bpf/bpf_insn_array.c    |  19 ++++-
 kernel/bpf/cfg.c               |   3 +
 kernel/bpf/syscall.c           |   2 +-
 kernel/bpf/verifier.c          |  23 ++++++
 tools/include/uapi/linux/bpf.h |  11 ++-
 tools/lib/bpf/bpf.c            |   3 +-
 tools/lib/bpf/bpf.h            |   4 +-
 tools/lib/bpf/libbpf.c         | 141 ++++++++++++++++++++++++++++++++-
 9 files changed, 210 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c91b5a4bda03..6a03e3f0506e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1466,6 +1466,9 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+/* insn_array map is used for bpf SDT probe */
+	BPF_F_INSN_ARRAY_SDT	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1669,6 +1672,10 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		/* fd of the BPF_MAP_TYPE_INSN_ARRAY map created with
+		 * BPF_F_INSN_ARRAY_SDT, used for SDT probe
+		 */
+		__u32		sdt_map_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -7732,7 +7739,9 @@ struct bpf_insn_array_value {
 	__u32 orig_off;
 	__u32 xlated_off;
 	__u32 jitted_off;
-	__u32 :32;
+	__u8  nargs;		/* argument count (0..5) */
+	__u8  arg_reg[5];	/* BPF register for each argument */
+	__u8  pad[2];
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index a2f84afe6f7c..f43777c5cd07 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -7,6 +7,7 @@ struct bpf_insn_array {
 	struct bpf_map map;
 	atomic_t used;
 	long *ips;
+	int subtype;
 	DECLARE_FLEX_ARRAY(struct bpf_insn_array_value, values);
 };
 
@@ -15,6 +16,11 @@ struct bpf_insn_array {
 
 #define INSN_DELETED ((u32)-1)
 
+enum bpf_insn_array_subtype {
+	BPF_INSN_ARRAY_SUBTYPE_JUMP_TABLE = 0,
+	BPF_INSN_ARRAY_SUBTYPE_SDT = 1,
+};
+
 static inline u64 insn_array_alloc_size(u32 max_entries)
 {
 	const u64 base_size = sizeof(struct bpf_insn_array);
@@ -28,7 +34,8 @@ static int insn_array_alloc_check(union bpf_attr *attr)
 	u32 value_size = sizeof(struct bpf_insn_array_value);
 
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
-	    attr->value_size != value_size || attr->map_flags != 0)
+	    attr->value_size != value_size ||
+	    attr->map_flags & ~BPF_F_INSN_ARRAY_SDT)
 		return -EINVAL;
 
 	return 0;
@@ -55,6 +62,11 @@ static struct bpf_map *insn_array_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&insn_array->map, attr);
 
+	if (attr->map_flags & BPF_F_INSN_ARRAY_SDT)
+		insn_array->subtype = BPF_INSN_ARRAY_SUBTYPE_SDT;
+	else
+		insn_array->subtype = BPF_INSN_ARRAY_SUBTYPE_JUMP_TABLE;
+
 	/* BPF programs aren't allowed to write to the map */
 	insn_array->map.map_flags |= BPF_F_RDONLY_PROG;
 
@@ -90,6 +102,11 @@ static long insn_array_update_elem(struct bpf_map *map, void *key, void *value,
 
 	insn_array->values[index].orig_off = val.orig_off;
 
+	if (insn_array->subtype == BPF_INSN_ARRAY_SUBTYPE_SDT) {
+		insn_array->values[index].nargs = val.nargs;
+		memcpy(insn_array->values[index].arg_reg, val.arg_reg, sizeof(val.arg_reg));
+	}
+
 	return 0;
 }
 
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 26d37066465f..1b8734ee4bf3 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -251,6 +251,9 @@ static struct bpf_iarray *jt_from_map(struct bpf_map *map)
 	int err;
 	int n;
 
+	if (map->map_flags & BPF_F_INSN_ARRAY_SDT)
+		return ERR_PTR(-EINVAL);
+
 	jt = bpf_iarray_realloc(NULL, map->max_entries);
 	if (!jt)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..dc881e5ad411 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2967,7 +2967,7 @@ int __init __used bpf_multi_func(void) { return 0; }
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD keyring_id
+#define BPF_PROG_LOAD_LAST_FIELD sdt_map_fd
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *attr_log)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..05734163650a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19800,6 +19800,29 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret)
 		goto skip_full_check;
 
+	if (attr->sdt_map_fd) {
+		CLASS(fd, f)(attr->sdt_map_fd);
+		struct bpf_map *sdt_map = __bpf_map_get(f);
+
+		if (IS_ERR(sdt_map)) {
+			verbose(env, "sdt_map_fd %d is not a valid bpf_map\n",
+				attr->sdt_map_fd);
+			ret = PTR_ERR(sdt_map);
+			goto skip_full_check;
+		}
+		if (sdt_map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
+			verbose(env, "sdt_map_fd %d is not an INSN_ARRAY map\n",
+				attr->sdt_map_fd);
+			ret = -EINVAL;
+			goto skip_full_check;
+		}
+		ret = __add_used_map(env, sdt_map);
+		if (ret < 0) {
+			verbose(env, "failed to bind SDT map to program: %d\n", ret);
+			goto skip_full_check;
+		}
+	}
+
 	mark_verifier_state_clean(env);
 
 	if (IS_ERR(btf_vmlinux)) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c91b5a4bda03..6a03e3f0506e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1466,6 +1466,9 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+/* insn_array map is used for bpf SDT probe */
+	BPF_F_INSN_ARRAY_SDT	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1669,6 +1672,10 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		/* fd of the BPF_MAP_TYPE_INSN_ARRAY map created with
+		 * BPF_F_INSN_ARRAY_SDT, used for SDT probe
+		 */
+		__u32		sdt_map_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -7732,7 +7739,9 @@ struct bpf_insn_array_value {
 	__u32 orig_off;
 	__u32 xlated_off;
 	__u32 jitted_off;
-	__u32 :32;
+	__u8  nargs;		/* argument count (0..5) */
+	__u8  arg_reg[5];	/* BPF register for each argument */
+	__u8  pad[2];
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 96819c082c77..cb006bca97c6 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -295,7 +295,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, keyring_id);
+	const size_t attr_sz = offsetofend(union bpf_attr, sdt_map_fd);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -369,6 +369,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 
 	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
 	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
+	attr.sdt_map_fd = OPTS_GET(opts, sdt_map_fd, 0);
 
 	if (log_level) {
 		attr.log_buf = ptr_to_u64(log_buf);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7534a593edae..88294bb6b120 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -128,9 +128,11 @@ struct bpf_prog_load_opts {
 
 	/* if set, provides the length of fd_array */
 	__u32 fd_array_cnt;
+	/* if set, FD of the program's BPF_MAP_TYPE_INSN_ARRAY SDT map */
+	__u32 sdt_map_fd;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field fd_array_cnt
+#define bpf_prog_load_opts__last_field sdt_map_fd
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 327c9d412fe8..3f8b12a1eb8b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -494,6 +494,7 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
+	int sdt_map_fd;
 	bool autoload;
 	bool autoattach;
 	bool sym_global;
@@ -519,6 +520,9 @@ struct bpf_program {
 
 	struct bpf_light_subprog *subprogs;
 	__u32 subprog_cnt;
+
+	/* index of the main program that absorbed this subprog */
+	int absorbed_by;
 };
 
 struct bpf_struct_ops {
@@ -879,7 +883,9 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 
 	prog->type = BPF_PROG_TYPE_UNSPEC;
 	prog->fd = -1;
+	prog->sdt_map_fd = -1;
 	prog->exception_cb_idx = -1;
+	prog->absorbed_by = -1;
 
 	/* libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
@@ -6686,6 +6692,131 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
 	return err;
 }
 
+static int bpf_object__resolve_sdt_progs(struct bpf_object *obj)
+{
+	int i, j;
+	struct bpf_light_subprog *sp;
+
+	for (i = 0; i < obj->sdt_entry_cnt; i++) {
+		struct sdt_entry *e = &obj->sdt_entries[i];
+		struct bpf_program *prog, *subprog;
+
+		prog = find_prog_by_sec_insn(obj, e->sec_idx, e->insn_idx);
+		if (!prog) {
+			pr_warn("sdt: probe '%s' at sec %u insn %llu not found in any program\n",
+				e->name, (unsigned)e->sec_idx, (unsigned long long)e->insn_idx);
+			return -EINVAL;
+		}
+
+		/* resolve subprog probe in the main prog that absorbed the subprog */
+		if (prog_is_subprog(obj, prog) && prog->absorbed_by != -1) {
+			subprog = prog;
+			prog = &obj->programs[prog->absorbed_by];
+			for (j = 0; j < prog->subprog_cnt; j++) {
+				sp = &prog->subprogs[j];
+				if (sp->sec_insn_off == subprog->sec_insn_off) {
+					e->insn_idx = sp->sub_insn_off +
+						       (e->insn_idx - sp->sec_insn_off);
+					break;
+				}
+			}
+			if (j >= prog->subprog_cnt) {
+				pr_warn("sdt: subprog probe '%s' not found\n", e->name);
+				return -EINVAL;
+			}
+		}
+
+		e->prog_idx = prog - obj->programs;
+	}
+	return 0;
+}
+
+static int bpf_object__create_sdt_maps(struct bpf_object *obj)
+{
+	const __u32 value_size = sizeof(struct bpf_insn_array_value);
+	struct bpf_insn_array_value val = {};
+	struct bpf_program *prog;
+	struct {
+		__u32 sdt_cnt;
+		__u32 next_key;
+	} *prog_sdt;
+	int i, err = 0;
+
+	if (!obj->sdt_entry_cnt)
+		return 0;
+
+	err = bpf_object__resolve_sdt_progs(obj);
+	if (err)
+		return err;
+
+	prog_sdt = calloc(obj->nr_programs, sizeof(*prog_sdt));
+	if (!prog_sdt)
+		return -ENOMEM;
+
+	/* count entries per program */
+	for (i = 0; i < obj->sdt_entry_cnt; i++)
+		prog_sdt[obj->sdt_entries[i].prog_idx].sdt_cnt++;
+
+	/* create insn_array maps per program and populate entries */
+	for (i = 0; i < obj->sdt_entry_cnt; i++) {
+		__u32 key;
+		struct sdt_entry *e = &obj->sdt_entries[i];
+		__u32 sdt_cnt = prog_sdt[e->prog_idx].sdt_cnt;
+
+		if (!sdt_cnt)
+			continue;
+
+		prog = &obj->programs[e->prog_idx];
+
+		if (prog->sdt_map_fd < 0) {
+			int map_fd;
+			LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+
+			map_opts.map_flags = BPF_F_INSN_ARRAY_SDT;
+			map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".bpf_sdt_notes",
+						sizeof(key), value_size, sdt_cnt, &map_opts);
+			if (map_fd < 0) {
+				err = map_fd;
+				goto out_free;
+			}
+			prog->sdt_map_fd = map_fd;
+		}
+
+		key = prog_sdt[e->prog_idx].next_key++;
+
+		memset(&val, 0, sizeof(val));
+		val.nargs = e->nargs;
+		val.orig_off = e->insn_idx - prog->sec_insn_off;
+		memcpy(val.arg_reg, e->arg_reg, sizeof(val.arg_reg));
+
+		err = bpf_map_update_elem(prog->sdt_map_fd, &key, &val, 0);
+		if (err)
+			goto out_free;
+	}
+
+	/* freeze maps */
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->programs[i];
+		if (prog->sdt_map_fd >= 0) {
+			err = bpf_map_freeze(prog->sdt_map_fd);
+			if (err)
+				goto out_free;
+		}
+	}
+
+out_free:
+	free(prog_sdt);
+	if (err) {
+		for (i = 0; i < obj->nr_programs; i++) {
+			if (obj->programs[i].sdt_map_fd >= 0) {
+				close(obj->programs[i].sdt_map_fd);
+				obj->programs[i].sdt_map_fd = -1;
+			}
+		}
+	}
+	return err;
+}
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -7135,6 +7266,8 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 			err = bpf_object__append_subprog_code(obj, main_prog, subprog);
 			if (err)
 				return err;
+			if (subprog->absorbed_by == -1)
+				subprog->absorbed_by = main_prog - obj->programs;
 			err = bpf_object__reloc_code(obj, main_prog, subprog);
 			if (err)
 				return err;
@@ -8254,6 +8387,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.log_level = log_level;
 	load_attr.prog_flags = prog->prog_flags;
 	load_attr.fd_array = obj->fd_array;
+	if (prog->sdt_map_fd >= 0)
+		load_attr.sdt_map_fd = prog->sdt_map_fd;
 
 	load_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
@@ -9343,6 +9478,7 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__create_maps(obj);
+	err = err ? : bpf_object__create_sdt_maps(obj);
 	err = err ? : bpf_object_prepare_progs(obj);
 
 	if (err) {
@@ -9893,8 +10029,11 @@ void bpf_object__close(struct bpf_object *obj)
 	obj->nr_maps = 0;
 
 	if (obj->programs && obj->nr_programs) {
-		for (i = 0; i < obj->nr_programs; i++)
+		for (i = 0; i < obj->nr_programs; i++) {
+			if (obj->programs[i].sdt_map_fd >= 0)
+				close(obj->programs[i].sdt_map_fd);
 			bpf_program__exit(&obj->programs[i]);
+		}
 	}
 	zfree(&obj->programs);
 
-- 
2.47.3

