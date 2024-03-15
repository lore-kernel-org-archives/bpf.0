Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D1052F85
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532232; cv=none; b=brO4JAVpVtHIMtpSwXg1fGsU9IFuECDzalrb0+NMwa9pkhtIYxbTBaenoDtKSwe0N8X0ba2K3QGhHedbVQLntF9z+8P4SIs+DJc/gmynPPgwQnifNB6U8P4J5B7nHwIDxOue1/6ZWE9iLYQo+AXFrBAcep7yykXKKmeib/oWKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532232; c=relaxed/simple;
	bh=Herlw+5vQoOpsVPm6iqgfqltpf24zeZ8ItLmUQ/f1Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJhNJytoVLxC/mJiXiiP1mdBisJvdGmZKwXlkhk35euhbhDn0uNZGl7AWtUydgsuBNbHJ10DjOROXNLAxPxiF6bUxeKYBICIyCgYLfjdLExZqJQn+yQ0JhMFSvfnuU17mjesk/FAxKLig45oNyYfRv6OrcY4b9cwNnrP+D+nUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=KotD26ps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2q5x+4m; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="KotD26ps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2q5x+4m"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 5E0705C01B9;
	Fri, 15 Mar 2024 15:50:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 15 Mar 2024 15:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1710532228; x=
	1710618628; bh=HLuLkfVPuobRJWfEQNGlwVdVTqSB2z1tMsKetO2p69A=; b=K
	otD26psdXkOqStdRUpUMyQrOeADLWepAZtEpTd2nDqLw613msLxwCJtiOPkxDTCv
	iu0JD4XlgD45+iLF2IWJ0ZoFwWTZoGnsPQ2M49QiEFTgEsoiya5Gls+m/m5Ah8Ta
	dz9kH0oN+8jmzdkiacBgHs7MkSfNLUqx/XlBuzYInqxX/GYxL/wPzG/uEk0bSCkk
	WPSwcGdzb20XvM7oGysPVhpOOY3BFsBcd1K9QIxv0AB7RBfItSs76HOR1uZmrEEf
	VD5Q3GRU89C7DFm5/nKIm3eYxBN+GsDXF/CWYNa6IKTF+hcqBcU7zmLSjXTZgRC5
	tmSpE475g5xwqp2Viq9Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710532228; x=
	1710618628; bh=HLuLkfVPuobRJWfEQNGlwVdVTqSB2z1tMsKetO2p69A=; b=l
	2q5x+4mmxUGE4HR271NrcElDoSsU4d4tfNAof2zgcUYNOCdSzixmmS8D6oFfcjJA
	Wbcng+mjUQrU32nP6i1yb8AHaPZaDu9RASGIqePy3wGu9sV/3h3z55WSSwymsxhJ
	XNiVFMTw5Wphu9mojabvMuYf8pWME/+Mfv+B//vYUoNUzgcMwQxsbaUY/6fq1+4w
	koguRWEnfxI2mocgIS6tedGBEhFdhsJzXYV9WpmHF4of5erGXxJIGtzpufHns7SZ
	BOt68rwGTz64WyS8qSbKn5WWK52E5xEOstnRkh5hPcfRCXbsXKSx6c8XACfiuoHp
	QfQbOsTg9xmEIXmk1STog==
X-ME-Sender: <xms:g6b0ZUu9P7HEiliHBjjkUNsQ3hRnUuXOkoLwfI4NGi2USNFbaUQFHQ>
    <xme:g6b0ZRcXT4-hPIzh3SUF_8ZGAUXOwr1HguF62C48-LOpt2EGbkvwByYR85a8DUgGt
    MfA5Ah_25Dfe_MFgA>
