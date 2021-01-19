Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F31EC433DB
	for <bpf@archiver.kernel.org>; Tue, 19 Jan 2021 16:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A9F216FD
	for <bpf@archiver.kernel.org>; Tue, 19 Jan 2021 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbhASQB4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391648AbhASQAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 11:00:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1974C061757
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 08:00:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 6so12967373wri.3
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3ezeIdxQA6HUcVbMIawXV4uO3GjVDrBBcxqIn97pLo=;
        b=jOWsETPqtvTAzVk6EYslXWIDwS+h+JvNnbmzJZvezK6Wlk5xd1fYpNplpzhowgQF1V
         vCX+AcpJKRCFwa28WJgLKIvITUwPH3HpY75tlBJhgqnBhEKqvrGL8V0UNXc+dTgNqXsJ
         g7/43H1wZhd4Gr+wynZKkeLoD+VlpVULR/glo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3ezeIdxQA6HUcVbMIawXV4uO3GjVDrBBcxqIn97pLo=;
        b=p43L7VvllZdKeLQi00Cv/R6OfvWWdFg5nPRzHIhlCTf8HHH0o6Haj54akMzwkhvc6f
         H8fylTS51qJGp0qK7YBezIbS8heXFVzbhFX7jBAB+WM5oL7cye4PyuXZZi0iZFh/eKSS
         gd7E2oUpYFFY3h1u5NMIIkb0kG67kyLPXOVJtvjk6caDagrIId3pWeS9wGXsxdIdO99v
         uTV8kYOOudNN7dNWYKlqVWpR5svuXr/0qVfnUFlsb85ZlAjCOaJsxKEzjePdYgCT7iV0
         CpKw/Xe/ybcyVmWZw46Jq77e9u27cAXjW1m26/WWAqGx3aO3sA8DdLbSw3WnEa4Ghm71
         sTfA==
X-Gm-Message-State: AOAM5306oaOw4MTRxOvc/GFA3m/RmgZuwl+Z2aub/iamkQ+vPe6kzXt/
        otJPhg19SHot9AUDSTzuKoJ77SY+Znrpbg==
X-Google-Smtp-Source: ABdhPJz+zMVRPSU1xDf7RAqAN5YPaoXl4ATKLsoGaK//5SSwMc+/JfavDapDnAlh9I5ujwLQaPg4Cg==
X-Received: by 2002:adf:f6cc:: with SMTP id y12mr5038792wrp.35.1611072006140;
        Tue, 19 Jan 2021 08:00:06 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:81f8:2ac6:58bf:7d7a])
        by smtp.gmail.com with ESMTPSA id n11sm41454944wra.9.2021.01.19.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:00:05 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 1/4] bpf: Be less specific about socket cookies guarantees
Date:   Tue, 19 Jan 2021 16:59:50 +0100
Message-Id: <20210119155953.803818-1-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since "92acdc58ab11 bpf, net: Rework cookie generator as per-cpu one"
socket cookies are not guaranteed to be non-decreasing. The
bpf_get_socket_cookie helper descriptions are currently specifying that
cookies are non-decreasing but we don't want users to rely on that.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/uapi/linux/bpf.h       | 8 ++++----
 tools/include/uapi/linux/bpf.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c001766adcbc..0b735c2729b2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1656,22 +1656,22 @@ union bpf_attr {
  * 		networking traffic statistics as it provides a global socket
  * 		identifier that can be assumed unique.
  * 	Return
- * 		A 8-byte long non-decreasing number on success, or 0 if the
- * 		socket field is missing inside *skb*.
+ * 		A 8-byte long unique number on success, or 0 if the socket
+ * 		field is missing inside *skb*.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
  * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c001766adcbc..0b735c2729b2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1656,22 +1656,22 @@ union bpf_attr {
  * 		networking traffic statistics as it provides a global socket
  * 		identifier that can be assumed unique.
  * 	Return
- * 		A 8-byte long non-decreasing number on success, or 0 if the
- * 		socket field is missing inside *skb*.
+ * 		A 8-byte long unique number on success, or 0 if the socket
+ * 		field is missing inside *skb*.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
  * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
-- 
2.30.0.284.gd98b1dd5eaa7-goog

