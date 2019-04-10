Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849FDC282CE
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E9B20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HzZ/RMLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfDJTvP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDJTu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so4366463wro.5
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FyyxR9Iqk6cAH0oBjCaJb0bcVV0NGMOOW5Oun5gFHdM=;
        b=HzZ/RMLbRR0LlDWzLnkZuiW8/E4JzLPukqHbMowxvtAH3ngpu8hPjb2RrOLrSv1Zzz
         w3bnZ9bplhvqqpT2vV+cf4cqUi7D7QkyFZvtxdXXjEGdyzLgymBA/fBTWvoF+zEAY3Ed
         +tINQH6XYx7+pgTtDEaUNbvphEFWz2tDq8dUaRHu8KrfaYAcL3WqjrzT2odP8eAgOn1L
         vYPo6kz9EvCe7rasm7djKef9Q0y0nOpB4PYQXV+FzcyCaSq1GOraYf9MNEtpyTu0XFcy
         j+UwxBRfDt2ggWnJeu0YcCFmwrlsn4lzxGrQXn+iGfxAFL8kwBrR0qDBuaAtRXUPjzmY
         1B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FyyxR9Iqk6cAH0oBjCaJb0bcVV0NGMOOW5Oun5gFHdM=;
        b=ts4kS5TdlO8kdaGXq6mI6HSpgG9TNHr6nBzWR0Pw9NCJSIF8zGaWD3mL5cLYc/q6Yo
         7sC6r0SyW/aGM4bsvGRb6Yme0IdLp/NcPHPUgPevOAFU27XWj6mg27ZPoMt0TgLPtJaP
         +ABWWM3zT1O4PFt3L0EVww7VnSonE3EU2NhyE9JxNA2VmoAhi7Rhx50cvk4YwjbkNN1i
         0X5w+UkkTIFvPbecaYCfTouSOxWcOfYKBQePcxKbllOnNHhr3e+MZKrPEYSFrD+X+whb
         09eY2MlY3+PJXVueEtXmUbDI89DrT5WxMTNaevGuaENOvS+EmgLaBXUjgklQYwsqD7Vu
         Aozg==
X-Gm-Message-State: APjAAAVquDLUVvE4FVZ0Js879W7Sc9m4gF6i3SSN+LAsDMNNDOd3B/IA
        HBVFStJIBbX43NBLKpXYwgFtuw==
X-Google-Smtp-Source: APXvYqzxXf6ZJEMOzZFrLqKmI0tx2yu77e9UcA0swTVWCzqiYYMtnFBeClEJ9Ap7k5/MJnMoJ1qb6A==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr27949031wro.111.1554925854993;
        Wed, 10 Apr 2019 12:50:54 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:54 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH/RFC v2 bpf-next 14/19] powerpc: bpf: eliminate zero extension code-gen
Date:   Wed, 10 Apr 2019 20:50:28 +0100
Message-Id: <1554925833-7333-15-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 21a1dcd..d10621b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -559,7 +559,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 
 bpf_alu32_trunc:
 		/* Truncate to 32-bits */
-		if (BPF_CLASS(code) == BPF_ALU)
+		if (BPF_CLASS(code) == BPF_ALU && fp->aux->no_verifier_zext)
 			PPC_RLWINM(dst_reg, dst_reg, 0, 0, 31);
 		break;
 
@@ -1046,6 +1046,11 @@ struct powerpc64_jit_data {
 	struct codegen_context ctx;
 };
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
 	u32 proglen;
-- 
2.7.4

