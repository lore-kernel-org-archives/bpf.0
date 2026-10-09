Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50945563C;
	Fri,  9 Oct 2026 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545058; cv=none; b=KzvUlSgKXO/8u2DLxLnAvpyS1GK01aUXOGM1jTrK0JfVf6ekCuiSUXtMdd2+yykBf0xVkPB9uQUtccxGo2BnJcn6NkWZ8WAPwQi4wQcXGrSG46TlD2Zt1X2A0xmAq1DmssrAaRL66B2khZVBHCa3VKsEzzICeH8atttliR12E3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545058; c=relaxed/simple;
	bh=3KyRV5fNR7vIe427aCO0nVO+jT3N2xo/nkkZoCJhOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHq3LtKXrG2lsIu87SPf27IHWFwQeTlgqYFmIvHfZiAxL3tTX7L2uNU2Nnt88MV00NuyOhItouCcSgD+ZGvIlvjueMp/eAs+5JVHGxfFyUkx2TZuTBCoknEiecwXqUuv+ebJLN6OV4HM/pb6MHXDdBbWYRdWud9BCVdaUwKAX7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rbxbZeL7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rbxbZeL7"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698K9p5H2257839;
	Fri, 9 Oct 2026 11:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=10Ndk
	0qd9qFRN9ato391uuq3ZjpYI9RlN+fGKD+UEnQ=; b=rbxbZeL7qy3Jg0I8iTy67
	5DLtV5PzMx3IQvFFo4zsoN2hGualdg4RNAMn1WAtebdS4YlTqHhnudoxyWgefKiD
	S8E9hUs93LrWu8XpRcS2W37O5jB0L0ICe/yfEzCkaN/4/NAHUXZ8qa6bO01ypxlQ
	ubWN4JmvDiVOxRYYWvGTU1YEWyAPFHXyGUIt7qVATb+DXkQeYAeiVJ2Iu/TrGmdC
	qfLGdrdkBJePtxQme4rXQfzSKNhg1EpQf1o7Hq06YbFajoQ4M554wcFHybvX+6qk
	cmQfIPNBL/tj4pG1VTQalCeAru1skTRJ/Xi1ot1CcohkTaBCM/aB3B5LonhK5JsW
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xegjy68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLkSs039873;
	Fri, 9 Oct 2026 11:23:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsnby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:35 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRkU006543;
	Fri, 9 Oct 2026 11:23:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-3;
	Fri, 09 Oct 2026 11:23:35 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 2/7] resolve_btfids: Populate BTF link section
Date: Fri,  9 Oct 2026 12:23:19 +0100
Message-ID: <20261009112324.1442319-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX3qL07T2EiSjr
 lzwU0pvEf+RfGVYZXQYLYgTe7xvUBVoki5wS9fuBtI+x7bkG82zcScUntvcZVO6AbTaHPjIaOmD
 1sqf8tEMP9rVQuLYvBEdOKgIgi0AU4IjMIrHVXX13m2C6nqJSwgl/WQSWduT2SgAytgr98Mv7gI
 gB2UzoGcPfkxzE2HaEfccC6SKmmsJy87m5umcBCZ8n773N4lQScsJjMcVlUuvazmj+GAOQF2hOZ
 /64YxE7591fKoYD76ZJX4rAsEXoeJlz88xxQTAstVG8Y8QLB5ma1tskudV7RsVR1CUEmMn8nrcv
 ESTVLEOGu5lkbFtsb1u4awZaubjVpQKhr8uZliOPGsLLCJi4W9E3hrO8AeanFp3jfgKe6UhnyzG
 TUndYrWo0Exe6GUIKUikfdhTJT0YsQboJGujbGwcYzmVFU2/IfRHI333tgclNd6kbmlxG4slW69
 ScUC9kgZmmOqx1+P8354QQYSQdIHLuTUf2DcUM54=
X-Authority-Analysis: v=2.4 cv=OtfaWC/t c=1 sm=1 tr=0 ts=6ac8ceb9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=MyPM3S7XMLX627TPedsA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-ORIG-GUID: B169sCwh8EuRkwMi3e8oKthbMog2R65m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX0kIJlZrIBXzz
 nse3NzvFOIMZSFPTU0WdMP2VplEoxt2cfNHy9NArbFltgm4c8LKARDySTW1I6v6G/uZhyK3igAt
 l8ISplGDQqnyvWKQsyvqbjMbWORjBYZbuNOkQzvGjBf8qI9K36le
