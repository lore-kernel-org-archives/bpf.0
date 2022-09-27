Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D333C6FA82
	for <bpf@archiver.kernel.org>; Tue, 27 Sep 2022 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiI0S6n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Sep 2022 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiI0S6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:58:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E381DB548
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:42 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RI0GAm015702
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i01NmLPIFOUlWCPYtyI7PCkDUgAVJGEMBgBQ2uTJNrw=;
 b=NZAPFBMa1R6bXp9+W0WlMcffWSpI2r9yo6PILK5/EsW6t2hOSsDhFLpUqt4LiUjL0IJT
 ytAA0sjQ+G5QDXlGX+9PvlPr41nWNdq8naKzFFUQHBoe5txLDpSv39o9Ncfhb/HaLuUa
 fhaIlx1dGLPx/Wu62i+Hdx6uFrswRT3TU9k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jv62ngf5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:42 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 11:58:40 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id DB0FE10B4B678; Tue, 27 Sep 2022 11:58:34 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v3 3/3] bpf: add selftests for lsh, rsh, arsh with reg operand
Date:   Tue, 27 Sep 2022 11:58:01 -0700
Message-ID: <20220927185801.1824838-4-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927185801.1824838-1-jmeng@fb.com>
References: <7437e1cb-325c-fc86-37f6-3422c085007d@iogearbox.net>
 <20220927185801.1824838-1-jmeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3W0DzlH9ZrMF-TczappRIs52ff6dBSCC
X-Proofpoint-GUID: 3W0DzlH9ZrMF-TczappRIs52ff6dBSCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_09,2022-09-27_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current tests cover only shifts with an immediate as the source
operand/shift counts; add a new test case to cover register operand.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 tools/testing/selftests/bpf/verifier/jit.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/s=
elftests/bpf/verifier/jit.c
index 79021c30e51e..8bf37e5207f1 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -20,6 +20,30 @@
 	.result =3D ACCEPT,
 	.retval =3D 2,
 },
+{
+	"jit: lsh, rsh, arsh by reg",
+	.insns =3D {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_MOV64_IMM(BPF_REG_4, 1),
+	BPF_MOV64_IMM(BPF_REG_1, 0xff),
+	BPF_ALU64_REG(BPF_LSH, BPF_REG_1, BPF_REG_0),
+	BPF_ALU32_REG(BPF_LSH, BPF_REG_1, BPF_REG_4),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_4),
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_1),
+	BPF_ALU32_REG(BPF_RSH, BPF_REG_4, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0xff, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ARSH, BPF_REG_4, BPF_REG_4),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D ACCEPT,
+	.retval =3D 2,
+},
 {
 	"jit: mov32 for ldimm64, 1",
 	.insns =3D {
--=20
2.30.2

