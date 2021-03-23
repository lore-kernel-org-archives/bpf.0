Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F349C433E0
	for <bpf@archiver.kernel.org>; Tue, 23 Mar 2021 02:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D588619AB
	for <bpf@archiver.kernel.org>; Tue, 23 Mar 2021 02:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCWCvl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Mar 2021 22:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCWCv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 22:51:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD5C061574;
        Mon, 22 Mar 2021 19:51:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 7so12968405qka.7;
        Mon, 22 Mar 2021 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWr8b6NVfNVSJB4y0TRipb+mBEkENqc20wn57/NFQ9Y=;
        b=aKRkX0bOJss5xZb4KASYkiVKal5zi1VIB4o8hIiMbI8u3GI1l6xzwTVK1qAQcuSkCd
         vofeoGyuScbFKl85vlgd/tYDZKgNSZLzcmN59HqNSEIh0gs4LBcFqK/4uhr/BUyvfsYm
         zjSIT9abXlqPTFbUdd/qjDwhKhv22yXGfcW5Cwv5wxMQy0De7tiiN6tHMPz/+GVgt2Ut
         KeV2U/N6/H7X1BZPPUbHT662Tksf+GTqBoooeDMqNFo3XoYRhSN2jVe/G7osyJFr89QB
         5H1yP+l6tdu23PEvC8+5fIM2g/BhPR3vHWqeGZWbLekvTexsI8MEuXRl7oTnhqX3aXOZ
         KyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWr8b6NVfNVSJB4y0TRipb+mBEkENqc20wn57/NFQ9Y=;
        b=M2ebDKetCWifRW2VZLVLghsEUIUSEFou/smxDgT9IKyKWoYKg/mwYZE7G61WjUPnQB
         YW0ywz9+k6RCbZGbpgTcEbUQ3I3LvnWGDmprAGeiPzRXaOCm8Ux02f4580QEXQPXUxtZ
         6eKGRveKo/PutuqN2J9y5yB4Pim1Vrz3WYLcnXKEHvqdflAoxLTfqL+FnOan51Ky1mN8
         IoMtIRxAwmcaCHbHSnOsK6vqHzXrNBI+KH/myTxfc6hDZRVmCXfXyzOBjwVxkzW+ol5R
         lariAIhttZUd16rQjAT526VNHRoyw+1IifKT9j562dHdjOhU/FhltW1uU/yLnkU7ivmk
         6vRg==
X-Gm-Message-State: AOAM533uRsutFjhM8sjZaKbbV+OBckDgjerlPnRUPlZRCc4AzP1AxV1Z
        dqP2WlMvlaaQ4k207WufDfU=
X-Google-Smtp-Source: ABdhPJwfxZXvAuR8ORJL5ck+l5CXF3iwnwgTLK+4AVw70Xdh9Ng6Y8kQzjLU8WBVD7JEFSCJqpTPfg==
X-Received: by 2002:a37:dcb:: with SMTP id 194mr3530832qkn.4.1616467887437;
        Mon, 22 Mar 2021 19:51:27 -0700 (PDT)
Received: from localhost.localdomain ([179.218.4.27])
        by smtp.gmail.com with ESMTPSA id h13sm292265qtn.26.2021.03.22.19.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:51:26 -0700 (PDT)
From:   Pedro Tammela <pctammela@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Pedro Tammela <pctammela@mojatatu.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] add support for batched ops in LPM trie
Date:   Mon, 22 Mar 2021 23:50:52 -0300
Message-Id: <20210323025058.315763-1-pctammela@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The patch itself is straightforward thanks to the infrastructure that is
already in-place.

The tests follows the other '*_map_batch_ops' tests with minor tweaks.

v1 -> v2:
Fixes for checkpatch warnings

Pedro Tammela (2):
  bpf: add support for batched operations in LPM trie maps
  bpf: selftests: add tests for batched ops in LPM trie maps

 kernel/bpf/lpm_trie.c                         |   3 +
 .../map_tests/lpm_trie_map_batch_ops.c (new)  | 158 ++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c

-- 
2.25.1

