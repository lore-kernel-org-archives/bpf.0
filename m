Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD6C433DB
	for <bpf@archiver.kernel.org>; Sun, 21 Feb 2021 03:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1231B64EF6
	for <bpf@archiver.kernel.org>; Sun, 21 Feb 2021 03:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhBUDcf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 20 Feb 2021 22:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhBUDcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Feb 2021 22:32:33 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A3C061574
        for <bpf@vger.kernel.org>; Sat, 20 Feb 2021 19:31:53 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q186so10485295oig.12
        for <bpf@vger.kernel.org>; Sat, 20 Feb 2021 19:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVS2Bo58DNHtsECb89seQrO6Ji931+OCpGN4KgGwX1Y=;
        b=sqd8a2nRwvi/Aa7f2bQ+Or2/pJ/YzfGNvdGEVQtiX9FGbrFjXf8M6v4ttB+YRGLyiu
         N4nFqv0DJM3/2YywfEcZ6KtLfi1hX5lCkPv2AEJZjhACRnE77R2qJdE8H/azua0c23Ff
         A5iMKbMm29RZXMoQ0Bki0oRgRz8t/m5H4LeNVEQBibOD65qr55wRyvLzn0Jguee4QQMA
         3UP9Wug/sLD1BP7UoDajeTFmv9VC11azYmiLQ41ZK9Flj2pYRfk9pFcTBajSnWK+rgU4
         K/RDLpwhlWM4KY4Z59f3ceTdI76eJPUfGVIrGZsewErRY59wZhG9fAi63QA2+BTOYlIL
         GW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVS2Bo58DNHtsECb89seQrO6Ji931+OCpGN4KgGwX1Y=;
        b=d7JIxyKwXplUGsyXu+nnPjlTs6ErIpA/PScKRKmiv05d/Nc9DTWMupsqsCeyxtBny3
         zIYzEBv5oM6JDkn5DhG5erNXYq3O1GWVVoWnlvV+4vgT8IrYgQl648/WmG3t/S1SbeZU
         7+FFO5tiHcn6xO+WdvO5cOcQZ5K4rB8u+yC0ZNtuaV1LA+D0fdsjOl2f9aS4V9zcNKgh
         QEqEZuz9fFOSBebXg3M/1WjsdoySB3JSWZ6Uqhqh6v1yhNN2u0sjxai3VVmvRlwIrrM6
         DovnHzS1/22d1ZPGu7Fp1TyAIsccNuNHEKcBDlz0I8eFnLQ5gEBAuj+CmNVCRSkhAivq
         wCCA==
X-Gm-Message-State: AOAM531QeO7E9a16stoQbystLowADoFOgL1k98ZkQNxYEhUsIOvpFNYf
        Z84pNo0YRdsV2cAVUETGSyY=
X-Google-Smtp-Source: ABdhPJw4Gl0n+8olQ9Byv8Ezm16KroNdsABrrOiALtcM1OkOP+xmxecuMDX1KAuzSi5CpmB6akJ7oQ==
X-Received: by 2002:aca:3c87:: with SMTP id j129mr11799846oia.4.1613878311932;
        Sat, 20 Feb 2021 19:31:51 -0800 (PST)
Received: from localhost.localdomain (162-198-41-83.lightspeed.wepbfl.sbcglobal.net. [162.198.41.83])
        by smtp.gmail.com with ESMTPSA id c19sm2464155oiy.58.2021.02.20.19.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 19:31:51 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, grantseltzer <grantseltzer@gmail.com>
Subject: [PATCH v2 bpf-next] Add CONFIG_DEBUG_INFO_BTF check to bpftool feature command
Date:   Sat, 20 Feb 2021 05:13:21 +0000
Message-Id: <20210220051321.79729-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the CONFIG_DEBUG_INFO_BTF kernel compile option to output of
the bpftool feature command. This is relevant for developers that want
to use libbpf to account for data structure definition differences
between kernels.

Signed-off-by: grantseltzer <grantseltzer@gmail.com>
---
 tools/bpf/bpftool/feature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 359960a8f..34343e7fa 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char *define_prefix)
 		{ "CONFIG_BPF_JIT", },
 		/* Avoid compiling eBPF interpreter (use JIT only) */
 		{ "CONFIG_BPF_JIT_ALWAYS_ON", },
+		/* Enable using BTF debug information */
+		{ "CONFIG_DEBUG_INFO_BTF", },
 
 		/* cgroups */
 		{ "CONFIG_CGROUPS", },
-- 
2.29.2

