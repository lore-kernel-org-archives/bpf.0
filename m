Return-Path: <SRS0=v7MC=QX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205FBC43381
	for <bpf@archiver.kernel.org>; Sat, 16 Feb 2019 03:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6F6222D0
	for <bpf@archiver.kernel.org>; Sat, 16 Feb 2019 03:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iLZcz2Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfBPDwY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:52:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfBPDwY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Feb 2019 22:52:24 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1G3mrbt003737
        for <bpf@vger.kernel.org>; Fri, 15 Feb 2019 19:52:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=SEX6g0L3FPutaxrg4Jpn11jL2NJvYDmWeR24s21DWI0=;
 b=iLZcz2Tz99wB6Rb0nfwUubhsjV1e4hds1oTr/rAQpanf/eA1zyOZJbyAqxEP/wwqAkkG
 qd0AXJMxPcptxn9tvVNrEjYXuAhDDdqm6iq+fRSzbWj7E39osZxte99gWkZuW2RIK4Ms
 +2UQfdsEO0KMKjE1NatMHCoef/EZ/efs/AY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qp635gqbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Feb 2019 19:52:23 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 15 Feb 2019 19:52:22 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id E409FADA7F6A; Fri, 15 Feb 2019 19:52:21 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>,
        <ast@fb.com>, <kafai@fb.com>, <daniel@iogearbox.net>,
        <acme@kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] tools/libbpf: support bigger BTF data sizes
Date:   Fri, 15 Feb 2019 19:52:18 -0800
Message-ID: <20190216035218.342185-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-16_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While it's understandable why kernel limits number of BTF types to 65535
and size of string section to 64KB, in libbpf as user-space library it's
too restrictive. E.g., pahole converting DWARF to BTF type information
for Linux kernel generates more than 3 million BTF types and more than
3MB of strings, before deduplication. So to allow btf__dedup() to do its
work, we need to be able to load bigger BTF sections using btf__new().

Singed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ade1c32fb083..68b50e9bbde1 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -16,7 +16,8 @@
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
-#define BTF_MAX_NR_TYPES 65535
+#define BTF_MAX_NR_TYPES 0x7fffffff
+#define BTF_MAX_STR_OFFSET 0x7fffffff
 
 #define IS_MODIFIER(k) (((k) == BTF_KIND_TYPEDEF) || \
 		((k) == BTF_KIND_VOLATILE) || \
@@ -175,7 +176,7 @@ static int btf_parse_str_sec(struct btf *btf)
 	const char *start = btf->nohdr_data + hdr->str_off;
 	const char *end = start + btf->hdr->str_len;
 
-	if (!hdr->str_len || hdr->str_len - 1 > BTF_MAX_NAME_OFFSET ||
+	if (!hdr->str_len || hdr->str_len - 1 > BTF_MAX_STR_OFFSET ||
 	    start[0] || end[-1]) {
 		pr_debug("Invalid BTF string section\n");
 		return -EINVAL;
@@ -1882,7 +1883,7 @@ static int btf_dedup_prim_types(struct btf_dedup *d)
  */
 static inline bool is_type_mapped(struct btf_dedup *d, uint32_t type_id)
 {
-	return d->map[type_id] <= BTF_MAX_TYPE;
+	return d->map[type_id] <= BTF_MAX_NR_TYPES;
 }
 
 /*
@@ -2033,7 +2034,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 	canon_id = resolve_fwd_id(d, canon_id);
 
 	hypot_type_id = d->hypot_map[canon_id];
-	if (hypot_type_id <= BTF_MAX_TYPE)
+	if (hypot_type_id <= BTF_MAX_NR_TYPES)
 		return hypot_type_id == cand_id;
 
 	if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
@@ -2252,7 +2253,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 	__u32 h;
 
 	/* already deduped or is in process of deduping (loop detected) */
-	if (d->map[type_id] <= BTF_MAX_TYPE)
+	if (d->map[type_id] <= BTF_MAX_NR_TYPES)
 		return 0;
 
 	t = d->btf->types[type_id];
@@ -2329,7 +2330,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 	if (d->map[type_id] == BTF_IN_PROGRESS_ID)
 		return -ELOOP;
-	if (d->map[type_id] <= BTF_MAX_TYPE)
+	if (d->map[type_id] <= BTF_MAX_NR_TYPES)
 		return resolve_type_id(d, type_id);
 
 	t = d->btf->types[type_id];
@@ -2509,7 +2510,7 @@ static int btf_dedup_remap_type_id(struct btf_dedup *d, __u32 type_id)
 
 	resolved_type_id = resolve_type_id(d, type_id);
 	new_type_id = d->hypot_map[resolved_type_id];
-	if (new_type_id > BTF_MAX_TYPE)
+	if (new_type_id > BTF_MAX_NR_TYPES)
 		return -EINVAL;
 	return new_type_id;
 }
-- 
2.17.1

