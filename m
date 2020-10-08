Return-Path: <SRS0=0bGE=DP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E756C433E7
	for <bpf@archiver.kernel.org>; Thu,  8 Oct 2020 00:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8203207EA
	for <bpf@archiver.kernel.org>; Thu,  8 Oct 2020 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602115849;
	bh=FJvQ+d/U21rDOfDUvKqTUK0q5JvPCzb+v85kWWtVYss=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M/c1EBounxofVFGvwGyPuJG668pVghzNzAPpei2Udb1pFXb9tlEl89GwrVYZ9oXSm
	 5BDQi3vN2IkASnihMCsyke40YpzzQOctK6OgtNkNfbzDy99aXx/1aEIZn+qC8KqZAi
	 zTzO+LbzrX2W0LDHZEut4Cauo423OeduXZTriJP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJHAKt convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 7 Oct 2020 20:10:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727261AbgJHAKt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 20:10:49 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09807wHP002200
        for <bpf@vger.kernel.org>; Wed, 7 Oct 2020 17:10:48 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3418t9mpx9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 17:10:48 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 7 Oct 2020 17:10:29 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 300212EC7C0E; Wed,  7 Oct 2020 17:10:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Tony Ambardar <tony.ambardar@gmail.com>
Subject: [PATCH v3 bpf-next 1/4] libbpf: skip CO-RE relocations for not loaded BPF programs
Date:   Wed, 7 Oct 2020 17:10:21 -0700
Message-ID: <20201008001025.292064-2-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201008001025.292064-1-andrii@kernel.org>
References: <20201008001025.292064-1-andrii@kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-07,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=8 clxscore=1034 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=895 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070156
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bypass CO-RE relocations step for BPF programs that are not going to be
loaded. This allows to have BPF programs compiled in and disabled dynamically
if kernel is not supposed to provide enough relocation information. In such
case, there won't be unnecessary warnings about failed relocations.

Fixes: d929758101fc ("libbpf: Support disabling auto-loading BPF programs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index faec389c4849..07d62771472f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5765,6 +5765,11 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 				err = -EINVAL;
 				goto out;
 			}
+			/* no need to apply CO-RE relocation if the program is
+			 * not going to be loaded
+			 */
+			if (!prog->load)
+				continue;
 
 			err = bpf_core_apply_relo(prog, rec, i, obj->btf,
 						  targ_btf, cand_cache);
-- 
2.24.1

