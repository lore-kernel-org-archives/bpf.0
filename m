Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A6FC63697
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0238E246AA
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 16:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGu+7Bf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKSQ1g (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgKSQ1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 11:27:36 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F6C061A49
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 08:27:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so7294606wmb.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z36MlF26WgWXOikzwPdY6S4xLAQhn1npxSnvJNteclE=;
        b=fGu+7Bf2lyWU/lgx4K/qS0Ycvfcqw+M6On5Tb5RL0jM+IkZKCmP9vLsbL4zJRFes3M
         l+Ll2BcApNvJlfdn0KlrAn5iveQ6/KPXJhXMDSoBGy0cuMyV6srYTnOdHfpkc0KxL9Xi
         Kje/Norox0GHxKdLiAEvU8gDOm43OPjQYjC1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z36MlF26WgWXOikzwPdY6S4xLAQhn1npxSnvJNteclE=;
        b=P0wfVuD7kI4AiHQlCLa+skcwzVxB9QHlFS/R/j9RonM5Za6AZvOoFlrvf90P0pKve3
         JHEt+fU819bWvImx1CVOuaDWsGed0gyZEw9LUsd3SjI8C/6VI2FN7hYWwOs5gVp2uTVv
         TQic5ML03lkhL1OiKkjX00ubXZw3zrUZpxlY2s2KYDFHmUe3qCO2JI0scXdhNz3CUbX+
         mGgs4Z/wA9sYxSMOZH9oMJiBf7PUC01dxcpD9OY4Xp4C9fJ5sNS1/+s3EzxEGNcZUU/h
         IXDayvzjABdm7c66sRCE3S6bZTOn63wBPr6kuaGCkW3HSY3XaMn2mnCfyuETtufKHc7G
         bgcw==
X-Gm-Message-State: AOAM531ocW/O3T/zkSC1CxSN7yFJnCgV0Q5KnTuQQLv3anDFN4HfzOEy
        jM6IItooD9z46Sslkq2JKCjap1UZ0BFJn+OY
X-Google-Smtp-Source: ABdhPJwzpEf8BMNhQktHP9wY1hZnvZBrQH11aEU7uxGK8wfrft4HifITGFcsDcw+G1QgAaS0oSAxkA==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr5350605wmi.75.1605803254062;
        Thu, 19 Nov 2020 08:27:34 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id i5sm380061wrw.45.2020.11.19.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:27:33 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 3/5] bpf: Expose bpf_sk_storage_* to iterator programs
Date:   Thu, 19 Nov 2020 17:26:52 +0100
Message-Id: <20201119162654.2410685-3-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201119162654.2410685-1-revest@chromium.org>
References: <20201119162654.2410685-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Florent Revest <revest@google.com>

Iterators are currently used to expose kernel information to userspace
over fast procfs-like files but iterators could also be used to
manipulate local storage. For example, the task_file iterator could be
used to initialize a socket local storage with associations between
processes and sockets or to selectively delete local storage values.

This exposes both socket local storage helpers to all iterators.
Alternatively we could expose it to only certain iterators with strcmps
on prog->aux->attach_func_name.

Signed-off-by: Florent Revest <revest@google.com>
---
 net/core/bpf_sk_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a32037daa933..4edd033e899c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -394,6 +394,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 	 * use the bpf_sk_storage_(get|delete) helper.
 	 */
 	switch (prog->expected_attach_type) {
+	case BPF_TRACE_ITER:
 	case BPF_TRACE_RAW_TP:
 		/* bpf_sk_storage has no trace point */
 		return true;
-- 
2.29.2.299.gdc1121823c-goog

