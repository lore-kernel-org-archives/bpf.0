Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FB4C9013
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608178; cv=none; b=DD9+rDwiXgPWYXikKqODyERc8/XjHOTEUj+CZknfIa4eueAFfAjNwJ46HRdkKw1SH8S3CkX37ESLF37Gu/g8ZFc6hyt8yrJe3assJOw3DLPHhQO3wXe21tC8U5ZMUKei582Q8PsG8DYWVJT8BTOuwJILbL5xcrV3LzuuqESClmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608178; c=relaxed/simple;
	bh=Kdjr65lbHG3qucTiiQPPGK2T43njYsjG6p3w/MesfY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dstf69WvrQKVgBf48xLVq62HtGcoWJJtZ4irDKYMBEW4tN062+iUx0e2sIKyLbISisKjbGnNXHho+kxa8kfI04X3FIVkQnMzXIxYDy8oHX7Fg6lAuw4T5XLZoa/y6ADaW7byBx4wckC6hp5glAg2NUUX/7qcsZ5yPP8p7v21fKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ACNbzEFh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ACNbzEFh"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654DucRl1173070
	for <bpf@vger.kernel.org>; Thu, 4 Jun 2026 14:22:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=e4bu41aIp9KB0oOttkR2S8a39KtXyhF
	MpFg5ISnDgJA=; b=ACNbzEFhHsooe6ojNyrU7nWRrVi7ZHKpxTi8X8rtxMJxeDT
	oQqDBPkEjiLPDYznZ6limEV7sGu0J5SNuku2K+zvbj+K7QmI01aVTFtZkF/NF6B3
	XMYnFx7BkcbOeJq7r6zTViy6ff/ZMUNit5vKemAO11zPHGb5szV18pNgDa7TNqO0
	0zrqKVRxCLh0oAKsKeoY+Ao9hbJ3CRwydZGPjlWOcj7syDWfIfrlhUiZqvrtsPz2
	cwnEKj01nVoWbFWU97GE7OfZkmKlyknoX4L1o86ftwpu5SvwtYVwrydNpQvIg85o
	ZSdt1vPCFwGcICZ2qkwJx3tf4xVnIT02k3Bjxjg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ek94vumgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 14:22:51 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6b73b3920so1635274a34.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 14:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780608170; x=1781212970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4bu41aIp9KB0oOttkR2S8a39KtXyhFMpFg5ISnDgJA=;
        b=lInBa5aQgv59Ljt/7h5aHXHf+hIdSl6TeoQ4PKVdMbyW8e70WpW+oXp/rb/23LaY1b
         I9ojGKJyUnjBiI8hYzWKhp+p79qgBqlRmqysN7dlNyynN0FZUcpUc4OZZmwQp/npaUj/
         ilNjUD0FU/OLHalfez3K6DojIYmFMrXXZ5BBEsjtYMLiXKOdnjW5Bk9y0JAWWf0kQvIN
         R9KU7c01xZ+vS3IBzKmoCpm8eBhY6yRWySnFhrHK80s20tyh0wnZd0rrckmmitKRuXKG
         2f++6GwNjNW1+406U3Q1pSlF98D5egRpN08B6L7KmyO0kcBphTiSYUNqWPy80ENq40tE
         04Fg==
X-Forwarded-Encrypted: i=1; AFNElJ8wnKf9O8xz9irrhHm5USv2gh57IuZocUy2MQ9Oy+RX9c2PXiMOV+lclhIv6kIo15Uz5MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTnBgPj7xgJ7T/wRokbb5s4l6Jc6B5If1mUjyMR2GS7ZB0a7N
	vUv5Y4vy+s7RlsWJRGDfutPbgh9nOEeXWkCUoaSksJ2DthWGb167zBHBcD3MGk1Itq8Sad9TWya
	OMffrFObL1kbjQBe5M6L+f1U34dJVLQ/Kuyr0GTaDojmEyrtlq6MMZFECYBA=
X-Gm-Gg: Acq92OFiHQUznUyoe1mAhYoHMfxbNPBYVjq7LyoFjonTxnSc2/Gtku92IMLo6h2gWLq
	HC8wBFvZQZl34hBgHZJjmpw8kL5Vwed9rPIkHNmt2kIlaPYrUm+hK4MNYauE4ifRSJPd1JsvNx9
	elq5jd3TMCf8srMzTw/RoBYlH7aHobDKqXtLCwLzt3pERwF/4YnVt2yNOp7PgmNrDebJRGo1yf/
	2+Ij2tR/SApQke/b2dZbRgBZnW19mCLV63b2DYEdB8zw0sX805r+YtI7jPro6zNqNi1VN312ZOy
	+w7SYx3NM4QYQABFjO2vNjd5WFVVvE5L9tmJFC7s2KWRZ76QCwUJU+EScAWOTM7K51A6Hky4VCn
	vFdytgO9/vejz1OQWi8YpiA==
