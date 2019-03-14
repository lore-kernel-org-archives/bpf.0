Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343FFC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009DA20854
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NhlpnCa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfCNLkf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:40:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35226 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCNLkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id t18so5481259wrx.2
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZBDm+cVJzq/Y2HJGOefBV1X/maW8xuv3PGfESLfRhw=;
        b=NhlpnCa8aT+4t78ZjCxszOYvnhhhT8779lOooO95ixmnbnakrEAWixEK67aFdkU+GW
         IaNg2Z0GxQgJXt73dNRcRagKZ0c4QgloHkCK84LIw/DCUntCizsfwdYU1tTnPDkO0MTA
         WqMI+PRjTiaJLd9zf/FqQhQnG/JK0JVX6d8Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZBDm+cVJzq/Y2HJGOefBV1X/maW8xuv3PGfESLfRhw=;
        b=R/CKpTUKnhD3C7cSg5l5oESJA3gfWcnYsO+WaTrieyfJQnzs7k5QbENL1E/zXHm09n
         NS108zNZtc7YT+7uirffRk4ioXgX0Ifadhk1BqPR6a/Po+htZPtXrEivEzzS3CfFaCfo
         3C++J8H357jdHFIQEXOBMZFGSp2wybzgcm4Xb6Qkat6wBmHS9oWkbCg3DMAYHoz68zA/
         RTU9IV3DCTlIWLoaiApc48ylk7jssCZ8ZGlXdG8Gezy+KvUjqgG6FeFtsvd+EvEv6Td9
         HLeobyVPyVJ+ZGouoEzkPxb/6v6Cqqin8a4xDq/6WJRYHfAwt8aXa699EcWYtAuYI+Hd
         +7Ew==
X-Gm-Message-State: APjAAAWLRP2zz8DACGaW3ySInM2uVXoLjo41UB9u/gmtO9YMyxk82NLl
        /rnuX+mt/t068rW+YrFw6a/zLA==
X-Google-Smtp-Source: APXvYqxXEfegnQXlYbN1nrzn8Gaa/AG6xQbTlswHUgy04FQ89Gx3P4TWGse+ZPwxb+XFmneLNSMIlQ==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr26930305wro.24.1552563633187;
        Thu, 14 Mar 2019 04:40:33 -0700 (PDT)
Received: from antares.lan (5.8.9.5.4.5.2.4.f.f.6.d.4.1.5.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8514:d6ff:4254:5985])
        by smtp.gmail.com with ESMTPSA id a9sm1804017wmb.30.2019.03.14.04.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:40:32 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, theojulienne@github.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 0/8] Allow checking SYN cookies from XDP and tc cls act
Date:   Thu, 14 Mar 2019 11:39:46 +0000
Message-Id: <20190314113954.10210-1-lmb@cloudflare.com>
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

Thanks to Martin KaFai Lau for his review!

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

