Return-Path: <SRS0=+bqE=YK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE45ECE58E
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 15:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D4D21835
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 15:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2XyWna3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409408AbfJQPAy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:00:54 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:35331 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfJQPAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 11:00:54 -0400
Received: by mail-qt1-f169.google.com with SMTP id m15so4062816qtq.2;
        Thu, 17 Oct 2019 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F1lqeUF4eYaIZsid524XxMao/krSOB40UF5+S1hEV9I=;
        b=T2XyWna3C2o25XSGB9L29eUhNW8pkBLNz3dhptkVgkZKzMfLjR6vDXIfkE+nuKb4dY
         /4ySHoxkTSvdxpoOZhULnpRv3NUmCVYdhIFKWff6zsbDO0inTapQZlAZMUnU/+72Bxl7
         qGEL5cAiI4XFV0MlA3WiVFVPZsDOECFwj21X6agb19YBR73GSSdbvnf9hfCOrOFLgB0s
         Poq1DhSLKS61bn2hz5weu/KmfVFUMxHK1GgpvBkQvV8gft6r1mqanVqRfTL+hxpKoaFh
         vbZWb8p4eosfwCSjK710ITOP5wz/BKphoa9qfcYnU6TLSbsUfBU0Q0UjthgcafFMYTkT
         jUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1lqeUF4eYaIZsid524XxMao/krSOB40UF5+S1hEV9I=;
        b=uBs87DsJ+DfujPNpWkPqS33cXpMLs8PlbeQ4VJNSv5OWQW3Vu0GAsQUPySTB9tAV9x
         NY0N36MYU4O2dWQHK21q0xLvISZdk/n/biV7SplAQSf1HqmY0xp1kbD3RKokfnSKFSD6
         jvjQULjLVX9khm9IgMUxkkjgVO8P2emw6UbnLlSpbIJoKNm84W9zKorQWV8nTV5s/UyD
         fE+wFaTQJELXDyDJ+2hX4+/tAEiYymV9LQpz1N3RIjgixKUnSu+zY3NnRZO5z0RaciZd
         bIzEPyh+zUSnqZ26dDWcwvORaYCDHlgeZv45AfngWXxW38mX68PLO4Vo5KMG0IyHhxn+
         4PiA==
X-Gm-Message-State: APjAAAVRkIw1iWruGllgOW/8ob9Qi+1odTuEF2eLNz+b50W4bQE9kTXb
        MjfCMSDzBfJfkLHbjxUX09ublP/qY4M=
X-Google-Smtp-Source: APXvYqzcUekTMXuZ/QYAM0Ae5m7rYcwVEZFWf0xHfrOLO+YbmA0uHLb8QIsIDS1MFlJ7w+5jdsAwYg==
X-Received: by 2002:a0c:e6a6:: with SMTP id j6mr4294073qvn.74.1571324452900;
        Thu, 17 Oct 2019 08:00:52 -0700 (PDT)
Received: from ebpf00.byteswizards.com ([190.162.109.190])
        by smtp.googlemail.com with ESMTPSA id z20sm1550859qtu.91.2019.10.17.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 08:00:52 -0700 (PDT)
From:   Carlos Neira <cneirabustos@gmail.com>
To:     netdev@vger.kernel.org
Cc:     yhs@fb.com, ebiederm@xmission.com, brouer@redhat.com,
        bpf@vger.kernel.org, cneirabustos@gmail.com
Subject: [PATCH v14 5/5] bpf_helpers_doc.py: Add struct bpf_pidns_info to known types
Date:   Thu, 17 Oct 2019 12:00:32 -0300
Message-Id: <20191017150032.14359-6-cneirabustos@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017150032.14359-1-cneirabustos@gmail.com>
References: <20191017150032.14359-1-cneirabustos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add struct bpf_pidns_info to known types

Signed-off-by: Carlos Neira <cneirabustos@gmail.com>
---
 scripts/bpf_helpers_doc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 7df9ce598ff9..d42eb185810f 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -450,6 +450,7 @@ class PrinterHelpers(Printer):
             'struct sk_reuseport_md',
             'struct sockaddr',
             'struct tcphdr',
+            'struct bpf_pidns_info',
     }
     mapped_types = {
             'u8': '__u8',
-- 
2.20.1