X-ME-Received: <xmr:g6b0ZfzW_0Vs-iiKDQDqsdC2Da41-ERa4A67auhBHjFn6mOLdfqZVc1-LkG06gyVqjM_4rirdKzbUMboDVx-9Yr0M8DWbHEHq7YP-nVMoJQzbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:g6b0ZXNdSKbUGtBs5FMJX2h5JeB8B7vMMDvPX3boSXqR8UxdNTWCug>
    <xmx:g6b0ZU_gDO3Ur16TO6Lus-8AJ8xab_-og__dlvxxBK3jA8Yp9UwsFw>
    <xmx:g6b0ZfUXvUtGLx5zanXvrGpbF14_TNDIPNN0cSrJ8rS3sqLNJ89-Sw>
    <xmx:g6b0ZdfigiETShGQPC0Ui_OPUIYNmk7ZeAuSU-AJoKix81x4nekQhQ>
    <xmx:hKb0ZYR2guf520Z4OL3HASX1nZ71qDZVubgetIpxF7x5pRrzDCRtnQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Mar 2024 15:50:27 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v5 2/2] pahole: Inject kfunc decl tags into BTF
Date: Fri, 15 Mar 2024 13:48:52 -0600
Message-ID: <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710532093.git.dxu@dxuuu.xyz>
References: <cover.1710532093.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit teaches pahole to parse symbols in .BTF_ids section in
vmlinux and discover exported kfuncs. Pahole then takes the list of
kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.

