Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902CCC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9A02075E
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrZ12Ype"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfC0Nwh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:52:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36886 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0Nwg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 09:52:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id q6so3356396pll.4;
        Wed, 27 Mar 2019 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JdAwqw+SZU37QvtZnlrcjekP9weXgvvYemjbEx20cs=;
        b=UrZ12Ypex7bJLF7qmkEVFB/PSyN6HQij7XZAOsknZ4bxjZVSsz8+oHydbF4iy8cEUr
         aRqv8GPuZmccdzLBuXK+p4TDIoJuawewXIunhw9/KhuwUb4LFz7AKW60k0Q7l3pQ5J7A
         slxotPuRHe+QroACI1hgdqaMpORHxQu2IF21cvfHsCLuCfb/9fKTXmYvOPIToHWxFK+X
         uIlCkVmRq9sy/D1fCd7zHCgBtDvF8FE8Cx5iW1XyxhWwMPPNxTJ2CoCm1io9ZRnlQMih
         HTIYw+jq/kML1ZvPMn3TLtM3DIFdjO2lTeBjqIwJ9HBOKyGvKwXbgdyprWgHax35ckt3
         OoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JdAwqw+SZU37QvtZnlrcjekP9weXgvvYemjbEx20cs=;
        b=lee7bxrBLaGvCgoyDAiHpidZ5YBU2rOpYg8NgU6SU45q/S4UWv+ndRq4F9LUr0GydY
         BdWwD8LGq1Q3+B6yHovzUuCAAwHrMdxinC2iy6qlaEksC+KiQBUIEXDWPTNuhtjs6zyB
         P9I+8q+JOyk2oEZU1NNfhTmDOqI/eIjruIriKgFW7wPJ4mQ4uu3iDsJGGFcUg5sGIscX
         d5BYLEf3kysMqvcRuOCLUV9QHZ+SfGkcfkxUJlp5Rz1i4qD8PFjUgBUmk8t06DFhQ2t0
         P2z8jOM6rcAR5/Q4tDpywwbPMcYsINo0ZBsGcpVI1+D8qox+aMTGdzsV4IUhspwAACuw
         KUNQ==
X-Gm-Message-State: APjAAAXFbvcAWyL/EcipJTyYHMepik+SNf4vcmh2vdk4kwf4zfXPqoz1
        AYWtBpTTeAE/gMooqgi4zco=
X-Google-Smtp-Source: APXvYqwcPGBRSJNX+T6/6aPzRnKutqul4XGrRBk7dw40IgN5RR7bMNvqsEjU1A8lIsANEaQl7VPdNQ==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr36134663plb.59.1553694756298;
        Wed, 27 Mar 2019 06:52:36 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id d15sm6823571pfo.34.2019.03.27.06.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 06:52:35 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, bpf@vger.kernel.org,
        xiaolong.ye@intel.com, qi.z.zhang@intel.com
Subject: [PATCH bpf 2/2] libbpf: add libelf dependency to shared library build
Date:   Wed, 27 Mar 2019 14:51:14 +0100
Message-Id: <20190327135114.17026-3-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327135114.17026-1-bjorn.topel@gmail.com>
References: <20190327135114.17026-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

When libbpf was built was a shared library, libelf was not included in
the linking phase. Since libelf is an internal depedency to libbpf,
libeld should be included. This patch adds '-lelf' to resolve that.

Fixes: 1b76c13e4b36 ("bpf tools: Introduce 'bpf' library and add bpf feature check")
Suggested-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 279589c29983..7beec4d5b522 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -177,7 +177,7 @@ $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(VERSION) \
-				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(VERSION)
 
-- 
2.19.1

