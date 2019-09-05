Return-Path: <SRS0=JPvp=XA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A1C43331
	for <bpf@archiver.kernel.org>; Thu,  5 Sep 2019 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84933206B8
	for <bpf@archiver.kernel.org>; Thu,  5 Sep 2019 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vj9vsJ9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfIEP1M (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:27:12 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:33079 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfIEP1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Sep 2019 11:27:12 -0400
Received: by mail-ua1-f74.google.com with SMTP id w26so436871uan.0
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2019 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nl+R158SA53ROLBik0ktxdgdO0TsfvIUT2YNmNuqIYE=;
        b=Vj9vsJ9Ssuif2auvR/HFmfEc3R8VIW3FMgTUxPKPZrPdVAgBg5MSwqXqJZJvuHET8j
         FAuBRAvLk7aQQwnh8KpJJKfUcDQWIgb3thmAqfZiHOMTdWsNN5i3EuOUWWt9YKPDX4/T
         e//aUXDeSEZPpqYt3UK7kUtquS2DXxNhIwlxO5AANiPSNJEuwXMlchF4aQFWVSvTcUwl
         6I0c493yuOuFtEKKywdP64czeSQf5eL2aQ+vgDtsMUpIMPW0X3/K5F354lkTE3GZuTjt
         gAXFfbkZWIhtj6h5C0jQJh4HYTZ/W5wiZuRyoEqLUsHcL/MYE3Q0BqaaJTvUrVv31Jg4
         qROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nl+R158SA53ROLBik0ktxdgdO0TsfvIUT2YNmNuqIYE=;
        b=i5rGWR/kFXT7O9E0skXN6x5Ic7/sVSa9lU5LMkQOcoUdnRhtG8aq0LKa375wKUCNUZ
         CBiqY9M/gq/kicnYoQ/butNNxjMXKrP2DdaB/C/o6qR7/arHJao8Hlvx+pf74W9wic3v
         LT1XZ4k14CU+bQSlZA9csKlq8P/rQImfRyJFJjgQlhYwrREklq4JU6dnTho1bvN26zxT
         zb1Hjckd3fmwYXzcUcuZruDRHuPTmS7OZ0oQcAfn/XhFsoLh1GuUxmb+6twP4hm8XY00
         nZ2R9HoZ793QpY/P2pqpYKPIzJ/CJFuBvJ6ZlilWBLUyO+AUmEXDppxGtkdCLVA9coc2
         gIEQ==
X-Gm-Message-State: APjAAAXk/0+1TA8ynjotMP8duSFZlcGg7fmBYeuDSxogOGRd4lFu23PR
        AHVaKSSuCDWWCNwL9F5jfYR303A=
X-Google-Smtp-Source: APXvYqzaIJkSUm7nMGuu4szIHT4bt97LorLT+UUcyaC6O3Pe7mIM3Vg1h+NOt/4/ygigJtEFZNorJAE=
X-Received: by 2002:ab0:2791:: with SMTP id t17mr1731060uap.101.1567697231316;
 Thu, 05 Sep 2019 08:27:11 -0700 (PDT)
Date:   Thu,  5 Sep 2019 08:27:03 -0700
Message-Id: <20190905152709.111193-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next v2 0/6] selftests/bpf: move sockopt tests under test_progs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that test_progs is shaping into more generic test framework,
let's convert sockopt tests to it. This requires adding
a helper to create and join a cgroup first (test__join_cgroup).
Since we already hijack stdout/stderr that shouldn't be
a problem (cgroup helpers log to stderr).

The rest of the patches just move sockopt tests files under prog_tests/
and do the required small adjustments.

v2:
* don't create a subtest per sockopt test, too verbose (Alexei
  Starovoitov)

Stanislav Fomichev (6):
  selftests/bpf: test_progs: add test__join_cgroup helper
  selftests/bpf: test_progs: convert test_sockopt
  selftests/bpf: test_progs: convert test_sockopt_sk
  selftests/bpf: test_progs: convert test_sockopt_multi
  selftests/bpf: test_progs: convert test_sockopt_inherit
  selftests/bpf: test_progs: convert test_tcp_rtt

 tools/testing/selftests/bpf/.gitignore        |   5 -
 tools/testing/selftests/bpf/Makefile          |  12 +--
 .../{test_sockopt.c => prog_tests/sockopt.c}  |  50 ++-------
 .../sockopt_inherit.c}                        | 102 ++++++++----------
 .../sockopt_multi.c}                          |  62 ++---------
 .../sockopt_sk.c}                             |  60 +++--------
 .../{test_tcp_rtt.c => prog_tests/tcp_rtt.c}  |  83 +++++---------
 tools/testing/selftests/bpf/test_progs.c      |  38 +++++++
 tools/testing/selftests/bpf/test_progs.h      |   4 +-
 9 files changed, 142 insertions(+), 274 deletions(-)
 rename tools/testing/selftests/bpf/{test_sockopt.c => prog_tests/sockopt.c} (96%)
 rename tools/testing/selftests/bpf/{test_sockopt_inherit.c => prog_tests/sockopt_inherit.c} (72%)
 rename tools/testing/selftests/bpf/{test_sockopt_multi.c => prog_tests/sockopt_multi.c} (83%)
 rename tools/testing/selftests/bpf/{test_sockopt_sk.c => prog_tests/sockopt_sk.c} (79%)
 rename tools/testing/selftests/bpf/{test_tcp_rtt.c => prog_tests/tcp_rtt.c} (76%)

-- 
2.23.0.187.g17f5b7556c-goog
