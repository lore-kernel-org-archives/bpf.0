Return-Path: <SRS0=xxat=CZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE882C433E2
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 02:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D33920936
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 02:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsOZBc5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIPCDV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgIPCDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 22:03:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534CAC06174A;
        Tue, 15 Sep 2020 19:03:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so3007531pgd.5;
        Tue, 15 Sep 2020 19:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1eCAG8h6I0Q09MjaaDkWuLMChrptUJ7/Euhkn/bFWU=;
        b=MsOZBc5bF777DutgbLfDLg+WGKDthoYyY6KFNjYNiee7se+Nhp3H5+O56077KSprfK
         AMpg9A5mSkXvgVkAo221YZODFqV+W5Nab03UTNClasjZzOSJRvnpzLy+fQiOrSXjDZ3X
         DtznxbF9HzpNKBldflIVHCF1Bh0G0PGllYhnwbxWREGmPd8Ttz/m7VnalQ+oYOnYWd8m
         iDDVw2GlLC98A25Uzx9m7AJ1/V2vcduMG0wtr60S9PAXD/BN88z0bzT00kBYvY+5ztJp
         QKTffRyV6+EASANnOsaPAjq0wDE3HFYPuUihVxJQ18zUPwLetqabiVHWmNYm01Dq0Mx+
         rHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1eCAG8h6I0Q09MjaaDkWuLMChrptUJ7/Euhkn/bFWU=;
        b=MdKpeYOr/wrssKNaHRCC/dPV35Hw8bpF9gR9jHFZoLCBQH15AI1shUlc+VzVjz6qtO
         3rEK40H1kuzWuaDGRZk3Iz9oZbQS3iUXkG7a9xi0wAqZeD1wJtB0miqQKA9Jz3J/mu5t
         CSVJKtuSXWkTxKEAVlOXEZCqZCjC3nEUKZht6fAsZTbgxCKPytS0pW5PWm4pDBFRYOzN
         2CrWH40PkZ0X0XaRKq6odUNKqZL1Dd/NMCzHg11NCFUcesMO9W90UCneiykg0ZoO0Bru
         CFGo9YphzIjamh9NXT2513Rkd9nZjZfeGkhyKwToasCRj/wDpLPOR4dd0p+sJ3fdTvF6
         pBMg==
X-Gm-Message-State: AOAM532pXN8AqWk4/nS0BcOXVk34d3TYcWv2u6iYkMEv9R93Y4hjMVUQ
        gVWzZ+KMraKuVlzRprF0palQ74XlwH8=
X-Google-Smtp-Source: ABdhPJwfjVFeez6USKJ+ESZTJbJnwqoUoKW9D/AkVqPNdF9CkNG/XCyHgMN+iRVWymz7yb1k/bue4A==
X-Received: by 2002:aa7:9522:0:b029:13c:f6b9:1c17 with SMTP id c2-20020aa795220000b029013cf6b91c17mr20139022pfp.11.1600221798759;
        Tue, 15 Sep 2020 19:03:18 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id 126sm1058630pfg.192.2020.09.15.19.03.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 19:03:17 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: pull-request: bpf 2020-09-15
Date:   Tue, 15 Sep 2020 19:03:16 -0700
Message-Id: <20200916020316.18673-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

We've added 12 non-merge commits during the last 19 day(s) which contain
a total of 10 files changed, 47 insertions(+), 38 deletions(-).

The main changes are:

1) docs/bpf fixes, from Andrii.

2) ld_abs fix, from Daniel.

3) socket casting helpers fix, from Martin.

4) hash iterator fixes, from Yonghong.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexei Starovoitov, Andrii Nakryiko, Bryce Kahle, Ciara Loftus, Jiri 
Olsa, Mauro Carvalho Chehab, Song Liu, Vaidyanathan Srinivasan, Yonghong 
Song

----------------------------------------------------------------

The following changes since commit c8146fe292a726d71e302719df90b53e2f84f7a5:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2020-08-28 16:12:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to ce880cb825fcc22d4e39046a6c3a3a7f6603883d:

  bpf: Fix a rcu warning for bpffs map pretty-print (2020-09-15 18:17:39 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'hashmap_iter_bucket_lock_fix'

Andrii Nakryiko (2):
      docs/bpf: Fix ringbuf documentation
      docs/bpf: Remove source code links

Björn Töpel (1):
      xsk: Fix number of pinned pages/umem size discrepancy

Daniel Borkmann (1):
      bpf: Fix clobbering of r2 in bpf_gen_ld_abs

Martin KaFai Lau (1):
      bpf: Bpf_skc_to_* casting helpers require a NULL check on sk

Naveen N. Rao (1):
      libbpf: Remove arch-specific include path in Makefile

Toke Høiland-Jørgensen (1):
      tools/bpf: build: Make sure resolve_btfids cleans up after itself

Tony Ambardar (2):
      libbpf: Fix build failure from uninitialized variable warning
      tools/libbpf: Avoid counting local symbols in ABI check

Yonghong Song (3):
      bpf: Do not use bucket_lock for hashmap iterator
      selftests/bpf: Add bpf_{update, delete}_map_elem in hashmap iter program
      bpf: Fix a rcu warning for bpffs map pretty-print

 Documentation/bpf/ringbuf.rst                          |  5 +----
 kernel/bpf/hashtab.c                                   | 15 ++++-----------
 kernel/bpf/inode.c                                     |  4 +++-
 net/core/filter.c                                      | 18 +++++++++---------
 net/xdp/xdp_umem.c                                     | 17 ++++++++---------
 tools/bpf/Makefile                                     |  4 ++--
 tools/bpf/resolve_btfids/Makefile                      |  1 +
 tools/lib/bpf/Makefile                                 |  4 +++-
 tools/lib/bpf/libbpf.c                                 |  2 +-
 .../selftests/bpf/progs/bpf_iter_bpf_hash_map.c        | 15 +++++++++++++++
 10 files changed, 47 insertions(+), 38 deletions(-)
