Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33613C433ED
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 19:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124C960FD8
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 19:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbhDLTku (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhDLTkl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 15:40:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFADEC061574;
        Mon, 12 Apr 2021 12:40:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d15so2537293qkc.9;
        Mon, 12 Apr 2021 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DUapBlFjGRDJpFp34wiWQN/kbUJN43b6f1p6IDIwe8=;
        b=mp3KqjNw0LQd0I2bqTPG/fQL1YlviiYT6IUiZ5Y1MfutWISnWh0azZQJJika+jDBs8
         fivRC3j2ToPcjtg9+eAsn0KAKPKcpgn3wEsDFPbMdtd8vMetlIg6c3NcB904z4eUOMVM
         r1+WPqjxarzvWAvSLFLuJldvUHMQM8bnovM27v4kp0qqjC2PpOQWJlF5dGEPGOgqbZwv
         5MdRhnEXgFxs0BOZJHVoWDuv6iE7sjgmqYVx1kHLT5Uj1NP7X5ohUeLjFAtIxHCM4lIq
         Xzcdjyw5YBpfzvzsNlNk99Ke4DgNJU5GR5IWWHb6CNO+dLQb0NoGmK363FHGz+9MnNOI
         Xo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DUapBlFjGRDJpFp34wiWQN/kbUJN43b6f1p6IDIwe8=;
        b=HVIzeQJOrCtYjcR9jDJpKpioHsAzZJW4JxE2BlEKgwQjC7/UTBOLNZ9Xcbts8FiVpL
         ZrVdUbhFYngeThXkuhsI33glEuhctWjV10Lh4miG/0g6roppPcMGOYwP1SSImA7gRE0I
         nfFhyg+00NXQrDizzXXMg/wAR0weg4azpZ03jk0W4yfwdhA6heDnFjLz4nI52NBHYttV
         q0N05pfLNJeUZt1kPVbJwySvVafTH5HqaHK5Cba84G2SbTPoZDLoEw41bFxM2gcVCull
         cbYd5EmDCcZ86UeBf9vX886ZF6ZC+FiywiBzysLZBY3Y+3+6KHk/5qFJF9OlNBiIMkki
         qtbg==
X-Gm-Message-State: AOAM5301wsKEgo2ckFhmeRDifcut6Za7hrExnuAI94yELKFN8d7c6w0Q
        peVYHE+dkR6E5Kc+RVm/FjY=
X-Google-Smtp-Source: ABdhPJy+f4eNvJPa4zhJEodX5saa8XiJJ9VYle8y8BGW6VjLKr7avndqRoR50RHrlzUCXjdl9QwayQ==
X-Received: by 2002:a37:9385:: with SMTP id v127mr17251561qkd.45.1618256422279;
        Mon, 12 Apr 2021 12:40:22 -0700 (PDT)
Received: from localhost.localdomain ([179.218.4.27])
        by smtp.gmail.com with ESMTPSA id j30sm8407911qka.57.2021.04.12.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:40:21 -0700 (PDT)
From:   Pedro Tammela <pctammela@gmail.com>
X-Google-Original-From: Pedro Tammela <pctammela@mojatatu.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        David Verbeiren <david.verbeiren@tessares.net>,
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH bpf-next v3 1/3] bpf: add batched ops support for percpu array
Date:   Mon, 12 Apr 2021 16:39:59 -0300
Message-Id: <20210412194001.946213-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412194001.946213-1-pctammela@mojatatu.com>
References: <20210412194001.946213-1-pctammela@mojatatu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Uses the already in-place infrastructure provided by the
'generic_map_*_batch' functions.

No tweak was needed as it transparently handles the percpu variant.

As arrays don't have delete operations, let it return a error to
user space (default behaviour).

Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 463d25e1e67e..3c4105603f9d 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -698,6 +698,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_delete_elem = array_map_delete_elem,
 	.map_seq_show_elem = percpu_array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_btf_name = "bpf_array",
-- 
2.25.1

