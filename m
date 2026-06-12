Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A071E1A3D
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226054; cv=none; b=WUzWzKAzJVMZhIovW8PoxxjqvvPEZ8ftfZu/Vb1ATeI3zFewf7/N7NaoLSawIv07lYDZYmFmrIQm790lJBwao4dlORJxRLyWhfQy5GWa3s+xe5MM76j69yhVGmSK2uA6FeOWMeBoAXnc14lV/6d+UvH/C8j2BA6YDBDEDKiiTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226054; c=relaxed/simple;
	bh=mm7lhGurzpH5S1D4K03Qa3k5Ics0Cd5OlZOIs6VTP1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnk94NjBERdCfg+sDBANRI49gUS0W8dbhZdf3Ur/0xivNlugi0vot0HG8p4acdHAvIkDgHqSWfkA+yftcxmsR/ekZKw+ajhER1jQ9gsQkNgTkIcH8d7TVX6njEfZdVqdE28BXLuiQiGjFV+jHA2oPIsHh+wG4+Ykh1P0dO092xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HG1HyNyj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HG1HyNyj"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BE1F0k3150808
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:00:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=zFDj2IOT/JWpaH+VD8OkJUPInevQlFQ
	dH2RzPJRh3Qk=; b=HG1HyNyj+U73SKLwM4GsJrV9X3AOr0Aze0Ckd32xiLQR85R
	TPIC1lgy8EM7sfXNAYysf/6QNrWy92NuFQPAQfaB61+XaM8rCU5cCcSjEcsTy+f3
	1Ng3RmrIyEsZi6kZd0ERzEMVkQUYqPA5mnaUOSi3id/WHbKQ14tkh7+jcihLS+1p
	YtCkl46kLygTNxlOliCHqJt2uKStRL6D4EzDzRzrlVQNYpRc/KzsF0K7cVaa9jdX
	xNhikC5b1RYQ2U3XVMzIEwsnHuM7rl4BreajsHLImbTpi9KJh4hhNK6YbRRz3Z3u
	If+IXOJYHTW1WWuxoNbrZ6cWDCZrESwJwJhmWFg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78a38w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:00:51 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6f7f4e47eso1051468a34.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226050; x=1781830850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFDj2IOT/JWpaH+VD8OkJUPInevQlFQdH2RzPJRh3Qk=;
        b=C56K1d4lUAUfb2yXSy24uWkLaKhZaaV2q/t1A/RRGP3vwOvZOCpXSYzrNHsT3AZVOa
         56cvHsj6iJI6Z+9fq/NO05Krf+UaS0dG6cQ0qxUcvwJoekimgFwaxPgmnUi87d4bzxVz
         6S+FObxm0mrNVwd1/2CSCFUdtuI/Y2yRVjCJ3Wk7srJrMutpdTLqsQkH9ID9M6c7oaB4
         0xKc8Fq+KClz2Y7ewq38KzSsXPMOrmlZo+pF/xrNdF12QVyvZPZULl9oSiAyL8Kgl8B0
         Db6CrXDvwuBIVt05vOltWUSLxprqoQUygJF1MHew7U4TxtC2S2YYAZqfTUc5nVhqxwJo
         XQ+A==
X-Forwarded-Encrypted: i=1; AFNElJ+9odk/NwuFzlVTl8TjMN+ey2xtbXxRWRrj4ZCdecf5ozeKLf/Ac2vuv4vcJ4POPpM/3/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXwSm18apn6N0LG1AsSkRnLTMuzDGgXWkcevF3I72p47HHVFH
	SaGioZdxn5IyDbLwUkQ/XJPlmIT+TJW9EORyhic2aBs1vUCGRB3GX5tH3PhNyHb758yn4gS9PC4
	nCS4qPnx5FlKrsK/4UJs6OrxNqUpQfF8hJ8+ej1BbLVJCY0Mb4WM=
X-Gm-Gg: Acq92OGDaEWgNd5TAhjQTwqXk+zCybsqLC8uuAmJmpcA9Dt4ohnEkktZmADpy4YvLyW
	z3XO2MRLaXc6JtyqqKWjE5stsSAUhDRW51OuFD8CElng++IS7sXpLW+ZwgiPZu+IGT0Snyqh91C
	iyXsMZygltoPoRrBnvTTnaZLmRUkoimFa5DGSWv9KAIjJcoVgvdu13nrruod5SbQ+TB+wYuo981
	s0/G+Un8EaV2xdEPzR1pcYVm2tTH9c9c32+cGiZgq+hOFkzZK0jOFtnLsB+5GvJ8VGRNI/lCUYl
	9k0ePGjimUo0A3gsoGMaSSIcEwmNRHLNKHlS+KxZi0mhb4NwvgSOm9irWgXVW1dt93PjCrbUIY0
	nJ2GZhZyqEQ==
X-Received: by 2002:a05:6830:7007:b0:7e6:fdea:7aee with SMTP id 46e09a7af769-7e7847b6cf6mr381225a34.24.1781226050252;
        Thu, 11 Jun 2026 18:00:50 -0700 (PDT)
