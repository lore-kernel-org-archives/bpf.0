Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E887EC00319
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4D218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rRCRy+nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfB1DEj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:04:39 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45639 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbfB1DEf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 22:04:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so21851922qtg.12
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 19:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0m+toNvhcpuE9D1eqkmyxgis6Re4yBVKuiek6I61BA=;
        b=rRCRy+nJMhbhmPraxiId04rMDtndxHutD/icD/6MQD1NmflGmmgXb5P84VcNz8qFdH
         nNguQ0Eo5TC62whISbRAsZV8+cD2Sc1Z5CKvV0epNGf4ZTnc3B/5JHAyJgdvu3zAQSBu
         scXyLHDM9ulTlhPscQbaNHkpsI134spGo4koGVz69xsD8GaSiu1Lhj1L/8oz7mCosITE
         DW6Jvk2ivCpcyr5AaexGnsvWt6Dg4fzBGFpWpZ/e1dYnQejlRG/h7P7uKL6FSCudjDZL
         dbinImg7wAwPqCSrSgxlhPLmfNpA7cZkwobggV0iKaS8AWMlv0MUEnr6OGHAh7iXVOdN
         Ec0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0m+toNvhcpuE9D1eqkmyxgis6Re4yBVKuiek6I61BA=;
        b=dSWL7k7GYN5zUO/dvmxvL2GfOpCiTnTe+KW1oM8m9jaymm1AOf1Nlx+cCnmVQ7sJMu
         jPZumGegvad6B1R8aHTB+OJJUHPC8v8lArMCe31toHORA3l9kyv5IjbhsR4TXVzCpJGr
         P3oXl5MRQzfJdcv0G1t0dF5trO8b6s3mplnnPCXEeAnp0ZF43OHFlyOFXwLL52LEHapx
         szUKpV+0AtLE+JUVSETBFe+sGCdUBwOkaljwQ0i4HhEqRZ4nZad8w6KEDsyu/4+rIvFk
         9rdNg8DC8MrCt9fxn/0Y3jNswkT8O1MpE6obEZoHEIQm7qssK/hrunt/pOwXlg2VlA7v
         ndrw==
X-Gm-Message-State: APjAAAV9hPGygxZS60d5EnNz2FSTFx0RmOiSSf0z6J+kOA5xYsuhR7AY
        HWk0CAT/fnqySAC7Vw0IfZaotmfhppQ=
X-Google-Smtp-Source: APXvYqyZ4b/MkeOhwgiTnjRKRa2Q+F1jfhE+Nz+5rKhv35PAq8RXTRA+mfqsIkQeW4TLLOQUoRsJ8w==
X-Received: by 2002:a0c:d251:: with SMTP id o17mr4610481qvh.207.1551323074029;
        Wed, 27 Feb 2019 19:04:34 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r44sm11242066qtb.53.2019.02.27.19.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 19:04:33 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2 5/5] tools: libbpf: make sure readelf shows full names in build checks
Date:   Wed, 27 Feb 2019 19:04:14 -0800
Message-Id: <20190228030414.18973-6-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190228030414.18973-1-jakub.kicinski@netronome.com>
References: <20190228030414.18973-1-jakub.kicinski@netronome.com>
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
Acked-by: Andrii Nakryiko <andriin@fb.com>
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

