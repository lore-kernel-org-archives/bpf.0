Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32273C10F05
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E838520879
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZcnN7tAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfCZSG7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50295 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732550AbfCZSG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so13781791wmi.0
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kp55HY6x50BAaP+YPYIVdE+fL/VPUW1VOJEZqQ4aFqs=;
        b=ZcnN7tAxMjlVKdPXCQpGxSiqdIQInrI81QG/cIUaOL/WJ0pa6XvR7kNsfebeDQgKTB
         LZG778KBAcpjt9WEoRPCit+KrBYxQS1mo8OG6EVK/HU58eHPcfUVMukpOTtEb7WtcI+T
         REINnCzJdCj3AkxLJKmxAsR6puPPfGcnlcj+owVOUX4LlWRRdt0IV/15IQik1mKgfjkJ
         Rejd9kCabwbBRmo2fFW+O5MN9jtxmZvKvdjvoyUy4tIppXFvHp2CXT+181IrEik5ARWh
         l5jz2tpej8l0f4yqtiswh/Ek/jo+MDEGiujOlWUAkh35MK/Qx9kXgxpRd9YvrjW1Ggrw
         6TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kp55HY6x50BAaP+YPYIVdE+fL/VPUW1VOJEZqQ4aFqs=;
        b=LELn4moqsNHerlM4gtx0GXyLa2GYP2R6+MWovyxTkY9WKO24xwE8ZoPCVECuiiJZoP
         d0vhIpGYtVDJFnh3vIQghJv6AVaE9Aopx6lMKUyujW1V8SvQ2KNFFpoZu3h8yBZAzgO6
         h9ZF2bIxK8VDJ7sspx98N0s+fvsaGLYPS/J2yXHFUF0SH8n5CDlYxwfNh+Ppzgwq8aVb
         3zExAKp2s2hT4nLLuu3XDVjmXfTrn6eN4G4lXWqaxft0UoMyh5y6NdoNGGNmS1RL13M7
         /XWAYZy45zi3m+NqJGvLRdimo3LwRr5iHBAqQYVnrpUubeVqwHQHx7fx83zQhjNWEIHw
         kWoQ==
X-Gm-Message-State: APjAAAUFKAlDN4wN3UESk+wa5Yz+0OKRHypWr2Io8LhKVmNyYCeYbIyc
        TWbLVAcpMkd/wE78juCmqzNr8w==
X-Google-Smtp-Source: APXvYqwZni5uwSB+SLC96uq94/quXkUn/BW/LivoEn/7OA65xKwxE4h20LnoVLnshCl3c6UqcbIlbg==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr15351423wmb.84.1553623616367;
        Tue, 26 Mar 2019 11:06:56 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:55 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 16/16] selftests: bpf: unit testcases for zero extension insertion pass
Date:   Tue, 26 Mar 2019 18:05:39 +0000
Message-Id: <1553623539-15474-17-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds some unit testcases.

There are a couple of code paths inside verifier doing register read/write
marking, therefore are the places that could trigger zero extension
insertion logic. Create one test for each of them.

A couple of testcases for complex CFG also included. They cover register
read propagation during path pruning etc.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/testing/selftests/bpf/verifier/zext.c | 651 ++++++++++++++++++++++++++++
 1 file changed, 651 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/zext.c

