Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E035CC282DD
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83E92175B
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 21:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDEVAD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:00:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:54872 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDEVAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Apr 2019 17:00:00 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hCVwJ-00075Z-Bi; Fri, 05 Apr 2019 22:59:55 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 09/16] bpf: sync {btf,bpf}.h uapi header from tools infrastructure
Date:   Fri,  5 Apr 2019 22:59:35 +0200
Message-Id: <e7d2f32680f308ec8452e7569518b5854c528cd2.1554497408.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554497408.git.daniel@iogearbox.net>
References: <cover.1554497408.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554497408.git.daniel@iogearbox.net>
References: <cover.1554497408.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25410/Fri Apr  5 09:58:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pull in latest changes from both headers, so we can make use of
them in libbpf.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/include/uapi/linux/bpf.h | 24 ++++++++++++++++++++++--
 tools/include/uapi/linux/btf.h | 32 ++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8370245..92588db 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -105,6 +105,7 @@ enum bpf_cmd {
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
+	BPF_MAP_FREEZE,
 };
 
 enum bpf_map_type {
@@ -255,8 +256,19 @@ enum bpf_attach_type {
  */
 #define BPF_F_ANY_ALIGNMENT	(1U << 1)
 
-/* when bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_FD, bpf_ldimm64->imm == fd */
+/* When BPF ldimm64's insn[0].src_reg != 0 then this can have
+ * two extensions:
+ *
+ * insn[0].src_reg:  BPF_PSEUDO_MAP_FD   BPF_PSEUDO_MAP_VALUE
+ * insn[0].imm:      map fd              map fd
+ * insn[1].imm:      0                   offset into value
+ * insn[0].off:      0                   lower 16 bit of map index
+ * insn[1].off:      0                   higher 16 bit of map index
+ * ldimm64 rewrite:  address of map      address of map[index]+offset
+ * verifier type:    CONST_PTR_TO_MAP    PTR_TO_MAP_VALUE
+ */
 #define BPF_PSEUDO_MAP_FD	1
+#define BPF_PSEUDO_MAP_VALUE	2
 
 /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
  * offset to another bpf function
@@ -283,7 +295,7 @@ enum bpf_attach_type {
 
 #define BPF_OBJ_NAME_LEN 16U
 
-/* Flags for accessing BPF object */
+/* Flags for accessing BPF object from syscall side. */
 #define BPF_F_RDONLY		(1U << 3)
 #define BPF_F_WRONLY		(1U << 4)
 
@@ -293,6 +305,14 @@ enum bpf_attach_type {
 /* Zero-initialize hash function seed. This should only be used for testing. */
 #define BPF_F_ZERO_SEED		(1U << 6)
 
+/* Flags for accessing BPF object from program side. */
+#define BPF_F_RDONLY_PROG	(1U << 7)
+#define BPF_F_WRONLY_PROG	(1U << 8)
+#define BPF_F_ACCESS_MASK	(BPF_F_RDONLY |		\
+				 BPF_F_RDONLY_PROG |	\
+				 BPF_F_WRONLY |		\
+				 BPF_F_WRONLY_PROG)
+
 /* flags for BPF_PROG_QUERY */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 7b7475e..9310652 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
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

