Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F9AC433E6
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001BC64F2B
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 20:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhCRUWf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhCRUWb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 16:22:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF2C06175F
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 13:22:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b9so6001959ejc.11
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDQUUl0OJbbj7hQ7QruZ741g0lQKhZLXWiJasbPlpi8=;
        b=egP+/AFl5Zi2ekCcC+yCqSkeF+oYGgNTKyL5vBeqMkwfOTQQqyZa8DJPfvvXBd5Js5
         cIXi3xIR8hs0vPmSGSFroJD7kOY9OyB/NKk+zv45i42HNMeXO4oTT0ymRL+M9gGAgjmx
         hlct+yRWAKTMguwQFyHwrUzPT9b1n3+QV313s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDQUUl0OJbbj7hQ7QruZ741g0lQKhZLXWiJasbPlpi8=;
        b=dBJ1fW13iKNPqtpRQpeHi6LZTL5s01cl4GFESgH/uvvIKn70S08trFhJXxTjxILkwk
         35DMVzbn4t7GzaVTcuBOFlW3xOVG2mAPobzuFC3GHebEpDxSHoV3vKz74jmdAB3rL5Sf
         /84nZah50k0cXWqWXYoLTI5zUprdJYb9Hofr/pXaMD37kDyXDu/vlN3L7TLCKEfsGDcC
         BSqWNnRJFm6dKq1UspH8M07rg+fVopW1yftjhmYGBp7pwrbwgHJXFSxB1mS4jz3Djh1h
         ypqVpbEn+JJYulPSiYwt3lexFfLuWsWu3GtVx3iUGQCQlFdmXHCLmFjcao8aP6fN6wCb
         4aAA==
X-Gm-Message-State: AOAM530WjmPy2TfziT+9oa8bxXqH0z3GFAO4vaDT2ayOjn7nmC3kYRTc
        sFY8NXHSAMSWSS1xTKU/+XjA0A==
X-Google-Smtp-Source: ABdhPJy5SB/+YoZPVl+gwhqIvgepReLAp+sL++qZjzTKHqR+vgURS/echoF0ioMPJaV7LxHwmdXnBA==
X-Received: by 2002:a17:907:b06:: with SMTP id h6mr411243ejl.144.1616098949492;
        Thu, 18 Mar 2021 13:22:29 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id e16sm2481120ejc.63.2021.03.18.13.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:22:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     trivial@kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>, bpf@vger.kernel.org
Subject: [PATCH 8/9] bpf: Fix typo "accesible"
Date:   Thu, 18 Mar 2021 21:22:22 +0100
Message-Id: <20210318202223.164873-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202223.164873-1-ribalda@chromium.org>
References: <20210318202223.164873-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trivial fix.

Cc: bpf@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cccaef1088ea..c4c8f3522594 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -54,7 +54,7 @@ struct bpf_iter_seq_info {
 	u32 seq_priv_size;
 };
 
-/* map is generic key/value storage optionally accesible by eBPF programs */
+/* map is generic key/value storage optionally accessible by eBPF programs */
 struct bpf_map_ops {
 	/* funcs callable from userspace (via syscall) */
 	int (*map_alloc_check)(union bpf_attr *attr);
-- 
2.31.0.rc2.261.g7f71774620-goog

