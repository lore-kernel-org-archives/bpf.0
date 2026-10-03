Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4A38887E;
	Sat,  3 Oct 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056656; cv=none; b=DSZD3doDxihyG6r5kIVVEkRRUqdk8IKGCUMbMmlEW8u3CyOPCiVmIU1oE+yBEXc5qARVzNt/KQpd1rU5KSrKFzr2LVsqNlVfFq6iLI86NRJ6e5T0k7Dl6d6j4J6OJqQQ2Img3z29MVQ5ApoK+JZtujrwBHDADWHF12STlIlMyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056656; c=relaxed/simple;
	bh=VCVN7KkNHh/XtxkErkYm5S6PNuRuWpE7JGwGrxDVw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxEJRg07EcGIYURLAbhvsNlFlVZvDzHL/D9UKpojRKpAMUOrgPYr2xo7ynrGzIEonZzTaeraVuWwahJgh4aAXWsUnq5tGbnCOgRmgK42UpDEPsZz/yBztnixx70SRhfeQ8WOs1YZyfkq32omDO9GoMrYrWRUNghjMmithw9FWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qTpSRM/t; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qTpSRM/t"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693IeKNl2626637;
	Sat, 3 Oct 2026 19:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=nwrm2
	Jv8qfU0AIv0sBW6+3/v8R5p9DBtb3BF522794o=; b=qTpSRM/tAUoHJnrIFcyL0
	MYozjUQZ3+SnWdvhQQnVSBNy7LHio373tlhUOrd7PqzekeTZAwJQt4xD5xv6bzCI
	y/Gm+1bZdllkDqsM5PwwJdF1yaAldH14j1FUzZhE8ftCpj2hJUBZPwn5Or49IcRE
	tvzx0Z+GUEHCPXpatOPpAMgwY5uUG8DtW/ZK4cCELqPdWf8AvI3cOyloRMtqTDeq
	wulOAOySIjKZYZvXRVvRM/Ytl1V5QpSXD9QtaYbN47wnaOqBOKVU2oa0Nxza5AdB
	eV7p3pzllhvoVP9YZlbLQH72X6jvBAi6YcYUhke6iCvC9sl+GXV3nBUxcOfobp3d
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rm98enj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693JZ1N8005051;
	Sat, 3 Oct 2026 19:43:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58yyqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:43 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 693JdEMv012617;
	Sat, 3 Oct 2026 19:43:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-182.vpn.oracle.com [10.154.83.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h2r58yynt-3;
	Sat, 03 Oct 2026 19:43:42 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 2/7] resolve_btfids: Populate BTF link section
Date: Sat,  3 Oct 2026 20:43:18 +0100
Message-ID: <20261003194323.817885-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261003194323.817885-1-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX0KlSbVqxpi2Y
 kz5Dv5x7Al59I7reEOdnvBT2umMLQ3HVRZLV1PeqrAxW2/z2mzcQpgaVzxFWoKCPJAo3NhIFyZY
 Pd2JWwyrLEBloB+bQO2QHYTEIb7Bqm1/T+GJfnGm8DtW1u2/X4km4NJOSUPdJtI/njSE7SatnEe
 sAbtqir/w3zcjzznz/WNo0X3x+UhI3ytBqRXKQtF0XzmWrE5uD++BXkWNikqbwF3IPF1BKRJ090
 oyOCMVgZuYemULEOBA6Et3zNXyxxN9kt02oXC2LNfbdXO/LCgS7XQkTILcGIJ2DIgE2dXsO5z7f
 u/KqD+RV0XvFug2nB3SA3ClMxRH98wW3SPY3kjFjdRIGIVAzB6QmKP+lUHy7K6batOrSEHztpF5
 5r7rzSTfVDeWDMMvelYccaRJH+ggmz1rgaHVWfaaUgsWuj73wYRzbno7MDLkS/3ENlfDQzq20h6
 VoZQ+r17ULZU+vYC1hA==
