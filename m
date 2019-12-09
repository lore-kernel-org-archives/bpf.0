Return-Path: <SRS0=w0EI=Z7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E7C43603
	for <bpf@archiver.kernel.org>; Mon,  9 Dec 2019 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8002520828
	for <bpf@archiver.kernel.org>; Mon,  9 Dec 2019 17:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uS7kguZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLIRcL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:32:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45491 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIRcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Dec 2019 12:32:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so6073105plz.12;
        Mon, 09 Dec 2019 09:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJx1gb7dyIux/wvtlAjUM4Ul67VDqBxG4kjHz1T/apg=;
        b=uS7kguZbewotiewe3eNEHiAYQ1NBG4BmutBfowVjnF3VSkL7gmTKFZI1qF19mjsr7U
         5Ymr+omBiK4cAUBfSnV7+LszdqA+5WKxmsJQPsh1nWll88ySD6QpGmUEVspEOECCoazn
         ksCs2t465xw2OIIjFykCvuSH2f/l6AHW15B/bMSIXzYmku7qq5PQJxVBwFHHqEEEIJf2
         lcBEpY62ERPEUolysJgD7ieIuyWWFH6st04PLD881a9iHhTgiq1ezMCQy+k7i9Kccdxs
         Xy0jnm0HdR+Ci0bYEumQQ43R2A8zgVWjnPvVyqCmlkjf9AE0SgiTdy2UDK2cx9hPyCgq
         qhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJx1gb7dyIux/wvtlAjUM4Ul67VDqBxG4kjHz1T/apg=;
        b=QIzHPO6OHeD62QtqlKM2m+G+UseHJuXNaG1UZpNsr6nly2A4PeNeDdVsTT3eV+x8g5
         9atTKXl/YRb++2FLVuVvhkTM5zt9yxXCc3MCH/3C7d/1LLnsrepHqAHQhDBkyAl+4Gic
         se+M9vDoK7DflAXO818DajMlsuoXk6OlTkzR/TmvKJQToTz1GeIMChydmxCv2i4Fi6/6
         Mkc9cSd3Js5uawvgZtN8g76MXBDXnJUEV1MjtxoxpG5Otw/WdsIGWd5JRGkMCIYMmrE4
         AyovIMDw8exPHL0hiEryCZdIOajEcUGw47RiMe+hY40nCNAuQVyNRKbjoGDY4Q2DUBOR
         9a9g==
X-Gm-Message-State: APjAAAX3r360Ok5Jo+VrnzptN86A71MHK4xqBp1zC6P9VYEB1PETU7kS
        qA4z94KXy+8RRdFFciCtI3I=
X-Google-Smtp-Source: APXvYqy8i85CXpsfyv8dckCdsUg7eLteOhLSNdZVYk516MDZYXdwuPo9V61Bsf6Mk2ZN6V00qpmncQ==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr156393pjq.11.1575912729718;
        Mon, 09 Dec 2019 09:32:09 -0800 (PST)
Received: from btopel-mobl.ger.intel.com ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id d23sm54943pfo.176.2019.12.09.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 09:32:09 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next 8/8] riscv, perf: add arch specific perf_arch_bpf_user_pt_regs
Date:   Mon,  9 Dec 2019 18:31:36 +0100
Message-Id: <20191209173136.29615-9-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209173136.29615-1-bjorn.topel@gmail.com>
References: <20191209173136.29615-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

RISC-V was missing a proper perf_arch_bpf_user_pt_regs macro for
CONFIG_PERF_EVENT builds.

Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
---
 arch/riscv/include/asm/perf_event.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index aefbfaa6a781..0234048b12bc 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -82,4 +82,8 @@ struct riscv_pmu {
 	int		irq;
 };
 
+#ifdef CONFIG_PERF_EVENTS
+#define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
+#endif
+
 #endif /* _ASM_RISCV_PERF_EVENT_H */
-- 
2.20.1

