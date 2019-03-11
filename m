Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03FBC10F0B
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 21:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0D9214AE
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfCKVvz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:51:55 -0400
Received: from www62.your-server.de ([213.133.104.62]:41136 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfCKVvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 17:51:45 -0400
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3Spg-0003Oc-4k; Mon, 11 Mar 2019 22:51:40 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, yhs@fb.com, andrii.nakryiko@gmail.com,
        jakub.kicinski@netronome.com, tgraf@suug.ch, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH rfc v3 bpf-next 5/9] bpf: sync bpf.h uapi header from tools infrastructure
Date:   Mon, 11 Mar 2019 22:51:21 +0100
Message-Id: <20190311215125.17793-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190311215125.17793-1-daniel@iogearbox.net>
References: <20190311215125.17793-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25385/Mon Mar 11 08:43:35 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pull in latest changes, so we can make use of them in libbpf.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/include/uapi/linux/bpf.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c38ac9a92a7..5eb59f05a147 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -105,6 +105,7 @@ enum bpf_cmd {
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
+	BPF_MAP_LOCK,
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
+ * insn[0].off:      0                   32 bit index to the
+ * insn[1].off:      0                   map value
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
 
-- 
2.17.1

