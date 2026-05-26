Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC13AA1A7
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827649; cv=none; b=J9eQZiB6gQ0AZSYwJsXsD6ZvTfFVR7Df6kOGKfP0c1laY/dLdAk58ZOMq7dWFtuGX2XkLJ5Kr7qcAEzrYT4h9y1PPehKw734maF2PmNZ4RjSQiDgpTWnaAPDFqS8hrnE1g1T0Jug5/C11RQ1n2QZyc+rac9n7ME5cjMA5G2Fir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827649; c=relaxed/simple;
	bh=vTBSQgZ8hCwsfb4y9WyJZ2M75y/JklCLtRE+PpCTRjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+CeEw28gIUB+O+M6k2xOBuZopmbdFwxOrcH49tZ7x8Xs+Cy5MKGiPOHjFyar1DclVWL62hcVThOQiOyT5oFUm6XlMMpK5qyg77mLXi8UK/xVyde9cHknez2hPaKkWLvq9xoam76HHk0PE43BrsE86g3s4oiGujBtQCLOAv7Z6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cevmrcb3; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cevmrcb3"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QIY3Kf1759304
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=e7b3B+5WN+mJZtHSXrSE3pwUAVi+r+A
	lhwStrrNpJM4=; b=cevmrcb3M/bmlWddoLYRF3z4Lki6RiC2Cc0e5i3fXM/6MgF
	TL7lJo2fn2oe5+vnEhmbQ6wmj/RspkaDDqJIs3DKAMO5ssfldV14t6xppdpDZALE
	rIZNaeC7lVNyoJyzSwIvmyXj6a0xM7hEDdPMEo1lRwGBQZVD8iRUqE9U41iyQkDv
	riaC2bc0ygGoRLRB07eGXlbb2OhYdMD1wvDZOL88Eo+tE4lPChn04UX80OX2W5X7
	8R28kr/SmlQRzQGzX/IwPr63yLuos364jCYLnMLHKFc3OqSN1dkgNt0XcSme3ooL
	3vYDnfZSe7Sp+prGKK08QbG2zOopVpXzo5GKDBg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ebbhggfuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:34:06 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69d9197c60bso4445165eaf.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827646; x=1780432446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7b3B+5WN+mJZtHSXrSE3pwUAVi+r+AlhwStrrNpJM4=;
        b=rW12aaWj7F2rRxK6vBqfuRJIFu1UyrSJwPYMRebkcQJqEGl25VpdiC4yg7d9DYEbMw
         PTTkkllVL72c4ntEMk6cY88OKtzV0T7vDzMW0bPNs/QlW7XsFAu+p/ESanuOue6FcV9C
         QMqHlyOZyPjjVmO/1fY/P8soJgkc89/Z4P2qMeFWh+9sJ9DnuF7wHUGpvQ+JueSJa2NW
         MpGidHdFnHzWwujbmpDycDIf1pATipagZG936iUDsodzyGUZ2NRTcecEjvagYy2FuFvh
         z0ZktQ9Io8QWlABxGWR07QL2pcscaY5XAWs3t6l/HXJm1qvSebi14TDRkbD9VxmCNrtH
         KIzA==
X-Forwarded-Encrypted: i=1; AFNElJ/AeQyyDN50e1H/8m9YjjJFXrz2lWtDTcBPUDZlh3z8eoP3uF66ITVX71Ot1+a7/wS3e/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwS0TElSRIloRS0sYMSNWxcTzEBLjWq+nugI8J+ZA3yRBisuiR
	2yPK/0uXIdHllym0sGbOX6+AE4+MOezoXT01d9uSPsp3zAQ6gLpd3na0PHZXO4X2pUba1/2p7OF
	nog5ogsy7fZpvX32hbTcYIUil2Gv1WeGr9Azx94mA2sG0EJuwLa0=
X-Gm-Gg: Acq92OG3dYqgQ4/e3nr1shiCU2XVES4ulbs2jd5uWvDrcGGDSoaAiuQA1eQ0ymQJx9q
	zP6k0hIEmbqjJHswH35gfXkGvwXqvL8Tsz3HiWu9otZUYcR7XJWzRlTzc+d3bmzom1O3xtblgir
	tIGaug6EwQewOW/Qkv1UBoOL1Vkr2qbHhl0v5BsHWwnVIBRUTCX6kegnOqJgMUXzFYVwBxG1nw0
	6F26HB5xZttpuXRyJWGsZNEa6U94OcvHeaFIk59JTB3i9HC+hdLy5OT5AduGkhGsmSAET8LRzzF
	FdnPlsSye3xU3agtJXgifYYbXPFAZdk+nA4rohZ59LcfbMzND62H0ATm9jAN4FStkegX0MaTk+T
	9M9uj4HOvmFw=
