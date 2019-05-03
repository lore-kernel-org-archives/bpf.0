Return-Path: <SRS0=eGwH=TD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A625C43219
	for <bpf@archiver.kernel.org>; Fri,  3 May 2019 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6C2081C
	for <bpf@archiver.kernel.org>; Fri,  3 May 2019 10:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rNyO6h4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfECKoL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 3 May 2019 06:44:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34199 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfECKoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 May 2019 06:44:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id e9so7290589wrc.1
        for <bpf@vger.kernel.org>; Fri, 03 May 2019 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XP0RwQbziCxRtw0HK+xAhkTdFI68wuwmjjzs474PFlM=;
        b=rNyO6h4PPVEd5LaW8uo+Hd9Gva2gPEgs+27p47gm0YHntR3EHW33cAjYQ5eqKMB/jZ
         ZMXRQf1RQcmoFqKXUggTCuztk1f7dNCggtNsW5Yz9p5caGPkPmLxLd+7cHyYYlUJ6p3t
         L08rRUD4eWU8CO9s2+IYns08RCHD/2f2TxlSdXtYEA5lcyBcGceVymA4/EsoAEzVjihO
         cr6SXmoGa1/vQkbfswlAQmCZjM05N/ZRmgzksocw6ZVR0qcgDhSsB4dw+Rtjr94ZRu3V
         719rzDuZ+2fURgvXD7Mnm4R1EVmuE7wDIzJ18O1JSBeeBjx9XAYXgwDDS8pylksnPRx3
         O/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XP0RwQbziCxRtw0HK+xAhkTdFI68wuwmjjzs474PFlM=;
        b=cf4HvcjyAHuuL2t2jcyeZUr/l+7rT3HzwXHAVuks7F5slvj12yY2ar4AEBfZIJ+omq
         ovdiUgge8kD1mvqpsQeN782U948D8VrthHVYei9NY4ndhUI/3uugunbBlVpJAAfLXgBL
         4FhCGienXcbQ4ZF+3EFZV2f19MCYncBZPxPhjW6lPMHzeIA/SyWltbYRbD5tyJ5oKDny
         PYJj5s/DEtWCEyxrAfxgoLp8gCe9ctRJrwCvhN0jGBJOmx8ZX+PIrEFEW++Sz6RiWrw5
         aqig51B9hWoqNBHsx00Z7paQsRdNnI77WNSQtjlZwwI6NDTh6MTCsHSmBXDdbpTQh9EH
         Xx+A==
X-Gm-Message-State: APjAAAXq5/t4V9Hr8bCojPhNjrCv37ylSct2xdoYive1C1LwvTYpv/91
        2A5PHnjELANvXVOA5Ht8sim67g==
X-Google-Smtp-Source: APXvYqzbnZ1JAE+CniEsw6ea0nVorWFG8Rlfh2hpHw3PlZj63X3b0PMFKjAtokjYND9xpxLYoBY5bw==
X-Received: by 2002:a5d:5501:: with SMTP id b1mr2673789wrv.196.1556880238328;
        Fri, 03 May 2019 03:43:58 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id r29sm1716999wra.56.2019.05.03.03.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 03:43:57 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v6 bpf-next 14/17] sparc: bpf: eliminate zero extension code-gen
Date:   Fri,  3 May 2019 11:42:41 +0100
Message-Id: <1556880164-10689-15-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
References: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 65428e7..8bac761 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -905,6 +905,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		ctx->saw_frame_pointer = true;
 
 	switch (code) {
+	/* dst = (u32) dst */
+	case BPF_ALU | BPF_ZEXT:
+		emit_alu_K(SRL, dst, 0, ctx);
+		break;
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 		emit_alu3_K(SRL, src, 0, dst, ctx);
@@ -1144,7 +1148,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 
 	do_alu32_trunc:
-		if (BPF_CLASS(code) == BPF_ALU)
+		if (BPF_CLASS(code) == BPF_ALU &&
+		    !ctx->prog->aux->verifier_zext)
 			emit_alu_K(SRL, dst, 0, ctx);
 		break;
 
@@ -1432,6 +1437,11 @@ static void jit_fill_hole(void *area, unsigned int size)
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

