Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C8C2D0E4
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 00:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A3B21D79
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 00:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BhQEmLVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMA7j (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMA7j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 19:59:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345EC0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 16:59:39 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so7958570wrx.5
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 16:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUzaJ8EeMucOBsVFqVgnjqj6uVdboqkKaNck4oy6TCM=;
        b=BhQEmLVS8QvaL4usGLTz03Q2p3nCy3Q2M2mt/Ke8s9PkBHv/+YpDoE9ciVvqZVZxgm
         ibT3BuXwzKyldbeNBbfKZrWd6xTBZ61kDcYN8fNfTZJNC+sgVprF49qFMeY07rGu0MiC
         PGfk/rIPDzQhjhdwu76hfGJZHdHeF7yhOAwgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUzaJ8EeMucOBsVFqVgnjqj6uVdboqkKaNck4oy6TCM=;
        b=Wd0yX9NQyNQXxrSkRca99zHt8E3EK5pmpzCdsRchGg1r5OV5GA/OaWS0ZVgAcWWL6n
         7FixVP61z+IsLaMYdPeCgrwyR3q1lagQ4OFyUVOpQ/4DTy+xvELpEhT+enh3ipMalsn+
         yH4/YbBp3Wpxb4v03T2vDwPTrglGeN0Zo9OSCU9MVGS86lvS06xJNfeqJLVeO1pn6VgG
         VbfHm3Abj+XavDDHAb5EHlRqKIeS5Ilku+Gjvkew4rzAh0zMjLQ/Ir5+rfgWCeH+44VL
         aJAQp7nbApPV1X3UKV5bOh/5js3FAomnFJ10VRlnm0yMUVZhNNtzD908vPA/QpMaXJsp
         d0uQ==
X-Gm-Message-State: AOAM532reSNBGY3hAFu1E0oUPxZMRtZRAoCX3qK6kaVwZBHX8F+Xkqzv
        7ZDO6kSpNFObUZl1H4IkwkjUIQ==
X-Google-Smtp-Source: ABdhPJwT/4eiKGRT5v/QCR+GVLnIIbBdMu7AYCziCtPSsmKFM6kn59mviL6UbKz5M6j7M2GKbpNSdQ==
X-Received: by 2002:adf:fdc5:: with SMTP id i5mr2668465wrs.26.1605229178129;
        Thu, 12 Nov 2020 16:59:38 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m3sm4508104wrv.6.2020.11.12.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:59:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 0/2] Sleepable LSM Hooks
Date:   Fri, 13 Nov 2020 00:59:28 +0000
Message-Id: <20201113005930.541956-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v2 -> v3

  * Remove the list of non-sleepable hooks, will send a separate patch
    to the lsm list based on the discussion with Daniel.
  * Add Andrii's ack for real

# v1 -> v2

  * Fixed typos and formatting errors.
  * Added Andrii's ack.

KP Singh (2):
  bpf: Augment the set of sleepable LSM hooks
  bpf: Expose bpf_d_path helper to sleepable LSM hooks

 include/linux/bpf_lsm.h  |  7 ++++
 kernel/bpf/bpf_lsm.c     | 81 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c    | 16 +-------
 kernel/trace/bpf_trace.c |  7 +++-
 4 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