X-Authority-Analysis: v=2.4 cv=QMD91QLL c=1 sm=1 tr=0 ts=6ac15af0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=dAkLVYRIcl1iJgNOQtYA:9
X-Proofpoint-ORIG-GUID: od35T7DpOVrgCnpmiEzcGso42A64lOnv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfXzr3YJICs4LWz
 vuRtgN3bw83obmNgZ7LJbTcEy6iBd+F9ApC9ObJJzBKdPl8igTUPoj7Jauj9nXT0l35JGINi5Q4
 Drh2HVUk2p0LQ9euwj/IiDXpGZZb/rwtKFogP0iA2mC05TcW7hUS
X-Proofpoint-GUID: od35T7DpOVrgCnpmiEzcGso42A64lOnv

Allow the final BTF patch pass to populate one or more BTF link
records.  A link identifies the BTF section to be delivered, its
carrier module, and the raw finalized BTF payload:

    --btf_link <section>:<module>:<raw-btf-file>

Use the raw file size and SHA-256 digest to populate the corresponding
<section>.link record.  This avoids reparsing BTF during final ELF
patching and supports both inline BTF and a future module-delivered
vmlinux BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT 5.6)
---
 tools/bpf/resolve_btfids/btf_colors.c |   6 +
 tools/bpf/resolve_btfids/btf_colors.h |   4 +
 tools/bpf/resolve_btfids/main.c       | 192 +++++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/btf_colors.c b/tools/bpf/resolve_btfids/btf_colors.c
index 347ae85d6bc7..5d307d70e7f2 100644
--- a/tools/bpf/resolve_btfids/btf_colors.c
+++ b/tools/bpf/resolve_btfids/btf_colors.c
@@ -7,6 +7,12 @@
  * which can't be included in main.c because of the u32 poison and pr_warn macro conflicts.
  */
 
