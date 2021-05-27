Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90248C4707F
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 04:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4AA61181
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 04:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhE0EEi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 May 2021 00:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EEh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 00:04:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986FDC061574;
        Wed, 26 May 2021 21:03:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g24so1982363pji.4;
        Wed, 26 May 2021 21:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rSjes+WUshzFVP8BXxctVak3NmznjnlLIiBOe82k2nI=;
        b=MxTvkuMw/kTcPDgv9scID7o/5svIgq6JxupREmtgt5sf4ePPKOf7mTyR/ErYMtBVdb
         bcISQNXs7KUt7AI8HeE9APSdULtfAjBqYJub16rkqU/DFf+fehKZcjKjtAUoGCt2cJRC
         Z+/rkjMYVZ/KvM3ZlYtyeDlLyS0KuAoLK9XqL3sWKcfNl2KxF+GYK7dCbMNyzecQ3STA
         +prDZH/phZQiPRDn/sni2pnt9hlH/RvzvX1vvEe/twgBwwMGtsmIzNfcGnd1JK3WGAmB
         kaF9ULOeBD0Dbpc259vJ24ZISiqhHS1JYzoAMP3gbqNDq0Plosloyks/GTn9Qnm8Ofnn
         TDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rSjes+WUshzFVP8BXxctVak3NmznjnlLIiBOe82k2nI=;
        b=p1HVN/aw4YfvMKSwdSYlUkxTBqVr6Jf5QX6zhiWwP/88mciwP1RMeYd9MAMzoSDBH1
         HzuIBuvloOZYOG1CIM3fccKqZ4sLryp7JspJ5WB0hOEt7CirXFEAG/DaUlhLzUuq3CfO
         486Whcy5VxEI+i1nqa112KPJ+z4tqKRtuDrK/Pce7SE6vZZw4fpuL8CrRo9szu6ZFR//
         8M3zeBlLKmQvuHYQgvFnKoEVeE9fKkNpJVcXF8jrwGTEWzC2DV03WTuoBXY9boxBicE3
         YHLJMM5Drb/KYWp8AcfXDXLii5xp+RDWcAr856hWGOv3/jpeozeLE0Mdo/FBa8/RGu+1
         AQnw==
X-Gm-Message-State: AOAM531pTgoh9kJhnevrVdjF6d2kN6BIrn0crTPrFj26pnizmQ1VkfjE
        prCNE/WVnoB46UQ/IMc7Wek=
X-Google-Smtp-Source: ABdhPJyv4HqzPjYI67+l+39qs/N+GoexJnJqJ96Jf3HhSB+wtUrXD4d78QQIuEUB7w4St/iXhQkuHA==
X-Received: by 2002:a17:90b:3709:: with SMTP id mg9mr7096759pjb.149.1622088183101;
        Wed, 26 May 2021 21:03:03 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:6b23])
        by smtp.gmail.com with ESMTPSA id j22sm568281pfd.215.2021.05.26.21.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 21:03:02 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Introduce BPF timers.
Date:   Wed, 26 May 2021 21:02:56 -0700
Message-Id: <20210527040259.77823-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The 1st patch implements interaction between bpf programs and bpf core.
The 2nd patch implements necessary safety checks.
The 3rd patch is the test.
The patchset it's not ready to land, since it needs a lot more tests,
but it's in functionally solid shape. Please review.

Alexei Starovoitov (3):
  bpf: Introduce bpf_timer
  bpf: Add verifier checks for bpf_timer.
  selftests/bpf: Add bpf_timer test.

 include/linux/bpf.h                           |  37 +++-
 include/linux/btf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  26 +++
 kernel/bpf/arraymap.c                         |   7 +
 kernel/bpf/btf.c                              |  77 +++++++--
 kernel/bpf/hashtab.c                          |  53 ++++--
 kernel/bpf/helpers.c                          | 160 ++++++++++++++++++
 kernel/bpf/local_storage.c                    |   4 +-
 kernel/bpf/syscall.c                          |  23 ++-
 kernel/bpf/verifier.c                         | 134 +++++++++++++++
 kernel/trace/bpf_trace.c                      |   2 +-
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |  26 +++
 .../testing/selftests/bpf/prog_tests/timer.c  |  47 +++++
 tools/testing/selftests/bpf/progs/timer.c     |  85 ++++++++++
 15 files changed, 644 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer.c

-- 
2.30.2

