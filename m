Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B3C433EF
	for <bpf@archiver.kernel.org>; Mon, 30 May 2022 09:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiE3JNy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 May 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiE3JNy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 05:13:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDE95D188
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 02:13:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so13071829pju.1
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNP+R0ohcLUjNtDJRZoqQVoepX4pDHJ5Tzsqw/Ip/us=;
        b=1zsRDNM7+bOnSAXrGT8GTnB+LPiaiWeULGvPDxnh8ygbaIBhoXtWi5qIMtlR+0jVC3
         mCvGt4XP1HvP05Ke+93gP1wyUTIWPC8TqTkPUCoiPi8wDLv8QUjVuAY9G0wfAwfbjglm
         NoKvGVb3RhJ+KbFn1b/3H6xRut1xSH5jjCVxn04Hu4IuhaomW+hHiu/5rI8BZ8F3q5pX
         eBlK0Kq1pBmWUk7cwGnPfxh4Z4PAB1MyZytQjrashWTXpKvEnWe8/jjjhSVvNtkcdGZ2
         VnvSXj+wY3xyfzW3dI1WBCB648rq6dK65QaH+KQdProsmF9O+QYp5Geg7zOqauaANpg9
         6iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNP+R0ohcLUjNtDJRZoqQVoepX4pDHJ5Tzsqw/Ip/us=;
        b=uSzXfnnQJiTMUEDiyhjHicdzNhro+nxAk2ejDzCJAglDC8PF3cp4U7ZEZ8UsKNWH7e
         2zAeHjZO1krvcbAv4vkGxlVNw8cCi3RrRjpNedd7cizpQTKD5AE0L2pfuKIHBICajffh
         hoJfQ1yoYJTJbbuvTs2HuGMk1NlDnhCCUaaFZP8f1qicSfyx/RK+CYDOCTH2jF7vSlY+
         FUVYbkIbh3sZ1e0gYTBMvAnYoRXjhTmZcS2YfxedqPr3ib3QCGD7XWDsU7ziPUYFN5fO
         O0WHyqah56nBAnk45Il5MHOZXKCZau8WOnR24HK9H1ggBmpDGnmc+Hb3Qe9SBkDleESP
         g4Hw==
X-Gm-Message-State: AOAM531vXoHSEa0gyiA/siku2oHXVt/vQRYhzeF2E3x+Xm6/0Cc+NO33
        TXU0AREdMc56KWFx4LLHvHWazg==
X-Google-Smtp-Source: ABdhPJy6/T1nAe2l6F6QTn/YqY4r78bM0hS6jGpWftKdzqrtiEzTF325nNWOg/9YtvKgUD7qLfn7Yw==
X-Received: by 2002:a17:903:22cc:b0:162:4d8b:e2eb with SMTP id y12-20020a17090322cc00b001624d8be2ebmr29890361plg.22.1653902032530;
        Mon, 30 May 2022 02:13:52 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902ebc200b0015e8d4eb20dsm8640644plg.87.2022.05.30.02.13.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 02:13:52 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, wangdongdong.6@bytedance.com,
        cong.wang@bytedance.com, zhouchengming@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH v3 0/2] Optimize performance of update hash-map when free is zero
Date:   Mon, 30 May 2022 17:13:38 +0800
Message-Id: <20220530091340.53443-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

We encountered bad case on big system with 96 CPUs that
alloc_htab_elem() would last for 1ms. The reason is that after the
prealloc hashtab has no free elems, when trying to update, it will still
grab spin_locks of all cpus. If there are multiple update users, the
competition is very serious.

0001: Add is_empty to check whether the free list is empty or not before taking
the lock.
0002: Add benchmark to reproduce this worst case.

Changelog:
v2->v3: Addressed comments from Alexei Starovoitov, Andrii Nakryiko.
- Adjust the way the benchmark is tested.
- Adjust the code format.
some details in here:
https://lore.kernel.org/all/20220524075306.32306-1-zhoufeng.zf@bytedance.com/T/

v1->v2: Addressed comments from Alexei Starovoitov.
- add a benchmark to reproduce the issue.
- Adjust the code format that avoid adding indent.
some details in here:
https://lore.kernel.org/all/877ac441-045b-1844-6938-fcaee5eee7f2@bytedance.com/T/

Feng Zhou (2):
  bpf: avoid grabbing spin_locks of all cpus when no free elems
  selftest/bpf/benchs: Add bpf_map benchmark

 kernel/bpf/percpu_freelist.c                  | 28 +++++-
 kernel/bpf/percpu_freelist.h                  |  1 +
 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../benchs/bench_bpf_hashmap_full_update.c    | 96 +++++++++++++++++++
 .../run_bench_bpf_hashmap_full_update.sh      | 11 +++
 .../bpf/progs/bpf_hashmap_full_update_bench.c | 40 ++++++++
 7 files changed, 178 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_full_update.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_hashmap_full_update.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_hashmap_full_update_bench.c

-- 
2.20.1

