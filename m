Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ACCC10F06
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B144B20854
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Snkt22Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfCNLkp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:40:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38534 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCNLkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id a188so2342063wmf.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7AiPMvQZj8LuCPIW7/2R5QK7nIIXiLCYkUH/b7otfA=;
        b=Snkt22MazqiX4FnA4VhXsrQOX1vueGMQMUSI8pvDOv0byZyUokj5weOVgpb6Ip7fbi
         lpT3Tbfd6WRG5mFeFSs8UrDAZJDYRTztxBpxWufYjohbWmfMquLhTYGpQVgS3Q7QDjN4
         hvrUb27FKj+3WoM84JRFqrR/hCjwGH8iNry4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7AiPMvQZj8LuCPIW7/2R5QK7nIIXiLCYkUH/b7otfA=;
        b=Nkf8Byk3l4vJUvxjdGPOzc9n26j9l90aio8iHCTrGPRIknpGavqz3dvVehDFkY2OM2
         5ojyd/8uPyDJ7jN1AhdxA89rapHDBkPTLwi19Seep4OS/2a/F90s/Rk3ioefIb8HsXNP
         KYQLlOQRVxwwM/dU2oiHBBP13mAiSpiIYd4SHHzQMstOpoaVMLWL56AgUptlZIbWIJ6B
         u+892rqwZjY18ggzJtCiRuYkgrdhmz9JAgr5GAgXfwxlk6TJxX99buM44rDYpD+H9COL
         emegmzQvFMTq73np73umgJUwazzw+eNvaZunz2u2pLDI86WZOZnVVju1YA38IhAW/ZNb
         qy5Q==
X-Gm-Message-State: APjAAAVqKhBKtBnadvBMBDTcNU8PessfAhAPtCWL0B3DsIzXah3dLGoW
        hTE70d3yBVBn4eoUnJH8q+xqog==
X-Google-Smtp-Source: APXvYqxNzNVSpAVbftkrmhq2eDIT8pa5glCFRXMrBJ562ND+BqlU2xVeaQ1Bcf93WTtlPzSiAzgqAQ==
X-Received: by 2002:a1c:80d6:: with SMTP id b205mr2301469wmd.109.1552563642483;
        Thu, 14 Mar 2019 04:40:42 -0700 (PDT)
Received: from antares.lan (5.8.9.5.4.5.2.4.f.f.6.d.4.1.5.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8514:d6ff:4254:5985])
        by smtp.gmail.com with ESMTPSA id a9sm1804017wmb.30.2019.03.14.04.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:40:41 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, theojulienne@github.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 6/8] selftests/bpf: allow specifying helper for BPF_SK_LOOKUP
Date:   Thu, 14 Mar 2019 11:39:52 +0000
Message-Id: <20190314113954.10210-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314113954.10210-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190314113954.10210-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make the BPF_SK_LOOKUP macro take a helper function, to ease
writing tests for new helpers.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/test_verifier.c   |  6 +-
 .../selftests/bpf/verifier/ref_tracking.c     | 78 +++++++++----------
 tools/testing/selftests/bpf/verifier/unpriv.c |  8 +-
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 477a9dcf9fff..19b5d03acc2a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -198,7 +198,7 @@ static void bpf_fill_rand_ld_dw(struct bpf_test *self)
 }
 
 /* BPF_SK_LOOKUP contains 13 instructions, if you need to fix up maps */
-#define BPF_SK_LOOKUP							\
+#define BPF_SK_LOOKUP(func)						\
 	/* struct bpf_sock_tuple tuple = {} */				\
 	BPF_MOV64_IMM(BPF_REG_2, 0),					\
 	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),			\
@@ -207,13 +207,13 @@ static void bpf_fill_rand_ld_dw(struct bpf_test *self)
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -32),		\
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -40),		\
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -48),		\
-	/* sk = sk_lookup_tcp(ctx, &tuple, sizeof tuple, 0, 0) */	\
+	/* sk = func(ctx, &tuple, sizeof tuple, 0, 0) */		\
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),				\
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -48),				\
 	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct bpf_sock_tuple)),	\
 	BPF_MOV64_IMM(BPF_REG_4, 0),					\
 	BPF_MOV64_IMM(BPF_REG_5, 0),					\
-	BPF_EMIT_CALL(BPF_FUNC_sk_lookup_tcp)
+	BPF_EMIT_CALL(BPF_FUNC_ ## func)
 
 /* BPF_DIRECT_PKT_R2 contains 7 instructions, it initializes default return
  * value into 0 and does necessary preparation for direct packet access
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index 923f2110072d..a6905e5017dc 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -1,7 +1,7 @@
 {
 	"reference tracking: leak potential reference",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0), /* leak reference */
 	BPF_EXIT_INSN(),
 	},
@@ -12,7 +12,7 @@
 {
 	"reference tracking: leak potential reference on stack",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_0, 0),
@@ -26,7 +26,7 @@
 {
 	"reference tracking: leak potential reference on stack 2",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),
 	BPF_STX_MEM(BPF_DW, BPF_REG_4, BPF_REG_0, 0),
@@ -41,7 +41,7 @@
 {
 	"reference tracking: zero potential reference",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_IMM(BPF_REG_0, 0), /* leak reference */
 	BPF_EXIT_INSN(),
 	},