X-Received: by 2002:a4a:e90c:0:b0:69d:82e6:69b7 with SMTP id 006d021491bc7-69d82e671b3mr9975520eaf.51.1779827645667;
        Tue, 26 May 2026 13:34:05 -0700 (PDT)
X-Received: by 2002:a4a:e90c:0:b0:69d:82e6:69b7 with SMTP id 006d021491bc7-69d82e671b3mr9975494eaf.51.1779827645190;
        Tue, 26 May 2026 13:34:05 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63a15569sm14264392fac.16.2026.05.26.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:34:04 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v9 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue, 26 May 2026 13:34:01 -0700
Message-ID: <20260526203403.3517607-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Bva4AiV46AfOcimM-By_7__u--BqlIhB
X-Proofpoint-ORIG-GUID: Bva4AiV46AfOcimM-By_7__u--BqlIhB
X-Authority-Analysis: v=2.4 cv=K8MS2SWI c=1 sm=1 tr=0 ts=6a1603be cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=djp0iyAdQ3A2I_T4MNwA:9 a=rBiNkAWo9uy_4UTK5NWh:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4MiBTYWx0ZWRfX9Y845taDzTNB
 M26orhiaYqmgTe5WrLo1p9l/8SclAyHzy//wG4ts9hS5FKJ6nYIXcsJFysEKB/pywaOx+JmhdaQ
 wV40XQ01KQ9TV0QsRn1dK+WSAP17/pWNj6oisgQUB4YjwmjELLAg94oXcmgJOm1AIdoQzxJ8iFY
 zR9JkVANobF+QtlERW7fgMEeizFOq7uB5sh+qLg+BOJNhkzxlwtTeMRt2rXo/7D2iU1xm/mPaxs
 jTVZ6ujyYb2YxGFnQN1GOcxayFF64ciHhc6zVSfdpWW9VTjR78i1bHPKu1YWyN2F71l1pLWuOLK
 QfGTR/dkRSIjDHSC2L3oxDvI2eUl+IBCuL6FmkpgM2d3Tkv7+stQTltdU+FvH8kVZKXcUH6R3N5
 oNrJo+1d5qFMUwmZTnUthzVIu3avgcyqtapSrZmglKtihkEGhXbVvsaCMabB5reT9fXUopBprwj
 s0S38V/0va4esLyD1Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection logic.  The cached
route is reused and fib6_select_path() is never re-invoked, so
so the connection uses the same local ECMP decision.

This series adds the two missing pieces:

1. __sk_dst_reset() alongside sk_rethink_txhash() so the cached dst
   is invalidated and the next transmit triggers a fresh route lookup.

2. fl6->mp_hash set from sk_txhash before each route lookup so
   fib6_select_path() picks a path based on the (potentially re-rolled)
   hash.  This is conditioned on fib_multipath_hash_policy == 0 (L3)
   because policies 1-3 compute a deterministic hash from the flow
   keys which must not be overridden.

Patch 1 is the kernel change; patch 2 adds selftests covering SYN
rehash, SYN/ACK rehash, midstream RTO rehash, midstream ACK rehash
(spurious retransmission), PLB rehash, a policy 1 negative test,
a flowlabel leak regression test, two dst rebuild consistency
tests (normal and syncookie) verifying that natural route
invalidation does not cause unintended path changes, and a
syncookie server path consistency test verifying that the SYN-ACK
and post-cookie ACKs use the same ECMP nexthop.

I'd like guidance on whether to use the ISN as txhash when using
syncookies; it keeps the SYN-ACK and subsequent data path consistent,
but one could argue that this consistency doesn't matter because no
reordering is possible.

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

 net/core/filter.c                          |    1 +
 net/ipv4/syncookies.c                      |    8 +-
 net/ipv4/tcp_input.c                       |   20 +-
 net/ipv4/tcp_plb.c                         |    5 +-
 net/ipv4/tcp_timer.c                       |    2 +
 net/ipv6/af_inet6.c                        |    3 +
 net/ipv6/inet6_connection_sock.c           |    8 +
 net/ipv6/syncookies.c                      |    4 +
 net/ipv6/tcp_ipv6.c                        |   13 +-
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1050 ++++++++++++++++++++
 12 files changed, 1104 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

--
2.53.0-Meta