X-Received: by 2002:a05:6830:4986:b0:7e6:f2ef:e232 with SMTP id 46e09a7af769-7e70ca9bccdmr260222a34.19.1780608170188;
        Thu, 04 Jun 2026 14:22:50 -0700 (PDT)
X-Received: by 2002:a05:6830:4986:b0:7e6:f2ef:e232 with SMTP id 46e09a7af769-7e70ca9bccdmr260203a34.19.1780608169739;
        Thu, 04 Jun 2026 14:22:49 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e14b9sm4692298a34.13.2026.06.04.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:22:49 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v12 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Thu,  4 Jun 2026 14:22:44 -0700
Message-ID: <20260604212246.265079-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hWGibaz9gp5UWuNadRnwMrenwBY6esmf
X-Proofpoint-GUID: hWGibaz9gp5UWuNadRnwMrenwBY6esmf
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a21ecab cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=UiyovihmSlTbsT8-nD0A:9 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIwOSBTYWx0ZWRfXxec/6/jPmyPZ
 A3shDOegftvgYmY1Atm7kmxXgD3uGed+6uJryH3H/au97ArNOX8KE0Jj0s9GUBVR1ht9f0r7975
 5rdrfeZ1s6+tWBwWdOnC0Xxt83kgy5skVxYgpztx8CMct1L7XcPwJgoidX9XUp9o7OpIlzsVcRl
 8EukpI+PWoR3InPHr7yGWP7+V2FKtZ3WWwXaOp/jSTxs4aES43iKr23kUvqrBpXAFwaWd3iALr6
 YGYIONFnvl5Yi/uINGWygJ9vp/RhBC1xALJrxRdE3H4b8MK/bgvM1Cp8xtElrEJx7m+zhgr+yj2
 ugn7i6v492xW3EXxGOB2uYnKMdFX1/s1mMEV866+sUkBLmOjC+UQSbsV10w6s6ShSWHRQizNLdP
 Lc+Rz97u2X9adIGCEGUfkflOeyDBZ7JeIGChscgVKtKoy30BgByP5VR7LK8b9/CWA+B6Si7gZkq
 eDc3dwa+M08nPnxYBYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection logic.  The cached
route is reused and fib6_select_path() is never re-invoked, so
the connection uses the same local ECMP decision.

This series adds the two missing pieces:

1. __sk_dst_reset() alongside sk_rethink_txhash() so the cached dst
   is invalidated and the next transmit triggers a fresh route lookup.

2. fl6->mp_hash set from sk_txhash before each route lookup so
   fib6_select_path() picks a path based on the (potentially re-rolled)
   hash.  This only applies to fib_multipath_hash_policy 0 (the
   default L3 policy).  Policy 0 is already asymmetric for TCP: with
   auto_flowlabels enabled (the default), each socket gets a per-socket
   flowlabel, so the hash is already per-connection and unidirectional.
   For policy 0 the local ECMP path now follows sk_txhash even when a
   flow label is present (reflected REPFLOW or explicitly set); only
   local path selection changes, the on-wire flow label is unaffected.
   Policies 1-3 exist for operators who need deterministic symmetric
   hashing (e.g., for stateful middleboxes) and are left unchanged.

Patch 1 is the kernel change; patch 2 adds selftests covering SYN
rehash, SYN/ACK rehash, midstream RTO rehash, midstream ACK rehash
(spurious retransmission), PLB rehash, a policy 1 negative test,
a flowlabel leak regression test, two dst rebuild consistency
tests (normal and syncookie) verifying that natural route
invalidation does not cause unintended path changes, and a
syncookie server path consistency test verifying that the SYN-ACK
and post-cookie ACKs use the same ECMP nexthop.

Changes since v11: https://lore.kernel.org/netdev/20260602181428.2318919-1-ntspring@meta.com/
Patch 1:
- Fix the IPv6-only rule to exclude IPv4-mapped connections: key the
  cookie txhash on skb->protocol, not sk->sk_family (Sashiko AI review)
- Set fl6->mp_hash in tcp_v6_send_response() so RSTs and time-wait
  ACKs use the connection's ECMP path (Sashiko AI review)
- Remove the bpf_sk_assign_tcp_reqsk() txhash init added in v7; it is
  redundant, as cookie_tcp_reqsk_init() always sets txhash before the
  request socket is routed (verified by poisoning txhash and running
  the tcp_custom_syncookie BPF selftest: the route lookup never saw
  the poison)
