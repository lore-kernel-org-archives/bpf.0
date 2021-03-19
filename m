Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B06C4332B
	for <bpf@archiver.kernel.org>; Fri, 19 Mar 2021 03:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBD764DD2
	for <bpf@archiver.kernel.org>; Fri, 19 Mar 2021 03:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhCSDMz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Mar 2021 23:12:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231864AbhCSDMu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 23:12:50 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12J34Snd029504
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 20:12:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+FwlTZK1j9LgfSFuLiWA531SLG7H/kYuJRz/AkwN104=;
 b=Cj/cWa5tkHMbX8MAw/U6PWC28NL9nS38XNBPqSaDGhDL9E0BwyCOQn8UjC7g92J2DajK
 /fSMSJY0DSFajuJ9rIWIio2+w9rX69UneWxAReYJi3OGhf8zv1rnIhf4FugQe1f6aKmm
 x/1y4A/Z0rugr9GrfaYLmvZz7ClQBB/jaK0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37cefu9jkk-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 20:12:50 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 20:12:46 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F37717A9E59; Thu, 18 Mar 2021 20:12:41 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH bpf-next v2 2/2] bpf: fix bpf_cgroup_storage_set() usage in test_run
Date:   Thu, 18 Mar 2021 20:12:41 -0700
Message-ID: <20210319031241.3709930-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319031231.3707705-1-yhs@fb.com>
References: <20210319031231.3707705-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_19:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=711
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In bpf_test_run(), check the return value of bpf_cgroup_storage_set()
and do bpf_cgroup_storate_unset() properly.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/bpf/test_run.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0abdd67f44b1..4aabf71cd95d 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -106,12 +106,16 @@ static int bpf_test_run(struct bpf_prog *prog, void=
 *ctx, u32 repeat,
=20
 	bpf_test_timer_enter(&t);
 	do {
-		bpf_cgroup_storage_set(storage);
+		ret =3D bpf_cgroup_storage_set(storage);
+		if (ret)
+			break;
=20
 		if (xdp)
 			*retval =3D bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval =3D BPF_PROG_RUN(prog, ctx);
+
+		bpf_cgroup_storage_unset();
 	} while (bpf_test_timer_continue(&t, repeat, &ret, time));
 	bpf_test_timer_leave(&t);
=20
--=20
2.30.2