+void btf_sha256(const void *data, size_t len,
+		__u8 out[BTF_SHA256_DIGEST_LENGTH])
+{
+	libbpf_sha256(data, len, out);
+}
+
 /*
  * Marks `root_id` and local types reachable from it with `color`.
  * `colors` is indexed by source ID; worklist has room for every local type.
diff --git a/tools/bpf/resolve_btfids/btf_colors.h b/tools/bpf/resolve_btfids/btf_colors.h
index 9cea757cb356..56a85a242d6b 100644
--- a/tools/bpf/resolve_btfids/btf_colors.h
+++ b/tools/bpf/resolve_btfids/btf_colors.h
@@ -11,6 +11,10 @@ enum btf_color {
 	BTF_COLOR_SHARED = BTF_COLOR_MAIN | BTF_COLOR_LOC,
 };
 
+#define BTF_SHA256_DIGEST_LENGTH	32
+
+void btf_sha256(const void *data, size_t len,
+		__u8 out[BTF_SHA256_DIGEST_LENGTH]);
 void btf_mark_reachable(struct btf *btf, __u32 root, enum btf_color color,
 			__u8 *colors, __u32 *worklist);
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index dcd289d16faf..84cd9691f177 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -93,6 +93,7 @@
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
+#define BTF_LINK_MODULE_NAME_MAX	64
 #define BTF_ID_PREFIX	"__BTF_ID__"
 
 #define BTF_STRUCT	"struct"
@@ -157,6 +158,7 @@ struct object {
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
 		int		 encoding;
+		int		 elf_class;
 		const char	**func_symbols;
 		u32		 func_symbols_cnt;
 		u32		 func_symbols_cap;
@@ -179,6 +181,19 @@ struct object {
 	u32 addr_syms_cap;
 };
 
+struct btf_link {
+	char *value;
+	char *section;
+	char *module;
+	char *btf_path;
+};
+
+struct btf_links {
+	struct btf_link *links;
+	u32 cnt;
+	u32 cap;
+};
+
 #define DECL_TAG_FASTCALL "bpf_fastcall"
 #define DECL_TAG_KFUNC "bpf_kfunc"
 
@@ -266,6 +281,49 @@ static int __ensure_mem(void **data, u32 *cap, u32 cnt, size_t elem_sz)
 #define ensure_mem(arr_ptr, cap_ptr, cnt) \
 	__ensure_mem((void **)(arr_ptr), (cap_ptr), (cnt), sizeof(**(arr_ptr)))
 
+static int parse_btf_link(const struct option *opt, const char *arg, int unset)
+{
+	struct btf_links *links = opt->value;
+	struct btf_link *link;
+	char *separator;
+
+	if (unset)
+		return -EINVAL;
+	if (__ensure_mem((void **)&links->links, &links->cap, links->cnt + 1,
+			 sizeof(*links->links)))
+		return -ENOMEM;
+	link = &links->links[links->cnt];
+	memset(link, 0, sizeof(*link));
+	link->value = strdup(arg);
+	if (!link->value)
+		return -ENOMEM;
+	link->section = link->value;
+	separator = strchr(link->section, ':');
+	if (!separator || separator == link->section)
+		goto err_value;
+	*separator++ = '\0';
+	link->module = separator;
+	separator = strchr(link->module, ':');
+	if (!separator || separator == link->module || !separator[1])
+		goto err_value;
+	*separator++ = '\0';
+	link->btf_path = separator;
+	links->cnt++;
+	return 0;
+err_value:
+	free(link->value);
+	return -EINVAL;
+}
+
+static void free_btf_links(struct btf_links *links)
+{
+	u32 i;
+
+	for (i = 0; i < links->cnt; i++)
+		free(links->links[i].value);
+	free(links->links);
+}
+
 static bool is_btf_id(const char *name)
 {
 	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
@@ -487,6 +545,7 @@ static int elf_collect(struct object *obj)
 		return -1;
 	}
 	obj->efile.encoding = ehdr.e_ident[EI_DATA];
+	obj->efile.elf_class = ehdr.e_ident[EI_CLASS];
 
 	/*
 	 * Scan all the elf sections and look for save data
@@ -1036,6 +1095,110 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
 	return 0;
 }
 
+static int patch_btf_link(struct object *obj, const struct btf_link *link)
+{
+	void *raw_btf_data;
+	Elf_Scn *scn = NULL;
+	Elf_Data *data;
+	GElf_Shdr sh;
+	char section[128];
+	char *name;
+	size_t shdrstrndx, module_name_len;
+	int fd, len, err = -1;
+	struct stat st;
+	FILE *btf_file;
+	u32 raw_btf_size;
+	Elf *elf;
+	u8 *size;
+
+	if (stat(link->btf_path, &st) || !S_ISREG(st.st_mode) ||
+	    st.st_size <= 0 || st.st_size > UINT_MAX)
+		return -EINVAL;
+	raw_btf_size = st.st_size;
+	raw_btf_data = malloc(raw_btf_size);
+	if (!raw_btf_data)
+		return -ENOMEM;
+	btf_file = fopen(link->btf_path, "rb");
+	if (!btf_file)
+		goto out_data;
+	if (fread(raw_btf_data, raw_btf_size, 1, btf_file) != 1)
+		goto out_file;
+	fclose(btf_file);
+	if (obj->efile.elf_class == ELFCLASS32)
+		module_name_len = BTF_LINK_MODULE_NAME_MAX - 4;
+	else if (obj->efile.elf_class == ELFCLASS64)
+		module_name_len = BTF_LINK_MODULE_NAME_MAX - 8;
+	else
+		goto out_data;
+	if (strlen(link->module) >= module_name_len)
+		goto out_data;
+	len = snprintf(section, sizeof(section), "%s.link", link->section);
+	if (len < 0 || len >= sizeof(section))
+		goto out_data;
+
+	fd = open(obj->path, O_RDWR);
+	if (fd < 0)
+		goto out_data;
+	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
+	if (!elf) {
+		err = -EINVAL;
+		goto out_close;
+	}
+	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
+	if (elf_getshdrstrndx(elf, &shdrstrndx))
+		goto out_elf;
+	while ((scn = elf_nextscn(elf, scn))) {
+		if (gelf_getshdr(scn, &sh) != &sh)
+			goto out_elf;
+		name = elf_strptr(elf, shdrstrndx, sh.sh_name);
+		if (name && !strcmp(name, section))
+			break;
+	}
+	if (!scn) {
+		pr_err("FAILED: section %s not found in %s\n", section, obj->path);
+		goto out_elf;
+	}
+	data = elf_getdata(scn, NULL);
+	if (sh.sh_type != SHT_PROGBITS || !data || !data->d_buf ||
+	    data->d_size != module_name_len +
+		BTF_SHA256_DIGEST_LENGTH + sizeof(u32)) {
+		pr_err("FAILED: section %s is not a writable BTF link\n", section);
+		goto out_elf;
+	}
+	memset(data->d_buf, 0, data->d_size);
+	memcpy(data->d_buf, link->module, strlen(link->module) + 1);
+	btf_sha256(raw_btf_data, raw_btf_size,
+		   (u8 *)data->d_buf + module_name_len);
+	size = (u8 *)data->d_buf + module_name_len + BTF_SHA256_DIGEST_LENGTH;
+	if (obj->efile.encoding == ELFDATA2LSB) {
+		size[0] = raw_btf_size;
+		size[1] = raw_btf_size >> 8;
+		size[2] = raw_btf_size >> 16;
+		size[3] = raw_btf_size >> 24;
+	} else if (obj->efile.encoding == ELFDATA2MSB) {
+		size[0] = raw_btf_size >> 24;
+		size[1] = raw_btf_size >> 16;
+		size[2] = raw_btf_size >> 8;
+		size[3] = raw_btf_size;
+	} else {
+		goto out_elf;
+	}
+	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
+	if (elf_update(elf, ELF_C_WRITE) >= 0)
+		err = 0;
+out_elf:
+	elf_end(elf);
+out_close:
+	close(fd);
+	free(raw_btf_data);
+	return err;
+out_file:
+	fclose(btf_file);
+out_data:
+	free(raw_btf_data);
+	return err;
+}
+
 static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf, s32 type_id)
 {
 	const struct btf_type *t = btf__type_by_id(btf, type_id);
@@ -1886,7 +2049,7 @@ static int patch_btfids(const char *btfids_path, const char *elf_path)
 
 static const char * const resolve_btfids_usage[] = {
 	"resolve_btfids [<options>] <ELF object>",
-	"resolve_btfids --patch_btfids <.BTF_ids file> <ELF object>",
+	"resolve_btfids --patch_btfids <.BTF_ids file> [--btf_link <section:module:btf-file>] <ELF object>",
 	NULL
 };
 
@@ -1904,6 +2067,7 @@ int main(int argc, const char **argv)
 		.sets     = RB_ROOT,
 	};
 	const char *btfids_path = NULL;
+	struct btf_links btf_links = {};
 	bool fatal_warnings = false;
 	bool resolve_btfids = true;
 	char out_path[PATH_MAX];
@@ -1921,6 +2085,8 @@ int main(int argc, const char **argv)
 			    "distill --btf_base and emit .BTF.base section data"),
 		OPT_BOOLEAN(0, "inline", &obj.extract_inline,
 			    "extract location BTF into a .BTF.inline file"),
+		OPT_CALLBACK(0, "btf_link", &btf_links, "section:module:btf-file",
+			     "patch a BTF link with --patch_btfids", parse_btf_link),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
 			   "path to .BTF_ids section data blob to patch into ELF file"),
 		OPT_END()
@@ -1931,12 +2097,30 @@ int main(int argc, const char **argv)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc != 1)
 		usage_with_options(resolve_btfids_usage, btfid_options);
+	if (btf_links.cnt && !btfids_path) {
+		pr_err("--btf_link requires --patch_btfids\n");
+		goto out;
+	}
 
 	obj.path = argv[0];
 
-	if (btfids_path)
-		return patch_btfids(btfids_path, obj.path);
+	if (btfids_path) {
+		err = patch_btfids(btfids_path, obj.path);
+		if (err || !btf_links.cnt)
+			goto out;
+		if (elf_collect(&obj)) {
+			err = -EINVAL;
+			goto out;
+		}
+		for (u32 i = 0; i < btf_links.cnt; i++) {
+			struct btf_link *link = &btf_links.links[i];
 
+			err = patch_btf_link(&obj, link);
+			if (err)
+				break;
+		}
+		goto out;
+	}
 	if (elf_collect(&obj))
 		goto out;
 	if (obj.extract_inline && collect_func_symbols(&obj))
@@ -1997,10 +2181,10 @@ int main(int argc, const char **argv)
 		if (err)
 			goto out;
 	}
-
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
+	free_btf_links(&btf_links);
 	btf__free(obj.inline_btf);
 	btf__free(obj.btf);
 	btf__free(obj.base_btf);
-- 
2.43.5

