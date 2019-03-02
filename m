Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00261C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D1020840
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyDg9sj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCBDmX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:42:23 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:54827 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCBDmX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:42:23 -0500
Received: by mail-yw1-f73.google.com with SMTP id y133so24833387ywa.21
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LnVZcKb8bZZ/YC4iGcJAdmk6TNXedfnEeu/GsipWawU=;
        b=DyDg9sj573OBZtzerPuLDg6Rv3WLDn+Uxa1QhwHciQGaRxMFbGV5PQ05uEjvthfUEw
         WCKFiAQ4NMhAVpx6ANYY/tfSpGbs2z31uVEJ9OXTcW1tKuN4Q51D8lPlV0udQOZafUpE
         ECYH+eWiSI6AOkW7DCnQr1BcQIJSTmgIpNvPILVx2OxllywojPCXGmSbJKpovENOE6+N
         4EcJjLi7q+cbn3CHQ3ukCiQqlZIuVnTNKNlVJTR5vZQzMtIGp0luLS5itkCDCZO4e/2M
         KniA4PEKI2eiynfRkGBisGZmCg7ocJY11BRV4wtn+t6OsvV+r7keSes2tYv2OYYVXkKL
         OCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LnVZcKb8bZZ/YC4iGcJAdmk6TNXedfnEeu/GsipWawU=;
        b=fNrjRdw7Ktsi/VJhe4Ab02aq3g3SkZDglZAQsG2xnL7Lcq8diBG5kOFXQrUY5fwVeT
         gPym8k0V/pcqY9VykphIJGNavVOSmlKcCUDz8ki8TXtuk+nAIU8YzfsYhouqL1aGnIqv
         SUmW7sbLg9cOPyM7lYAgLySefj6qPoTdIjG+LemsRXT7RTyKDtTOX8gK7fSCF938KM2N
         IOiyMkt5ODW35Yt090WsX1duxF8aTz8zF4CuIT7RsdKmzhZ6y275Ar3kmwjrav/hunTS
         VY5ZqcIA+AOQ50GIc97JlvcSIOc3ituLZkerNyL0H1jScGQPXxdgimf2oMibnLfLy19m
         75Tw==
X-Gm-Message-State: APjAAAU0+DuA9qAZwXKRl6x0BTPwEefgmwVj1t/r+ipFzg/Bm9Ug15zC
        T3JbXROVKttAIGJTNvgRlypkW+8=
X-Google-Smtp-Source: APXvYqxvWcDxDInnjXrID/dVBq1ui5TCuQcd8WYu24StkHFNnrlrkkZVqrYNNQR6ZKXuHFcuCcnIt1c=
X-Received: by 2002:a25:4e86:: with SMTP id c128mr4273501ybb.12.1551498142147;
 Fri, 01 Mar 2019 19:42:22 -0800 (PST)
Date:   Fri,  1 Mar 2019 19:42:12 -0800
Message-Id: <20190302034219.99480-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf-next v3 0/7] selftests: bpf: break up test_progs
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

v3 changes:
* respin on top of commit ebace0e981b2 ("selftests/bpf: use
  __bpf_constant_htons in test_prog.c for flow dissector")
* put bpf_rlimit.h into test_progs.c instead of test_progs.h

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
 tools/testing/selftests/bpf/test_progs.c      | 2043 +----------------
 tools/testing/selftests/bpf/test_progs.h      |   93 +
 28 files changed, 2108 insertions(+), 2029 deletions(-)
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
2.21.0.352.gf09ad66450-goog
