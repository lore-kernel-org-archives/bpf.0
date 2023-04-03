Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0676CC76188
	for <bpf@archiver.kernel.org>; Mon,  3 Apr 2023 17:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDCRbp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjDCRbp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 13:31:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEC81BE3
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 10:31:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333HKheB031098
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 10:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=aQVGZe4fmLrrAgHbNPdkCK1YuzoboeyDuCUqRyRT6NE=;
 b=opr/oI3yv83kO/j2HY1iT36Ar9UHtLY03SLMgWbJ0p/B3bUifGHkTQDuGbrU9L5t3Buc
 MKdZ9uFQqj7PnHUviAZLKJgR3KMt5jKpGBcAyjsnPNM0SL4+Asaf9JCdXP3KucbvrhWU
 G4kUi0zJ7yz1bdnV/Z43FUDAgjtk5qVn51A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pr0m71995-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 10:31:42 -0700
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 10:31:35 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 4EC381B111653; Mon,  3 Apr 2023 10:31:26 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf] bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call
Date:   Mon, 3 Apr 2023 10:31:25 -0700
Message-ID: <20230403173125.1056883-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: To4_Yymd6SDWgplaKJHqtTpfDIqkOxO9
X-Proofpoint-ORIG-GUID: To4_Yymd6SDWgplaKJHqtTpfDIqkOxO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_14,2023-04-03_03,2023-02-09_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_obj_drop_impl has a void return type. In check_kfunc_call, the "else
if" which sets kptr_struct_meta for bpf_obj_drop_impl is
surrounded by a larger if statement which checks btf_type_is_ptr. As a
result:

  * The bpf_obj_drop_impl-specific code will never execute
  * The btf_struct_meta input to bpf_obj_drop is always NULL
  * bpf_obj_drop_impl will always see a NULL btf_record when called
    from BPF program, and won't call bpf_obj_free_fields
  * program-allocated kptrs which have fields that should be cleaned up
    by bpf_obj_free_fields may instead leak resources

This patch adds a btf_type_is_void branch to the larger if and moves
special handling for bpf_obj_drop_impl there, fixing the issue.

Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
I can send a version of this patch which applies on bpf-next as well,
but think this makes sense in bpf as the issue exists there too.

 kernel/bpf/verifier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..753f652914da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9965,10 +9965,6 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 				env->insn_aux_data[insn_idx].obj_new_size =3D ret_t->size;
 				env->insn_aux_data[insn_idx].kptr_struct_meta =3D
 					btf_find_struct_meta(ret_btf, ret_btf_id);
-			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_imp=
l]) {
-				env->insn_aux_data[insn_idx].kptr_struct_meta =3D
-					btf_find_struct_meta(meta.arg_obj_drop.btf,
-							     meta.arg_obj_drop.btf_id);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_fro=
nt] ||
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
@@ -10053,7 +10049,15 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
=20
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].i=
d)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
-	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
+	} else if (btf_type_is_void(t)) {
+		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_=
set, meta.func_id)) {
+			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
+				env->insn_aux_data[insn_idx].kptr_struct_meta =3D
+					btf_find_struct_meta(meta.arg_obj_drop.btf,
+							     meta.arg_obj_drop.btf_id);
+			}
+		}
+	}
=20
 	nargs =3D btf_type_vlen(func_proto);
 	args =3D (const struct btf_param *)(func_proto + 1);
--=20
2.34.1

