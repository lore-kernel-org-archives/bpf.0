Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EEDC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16E520717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BEAOSVcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfDYWaR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:30:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47514 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfDYWaR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 18:30:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PMT7SX006147
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=3H1+yCO+26sB2ZhV3EgaQFHWZrceDoTAOLwYz1UQvbM=;
 b=BEAOSVcvJm43Y/VvD9okfSUwPF/7jUAPvnCxAUYtjtHu9nUwpXzGVi3+1zM2ojVhpGKa
 kPUaoA/JDH4J3slsUzTfwzyeOU1KnPcitFekVQvjYnUZjUt+IU5x6xSapspNa38ayCt5
 ejF6iHaNAyApIEENqi/mudT/EwGKjMJhZgQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3fen1jt0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:15 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 25 Apr 2019 15:30:14 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 0009B8615AE; Thu, 25 Apr 2019 15:30:13 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 1/4] bpftool: add ability to dump BTF types
Date:   Thu, 25 Apr 2019 15:30:08 -0700
Message-ID: <20190425223011.284686-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425223011.284686-1-andriin@fb.com>
References: <20190425223011.284686-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new `btf dump` sub-command to bpftool. It allows to dump
human-readable low-level BTF types representation of BTF types. BTF can
be retrieved from few different sources:
  - from BTF object by ID;
  - from PROG, if it has associated BTF;
  - from MAP, if it has associated BTF data; it's possible to narrow
    down types to either key type, value type, both, or all BTF types;
  - from ELF file (.BTF section).

