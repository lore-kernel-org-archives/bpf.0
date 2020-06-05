Return-Path: <SRS0=qrx8=7S=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65038C433E0
	for <bpf@archiver.kernel.org>; Fri,  5 Jun 2020 00:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B53206A2
	for <bpf@archiver.kernel.org>; Fri,  5 Jun 2020 00:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H93cyo8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgFEAWA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFEAWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 20:22:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB45C08C5C0
        for <bpf@vger.kernel.org>; Thu,  4 Jun 2020 17:21:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t4so9356096yba.12
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TaQs5kID7d7oKRvqLDjMcKDPKSktLZSpakjS4ZlwGko=;
        b=H93cyo8UJsvA4tSEBJRzJw5nZUv4IZSbUkVpdDMiW86FOLWz/usgL5WPN2BtL+ZoWT
         u8zi2nQEZOCHW1+kBmwlT0a+kOvKEAptSlWzamPs7ZMtXEtmgGjaMr0Dp8HzpwV4Nrp1
         pzGHyJFLaaRAVk/QY+CHafKY9IUDPAjLIfp56NxBELwmNWrbw7CQ64fch3FRCHsf48WC
         aG9+/rYOYmyjaGN6EU3axmOCY+YB98g2E6IelVprTtPP8I99tRAQRev85CmR7BAAUJ6r
         eSBRysJ2aqtS1BT962j7viyYwzLitr1bFmepgDXvgmk0Ed9jxwXdoySXKP3ewAAdPXrB
         5QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TaQs5kID7d7oKRvqLDjMcKDPKSktLZSpakjS4ZlwGko=;
        b=T1oeckc5i7iLx9k3fjPod1KuuyanKpOErRq9UviDvgOs4A4+/yNB1ZRnZYUblJWTKG
         YjqV5LzhDt3ZFn4kT2M1H5IkZikoFpRykDKUDN+W5Ki9fPk4PPsPJdFF1CI4EbgANsy3
         OFWMrxqbk/oLTu5u/VRhW0SECECRsmz608VVAoK7AQ3w5x7H/rlw4NK3v/IDJRcxj0bv
         0wXn3e0W+WQu2LWMrohivDyj6hSBUrrR1pymhPPpPA09PgD2JlHJvByj9/Oe6oTA+WfQ
         69pxgqTUscUi/EQIh2itDVsHBpwmOsHSUR+PsPhsYgRJI8pehucBP+6n1umkVUZFrRF6
         XmHQ==
X-Gm-Message-State: AOAM533VKxp/eJl4ADLuXv68QPVyV2pgsjD6e6BGb2Cjhjm40V4AunRs
        MlbZzWDYbbGDV+VwGu8qt0rOt8I=
X-Google-Smtp-Source: ABdhPJwMDQUiAnfEgRN2BoPavMRQcDWR9n7aiTAoZjqVMNu+WmNw/wtsnfb3BJdPoSvlVHMIIlrLGxo=
X-Received: by 2002:a25:9d86:: with SMTP id v6mr12109026ybp.322.1591316518065;
 Thu, 04 Jun 2020 17:21:58 -0700 (PDT)
Date:   Thu,  4 Jun 2020 17:21:55 -0700
Message-Id: <20200605002155.93267-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH bpf v2] bpf: increase {get,set}sockopt optval size limit
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

v2:
* proper comments formatting (Jakub Kicinski)

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fdf7836750a3..fb786b0f0f88 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1276,7 +1276,14 @@ static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
 
 static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
 {
-	if (unlikely(max_optlen > PAGE_SIZE) || max_optlen < 0)
+	/* The user with the largest known setsockopt optvals is iptables.
+	 * Allocate enough space to accommodate it.
+	 *
+	 * See XT_MAX_TABLE_SIZE and sizeof(struct ipt_replace).
+	 */
+	const int max_supported_optlen = 512 * 1024 * 1024 + 128;
+
+	if (unlikely(max_optlen > max_supported_optlen) || max_optlen < 0)
 		return -EINVAL;
 
 	ctx->optval = kzalloc(max_optlen, GFP_USER);
-- 
2.27.0.278.ge193c7cf3a9-goog

