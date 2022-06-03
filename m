Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075BDC43334
	for <bpf@archiver.kernel.org>; Fri,  3 Jun 2022 01:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiFCB7W (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiFCB7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 21:59:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6BC39696
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 18:59:20 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2530qiLe016101
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 18:59:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dtUFLurAVpC2sjwYufq4sMNqVj3+whNProPCHEfGRkw=;
 b=kSOxSqBw8XnzZxk4BEHHwfcfsaba2rPoZYuAHVH0Ql9YJn7hr+h1iSAq/MLOT5JJAIH2
 jWhU5YQl+8uRH22NQMR4+yg6YijzbGmpJWiPaF7v9eiYpkfgbN2ApxcNTKXgSeNcCYHT
 7Zv0dc98DyzBiuE783lPRlqC0jvQ7gC2ZU0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gf4yy97p8-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 18:59:20 -0700
Received: from twshared24024.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 18:59:18 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 00D8DB299F4A; Thu,  2 Jun 2022 18:59:10 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v4 03/18] libbpf: Fix an error in 64bit relocation value computation
Date:   Thu, 2 Jun 2022 18:59:10 -0700
Message-ID: <20220603015910.1188721-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603015855.1187538-1-yhs@fb.com>
References: <20220603015855.1187538-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fs-IEXl5v_1-VaVglA99KZPyRVHH2Y2S
X-Proofpoint-ORIG-GUID: fs-IEXl5v_1-VaVglA99KZPyRVHH2Y2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the 64bit relocation value in the instruction
is computed as follows:
  __u64 imm =3D insn[0].imm + ((__u64)insn[1].imm << 32)

Suppose insn[0].imm =3D -1 (0xffffffff) and insn[1].imm =3D 1.
With the above computation, insn[0].imm will first sign-extend
to 64bit -1 (0xffffffffFFFFFFFF) and then add 0x1FFFFFFFF,
producing incorrect value 0xFFFFFFFF. The correct value
should be 0x1FFFFFFFF.

Changing insn[0].imm to __u32 first will prevent 64bit sign
extension and fix the issue. Merging high and low 32bit values
also changed from '+' to '|' to be consistent with other
similar occurences in kernel and libbpf.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/relo_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 0dce5644877b..073a54ed7432 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1027,7 +1027,7 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
 			return -EINVAL;
 		}
=20
-		imm =3D insn[0].imm + ((__u64)insn[1].imm << 32);
+		imm =3D (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
 		if (res->validate && imm !=3D orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: go=
t %llu, exp %llu -> %llu\n",
 				prog_name, relo_idx,
--=20
2.30.2

