Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEB3F58C2
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070509; cv=none; b=gNeHkRPNDO0P3LQfV28E6lLwZVNpEot89ejd3/KGjnbvoS4ynTLjp71E/xURRoPuyCFJtOOmZDqBy6xeRkCjG5yiiZ2VdyJtVPdN6P4qRQzcWEcM7/xoA2a9mHOjIBMX5MIEEcqQqyTu/y+XKkNgDmc/n8oOEfCnkv8iyVE3WfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070509; c=relaxed/simple;
	bh=adrItgAPIjVXwvCxZZRRDlDU3jmsl1e7aqyrg2cf7b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/syidlopPX40UmM/GhKNK4GodT5KplKDbZWGE8ddwXFTc+zQR4rNkB/vi66DMZu1puKzQ2iaRKxhxix0MQb+AMDSGknhqpRj1yiI/TWnaSgphL1beEUCaIOV4PFf7GLeMqwnP3FVKPTx7PSpLY3EL1UmIMSF/nlOOHLhX4VPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CXtRqeRk; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CXtRqeRk"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64SNt50H1179093
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:01:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=H+aGJpPT+zYANWgob54sY1in/IxcwZC
	pa8NHbHrVREw=; b=CXtRqeRkkxbsy/Fa/UYLPc16qM5PNAPbO3/JWrnOoZtrUQG
	OzBm3MO/fBjslKCGfKfzxyQT3kVlMm/ed7hcOuWwBR3yFrlqrQHlHFFpsLrFsjn3
	/QHgSdgnOStQpRxkUzkbk49YKfrCzzIkktnIxseY7BjGFxy+IbSbxzMf86IA8Eps
	qJBZtDHBmLGUGHfKUPR1TenQRM6ffgUX4y4h6WgtszLjsNNara31uSOR0nQ4PbFP
	evTzkVac0bnK9AsrekXR4u+Jpd+XvTRi3F3ruI7mAa0xcsJzClsjqOfRrI+/lhO2
	dBn/kFevJNN9ny5MK2Rg8emYptzhHHitHcqGRTA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ee7xg54hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:01:45 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4855ad52165so11351962b6e.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780070505; x=1780675305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+aGJpPT+zYANWgob54sY1in/IxcwZCpa8NHbHrVREw=;
        b=N7ofmA31bApjiznHhBkamo8OYerIL/f1Y+GyRuGgS5jNeqQV51S6iLMuE9epe2XpPH
         Hq+70HiWoPrw3KANQeFf8pKmER5GO2F1GC/0+FYFnXs17sIIS0yB35EILlpadeWfmDA+
         B+7ZrD3cYNKajdxlTWMEPxauctA+tzcKXua8/+0oFnduficlzKBiri4745jcSi6pUNso
         8Ce4L7gTUnKIJBVtTBxIROrhwbx3RqJxp9IcPO3DWbezM+6I8kyJnT1EbGw34X4WymrL
         4BKXBA2OXgoiE/2j+usqEqDA6fD7IayLqn/8t386hJuaj1LvE0tAu3vRhmvtdI6la9LI
         LpaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9de/lexIclbWM5c5DXnyzOe1mphlGIj/zD3mE72uVLRXcqk77sQ3gVkbaIuhQPMoIocc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtILHqUPVnsJn7O2UxOpen69EYbMNMQhJu4u9Wc2P7HU3z/GbO
	DYUTNCEZQqkC5vHkxHPI4R5g0TfRUI+A8zTVc3rCE9PH8iON2DSsf8RAx0Par6YpS1/sBxj8saG
	vk4K0imCpmGt+rOPuHPEvg3LLb5WiOeAlobz89A3PignNWbQQeHU=
X-Gm-Gg: Acq92OG9vcrq7t83MbFEeyb0OChbOakKS8AEyDbhMaysUraK68/iO194qj1Qpshh/Sd
	+t7n444o4czsrdM9uBzGB2Z6W7EbHdwKHIHV7CHxCPUq5NDo58poxrwgG1qLi4XR/3pgi0iJpVN
	vY0qggngTjOd2TE4V4I4jwt29pELKodp5lBPGBMb5fh6B9paH4P1WZdoz/e0jzGyizzk3dKKc+4
	Uj1cOeV2MS5WJW/gCozl17BSIS/eQqmgph3bhQPfrtG3KaydpitHHZHPnBkVdEnvepGuOMUpS02
	9xHHAMJxuSXOysFaGaXpvIbw5UUqD9VlI3LKCiIjVaUYLl5OqZCiC/ZU1I0Kd53BBbZdiwB8yBd
	PEFy+VrGxYWSITnnJCfyi
X-Received: by 2002:a05:6808:1b88:b0:485:1174:4582 with SMTP id 5614622812f47-485fb298237mr34721b6e.13.1780070502476;
        Fri, 29 May 2026 09:01:42 -0700 (PDT)
X-Received: by 2002:a05:6808:1b88:b0:485:1174:4582 with SMTP id 5614622812f47-485fb298237mr34052b6e.13.1780070498156;
        Fri, 29 May 2026 09:01:38 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485edbc33a1sm870480b6e.4.2026.05.29.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:01:37 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v10 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Fri, 29 May 2026 09:01:34 -0700
Message-ID: <20260529160136.1010064-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vO_HljBX_xDOmn_GHpXUPhKvD92cTFyE
X-Authority-Analysis: v=2.4 cv=demwG3Xe c=1 sm=1 tr=0 ts=6a19b869 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=djp0iyAdQ3A2I_T4MNwA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: vO_HljBX_xDOmn_GHpXUPhKvD92cTFyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE2MCBTYWx0ZWRfX9ZeI9x2TicYu
 zeXCdlxDoAmFKQI0YVXT8HEg31d8p1qEkBeB2BzYvJ4koxp/vFSNicR49rfaXjTX1a1oLQHBqZs
 foyaJmItFUCRyRZle1MJMGr+wDzeCcz6wSwgfkbxHSGFnh6Y+GM4KkNrKSiCjj6YEdHcpdCzFRr
 UxeqtkWrLhbJ4ohY19ZZfTnANAnrVJlA26Nj6joPYDQAp/7yRolj+Xeu6iCrNl2/9w8iYJUZ0IS
 B6SAMFE5ICPxydI6CzcK7LvQyzmme3GQMul0BgTQ8u6biCgrBoxdiwcms4MDZ7MIM7BHYoDH9J0
 2zbHaFRnZKrTcMR6FopiMpJKYY3F0Z2RmMu7kD0dT89Maswq2abZBwBYhKweaMNX3zFhW48eZSH
 40Io7pZHlDm4/NmBZ58hKVSxCquOonq90R1CTxGTmuDAwEi2AD6Q6VILxDdw8GJVGSfKpEv0cDx
 MTKq8OlkreyLoeZWwRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01

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

 include/net/tcp.h                          |   17 -
 net/core/filter.c                          |    1 +
 net/ipv4/syncookies.c                      |    8 +-
 net/ipv4/tcp_input.c                       |   18 +-
 net/ipv4/tcp_plb.c                         |    5 +-
 net/ipv4/tcp_timer.c                       |    2 +
 net/ipv6/af_inet6.c                        |    3 +
 net/ipv6/inet6_connection_sock.c           |    8 +
 net/ipv6/syncookies.c                      |    4 +
 net/ipv6/tcp_ipv6.c                        |   13 +-
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1067 ++++++++++++++++++++
 13 files changed, 1123 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

--
2.53.0-Meta

