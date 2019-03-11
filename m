Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B02C43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 00:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1752220652
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 00:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UDRGm+fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfCKAoW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:44:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36204 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbfCKAoV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 10 Mar 2019 20:44:21 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2B0cV16022252
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2019 17:44:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=p8E8jK4eZvMJsmA09otvpahuVjd3PORavlj+q6vGXS4=;
 b=UDRGm+fT3HCivUAgvPhPWNs3ooPyrTVA4geOT2YlvIRmdk/IJOFZpHdvjxlgVU5gtZpb
 qoQn3pKFS8pGZq6CfPjr8FZ2+z5bNoV8hjbg4IaS+f192LmvXVFQY5GKhJ9jpp71nHSv
 72gIwEtcqq2gJZmpSUtwRUWOYqi7figQvSY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r59f80d8y-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2019 17:44:19 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 10 Mar 2019 17:44:17 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id CB8F18608F0; Sun, 10 Mar 2019 17:44:16 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/2] btf: resolve enum fwds in btf_dedup
Date:   Sun, 10 Mar 2019 17:44:09 -0700
Message-ID: <20190311004410.3896503-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311004410.3896503-1-andriin@fb.com>
References: <20190311004410.3896503-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_20:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC and clang support enum forward declarations as an extension. Such
forward-declared enums will be represented as normal BTF_KIND_ENUM types with
vlen=0. This patch adds ability to resolve such enums to their corresponding
fully defined enums. This helps to avoid duplicated BTF type graphs which only
differ by some types referencing forward-declared enum vs full enum.

One such example in kernel is enum irqchip_irq_state, defined in
include/linux/interrupt.h and forward-declared in include/linux/irq.h. This
causes entire struct task_struct and all referenced types to be duplicated in
btf_dedup output. This patch eliminates such duplication cases.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c | 51 +++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 1b8d8cdd3575..87e3020ac1bc 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1602,16 +1602,12 @@ static bool btf_equal_int(struct btf_type *t1, struct btf_type *t2)
 /* Calculate type signature hash of ENUM. */
 static __u32 btf_hash_enum(struct btf_type *t)
 {
-	struct btf_enum *member = (struct btf_enum *)(t + 1);
-	__u32 vlen = BTF_INFO_VLEN(t->info);
-	__u32 h = btf_hash_common(t);
-	int i;
+	__u32 h;
 
-	for (i = 0; i < vlen; i++) {
-		h = hash_combine(h, member->name_off);
-		h = hash_combine(h, member->val);
-		member++;
-	}
+	/* don't hash vlen and enum members to support enum fwd resolving */
+	h = hash_combine(0, t->name_off);
+	h = hash_combine(h, t->info & ~0xffff);
+	h = hash_combine(h, t->size);
 	return h;
 }
 
@@ -1637,6 +1633,22 @@ static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
 	return true;
 }
 
+static inline bool btf_is_enum_fwd(struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM &&
+	       BTF_INFO_VLEN(t->info) == 0;
+}
+
+static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
+{
+	if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
+		return btf_equal_enum(t1, t2);
+	/* ignore vlen when comparing */
+	return t1->name_off == t2->name_off &&
+	       (t1->info & ~0xffff) == (t2->info & ~0xffff) &&
+	       t1->size == t2->size;
+}
+
 /*
  * Calculate type signature hash of STRUCT/UNION, ignoring referenced type IDs,
  * as referenced type IDs equivalence is established separately during type
@@ -1860,6 +1872,17 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 				new_id = cand_node->type_id;
 				break;
 			}
+			if (d->opts.dont_resolve_fwds)
+				continue;
+			if (btf_compat_enum(t, cand)) {
+				if (btf_is_enum_fwd(t)) {
+					/* resolve fwd to full enum */
+					new_id = cand_node->type_id;
+					break;
+				}
+				/* resolve canonical enum fwd to full enum */
+				d->map[cand_node->type_id] = type_id;
+			}
 		}
 		break;
 
@@ -2084,15 +2107,15 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return fwd_kind == real_kind;
 	}
 
-	if (cand_type->info != canon_type->info)
-		return 0;
-
 	switch (cand_kind) {
 	case BTF_KIND_INT:
 		return btf_equal_int(cand_type, canon_type);
 
 	case BTF_KIND_ENUM:
-		return btf_equal_enum(cand_type, canon_type);
+		if (d->opts.dont_resolve_fwds)
+			return btf_equal_enum(cand_type, canon_type);
+		else
+			return btf_compat_enum(cand_type, canon_type);
 
 	case BTF_KIND_FWD:
 		return btf_equal_common(cand_type, canon_type);
@@ -2103,6 +2126,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+		if (cand_type->info != canon_type->info)
+			return 0;
 		return btf_dedup_is_equiv(d, cand_type->type, canon_type->type);
 
 	case BTF_KIND_ARRAY: {
-- 
2.17.1