@@ -52,7 +52,7 @@
 {
 	"reference tracking: copy and zero potential references",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_MOV64_IMM(BPF_REG_7, 0), /* leak reference */
@@ -65,7 +65,7 @@
 {
 	"reference tracking: release reference without check",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	/* reference in r0 may be NULL */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
@@ -79,7 +79,7 @@
 {
 	"reference tracking: release reference",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -91,7 +91,7 @@
 {
 	"reference tracking: release reference 2",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
@@ -104,7 +104,7 @@
 {
 	"reference tracking: release reference twice",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
@@ -120,7 +120,7 @@
 {
 	"reference tracking: release reference twice inside branch",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3), /* goto end */
@@ -147,7 +147,7 @@
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_2,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1), /* mark == 0? */
 	/* Leak reference in R0 */
 	BPF_EXIT_INSN(),
@@ -175,7 +175,7 @@
 	BPF_EXIT_INSN(),
 	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_2,
 		    offsetof(struct __sk_buff, mark)),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 4), /* mark == 0? */
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2), /* sk NULL? */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -193,7 +193,7 @@
 {
 	"reference tracking in call: free reference in subprog",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* unchecked reference */
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -211,7 +211,7 @@
 {
 	"reference tracking in call: free reference in subprog and outside",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* unchecked reference */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
@@ -241,7 +241,7 @@
 
 	/* subprog 1 */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_4),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	/* spill unchecked sk_ptr into stack of caller */
 	BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_0, 0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
@@ -262,7 +262,7 @@
 	BPF_EXIT_INSN(),
 
 	/* subprog 1 */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_EXIT_INSN(), /* return sk */
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -291,7 +291,7 @@
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -324,7 +324,7 @@
 	BPF_EXIT_INSN(),
 
 	/* subprog 2 */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
@@ -334,7 +334,7 @@
 	"reference tracking: allow LD_ABS",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -350,7 +350,7 @@
 	"reference tracking: forbid LD_ABS while holding reference",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_LD_ABS(BPF_B, 0),
 	BPF_LD_ABS(BPF_H, 0),
 	BPF_LD_ABS(BPF_W, 0),
@@ -367,7 +367,7 @@
 	"reference tracking: allow LD_IND",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -384,7 +384,7 @@
 	"reference tracking: forbid LD_IND while holding reference",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_4, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_7, 1),
 	BPF_LD_IND(BPF_W, BPF_REG_7, -0x200000),
@@ -402,7 +402,7 @@
 	"reference tracking: check reference or tail call",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	/* if (sk) bpf_sk_release() */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 7),
@@ -424,7 +424,7 @@
 	"reference tracking: release reference then tail call",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	/* if (sk) bpf_sk_release() */
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
@@ -446,7 +446,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
 	/* Look up socket and store in REG_6 */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	/* bpf_tail_call() */
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_3, 2),
@@ -470,7 +470,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_1),
 	/* Look up socket and store in REG_6 */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	/* if (!sk) goto end */
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
@@ -492,7 +492,7 @@
 {
 	"reference tracking: mangle and release sock_or_null",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 5),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
@@ -506,7 +506,7 @@
 {
 	"reference tracking: mangle and release sock",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 5),
@@ -520,7 +520,7 @@
 {
 	"reference tracking: access member",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
@@ -534,7 +534,7 @@
 {
 	"reference tracking: write to member",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
@@ -553,7 +553,7 @@
 {
 	"reference tracking: invalid 64-bit access of member",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
@@ -568,7 +568,7 @@
 {
 	"reference tracking: access after release",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 	BPF_EMIT_CALL(BPF_FUNC_sk_release),
@@ -608,7 +608,7 @@
 {
 	"reference tracking: use ptr from bpf_tcp_sock() after release",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
@@ -631,7 +631,7 @@
 {
 	"reference tracking: use ptr from bpf_sk_fullsock() after release",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
@@ -654,7 +654,7 @@
 {
 	"reference tracking: use ptr from bpf_sk_fullsock(tp) after release",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
@@ -681,7 +681,7 @@
 {
 	"reference tracking: use sk after bpf_sk_release(tp)",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
@@ -703,7 +703,7 @@
 {
 	"reference tracking: use ptr from bpf_get_listener_sock() after bpf_sk_release(sk)",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
@@ -725,7 +725,7 @@
 {
 	"reference tracking: bpf_sk_release(listen_sk)",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
@@ -750,7 +750,7 @@
 	/* !bpf_sk_fullsock(sk) is checked but !bpf_tcp_sock(sk) is not checked */
 	"reference tracking: tp->snd_cwnd after bpf_sk_fullsock(sk) and bpf_tcp_sock(sk)",
 	.insns = {
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testing/selftests/bpf/verifier/unpriv.c
index dbaf5be947b2..91bb77c24a2e 100644
--- a/tools/testing/selftests/bpf/verifier/unpriv.c
+++ b/tools/testing/selftests/bpf/verifier/unpriv.c
@@ -242,7 +242,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
 	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	/* u64 foo; */
 	/* void *target = &foo; */
@@ -276,7 +276,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
 	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	/* u64 foo; */
 	/* void *target = &foo; */
@@ -307,7 +307,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
 	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	/* u64 foo; */
 	/* void *target = &foo; */
@@ -339,7 +339,7 @@
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_1),
 	/* struct bpf_sock *sock = bpf_sock_lookup(...); */
-	BPF_SK_LOOKUP,
+	BPF_SK_LOOKUP(sk_lookup_tcp),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	/* u64 foo; */
 	/* void *target = &foo; */
-- 
2.19.1

