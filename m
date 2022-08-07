Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6FBC19F2A
	for <bpf@archiver.kernel.org>; Sun,  7 Aug 2022 17:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiHGRv3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 7 Aug 2022 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Aug 2022 13:51:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD4360C3
        for <bpf@vger.kernel.org>; Sun,  7 Aug 2022 10:51:27 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277EkQOc012001
        for <bpf@vger.kernel.org>; Sun, 7 Aug 2022 10:51:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FtcTkn3LrWRN7wtepF2RfbXRfi33ZXDmkZfqK4+clLA=;
 b=pmA6GTLfpN6vIqvS7SSPt2CTSpWN02iUf7njefJc51JOGF2ExiqOA//UeEXp5JEnyoZA
 iqiKXQCdVc30pJe6/tQMHbLdMcL5TGV0LmbtkbCW20eOer+kqjEdOb6XOW/2oTAby3Jk
 +B6TquviYVN94ghZ7YjgMLVxLL15qwo9R18= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsp4uwgdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Aug 2022 10:51:26 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 10:51:25 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 7D772DC759A6; Sun,  7 Aug 2022 10:51:16 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 1/3] bpf: Always return corresponding btf_type in __get_type_size()
Date:   Sun, 7 Aug 2022 10:51:16 -0700
Message-ID: <20220807175116.4179242-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220807175111.4178812-1-yhs@fb.com>
References: <20220807175111.4178812-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FiII6U7rBFfSXvYj2yDmfszfQzf-aNBk
X-Proofpoint-ORIG-GUID: FiII6U7rBFfSXvYj2yDmfszfQzf-aNBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_11,2022-08-05_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently in funciton __get_type_size(), the corresponding
btf_type is returned only in invalid cases. Let us always
return btf_type regardless of valid or invalid cases.
Such a new functionality will be used in subsequent patches.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7e64447659f3..8119dc3994db 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5864,26 +5864,25 @@ bool btf_struct_ids_match(struct bpf_verifier_log=
 *log,
 }
=20
 static int __get_type_size(struct btf *btf, u32 btf_id,
-			   const struct btf_type **bad_type)
+			   const struct btf_type **ret_type)
 {
 	const struct btf_type *t;
=20
+	*ret_type =3D btf_type_by_id(btf, 0);
 	if (!btf_id)
 		/* void */
 		return 0;
 	t =3D btf_type_by_id(btf, btf_id);
 	while (t && btf_type_is_modifier(t))
 		t =3D btf_type_by_id(btf, t->type);
-	if (!t) {
-		*bad_type =3D btf_type_by_id(btf, 0);
+	if (!t)
 		return -EINVAL;
-	}
+	*ret_type =3D t;
 	if (btf_type_is_ptr(t))
 		/* kernel size of pointer. Not BPF's size of pointer*/
 		return sizeof(void *);
 	if (btf_type_is_int(t) || btf_is_any_enum(t))
 		return t->size;
-	*bad_type =3D t;
 	return -EINVAL;
 }
=20
--=20
2.30.2

