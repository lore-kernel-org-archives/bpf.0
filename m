Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FD4C433DB
	for <bpf@archiver.kernel.org>; Sat, 27 Mar 2021 04:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4892D61A02
	for <bpf@archiver.kernel.org>; Sat, 27 Mar 2021 04:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhC0EZk convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 27 Mar 2021 00:25:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41074 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhC0EZd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 27 Mar 2021 00:25:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12R4OsMQ014060
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 21:25:10 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37hj0kbg15-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 21:25:10 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 26 Mar 2021 21:25:09 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 53B432ED2F0C; Fri, 26 Mar 2021 21:25:03 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: fix memory leak when emitting final btf_ext
Date:   Fri, 26 Mar 2021 21:25:02 -0700
Message-ID: <20210327042502.969745-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1ZBfLuO77-nfmF2qr3YDUoGVLg1YEXaW
X-Proofpoint-ORIG-GUID: 1ZBfLuO77-nfmF2qr3YDUoGVLg1YEXaW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-27_01:2021-03-26,2021-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=846 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103270032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Free temporary allocated memory used to construct finalized .BTF.ext data.
Found by Coverity static analysis on libbpf's Github repo.

Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/linker.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index a29d62ff8041..46b16cbdcda3 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1906,8 +1906,10 @@ static int finalize_btf_ext(struct bpf_linker *linker)
 			struct dst_sec *sec = &linker->secs[i];
 
 			sz = emit_btf_ext_data(linker, cur, sec->sec_name, &sec->func_info);
-			if (sz < 0)
-				return sz;
+			if (sz < 0) {
+				err = sz;
+				goto out;
+			}
 
 			cur += sz;
 		}
@@ -1921,8 +1923,10 @@ static int finalize_btf_ext(struct bpf_linker *linker)
 			struct dst_sec *sec = &linker->secs[i];
 
 			sz = emit_btf_ext_data(linker, cur, sec->sec_name, &sec->line_info);
-			if (sz < 0)
-				return sz;
+			if (sz < 0) {
+				err = sz;
+				goto out;
+			}
 
 			cur += sz;
 		}
@@ -1936,8 +1940,10 @@ static int finalize_btf_ext(struct bpf_linker *linker)
 			struct dst_sec *sec = &linker->secs[i];
 
 			sz = emit_btf_ext_data(linker, cur, sec->sec_name, &sec->core_relo_info);
-			if (sz < 0)
-				return sz;
+			if (sz < 0) {
+				err = sz;
+				goto out;
+			}
 
 			cur += sz;
 		}
@@ -1948,8 +1954,10 @@ static int finalize_btf_ext(struct bpf_linker *linker)
 	if (err) {
 		linker->btf_ext = NULL;
 		pr_warn("failed to parse final .BTF.ext data: %d\n", err);
-		return err;
+		goto out;
 	}
 
-	return 0;
+out:
+	free(data);
+	return err;
 }
-- 
2.30.2

