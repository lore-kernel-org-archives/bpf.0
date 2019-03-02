Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84944C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4845A20840
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqhG0I7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfCBDln (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:41:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40597 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfCBDlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:41:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id w6so22171522ljd.7
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4+Q7bUDYoTBIvrE9w/Y8WD++8iBjJ+gw/QxXbHd6VE=;
        b=cqhG0I7sdgj+ZAcfa4iLQm6hEyMgeJo5geIqpcVfJjyw6+lx+MI5UdwDVlNqZr3bw9
         JMKvH9cb1x3PaCoFY5TZ+nqkzydQjRCw18ihA6j73clevMCdPnf+ULf4yuL0TdsKV/IK
         8MBLnirgdEGQhdF/WFPcnV0dyRfAynJYsg/LUGpVlcalfMUgwvRFZK0GuSTsRaIfrdYf
         J6KeH34S3HLo/Lz4h0SEm8Sb4E9iyBT2MBxwS0QtnCK8MYOnmfas0QmjvbvDJa7MVzH+
         2Mwso4FHqYUUAqeSvzT0tt2rZg+X4y131/jrkvjVEzKG86xk2mJ6u/OoOniFE8D+unvK
         WzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4+Q7bUDYoTBIvrE9w/Y8WD++8iBjJ+gw/QxXbHd6VE=;
        b=Jww0x+8bOPtqetpcIQS3XE9RAasderVAxwxOmwBLvGxX2qced8da0TQfs6wd8mKmjb
         0f6PodskEs8GSeMmrx25AMH2URMvqdmqkso3tc2cX2fzbXweVZNl6BwH6sjowLsePgdg
         bH6ka3thCEJmE3+p3NETX/yqWAdfFBdE7mef+hS5rlFcDM3z2DMuo+UEbumdZdh/AUpP
         3DK6pgkqgU8zKelxJnCc4ru+5g8AStFgl+PjF6lv1bNM+Wnx3D78gpEJTQc3jxfslqhD
         MVsZdHOCI8P/qg4JFmino6LIVguSgT2Y4RVqaYaMZ1trwEI+nNttPFAJn1rOipXMNOFL
         azKg==
X-Gm-Message-State: APjAAAWcVDVKLfCHbwGBx7N9/4Z+LOhlRHL6VKAp4Iyvt1yW2SOjU70E
        5p4l+hXZx77Ly4qNwIxKWPdGgrIggm+COLu0SFcwqgJa
X-Google-Smtp-Source: APXvYqzzxZe/eI3j2UoJ+OgsqZ64vFHgdplecoynCmXpncNUG2Sb09IARhUjvw3ZTBE3ayO72QBxn7J6vK3FA0sQvns=
X-Received: by 2002:a2e:9e9a:: with SMTP id f26mr4401430ljk.67.1551498099985;
 Fri, 01 Mar 2019 19:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20190302034029.96595-1-sdf@google.com>
In-Reply-To: <20190302034029.96595-1-sdf@google.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 1 Mar 2019 19:41:28 -0800
Message-ID: <CAKH8qBvV5iutmL=7H79cW4NwhES_Nr86V1dbr4vitSkKk++HDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] selftests: bpf: break up test_progs
To:     Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 7:40 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Recently we had linux-next bpf/bpf-next conflict when we added new
> functionality to the test_progs.c at the same location. Let's split
> test_progs.c the same way we recently split test_verifier.c.
>
> I follow the same patten we did in commit 2dfb40121ee8 ("selftests: bpf:
> prepare for break up of verifier tests") for verifier: create
> scaffolding to support dedicated files and slowly move the tests into
> separate files.
>
> The first patch adds scaffolding, subsequent patches move progs into
> separate files.
>
> In theory, many of the standalone tests can be migrated to this new
> framework as well. They get the benefit of common CHECK macro and
> bpf_find_map function which a lot of standalone tests need to redefine.
>
> v3 changes:
Oops, forgot to increment vX in the subject line, please ignore.

> * respin on top of commit ebace0e981b2 ("selftests/bpf: use
>   __bpf_constant_htons in test_prog.c for flow dissector")
> * put bpf_rlimit.h into test_progs.c instead of test_progs.h
>
> v2 changes:
> * added cover letter, added more description about file structure
>
> Stanislav Fomichev (7):
>   selftests: bpf: break up test_progs - preparations
>   selftests: bpf: break up test_progs - pkt access
>   selftests: bpf: break up test_progs - xdp
>   selftests: bpf: break up test_progs - stackmap
>   selftests: bpf: break up test_progs - tracepoint
>   selftests: bpf: break up test_progs - spinlock
>   selftests: bpf: break up test_progs - misc
>
>  tools/testing/selftests/bpf/Makefile          |   27 +-
>  .../selftests/bpf/prog_tests/.gitignore       |    1 +
>  .../selftests/bpf/prog_tests/bpf_obj_id.c     |  249 ++
>  .../selftests/bpf/prog_tests/flow_dissector.c |   72 +
>  .../bpf/prog_tests/get_stack_raw_tp.c         |  139 ++
>  .../selftests/bpf/prog_tests/l4lb_all.c       |   90 +
>  .../selftests/bpf/prog_tests/map_lock.c       |   75 +
>  .../selftests/bpf/prog_tests/obj_name.c       |   71 +
>  .../selftests/bpf/prog_tests/pkt_access.c     |   29 +
>  .../selftests/bpf/prog_tests/pkt_md_access.c  |   24 +
>  .../selftests/bpf/prog_tests/prog_run_xattr.c |   49 +
>  .../bpf/prog_tests/queue_stack_map.c          |  103 +
>  .../bpf/prog_tests/reference_tracking.c       |   48 +
>  .../selftests/bpf/prog_tests/signal_pending.c |   48 +
>  .../selftests/bpf/prog_tests/spinlock.c       |   29 +
>  .../bpf/prog_tests/stacktrace_build_id.c      |  165 ++
>  .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  150 ++
>  .../selftests/bpf/prog_tests/stacktrace_map.c |  103 +
>  .../bpf/prog_tests/stacktrace_map_raw_tp.c    |   59 +
>  .../bpf/prog_tests/task_fd_query_rawtp.c      |   78 +
>  .../bpf/prog_tests/task_fd_query_tp.c         |   82 +
>  .../selftests/bpf/prog_tests/tcp_estats.c     |   19 +
>  .../bpf/prog_tests/tp_attach_query.c          |  132 ++
>  tools/testing/selftests/bpf/prog_tests/xdp.c  |   46 +
>  .../bpf/prog_tests/xdp_adjust_tail.c          |   31 +
>  .../selftests/bpf/prog_tests/xdp_noinline.c   |   82 +
>  tools/testing/selftests/bpf/test_progs.c      | 2043 +----------------
>  tools/testing/selftests/bpf/test_progs.h      |   93 +
>  28 files changed, 2108 insertions(+), 2029 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/.gitignore
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/l4lb_all.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_lock.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/obj_name.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_access.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/reference_tracking.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/signal_pending.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_estats.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
>  create mode 100644 tools/testing/selftests/bpf/test_progs.h
>
> --
> 2.21.0.352.gf09ad66450-goog
