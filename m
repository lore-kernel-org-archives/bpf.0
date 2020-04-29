Return-Path: <SRS0=PQF5=6N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21964C83004
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB29E21973
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 18:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hik43Ezb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD2SMa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbgD2SL6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 14:11:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9CC035493
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 11:11:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so3724311wrt.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryUFaJ+61X3pzz7HW3AjoxfMyaLsi/WhEIy5/h3CzoM=;
        b=Hik43EzbKRZNwN4TwmwvCzr+RxkJYWkqQKMjCZBYtN4kRnwYCe2bJ7T6B1pq8EwVtF
         uqpjuaNRCfCnD9Px/rCzWvW1uxMyXaKNhkGh96+M4T8p2oAwjPdVUqk2Tbbfnho7TxD/
         kgfPWNPDjfVuPTwPfFRTtTvxxSD8UlUVxWW/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryUFaJ+61X3pzz7HW3AjoxfMyaLsi/WhEIy5/h3CzoM=;
        b=pduiy32g3cIxxNYMdW6Z0KJt/sE9Nj6bqPrwMP0Ae1ssTL51vCI+uHJs6DWbV5JZu/
         6upkqmAB28jpDqiJ7DmJH8E81V7pSqQ6REThv/uh2jZCcyjKwiNS4l6lxd8BB891DGau
         lSd42PA2DEYgyXRfqOCwF17Lcm5TpOKEwohyvNQ6JGo0YuV6gp+fRsCkVb0Jd1yD4fju
         Q7BTEGHND28ylsYkFn/0qJ2iKeGUyLgrOW19KjCHa20uf4QzrtxRvWvZShduYtcfTB+M
         Oh3G97sFxpdB8/p2O7/MpQaMs8Gd5/kxplyLPc4efQNV/gxQhDWjfqKxRtk959l/ai/W
         KRzQ==
X-Gm-Message-State: AGi0PuYn/NIJkPB+daD8lufK0xjLCwP0YR/DXIAhxQqBQtGasNZOKU4u
        uKHpAQRUJI+b7WivdPluwkIjc0pLz6Q=
X-Google-Smtp-Source: APiQypKLuiWG4KER2XgSYxbhPUNXiJNyN4jfAN84VIxZx7sSzpALAVb3Gubv7peT4z+zoc4Uz0SydQ==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr43099508wro.178.1588183915794;
        Wed, 29 Apr 2020 11:11:55 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id p6sm72145wrt.3.2020.04.29.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:11:55 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joe Stringer <joe@wand.net.nz>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 0/3] Enable socket lookup in SOCKMAP/SOCKHASH from BPF
Date:   Wed, 29 Apr 2020 20:11:51 +0200
Message-Id: <20200429181154.479310-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series enables BPF programs to fetch sockets from SOCKMAP/SOCKHASH by
doing a map lookup, as proposed during virtual BPF conference.

Patch 1 description covers changes on verifier side needed to make it work.

Fetched socket can be inspected or passed to helpers such as bpf_sk_assign,
which is demonstrated by the test updated in patch 3.

Thanks,
Jakub

Jakub Sitnicki (3):
  bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH
  selftests/bpf: Test that lookup on SOCKMAP/SOCKHASH is allowed
  selftests/bpf: Use SOCKMAP for server sockets in bpf_sk_assign test

 kernel/bpf/verifier.c                         | 45 +++++++---
 net/core/filter.c                             |  4 +
 net/core/sock_map.c                           | 18 +++-
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/sk_assign.c      | 21 ++++-
 .../selftests/bpf/progs/test_sk_assign.c      | 82 ++++++++-----------
 .../bpf/verifier/prevent_map_lookup.c         | 30 -------
 tools/testing/selftests/bpf/verifier/sock.c   | 70 ++++++++++++++++
 8 files changed, 178 insertions(+), 94 deletions(-)

-- 
2.25.3

