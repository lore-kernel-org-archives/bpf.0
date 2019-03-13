Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B19EC43381
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED0A2075C
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 19:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504931;
	bh=dGThOl2T7YB5RI+20a+sddRz1f7tdgkEVFfdRwXAka8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oIbKzeAFal7MthT3hQb7jy/pwN+KgJ4sAcmEZwDWy2KucvD19lW1QVCg+GUcVY65z
	 NhiQ2X09u9DdS3c3pGoFA4LzSDHlv3fJNYyWkOOcIeF9yHvmpXkqEzFeMYuhW+cNCo
	 BJ1wcaAuG814oUw0pZLai2xiAqpSO/DbpxyFhIlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfCMTRx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfCMTRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Mar 2019 15:17:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 773A52171F;
        Wed, 13 Mar 2019 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504671;
        bh=dGThOl2T7YB5RI+20a+sddRz1f7tdgkEVFfdRwXAka8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YU5IsB6rYnYrxdAmSl6Mtihz9ezxNtyP5TGiitnik+Q/pNKxuBDCzjCmQGskEZRO9
         34cgiT/O/IMbauxDgZTiLdd69KgZqjXRjD7H+wtU+D3MqVu16vIYCAmSxxvVYnth+s
         fNPYTOR8DKjIDpU83FjLzZNwr5wNBiFyh108TAno=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/24] nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
Date:   Wed, 13 Mar 2019 15:16:44 -0400
Message-Id: <20190313191647.160171-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191647.160171-1-sashal@kernel.org>
References: <20190313191647.160171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>

[ Upstream commit 71c190249f0ced5b26377ea6bf829ab3af77a40c ]

The intended optimization should be A ^ 0 = A, not A ^ -1 = A.

Fixes: cd7df56ed3e6 ("nfp: add BPF to NFP code translator")
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c b/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c
index f8df5300f49c..6bfcd6eb74ca 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c
@@ -1017,7 +1017,7 @@ static int xor_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int xor_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR, !~meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR, !meta->insn.imm);
 }
 
 static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
-- 
2.19.1

