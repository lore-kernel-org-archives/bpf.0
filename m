Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B8C4360F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52F420830
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FCt4484A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfB1Xbu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:31:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57130 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732367AbfB1Xbu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 18:31:50 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SNS8wQ002228
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yv2te+/7ZWov+RFZsLfl7wFKUr1FUlswI0auD1wsbbU=;
 b=FCt4484ATkFxja13Pn/4MLDVkQ5CF0SIMvm6PrHBLi1rXPrUOU1twLqS73b4WwTkd86m
 y5/wS0e8GNmwtXsAcJll9xx/M7R2HdmM8T5DqjKaAPP5OnCGD7QkzbPa11sJLoioVTxW
 NtB/0zT7mAZEj+WXX/6RtpkY/1XFa2686Lw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxr1509k7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:48 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 15:31:28 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id D45B5C155DE0; Thu, 28 Feb 2019 15:31:26 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION into corresponding FWD
Date:   Thu, 28 Feb 2019 15:31:24 -0800
Message-ID: <20190228233125.1013080-5-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228233125.1013080-1-andriin@fb.com>
References: <20190228233125.1013080-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When checking available canonical candidates for struct/union algorithm
utilizes btf_dedup_is_equiv to determine if candidate is suitable. This
check is not enough when candidate is corresponding FWD for that
struct/union, because according to equivalence logic they are
equivalent. When it so happens that FWD and STRUCT/UNION end in hashing
to the same bucket, it's possible to create remapping loop from FWD to
STRUCT and STRUCT to same FWD, which will cause btf_dedup() to loop
forever.

This patch fixes the issue by additionally checking that type and
canonical candidate are strictly equal (utilizing btf_equal_struct).

Fixes: d5caef5b5655 ("btf: add BTF types deduplication algorithm")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0f83f99211c6..c0b575c6ebb0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1663,7 +1663,7 @@ static __u32 btf_hash_struct(struct btf_type *t)
  * IDs. This check is performed during type graph equivalence check and
  * referenced types equivalence is checked separately.
  */
-static bool btf_equal_struct(struct btf_type *t1, struct btf_type *t2)
+static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
 {
 	struct btf_member *m1, *m2;
 	__u16 vlen;
@@ -2124,7 +2124,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		struct btf_member *cand_m, *canon_m;
 		__u16 vlen;
 
-		if (!btf_equal_struct(cand_type, canon_type))
+		if (!btf_shallow_equal_struct(cand_type, canon_type))
 			return 0;
 		vlen = BTF_INFO_VLEN(cand_type->info);
 		cand_m = (struct btf_member *)(cand_type + 1);
@@ -2265,7 +2265,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
 static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 {
 	struct btf_dedup_node *cand_node;
-	struct btf_type *t;
+	struct btf_type *cand_type, *t;
 	/* if we don't find equivalent type, then we are canonical */
 	__u32 new_id = type_id;
 	__u16 kind;
@@ -2285,6 +2285,20 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 	for_each_dedup_cand(d, h, cand_node) {
 		int eq;
 
+		/*
+		 * Even though btf_dedup_is_equiv() checks for
+		 * btf_shallow_equal_struct() internally when checking two
+		 * structs (unions) for equivalence, we need to guard here
+		 * from picking matching FWD type as a dedup candidate.
+		 * This can happen due to hash collision. In such case just
+		 * relying on btf_dedup_is_equiv() would lead to potentially
+		 * creating a loop (FWD -> STRUCT and STRUCT -> FWD), because
+		 * FWD and compatible STRUCT/UNION are considered equivalent.
+		 */
+		cand_type = d->btf->types[cand_node->type_id];
+		if (!btf_shallow_equal_struct(t, cand_type))
+			continue;
+
 		btf_dedup_clear_hypot_map(d);
 		eq = btf_dedup_is_equiv(d, type_id, cand_node->type_id);
 		if (eq < 0)
-- 
2.17.1