X-Proofpoint-GUID: B169sCwh8EuRkwMi3e8oKthbMog2R65m

Allow the final BTF patch pass to populate one or more BTF link
records.  A link identifies the BTF section to be delivered, its
carrier module, and the raw finalized BTF payload:

    --btf_link <section>:<module>:<raw-btf-file>

Use the raw file size and SHA-256 digest to populate the corresponding
<section>.link record.  This avoids reparsing BTF during final ELF
patching and supports inline vmlinux BTF linking.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT 5.6)
---
 tools/bpf/resolve_btfids/btf_colors.c |   6 +
 tools/bpf/resolve_btfids/btf_colors.h |   4 +
 tools/bpf/resolve_btfids/main.c       | 234 +++++++++++++++++++++++++-
 3 files changed, 241 insertions(+), 3 deletions(-)

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
index 15e7be13061f..f737fac60fa2 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -93,6 +93,7 @@
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
+#define BTF_LINK_MODULE_NAME_MAX	64
 #define BTF_ID_PREFIX	"__BTF_ID__"
 
 #define BTF_STRUCT	"struct"
@@ -158,6 +159,7 @@ struct object {
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
 		int		 encoding;
+		int		 elf_class;
 		const char	**func_symbols;
 		u32		 func_symbols_cnt;
 		u32		 func_symbols_cap;
@@ -180,6 +182,19 @@ struct object {
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
 
@@ -267,6 +282,49 @@ static int __ensure_mem(void **data, u32 *cap, u32 cnt, size_t elem_sz)
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
@@ -488,6 +546,7 @@ static int elf_collect(struct object *obj)
 		return -1;
 	}
 	obj->efile.encoding = ehdr.e_ident[EI_DATA];
+	obj->efile.elf_class = ehdr.e_ident[EI_CLASS];
 
 	/*
 	 * Scan all the elf sections and look for save data
@@ -1030,6 +1089,153 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
 	return 0;
 }
 
+static int patch_btf_link(struct object *obj, const struct btf_link *link)
+{
+	char section[128];
+	void *raw_btf_data = NULL;
+	size_t shdrstrndx, module_name_len;
+	int fd = -1, len, err = -1;
+	FILE *btf_file = NULL;
+	Elf_Scn *scn = NULL;
+	u32 raw_btf_size;
+	struct stat st;
+	Elf_Data *data;
+	GElf_Shdr sh;
+	char *name;
+	Elf *elf = NULL;
+	u8 *size;
+
+	if (stat(link->btf_path, &st)) {
+		err = -errno;
+		pr_err("FAILED to stat BTF file %s: %s\n",
+		       link->btf_path, strerror(errno));
+		return err;
+	}
+	if (!S_ISREG(st.st_mode) || st.st_size <= 0 || st.st_size > UINT_MAX) {
+		pr_err("FAILED: invalid BTF file size or type: %s\n", link->btf_path);
+		return -EINVAL;
+	}
+	raw_btf_size = st.st_size;
+	raw_btf_data = malloc(raw_btf_size);
+	if (!raw_btf_data) {
+		pr_err("FAILED to allocate %u bytes for BTF file %s\n",
+		       raw_btf_size, link->btf_path);
+		return -ENOMEM;
+	}
+	btf_file = fopen(link->btf_path, "rb");
+	if (!btf_file) {
+		err = -errno;
+		pr_err("FAILED to open BTF file %s: %s\n",
+		       link->btf_path, strerror(errno));
+		goto out;
+	}
+	if (fread(raw_btf_data, raw_btf_size, 1, btf_file) != 1) {
+		err = -EIO;
+		pr_err("FAILED to read BTF file %s\n", link->btf_path);
+		goto out;
+	}
+	fclose(btf_file);
+	btf_file = NULL;
+	if (obj->efile.elf_class == ELFCLASS32) {
+		module_name_len = BTF_LINK_MODULE_NAME_MAX - 4;
+	} else if (obj->efile.elf_class == ELFCLASS64) {
+		module_name_len = BTF_LINK_MODULE_NAME_MAX - 8;
+	} else {
+		err = -EINVAL;
+		pr_err("FAILED: unsupported ELF class %u in %s\n",
+		       obj->efile.elf_class, obj->path);
+		goto out;
+	}
+	if (strlen(link->module) >= module_name_len) {
+		err = -EINVAL;
+		pr_err("FAILED: module name too long for BTF link: %s\n", link->module);
+		goto out;
+	}
+	len = snprintf(section, sizeof(section), "%s.link", link->section);
+	if (len < 0 || len >= sizeof(section)) {
+		err = -ENAMETOOLONG;
+		pr_err("FAILED: BTF link section name too long: %s.link\n", link->section);
+		goto out;
+	}
+
+	fd = open(obj->path, O_RDWR);
+	if (fd < 0) {
+		err = -errno;
+		pr_err("FAILED to open %s: %s\n", obj->path, strerror(errno));
+		goto out;
+	}
+	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
+	if (!elf) {
+		err = -EINVAL;
+		pr_err("FAILED to create ELF descriptor for %s: %s\n",
+		       obj->path, elf_errmsg(-1));
+		goto out;
+	}
+	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
+	if (elf_getshdrstrndx(elf, &shdrstrndx)) {
+		pr_err("FAILED to get section name index from %s: %s\n",
+		       obj->path, elf_errmsg(-1));
+		goto out;
+	}
+	while ((scn = elf_nextscn(elf, scn))) {
+		if (gelf_getshdr(scn, &sh) != &sh) {
+			pr_err("FAILED to get section header from %s: %s\n",
+			       obj->path, elf_errmsg(-1));
+			goto out;
+		}
+		name = elf_strptr(elf, shdrstrndx, sh.sh_name);
+		if (name && !strcmp(name, section))
+			break;
+	}
+	if (!scn) {
+		pr_err("FAILED: section %s not found in %s\n", section, obj->path);
+		goto out;
+	}
+	data = elf_getdata(scn, NULL);
+	if (sh.sh_type != SHT_PROGBITS || !data || !data->d_buf ||
+	    data->d_size != module_name_len +
+		BTF_SHA256_DIGEST_LENGTH + sizeof(u32)) {
+		pr_err("FAILED: section %s is not a writable BTF link\n", section);
+		goto out;
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
+		pr_err("FAILED: unsupported ELF data encoding %u in %s\n",
+		       obj->efile.encoding, obj->path);
+		goto out;
+	}
+	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
+	if (elf_update(elf, ELF_C_WRITE) < 0) {
+		pr_err("FAILED to update ELF file %s: %s\n",
+		       obj->path, elf_errmsg(-1));
+		goto out;
+	}
+	err = 0;
+out:
+	if (elf)
+		elf_end(elf);
+	if (fd >= 0)
+		close(fd);
+	if (btf_file)
+		fclose(btf_file);
+	free(raw_btf_data);
+	return err;
+}
+
 static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf, s32 type_id)
 {
 	const struct btf_type *t = btf__type_by_id(btf, type_id);
@@ -1871,7 +2077,7 @@ static int patch_btfids(const char *btfids_path, const char *elf_path)
 
 static const char * const resolve_btfids_usage[] = {
 	"resolve_btfids [<options>] <ELF object>",
-	"resolve_btfids --patch_btfids <.BTF_ids file> <ELF object>",
+	"resolve_btfids --patch_btfids <.BTF_ids file> [--btf_link <section:module:btf-file>] <ELF object>",
 	NULL
 };
 
@@ -1889,6 +2095,7 @@ int main(int argc, const char **argv)
 		.sets     = RB_ROOT,
 	};
 	const char *btfids_path = NULL;
+	struct btf_links btf_links = {};
 	bool fatal_warnings = false;
 	bool resolve_btfids = true;
 	char out_path[PATH_MAX];
@@ -1906,6 +2113,8 @@ int main(int argc, const char **argv)
 			    "distill --btf_base and emit .BTF.base section data"),
 		OPT_BOOLEAN(0, "inline", &obj.extract_inline,
 			    "extract location BTF into a .BTF.inline file"),
+		OPT_CALLBACK(0, "btf_link", &btf_links, "section:module:btf-file",
+			     "patch a BTF link with --patch_btfids", parse_btf_link),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
 			   "path to .BTF_ids section data blob to patch into ELF file"),
 		OPT_END()
@@ -1916,12 +2125,30 @@ int main(int argc, const char **argv)
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
@@ -1986,6 +2213,7 @@ int main(int argc, const char **argv)
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
+	free_btf_links(&btf_links);
 	/*
 	 * Free BTFs in reverse dependency order.  inline_btf borrows obj.btf;
 	 * obj.btf can borrow a base owned by orig_btf or obj.base_btf, and
-- 
2.43.5

