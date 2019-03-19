Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D8C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E316520857
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YBtNbgWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfCSKV3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfCSKV1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so20360541wrm.5
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQst3FeWE/UQWQTDNl9jXz5b8QQZ9NSbn0J6McYIkXU=;
        b=YBtNbgWWXmS1IPnYnHLJB3CY/bNXocQ9h93nU6peEVNtzvDG5ggq0m/TIIgIXlxqFk
         mKFQNyMJRY79PXAj58a5wnnqdBxfS52kgR9B58QfRB4SqT3Nh4yDK5/y/INODoKE2rBb
         Ivn/iQmVCKFr2C7a2vmtKAE6Q3a+eFWVi0vlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQst3FeWE/UQWQTDNl9jXz5b8QQZ9NSbn0J6McYIkXU=;
        b=hULjIqYiLer+iwzKo0tEYdCpsHNNfS+lHiYbbxa3WfRQv2vyXNifEXG6MNyIvQrnzQ
         lAF+OMHzyxvGx/qsbPn8faEbmcb6qFpf6wlbyNxUDbH9iShBzuc6q+wkNI7ADiGd+3Im
         tNgt7r5rNRpyOA//D/c9878RhRExJH5fra/mXW2BksM8q9d/GmpFOAuj5O+WlgNht+V5
         FFIf7OUqKnibqt+pN9Saqr5jb1MtTyxFxusMRUOkZ26O+aJHTBLgELO8dMyJkyM/vv3r
         yd10C28KxLJ3rvp4vi7p+jfiY2DUNy2ZOjNQNb0TPD/IS35Fp15Rz3/lEy0UR97L8UFH
         lPhA==
X-Gm-Message-State: APjAAAVZ1pb3DkTlyOQImQCPCjcnYQlUoZrbMyTyNF+GNbkdW2gXY7/V
        ifxbuYryDAA061lmZiKnNfPjFQ==
X-Google-Smtp-Source: APXvYqz64vkoxOE4EQs46gfUEcIe4/aro/VSVoDbKVLqlkF/Wp4gQCM+MeXmJJs5eEbVdVMNop8DWQ==
X-Received: by 2002:adf:b651:: with SMTP id i17mr15172610wre.108.1552990885773;
        Tue, 19 Mar 2019 03:21:25 -0700 (PDT)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id q2sm27895781wrd.46.2019.03.19.03.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:24 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 0/8] Allow checking SYN cookies from XDP and tc cls act
Date:   Tue, 19 Mar 2019 10:20:55 +0000
Message-Id: <20190319102103.7380-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222095057.9442-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds the necessary helpers to determine wheter a given
(encapsulated) TCP packet belongs to a connection known to the network stack.

* bpf_skc_lookup_tcp gives access to request and timewait sockets
* bpf_tcp_check_syncookie identifies the final 3WHS ACK when syncookies
  are enabled

The goal is to be able to implement load-balancing approaches like
glb-director [1] or Beamer [2] in pure eBPF. Specifically, we'd like to replace
the functionality of the glb-redirect kernel module [3] by an XDP program or
tc classifier.

Apologies for submitting during the merge window. Thanks to Martin KaFai Lau
for his review!

Changes in v2:
* Rename bpf_sk_check_syncookie to bpf_tcp_check_syncookie.
* Add bpf_skc_lookup_tcp. Without it bpf_tcp_check_syncookie doesn't make sense.
* Check tcp_synq_no_recent_overflow() in bpf_tcp_check_syncookie.
* Check th->syn in bpf_tcp_check_syncookie.
* Require CONFIG_IPV6 to be a built in.

1: https://github.com/github/glb-director
2: https://www.usenix.org/conference/nsdi18/presentation/olteanu
3: https://github.com/github/glb-director/tree/master/src/glb-redirect

Lorenz Bauer (8):
  bpf: track references based on is_acquire_func
  bpf: allow helpers to return PTR_TO_SOCK_COMMON
  bpf: add skc_lookup_tcp helper
  bpf: add helper to check for a valid SYN cookie
  tools: update include/uapi/linux/bpf.h
  selftests/bpf: allow specifying helper for BPF_SK_LOOKUP
  selftests/bpf: test references to sock_common
  selftests/bpf: add tests for bpf_tcp_check_syncookie and
    bpf_skc_lookup_tcp

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  36 ++-
 kernel/bpf/verifier.c                         |  33 +--
 net/core/filter.c                             | 185 ++++++++++++++-
 tools/include/uapi/linux/bpf.h                |  36 ++-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   8 +
 .../bpf/progs/test_tcp_check_syncookie_kern.c | 126 +++++++++++
 .../selftests/bpf/test_tcp_check_syncookie.sh |  81 +++++++
 .../bpf/test_tcp_check_syncookie_user.c       | 212 ++++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c   |   6 +-
 .../selftests/bpf/verifier/ref_tracking.c     | 126 +++++++----
 tools/testing/selftests/bpf/verifier/unpriv.c |   8 +-
 14 files changed, 789 insertions(+), 75 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
 create mode 100644 tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c

--
2.19.1

