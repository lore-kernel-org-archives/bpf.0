Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7CC00140
	for <bpf@archiver.kernel.org>; Fri, 12 Aug 2022 05:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiHLFYh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Aug 2022 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiHLFYf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 01:24:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A555A00E4
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:34 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLSedY032450
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hZGvQPYIDtsNxLbVmfzmqVqDuTF5iehhIOecZNPxwEg=;
 b=IOMHHEZ/ZjeB6wg2p3xbG5MGSwmSvpXfi9V0eFFx0dAmHLjcFu41p8TnLDT38Cq6xhBv
 hgL0N/tVOMsUqveaNPH5ZB3nRdYgJ5ajpd67l2aVnuqQdQJPn4yqNk2SyOPYopHkatTN
 Pfp6GXydtJg1+1IJsiMTxz0SKCAfdmY1WKw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9qfj1t2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:33 -0700
Received: from twshared0646.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 22:24:31 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id E866BDF8C41C; Thu, 11 Aug 2022 22:24:29 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 2/6] bpf: x86: Rename stack_size to regs_off in {save,restore}_regs()
Date:   Thu, 11 Aug 2022 22:24:29 -0700
Message-ID: <20220812052429.522618-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812052419.520522-1-yhs@fb.com>
References: <20220812052419.520522-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SuCfszpdxhE_QQY9-B_YnYUidv4Wqk9T
X-Proofpoint-ORIG-GUID: SuCfszpdxhE_QQY9-B_YnYUidv4Wqk9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_03,2022-08-11_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename argument 'stack_size' to 'regs_off' in save_regs() and
restore_regs() since in reality 'stack_size' represents a particular
stack offset and 'regs_off' is the one in the caller argument.
Leter, another stack offset will be added to these two functions
for saving and restoring struct argument values.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f6c1c51d99..2657b58001cf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1749,7 +1749,7 @@ st:			if (is_imm8(insn->off))
 }
=20
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_=
args,
-		      int stack_size)
+		      int regs_off)
 {
 	int i;
 	/* Store function arguments to stack.
@@ -1761,11 +1761,11 @@ static void save_regs(const struct btf_func_model=
 *m, u8 **prog, int nr_args,
 		emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
 			 BPF_REG_FP,
 			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 -(stack_size - i * 8));
+			 -(regs_off - i * 8));
 }
=20
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int =
nr_args,
-			 int stack_size)
+			 int regs_off)
 {
 	int i;
=20
@@ -1778,7 +1778,7 @@ static void restore_regs(const struct btf_func_mode=
l *m, u8 **prog, int nr_args,
 		emit_ldx(prog, bytes_to_bpf_size(m->arg_size[i]),
 			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 BPF_REG_FP,
-			 -(stack_size - i * 8));
+			 -(regs_off - i * 8));
 }
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
--=20
2.30.2

