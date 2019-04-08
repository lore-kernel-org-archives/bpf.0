Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C0C282CE
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB27620663
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDHNy1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:54:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:46140 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDHNyG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 09:54:06 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDUin-0003ht-6e; Mon, 08 Apr 2019 15:54:01 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 13/16] bpf: bpftool support for dumping data/bss/rodata sections
Date:   Mon,  8 Apr 2019 15:53:45 +0200
Message-Id: <8f55b9696bfab47963c0ca7428f7caaa70f7ce81.1554731339.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25413/Mon Apr  8 09:56:28 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the ability to bpftool to handle BTF Var and DataSec kinds
in order to dump them out of btf_dumper_type(). The value has a
single object with the section name, which itself holds an array
of variables it dumps. A single variable is an object by itself
printed along with its name. From there further type information
is dumped along with corresponding value information.

Example output from .rodata:

  # ./bpftool m d i 150
  [{
          "value": {
              ".rodata": [{
                      "load_static_data.bar": 18446744073709551615
                  },{
                      "num2": 24
                  },{
                      "num5": 43947
                  },{
                      "num6": 171
                  },{
                      "str0": [97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,0,0,0,0,0,0
                      ]
                  },{
                      "struct0": {
                          "a": 42,
                          "b": 4278120431,
                          "c": 1229782938247303441
                      }
                  },{
                      "struct2": {
                          "a": 0,
                          "b": 0,
                          "c": 0
                      }
                  }
              ]
          }
      }
  ]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/btf_dumper.c | 59 ++++++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/map.c        | 10 ++++---
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index e63bce0..8cafb9b 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -309,6 +309,48 @@ static int btf_dumper_struct(const struct btf_dumper *d, __u32 type_id,
 	return ret;
 }
 
+static int btf_dumper_var(const struct btf_dumper *d, __u32 type_id,
+			  __u8 bit_offset, const void *data)
+{
+	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
+	int ret;
+
+	jsonw_start_object(d->jw);
+	jsonw_name(d->jw, btf__name_by_offset(d->btf, t->name_off));
+	ret = btf_dumper_do_type(d, t->type, bit_offset, data);
+	jsonw_end_object(d->jw);
+
+	return ret;
+}
+
+static int btf_dumper_datasec(const struct btf_dumper *d, __u32 type_id,
+			      const void *data)
+{
+	struct btf_var_secinfo *vsi;
+	const struct btf_type *t;
+	int ret = 0, i, vlen;
+
+	t = btf__type_by_id(d->btf, type_id);
+	if (!t)
+		return -EINVAL;
+
+	vlen = BTF_INFO_VLEN(t->info);
+	vsi = (struct btf_var_secinfo *)(t + 1);
+
+	jsonw_start_object(d->jw);
+	jsonw_name(d->jw, btf__name_by_offset(d->btf, t->name_off));
+	jsonw_start_array(d->jw);
+	for (i = 0; i < vlen; i++) {
+		ret = btf_dumper_do_type(d, vsi[i].type, 0, data + vsi[i].offset);
+		if (ret)
+			break;
+	}
+	jsonw_end_array(d->jw);
+	jsonw_end_object(d->jw);
+
+	return ret;
+}
+
 static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 			      __u8 bit_offset, const void *data)
 {
@@ -341,6 +383,10 @@ static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
 		return btf_dumper_modifier(d, type_id, bit_offset, data);
+	case BTF_KIND_VAR:
+		return btf_dumper_var(d, type_id, bit_offset, data);
+	case BTF_KIND_DATASEC:
+		return btf_dumper_datasec(d, type_id, data);
 	default:
 		jsonw_printf(d->jw, "(unsupported-kind");
 		return -EINVAL;
@@ -377,6 +423,7 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
 {
 	const struct btf_type *proto_type;
 	const struct btf_array *array;
+	const struct btf_var *var;
 	const struct btf_type *t;
 
 	if (!type_id) {
@@ -440,6 +487,18 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
 		if (pos == -1)
 			return -1;
 		break;
+	case BTF_KIND_VAR:
+		var = (struct btf_var *)(t + 1);
+		if (var->linkage == BTF_VAR_STATIC)
+			BTF_PRINT_ARG("static ");
+		BTF_PRINT_TYPE(t->type);
+		BTF_PRINT_ARG(" %s",
+			      btf__name_by_offset(btf, t->name_off));
+		break;
+	case BTF_KIND_DATASEC:
+		BTF_PRINT_ARG("section (\"%s\") ",
+			      btf__name_by_offset(btf, t->name_off));
+		break;
 	case BTF_KIND_UNKN:
 	default:
 		return -1;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e0c650d..e969030 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -153,11 +153,13 @@ static int do_dump_btf(const struct btf_dumper *d,
 	/* start of key-value pair */
 	jsonw_start_object(d->jw);
 
-	jsonw_name(d->jw, "key");
+	if (map_info->btf_key_type_id) {
+		jsonw_name(d->jw, "key");
 
-	ret = btf_dumper_type(d, map_info->btf_key_type_id, key);
-	if (ret)
-		goto err_end_obj;
+		ret = btf_dumper_type(d, map_info->btf_key_type_id, key);
+		if (ret)
+			goto err_end_obj;
+	}
 
 	if (!map_is_per_cpu(map_info->type)) {
 		jsonw_name(d->jw, "value");
-- 
2.9.5

