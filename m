Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A4C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FB12133D
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a7N2hmmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfB0Wqy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:46:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40154 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730254AbfB0Wqx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Feb 2019 17:46:53 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1RMbOtc005758
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=9aNLpjBqFRqS9gdhzLnZZThY6ccSFCfONWG1DMgXnLk=;
 b=a7N2hmmCZ7d/itFTCoKHC0IdXGn/LpvEjERVS2RSGhMdbmMrSDjt6MMEnnIN5Mvv0Lvo
 QdJHdjJ48g+BLygjZlHapsc6ETv+0l0lQpacMKHMP4YDlTOAo3l9PpzN6AgHYgG7WhZF
 LmL+J6NR1PVIeK+nrfoB0xEVc072PU06VD8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2qx25v89r7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:50 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 14:46:49 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 9DDFCC07CCD4; Wed, 27 Feb 2019 14:46:47 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION into corresponding FWD
Date:   Wed, 27 Feb 2019 14:46:40 -0800
Message-ID: <20190227224642.1069138-5-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227224642.1069138-1-andriin@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
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
---
 tools/lib/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 6bbb710216e6..53db26d158c9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2255,7 +2255,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
 static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 {
 	struct btf_dedup_node *cand_node;
-	struct btf_type *t;
+	struct btf_type *cand_type, *t;
 	/* if we don't find equivalent type, then we are canonical */
 	__u32 new_id = type_id;
 	__u16 kind;
@@ -2275,6 +2275,10 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 	for_each_dedup_cand(d, h, cand_node) {
 		int eq;
 
+		cand_type = d->btf->types[cand_node->type_id];
+		if (!btf_equal_struct(t, cand_type))
+			continue;
+
 		btf_dedup_clear_hypot_map(d);
 		eq = btf_dedup_is_equiv(d, type_id, cand_node->type_id);
 		if (eq < 0)
-- 
2.17.1

