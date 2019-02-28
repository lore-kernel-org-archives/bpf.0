Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1D9C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12E32085A
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5G45/zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfB1XYp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:24:45 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:38202 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfB1XYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:24:45 -0500
Received: by mail-vk1-f202.google.com with SMTP id e13so11476441vka.5
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XgBBH4WYPtp3jmfvCO+FpDf/2aZuUK+cYM3t38QE9Kk=;
        b=I5G45/zdRusE7GnGy2f9rlEIQWibFXDfteXZAM1XfCJmawj60X9sVb+pZ5snJgIae1
         g8s9PFjZWaanajJ0jv0cj1QYL2oknygG1/VUv9I4C4/xHCO5o5Dx2sjthaiHIr81YlFS
         v6upI/39auCkmfWVNgWdkLCG2jOFERarwyJK0Ij3fetMxovLUz4OZIj9DIc0HkBvSMrb
         r0Cn0VrLcBAmo4P9fGTEKEXNXo02v/EpIkJ+pTh05Xn60/1hCQ+oXy4zQdD1qBaVdm2x
         HvwRM62TtTFqFDEWAqwCERjXKh7IVC1+VnS6Val51tDHSHhqamo6HdhhyCiAmzLPRy13
         rb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XgBBH4WYPtp3jmfvCO+FpDf/2aZuUK+cYM3t38QE9Kk=;
        b=fHQouzZINC2dwplM8Iai1p2k7Zuq+yWMPbx1aei1a/NRGiIf7KTbVOUL/Fh/cGtPKu
         +dCFcaFUDoAv/zJQEDbBxOdD6W8mo85f4U8XDWrTtWqStZPlDsUNOI8ATD+RbokMYiCV
         Yu6nfGfjkaW5/xWIiZhceWwB3mJu2EJIGljFI2UhbciIPw+24LVifWZu3Ml5CXB8k2gL
         n8pk3xFPHdLWpQT7J+jeAD9nLGwfL2CxQEwf56TBHLVx58z5OVXwjqaweRTvAaXfo9x9
         esupkndj9veNZrUiOBUEaLiLcAzzWbw2bqaXVXRRcmVoZd1MsUBygi43y/vrwrsyvOVZ
         54gQ==
X-Gm-Message-State: APjAAAU0TNrAEUAJwWpHcPYCXxwH0IgEdlS1OO3jlMyGPmFETqRVatB4
        R1tTnVt5GhfLLLqNFY5s0kXoljQ=
X-Google-Smtp-Source: APXvYqyea/ATAcfqzVs8YRqsGMKbhJrrCfmhxQZQsTHiZ0NIYenlWJ6JKH0iRDxwe6UOlCbiQuY7BCk=
X-Received: by 2002:a67:7ac7:: with SMTP id v190mr1300855vsc.17.1551396284222;
 Thu, 28 Feb 2019 15:24:44 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:24:33 -0800
Message-Id: <20190228232440.28668-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next v2 0/7] selftests: bpf: break up test_progs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recently we had linux-next bpf/bpf-next conflict when we added new
functionality to the test_progs.c at the same location. Let's split
test_progs.c the same way we recently split test_verifier.c.

I follow the same patten we did in commit 2dfb40121ee8 ("selftests: bpf:
prepare for break up of verifier tests") for verifier: create
scaffolding to support dedicated files and slowly move the tests into
separate files.

The first patch adds scaffolding, subsequent patches move progs into
separate files.

In theory, many of the standalone tests can be migrated to this new
framework as well. They get the benefit of common CHECK macro and
bpf_find_map function which a lot of standalone tests need to redefine.

v2 changes:
* added cover letter, added more description about file structure

Stanislav Fomichev (7):
  selftests: bpf: break up test_progs - preparations
  selftests: bpf: break up test_progs - pkt access
  selftests: bpf: break up test_progs - xdp
  selftests: bpf: break up test_progs - stackmap
  selftests: bpf: break up test_progs - tracepoint
  selftests: bpf: break up test_progs - spinlock
  selftests: bpf: break up test_progs - misc

 tools/testing/selftests/bpf/Makefile          |   27 +-
 .../selftests/bpf/prog_tests/.gitignore       |    1 +
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |  249 ++
 .../selftests/bpf/prog_tests/flow_dissector.c |   72 +
 .../bpf/prog_tests/get_stack_raw_tp.c         |  139 ++
 .../selftests/bpf/prog_tests/l4lb_all.c       |   90 +
 .../selftests/bpf/prog_tests/map_lock.c       |   75 +
 .../selftests/bpf/prog_tests/obj_name.c       |   71 +
 .../selftests/bpf/prog_tests/pkt_access.c     |   29 +
 .../selftests/bpf/prog_tests/pkt_md_access.c  |   24 +
 .../selftests/bpf/prog_tests/prog_run_xattr.c |   49 +
 .../bpf/prog_tests/queue_stack_map.c          |  103 +
 .../bpf/prog_tests/reference_tracking.c       |   48 +
 .../selftests/bpf/prog_tests/signal_pending.c |   48 +
 .../selftests/bpf/prog_tests/spinlock.c       |   29 +
 .../bpf/prog_tests/stacktrace_build_id.c      |  165 ++
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  150 ++
 .../selftests/bpf/prog_tests/stacktrace_map.c |  103 +
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |   59 +
 .../bpf/prog_tests/task_fd_query_rawtp.c      |   78 +
 .../bpf/prog_tests/task_fd_query_tp.c         |   82 +
 .../selftests/bpf/prog_tests/tcp_estats.c     |   19 +
 .../bpf/prog_tests/tp_attach_query.c          |  132 ++
 tools/testing/selftests/bpf/prog_tests/xdp.c  |   46 +
 .../bpf/prog_tests/xdp_adjust_tail.c          |   31 +
 .../selftests/bpf/prog_tests/xdp_noinline.c   |   82 +
 tools/testing/selftests/bpf/test_progs.c      | 2044 +----------------
 tools/testing/selftests/bpf/test_progs.h      |   94 +
 28 files changed, 2109 insertions(+), 2030 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/.gitignore
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/l4lb_all.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_lock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/obj_name.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_access.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reference_tracking.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/signal_pending.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_estats.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
 create mode 100644 tools/testing/selftests/bpf/test_progs.h

-- 
2.21.0.rc2.261.ga7da99ff1b-goog
