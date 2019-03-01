Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D6C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 06:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C051220850
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 06:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7utoMUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCAG1p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:27:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32913 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfCAG1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 01:27:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so26608104qtz.0;
        Thu, 28 Feb 2019 22:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfkD3/SUY1G8bR4yshunE7ud11039Ie67lMQqc4mWhw=;
        b=H7utoMUy1vnVpnKhe+VGbLQfSb35d551VdaV1iSQHqZOQUXLrMDAdsZ05lmyONuTTj
         xXNi0seUKzkjD1SPXqIjXDNh/k+p8Rkv4TYiQLX+7W1VT1IUXnFgz8QkP0D1jWx2MVzr
         EMaaKQ10Az8ZsjHgMzLuZL35p4/Gwj53mjm4LDUpYhgnOiqBi7r93hRaSrLT/KZPZ3JB
         KmfWbAA0D9DZEhfAQ12n95LGCFrXwScSkQdc5VSjzt3ExIU8qpkDu16FJu81ICzkvKrf
         3OSmtwEHSkfrVszaGdLG9WBkAq4M1xAZuEHFs+c7mDMu0EcXlIcXjiTkHt4Vbu1PXAE5
         j72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfkD3/SUY1G8bR4yshunE7ud11039Ie67lMQqc4mWhw=;
        b=BGwxVB9+MRJXIMypWJIfnN6DeGf0JPEp34/bJvPI7boXuW0TpW+Avh3GxgcLQ8/53q
         YXvzVCjQAjsKub78g5NaNvniWL1nySN7fmykeu3AZiWiSPtgWoryKaOUhRmRtUkT2NCX
         QbcMN86lGeMJ59YJFJwvZUcCLCv3mb2phZ6tnn6oSTLWFBL9l1svX2X8SCnLcuRhnbwP
         WcYTdOSXBy53iWpZH3bNCQXrgaJ9rSqbs+V+xFHhxlCkP+scNHJEVsjOdXhLeKyAkoPk
         cqYScPlfZsxXM4UrH6oGIk15Mka6SJZBnf2VObfhNaN4up47sXJ7df5RCn53DMabhp9J
         s5HA==
X-Gm-Message-State: APjAAAX2DKEYjXVBEW3gLuxfpsC0Zt0jOtI7WID3RiEelpRbECnl1Raq
        xQfHiQSocZAwBVZVbLILwj3hr7gQflIHKFGJ4nU=
X-Google-Smtp-Source: APXvYqwHa3cKhqMdPZvBnU7PauzdXRXcWr8GQEVg8eAyL+OP7y8pfMGFbpCF40fFre/uR9Gban8xWYxbilzMCjbtnx0=
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr2548107qvc.239.1551421663795;
 Thu, 28 Feb 2019 22:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20190228232440.28668-1-sdf@google.com>
In-Reply-To: <20190228232440.28668-1-sdf@google.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 22:27:32 -0800
Message-ID: <CAPhsuW5_zkrebef54O4s=m6nCz1prcaqovp2Hzoof0oQ55aavQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] selftests: bpf: break up test_progs
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 5:38 PM Stanislav Fomichev <sdf@google.com> wrote:
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
> v2 changes:
> * added cover letter, added more description about file structure

Thanks for the timely revision.

For the series:
Acked-by: Song Liu <songliubraving@fb.com>

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
>  tools/testing/selftests/bpf/test_progs.c      | 2044 +----------------
>  tools/testing/selftests/bpf/test_progs.h      |   94 +
>  28 files changed, 2109 insertions(+), 2030 deletions(-)
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
> 2.21.0.rc2.261.ga7da99ff1b-goog
