Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D84C433FE
	for <bpf@archiver.kernel.org>; Thu, 26 May 2022 18:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiEZSzH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 26 May 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbiEZSy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:54:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103DC8BD1
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:54:55 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QInwKv000668
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:54:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3kRFnd9BWqNCBsv6M9a7OY5UB2/aHF4x70HuKHPeawU=;
 b=i4tY3zM4JLY9dzIITEwNnG7fPp42TWS+0s6ATUSwiZqXO4KE3ugTsujQsfV55F/xUKou
 qjnZ3TEWAO/dYrSBB/k7f6tKnRLgUgStmavvF8C9iV/Ic85ZqfsUmxVjwe5f66G7X79N
 fLkNC1NuCZKBeJ6gMdhyPZfK0iGa0vK4Fzc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gacgx9an6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 11:54:55 -0700
Received: from twshared26317.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 26 May 2022 11:54:53 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2C9B3AD83CD9; Thu, 26 May 2022 11:54:48 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v3 03/18] libbpf: Fix an error in 64bit relocation value computation
Date:   Thu, 26 May 2022 11:54:48 -0700
Message-ID: <20220526185448.2547263-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526185432.2545879-1-yhs@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Wlccacw5kVlm4XtRG-zDqEl1y8SvGt8z
X-Proofpoint-ORIG-GUID: Wlccacw5kVlm4XtRG-zDqEl1y8SvGt8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_10,2022-05-25_02,2022-02-23_01
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
index aea16343a8f1..78b16cda86fa 100644
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