Output format mostly follows BPF verifier log format with few notable
exceptions:
  - all the type/field/param/etc names are enclosed in single quotes to
    allow easier grepping and to stand out a little bit more;
  - FUNC_PROTO output follows STRUCT/UNION/ENUM format of having one
    line per each argument; this is more uniform and allows easy
    grepping, as opposed to succinct, but inconvenient format that BPF
    verifier log is using.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/btf.c  | 586 +++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/main.c |   3 +-
 tools/bpf/bpftool/main.h |   1 +
 3 files changed, 589 insertions(+), 1 deletion(-)
 create mode 100644 tools/bpf/bpftool/btf.c

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
new file mode 100644
index 000000000000..58a2cd002a4b
--- /dev/null
+++ b/tools/bpf/bpftool/btf.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (C) 2019 Facebook */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/err.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <gelf.h>
+#include <bpf.h>
+#include <linux/btf.h>
+
+#include "btf.h"
+#include "json_writer.h"
+#include "main.h"
+
+static const char * const btf_kind_str[NR_BTF_KINDS] = {
+	[BTF_KIND_UNKN]		= "UNKNOWN",
+	[BTF_KIND_INT]		= "INT",
+	[BTF_KIND_PTR]		= "PTR",
+	[BTF_KIND_ARRAY]	= "ARRAY",
+	[BTF_KIND_STRUCT]	= "STRUCT",
+	[BTF_KIND_UNION]	= "UNION",
+	[BTF_KIND_ENUM]		= "ENUM",
+	[BTF_KIND_FWD]		= "FWD",
+	[BTF_KIND_TYPEDEF]	= "TYPEDEF",
+	[BTF_KIND_VOLATILE]	= "VOLATILE",
+	[BTF_KIND_CONST]	= "CONST",
+	[BTF_KIND_RESTRICT]	= "RESTRICT",
+	[BTF_KIND_FUNC]		= "FUNC",
+	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
+	[BTF_KIND_VAR]		= "VAR",
+	[BTF_KIND_DATASEC]	= "DATASEC",
+};
+
+static const char *btf_int_enc_str(__u8 encoding)
+{
+	switch (encoding) {
+	case 0:
+		return "(none)";
+	case BTF_INT_SIGNED:
+		return "SIGNED";
+	case BTF_INT_CHAR:
+		return "CHAR";
+	case BTF_INT_BOOL:
+		return "BOOL";
+	default:
+		return "UNKN";
+	}
+}
+
+static const char *btf_var_linkage_str(__u32 linkage)
+{
+	switch (linkage) {
+	case BTF_VAR_STATIC:
+		return "static";
+	case BTF_VAR_GLOBAL_ALLOCATED:
+		return "global-alloc";
+	default:
+		return "(unknown)";
+	}
+}
+
+static const char *btf_str(const struct btf *btf, __u32 off)
+{
+	if (!off)
+		return "(anon)";
+	return btf__name_by_offset(btf, off) ? : "(invalid)";
+}
+
+static int dump_btf_type(const struct btf *btf, __u32 id,
+			 const struct btf_type *t)
+{
+	json_writer_t *w = json_wtr;
+	int kind, safe_kind;
+
+	kind = BTF_INFO_KIND(t->info);
+	safe_kind = kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
+
+	if (json_output) {
+		jsonw_start_object(w);
+		jsonw_uint_field(w, "id", id);
+		jsonw_string_field(w, "kind", btf_kind_str[safe_kind]);
+		jsonw_string_field(w, "name", btf_str(btf, t->name_off));
+	} else {
+		printf("[%u] %s '%s'", id, btf_kind_str[safe_kind],
+		       btf_str(btf, t->name_off));
+	}
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_INT: {
+		__u32 v = *(__u32 *)(t + 1);
+		const char *enc;
+
+		enc = btf_int_enc_str(BTF_INT_ENCODING(v));
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "bits_offset", BTF_INT_OFFSET(v));
+			jsonw_uint_field(w, "nr_bits", BTF_INT_BITS(v));
+			jsonw_string_field(w, "encoding", enc);
+		} else {
+			printf(" size=%u bits_offset=%u nr_bits=%u encoding=%s",
+			       t->size, BTF_INT_OFFSET(v), BTF_INT_BITS(v),
+			       enc);
+		}
+		break;
+	}
+	case BTF_KIND_PTR:
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPEDEF:
+		if (json_output)
+			jsonw_uint_field(w, "type_id", t->type);
+		else
+			printf(" type_id=%u", t->type);
+		break;
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *arr = (const void *)(t + 1);
+
+		if (json_output) {
+			jsonw_uint_field(w, "type_id", arr->type);
+			jsonw_uint_field(w, "index_type_id", arr->index_type);
+			jsonw_uint_field(w, "nr_elems", arr->nelems);
+		} else {
+			printf(" type_id=%u index_type_id=%u nr_elems=%u",
+			       arr->type, arr->index_type, arr->nelems);
+		}
+		break;
+	}
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const struct btf_member *m = (const void *)(t + 1);
+		__u16 vlen = BTF_INFO_VLEN(t->info);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "members");
+			jsonw_start_array(w);
+		} else {
+			printf(" size=%u vlen=%u", t->size, vlen);
+		}
+		for (i = 0; i < vlen; i++, m++) {
+			const char *name = btf_str(btf, m->name_off);
+			__u32 bit_off, bit_sz;
+
+			if (BTF_INFO_KFLAG(t->info)) {
+				bit_off = BTF_MEMBER_BIT_OFFSET(m->offset);
+				bit_sz = BTF_MEMBER_BITFIELD_SIZE(m->offset);
+			} else {
+				bit_off = m->offset;
+				bit_sz = 0;
+			}
+
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_string_field(w, "name", name);
+				jsonw_uint_field(w, "type_id", m->type);
+				jsonw_uint_field(w, "bits_offset", bit_off);
+				if (bit_sz) {
+					jsonw_uint_field(w, "bitfield_size",
+							 bit_sz);
+				}
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t'%s' type_id=%u bits_offset=%u",
+				       name, m->type, bit_off);
+				if (bit_sz)
+					printf(" bitfield_size=%u", bit_sz);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+	case BTF_KIND_ENUM: {
+		const struct btf_enum *v = (const void *)(t + 1);
+		__u16 vlen = BTF_INFO_VLEN(t->info);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "values");
+			jsonw_start_array(w);
+		} else {
+			printf(" size=%u vlen=%u", t->size, vlen);
+		}
+		for (i = 0; i < vlen; i++, v++) {
+			const char *name = btf_str(btf, v->name_off);
+
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_string_field(w, "name", name);
+				jsonw_uint_field(w, "val", v->val);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t'%s' val=%u", name, v->val);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+	case BTF_KIND_FWD: {
+		const char *fwd_kind = BTF_INFO_KIND(t->info) ? "union"
+							      : "struct";
+
+		if (json_output)
+			jsonw_string_field(w, "fwd_kind", fwd_kind);
+		else
+			printf(" fwd_kind=%s", fwd_kind);
+		break;
+	}
+	case BTF_KIND_FUNC:
+		if (json_output)
+			jsonw_uint_field(w, "type_id", t->type);
+		else
+			printf(" type_id=%u", t->type);
+		break;
+	case BTF_KIND_FUNC_PROTO: {
+		const struct btf_param *p = (const void *)(t + 1);
+		__u16 vlen = BTF_INFO_VLEN(t->info);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "ret_type_id", t->type);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "params");
+			jsonw_start_array(w);
+		} else {
+			printf(" ret_type_id=%u vlen=%u", t->type, vlen);
+		}
+		for (i = 0; i < vlen; i++, p++) {
+			const char *name = btf_str(btf, p->name_off);
+
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_string_field(w, "name", name);
+				jsonw_uint_field(w, "type_id", p->type);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t'%s' type_id=%u", name, p->type);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+	case BTF_KIND_VAR: {
+		const struct btf_var *v = (const void *)(t + 1);
+		const char *linkage;
+
+		linkage = btf_var_linkage_str(v->linkage);
+
+		if (json_output) {
+			jsonw_uint_field(w, "type_id", t->type);
+			jsonw_string_field(w, "linkage", linkage);
+		} else {
+			printf(" type_id=%u, linkage=%s", t->type, linkage);
+		}
+		break;
+	}
+	case BTF_KIND_DATASEC: {
+		const struct btf_var_secinfo *v = (const void *)(t+1);
+		__u16 vlen = BTF_INFO_VLEN(t->info);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "vars");
+			jsonw_start_array(w);
+		} else {
+			printf(" size=%u vlen=%u", t->size, vlen);
+		}
+		for (i = 0; i < vlen; i++, v++) {
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_uint_field(w, "type_id", v->type);
+				jsonw_uint_field(w, "offset", v->offset);
+				jsonw_uint_field(w, "size", v->size);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\ttype_id=%u offset=%u size=%u",
+				       v->type, v->offset, v->size);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+	default:
+		break;
+	}
+
+	if (json_output)
+		jsonw_end_object(json_wtr);
+	else
+		printf("\n");
+
+	return 0;
+}
+
+static int dump_btf_raw(const struct btf *btf,
+			__u32 *root_type_ids, int root_type_cnt)
+{
+	const struct btf_type *t;
+	int i;
+
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_name(json_wtr, "types");
+		jsonw_start_array(json_wtr);
+	}
+
+	if (root_type_cnt) {
+		for (i = 0; i < root_type_cnt; i++) {
+			t = btf__type_by_id(btf, root_type_ids[i]);
+			dump_btf_type(btf, root_type_ids[i], t);
+		}
+	} else {
+		int cnt = btf__get_nr_types(btf);
+
+		for (i = 1; i <= cnt; i++) {
+			t = btf__type_by_id(btf, i);
+			dump_btf_type(btf, i, t);
+		}
+	}
+
+	if (json_output) {
+		jsonw_end_array(json_wtr);
+		jsonw_end_object(json_wtr);
+	}
+	return 0;
+}
+
+static bool check_btf_endianness(GElf_Ehdr *ehdr)
+{
+	static unsigned int const endian = 1;
+
+	switch (ehdr->e_ident[EI_DATA]) {
+	case ELFDATA2LSB:
+		return *(unsigned char const *)&endian == 1;
+	case ELFDATA2MSB:
+		return *(unsigned char const *)&endian == 0;
+	default:
+		return 0;
+	}
+}
+
+static int btf_load_from_elf(const char *path, struct btf **btf)
+{
+	int err = -1, fd = -1, idx = 0;
+	Elf_Data *btf_data = NULL;
+	Elf_Scn *scn = NULL;
+	Elf *elf = NULL;
+	GElf_Ehdr ehdr;
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		p_err("failed to init libelf for %s", path);
+		return -1;
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		p_err("failed to open %s: %s", path, strerror(errno));
+		return -1;
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf) {
+		p_err("failed to open %s as ELF file", path);
+		goto done;
+	}
+	if (!gelf_getehdr(elf, &ehdr)) {
+		p_err("failed to get EHDR from %s", path);
+		goto done;
+	}
+	if (!check_btf_endianness(&ehdr)) {
+		p_err("non-native ELF endianness is not supported");
+		goto done;
+	}
+	if (!elf_rawdata(elf_getscn(elf, ehdr.e_shstrndx), NULL)) {
+		p_err("failed to get e_shstrndx from %s\n", path);
+		goto done;
+	}
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		GElf_Shdr sh;
+		char *name;
+
+		idx++;
+		if (gelf_getshdr(scn, &sh) != &sh) {
+			p_err("failed to get section(%d) header from %s",
+			      idx, path);
+			goto done;
+		}
+		name = elf_strptr(elf, ehdr.e_shstrndx, sh.sh_name);
+		if (!name) {
+			p_err("failed to get section(%d) name from %s",
+			      idx, path);
+			goto done;
+		}
+		if (strcmp(name, BTF_ELF_SEC) == 0) {
+			btf_data = elf_getdata(scn, 0);
+			if (!btf_data) {
+				p_err("failed to get section(%d, %s) data from %s",
+				      idx, name, path);
+				goto done;
+			}
+			break;
+		}
+	}
+
+	if (!btf_data) {
+		p_err("%s ELF section not found in %s", BTF_ELF_SEC, path);
+		goto done;
+	}
+
+	*btf = btf__new(btf_data->d_buf, btf_data->d_size);
+	if (IS_ERR(*btf)) {
+		err = PTR_ERR(*btf);
+		*btf = NULL;
+		p_err("failed to load BTF data from %s: %s",
+		      path, strerror(err));
+		goto done;
+	}
+
+	err = 0;
+done:
+	if (err) {
+		if (*btf) {
+			btf__free(*btf);
+			*btf = NULL;
+		}
+	}
+	if (elf)
+		elf_end(elf);
+	close(fd);
+	return err;
+}
+
+static int do_dump(int argc, char **argv)
+{
+	struct btf *btf = NULL;
+	__u32 root_type_ids[2];
+	int root_type_cnt = 0;
+	__u32 btf_id = -1;
+	const char *src;
+	int fd = -1;
+	int err;
+
+	if (!REQ_ARGS(2)) {
+		usage();
+		return -1;
+	}
+	src = GET_ARG();
+
+	if (is_prefix(src, "map")) {
+		struct bpf_map_info info = {};
+		__u32 len = sizeof(info);
+
+		if (!REQ_ARGS(2)) {
+			usage();
+			return -1;
+		}
+
+		fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
+		if (fd < 0)
+			return -1;
+
+		btf_id = info.btf_id;
+		if (argc && is_prefix(*argv, "key")) {
+			root_type_ids[root_type_cnt++] = info.btf_key_type_id;
+			NEXT_ARG();
+		} else if (argc && is_prefix(*argv, "value")) {
+			root_type_ids[root_type_cnt++] = info.btf_value_type_id;
+			NEXT_ARG();
+		} else if (argc && is_prefix(*argv, "all")) {
+			NEXT_ARG();
+		} else if (argc && is_prefix(*argv, "kv")) {
+			root_type_ids[root_type_cnt++] = info.btf_key_type_id;
+			root_type_ids[root_type_cnt++] = info.btf_value_type_id;
+			NEXT_ARG();
+		} else {
+			root_type_ids[root_type_cnt++] = info.btf_key_type_id;
+			root_type_ids[root_type_cnt++] = info.btf_value_type_id;
+		}
+	} else if (is_prefix(src, "prog")) {
+		struct bpf_prog_info info = {};
+		__u32 len = sizeof(info);
+
+		if (!REQ_ARGS(2)) {
+			usage();
+			return -1;
+		}
+
+		fd = prog_parse_fd(&argc, &argv);
+		if (fd < 0)
+			return -1;
+
+		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			p_err("can't get prog info: %s", strerror(errno));
+			goto done;
+		}
+
+		btf_id = info.btf_id;
+	} else if (is_prefix(src, "id")) {
+		char *endptr;
+
+		btf_id = strtoul(*argv, &endptr, 0);
+		if (*endptr) {
+			p_err("can't parse %s as ID", **argv);
+			return -1;
+		}
+		NEXT_ARG();
+	} else if (is_prefix(src, "file")) {
+		err = btf_load_from_elf(*argv, &btf);
+		if (err)
+			goto done;
+		NEXT_ARG();
+	} else {
+		err = -1;
+		p_err("unrecognized BTF source specifier: '%s'", src);
+		goto done;
+	}
+
+	if (!btf) {
+		err = btf__get_from_id(btf_id, &btf);
+		if (err) {
+			p_err("get btf by id (%u): %s", btf_id, strerror(err));
+			goto done;
+		}
+		if (!btf) {
+			err = ENOENT;
+			p_err("can't find btf with ID (%u)", btf_id);
+			goto done;
+		}
+	}
+
+	dump_btf_raw(btf, root_type_ids, root_type_cnt);
+
+done:
+	close(fd);
+	btf__free(btf);
+	return err;
+}
+
+static int do_help(int argc, char **argv)
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %s btf dump BTF_SRC\n"
+		"       %s btf help\n"
+		"\n"
+		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
+		"       " HELP_SPEC_MAP "\n"
+		"       " HELP_SPEC_PROGRAM "\n"
+		"       " HELP_SPEC_OPTIONS "\n"
+		"",
+		bin_name, bin_name);
+
+	return 0;
+}
+
+static const struct cmd cmds[] = {
+	{ "help",	do_help },
+	{ "dump",	do_dump },
+	{ 0 }
+};
+
+int do_btf(int argc, char **argv)
+{
+	return cmd_select(cmds, argc, argv, do_help);
+}
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index a9d5e9e6a732..1ac1fc520e6a 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -56,7 +56,7 @@ static int do_help(int argc, char **argv)
 		"       %s batch file FILE\n"
 		"       %s version\n"
 		"\n"
-		"       OBJECT := { prog | map | cgroup | perf | net | feature }\n"
+		"       OBJECT := { prog | map | cgroup | perf | net | feature | btf }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, bin_name, bin_name);
@@ -188,6 +188,7 @@ static const struct cmd cmds[] = {
 	{ "perf",	do_perf },
 	{ "net",	do_net },
 	{ "feature",	do_feature },
+	{ "btf",	do_btf },
 	{ "version",	do_version },
 	{ 0 }
 };
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 1ccc46169a19..3d63feb7f852 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -150,6 +150,7 @@ int do_perf(int argc, char **arg);
 int do_net(int argc, char **arg);
 int do_tracelog(int argc, char **arg);
 int do_feature(int argc, char **argv);
+int do_btf(int argc, char **argv);
 
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
 int prog_parse_fd(int *argc, char ***argv);
-- 
2.17.1

