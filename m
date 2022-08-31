Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0171DECAAD1
	for <bpf@archiver.kernel.org>; Wed, 31 Aug 2022 15:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiHaP1E (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiHaP1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 11:27:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26ED7D24
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:02 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEh40O031368
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=McXEiJptNjPYOdgh7RLsNyGLsvK5M/BUrqqZzx6Ikeo=;
 b=A5DhkRA8EkDkHyUeo1WoM1xfINXJYYVpi+vz8qEjTN06RvY7o1y3HlThs7ernwvyv/+F
 BPc1jaUe+YXmRckHq82myiFP9UgTx+4gCBJSm7VprS+EAp82r+CXcNRYX1niFo6rKxW7
 7qRuamEt/D2prfNqag7T8sZ1z62lV6raHhU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9a6jahy7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:27:02 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 08:27:01 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5A525ECDECF2; Wed, 31 Aug 2022 08:26:57 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 3/8] bpf: Update descriptions for helpers bpf_get_func_arg[_cnt]()
Date:   Wed, 31 Aug 2022 08:26:57 -0700
Message-ID: <20220831152657.2078805-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831152641.2077476-1-yhs@fb.com>
References: <20220831152641.2077476-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4GjOD3ifS6oAmVpTLSkiGihv5_gel-bT
X-Proofpoint-GUID: 4GjOD3ifS6oAmVpTLSkiGihv5_gel-bT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now instead of the number of arguments, the number of registers
holding argument values are stored in trampoline. Update
the description of bpf_get_func_arg[_cnt]() helpers. Previous
programs without struct arguments should continue to work
as usual.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/bpf.h       | 9 +++++----
 tools/include/uapi/linux/bpf.h | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 962960a98835..f9f43343ef93 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5079,12 +5079,12 @@ union bpf_attr {
  *
  * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
  *	Description
- *		Get **n**-th argument (zero based) of the traced function (for traci=
ng programs)
+ *		Get **n**-th argument register (zero based) of the traced function (=
for tracing programs)
  *		returned in **value**.
  *
  *	Return
  *		0 on success.
- *		**-EINVAL** if n >=3D arguments count of traced function.
+ *		**-EINVAL** if n >=3D argument register count of traced function.
  *
  * long bpf_get_func_ret(void *ctx, u64 *value)
  *	Description
@@ -5097,10 +5097,11 @@ union bpf_attr {
  *
  * long bpf_get_func_arg_cnt(void *ctx)
  *	Description
- *		Get number of arguments of the traced function (for tracing programs=
).
+ *		Get number of registers of the traced function (for tracing programs=
) where
+ *		function arguments are stored in these registers.
  *
  *	Return
- *		The number of arguments of the traced function.
+ *		The number of argument registers of the traced function.
  *
  * int bpf_get_retval(void)
  *	Description
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index f4ba82a1eace..f13fa71822f4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5079,12 +5079,12 @@ union bpf_attr {
  *
  * long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
  *	Description
- *		Get **n**-th argument (zero based) of the traced function (for traci=
ng programs)
+ *		Get **n**-th argument register (zero based) of the traced function (=
for tracing programs)
  *		returned in **value**.
  *
  *	Return
  *		0 on success.
- *		**-EINVAL** if n >=3D arguments count of traced function.
+ *		**-EINVAL** if n >=3D argument register count of traced function.
  *
  * long bpf_get_func_ret(void *ctx, u64 *value)
  *	Description
@@ -5097,10 +5097,11 @@ union bpf_attr {
  *
  * long bpf_get_func_arg_cnt(void *ctx)
  *	Description
- *		Get number of arguments of the traced function (for tracing programs=
).
+ *		Get number of registers of the traced function (for tracing programs=
) where
+ *		function arguments are stored in these registers.
  *
  *	Return
- *		The number of arguments of the traced function.
+ *		The number of argument registers of the traced function.
  *
  * int bpf_get_retval(void)
  *	Description
--=20
2.30.2

