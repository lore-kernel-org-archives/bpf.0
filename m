Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCAFC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBFC20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="h+f/MmuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDJTu7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34373 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDJTu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so4393388wrq.1
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=h+f/MmuThlGCO+2gwqFUFZCTLfRc1rF9K0PyqVEz48+Ix/qTjIg7rIOkqThqQpvZlc
         fkmBmNhRP2Bagpwud+TsggBmi+ZkKOLlKN/sDeAxCl5iJMc27nv5NLAWSlO1KTBuu5yi
         YvoB387W32CtwlUvthLbwSb4hYc2aOzKRTzmSbhTAF9oIRFZr9W4AFD+L8LwwD3gY+mw
         mhdFKWMtnoaaIubd1Pkf7hRkUe+ypgr0BgQWeVW/0unI96UtZQllfpM7Cuo7XmVKJg9F
         rztcWiqgxbXxYMMcEnC4XDAmnTJHiQVEV4GlM80ozdhax+2WPNFiI/AmldOANrwOCPa5
         iEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=BsON/kQi4/MBtWRCJpoEo20Lif1GbOpmEET8ARJeLXcQCwoPeDKz79aUzFHBimN7d8
         ZkcP03RpAJ4g4soqSf7R0rAca6sWT3qzAw+GR/1726I5cQ8kXGUTvOhjyx1xJSRyDA06
         +Q6G0+xeLSP81fzneaSDc27+pxC1Yszma+XzlGWKIpg4Jzq/xJiomCaiTYU8iWnCdsyJ
         IN0IeXvp0LH2uXmIugEKlvtQwpcA05nSkNden4ccRhQHxgm/knCcd7LRf+14WDt3+Dmj
         rmwUWd+Ui0fHcJ+DJMf7wvKDR/5vfxPtp49XU8D8RVGRJ3aY2dFi+TVUyvGCvbO6N+f2
         59sg==
X-Gm-Message-State: APjAAAVIPusaPS/Km4qyQPCfk8jmmTSBHf8F/P0XsB/w97eZkqdQhB1n
        mYGOmrXfaJMINbXISmF+5oSAcw==
X-Google-Smtp-Source: APXvYqx7OlAOpGFjhioIJ3r9IhMKxbffKlpC/zAwgt+4zJpmqshyZ6qiyxXEYRmGKwdrkv5aqmTJmg==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr18043501wrl.214.1554925857247;
        Wed, 10 Apr 2019 12:50:57 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:56 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH/RFC v2 bpf-next 16/19] sparc: bpf: eliminate zero extension code-gen
Date:   Wed, 10 Apr 2019 20:50:30 +0100
Message-Id: <1554925833-7333-17-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
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

