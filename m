Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800C146D5A;
	Sat, 27 Jun 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571987; cv=none; b=oqud0ydBmjuyM3xo37rVAnszZjMUQTk/kDcI5EIELultk8q3v2eDDo9rXdcJ2BNgq9gxGIQCNkLr8gYD+OysKZYCQJ3aPGMDQz1FxzdKDHGwsfh3K9wqBPhwwxReBfJbPDmDVC82LY01P1b0lwS62T8Hx95GrsTsa2twVNJx6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571987; c=relaxed/simple;
	bh=/oUU8w+/Bk7zOxr0wAcjNSGWkRKCKLfYcgKMmj/hrko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulF/uGuN/Yic0rhBfL9yT7WCM4dv4p7wiq7dn/KRRmoeoZaluUatbooYSVSYk16Su2B7BZ4P68kIiA/vkP+Zk0xNyDv3FCjcAlLJgxxsay1IR6902RQ1OMZ7yOD1Qsg0ht/g4RhQ2rQW5nOqWBGBbeEu4/TtiJLNJamIopocrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB34kDpzKHMNs;
	Sat, 27 Jun 2026 22:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0171F4058C;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S7;
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
Subject: [RFC PATCH bpf-next 05/12] bpf: Collect SDT probe BTF IDs from BTF decl tags
Date: Sat, 27 Jun 2026 22:51:39 +0000
Message-ID: <ec8e3dcd0857d4ed80151ab68be9acf01fa4d93b.1782571533.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3Xr45trW5XFWrXr4DCFg_yoWrtrWkpF
	s5Cr1Ykr48XF47Zrs5GayruryrWrs29a1jkay3W34UZF48XF95XF4IgF4avF1fXrWqyF13
	Aa1Y9rZ8W3yUXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0fb15UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Collect SDT probe BTF IDs from BTF decl tags matching name pattern
"bpf_sdt:<name>:<nargs>". The IDs are ultimately stored in each probe
entry of the SDT map.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/bpf_insn_array.c    |  1 +
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/libbpf.c         | 55 ++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6a03e3f0506e..773a7def0fbd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7739,6 +7739,7 @@ struct bpf_insn_array_value {
 	__u32 orig_off;
 	__u32 xlated_off;
 	__u32 jitted_off;
+	__u32 btf_id;		/* BTF FUNC_PROTO type ID (0 if none) */
 	__u8  nargs;		/* argument count (0..5) */
 	__u8  arg_reg[5];	/* BPF register for each argument */
 	__u8  pad[2];
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index f43777c5cd07..aca8676ab563 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -103,6 +103,7 @@ static long insn_array_update_elem(struct bpf_map *map, void *key, void *value,
 	insn_array->values[index].orig_off = val.orig_off;
 
 	if (insn_array->subtype == BPF_INSN_ARRAY_SUBTYPE_SDT) {
+		insn_array->values[index].btf_id = val.btf_id;
 		insn_array->values[index].nargs = val.nargs;
 		memcpy(insn_array->values[index].arg_reg, val.arg_reg, sizeof(val.arg_reg));
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6a03e3f0506e..773a7def0fbd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7739,6 +7739,7 @@ struct bpf_insn_array_value {
 	__u32 orig_off;
 	__u32 xlated_off;
 	__u32 jitted_off;
+	__u32 btf_id;		/* BTF FUNC_PROTO type ID (0 if none) */
 	__u8  nargs;		/* argument count (0..5) */
 	__u8  arg_reg[5];	/* BPF register for each argument */
 	__u8  pad[2];
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3f8b12a1eb8b..badac128e8ad 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -715,6 +715,7 @@ struct sdt_entry {
 	__u64 insn_idx;  /* insn index of probe site within its ELF section */
 	__u8 nargs;      /* how many arguments */
 	__u8 arg_reg[5]; /* which register the argument locates in */
+	__u32 btf_id;    /* BTF FUNC_PROTO type ID from decl tag */
 };
 
 struct bpf_object {
@@ -6692,6 +6693,57 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
 	return err;
 }
 
+static void sdt_collect_btf_ids(struct bpf_object *obj)
+{
+	int n = btf__type_cnt(obj->btf);
+	const struct btf_type *t;
+	int i;
+
+	for (i = 1; i < n; i++) {
+		const char *tag, *colon;
+		size_t name_len;
+		__u32 func_proto_id;
+		int j;
+
+		t = btf_type_by_id(obj->btf, i);
+		if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx != -1)
+			continue;
+
+		tag = btf__str_by_offset(obj->btf, t->name_off);
+		if (strncmp(tag, "bpf_sdt:", 8) != 0)
+			continue;
+
+		/* tag format: "bpf_sdt:<name>:<nargs>"; <name> has no colons */
+		colon = strchr(tag + 8, ':');
+		if (!colon)
+			continue;
+		name_len = colon - tag - 8;
+
+		/* type chain: DECL_TAG -> VAR -> (CONST) -> PTR -> FUNC_PROTO */
+		t = btf_type_by_id(obj->btf, t->type);
+		if (!btf_is_var(t))
+			continue;
+		t = btf_type_by_id(obj->btf, t->type);
+		if (btf_kind(t) == BTF_KIND_CONST)
+			t = btf_type_by_id(obj->btf, t->type);
+		if (!btf_is_ptr(t))
+			continue;
+		func_proto_id = t->type;
+		t = btf_type_by_id(obj->btf, func_proto_id);
+		if (!btf_is_func_proto(t))
+			continue;
+
+		/* match by name (tag format: "bpf_sdt:<name>:<nargs>") */
+		for (j = 0; j < obj->sdt_entry_cnt; j++) {
+			struct sdt_entry *e = &obj->sdt_entries[j];
+
+			if (!e->btf_id && strlen(e->name) == name_len &&
+			    strncmp(tag + 8, e->name, name_len) == 0)
+				e->btf_id = func_proto_id;
+		}
+	}
+}
+
 static int bpf_object__resolve_sdt_progs(struct bpf_object *obj)
 {
 	int i, j;
@@ -6749,6 +6801,8 @@ static int bpf_object__create_sdt_maps(struct bpf_object *obj)
 	if (err)
 		return err;
 
+	sdt_collect_btf_ids(obj);
+
 	prog_sdt = calloc(obj->nr_programs, sizeof(*prog_sdt));
 	if (!prog_sdt)
 		return -ENOMEM;
@@ -6785,6 +6839,7 @@ static int bpf_object__create_sdt_maps(struct bpf_object *obj)
 		key = prog_sdt[e->prog_idx].next_key++;
 
 		memset(&val, 0, sizeof(val));
+		val.btf_id = e->btf_id;
 		val.nargs = e->nargs;
 		val.orig_off = e->insn_idx - prog->sec_insn_off;
 		memcpy(val.arg_reg, e->arg_reg, sizeof(val.arg_reg));
-- 
2.47.3

