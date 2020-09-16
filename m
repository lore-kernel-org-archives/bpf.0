Return-Path: <SRS0=xxat=CZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3945C35257
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6522420732
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 18:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="vkwKMK+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgIPS4c (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgIPRyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C97DC06178A
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so3963388wmi.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCyFS5QslMeWTOil0l98YYYoFrmDonUoF0YDrsUpPGg=;
        b=vkwKMK+OirFocAjpGC2O0sxbV/xUzlNyZG0uDDsYGN4konVYlCDEU9LggB1wf7UBvH
         85BXB2pnCVd+H9oB0VkNfVk0EYBGEw5paRvxEtEkkluHLuCM3ZM4GhfJFRcTEigu7Rfu
         fDiyXc4eTShe9dN4GBjecnfgUvboLzJT+xCyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCyFS5QslMeWTOil0l98YYYoFrmDonUoF0YDrsUpPGg=;
        b=tMp9aL/O+FN3SRCi8Xg+9yaqRQ7WL3kigY/tjPiI082gi5aqNcSovvLatzksEi5edo
         UgHwcVUnCQ/5Q5j7w4OyQioc3PSwQvYm/e4RKoykWwDjYtSwTP9ok5tvYUDq6dAZtO+p
         3o0MCPj27wxI/Y+/lVgxl8wSpwYkR4OXmct8QlMqKnddEtXHJ3QyeiGgNO2B4w8l5+sg
         dYiyp+V8TkuHsGr+3col0f2MGs9timPRGtk/dFeTl+p0XZXSr/FGh7MoH99RZyVjGplb
         ITN4Q+N3QaBJEX75pReCGNTpJKKPn1bSvi2aQueo1bs2GqUNKH1/Yv7UGDAfJ4UfEYzD
         RqMQ==
X-Gm-Message-State: AOAM533Y+TTzVK38//pftmym6TgAT/XLkC0ZgyBF0irvrT/rMTQnaFWJ
        a32qfDqRQzmpgs7lfRnoV08SzRB/VqunIQ==
X-Google-Smtp-Source: ABdhPJxl+6QztZ0Pgi/ieiCw/47tk65QOGClAJNHDLNXOZIFArvxyg2eav2JzJrUNoYLkYj8P43vBw==
X-Received: by 2002:a1c:9ad0:: with SMTP id c199mr6029361wme.54.1600278814805;
        Wed, 16 Sep 2020 10:53:34 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:34 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 03/11] btf: Add BTF_ID_LIST_SINGLE macro
Date:   Wed, 16 Sep 2020 18:52:47 +0100
Message-Id: <20200916175255.192040-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a convenience macro that allows defining a BTF ID list with
a single item. This lets us cut down on repetitive macros.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Suggested-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/btf_ids.h       | 8 ++++++++
 tools/include/linux/btf_ids.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 210b086188a3..57890b357f85 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -76,6 +76,13 @@ extern u32 name[];
 #define BTF_ID_LIST_GLOBAL(name)			\
 __BTF_ID_LIST(name, globl)
 
+/* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
+ * a single entry.
+ */
+#define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
+	BTF_ID_LIST(name) \
+	BTF_ID(prefix, typename)
+
 /*
  * The BTF_ID_UNUSED macro defines 4 zero bytes.
  * It's used when we want to define 'unused' entry
@@ -140,6 +147,7 @@ extern struct btf_id_set name;
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
+#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
 #define BTF_SET_START(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_END(name)
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 210b086188a3..57890b357f85 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -76,6 +76,13 @@ extern u32 name[];
 #define BTF_ID_LIST_GLOBAL(name)			\
 __BTF_ID_LIST(name, globl)
 
+/* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
+ * a single entry.
+ */
+#define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
+	BTF_ID_LIST(name) \
+	BTF_ID(prefix, typename)
+
 /*
  * The BTF_ID_UNUSED macro defines 4 zero bytes.
  * It's used when we want to define 'unused' entry
@@ -140,6 +147,7 @@ extern struct btf_id_set name;
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
+#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
 #define BTF_SET_START(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_END(name)
-- 
2.25.1

