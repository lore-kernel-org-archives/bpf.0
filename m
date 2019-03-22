Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24795C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE31A218FC
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qj62yeeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfCVByY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45012 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVByY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so329822pgj.11
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 18:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbrqtsqiTytIzddjqtL0Hz/w19VokftbisNMDRGuDTA=;
        b=Qj62yeeNj0exv5WnIr5wZ4qkIqIpmaEJtrFOcN13/Out589ytNqfqshqNqg0Sb1VK7
         iO5884luSZ/aI1e2nP+WkR1KtRzFMnxiyrg9Pnbm0VP97LNMXMIljR153om+K0F13Ncq
         OKOYdSHwU3ls3Xz9Rzi158NJCPJpvZcK9hnK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbrqtsqiTytIzddjqtL0Hz/w19VokftbisNMDRGuDTA=;
        b=oDd5m4P+DWhDwNV5Y8BYKMOkj/ge9WsjAeiy6B/IUUUCSnbzWfTS0ox21tl85Uk84V
         pfXGL5aMmiIm5MquN4DGwp0lcrPWTC3dqAS09vk57AxTZbenAT2KAaKfosqdv0IdNFfU
         9ez7Wrrhg+TL7dMtzt7bzigHEbmbDjaE0LZTKR4cxxBIBAow/b9PndVOM+rWal69/6LD
         IOw7IvICy10RZNNOnlREfmC+KbH4juL8vAkYBcdxJgZWJnbYT+jP5xz9Bs8tiw2q/fDQ
         HW5pgwjGVoSqBhVKJ0IrnHbjTMMjTow/IdRvyjYFICRJP+NV92R7N9Y3/8VAiqb3Q4R9
         GV7g==
X-Gm-Message-State: APjAAAXxH/OeoLzBpEkzntmhiMop+9lNuKFR9keeJ5FUH8TU6yAPQeRA
        YjT5fr9nhmYDp/gRSxfv0x76UQ==
X-Google-Smtp-Source: APXvYqzUzCs4OfxwBmUmD2esrEDXIF6F7o8HohvlJpEPBGORNm6QwM0wCmHZB6DbrFBdMiy/VrjSwg==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr6569791pld.172.1553219663431;
        Thu, 21 Mar 2019 18:54:23 -0700 (PDT)
Received: from localhost.localdomain ([157.120.241.186])
        by smtp.gmail.com with ESMTPSA id i10sm7161799pgs.26.2019.03.21.18.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:54:22 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 0/8] Allow checking SYN cookies from XDP and tc cls act
Date:   Fri, 22 Mar 2019 09:53:58 +0800
Message-Id: <20190322015406.26453-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190319102103.7380-1-lmb@cloudflare.com>
References: <20190319102103.7380-1-lmb@cloudflare.com>
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

Changes in v3:
* Fix missing check for ip4->ihl
* Only cast to unsigned long in BPF_CALLs

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
 net/core/filter.c                             | 216 ++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |  36 ++-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   8 +
 .../bpf/progs/test_tcp_check_syncookie_kern.c | 129 +++++++++++
 .../selftests/bpf/test_tcp_check_syncookie.sh |  81 +++++++
 .../bpf/test_tcp_check_syncookie_user.c       | 212 +++++++++++++++++
 tools/testing/selftests/bpf/test_verifier.c   |   6 +-
 .../selftests/bpf/verifier/ref_tracking.c     | 126 ++++++----
 tools/testing/selftests/bpf/verifier/unpriv.c |   8 +-
 14 files changed, 811 insertions(+), 87 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
 create mode 100644 tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c

--
2.19.1

