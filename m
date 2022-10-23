Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5AAECAAA1
	for <bpf@archiver.kernel.org>; Sun, 23 Oct 2022 18:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJWSFb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 23 Oct 2022 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJWSFa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 14:05:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D395A4C600
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:27 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29N7cMjP010813
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NUCMZhBtdEFob4Yy2+IoIDADd3grxFGmLtCe9yP2X0I=;
 b=AoyWmTo4318mwakub2Z845/BFVW0PUalOPg3eaSQSGE1Y84FiGjQ34+zitLb+YUazhCV
 eeAn4Gv/Pikj26TkRTKguegv8P1MvP0qo0RDK22llWeUcSCBgueaQn8rmUQ47otN/OIi
 oa2TxgNkLbOaG/o1BYoGB3/1F10LBdl7OJY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kce7qu582-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 11:05:27 -0700
Received: from twshared9269.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 23 Oct 2022 11:05:26 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6391E111596F7; Sun, 23 Oct 2022 11:05:19 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 1/7] bpf: Make struct cgroup btf id global
Date:   Sun, 23 Oct 2022 11:05:19 -0700
Message-ID: <20221023180519.2858371-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221023180514.2857498-1-yhs@fb.com>
References: <20221023180514.2857498-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GO5eKF_F6U1BVRGipUUmthocr_63nEIQ
X-Proofpoint-GUID: GO5eKF_F6U1BVRGipUUmthocr_63nEIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make struct cgroup btf id global so later patch can reuse
the same btf id.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/btf_ids.h  | 1 +
 kernel/bpf/cgroup_iter.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 2aea877d644f..c9744efd202f 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -265,5 +265,6 @@ MAX_BTF_TRACING_TYPE,
 };
=20
 extern u32 btf_tracing_ids[];
+extern u32 bpf_cgroup_btf_id[];
=20
 #endif
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 0d200a993489..c6ffc706d583 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -157,7 +157,7 @@ static const struct seq_operations cgroup_iter_seq_op=
s =3D {
 	.show   =3D cgroup_iter_seq_show,
 };
=20
-BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
=20
 static int cgroup_iter_seq_init(void *priv, struct bpf_iter_aux_info *au=
x)
 {
--=20
2.30.2

