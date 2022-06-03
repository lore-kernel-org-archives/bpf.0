Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBEC43334
	for <bpf@archiver.kernel.org>; Fri,  3 Jun 2022 01:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiFCB7r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbiFCB7r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 21:59:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A939696
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 18:59:46 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2530qxTV022147
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 18:59:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=o2hlnjCdwzIKFCAUI9mOsWpoqt0WDheZVAyYrF8Fx3E=;
 b=K90wyVWl44kT8r88jzkokl+sQER07lWA7WSm2orLhFW3Y+ciWzGQEwNlQ4yelKG9PE5s
 8kt3pSP10c3u5xdc7a7REd91rEdLNAlkqHaSP5s8hRpYU1CSXfWukaGiz3H8PQsRgcqF
 mTo+yD+kGzeTwevb7tT3AFrmSkEESFMqI/E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge5vcvs2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 18:59:46 -0700
Received: from twshared17349.03.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 18:59:45 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 7553BB299F8E; Thu,  2 Jun 2022 18:59:42 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 09/18] libbpf: Add enum64 support for bpf linking
Date:   Thu, 2 Jun 2022 18:59:42 -0700
Message-ID: <20220603015942.1191162-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603015855.1187538-1-yhs@fb.com>
References: <20220603015855.1187538-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9XZOtASqCf_nzM5cASzJ3sbvk-u-UGyw
X-Proofpoint-ORIG-GUID: 9XZOtASqCf_nzM5cASzJ3sbvk-u-UGyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_ENUM64 support for bpf linking, which is
very similar to BTF_KIND_ENUM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/linker.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 9aa016fb55aa..979b150affb9 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1340,6 +1340,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
me, bool exact,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_FWD:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
@@ -1362,6 +1363,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
me, bool exact,
 	case BTF_KIND_INT:
 	case BTF_KIND_FLOAT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		/* ignore encoding for int and enum values for enum */
 		if (t1->size !=3D t2->size) {
 			pr_warn("global '%s': incompatible %s '%s' size %u and %u\n",
--=20
2.30.2

