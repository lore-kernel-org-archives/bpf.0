Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B86BC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD4C218CD
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqn/0ZQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfB1TQT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:16:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45300 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1TQT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 14:16:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so24807978qtg.12;
        Thu, 28 Feb 2019 11:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLVe0dg5PAXVsP2a8A/pI1lkD6c5jXwaBrVI0jlvk3s=;
        b=Hqn/0ZQLXdTR6XyLGz65+CVqF3QTrbqyIaek6lp4qsouX+p7pKsPdFX4LeejtTSM1E
         v6Jo4PmSLz6bq6KNXwV8tB6z5X9zZkvF92Zg4uECN4XlWB7TBn9t3/MAMwhuUmNqYUxc
         +j9dg92lYGqx/m7fQ7rSM5Sqc6OmKMAs057pJqYF6cKYCt7idQh6nuxcGftWtPyt458I
         r/SvMDU0KdDQG3hAuQPRdQwHzSWTi1qAPX9+rJQOfLrdJZFo5ClLcSLkoE2irnko5doZ
         EMyP9e+hVLhDZZvlpd+v4uwM8qXURHPjGy7ISzseKYvBQRgQIQ4f8AOMRr1gniCVIy1T
         3FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLVe0dg5PAXVsP2a8A/pI1lkD6c5jXwaBrVI0jlvk3s=;
        b=iTtFvJcTvVJexXCifUph/LjyPNpdICeWbSsecO4HqjQOpkxSPPmWd2E0830sfeZhrJ
         olxPuFrIZmb3SgPCQMZEcLLaLc5/7RU5nCYF8mIcZxiop9LiFrzvKLAHfN7kiLAwJCI3
         62MH0PPDSl8mrJQXl+GmuebSgIl/OQAJptLKUQkhpF333TKpTpeqiKwCJKjTaHJB/WCU
         Uwo/47uReVBdIK5OGjkjhUZ5oxhkME10TGlP32Sek/hq07kC1H/5mKkO6aMBwfbeNf25
         AT1yOnlOL8Ib6uUeBIQ6FeCk253+Q15cYoMjcHcJvL7Q+CoRnFc1npz5B6vtuzKPNrqj
         5PDQ==
X-Gm-Message-State: APjAAAWIE4EI+7wOxzYfJLj/nh6FTLhS0G6b6/IjMiyLsKDWRML3gZIn
        Xh7qd2PT3a9mEvEMNDCf5gAciegb5sUU+ZYRMye34mu7
X-Google-Smtp-Source: APXvYqydO/48FGqYITk1zW2DUGpiBVnS3YAOILETeeEzfedMqV68NbviI+T3l+6+ii/ORnVcGBKOSTsWNXW1IXF4xl0=
X-Received: by 2002:aed:3904:: with SMTP id l4mr740253qte.194.1551381377934;
 Thu, 28 Feb 2019 11:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20190228030414.18973-1-jakub.kicinski@netronome.com>
In-Reply-To: <20190228030414.18973-1-jakub.kicinski@netronome.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 11:16:06 -0800
Message-ID: <CAPhsuW5nJ+29yc58h5QX=pr1d3WwzZfBF+gMuvmUrOwHoEZ-cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] samples: bpf: continue effort to get rid
 of bpf_load
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 7:05 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> Hi!
>
> This set is next part of a quest to get rid of the bpf_load
> ELF loader.  It fixes some minor issues with the samples and
> starts the conversion.
>
> First patch fixes ping invocations, ping localhost defaults
> to IPv6 on modern setups. Next load_sock_ops sample is removed
> and users are directed towards using bpftool directly.
>
> Patch 4 removes the use of bpf_load from samples which don't
> need the auto-attachment functionality at all.
>
> Patch 5 improves symbol counting in libbpf, it's not currently
> an issue but it will be when anyone adds a symbol with a long
> name. Let's make sure that person doesn't have to spend time
> scratching their head and wondering why .a and .so symbol
> counts don't match.
>
> v2: - specify prog_type where possible (Andrii).

For the series:

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for doing this work!
Song

>
> Jakub Kicinski (5):
>   samples: bpf: force IPv4 in ping
>   samples: bpf: remove load_sock_ops in favour of bpftool
>   tools: libbpf: add a correctly named define for map iteration
>   samples: bpf: use libbpf where easy
>   tools: libbpf: make sure readelf shows full names in build checks
>
>  samples/bpf/.gitignore                        |  1 -
>  samples/bpf/Makefile                          |  8 +-
>  samples/bpf/fds_example.c                     | 10 +-
>  samples/bpf/load_sock_ops.c                   | 97 -------------------
>  samples/bpf/sock_example.c                    |  2 +-
>  samples/bpf/sockex1_user.c                    | 25 ++---
>  samples/bpf/sockex2_user.c                    | 23 +++--
>  samples/bpf/sockex3_user.c                    |  2 +-
>  samples/bpf/tcp_basertt_kern.c                |  2 +-
>  samples/bpf/tcp_bpf.readme                    | 14 +--
>  samples/bpf/tcp_bufs_kern.c                   |  2 +-
>  samples/bpf/tcp_clamp_kern.c                  |  2 +-
>  samples/bpf/tcp_cong_kern.c                   |  2 +-
>  samples/bpf/tcp_iw_kern.c                     |  2 +-
>  samples/bpf/tcp_rwnd_kern.c                   |  2 +-
>  samples/bpf/tcp_synrto_kern.c                 |  2 +-
>  samples/bpf/tcp_tos_reflect_kern.c            |  2 +-
>  samples/bpf/tracex2_user.c                    |  2 +-
>  tools/bpf/bpftool/prog.c                      |  4 +-
>  tools/lib/bpf/Makefile                        |  4 +-
>  tools/lib/bpf/libbpf.c                        |  8 +-
>  tools/lib/bpf/libbpf.h                        |  3 +-
>  tools/perf/util/bpf-loader.c                  |  4 +-
>  .../testing/selftests/bpf/test_libbpf_open.c  |  2 +-
>  24 files changed, 69 insertions(+), 156 deletions(-)
>  delete mode 100644 samples/bpf/load_sock_ops.c
>
> --
> 2.19.2
>
