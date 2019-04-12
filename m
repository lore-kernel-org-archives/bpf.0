Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75466C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A41218A3
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="GzYIX3VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDLWAe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40037 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfDLWAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so12734517wmi.5
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FyyxR9Iqk6cAH0oBjCaJb0bcVV0NGMOOW5Oun5gFHdM=;
        b=GzYIX3VKctvBc2dtvJ16iqFpJneBC6lA4gUWtjc4rDtUOyQDQACrJmf/ffwJ/17EzV
         ryGcqB3E2HZ4BG8zvj+sP8N4BBxHxsD7pf3VYeMnAkK6wuMg/MbA2DflQixp+7kODyVM
         Bl6A55sxVt8IowrKxGEos7H1WUAvDnRH0uOy3wfbV1FwyRG7U8xfuU76ES0Xjtl6+QUu
         XyCAtbuprm0xyhRgICR9aahKf5z3vZ+21dWQVZND5Uz+bkUizLbOWRvFVeThJXcV9w8+
         cOA1MRnRirYz0uHTiOxPVAS/gda1ySbVyrLG8TN2/WmHWCZFaiRPpvFU2wCIUz11Lvh5
         FVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FyyxR9Iqk6cAH0oBjCaJb0bcVV0NGMOOW5Oun5gFHdM=;
        b=jin7wFEGgJv5+AR7Nk0/mSb3h79tXNws0p8c5uK/gAqdy2s/4WDiGFVNWy9ag2FH6l
         ANI4FDYwi+PCNGKms063Bh8/kb4VjkJKEX6rpMMv2fy8Ch/kJTzT8QdhMggj88/KwS2t
         huaUheU3evwTps9CssFaoTi+Ri+AGcH41+H+TqXrRGmYMN/dYxjEw8979wqpKPX9t3+I
         vPCeLLpbwsPV4Gmt1RbJNSMjLRdGJyyYQRKdtl/PCj8p1MRSV2RiRFrbweMj5ZVecsHH
         bOQ2FGHWb8hX0wFZ9kYDZXkwKAfSFyc+CASKvpJNtnJF0kKYbOfNCICAKp2cRR0zPIp+
         eaXA==
X-Gm-Message-State: APjAAAWznzGE4qTFaXCs1Lfr9xZFvi4uil3yaBMYXGszSfoOWJvr635v
        tK0j96OpQoloPlwe1Src8N2euA==
X-Google-Smtp-Source: APXvYqzC0PxQp0Q/y1dMtjmEK0vjYwZU7d77qu34HT2P4CZAC2TdvSATMtk7FNbgkx7ih4A0kwZilA==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr11850480wma.99.1555106417615;
        Fri, 12 Apr 2019 15:00:17 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:16 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v3 bpf-next 14/19] powerpc: bpf: eliminate zero extension code-gen
Date:   Fri, 12 Apr 2019 22:59:47 +0100
Message-Id: <1555106392-20117-15-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
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

