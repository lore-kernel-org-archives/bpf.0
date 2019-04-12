Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3088C10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA2E218C3
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LV0VrOZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfDLN3x (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:29:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54759 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDLN3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 09:29:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so11245418wml.4
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SVmYhA4JNY20p4whZDeQQI5rrTICErMn5NNPX8Bgt90=;
        b=LV0VrOZJYiiiWVByX9+NWEh2lm13EcYst3GQ1HhKCpS0faRjRw8hESSySH4H9uID9S
         lNdL/Q5SeudK8fNdLsIrpQM2dMMfXKD1GAVLI70KYyaylAED8S5Dg7/SWOZeZa4Hc4Y7
         Qyb7Za+NNunI7IqAv14ALL8Cyi/Yd7JNQPArHBkNHKBXeekX4TDeSIdvbIijE3gnqJdF
         KYPVloN15X5+t+QBsr5prBanXzqxbTlp5e49bbQpwVjT2fgTdbiBHsJTiGoqZ+P9gZar
         qI0erPCKjaYbWYkBJieeYyPSS8ivqt9NMjaoef6EVoeVJ9GAJzDfnyNGSdjCmGShIf2u
         tV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SVmYhA4JNY20p4whZDeQQI5rrTICErMn5NNPX8Bgt90=;
        b=iqz56WWDs0su6pNUZL0YQa4TbPsUjxhz5RQGfIsC/PlMvauMqkVnWYjpzmlFvwcqwk
         kbH3e0J5Q36ROi8TkPcRUtIePmRsRaAQ+eojCXLnYj25VyYkoo8ZxSdDcj2+hqtB5kU/
         ZiABN/6ex+DGSuaKIt82uDAU2kCNhlRo3/uxSa6e4xeDElDgKs/AShGJ1nXME5cn93En
         Py1xfs/YE2IS8ichnvaZJHzITP/efGqk+FkRWdn89QyfBo3aLw3Q7mplczKBjJ0RpIXM
         MCdGKsHdaLSbqsBTMWMEkZryjCdAW9JwZJA0sxKV8/R10UALkF0sdfrlWA+bN4c8Fi12
         UAag==
X-Gm-Message-State: APjAAAUB1UzovU0Cd5PGXa0ZEHN+hV9Jev2f+q/E3NSrqD6DANDo4/Cy
        iJWPhl88SRvVvp+3jUKKJyJH+G8/umo=
X-Google-Smtp-Source: APXvYqwPZpdubb9jr9vzHWvco0BM+zpXOGpvZQHXAEzhg2Uq8ZehX2ffACsjz8qqshO5pXJylakt1w==
X-Received: by 2002:a7b:c92f:: with SMTP id h15mr11043781wml.115.1555075791099;
        Fri, 12 Apr 2019 06:29:51 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v184sm15752915wma.6.2019.04.12.06.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:29:50 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 0/5] tools: bpftool: fix minor issues in bpftool and its documentation
Date:   Fri, 12 Apr 2019 14:29:33 +0100
Message-Id: <20190412132938.9044-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This series brings a number of small fixes to bpftool and the related
manual pages.

The first two patches are on bpftool itself (remove blank lines when
dumping programs, do not set errno when showing a tree of cgroup programs).

The next two patches are fixes for the manual pages (missing keyword, wrong
option name for showing bpftool version). The last one is not exactly a
fix, but rather an addition to the man page, explaining how to dump program
statistics.

Quentin Monnet (5):
  tools: bpftool: remove blank line after btf_id when listing programs
  tools: bpftool: reset errno for "bpftool cgroup tree"
  tools: bpftool: fix man page documentation for "pinmaps" keyword
  tools: bpftool: fix short option name for printing version in man
    pages
  tools: bpftool: add a note on program statistics in man page

 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst  |  2 +-
 tools/bpf/bpftool/Documentation/bpftool-feature.rst |  2 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst     |  2 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst     |  2 +-
 tools/bpf/bpftool/Documentation/bpftool-perf.rst    |  2 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst    | 12 ++++++++++--
 tools/bpf/bpftool/Documentation/bpftool.rst         |  2 +-
 tools/bpf/bpftool/cgroup.c                          |  7 +++++++
 tools/bpf/bpftool/prog.c                            |  2 +-
 9 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.17.1