diff --git a/tools/testing/selftests/bpf/verifier/zext.c b/tools/testing/selftests/bpf/verifier/zext.c
new file mode 100644
index 0000000..b45a429
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/zext.c
@@ -0,0 +1,651 @@
+/* There are a couple of code paths inside verifier doing register
+ * read/write marking. Create one test for each.
+ */
+{
+	"zext: basic 1",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"zext: basic 2",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = -1,
+},
+{
+	"zext: basic 3",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"zext: basic 4",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_1, 0x300000001ULL),
+	BPF_MOV32_IMM(BPF_REG_1, 1),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
+	BPF_MOV32_IMM(BPF_REG_2, 2),
+	BPF_JMP_REG(BPF_JSLE, BPF_REG_1, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 3),
+	BPF_EXIT_INSN(),
+	BPF_MOV32_IMM(BPF_REG_0, 4),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_1, 0x300000001ULL),
+	BPF_MOV32_IMM(BPF_REG_1, 1),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
+	BPF_MOV32_IMM(BPF_REG_2, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 32),
+	BPF_JMP_REG(BPF_JSLE, BPF_REG_1, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 3),
+	BPF_EXIT_INSN(),
+	BPF_MOV32_IMM(BPF_REG_0, 4),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 4,
+},
+{
+	"zext: basic 5",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_1, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_1, 0),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_1, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"zext: basic 6",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_MOV32_IMM(BPF_REG_1, 1),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_MOV32_IMM(BPF_REG_1, 1),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"zext: ret from main",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"zext: ret from helper",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_IMM(BPF_REG_8, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	/* Shouldn't do zext. */
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_IMM(BPF_REG_8, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"zext: xadd",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_STX_XADD(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_0, 0x100000001ULL),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_STX_XADD(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.retval = 1,
+},
+{
+	"zext: ld_abs ind",
+	.insns = {
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_1),
+	BPF_LD_IMM64(BPF_REG_8, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	BPF_LD_IND(BPF_B, BPF_REG_8, 0),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_1),
+	BPF_LD_IMM64(BPF_REG_8, 0x100000000ULL),
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	},
+	.data = {
+		10, 20, 30, 40, 50,
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 10,
+},
+{
+	"zext: multi paths, all 32-bit use",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	BPF_MOV32_REG(BPF_REG_7, BPF_REG_8),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_7),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	BPF_MOV32_REG(BPF_REG_7, BPF_REG_8),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_7),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 2,
+},
+{
+	"zext: multi paths, partial 64-bit use",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_8, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_8, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_LD_IMM64(BPF_REG_8, 0x100000001ULL),
+	BPF_MOV32_IMM(BPF_REG_8, 0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"zext: multi paths, 32-bit def override",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_7),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
+	BPF_MOV32_REG(BPF_REG_0, BPF_REG_7),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 2,
+},
+{
+	/* Diamond CFG
+	 *
+	 *          -----
+	 *         | BB0 |
+	 *          -----
+	 *           /\
+	 *          /  \
+	 *         /    \
+	 *      -----     -----
+	 *     | BB1 |   | BB2 | u32 def
+	 *      -----     -----
+	 *         \     /
+	 *          \   / -> pruned, but u64 read should propagate backward
+	 *           \ /
+	 *          -----
+	 *         | BB3 | u64 read
+	 *          -----
+	 */
+	"zext: complex cfg 1",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	/* BB3, 64-bit R8 read should be prop backward. */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	/* BB3 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	/* Diamond CFG
+	 *
+	 *          -----
+	 *         | BB0 | u32 def
+	 *          -----
+	 *           /\
+	 *          /  \
+	 *         /    \
+	 *      -----     -----
+	 *     | BB1 |   | BB2 | u32 def
+	 *      -----     -----
+	 *         \     /
+	 *          \   / -> pruned, but u64 read should propagate backward
+	 *           \ /
+	 *          -----
+	 *         | BB3 | u64 read
+	 *          -----
+	 */
+	"zext: complex cfg 2",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_6, 2),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	/* BB3, 64-bit R8 read should be prop backward. */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_6, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 32),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	/* BB3 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 2,
+},
+{
+	/* Diamond CFG
+	 *
+	 *                 -----
+	 *                | BB0 | u32 def A
+	 *                 -----
+	 *                  /\
+	 *                 /  \
+	 *                /    \
+	 *             -----    -----
+	 *  u64 def A | BB1 |  | BB2 | u32 def B
+	 *             -----    -----
+	 *                 \     /
+	 *                  \   /
+	 *                   \ /
+	 *                  -----
+	 *                 | BB3 | u64 read A and B
+	 *                  -----
+	 */
+	"zext: complex cfg 3",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_6, 2),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_MOV64_IMM(BPF_REG_6, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 2),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	/* BB3, 64-bit R8 read should be prop backward. */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_6, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 32),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_MOV64_IMM(BPF_REG_6, 2),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	/* BB3 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 2,
+},
+{
+	/* Diamond CFG
+	 *
+	 *                 -----
+	 *                | BB0 | u32 def A
+	 *                 -----
+	 *                  /\
+	 *                 /  \
+	 *                /    \
+	 *             -----    -----
+	 *  u64 def A | BB1 |  | BB2 | u64 def A and u32 def B
+	 *             -----    -----
+	 *                 \     /
+	 *                  \   /
+	 *                   \ /
+	 *                  -----
+	 *                 | BB3 | u64 read A and B
+	 *                  -----
+	 */
+	"zext: complex cfg 4",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_6, 2),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_MOV64_IMM(BPF_REG_6, 3),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_MOV64_IMM(BPF_REG_6, 3),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
+	/* BB3, 64-bit R8 read should be prop backward. */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV32_IMM(BPF_REG_6, 2),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 3),
+	/* BB1 */
+	BPF_MOV64_IMM(BPF_REG_8, 2),
+	BPF_MOV64_IMM(BPF_REG_6, 3),
+	BPF_JMP_IMM(BPF_JA, 0, 0, 4),
+	/* BB2 */
+	BPF_MOV32_IMM(BPF_REG_8, 2),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_8, 32),
+	BPF_MOV64_IMM(BPF_REG_6, 3),
+	/* BB3 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 3,
+},
+{
+	"zext: callee-saved",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_6, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	/* callee */
+	BPF_MOV32_IMM(BPF_REG_6, 1),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	/* caller u32 def should be zero extended. */
+	BPF_MOV32_IMM(BPF_REG_6, 0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 32),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	/* u64 use. */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	/* callee u32 def shouldn't be affected. */
+	BPF_MOV32_IMM(BPF_REG_6, 1),
+	BPF_EXIT_INSN(),
+	},
+	.errstr_unpriv = "function calls to other bpf functions are allowed for root only",
+	.result_unpriv = REJECT,
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"zext: arg regs",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callee */
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	/* caller u32 def should be zero extended. */
+	BPF_MOV32_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+	/* u64 use. */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* callee u64 use on caller-saved reg. */
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_EXIT_INSN(),
+	},
+	.errstr_unpriv = "function calls to other bpf functions are allowed for root only",
+	.result_unpriv = REJECT,
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"zext: return arg",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_MOV32_REG(BPF_REG_6, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	/* callee 1 */
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* callee 2 */
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.xlated_insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 7),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_MOV32_REG(BPF_REG_6, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 32),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_6),
+	BPF_EXIT_INSN(),
+	/* callee 1 */
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* callee 2 */
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 32),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 32),
+	BPF_EXIT_INSN(),
+	},
+	.errstr_unpriv = "function calls to other bpf functions are allowed for root only",
+	.result_unpriv = REJECT,
+	.result = ACCEPT,
+	.retval = 3,
+},
-- 
2.7.4

