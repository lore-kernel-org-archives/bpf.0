Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C501FC4338F
	for <bpf@archiver.kernel.org>; Fri, 23 Jul 2021 22:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3F060E0C
	for <bpf@archiver.kernel.org>; Fri, 23 Jul 2021 22:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhGWV4t (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:56:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41826 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231742AbhGWV4t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Jul 2021 17:56:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NMYkS6009630
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 15:37:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hF+eKeMWlIXUprKWKBvFjkn16h4yw5GBRjjNsrfdwG8=;
 b=BGpb827RjZH0jvvDjmty+wWyXNNHnx1RJNO11oM3dRv/5Ozk1QAJ6QJa4nlMoVu76Ipu
 NlV1ldBlNdFRxFzysfSBZIrzJ2glUFXbcHFyQLEH7peyZam9vQu8piBoYC017JPyFoHw
 T+UsxScAb1N8/6MEkdldcrFe8i6PE1l7x4o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39y99uae38-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 15:37:21 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 15:37:16 -0700
Received: by devvm2776.vll0.facebook.com (Postfix, from userid 364226)
        id 6A1615E97B9; Fri, 23 Jul 2021 15:37:10 -0700 (PDT)
From:   Evgeniy Litvinenko <evgeniyl@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
Subject: [PATCH bpf-next] selftests/bpf: Document vmtest dependencies
Date:   Fri, 23 Jul 2021 15:36:45 -0700
Message-ID: <20210723223645.907802-1-evgeniyl@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3wQ9r3Oo2jixTTPTGHsmvvAky6qKkPWt
X-Proofpoint-ORIG-GUID: 3wQ9r3Oo2jixTTPTGHsmvvAky6qKkPWt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_13:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a list of vmtest script dependencies to make it easier for new
contributors to get going (I discovered those by trial and error).

Signed-off-by: Evgeniy Litvinenko <evgeniyl@fb.com>
---
 tools/testing/selftests/bpf/README.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selft=
ests/bpf/README.rst
index 8deec1ca9150..e47786e93159 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -19,6 +19,13 @@ the CI. It builds the kernel (without overwriting your=
 existing Kconfig), recomp
 bpf selftests, runs them (by default ``tools/testing/selftests/bpf/test_=
progs``) and
 saves the resulting output (by default in ``~/.bpf_selftests``).
=20
+Script dependencies:
+- clang
+- qemu
+- pahole
+- docutils (for ``rst2man``)
+- libcap-devel
+
 For more information on about using the script, run:
=20
 .. code-block:: console
--=20
2.30.2

