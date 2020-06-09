Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21615C433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16F32064C
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 11:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVE/MUme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgFILjs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgFILjk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 07:39:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6451FC03E97C;
        Tue,  9 Jun 2020 04:39:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w1so20400311qkw.5;
        Tue, 09 Jun 2020 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UYWL4b+Nksdqw2T1bjsF7nZO4cYFZU9p52lDBPWks3Q=;
        b=EVE/MUmeNfXmLgTiwN5/i+wciCoKUwFN5h7WteGzb3uFj47uWistcYYVYgoLIMWUya
         0mdzYDev4qaM1LIeOsWOR/IiRRiU3mULp01mh1rDC02Tfxfv2jNZc0MJXYFF8GNVnm91
         mxx3fB9LaOjpzYVgDRBBPNrORD1BO1Z1UV4og/HwThZjR/UI2jPpqXGsxtd6pmvIIiBp
         or7N5kR1jTvcexoFpu8lI9k9fdPCd06yQ8BhwvP49VfTjtVtCJZ5i3MQEo9YPcdQBAeV
         hA3ufNs7D+YD7QXrSczACvOjUOLw5kdKRhU6g8xPesviG7SZKD2icTbCT8jm0s4Ylx9j
         oLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UYWL4b+Nksdqw2T1bjsF7nZO4cYFZU9p52lDBPWks3Q=;
        b=U+qDKnX0hArrIFGWuS/SeUd4kDwOskap4+DZ44zoo22f0NOoVPOP9RrvPSkfUh5t+m
         cN8cgt82tbLg0h/ZJgWNjsLww7ScHpp15RhxHtgam0Cl5QVnzBIbn4qIR7qYjXfaOcmN
         5TJRXv9/6ILYzrf/k/TMqhqg3ze1KOYE0H3y2BdG7yz1Cey+qe6Nl2Wz/DQY4yOC/Q2g
         ZjXt13NBgrKd9tshMfOR/+XnIC/xeR6DiUcvSS50xI6gegtSk26l5m+TySqdbaZ61ki7
         Hm1xeQjCI2uADSSTxiI3ULHQcX/JGnLDbPYj98T8n4KFX0XXCX5UsTs/WdISqo699Ukc
         WOow==
X-Gm-Message-State: AOAM533v/pLyFXv19JkVromjWFdL5GptFUwr2T65GDiZ/fXQ9lKbQN2h
        ysxvjKGgHtcJhPSkmRnRemU=
X-Google-Smtp-Source: ABdhPJw82gvLnPVRojON5y8/81l8qJFH5PwKefp/eQWm+pI3IoYi1CfHo4jZKwrlXaPWYhQlnEIoCg==
X-Received: by 2002:a37:a504:: with SMTP id o4mr26378752qke.245.1591702779549;
        Tue, 09 Jun 2020 04:39:39 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:29ac:7979:1e2e:c67b])
        by smtp.googlemail.com with ESMTPSA id n13sm11281614qtb.20.2020.06.09.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 04:39:39 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bpf: alloc_record_per_cpu Add null check after malloc
Date:   Tue,  9 Jun 2020 07:38:39 -0400
Message-Id: <20200609113839.9628-2-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609113839.9628-1-gaurav1086@gmail.com>
References: <20200609113839.9628-1-gaurav1086@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 samples/bpf/xdp_rxq_info_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index 4fe47502ebed..490b07b7df78 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -202,11 +202,11 @@ static struct datarec *alloc_record_per_cpu(void)
 
 	size = sizeof(struct datarec) * nr_cpus;
 	array = malloc(size);
-	memset(array, 0, size);
 	if (!array) {
 		fprintf(stderr, "Mem alloc error (nr_cpus:%u)\n", nr_cpus);
 		exit(EXIT_FAIL_MEM);
 	}
+	memset(array, 0, size);
 	return array;
 }
 
-- 
2.17.1

