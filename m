Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE653C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D573218A2
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="QNgQQyj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfB1DE2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:04:28 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37185 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfB1DE1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 22:04:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so21934843qtb.4
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 19:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEZCUBIE+OQbXv2wYtje5xLSOLEN84VEqVWn3dVCPY0=;
        b=QNgQQyj5fpsksXtGs+orpPuf3ptWC1D8LKR15a4+eq10GI/2n0/pxZRQGtNqjdyi66
         0CM0C/kq5YXKgITCk3yoMifSjDlMIB1hBsUTljG2SQqk+botD+Qk9E2xalOHWbKHSI6a
         suX0u1Lv4qXsnfGrvVSkU03av3LupOPMU3rPHPxZg6W+DJ7Tf+OhgHYfkOzN5NeaXyJU
         eLUaXMiBz7Vbw0aGcd8m7ShYaEa48BC5EVDKbtkuCXKoqPSCxV5cXzxGIWmmPbVl9Ihf
         8Poy8ThHNm9e6sqlX7jDH7mKtA1MifdSbOVmIXC3W82sWrJxRqplRO2aANT53qUibobW
         oFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEZCUBIE+OQbXv2wYtje5xLSOLEN84VEqVWn3dVCPY0=;
        b=ftp6I5Z0qn4fmYj4dzYNr4/UcHDaId/2+WH4nTMSUJbFuMISgiDmPT2MA/tM4aVU7l
         wJ0s46eLf9a506jJ2NJs47pTD8wzKLa9uZaCDEKl7aL9kKelnkVquGGjAq0axGrWUtM+
         uz31Kvubh4qGGZs5w/O2oxqKek5Ux2Qb1UOszdFpjXRAZSFlJOWXDJDwXp8TMyw+zUX3
         L+/1Q7Ek8YpjK38UoXAFxsrpIGe1jSOelFNvcXx6OqR5kShkpAMUtnrEHeMpFLIbHU6O
         vmico6r7Nda0MGCU1Zvx6cfYDqyKDyu0LcDHWnDadkT5mD8OesmmfJxTYxlag8KvuIPe
         xCnw==
X-Gm-Message-State: AHQUAuZ/yFqrkMck7bIcvc/s7AHYRY9CVDyobdS9ME2TbUE2HJar+H7/
        UzgJOX6GD2j3IE/V/X7BvnVkkA==
X-Google-Smtp-Source: AHgI3Iaab9n3Z76EYTDIIU8y+lkzB9O2HtyiXDIlmepLY574Q0M28g6C/cHOXeC2g9FjvFixjvlWzQ==
X-Received: by 2002:ac8:19e3:: with SMTP id s32mr4259626qtk.287.1551323066740;
        Wed, 27 Feb 2019 19:04:26 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r44sm11242066qtb.53.2019.02.27.19.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 19:04:26 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2 0/5] samples: bpf: continue effort to get rid of bpf_load
Date:   Wed, 27 Feb 2019 19:04:09 -0800
Message-Id: <20190228030414.18973-1-jakub.kicinski@netronome.com>
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

v2: - specify prog_type where possible (Andrii).

Jakub Kicinski (5):
  samples: bpf: force IPv4 in ping
  samples: bpf: remove load_sock_ops in favour of bpftool
  tools: libbpf: add a correctly named define for map iteration
  samples: bpf: use libbpf where easy
  tools: libbpf: make sure readelf shows full names in build checks

 samples/bpf/.gitignore                        |  1 -
 samples/bpf/Makefile                          |  8 +-
 samples/bpf/fds_example.c                     | 10 +-
 samples/bpf/load_sock_ops.c                   | 97 -------------------
 samples/bpf/sock_example.c                    |  2 +-
 samples/bpf/sockex1_user.c                    | 25 ++---
 samples/bpf/sockex2_user.c                    | 23 +++--
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
 24 files changed, 69 insertions(+), 156 deletions(-)
 delete mode 100644 samples/bpf/load_sock_ops.c

-- 
2.19.2

