Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AA9C00319
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F68021850
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mS6AIzvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfB0XbP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:31:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39223 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbfB0XbO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 18:31:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id x6so11010820qki.6
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uTQMdIzdnY9lddznzQKGdsViPxNsEqhglPO+xp0Rgk=;
        b=mS6AIzvUfE6ZHJibvdUz/vyEXuyOmmTPZFM/FiKgqkzDweWabBIb8pg+kaBqPegCRU
         EsbaFtzHoxLKG7NjVcnOoR2xeho4Gh1hMA2vKfnrfnbnljT4m2QDjMa8IDoX/EvUAUAG
         jm1SuOy/OyeIumKXPFaifG9LnN4geSPQMTcD+25dWdpCkZCjN9oGxjpfLK591chQWXNM
         hRXoFYV8Iu+h+2vrJ8ceAKtcrEd0/KsHbUcu6P1HOvODlSz1dG7H5NUBqtULorEqIxWN
         ZOc9rClS8LrydT6BPTY/RLPhcuJIINdBzexXw/+gw64vYYNmqItMwaKBSzTfhj7Fe9qF
         A5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uTQMdIzdnY9lddznzQKGdsViPxNsEqhglPO+xp0Rgk=;
        b=FUGLNForT7RoYlZuDljn9ZkvkAzWoetBFaz89UfuM4diW2hbBaRwlQEUzgOBwu/Iyx
         6QlRd7QaKQJJUrb0fU8b/2uJxi8ewCbjxpfvOWqzET7vUp1bhfkI9DOMDas/OaNyDnQB
         ZGcWovtrJtvlUWd8pEY8uIk5r5Ea6LIlsGXJ0P+NPUHglkwJuEhb93vRD4/zI1o8Y3NC
         +tgz5mW3v8vXZ8uLz6P8V+zgpUhaNvtQnd+8GGKsr8DsUQ/Eoy7K6/Ak2eNbbJMOai9R
         AdcEfK3tbnyAo7s9RBZCR2yP96+bhJGDVhEP2hW3ESgHpJRwhqRN1M6HbUq2B5t6RvMk
         5V5g==
X-Gm-Message-State: APjAAAWFZf8sjnztigRHLNUD0fs6x6L4tCuoRPCJ0wKJPzSaw+fT8DH2
        82xo5+4CE7hkivqr7+/TtjrRrw==
X-Google-Smtp-Source: APXvYqydCVnUYC8uHYUb/l0fA/r72LRFZaf/XOkrqefKFPpMjhZawibhN1y/zOd4CdkdjyVvtd7MmQ==
X-Received: by 2002:ae9:ef05:: with SMTP id d5mr4340648qkg.323.1551310273128;
        Wed, 27 Feb 2019 15:31:13 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z28sm11509741qth.85.2019.02.27.15.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:31:12 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 5/5] tools: libbpf: make sure readelf shows full names in build checks
Date:   Wed, 27 Feb 2019 15:30:46 -0800
Message-Id: <20190227233046.11718-6-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190227233046.11718-1-jakub.kicinski@netronome.com>
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

readelf truncates its output by default to attempt to make it more
readable.  This can lead to function names getting aliased if they
differ late in the string.  Use --wide parameter to avoid
truncation.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/lib/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 761691bd72ad..a05c43468bd0 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -132,9 +132,9 @@ BPF_IN    := $(OUTPUT)libbpf-in.o
 LIB_FILE := $(addprefix $(OUTPUT),$(LIB_FILE))
 VERSION_SCRIPT := libbpf.map
 
-GLOBAL_SYM_COUNT = $(shell readelf -s $(BPF_IN) | \
+GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN) | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {s++} END{print s}')
-VERSIONED_SYM_COUNT = $(shell readelf -s $(OUTPUT)libbpf.so | \
+VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
 
 CMD_TARGETS = $(LIB_FILE)
-- 
2.19.2