Example of encoding:

        $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
        121

        $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
        [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
        [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1

This enables downstream users and tools to dynamically discover which
kfuncs are available on a system by parsing vmlinux or module BTF, both
available in /sys/kernel/btf.

This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btf_encoder.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 368 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 850e36f..31848e2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -34,6 +34,21 @@
 #include <pthread.h>
 
 #define BTF_ENCODER_MAX_PROTO	512
+#define BTF_IDS_SECTION		".BTF_ids"
+#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
+#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
+#define BTF_SET8_KFUNCS		(1 << 0)
+#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
+
+/* Adapted from include/linux/btf_ids.h */
+struct btf_id_set8 {
+        uint32_t cnt;
+        uint32_t flags;
+        struct {
+                uint32_t id;
+                uint32_t flags;
+        } pairs[];
+};
 
 /* state used to do later encoding of saved functions */
 struct btf_encoder_state {
@@ -75,6 +90,7 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
+			  skip_encoding_decl_tag,
 			  tag_kfuncs,
 			  is_rel;
 	uint32_t	  array_index_id;
@@ -94,6 +110,17 @@ struct btf_encoder {
 	} functions;
 };
 
+struct btf_func {
+	const char *name;
+	int	    type_id;
+};
+
+/* Half open interval representing range of addresses containing kfuncs */
+struct btf_kfunc_set_range {
+	size_t start;
+	size_t end;
+};
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -1363,8 +1390,339 @@ out:
 	return err;
 }
 
+/* Returns if `sym` points to a kfunc set */
+static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
+{
+	void *ptr = idlist->d_buf;
+	struct btf_id_set8 *set;
+	bool is_set8;
+	int off;
+
+	/* kfuncs are only found in BTF_SET8's */
+	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
+	if (!is_set8)
+		return false;
+
+	off = sym->st_value - idlist_addr;
+	if (off >= idlist->d_size) {
+		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
+		return false;
+	}
+
+	/* Check the set8 flags to see if it was marked as kfunc */
+	set = ptr + off;
+	return set->flags & BTF_SET8_KFUNCS;
+}
+
+/*
+ * Parse BTF_ID symbol and return the func name.
+ *
+ * Returns:
+ *	Caller-owned string containing func name if successful.
+ *	NULL if !func or on error.
+ */
+static char *get_func_name(const char *sym)
+{
+	char *func, *end;
+
+	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
+		return NULL;
+
+	/* Strip prefix */
+	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
+	if (strlen(func) < 2) {
+                free(func);
+                return NULL;
+        }
+
+	/* Strip suffix */
+	end = strrchr(func, '_');
+	if (!end || *(end - 1) != '_') {
+		free(func);
+		return NULL;
+	}
+	*(end - 1) = '\0';
+
+	return func;
+}
+
+static int btf_func_cmp(const void *_a, const void *_b)
+{
+	const struct btf_func *a = _a;
+	const struct btf_func *b = _b;
+
+	return strcmp(a->name, b->name);
+}
+
+/*
+ * Collects all functions described in BTF.
+ * Returns non-zero on error.
+ */
+static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
+{
+	struct btf *btf = encoder->btf;
+	int nr_types, type_id;
+	int err = -1;
+
+	/* First collect all the func entries into an array */
+	nr_types = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr_types; type_id++) {
+		const struct btf_type *type;
+		struct btf_func func = {};
+		const char *name;
+
+		type = btf__type_by_id(btf, type_id);
+		if (!type) {
+			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
+				__func__, type_id);
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (!btf_is_func(type))
+			continue;
+
+		name = btf__name_by_offset(btf, type->name_off);
+		if (!name) {
+			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
+				__func__, type_id);
+			err = -EINVAL;
+			goto out;
+		}
+
+		func.name = name;
+		func.type_id = type_id;
+		err = gobuffer__add(funcs, &func, sizeof(func));
+		if (err < 0)
+			goto out;
+	}
+
+	/* Now that we've collected funcs, sort them by name */
+	qsort((void *)gobuffer__entries(funcs), gobuffer__nr_entries(funcs),
+	      sizeof(struct btf_func), btf_func_cmp);
+
+	err = 0;
+out:
+	return err;
+}
+
+static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
+{
+	struct btf_func key = { .name = kfunc };
+	struct btf *btf = encoder->btf;
+	struct btf_func *target;
+	const void *base;
+	unsigned int cnt;
+	int err = -1;
+
+	base = gobuffer__entries(funcs);
+	cnt = gobuffer__nr_entries(funcs);
+	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
+	if (!target) {
+		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
+		goto out;
+	}
+
+	/* Note we are unconditionally adding the btf_decl_tag even
+	 * though vmlinux may already contain btf_decl_tags for kfuncs.
+	 * We are ok to do this b/c we will later btf__dedup() to remove
+	 * any duplicates.
+	 */
+	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
+	if (err < 0) {
+		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
+			__func__, kfunc, err);
+		goto out;
+	}
+
+	err = 0;
+out:
+	return err;
+}
+
+static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
+{
+	const char *filename = encoder->filename;
+	struct gobuffer btf_kfunc_ranges = {};
+	struct gobuffer btf_funcs = {};
+	Elf_Data *symbols = NULL;
+	Elf_Data *idlist = NULL;
+	Elf_Scn *symscn = NULL;
+	int symbols_shndx = -1;
+	size_t idlist_addr = 0;
+	int fd = -1, err = -1;
+	int idlist_shndx = -1;
+	size_t strtabidx = 0;
+	Elf_Scn *scn = NULL;
+	Elf *elf = NULL;
+	GElf_Shdr shdr;
+	size_t strndx;
+	char *secname;
+	int nr_syms;
+	int i = 0;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open %s\n", filename);
+		goto out;
+	}
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		elf_error("Cannot set libelf version");
+		goto out;
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (elf == NULL) {
+		elf_error("Cannot update ELF file");
+		goto out;
+	}
+
+	/* Locate symbol table and .BTF_ids sections */
+	if (elf_getshdrstrndx(elf, &strndx) < 0)
+		goto out;
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		Elf_Data *data;
+
+		i++;
+		if (!gelf_getshdr(scn, &shdr)) {
+			elf_error("Failed to get ELF section(%d) hdr", i);
+			goto out;
+		}
+
+		secname = elf_strptr(elf, strndx, shdr.sh_name);
+		if (!secname) {
+			elf_error("Failed to get ELF section(%d) hdr name", i);
+			goto out;
+		}
+
+		data = elf_getdata(scn, 0);
+		if (!data) {
+			elf_error("Failed to get ELF section(%d) data", i);
+			goto out;
+		}
+
+		if (shdr.sh_type == SHT_SYMTAB) {
+			symbols_shndx = i;
+			symscn = scn;
+			symbols = data;
+			strtabidx = shdr.sh_link;
+		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
+			idlist_shndx = i;
+			idlist_addr = shdr.sh_addr;
+			idlist = data;
+		}
+	}
+
+	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
+	if (symbols_shndx == -1 || idlist_shndx == -1) {
+		err = 0;
+		goto out;
+	}
+
+	if (!gelf_getshdr(symscn, &shdr)) {
+		elf_error("Failed to get ELF symbol table header");
+		goto out;
+	}
+	nr_syms = shdr.sh_size / shdr.sh_entsize;
+
+	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
+	if (err) {
+		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
+		goto out;
+	}
+
+	/* First collect all kfunc set ranges.
+	 *
+	 * Note we choose not to sort these ranges and accept a linear
+	 * search when doing lookups. Reasoning is that the number of
+	 * sets is ~O(100) and not worth the additional code to optimize.
+	 */
+	for (i = 0; i < nr_syms; i++) {
+		struct btf_kfunc_set_range range = {};
+		const char *name;
+		GElf_Sym sym;
+
+		if (!gelf_getsym(symbols, i, &sym)) {
+			elf_error("Failed to get ELF symbol(%d)", i);
+			goto out;
+		}
+
+		if (sym.st_shndx != idlist_shndx)
+			continue;
+
+		name = elf_strptr(elf, strtabidx, sym.st_name);
+		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
+			continue;
+
+		range.start = sym.st_value;
+		range.end = sym.st_value + sym.st_size;
+		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
+	}
+
+	/* Now inject BTF with kfunc decl tag for detected kfuncs */
+	for (i = 0; i < nr_syms; i++) {
+		const struct btf_kfunc_set_range *ranges;
+		unsigned int ranges_cnt;
+		char *func, *name;
+		GElf_Sym sym;
+		bool found;
+		int err;
+		int j;
+
+		if (!gelf_getsym(symbols, i, &sym)) {
+			elf_error("Failed to get ELF symbol(%d)", i);
+			goto out;
+		}
+
+		if (sym.st_shndx != idlist_shndx)
+			continue;
+
+		name = elf_strptr(elf, strtabidx, sym.st_name);
+		func = get_func_name(name);
+		if (!func)
+			continue;
+
+		/* Check if function belongs to a kfunc set */
+		ranges = gobuffer__entries(&btf_kfunc_ranges);
+		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
+		found = false;
+		for (j = 0; j < ranges_cnt; j++) {
+			size_t addr = sym.st_value;
+
+			if (ranges[j].start <= addr && addr < ranges[j].end) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			free(func);
+			continue;
+		}
+
+		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
+		if (err) {
+			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
+			free(func);
+			goto out;
+		}
+		free(func);
+	}
+
+	err = 0;
+out:
+	__gobuffer__delete(&btf_funcs);
+	__gobuffer__delete(&btf_kfunc_ranges);
+	if (elf)
+		elf_end(elf);
+	if (fd != -1)
+		close(fd);
+	return err;
+}
+
 int btf_encoder__encode(struct btf_encoder *encoder)
 {
+	bool should_tag_kfuncs;
 	int err;
 
 	/* for single-threaded case, saved funcs are added here */
@@ -1377,6 +1735,15 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	if (btf__type_cnt(encoder->btf) == 1)
 		return 0;
 
+	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
+	 * take care to call this before btf_dedup().
+	 */
+	should_tag_kfuncs = encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag;
+	if (should_tag_kfuncs && btf_encoder__tag_kfuncs(encoder)) {
+		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
+		return -1;
+	}
+
 	if (btf__dedup(encoder->btf, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
@@ -1660,6 +2027,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
-- 
2.44.0

