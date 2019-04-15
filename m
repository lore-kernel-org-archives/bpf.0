Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE73C10F12
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93C520675
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDOXsO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:48:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbfDOXsN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 19:48:13 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FNcNgr032427
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 16:48:11 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rw2ffr99t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 16:48:11 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 15 Apr 2019 16:48:10 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 47E3286176A; Mon, 15 Apr 2019 16:48:10 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/2] btf: add support for VAR and DATASEC in btf_dedup()
Date:   Mon, 15 Apr 2019 16:48:07 -0700
Message-ID: <20190415234808.2225360-2-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415234808.2225360-1-andrii.nakryiko@gmail.com>
References: <20190415234808.2225360-1-andrii.nakryiko@gmail.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

This patch adds support for VAR and DATASEC in btf_dedup(). VAR/DATASEC
are never deduplicated, but they need to be processed anyway as types
they refer to might need to be remapped due to deduplication and
compaction.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 701e7e28ada3..75eaf10b9e1a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1354,8 +1354,16 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 	}
 	/* special BTF "void" type is made canonical immediately */
 	d->map[0] = 0;
-	for (i = 1; i <= btf->nr_types; i++)
-		d->map[i] = BTF_UNPROCESSED_ID;
+	for (i = 1; i <= btf->nr_types; i++) {
+		struct btf_type *t = d->btf->types[i];
+		__u16 kind = BTF_INFO_KIND(t->info);
+
+		/* VAR and DATASEC are never deduped and are self-canonical */
+		if (kind == BTF_KIND_VAR || kind == BTF_KIND_DATASEC)
+			d->map[i] = i;
+		else
+			d->map[i] = BTF_UNPROCESSED_ID;
+	}
 
 	d->hypot_map = malloc(sizeof(__u32) * (1 + btf->nr_types));
 	if (!d->hypot_map) {
@@ -1946,6 +1954,8 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_UNION:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FUNC_PROTO:
+	case BTF_KIND_VAR:
+	case BTF_KIND_DATASEC:
 		return 0;
 
 	case BTF_KIND_INT:
@@ -2699,6 +2709,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+	case BTF_KIND_VAR:
 		r = btf_dedup_remap_type_id(d, t->type);
 		if (r < 0)
 			return r;
@@ -2753,6 +2764,20 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
 		break;
 	}
 
+	case BTF_KIND_DATASEC: {
+		struct btf_var_secinfo *var = (struct btf_var_secinfo *)(t + 1);
+		__u16 vlen = BTF_INFO_VLEN(t->info);
+
+		for (i = 0; i < vlen; i++) {
+			r = btf_dedup_remap_type_id(d, var->type);
+			if (r < 0)
+				return r;
+			var->type = r;
+			var++;
+		}
+		break;
+	}
+
 	default:
 		return -EINVAL;
 	}
-- 
2.17.1

