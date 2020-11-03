Return-Path: <SRS0=gkZj=EJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E6C388F9
	for <bpf@archiver.kernel.org>; Tue,  3 Nov 2020 15:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957612244C
	for <bpf@archiver.kernel.org>; Tue,  3 Nov 2020 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxbkeczE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgKCPbk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCPbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B325C0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 07:31:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so13196101wme.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 07:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1OwOdZbVZkD+L5PGfTjlD9ufqYh7WPaMmVHnEknv2k=;
        b=nxbkeczEA9hMFJvKILBbwYimkJFAsHZ2mI4+7iRSpOI0s4xDmH275aqdqHzew39P/4
         MIXRZuqH6wqhC0GNAFUzl3A3gbP6c8tNN3n0Bbckm+v1wTVQgojN97JrgtJbY2q7dbt3
         c4zEdB6qJHS3KmmqPTRUF6kHiDuGdS2vNtRZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1OwOdZbVZkD+L5PGfTjlD9ufqYh7WPaMmVHnEknv2k=;
        b=nydu7fY8S+vi0eeKplOTTh1kFUXYvxMuvkrIqGMkBuuqU4md2Dy+NfFeY1iIxnJjGl
         EfGnwkOcYlfAHRNeHvstv0R+N84Q9S/0BGqcXJarhoK3qXwZTFEbiH00OgCfuF1mK3L6
         vCvjW8IXI2Oc6y8AY17sCe72PiI5ad8HFoOhxuBjQSin90/5HHuOXIYEx4j6fTgoZyC/
         XLRsDjalXNgdcNi+oszEjBn2mCoU0fwygIvWQC40zP6BDsK3odbgg6Tnn5dXvmadt9wX
         i5Amu5L8Wrp8C+LZEqW+VY2dcttwzvaAZ+h3Q4SM/kNT3GvE3mOF87TwSzxn4Iw9hW/N
         /D+A==
X-Gm-Message-State: AOAM530wxbMrg8a4d19Ulo3dmxtz/3mEdQQjsQavvqUdSxDro4wlG5OG
        7PkIgnkVpfLbXhv4XvQ/bAs9sg==
X-Google-Smtp-Source: ABdhPJwQLMm2OkckMfMF3HwMs+LiH7QUs5htucqAE3ZDwWM1FzDZFaSRk+3rNft1uArL95j1W1LMkw==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr292934wma.171.1604417497765;
        Tue, 03 Nov 2020 07:31:37 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 0/8]  Implement task_local_storage
Date:   Tue,  3 Nov 2020 16:31:24 +0100
Message-Id: <20201103153132.2717326-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v1 -> v2

- Updated the refcounting for task_struct and simplified conversion
  of fd -> struct pid.
- Some fixes suggested by Martin and Andrii, notably:
   * long return type for the bpf_task_storage_delete helper (update
     for bpf_inode_storage_delete will be sent separately).
   * Remove extra nullness check to task_storage_ptr in map syscall
     ops.
   * Changed the argument signature of the BPF helpers to use
     task_struct pointer in uapi headers.
   * Remove unnecessary verifier logic for the bpf_get_current_task_btf
     helper.
   * Split the changes for bpftool and libbpf.
- Exercised syscall operations for local storage (kept a simpler verison
  in test_local_storage.c, the eventual goal will be to update
  sk_storage_map.c for all local storage types).
- Formatting fixes + Rebase.

We already have socket and inode local storage since [1]

This patch series:

* Implements bpf_local_storage for task_struct.
* Implements the bpf_get_current_task_btf helper which returns a BTF
  pointer to the current task. Not only is this generally cleaner
  (reading from the task_struct currently requires BPF_CORE_READ), it
  also allows the BTF pointer to be used in task_local_storage helpers.
* In order to implement this helper, a RET_PTR_TO_BTF_ID is introduced
  which works similar to RET_PTR_TO_BTF_ID_OR_NULL but does not require
  a nullness check.
* Implements a detection in selftests which uses the
  task local storage to deny a running executable from unlinking itself.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=f836a56e84ffc9f1a1cd73f77e10404ca46a4616

KP Singh (8):
  bpf: Implement task local storage
  libbpf: Add support for task local storage
  bpftool: Add support for task local storage
  bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
  bpf: Fix tests for local_storage
  bpf: Update selftests for local_storage to use vmlinux.h
  bpf: Add tests for task_local_storage
  bpf: Exercise syscall operations for inode and sk storage

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |  23 ++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  48 +++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_lsm.c                          |   4 +
 kernel/bpf/bpf_task_storage.c                 | 313 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  17 +-
 kernel/trace/bpf_trace.c                      |  16 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |  48 +++
 tools/lib/bpf/libbpf_probes.c                 |   2 +
 .../bpf/prog_tests/test_local_storage.c       | 181 +++++++++-
 .../selftests/bpf/progs/local_storage.c       |  87 +++--
 18 files changed, 705 insertions(+), 51 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

-- 
2.29.1.341.ge80a0c044ae-goog

