Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A8C433FE
	for <bpf@archiver.kernel.org>; Sun, 20 Nov 2022 11:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKTL0E (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 20 Nov 2022 06:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKTL0B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 06:26:01 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA3C4874F
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 03:25:59 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668943557;
        x=1669202757; bh=VOwX7yZI71v5MXD+YSRwyPItO8qPemAtnDxzCOZiQ44=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=PFJZdN0WFPuoHnq0WXXwkHtkbJgfoSgbUiUe8BOvi2g0Na3gRLoD5gQs9eQGH5zYN
         +BFG8kdq4MFcyo5MwhjLEoZ6G3teQ8d5Nv4FQoOXDCU+BMNGJNQ1SCqD7L/oLnsQxw
         zTVVDIsOmE0CQPSVBpna8MoUCy6bk+NhNh2OvEnHs8zvwGbM4rPEJ3i0pK9sx9sBgF
         rh4PaZRk8E3wxNCv6c4JHblcL3DEppnvuRGRAgyn6upe73XFF+nF2eAG7xL4IyOcCg
         JYXFvf1x/DTh63jQzmfRm/d27LJYz2N9VgyNzal41tzEwsk7S/8tO/K52tgmJysrej
         SJmNMBuF+UvIw==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v4 0/5] clean-up bpftool from legacy support
Message-ID: <20221120112515.38165-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of commit 93b8952d223a ("libbpf: deprecate legacy BPF map
definitions") and commit bd054102a8c7 ("libbpf: enforce strict libbpf
1.0 behaviors") The --legacy option is not relevant anymore. #1 is
removing it. #4 is cleaning the code from using libbpf_get_error().

About patches #2 and #3 They are changes discovered while working on
this series (credits to Quentin Monnet). #2 is cleaning-up usage of an
unnecessary PTR_ERR(NULL), finally #3 is fixing an invalid value
passed to strerror().

v1 -> v2:
   - Addressed review comments from Yonghong Song on patch #4
   - Added a patch #5 that removes unwanted function noticed by
     Yonghong Song
v2 -> v3
   - Addressed review comments from Andrii Nakryiko on patch #2, #3, #4
     * clean-up usage of libbpf_get_error() (#2, #3)
     * fix possible return of an uninitialized local variable err
     * fix returned errors using errno
v3 -> v4
   - Addressed review comments from Quentin Monnet
     * fix line moved from patch #2 to patch #3
     * fix missing returned errors using errno
     * fix some returned values to errno instead of -1

Sahid Orentino Ferdjaoui (5):
  bpftool: remove support of --legacy option for bpftool
  bpftool: replace return value PTR_ERR(NULL) with 0
  bpftool: fix error message when function can't register struct_ops
  bpftool: clean-up usage of libbpf_get_error()
  bpftool: remove function free_btf_vmlinux()

 .../bpftool/Documentation/common_options.rst  |  9 --------
 .../bpftool/Documentation/substitutions.rst   |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/btf.c                       | 19 +++++++---------
 tools/bpf/bpftool/btf_dumper.c                |  2 +-
 tools/bpf/bpftool/gen.c                       | 10 ++++-----
 tools/bpf/bpftool/iter.c                      | 10 +++++----
 tools/bpf/bpftool/main.c                      | 22 +++----------------
 tools/bpf/bpftool/main.h                      |  3 +--
 tools/bpf/bpftool/map.c                       | 20 ++++++-----------
 tools/bpf/bpftool/prog.c                      | 15 +++++--------
 tools/bpf/bpftool/struct_ops.c                | 22 ++++++++-----------
 .../selftests/bpf/test_bpftool_synctypes.py   |  6 ++---
 13 files changed, 49 insertions(+), 93 deletions(-)

--
2.34.1


