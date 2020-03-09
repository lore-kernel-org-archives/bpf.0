Return-Path: <SRS0=BaJ4=42=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E89C10F27
	for <bpf@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75BA2051A
	for <bpf@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="t6D3f0aQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgCILNK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:13:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45439 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id m9so1516002wro.12
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYROj5HsRYbnBFzlK0FzkrwDUfzZsnteghLz6nqHevI=;
        b=t6D3f0aQpn8rgusmcwNDPyMX4Ge1CTlojGAW1FhMP3gEWYZRKqAZt4BA17FONeKtds
         Z1N4Wn1IFMIT9GTUDcCH22VQXy9q4nOeNuLfAH5SFuGW8/M7KlonMp0ekhOCEW9IGosy
         KWUNUkrLo7v+MgPV8MV5d1OupI6+HJj5LcRu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYROj5HsRYbnBFzlK0FzkrwDUfzZsnteghLz6nqHevI=;
        b=cGgQPjMzF+uDKfBPP/fmGxZJqRqUHcklgYLtxSsN6tl0nzybgLQddFIiqxxTJboSt8
         EAbgCyi3gHJf3etdbs5V4RdMJDWuoM3/DRd0RWYGd6Z3qLH+nfoFQk821tJWEEEmuJkj
         jFdnYFNECWW3IXKxQ83oX4HQnjWpEnVwb1JcD9r2cwh3VR4sCxcq8f+myKZJAHFLfGx/
         aG7CqmRYE5K99oYCD59ykoZwpzRTnV8psWM4QEass1DklBrd1nSY4kuMV4h750mVvXEU
         SSFjgvrRfnlFFGbft1UOCu2LfrkJ6Z/sWnFt+v1OOaqsOp2MA5QNg6N9rZtUPCgUkzVA
         4VHg==
X-Gm-Message-State: ANhLgQ2HUmGBM1aN8bB9ajXzO8ItqU+41CsxIo6ZxLJwKJowPczYXYEz
        t70Qk/21nqC8jSj7A7DH8j5/xw==
X-Google-Smtp-Source: ADFU+vuEqABspoMtH2L9hlsNVwAkxs96SFOjG9gFG/lIYA1AV6FZOaFo4wEnzdIyJGKwCALNb1nvAA==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr19940280wrx.382.1583752388090;
        Mon, 09 Mar 2020 04:13:08 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:07 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 00/12] bpf: sockmap, sockhash: support storing UDP sockets
Date:   Mon,  9 Mar 2020 11:12:31 +0000
Message-Id: <20200309111243.6982-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I've adressed John's nit in patch 3, and added the reviews and acks.

Changes since v3:
- Clarify !psock check in sock_map_link_no_progs

Changes since v2:
- Remove sk_psock_hooks based on Jakub's idea
- Fix reference to tcp_bpf_clone in commit message
- Add inet_csk_has_ulp helper

Changes since v1:
- Check newsk->sk_prot in tcp_bpf_clone
- Fix compilation with BPF_STREAM_PARSER disabled
- Use spin_lock_init instead of static initializer
- Elaborate on TCPF_SYN_RECV
- Cosmetic changes to TEST macros, and more tests
- Add Jakub and me as maintainers

Lorenz Bauer (12):
  bpf: sockmap: only check ULP for TCP sockets
  skmsg: update saved hooks only once
  bpf: tcp: move assertions into tcp_bpf_get_proto
  bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
  bpf: sockmap: move generic sockmap hooks from BPF TCP
  bpf: sockmap: simplify sock_map_init_proto
  bpf: add sockmap hooks for UDP sockets
  bpf: sockmap: add UDP support
  selftests: bpf: don't listen() on UDP sockets
  selftests: bpf: add tests for UDP sockets in sockmap
  selftests: bpf: enable UDP sockmap reuseport tests
  bpf, doc: update maintainers for L7 BPF

 MAINTAINERS                                   |   3 +
 include/linux/bpf.h                           |   4 +-
 include/linux/skmsg.h                         |  56 ++---
 include/net/inet_connection_sock.h            |   6 +
 include/net/tcp.h                             |  20 +-
 include/net/udp.h                             |   5 +
 net/core/sock_map.c                           | 157 +++++++++++---
 net/ipv4/Makefile                             |   1 +
 net/ipv4/tcp_bpf.c                            | 114 ++--------
 net/ipv4/tcp_ulp.c                            |   7 -
 net/ipv4/udp_bpf.c                            |  53 +++++
 .../bpf/prog_tests/select_reuseport.c         |   6 -
 .../selftests/bpf/prog_tests/sockmap_listen.c | 204 +++++++++++++-----
 13 files changed, 402 insertions(+), 234 deletions(-)
 create mode 100644 net/ipv4/udp_bpf.c

-- 
2.20.1

