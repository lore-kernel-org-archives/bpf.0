Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3E9C282DA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF822183F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lmX9h9ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfDOR1D (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:27:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37120 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfDOR0v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so23049225wrm.4
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=lmX9h9ZV5BfsgW6Qbi07yWC0V78sfrm2KHsIxvSkbG+u8TJ8k2i3w8bEcN0+b4M2Ip
         Sr9OmNJk22Lj55iXqsugQZSsM00xFmhvjQsHRldxqFomrj/kiklZJtU2AuZaecOrVa1p
         8MDx9PK0w2CG6PCk2SElIGMce7n7KN1Kv2lW4reQtZ/r9eaQwxWM0f0lSd/fR+2uhUsF
         PgGlHddb/o0nClxjDlXAgyqP6qNhuBaOE8AZtdRRpvGqmwym3MOf/ieffRSNCSlpvLyd
         PdiJ0owJApvTlCFI8kSUi6Dqe+vegvozOj1MNq/s8sReC9cN486Jzp+Q97avSRDOyHxn
         cKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=nCt3KzW/Njp0R9GCZmx1/jLiMxZpF5chgKOpGmnLsne5mIIOwG1e6Am/68V3dlIskT
         BnxS6CcC2vckt9WN8u2Zr2MJus3usOBtcXLHLX+5DPjDYBjveZe2g6hhNVSvGsVPNLaq
         +hnYy+sd56YZMWyCuxoC0fDMYXEuxP4AibXJ1GH7n1N9jqQGaipmgyN0JbcYxgVDV64B
         CdKNGYeyTXMd1koud9uq4kEZQF2auKiLxAXoPxEzRIHrs+nO+wwxXSar3tiDNScc9/22
         DsNlK5aidwnW+rxoRsN3ZAZDrE7T80s+7aEiKiuBFkEDZTC8U2OuQxxyzFwsn6sl5rlG
         qTrg==
X-Gm-Message-State: APjAAAXX1x4Dvo18IoyBA/7TYxOJgWim64bGycjWhODL9tp0qc+RQqoE
        fByYb0QvqNRDgGplCZBwXVdcEejeq4g=
X-Google-Smtp-Source: APXvYqxJx5rtod4HgpqSbR4jQnRzjAd4JLhkmgw0wHzOAqhiyN86zoqvYB+uJD9ZRmnvwdiqDVTFmQ==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr20139226wrw.71.1555349209771;
        Mon, 15 Apr 2019 10:26:49 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:49 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v4 bpf-next 12/15] sparc: bpf: eliminate zero extension code-gen
Date:   Mon, 15 Apr 2019 18:26:22 +0100
Message-Id: <1555349185-12508-13-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 65428e7..e58f84e 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1144,7 +1144,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 
 	do_alu32_trunc:
-		if (BPF_CLASS(code) == BPF_ALU)
+		if (BPF_CLASS(code) == BPF_ALU &&
+		    ctx->prog->aux->no_verifier_zext)
 			emit_alu_K(SRL, dst, 0, ctx);
 		break;
 
@@ -1432,6 +1433,11 @@ static void jit_fill_hole(void *area, unsigned int size)
 		*ptr++ = 0x91d02005; /* ta 5 */
 }
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct sparc64_jit_data {
 	struct bpf_binary_header *header;
 	u8 *image;
-- 
2.7.4

