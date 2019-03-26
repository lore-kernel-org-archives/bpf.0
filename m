Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD103C10F0A
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F3A20866
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Uwz6kXSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfCZSGw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41908 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbfCZSGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so7813158wrq.8
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=Uwz6kXStZ3+GS00JjBgym7IHmoe5zQCtHuhTZWZ6whi8Paulx4I9osEYbAp8OAxb1r
         SN2R82bPatlTfGf7/ZDGsoX2AoKGLUHynBD4IcnNQN4nth3uhGZRFBxAIgKS1VjxkQYt
         Z1u+bGRrQhSNFQ40QVyNt5aahhgDaZZV/CywzKNqP1GUejZj6gDZtoyneyUNh0yD9qOO
         zxcvCDG183uaTZ/1QqG5h+1pXRv/HKJrxkCCzJpLxOXNlVXgRTKx/W/OfBwjHeesdTpt
         ydcoblscucz4JYutnXHtEprSx+fZ06ZbJlL/DFrCxZH4HRv9F7JDtnyFW1A+el7iMl0Q
         JjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=E/nAMY0UkKMKar843le8JgYENZ59uuqX3KS2x0KRUvKS+dzbHpWagelHHMRuHTTHXm
         cSLfAjy1LRFkmzSssuV11zKc7krNml8+93HkMONTZhhP19EvbiMaTqn+W4Cu1ivplJdl
         M1yMKJOekokCz3TCwmF68AAN+RQkfvZYr29L4WeRLir11b3+cT/ev5X90OLoTzVO9sg9
         LTZDXcnWqty1mvjOKv5onfVI9cTeEToQTxxrsl1Skv+nHdLhKKCmCrr+CM30B8fe51Vt
         /maBBA2aQ0rz1sBD8AfDId9uy9XgqMYNesXOq9e8uYeXm82dcfOX2CsyE5GXjJljeqpm
         /19Q==
X-Gm-Message-State: APjAAAV/y2c99q746Znqnpvq8MXAYYA8CR1GhqhO5ZLEuGG18EsdA/tM
        UbWnjGLty9kQ5yYXwcZmQ66dLw==
X-Google-Smtp-Source: APXvYqzRW/JCTfVndo3ix6hVnik+3OhuUgzyLEs1Bmvdrdyvk0jE6wPonj8TWWeDZgJqRDGyaufR0g==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr17263748wrw.313.1553623609369;
        Tue, 26 Mar 2019 11:06:49 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:48 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH/RFC bpf-next 11/16] sparc: bpf: eliminate zero extension code-gen
Date:   Tue, 26 Mar 2019 18:05:34 +0000
Message-Id: <1553623539-15474-12-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
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

