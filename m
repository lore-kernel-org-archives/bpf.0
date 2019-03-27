Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E832C4360F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4092082F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbfC0FAP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:00:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732266AbfC0FAO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Mar 2019 01:00:14 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2R4rEns007989
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 22:00:13 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rfp593h5q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 22:00:13 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 26 Mar 2019 22:00:12 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 6322986122F; Tue, 26 Mar 2019 22:00:12 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <acme@kernel.org>,
        <kernel-team@fb.com>, <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 1/2] libbpf: fix btf_dedup equivalence check handling of different kinds
Date:   Tue, 26 Mar 2019 22:00:06 -0700
Message-ID: <20190327050007.2419746-2-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327050007.2419746-1-andrii.nakryiko@gmail.com>
References: <20190327050007.2419746-1-andrii.nakryiko@gmail.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

btf_dedup_is_equiv() used to compare btf_type->info fields, before doing
kind-specific equivalence check. This comparsion implicitly verified
that candidate and canonical types are of the same kind. With enum fwd
resolution logic this check couldn't be done generically anymore, as for
enums info contains vlen, which differs between enum fwd and
fully-defined enum, so this check was subsumed by kind-specific
equivalence checks.

This change caused btf_dedup_is_equiv() to let through VOID vs other
types check to reach switch, which was never meant to be handing VOID
kind, as VOID kind is always pre-resolved to itself and is only
equivalent to itself, which is checked early in btf_dedup_is_equiv().

This change adds back BTF kind equality check in place of more generic
btf_type->info check, still defering further kind-specific checks to
a per-kind switch.

Fixes: 9768095ba97c ("btf: resolve enum fwds in btf_dedup")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 87e3020ac1bc..cf119c9b6f27 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2107,6 +2107,9 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return fwd_kind == real_kind;
 	}
 
+	if (cand_kind != canon_kind)
+		return 0;
+
 	switch (cand_kind) {
 	case BTF_KIND_INT:
 		return btf_equal_int(cand_type, canon_type);
-- 
2.17.1

