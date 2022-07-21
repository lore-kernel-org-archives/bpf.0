Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE70C43334
	for <bpf@archiver.kernel.org>; Thu, 21 Jul 2022 02:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGUCta (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Jul 2022 22:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGUCt3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 22:49:29 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531462A69
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 19:49:27 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id AFD2AF3E6F80; Wed, 20 Jul 2022 19:49:14 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: Fix ref_obj_id for dynptr data slices in verifier
Date:   Wed, 20 Jul 2022 19:48:20 -0700
Message-Id: <20220721024821.251231-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a data slice is obtained from a dynptr (through the bpf_dynptr_data =
API),
the ref obj id of the dynptr must be found and then associated with the d=
ata
slice.

The ref obj id of the dynptr must be found *before* the caller saved regs=
 are
reset. Without this fix, the ref obj id tracking is not correct for
dynptrs that are at an offset from the frame pointer.

Please also note that the data slice's ref obj id must be assigned after =
the
ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
zero-marked.

Fixes: 34d4ef5775f7("bpf: Add dynptr data slices");
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c59c3df0fea6..00f9b5a77734 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7341,6 +7341,22 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			}
 		}
 		break;
+	case BPF_FUNC_dynptr_data:
+		/* Find the id of the dynptr we're tracking the reference of.
+		 * We must do this before we reset caller saved regs.
+		 *
+		 * Please note as well that meta.ref_obj_id after the check_func_arg()=
 calls doesn't
+		 * already contain the dynptr ref obj id, since dynptrs are stored on =
the stack.
+		 */
+		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+			if (arg_type_is_dynptr(fn->arg_type[i])) {
+				if (meta.ref_obj_id) {
+					verbose(env, "verifier internal error: multiple refcounted args in =
func\n");
+					return -EFAULT;
+				}
+				meta.ref_obj_id =3D stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
+			}
+		}
 	}
=20
 	if (err)
@@ -7470,20 +7486,8 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D id;
 	} else if (func_id =3D=3D BPF_FUNC_dynptr_data) {
-		int dynptr_id =3D 0, i;
-
-		/* Find the id of the dynptr we're acquiring a reference to */
-		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
-			if (arg_type_is_dynptr(fn->arg_type[i])) {
-				if (dynptr_id) {
-					verbose(env, "verifier internal error: multiple dynptr args in func=
\n");
-					return -EFAULT;
-				}
-				dynptr_id =3D stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
-			}
-		}
 		/* For release_reference() */
-		regs[BPF_REG_0].ref_obj_id =3D dynptr_id;
+		regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
 	}
=20
 	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
--=20
2.30.2