- Document that policy 0 IPv6 TCP ECMP selection follows txhash over a
  reflected/explicit flow label (on-wire flow label unchanged)
Patch 2:
- Drain TCP teardown between rounds so late FIN/RST packets do not
  pollute the next round's tc filter counters (bot+bpf-ci)
- Skip the syncookie tests when CONFIG_SYN_COOKIES is unavailable;
  select it in selftests/net/config

Changes since v10: https://lore.kernel.org/netdev/20260529160136.1010064-1-ntspring@meta.com/
Patch 1:
- Fix build without CONFIG_SYN_COOKIES
- Leave IPv4 syncookie txhash unmodified (`net_tx_rndhash()`)
- Document the IPv6 TCP policy 0 behavior change in ip-sysctl.rst
Patch 2:
- Correct runtime estimate from ~15s to ~60s
- Build DCTCP as `=y` instead of `=m` to avoid module load races
- Fix false failure of the midstream ACK test by limiting the send
  buffer to avoid a closed receive window; window probes do not
  cause rehash

Changes since v9: https://lore.kernel.org/netdev/20260526203403.3517607-1-ntspring@meta.com/
Patch 1:
- Split cookie_init_sequence() into pure computation and a new
  cookie_record_sent() helper for the side effects; call
  cookie_record_sent() after route_req() succeeds so the overflow
  timestamp and SYNCOOKIESSENT counter are not bumped when no
  SYN-ACK is sent
Patch 2:
- Make midstream ACK rehash test more reliable by blocking the unused
  path first
- Fix port overlap when ECMP_REBUILD_ROUNDS exceeds the default

Changes since v8: https://lore.kernel.org/netdev/20260522215733.929238-1-ntspring@meta.com/
Patch 1:
- Fix REPFLOW flowlabel reflection for syncookie SYN-ACKs: pass 0 as
  tw_isn to route_req() so tcp_v6_init_req() saves ireq->pktopts
Patch 2:
- Give midstream and ACK rehash attempt helpers distinct failure
  messages (no TX activity vs no data on alternate path vs counter
  not incrementing) instead of a single generic error
- Drop unused ns_server parameter from ecmp_dst_rebuild_check()
- Clean up server socat before break on setup failure in the dst
  rebuild loop

Changes since v7: https://lore.kernel.org/netdev/20260520064310.4154268-1-ntspring@meta.com/
Patch 1:
- Remove #if IS_ENABLED(CONFIG_IPV6) guards around __sk_dst_reset()
  in tcp_plb.c and tcp_timer.c (Eric Dumazet)
- Guard mp_hash in inet6_csk_route_socket() on sk_protocol == IPPROTO_TCP
  instead of txhash != 0, since non-TCP callers like L2TP set sk_txhash
  in __ip6_datagram_connect() and should retain flow-key-based ECMP
- Use the syncookie (ISN) as txhash for both the SYN-ACK route lookup
  and cookie_v6_check() socket creation, so the server's ECMP selection is
  consistent across the stateless SYN-ACK and the subsequent full socket.
  Move cookie_init_sequence() before route_req() in tcp_conn_request()
  so the SYN-ACK dst is computed with the cookie-derived txhash; derive
  txhash from snt_isn in cookie_tcp_reqsk_init() to match
Patch 2:
- Invalidate dst via dummy route add/del instead of route replace to
  avoid a transient single-nexthop state during multipath replacement
- Add syncookie server path consistency test verifying the SYN-ACK and
  post-cookie ACKs use the same ECMP path
- Strengthen policy 1 negative test to wait for multiple rehash attempts
  and verify SYNs landed on exactly one interface

Changes since v6: https://lore.kernel.org/netdev/20260517174522.2232057-1-ntspring@meta.com/
- Guard mp_hash assignment so that non-TCP callers of
  inet6_csk_route_socket() fall through to rt6_multipath_hash()
  (superseded in v8 by sk_protocol == IPPROTO_TCP guard)
- Initialize txhash in bpf_sk_assign_tcp_reqsk() to avoid reading
  uninitialized slab memory in inet6_csk_route_req() (reverted in v12
  as redundant)
- Check post-rebuild busywait return status to avoid silent false pass

Changes since v5: https://lore.kernel.org/netdev/20260513204048.2721843-1-ntspring@meta.com/
- Improve selftest reliability: suppress __dst_negative_advice() via
  tcp_retries1=255 in dst rebuild tests so a real RTO cannot trigger
  an unintended rehash; add internal retry to midstream and ACK
  rehash tests to tolerate probabilistic ECMP path selection; fix
  midstream baseline capture to account for packets that bypass tc
  filters during the prio qdisc's TCQ_F_CAN_BYPASS window
