Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D3C64E7B
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631A321D42
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 17:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgLBRZ7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbgLBRZ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 12:25:58 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7BC0613CF
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 09:25:18 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id kb15so1276155pjb.4
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=n5RsSpY3huuHRsMCE/vat/BlcL/7RtJwJ6/7zzZ4dcM=;
        b=bfOtDilqZCHAzcLpVVUsuSGiEvRT1S+GUMIeFJmhTM19qRyMI4NmB7btquRaJnx6fK
         YtqDo4NWHIf2EkKm63K1m3rYQl4t9iljGgM7NzMwqV6a9gMt7PzU9ZDnR54VI+tJPtbL
         b6Us225xh8VTBIwzrEwBxYqeIjUIF1NXVWr1lM8nZsWlvSOuUKAAauFDA26LJEg1op0+
         fBpR1DrdsdQpOzhjPJpoBo6AbvW+mCfwrSS2EgSIHSEbc4ViqY63syySsstxihdsdaCj
         paWUsz0ugGATdkuMhXMvnb8NFJ7KQ+er/MFibWGv3Ccmfnh+SCXM8THcp4zyZju8Cmk8
         4Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=n5RsSpY3huuHRsMCE/vat/BlcL/7RtJwJ6/7zzZ4dcM=;
        b=tJPIKOsGQzuNxRi+asVw3nNzbkEJV7NN2iA4D/AA9QtFEH/RxzRkFt8Q5d9oGcpi5T
         lnVMZ9jpuzt3N67sjqhQueTY+9v06iNds5/aSJQT1aWPqF4Fnkf/kwrLL1QCmOlYjwHU
         WESjKOM3G1eCMOIT82xVDOou7IMK0UJXGL3Txm+2OdgzEuQy+K1tEMTKmIXZcXbtbaXT
         2A571MSyONBiyEm6gX3n/R25PJMb8JEudlbMdxenY20XIWbUMFnjlT0sCG7zuatvgKcs
         n1W5CUg5i7tTo6H5R8/PSQsu5iyowx+e107f+oD76d+k/4+Y4qYRuWPgP/E81Ry9OEKr
         aeQQ==
X-Gm-Message-State: AOAM532jlf95XHkN79Ees+MNNNsyh11uZw6PJs7/TNjkfXNqFoTINm3k
        KnSwCbB5d1Ct0f12Bi49p/+Tv9s=
X-Google-Smtp-Source: ABdhPJzj+1yEKB7Fq1oNUwHmgxID/gM2UcOGRAR/7UZ/5GjBrG34ILlrjhikJHAb2g0IBNErvWRsMzk=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a17:90b:a53:: with SMTP id gw19mr845884pjb.216.1606929917982;
 Wed, 02 Dec 2020 09:25:17 -0800 (PST)
Date:   Wed,  2 Dec 2020 09:25:13 -0800
Message-Id: <20201202172516.3483656-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next 0/3] bpf: expose bpf_{s,g}etsockopt helpers to
 bind{4,6} hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This might be useful for the listener sockets to pre-populate
some options. Since those helpers require locked sockets,
I'm changing bind hooks to lock/unlock the sockets. This
should not cause any performance overhead because at this
point there shouldn't be any socket lock contention and the
locking/unlocking should be cheap.

Also, as part of the series, I convert test_sock_addr bpf
assembly into C (and preserve the narrow load tests) to
make it easier to extend with th bpf_setsockopt later on.

v2:
* remove version from bpf programs (Andrii Nakryiko)

Stanislav Fomichev (3):
  selftests/bpf: rewrite test_sock_addr bind bpf into C
  bpf: allow bpf_{s,g}etsockopt from cgroup bind{4,6} hooks
  selftests/bpf: extend bind{4,6} programs with a call to bpf_setsockopt

 include/linux/bpf-cgroup.h                    |  12 +-
 net/core/filter.c                             |   4 +
 net/ipv4/af_inet.c                            |   2 +-
 net/ipv6/af_inet6.c                           |   2 +-
 .../testing/selftests/bpf/progs/bind4_prog.c  | 102 +++++++++
 .../testing/selftests/bpf/progs/bind6_prog.c  | 119 +++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 196 ++----------------
 7 files changed, 245 insertions(+), 192 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bind4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/bind6_prog.c

-- 
2.29.2.454.gaff20da3a2-goog

