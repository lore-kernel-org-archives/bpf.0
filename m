Return-Path: <SRS0=COpY=6U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D91C28CBC
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3C52073A
	for <bpf@archiver.kernel.org>; Wed,  6 May 2020 14:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgEFOEp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 May 2020 10:04:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgEFOEp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 10:04:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BDB53F1DD6459DB08CA;
        Wed,  6 May 2020 22:04:42 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 22:04:35 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <udknight@gmail.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <andriin@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>, <lukenels@cs.washington.edu>,
        <xi.wang@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2] bpf, i386: remove unneeded conversion to bool
Date:   Wed, 6 May 2020 22:03:52 +0800
Message-ID: <20200506140352.37154-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The '==' expression itself is bool, no need to convert it to bool again.
This fixes the following coccicheck warning:

arch/x86/net/bpf_jit_comp32.c:1478:50-55: WARNING: conversion to bool
not needed here
arch/x86/net/bpf_jit_comp32.c:1479:50-55: WARNING: conversion to bool
not needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 v2: change the name 'x32' to 'i386'.

 arch/x86/net/bpf_jit_comp32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 66cd150b7e54..96fde03aa987 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1475,8 +1475,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		const s32 imm32 = insn->imm;
 		const bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
-		const bool dstk = insn->dst_reg == BPF_REG_AX ? false : true;
-		const bool sstk = insn->src_reg == BPF_REG_AX ? false : true;
+		const bool dstk = insn->dst_reg != BPF_REG_AX;
+		const bool sstk = insn->src_reg != BPF_REG_AX;
 		const u8 code = insn->code;
 		const u8 *dst = bpf2ia32[insn->dst_reg];
 		const u8 *src = bpf2ia32[insn->src_reg];
-- 
2.21.1

