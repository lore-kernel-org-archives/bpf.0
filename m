Return-Path: <SRS0=Mmu5=7R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB9EC433DF
	for <bpf@archiver.kernel.org>; Thu,  4 Jun 2020 22:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0216206C3
	for <bpf@archiver.kernel.org>; Thu,  4 Jun 2020 22:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+lDtnxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgFDWbd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgFDWbc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 18:31:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99528C08C5C0
        for <bpf@vger.kernel.org>; Thu,  4 Jun 2020 15:31:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r18so9702385ybg.10
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tEqdbAS6ONuHBbIUsfUCXf+9mr+o3WQlFUIgfiUHXaU=;
        b=K+lDtnxVk7mR38vMVKmIdpPeoQYNhxQCRBrLtuSQRuBj1D1BLEa+5OuFLHStCbC1bL
         XY2nYzJIo6EIVlZjvsqOnKNqO3DMHiuhjQCCiJH9k2fDz7GkRiR4MrBzxAV3WtsuSbBN
         lbIPL5BoV422L3U60CmkWItYjvSn1OgJl8AmOxoAMmniHHKmTmTmCxn4vGyUSG1EaGXY
         d4Gdmg/iFNDuHPyl4CBWRSccZ8r2iNnpULJeT5l71JinRqEOhjEtGFdbJnH5rnEJGMaS
         ZzXzbQIYCH3031zfP22N94/iKsr3S2sdyh1ULwXAg7WrMZamZ6gJD9G7zoBkHn/dsgtS
         DFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tEqdbAS6ONuHBbIUsfUCXf+9mr+o3WQlFUIgfiUHXaU=;
        b=GHvKQMAHhTWPnrFVw8mJF+xYLYgWP2YRwsoS8b/8UwAZOADS1vG/teiHXiHaH+lJoc
         /shn6le0YHMzeEOw00u2q1+TPtD9iHxfdeVar9PhyOTWVvP9+GAhY6FB099YFQHZwRql
         974KpxDVylSiKEIuABk8gjPRUqDf3T2sCK6qpuT4PR0Mk50+OBqUKF7bPl7jDxztTQEK
         YpyIuft7kCbAz3A14CBJGQghv0gY9zRelFjXO3AyMWTiX32sJ1QgixwMZT9Lf40djNKo
         Gv4ZGXgBWUvvINtVjuf70rS9s2rXSGKaB47Ux6KOL/Oa4b6JcI7tqiJ6RDA9y4glNZuV
         y1IA==
X-Gm-Message-State: AOAM531YTMJKyCW3dtbUZ6CLKIlxFdVUflm0sfUOSVm19MBo1+F9e6wZ
        buiklSynTXESOazdK9TBrFf/0Pg=
X-Google-Smtp-Source: ABdhPJwDqr0Vi2rWDXqhoSxldBN6tjCiHy/wEB/wKOtSXkehsauwS/YToZxFvv+Xf3M4OE5NxEttxjc=
X-Received: by 2002:a25:4cc6:: with SMTP id z189mr1999878yba.153.1591309890935;
 Thu, 04 Jun 2020 15:31:30 -0700 (PDT)
Date:   Thu,  4 Jun 2020 15:31:29 -0700
Message-Id: <20200604223129.46555-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH bpf] bpf: increase {get,set}sockopt optval size limit
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Attaching to these hooks can break iptables because its optval is
usually quite big, or at least bigger than the current PAGE_SIZE limit.

There are two possible ways to fix it:
1. Increase the limit to match iptables max optval.
2. Implement some way to bypass the value if it's too big and trigger
   BPF only with level/optname so BPF can still decide whether
   to allow/deny big sockopts.

I went with #1 which means we are potentially increasing the
amount of data we copy from the userspace from PAGE_SIZE to 512M.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fdf7836750a3..17988cacac50 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1276,7 +1276,13 @@ static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
 
 static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
 {
-	if (unlikely(max_optlen > PAGE_SIZE) || max_optlen < 0)
+	// The user with the largest known setsockopt optvals is iptables.
+	// Allocate enough space to accommodate it.
+	//
+	// See XT_MAX_TABLE_SIZE and sizeof(struct ipt_replace).
+	const int max_supported_optlen = 512 * 1024 * 1024 + 128;
+
+	if (unlikely(max_optlen > max_supported_optlen) || max_optlen < 0)
 		return -EINVAL;
 
 	ctx->optval = kzalloc(max_optlen, GFP_USER);
-- 
2.27.0.278.ge193c7cf3a9-goog