X-Received: by 2002:a05:6830:7007:b0:7e6:fdea:7aee with SMTP id 46e09a7af769-7e7847b6cf6mr381196a34.24.1781226049731;
        Thu, 11 Jun 2026 18:00:49 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e78144823asm751251a34.5.2026.06.11.18.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:00:49 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v13 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Thu, 11 Jun 2026 18:00:45 -0700
Message-ID: <20260612010047.1377331-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAwNiBTYWx0ZWRfX+lm+mIJ9drOH
 rMbmgIqp2X6LMBIDNQMf9K0+lY4UaVLNTM0zC4AbrFpQrg3EGeY0JsPMSiDWO3jCuPgFNpRAU3F
 XgoVT/bzIabAqcDJjFr5B1O1hE9vPjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAwNiBTYWx0ZWRfX+uixYFm6GNxP
 qTgIO4XwPKuahPdEPC9OrWNgjrFJrWM5Vcbj0JzSoNx+xylgUV/d43U5qQsOjaO8zTMfH6NXyek
 zLeklL6DcOZOiiOqoJfeNs8cAZL0xxU1SreCti8LBx3BGs7FzzZIirwpNA81QrzWzlc0gVM/uLV
 rCKD5odYYScSnpfPCB6LP97sEPCiSTFySX+IJLB2xtI7xGytgH12A1pVzsvxM6BcywjeBrCYClE
 MK1jf745X5+kZ4BUBnLgs3Q//+rHgPQeg70BAUIa0weFbGTsSDygH0j4/Edf4YM1jPJmaUqFSpL
 imMuH/ZMrIcEPAM1tKGJ+k8i7teiqHqKhms+F897d84GAs7tHEtRhSsQuknIXd9Y/KE6sPgHyqn
 al2De4ctyg3xIlV1aHkGWaUf8z2vhIeWiuf2g5l7cwk1N7kSBAr3xBmWyENMZwH5hhcO2pssyFA
 3nASITJRzvezemtziaw==
X-Authority-Analysis: v=2.4 cv=etLvCIpX c=1 sm=1 tr=0 ts=6a2b5a43 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=FMVIpMHTegAHNGUTmSsA:9 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 6AdtSeBwo6etGdCVw1CNk1b4aUrFo9io
X-Proofpoint-GUID: 6AdtSeBwo6etGdCVw1CNk1b4aUrFo9io
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection.  The cached
route is reused and fib6_select_path() is never re-invoked, so
the connection uses the same local ECMP decision.

This series adds the two missing pieces:

1. __sk_dst_reset() alongside sk_rethink_txhash() so the cached dst
   is invalidated and the next transmit triggers a fresh route lookup.

2. fl6->mp_hash set from sk_txhash before each route lookup so
   fib6_select_path() picks a path from the (potentially re-rolled) hash.

The override applies only to fib_multipath_hash_policy 0 (the default L3
policy).  Its hash includes the flow label, but that is 0 by default
(np->flow_label is unset; auto_flowlabels computes the on-wire label
later, per packet), so flows to the same peer share one local path.
Keying it on sk_txhash makes that local path per-connection and lets a
rehash re-select it; even when a flow label is present (reflected REPFLOW
or explicitly set) only local path selection changes -- the on-wire flow
label is unaffected.  Policies 1-3 are left unchanged.

Patch 1 is the kernel change; patch 2 adds selftests covering SYN
rehash, SYN/ACK rehash, midstream RTO rehash, midstream ACK rehash
(spurious retransmission), PLB rehash, a policy 1 negative test,
a flowlabel leak regression test, two dst rebuild consistency
tests (normal and syncookie) verifying that natural route
invalidation does not cause unintended path changes, and a
syncookie server path consistency test verifying that the SYN-ACK
and post-cookie ACKs use the same ECMP nexthop.

Changes since v12: https://lore.kernel.org/netdev/20260604212246.265079-1-ntspring@meta.com/
Patch 1:
- Factor the repeated policy-0 IPv6 mp_hash assignment into a shared
  ip6_ecmp_set_mp_hash() helper (Paolo Abeni)
- Replace the open-coded txhash reroll + dst reset at the three rehash
  sites with a __sk_rethink_txhash_reset_dst() helper, kept separate
  from sk_rethink_txhash() so dst_negative_advice()'s dst op still runs
  (Paolo Abeni)
Patch 2:
- Check the first rehash attempt's exit status directly instead of via
  $? (shellcheck SC2181), and drop the redundant fail_reason capture on
  the tolerated first attempt (Paolo Abeni)
- Redirect the remaining slowwait stdout to /dev/null so loopy_wait's
  counter output cannot leak into the captured failure message
  (Sashiko AI review)

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
 include/net/ipv6.h                         |   11 +
 include/net/sock.h                         |   14 +
 include/net/tcp.h                          |   20 +-
 net/ipv4/syncookies.c                      |   11 +-
 net/ipv4/tcp_input.c                       |   18 +-
 net/ipv4/tcp_plb.c                         |    2 +-
 net/ipv4/tcp_timer.c                       |    2 +-
 net/ipv6/af_inet6.c                        |    2 +
 net/ipv6/inet6_connection_sock.c           |    5 +
 net/ipv6/syncookies.c                      |    2 +
 net/ipv6/tcp_ipv6.c                        |   19 +-
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    2 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1112 ++++++++++++++++++++
 15 files changed, 1211 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

-- 
2.53.0-Meta

