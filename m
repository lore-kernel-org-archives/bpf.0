Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC0C432C3
	for <bpf@archiver.kernel.org>; Tue, 12 Jan 2021 07:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E4822E01
	for <bpf@archiver.kernel.org>; Tue, 12 Jan 2021 07:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404034AbhALH4W convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 12 Jan 2021 02:56:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392150AbhALH4S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 02:56:18 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C7kNbP027640
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 23:55:37 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ywdusa71-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 23:55:37 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 23:55:34 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 131372ECD646; Mon, 11 Jan 2021 23:55:30 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hao Luo <haoluo@google.com>, kernel test robot <lkp@intel.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v3 bpf-next 3/7] bpf: declare __bpf_free_used_maps() unconditionally
Date:   Mon, 11 Jan 2021 23:55:16 -0800
Message-ID: <20210112075520.4103414-4-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210112075520.4103414-1-andrii@kernel.org>
References: <20210112075520.4103414-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_03:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=800
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1034 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__bpf_free_used_maps() is always defined in kernel/bpf/core.c, while
include/linux/bpf.h is guarding it behind CONFIG_BPF_SYSCALL. Move it out of
that guard region and fix compiler warning.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: a2ea07465c8d ("bpf: Fix missing prog untrack in release_maps")
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ef9309604b3e..6e585dbc10df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1206,8 +1206,6 @@ void bpf_prog_sub(struct bpf_prog *prog, int i);
 void bpf_prog_inc(struct bpf_prog *prog);
 struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
-void __bpf_free_used_maps(struct bpf_prog_aux *aux,
-			  struct bpf_map **used_maps, u32 len);
 
 void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
 void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
@@ -1676,6 +1674,9 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
 	return bpf_prog_get_type_dev(ufd, type, false);
 }
 
+void __bpf_free_used_maps(struct bpf_prog_aux *aux,
+			  struct bpf_map **used_maps, u32 len);
+
 bool bpf_prog_get_ok(struct bpf_prog *, enum bpf_prog_type *, bool);
 
 int bpf_prog_offload_compile(struct bpf_prog *prog);
-- 
2.24.1

