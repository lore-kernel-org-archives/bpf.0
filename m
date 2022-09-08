Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A6ECAAD3
	for <bpf@archiver.kernel.org>; Thu,  8 Sep 2022 00:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIHAKK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIHAKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:10:08 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1994C7CB62
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:10:07 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 4400511703780; Wed,  7 Sep 2022 17:07:26 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 2/8] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
Date:   Wed,  7 Sep 2022 17:02:48 -0700
Message-Id: <20220908000254.3079129-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908000254.3079129-1-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two new helper functions: bpf_dynptr_trim and bpf_dynptr_advance.

bpf_dynptr_trim decreases the size of a dynptr by the specified
number of bytes (offset remains the same). bpf_dynptr_advance advances
the offset of the dynptr by the specified number of bytes (size
decreases correspondingly).

One example where trimming / advancing the dynptr may useful is for
hashing. If the dynptr points to a larger struct, it is possible to hash
an individual field within the struct through dynptrs by using
bpf_dynptr_advance+trim.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 16 +++++++++
 kernel/bpf/helpers.c           | 63 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 16 +++++++++
 3 files changed, 95 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cce3356765fc..3b054553be30 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5453,6 +5453,20 @@ union bpf_attr {
  *		dynptr is invalid or if the offset and length is out of bounds
  *		or in a paged buffer for skb-type dynptrs or across fragments
  *		for xdp-type dynptrs.
+ *
+ * long bpf_dynptr_advance(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Advance a dynptr by *len*.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if *len*
+ *		exceeds the bounds of the dynptr.
+ *
+ * long bpf_dynptr_trim(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Trim a dynptr by *len*.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
+ *		trying to trim more bytes than the size of the dynptr.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5667,6 +5681,8 @@ union bpf_attr {
 	FN(dynptr_from_skb),		\
 	FN(dynptr_from_xdp),		\
 	FN(dynptr_data_rdonly),		\
+	FN(dynptr_advance),		\
+	FN(dynptr_trim),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 30a59c9e5df3..9f356105ab49 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1423,6 +1423,13 @@ static u32 bpf_dynptr_get_size(struct bpf_dynptr_k=
ern *ptr)
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
=20
+static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_siz=
e)
+{
+	u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
+
+	ptr->size =3D new_size | metadata;
+}
+
 int bpf_dynptr_check_size(u32 size)
 {
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
@@ -1646,6 +1653,58 @@ static const struct bpf_func_proto bpf_dynptr_data=
_proto =3D {
 	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
=20
+BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
+{
+	u32 size;
+
+	if (!ptr->data)
+		return -EINVAL;
+
+	size =3D bpf_dynptr_get_size(ptr);
+
+	if (len > size)
+		return -ERANGE;
+
+	ptr->offset +=3D len;
+
+	bpf_dynptr_set_size(ptr, size - len);
+
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_dynptr_advance_proto =3D {
+	.func		=3D bpf_dynptr_advance,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_dynptr_trim, struct bpf_dynptr_kern *, ptr, u32, len)
+{
+	u32 size;
+
+	if (!ptr->data)
+		return -EINVAL;
+
+	size =3D bpf_dynptr_get_size(ptr);
+
+	if (len > size)
+		return -ERANGE;
+
+	bpf_dynptr_set_size(ptr, size - len);
+
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_dynptr_trim_proto =3D {
+	.func		=3D bpf_dynptr_trim,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1718,6 +1777,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_data_proto;
 	case BPF_FUNC_dynptr_data_rdonly:
 		return &bpf_dynptr_data_rdonly_proto;
+	case BPF_FUNC_dynptr_advance:
+		return &bpf_dynptr_advance_proto;
+	case BPF_FUNC_dynptr_trim:
+		return &bpf_dynptr_trim_proto;
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index cce3356765fc..3b054553be30 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5453,6 +5453,20 @@ union bpf_attr {
  *		dynptr is invalid or if the offset and length is out of bounds
  *		or in a paged buffer for skb-type dynptrs or across fragments
  *		for xdp-type dynptrs.
+ *
+ * long bpf_dynptr_advance(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Advance a dynptr by *len*.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if *len*
+ *		exceeds the bounds of the dynptr.
+ *
+ * long bpf_dynptr_trim(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Trim a dynptr by *len*.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
+ *		trying to trim more bytes than the size of the dynptr.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5667,6 +5681,8 @@ union bpf_attr {
 	FN(dynptr_from_skb),		\
 	FN(dynptr_from_xdp),		\
 	FN(dynptr_data_rdonly),		\
+	FN(dynptr_advance),		\
+	FN(dynptr_trim),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

