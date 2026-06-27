Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A63B38A9;
	Sat, 27 Jun 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571983; cv=none; b=ksfKoK9S8dSRPyOFmc47Cwaj6Ksn607ompYsLMc286XvgGALLbKwcpmUTYqkOpsc3jnrB4vJzvP02oac3G0zWlp0yp/41jRjoXYeFoYHkI92b1Ox3g6ftYLDEKU7hub2+xKfvdwVTxXQOem/5AouhhZl2GT21G12IMsi8coUCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571983; c=relaxed/simple;
	bh=gxYqQndsEeBWo3cmQebL49In3lLWpanpHT7DzKXRYgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNThcF93I1OVPHLq5hAEXTBU2TAv5mAVWAn5r92l49BTlFQIB+txfE7nrQhqFBvksBSmuwZEW207ESJ0HY+BkahT5dzNcweUKMMn4vXgN02C8Px6zm3oaiLNjHzdqu53J3dqvDtmjTKTcgmpRzXwPcWRgKp4mVV+QpO87epNHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB33dpPzKHMMV;
	Sat, 27 Jun 2026 22:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D1D484058C;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S5;
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
Subject: [RFC PATCH bpf-next 03/12] libbpf: Add bpf_sdt_notes section parser
Date: Sat, 27 Jun 2026 22:51:37 +0000
Message-ID: <5834001015dba4c202cbd141c4c8723e4983b196.1782571533.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S5
X-Coremail-Antispam: 1UD129KBjvJXoW3tw4UXrW8WFy7CryftF4kXrb_yoWDAF1DpF
	W3W34jkrW8Jr4fGrs3Jw48Ca1a9rs7WF47CFW5G343Ar1Fga95t3W8tryFyF98Aw4UuF13
	Jayq9FZ8WryDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
	A2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU03CztUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Parse bpf_sdt_notes section to get probe call site index in the bpf
prog, and argument registers for each probe.

Layout of SDT entry:
      0: insn_off         // 64 bits of the NOP instruction offset
      8: r1 = %[arg0_reg]  //  bpf move instruction for arg0
     16: r2 = %[arg1_reg]  //  bpf move instruction for arg1
    ...
  8 * N: rN = %[argN_reg]  //  bpf move instruction for argN

N + 1 is the argument number, up to 5.

The argument number is calculated by walking the ELF symbol table
for ___sdt_jt_* symbols that mark each probe entry boundary in the
bpf_sdt_notes section: (next_off - off - 8) / sizeof(struct bpf_insn),
where off is the current entry offset, next_off is the next entry
offset.

The owning program for each probe is identified by walking the relocation
entries for each probe. Each relocation entry records the section index
of the program that contains the probe.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/libbpf.c | 290 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 290 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7162146280a8..327c9d412fe8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -693,6 +693,7 @@ struct elf_state {
 	bool has_st_ops;
 	int arena_data_shndx;
 	int jumptables_data_shndx;
+	int sdt_notes_shndx;
 };
 
 struct usdt_manager;
@@ -703,6 +704,15 @@ enum bpf_object_state {
 	OBJ_LOADED,
 };
 
