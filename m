Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCA1C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847C6218AC
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="FrIvcPfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfB0XbH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:31:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42020 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbfB0XbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 18:31:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id u7so12233180qtg.9
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 15:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tuZiRnOuCr1zo28GxIO7IZtBSUsqyRMXDWsLqEUgVg=;
        b=FrIvcPfgQJ04IzD/m1CTVsuGRE4KV4URJZM1VRQ4+b7ezGPsGOmi0h+p/v5xDp6cjP
         UNIZ2lMJFtA1kJGBbqEPL3QIPNspxtUmrw8PqMOYMWZGFgrf7tj73VHiM+EZ11DeJtl0
         cIl7YOXhvzBsx7RJC/7V5aBObRT3/leRiWw9o4cNTZA9By8/otBTf9HxdLrsW3QdUPCX
         u6OKlcqo/cVail4f5xnU4xJfCPYoIW1b2eD0uITF9y9rJfOrXS34VIOt/lq6V3s6gvhL
         zX2HpFINJE/NH6cALiHB7TuuS9DQmabDVD59iQF0QsKqYeHDD2kf4NsyzyyOGynU4Kzx
         qcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tuZiRnOuCr1zo28GxIO7IZtBSUsqyRMXDWsLqEUgVg=;
        b=f2UtALhzyQvihYAhK1x6jD2FAI8bYQNNf5JgsXCDpENmV+4kOz10aW1fHkZ49Ej4IE
         ekBFXVGDq2a9KDhJzFRVYqHw9xO7nv8IHwlEyI+J++NOgje9vGptmmnZG6s3so0Biqax
         C/xREhs+kIzWqeYSD5JWDMkwaJg0pVgYWDN1GGtetdRkaWmnj+fmJmU1XCsnBf1P5RdI
         Evj2//CqnPKR0ME24TQ6Prfnpg7vdhW826an3R+ajytp9YBbr3uQ2FO35EsTV1zMhSP+
         ZbsvMyjYmU3iXtnPT3egzMuJLZNlWFncHZh3A/ehPSjQZv1FKwyFoQjD40yW8GCy5lPK
         qJhQ==
X-Gm-Message-State: AHQUAuZuPu4i/4ouULal4l4bZBHgkDRJ/kajdvjVSf6SwG30l6x/5ndg
        v2TbIiOjuPqVfIkSri39mwcNJQ==
X-Google-Smtp-Source: AHgI3IbNJLzqInMlBFiGafOJuIpOsZ9zQ0QwyeCUdG4FXEv+4SBd0Y/tEHdThAC0peUC5k7X/S1+pQ==
X-Received: by 2002:ac8:2847:: with SMTP id 7mr3794714qtr.335.1551310265890;
        Wed, 27 Feb 2019 15:31:05 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z28sm11509741qth.85.2019.02.27.15.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:31:05 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 0/5] samples: bpf: start effort to get rid of bpf_load
Date:   Wed, 27 Feb 2019 15:30:41 -0800
Message-Id: <20190227233046.11718-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

This set is next part of a quest to get rid of the bpf_load
ELF loader.  It fixes some minor issues with the samples and
starts the conversion.

First patch fixes ping invocations, ping localhost defaults
to IPv6 on modern setups. Next load_sock_ops sample is removed
and users are directed towards using bpftool directly.

Patch 4 removes the use of bpf_load from samples which don't
need the auto-attachment functionality at all.

Patch 5 improves symbol counting in libbpf, it's not currently
an issue but it will be when anyone adds a symbol with a long
name. Let's make sure that person doesn't have to spend time
scratching their head and wondering why .a and .so symbol
counts don't match.

Jakub Kicinski (5):
  samples: bpf: force IPv4 in ping
  samples: bpf: remove load_sock_ops in favour of bpftool
  tools: libbpf: add a correctly named define for map iteration
  samples: bpf: use libbpf where easy
  tools: libbpf: make sure readelf shows full names in build checks

 samples/bpf/.gitignore                        |  1 -
 samples/bpf/Makefile                          |  8 +-
 samples/bpf/fds_example.c                     |  9 +-
 samples/bpf/load_sock_ops.c                   | 97 -------------------
 samples/bpf/sock_example.c                    |  2 +-
 samples/bpf/sockex1_user.c                    | 24 ++---
 samples/bpf/sockex2_user.c                    | 22 +++--
 samples/bpf/sockex3_user.c                    |  2 +-
 samples/bpf/tcp_basertt_kern.c                |  2 +-
 samples/bpf/tcp_bpf.readme                    | 14 +--
 samples/bpf/tcp_bufs_kern.c                   |  2 +-
 samples/bpf/tcp_clamp_kern.c                  |  2 +-
 samples/bpf/tcp_cong_kern.c                   |  2 +-
 samples/bpf/tcp_iw_kern.c                     |  2 +-
 samples/bpf/tcp_rwnd_kern.c                   |  2 +-
 samples/bpf/tcp_synrto_kern.c                 |  2 +-
 samples/bpf/tcp_tos_reflect_kern.c            |  2 +-
 samples/bpf/tracex2_user.c                    |  2 +-
 tools/bpf/bpftool/prog.c                      |  4 +-
 tools/lib/bpf/Makefile                        |  4 +-
 tools/lib/bpf/libbpf.c                        |  8 +-
 tools/lib/bpf/libbpf.h                        |  3 +-
 tools/perf/util/bpf-loader.c                  |  4 +-
 .../testing/selftests/bpf/test_libbpf_open.c  |  2 +-
 24 files changed, 66 insertions(+), 156 deletions(-)
 delete mode 100644 samples/bpf/load_sock_ops.c

-- 
2.19.2

