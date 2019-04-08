Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C0C282CE
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642ED20663
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfDHNyF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:54:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:46102 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfDHNyF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 09:54:05 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDUij-0003g9-Mi; Mon, 08 Apr 2019 15:53:57 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 06/16] bpf: add specification for BTF Var and DataSec kinds
Date:   Mon,  8 Apr 2019 15:53:38 +0200
Message-Id: <4a4225f60dcb0ab9b726229f3a59980989aaaedb.1554731339.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25413/Mon Apr  8 09:56:28 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the BTF specification and UAPI bits for supporting BTF Var
and DataSec kinds. This is following LLVM upstream commit ac4082b77e07
("[BPF] Add BTF Var and DataSec Support") which has been merged recently.
Var itself is for describing a global variable and DataSec to describe
ELF sections e.g. data/bss/rodata sections that hold one or multiple
global variables.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 Documentation/bpf/btf.rst | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btf.h  | 32 ++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 9a60a5d..60d87d7 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -82,6 +82,8 @@ sequentially and type id is assigned to each recognized type starting from id
     #define BTF_KIND_RESTRICT       11      /* Restrict     */
     #define BTF_KIND_FUNC           12      /* Function     */
     #define BTF_KIND_FUNC_PROTO     13      /* Function Proto       */
+    #define BTF_KIND_VAR            14      /* Variable     */
+    #define BTF_KIND_DATASEC        15      /* Section      */
 
 Note that the type section encodes debug info, not just pure types.
 ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
@@ -393,6 +395,61 @@ refers to parameter type.
 If the function has variable arguments, the last parameter is encoded with
 ``name_off = 0`` and ``type = 0``.
 
+2.2.14 BTF_KIND_VAR
+~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+  * ``name_off``: offset to a valid C identifier
+  * ``info.kind_flag``: 0
+  * ``info.kind``: BTF_KIND_VAR
+  * ``info.vlen``: 0
+  * ``type``: the type of the variable
+
+``btf_type`` is followed by a single ``struct btf_variable`` with the
+following data::
+
+    struct btf_var {
+        __u32   linkage;
+    };
+
+``struct btf_var`` encoding:
+  * ``linkage``: currently only static variable 0, or globally allocated
+                 variable in ELF sections 1
+
+Not all type of global variables are supported by LLVM at this point.
+The following is currently available:
+
+  * static variables with or without section attributes
+  * global variables with section attributes
+
+The latter is for future extraction of map key/value type id's from a
+map definition.
+
+2.2.15 BTF_KIND_DATASEC
+~~~~~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+  * ``name_off``: offset to a valid name associated with a variable or
+                  one of .data/.bss/.rodata
+  * ``info.kind_flag``: 0
+  * ``info.kind``: BTF_KIND_DATASEC
+  * ``info.vlen``: # of variables
+  * ``size``: total section size in bytes (0 at compilation time, patched
+              to actual size by BPF loaders such as libbpf)
+
+``btf_type`` is followed by ``info.vlen`` number of ``struct btf_var_secinfo``.::
+
+    struct btf_var_secinfo {
+        __u32   type;
+        __u32   offset;
+        __u32   size;
+    };
+
+``struct btf_var_secinfo`` encoding:
+  * ``type``: the type of the BTF_KIND_VAR variable
+  * ``offset``: the in-section offset of the variable
+  * ``size``: the size of the variable in bytes
+
 3. BTF Kernel API
 *****************
 
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 7b7475e..9310652 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -39,11 +39,11 @@ struct btf_type {
 	 *             struct, union and fwd
 	 */
 	__u32 info;
-	/* "size" is used by INT, ENUM, STRUCT and UNION.
+	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC and FUNC_PROTO.
+	 * FUNC, FUNC_PROTO and VAR.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -70,8 +70,10 @@ struct btf_type {
 #define BTF_KIND_RESTRICT	11	/* Restrict	*/
 #define BTF_KIND_FUNC		12	/* Function	*/
 #define BTF_KIND_FUNC_PROTO	13	/* Function Proto	*/
-#define BTF_KIND_MAX		13
-#define NR_BTF_KINDS		14
+#define BTF_KIND_VAR		14	/* Variable	*/
+#define BTF_KIND_DATASEC	15	/* Section	*/
+#define BTF_KIND_MAX		BTF_KIND_DATASEC
+#define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
 
 /* For some specific BTF_KIND, "struct btf_type" is immediately
  * followed by extra data.
@@ -138,4 +140,26 @@ struct btf_param {
 	__u32	type;
 };
 
+enum {
+	BTF_VAR_STATIC = 0,
+	BTF_VAR_GLOBAL_ALLOCATED,
+};
+
+/* BTF_KIND_VAR is followed by a single "struct btf_var" to describe
+ * additional information related to the variable such as its linkage.
+ */
+struct btf_var {
+	__u32	linkage;
+};
+
+/* BTF_KIND_DATASEC is followed by multiple "struct btf_var_secinfo"
+ * to describe all BTF_KIND_VAR types it contains along with it's
+ * in-section offset as well as size.
+ */
+struct btf_var_secinfo {
+	__u32	type;
+	__u32	offset;
+	__u32	size;
+};
+
 #endif /* _UAPI__LINUX_BTF_H__ */
-- 
2.9.5

