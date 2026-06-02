Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B83812F7
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424078; cv=none; b=okp/Qa/hCEy0ev05NyPRK+e1N9SRWpvIrAew+vKJd+ao/4rhl7Ah0UdmFPRcXb5zFNAe74q+M7qomcUbE5O2qFtaaqJ9OIL+s+hjG78hBaYLcPZbfj4pssoHF8UKd37pF4KPGDNVTlQn+eByVlg8B7aAA390anGvZsV+IJI/Cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424078; c=relaxed/simple;
	bh=hh/lAbwHBhS1YSawkm/umA1sOZR28ueDNMwsw05hfUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMgBYW6j0d+85t8u/xCMiQLZjCv7DSmq9W9QM99De2ZJXRG1sLrteFqZFbTxRu8iSZgGkbYcD14BrKV4tCJyKNsrLc5wmAraFt3Zu7Ej76t0qdk7B8TqzvwKLyvYyDgvJYzgbOzV/ApNVL3tQTd7r4URI3d/CWi2RChj5GcFXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lC62NuoY; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lC62NuoY"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652FnjWx2251358
	for <bpf@vger.kernel.org>; Tue, 2 Jun 2026 11:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=3gJqr66erQ11XLwdrsV1w+OwfLmMn1H
	JYnol7DS7514=; b=lC62NuoYcjsTPnJ8gdyTPGuvgf1NYQs8NxD0vObQSzz7oJj
	ZYkTNRnSRaCnititJJFPKsGscoGi/qxUzO8FMP/3YLQuGLA1O9+j03TrW0YY4hAy
	ZvEG8Eb0sEFVR/yMyert6yiD6bXJooJtFjK4SHyiIsGMhJtXPXY2a5YT3JB+8pO9
	/vW7aprhmuvfLzfyS52YNvhaIzgfMLfhxhZJqk67traMghP+6ffEurVZiVOtz1VK
	EsKkGOYeb4QIZFwCuWceNcwCGP2YuV0licWU43Mvx6eKMdyEr7ob1f9p41hiaboW
	M/H5J/cSleo9T2Z50vRvLV2xY3/O0F6/6tSYjPg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej25ms28r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 11:14:31 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4856ecace68so8593039b6e.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 11:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424071; x=1781028871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gJqr66erQ11XLwdrsV1w+OwfLmMn1HJYnol7DS7514=;
        b=gg1TrAzSkoRjej3GLStW7yKbjBWiPAeHiGEficqtjxhn1JYzPUKrxzE+1y1DYMEiOe
         ycIX82rn2A10XhkaJZMAl8alEsRWw0lqiobqnRbxlI0+ufZQYhcutXSm5l3FPQVORU0b
         Ph1HfJ6pck1ELYOU963daG70/8WTI9MsyYYka2mSBmjZe90fTU96k9GbHQLeXz7/73LR
         ZfxzTRxHZzVJmaMwCXrv8p9S2/xlhZIV/vJ0ZWQ+lWnM8UQPTF2yXsjNUg5gLkFrkl9f
         Ln5dhkuKzVUsiPAHuerwyheBL66EYPnwY+Osj/nDCR9J/NJkLXHMIPyl1jSMZhmCRlkv
         KxWg==
X-Forwarded-Encrypted: i=1; AFNElJ8J6VsHo4zqMOGXXuhWitVTgudctVNPCQCWI/Yz3ByENv1ttNxZkY3SfnUZf3kcL/qNDSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIl1qXAInrFwy7e/xfNhgYlmXyptqL04O0WDfZ0Pmf8Dy/uwKZ
	k84v6MAcDc/08dCcdpp8PF5v21IX9npqlVfa2fBsOf2xKEDD249Wxyg75o+G39XPvx1IcRsatxc
	qkEPjBkHkbUpPM5tTx/PyxSWPwH5LiixKABgfumF2xqZ6LP84Muc=
