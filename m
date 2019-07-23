Return-Path: <SRS0=nay9=VU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21120C7618B
	for <bpf@archiver.kernel.org>; Tue, 23 Jul 2019 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD090223BE
	for <bpf@archiver.kernel.org>; Tue, 23 Jul 2019 10:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuFkkcSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbfGWKPp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:15:45 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35233 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfGWKPp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 06:15:45 -0400
Received: by mail-pf1-f201.google.com with SMTP id r142so25844867pfc.2
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xmjcnxOIy3vC3x78cRcn02eU5r4Uf6FShc4XTyftpqk=;
        b=kuFkkcSujUiIq0s947Lw9Tp0ec8BAF5566m0Ea5cfeB/kY3rwjxSFeJyHZGFaJ/8jZ
         5uIhAkorhU9vf5OfIp8TRHWKOQyI0rv5qvqrp7zYSzdj2PKAUGUXhCWRueXs1HPiJ9iQ
         eDoEiGXY9Nltl94wcz3szBNq00KfdQOo+UXyUKuexIltf0c79pL4pzPoUgjLKY4VHUw/
         LSN6aGyum4M7l896bP5Bv6+NTIwygxuV/HtIi+p8EtVnmKk85wxKmbkb6k3TKJzcBggH
         qvCFqZg4AD1u4bSdWBT03jc4l0yIhv8vWy5tXx2HE1yOneRcVrqB+h6Pihpn5VqHP/Rr
         N1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xmjcnxOIy3vC3x78cRcn02eU5r4Uf6FShc4XTyftpqk=;
        b=ra64hv2WLOd3rE5s+UoPdHl7hCkR4eLdwxEBDkhpxqkzgcxt1nv4+nMdSfATBa/GLj
         amEOy4bhWBYR9HqanCxpunIujXQae7aWMJbAA7VQCse9ps9l1/hRfzlU9x7D6xk7ZaEc
         qxqTuP2rfE5PliNegi7tONb0g3CygGJOJPNn7Zl/XWEal90+Ge16uI3KGxnohIawq4wJ
         C2Pryy8E4F6qadw9owHVP7KOx8MUhbCTp8XIcs+4YiXEUKxBEw+5PLLPyA67YNcMnbLj
         VSdo1LhP2nogj69QIPZC4nJCHDG2IDX0pxkkbq0w/Ced+lsM4A1+gzinWOWPGeiyjF6D
         TXWg==
X-Gm-Message-State: APjAAAXBkyWl6A6WeG/UtrH8IjgX/AVJSXhbDKY2sU7qbrKoEoa/m8p4
        w6tk7zGZEFJ4g0WizcnCF17guXHokNe/9w==
X-Google-Smtp-Source: APXvYqyycRwBbp/QjzvXuQlhNuUoExeaBwHusb/AbMx69B05jNj0CjW0YEIbJFu8/zEjMvZPfelfsyyqujSnuw==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr75567383pgl.420.1563876944086;
 Tue, 23 Jul 2019 03:15:44 -0700 (PDT)
Date:   Tue, 23 Jul 2019 03:15:36 -0700
Message-Id: <20190723101538.136328-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf 0/2] bpf: gso_segs fixes
From:   Eric Dumazet <edumazet@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch changes the kernel, second patch
adds a new test.

Note that other patches might be needed to take
care of similar issues in sock_ops_convert_ctx_access()
and SOCK_OPS_GET_FIELD()

Eric Dumazet (2):
  bpf: fix access to skb_shared_info->gso_segs
  selftests/bpf: add another gso_segs access

 net/core/filter.c                              |  6 +++---
 tools/testing/selftests/bpf/verifier/ctx_skb.c | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog

