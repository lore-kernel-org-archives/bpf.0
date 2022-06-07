Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC44C43334
	for <bpf@archiver.kernel.org>; Tue,  7 Jun 2022 06:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiFGG1G (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiFGG1G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:27:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333CC9EC9
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:27:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257659pK015396
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:27:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sp3U1HSD/aJThxsm3jYAyPeKxudSj1m1ADsCx0XKWLs=;
 b=pWStq1Hwb4474nGn6kzlPFk4z+xyi3PbbFAy/AbKEQwYxNMN54+1VzVF+wbgwB4b7oK9
 Mc3XRaMakAXK2xM8K7amp/q1xr6JnGK5tqT91x9Bdk6meI5TAuresLScA/OEoPdtUraC
 ENZX8To3B/CIs/v4/GCbCMwkrbIm4udRKmM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gj13cg2gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:27:05 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:27:03 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id EFF7FB5211D5; Mon,  6 Jun 2022 23:26:57 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 12/17] selftests/bpf: Fix selftests failure
Date:   Mon, 6 Jun 2022 23:26:57 -0700
Message-ID: <20220607062657.3723737-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aCtT12v8g33N0DUTL2fKCM1ckt1HJSdj
X-Proofpoint-ORIG-GUID: aCtT12v8g33N0DUTL2fKCM1ckt1HJSdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kflag is supported now for BTF_KIND_ENUM.
So remove the test which tests verifier failure
due to existence of kflag.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index ba5bde53d418..8e068e06b3e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -2896,26 +2896,6 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid btf_info kind_flag",
 },
=20
-{
-	.descr =3D "invalid enum kind_flag",
-	.raw_types =3D {
-		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ENUM, 1, 1), 4),	/* [2] */
-		BTF_ENUM_ENC(NAME_TBD, 0),
-		BTF_END_RAW,
-	},
-	BTF_STR_SEC("\0A"),
-	.map_type =3D BPF_MAP_TYPE_ARRAY,
-	.map_name =3D "enum_type_check_btf",
-	.key_size =3D sizeof(int),
-	.value_size =3D sizeof(int),
-	.key_type_id =3D 1,
-	.value_type_id =3D 1,
-	.max_entries =3D 4,
-	.btf_load_err =3D true,
-	.err_str =3D "Invalid btf_info kind_flag",
-},
-
 {
 	.descr =3D "valid fwd kind_flag",
 	.raw_types =3D {
--=20
2.30.2