X-Gm-Gg: Acq92OEYEFb8WW/Q/5fysmoyrejfu7ZtmJ4z+3ph2OAiIdHSKWC9jXExcWLERxNRxWX
	tr5lqh2rDTuwz63zAVmM7lw7+agUTGabxpXdYIIH6VB+rNLowD6At+hIq8ZIcpyXUXPnFcaoNYE
	7zYxMsRckOTq08+VZdd3kiZPmjD/PxXgP56JkJzlGnoqi3+n1TjVW2DxAL4mflg9Tm7fMuEUaIA
	ckyOx+zz6jI91SIkG0EJamAN2Z2zxXLf9rCbr5N7j0BYUJRudXYc7gnQTiVKhsHIRGrCDOrZHXK
	ow5LGEU2JrLGKzGYxvVFP6JjqEtLW2cMjp9zrR9hZhnaEJhFE4YKovBM3QL60CKFKgiTFecCew5
	87V6HHzPixFmVqwNvDgrX5g==
X-Received: by 2002:a05:6808:80b3:b0:47c:3733:255a with SMTP id 5614622812f47-48656ec7877mr630077b6e.16.1780424070752;
        Tue, 02 Jun 2026 11:14:30 -0700 (PDT)
X-Received: by 2002:a05:6808:80b3:b0:47c:3733:255a with SMTP id 5614622812f47-48656ec7877mr630046b6e.16.1780424070204;
        Tue, 02 Jun 2026 11:14:30 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e14b9sm51787a34.13.2026.06.02.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:14:29 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v11 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue,  2 Jun 2026 11:14:26 -0700
Message-ID: <20260602181428.2318919-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3NiBTYWx0ZWRfXwVtm1pfxNWju
 JofawhhvEmibHBWy0Jdh5KGMabgA5mLNel+wioP3BcUVMZENA46369XhorNCoXHAD6J+bpN+Eo5
 rE+8EakxNpu+xsovP/olPGChFKW7DGa/4daRlKrc6N1Nrr1A5uqwnY/rHT1+8YQCHS6nTnFgoYK
 m4RtLdolkEOVT6p/NJT+x4tpfmpLZTXngYxZYIHo+1rbKlmk3DQWMtpKDdMHbhfigCNBXeMUwSj
 3B6HjH48mXHTXIIGhpvJjyhij9zv3mtAy1PTEbQ1zS9fJAocU8jabADOKx9s4y4lBQc75bFqoAv
 y63oauJm71HkT6zcjbonRJb9dB5AWmSxPhtKw6l6LzU6ZSGeF/1LXPwp+dnTuaI9Vxs33+m8KdT
 F+xycoQ95+FD8inqQ6LqxRc9SPcjZ8W292giO3Ma3t0U+GKLH0RlEd/QlbCg+Y9kXl+/tohYeuc
 EE/yuUTRThrBqzA3w3Q==
X-Authority-Analysis: v=2.4 cv=c/Obhx9l c=1 sm=1 tr=0 ts=6a1f1d87 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=eOgIIEJ8Q39cyHai93oA:9 a=_Y9Zt4tPzoBS9L09Snn2:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: EIhptX-gf3DKSB-p5Vrfw3U5iAoxbiM6
X-Proofpoint-ORIG-GUID: EIhptX-gf3DKSB-p5Vrfw3U5iAoxbiM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01

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
  uninitialized slab memory in inet6_csk_route_req()
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

 Documentation/networking/ip-sysctl.rst     |    5 +-
 include/net/tcp.h                          |   20 +-
 net/core/filter.c                          |    1 +
 net/ipv4/syncookies.c                      |   11 +-
 net/ipv4/tcp_input.c                       |   15 +-
 net/ipv4/tcp_plb.c                         |    5 +-
 net/ipv4/tcp_timer.c                       |    2 +
 net/ipv6/af_inet6.c                        |    3 +
 net/ipv6/inet6_connection_sock.c           |    8 +
 net/ipv6/syncookies.c                      |    4 +
 net/ipv6/tcp_ipv6.c                        |   13 +-
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1066 ++++++++++++++++++++
 14 files changed, 1140 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh


base-commit: c1e5127b577c6b88fa48e532616932ae978528d5
--
2.53.0-Meta

