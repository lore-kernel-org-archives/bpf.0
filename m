Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB266C4361A
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 23:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD85022519
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 23:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLDXU7 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 4 Dec 2020 18:20:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5112 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbgLDXU6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 18:20:58 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4NJkE3005754
        for <bpf@vger.kernel.org>; Fri, 4 Dec 2020 15:20:17 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 357quetp02-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 15:20:16 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 15:20:10 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 8CB582ECAB80; Fri,  4 Dec 2020 15:20:03 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf] tools/bpftool: fix PID fetching with a lot of results
Date:   Fri, 4 Dec 2020 15:20:01 -0800
Message-ID: <20201204232002.3589803-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_13:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of having so many PID results that they don't fit into a singe page
(4096) bytes, bpftool will erroneously conclude that it got corrupted data due
to 4096 not being a multiple of struct pid_iter_entry, so the last entry will
be partially truncated. Fix this by sizing the buffer to fit exactly N entries
with no truncation in the middle of record.

Fixes: d53dee3fe013 ("tools/bpftool: Show info for processes holding BPF map/prog/link/btf FDs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/pids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index df7d8ec76036..477e55d59c34 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -89,9 +89,9 @@ libbpf_print_none(__maybe_unused enum libbpf_print_level level,
 
 int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type type)
 {
-	char buf[4096];
-	struct pid_iter_bpf *skel;
 	struct pid_iter_entry *e;
+	char buf[4096 / sizeof(*e) * sizeof(*e)];
+	struct pid_iter_bpf *skel;
 	int err, ret, fd = -1, i;
 	libbpf_print_fn_t default_print;
 
-- 
2.24.1