- Increase ECMP_REBUILD_ROUNDS default to 10 for reliable regression
  detection with 2-way ECMP; replace sleep with busywait
- Use tcp_allowed_congestion_control instead of changing the host's
  default congestion control for PLB test
- Use (txhash >> 1) ?: 1 to guarantee non-zero mp_hash, since zero
  falls back to rt6_multipath_hash()

Changes since v4: https://lore.kernel.org/netdev/20260507171319.1259115-1-ntspring@meta.com/
- Condition fl6->mp_hash on fib_multipath_hash_policy == 0 to preserve
  deterministic hash policies 1-3 (e.g., symmetric 5-tuple for policy 1)
- Set fl6->mp_hash in tcp_v6_connect() and cookie_v6_check() for
  initial route lookup consistency; move sk_set_txhash() earlier
  (Jakub Kicinski)
- Add policy 1 negative test; improve sysctl save/restore
- Add flowlabel leak test confirming mp_hash does not alter the
  on-wire IPv6 flow label
- Add dst rebuild consistency tests (normal and syncookie) verifying
  that route table changes do not cause unintended ECMP path changes

Changes since v3: https://lore.kernel.org/netdev/20260505193824.2791642-1-ntspring@meta.com/
- Use __sk_dst_reset() instead of sk_dst_reset() since the socket lock
  is held in all three call sites (Eric Dumazet)
- Guard __sk_dst_reset() with sk->sk_family == AF_INET6 since IPv4 ECMP
  does not use sk_txhash for path selection
- Guard __sk_dst_reset() in tcp_plb_check_rehash() with the return value
  of sk_rethink_txhash()
- Move tcp_rsk(req)->txhash initialization before route_req() in
  tcp_conn_request() to avoid reading uninitialized memory
- Add CONFIG_TCP_CONG_DCTCP=m to selftests/net/config for PLB test
- Skip PLB test gracefully if DCTCP is not available
- Save and restore original congestion control algorithm in PLB test
- Default get_netstat_counter() to 0 when counter is not found
- Skip all tests if tcp_syn_linear_timeouts is not available
- Replace bash/pipe data sources with socat OPEN:/dev/zero for
  cleaner process cleanup
- Fix shellcheck warnings

Changes since v2: https://lore.kernel.org/netdev/20260408070514.1840227-1-ntspring@meta.com/
- Retitle "ECMP" to "local ECMP" to distinguish from remote ECMP
  (Neal Cardwell)
- Add fl6->mp_hash propagation in inet6_sk_rebuild_header() (af_inet6.c),
  covering the dst rebuild path used on established sockets
- Remove incorrect ir_iif update from tcp_check_req() in tcp_minisocks.c;
  the SYN/ACK rehash is already handled by tcp_rtx_synack() re-rolling
  txhash which feeds into inet6_csk_route_req()'s mp_hash
  (Eric Dumazet)
- Add ACK rehash and PLB rehash selftests
- Improve selftest reliability

Changes since v1: https://lore.kernel.org/netdev/20260408002802.2448424-1-ntspring@meta.com/
- Use tcp_rsk(req)->txhash instead of jhash_1word(req->num_retrans, ...)
  for ECMP path selection in inet6_csk_route_req(), making the request
  socket path consistent with the established socket path (Eric Dumazet)
- Add comments explaining the >> 1 shift for 31-bit mp_hash range
- Use socat -u (unidirectional) in selftest to avoid SIGPIPE race
- Increase tcp_syn_retries and tcp_syn_linear_timeouts to 25 for
  better rehash coverage

Neil Spring (2):
  tcp: rehash onto different local ECMP path on retransmit timeout
  selftests: net: add local ECMP rehash test

 Documentation/networking/ip-sysctl.rst     |    6 +-
 include/net/tcp.h                          |   20 +-
 net/ipv4/syncookies.c                      |   11 +-
 net/ipv4/tcp_input.c                       |   19 +-
 net/ipv4/tcp_plb.c                         |    5 +-
 net/ipv4/tcp_timer.c                       |    2 +
 net/ipv6/af_inet6.c                        |    3 +
 net/ipv6/inet6_connection_sock.c           |    8 +
 net/ipv6/syncookies.c                      |    4 +
 net/ipv6/tcp_ipv6.c                        |   21 +-
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    2 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1106 ++++++++++++++++++++
 13 files changed, 1193 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

-- 
2.53.0-Meta