+struct sdt_entry {
+	char *name;      /* probe name */
+	__u16 prog_idx;  /* resolved in bpf_object__resolve_sdt_progs */
+	__u16 sec_idx;   /* ELF section index of the probe site (from reloc) */
+	__u64 insn_idx;  /* insn index of probe site within its ELF section */
+	__u8 nargs;      /* how many arguments */
+	__u8 arg_reg[5]; /* which register the argument locates in */
+};
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -768,6 +778,13 @@ struct bpf_object {
 	void *jumptables_data;
 	size_t jumptables_data_sz;
 
+	void *sdt_notes_data;
+	size_t sdt_notes_data_sz;
+
+	struct sdt_entry *sdt_entries;
+	size_t sdt_entry_cnt;
+	size_t sdt_entry_cap;
+
 	struct {
 		struct bpf_program *prog;
 		unsigned int sym_off;
@@ -3892,6 +3909,254 @@ static int cmp_progs(const void *_a, const void *_b)
 	return a->sec_insn_off < b->sec_insn_off ? -1 : 1;
 }
 
+static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
+						 size_t sec_idx, size_t insn_idx);
+
+struct sdt_sym {
+	const char *name;
+	size_t off; /* offset in the sdt entry section */
+};
+
+static int sdt_sym_cmp(const void *a, const void *b)
+{
+	const struct sdt_sym *sym1 = a, *sym2 = b;
+
+	if (sym1->off == sym2->off)
+		return 0;
+
+	return sym1->off < sym2->off ? -1 : 1;
+}
+
+static Elf_Data *sdt_find_relo(struct bpf_object *obj)
+{
+	GElf_Shdr shdr;
+	Elf_Scn *scn = NULL;
+
+	while ((scn = elf_nextscn(obj->efile.elf, scn)) != NULL) {
+		if (!gelf_getshdr(scn, &shdr) || shdr.sh_type != SHT_REL)
+			continue;
+
+		if (shdr.sh_info == obj->efile.sdt_notes_shndx)
+			return elf_getdata(scn, NULL);
+	}
+
+	return NULL;
+}
+
+static int sdt_collect_syms(struct bpf_object *obj, struct sdt_sym **sdt_syms)
+{
+	int i, err, cnt = 0;
+	size_t nr_syms;
+	size_t sym_cap = 0;
+	const char *name;
+	Elf64_Sym *sym, *syms;
+	struct sdt_sym *ssyms = NULL;
+
+	syms = obj->efile.symbols->d_buf;
+	nr_syms = obj->efile.symbols->d_size / sizeof(Elf64_Sym);
+
+	for (i = 0; i < nr_syms; i++) {
+		sym = &syms[i];
+		if (sym->st_shndx != obj->efile.sdt_notes_shndx)
+			continue;
+
+		if (ELF64_ST_TYPE(sym->st_info) != STT_NOTYPE)
+			continue;
+
+		name = elf_sym_str(obj, sym->st_name);
+		if (!name || strncmp(name, "___sdt_jt_", 10))
+			continue;
+
+		err = libbpf_ensure_mem((void **)&ssyms, &sym_cap, sizeof(*ssyms), cnt + 1);
+		if (err) {
+			free(ssyms);
+			return -ENOMEM;
+		}
+
+		ssyms[cnt].name = name;
+		ssyms[cnt].off = sym->st_value;
+		cnt++;
+	}
+
+	if (cnt)
+		qsort(ssyms, cnt, sizeof(*ssyms), sdt_sym_cmp);
+
+	*sdt_syms = ssyms;
+
+	return cnt;
+}
+
+/*
+ * Layout of SDT entry:
+ *
+ *   off + 0:  64 bits of the NOP instruction offset
+ *   off + 8:  r1 = %[arg0_reg]  //  bpf move instruction for arg0
+ *   off + 16: r2 = %[arg1_reg]  //  bpf move instruction for arg1
+ *       ...
+ *   off + 8 * N: rN = %[argN_reg]  //  bpf move instruction for argN
+ *
+ *   next_off + 0: // start of the next entry
+ *
+ *   so argument number N = (next_entry_off - off - 8) / sizeof(bpf_insn).
+ */
+static int sdt_calc_nargs(struct sdt_sym *syms, int sym_idx, size_t sym_cnt, size_t last_off)
+{
+	size_t off = syms[sym_idx].off;
+	size_t next_off = (sym_idx + 1 < sym_cnt) ? syms[sym_idx + 1].off : last_off;
+
+	if (next_off > last_off)
+		return -EINVAL;
+
+	if (off + 8 > next_off)
+		return -EINVAL;
+
+	if ((next_off - off - 8) % sizeof(struct bpf_insn))
+		return -EINVAL;
+
+	if ((next_off - off - 8) / sizeof(struct bpf_insn) > 5)
+		return -EINVAL;
+
+	return (next_off - off - 8) / sizeof(struct bpf_insn);
+}
+
+/*
+ * Look up the ELF section index of the code section containing the probe
+ * site, via the R_BPF_64_ABS64 relocation on this entry's .quad.  The
+ * target symbol's st_shndx is the code section; this is stored in the
+ * sdt_entry and used later (after subprogram linking) to resolve prog_idx.
+ *
+ * Returns the section index on success, -1 on failure.
+ */
+static int sdt_find_sec_idx(struct bpf_object *obj, Elf_Data *sdt_relo,
+			    size_t sdt_entry_off)
+{
+	int i;
+	Elf64_Sym *tgt;
+	Elf64_Rel *rel = sdt_relo->d_buf;
+	Elf64_Sym *elf_syms = obj->efile.symbols->d_buf;
+
+	for (i = 0; i < sdt_relo->d_size / sizeof(Elf64_Rel); i++, rel++) {
+		if (rel->r_offset != sdt_entry_off)
+			continue;
+		if (ELF64_R_TYPE(rel->r_info) != R_BPF_64_ABS64)
+			continue;
+
+		tgt = &elf_syms[ELF64_R_SYM(rel->r_info)];
+		return tgt->st_shndx;
+	}
+
+	return -1;
+}
+
+static int sdt_parse_arg(const void *data, int nargs, struct sdt_entry *e)
+{
+	int i;
+	const struct bpf_insn *insn;
+
+	insn = (const struct bpf_insn *)data;
+	for (i = 0; i < nargs; i++, insn++) {
+		if (insn->code != (BPF_ALU64 | BPF_MOV | BPF_X))
+			return -EINVAL;
+		e->arg_reg[i] = insn->src_reg;
+	}
+
+	return 0;
+}
+
+
+/*
+ * Parse .bpf_sdt_notes into per-probe SDT entries.
+ *
+ * Each entry starts at a ___sdt_jt_<name> label and contains .quad nop_off
+ * (8 bytes, with R_BPF_64_ABS64 reloc) followed by one 8-byte BPF_MOV
+ * instruction per argument whose src_reg field encodes the register.
+ *
+ * nargs is derived from the gap between consecutive labels: the assembler
+ * lays entries out sequentially, so nargs = (next_off - off - 8) / 8.
+ */
+static int bpf_object__collect_sdt_notes(struct bpf_object *obj)
+{
+	int i, sym_cnt, err = 0;
+	struct sdt_sym *sdt_syms = NULL;
+	Elf_Data *sdt_relo = NULL;
+	const void *data = obj->sdt_notes_data;
+
+	if (!obj->sdt_notes_data || !obj->sdt_notes_data_sz)
+		return 0;
+
+	sdt_relo = sdt_find_relo(obj);
+	if (!sdt_relo)
+		return -EINVAL;
+
+	sym_cnt = sdt_collect_syms(obj, &sdt_syms);
+	if (sym_cnt < 0)
+		return sym_cnt;
+
+	for (i = 0; i < sym_cnt; i++) {
+		__u64 nop_idx;
+		int nargs, sec_idx;
+		struct sdt_entry *e;
+		size_t off = sdt_syms[i].off;
+
+		nargs = sdt_calc_nargs(sdt_syms, i, sym_cnt, obj->sdt_notes_data_sz);
+		if (nargs < 0) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		memcpy(&nop_idx, data + off, sizeof(__u64));
+		nop_idx = nop_idx / sizeof(struct bpf_insn);
+
+		/*
+		 * Record the ELF section index of the code section containing
+		 * the probe site.  prog_idx is resolved later in
+		 * bpf_object__resolve_sdt_progs(), after static subprograms
+		 * in .text have been absorbed into their calling main program;
+		 * resolving here would return the subprogram's own entry, not
+		 * the main program that ends up owning the probe site.
+		 */
+		sec_idx = sdt_find_sec_idx(obj, sdt_relo, off);
+		if (sec_idx < 0) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		/* Read arg_reg[] from cold instructions */
+		err = libbpf_ensure_mem((void **)&obj->sdt_entries, &obj->sdt_entry_cap,
+					sizeof(*obj->sdt_entries), i + 1);
+		if (err) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		e = &obj->sdt_entries[i];
+		err = sdt_parse_arg(data + off + 8, nargs, e);
+		if (err < 0)
+			goto out;
+
+		e->name = strdup(sdt_syms[i].name + 10); /* skip "___sdt_jt_" */
+		if (!e->name) {
+			err = -ENOMEM;
+			goto out;
+		}
+		e->sec_idx = sec_idx;
+		e->insn_idx = nop_idx;
+		e->nargs = nargs;
+		obj->sdt_entry_cnt++;
+	}
+
+out:
+	if (err) {
+		for (i = 0; i < obj->sdt_entry_cnt; i++)
+			free(obj->sdt_entries[i].name);
+		zfree(&obj->sdt_entries);
+		obj->sdt_entry_cnt = obj->sdt_entry_cap = 0;
+	}
+
+	free(sdt_syms);
+	return err;
+}
+
 static int bpf_object__elf_collect(struct bpf_object *obj)
 {
 	struct elf_sec_desc *sec_desc;
@@ -4034,6 +4299,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				memcpy(obj->jumptables_data, data->d_buf, data->d_size);
 				obj->jumptables_data_sz = data->d_size;
 				obj->efile.jumptables_data_shndx = idx;
+			} else if (strcmp(name, SDT_NOTES_SEC) == 0) {
+				obj->sdt_notes_data = malloc(data->d_size);
+				if (!obj->sdt_notes_data)
+					return -ENOMEM;
+				memcpy(obj->sdt_notes_data, data->d_buf, data->d_size);
+				obj->sdt_notes_data_sz = data->d_size;
+				obj->efile.sdt_notes_shndx = idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -4087,6 +4359,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 	if (obj->nr_programs)
 		qsort(obj->programs, obj->nr_programs, sizeof(*obj->programs), cmp_progs);
 
+	err = bpf_object__collect_sdt_notes(obj);
+	if (err) {
+		zfree(&obj->sdt_notes_data);
+		obj->sdt_notes_data_sz = 0;
+		return err;
+	}
+
 	return bpf_object__init_btf(obj, btf_data, btf_ext_data);
 }
 
@@ -9629,6 +9908,17 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->jumptables_data);
 	obj->jumptables_data_sz = 0;
 
+	zfree(&obj->sdt_notes_data);
+	obj->sdt_notes_data_sz = 0;
+
+	if (obj->sdt_entries) {
+		for (i = 0; i < obj->sdt_entry_cnt; i++)
+			free(obj->sdt_entries[i].name);
+		zfree(&obj->sdt_entries);
+		obj->sdt_entry_cnt = 0;
+		obj->sdt_entry_cap = 0;
+	}
+
 	for (i = 0; i < obj->jumptable_map_cnt; i++)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
-- 
2.47.3

