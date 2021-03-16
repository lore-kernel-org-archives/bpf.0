Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD525C433E0
	for <bpf@archiver.kernel.org>; Tue, 16 Mar 2021 01:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3EC64F76
	for <bpf@archiver.kernel.org>; Tue, 16 Mar 2021 01:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhCPBO7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Mar 2021 21:14:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234213AbhCPBOn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Mar 2021 21:14:43 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12G1CkJM020955
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 18:14:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2U63qfE7D12CslCQUPY59lxp/tlir6gd3bNCivSiCxQ=;
 b=Xh7ikHpuVYtIiIgnlVUuacCrVqH7Vu/sj5SuhgpmYQGTHYYT12eUw8++4boClUHDcTMA
 CX7zhg1ldBzueII1wtnDc8N6hjNWaZrKUv/pkchdSojho825n6eJR+DFF02Py/OA9ngK
 p2h8M7+Si2QCTBARl+rF/Gl7IBfzxGF02jw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 378sxtv4x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Mar 2021 18:14:42 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 18:14:42 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id DB7462942B57; Mon, 15 Mar 2021 18:14:38 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next 10/15] libbpf: Rename RELO_EXTERN to RELO_EXTERN_VAR
Date:   Mon, 15 Mar 2021 18:14:38 -0700
Message-ID: <20210316011438.4179031-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316011336.4173585-1-kafai@fb.com>
References: <20210316011336.4173585-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_15:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=797 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch renames RELO_EXTERN to RELO_EXTERN_VAR.
It is to avoid the confusion with a later patch adding
RELO_EXTERN_FUNC.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8355b786b3db..8f924aece736 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -189,7 +189,7 @@ enum reloc_type {
 	RELO_LD64,
 	RELO_CALL,
 	RELO_DATA,
-	RELO_EXTERN,
+	RELO_EXTERN_VAR,
 	RELO_SUBPROG_ADDR,
 };
=20
@@ -3463,7 +3463,7 @@ static int bpf_program__record_reloc(struct bpf_pro=
gram *prog,
 		}
 		pr_debug("prog '%s': found extern #%d '%s' (sym %d) for insn #%u\n",
 			 prog->name, i, ext->name, ext->sym_idx, insn_idx);
-		reloc_desc->type =3D RELO_EXTERN;
+		reloc_desc->type =3D RELO_EXTERN_VAR;
 		reloc_desc->insn_idx =3D insn_idx;
 		reloc_desc->sym_off =3D i; /* sym_off stores extern index */
 		return 0;
@@ -6226,7 +6226,7 @@ bpf_object__relocate_data(struct bpf_object *obj, s=
truct bpf_program *prog)
 			insn[0].imm =3D obj->maps[relo->map_idx].fd;
 			relo->processed =3D true;
 			break;
-		case RELO_EXTERN:
+		case RELO_EXTERN_VAR:
 			ext =3D &obj->externs[relo->sym_off];
 			if (ext->type =3D=3D EXT_KCFG) {
 				insn[0].src_reg =3D BPF_PSEUDO_MAP_VALUE;
--=20
2.30.2

