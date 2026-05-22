Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99725372045
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487059; cv=none; b=a4aKaemsVtGpnxh07H9hdpn3ylcwhU56fcZTlf57MPTnvryCjBA2YCJO2/Xlpcerkk+PNNPk8I/kJ5bnwM0F2Yon4ntP22aPptII2APFVtMR8kLOsVsvbuvv57A8XPtaieLOZcfVCb/i2WKXFXIXNtyRzf5yBbCgKlon4a/ZxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487059; c=relaxed/simple;
	bh=juil23xToy9CQ8hrlNcwOM0/VzXLtL5uef1zMIkRi/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSnUARac+TAikyzV/k6Gt/JXAc/cjND7VzGTpWdpm/ytcZtTJ8KjPJchks1G0BklTQ2H5mS+MRqA4c+AahNOM5VH9WPRxz+WSNimacMUOva7qqqPKIyRGbAcOmTWBdXahxdRX+jQbjqI4ntWc2igYxHA209Itl9BUqWB/00HPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FTEQ8CZr; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FTEQ8CZr"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MKNvU33209767
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 14:57:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=WsnLCyDet0IE96jpLaIya/EHaqC1Px4
	MftDg7/35Ods=; b=FTEQ8CZr/b9qCpAOtn3KwkTAeF94NaXvfPHTHdk4nP4opY6
	uqItIZtIISQTeClTnHMbdq7DyaoyjIET/0YBZdEslniMy3fWE1hjl3/4gVWBepCM
	cd1xRZikNg/vAEoGd6SH3C1GEQCQkSCpEH7MsdK8iGBxSOcXnY6YCT3Y7BC4KdcS
	51OhpY9Z/knNWIJ0gxpcNLtx3cgjBPs/qviJdMg6w/buqQt76NvVaTZJh7KZ2gSm
	VYUEMP9Iseec+DYzdewXFZnAb6dh3riPbUTzlQqZSKm39yLMpT4UuMVaIaGbFCYL
	HKAv3Zp+1TnCrizUmowANNfNCQ4u+imONKNbwbQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eaag16txd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 14:57:36 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-69d7fee2b39so961196eaf.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 14:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487056; x=1780091856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsnLCyDet0IE96jpLaIya/EHaqC1Px4MftDg7/35Ods=;
        b=pUfBqaZEvycIPqBA2AsRXzlFA0BBmwndISh3gufjd2voks6y94Z9Lww7KaJFPR7Gpa
         wN6HpIqgKO6W693nLVsWK3a51AWFwF+huIFXE/wl56FWHml7R1meUnJlOH5a0FJp2GuJ
         inAKBsLVo1lBxAcBdgsAr8ZEzha5EekzgTu4Q8mK1O/2bn5wkKBaYtZAWOixbZtmdZBD
         FiMrUSq8G+X4n1UOPO/yrHn3g9J1G0cvZL7Mfe7oVqwjeYS35TrLyh0N2XfpT9uEsk9D
         ki/tvlkHSLUN4iQaajmv7f4Q1i9vuxbiYhC4g17rANu2MmMWkUygqZc/osThYoJsLr7t
         HoCw==
X-Forwarded-Encrypted: i=1; AFNElJ8qX9RUMlNAPTMSKQJaCUkH+oLpP27XHgys1L/W79kYGxzt0m4qU2+jSAUWHSW7aPPwKrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2nQajprxgJLsfEJmOvrspF9AwcqGnx9EN7cLAiUIHukEU3n+
	bWX4M9IYaDW6kl5CnwBAf1/+Hoc52kw0OIq8ah+JXU5PXcW1OQL4XKY81I55ICG/8c8LRIIhD8c
	0HBkZyC/tvvwhh/fTmde/ozbhvkTm/DJCmmGvMcIqTVa4OyvdW00=
X-Gm-Gg: Acq92OGGzjSkwi32lfpuYAs01ZqVGZ83LRR/Q9TG/IugRVZX6BPHxhyhCXEDdCTU2aT
	ihdHSyrgwEIJnRIkjpybmLc2MCAfI+NBwhJNaMLe0TeG5k4SrXEiCSUrw517s5tWHlXNcwWiykf
	VH1A7lfCkNUXoJQUt3sQ+uJFGp+X97gYsEdxKM68hOihdZ6PThDC+nOhU4gsy4nckES4f6kB7jj
	WwU6r2F/A6WePYQYq0DMHmukrSTwE3VRd99xQSV17dNwYp0iR9uoi3WgNn/VbMrJOrx3GD/wSbJ
	BNsWpFHSKKpmAADx0QIRICRBq7bz3x59IiG7/jLSKGQrb5blbtMXv8eOzX+VLxvSio2ouKPcEZZ
	nqRAhF1i9ZA==
X-Received: by 2002:a05:6820:8c6:b0:696:8325:f7eb with SMTP id 006d021491bc7-69d7ecd0c9amr2823576eaf.45.1779487055615;
        Fri, 22 May 2026 14:57:35 -0700 (PDT)
X-Received: by 2002:a05:6820:8c6:b0:696:8325:f7eb with SMTP id 006d021491bc7-69d7ecd0c9amr2823549eaf.45.1779487054977;
        Fri, 22 May 2026 14:57:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83a4db17sm1485917eaf.9.2026.05.22.14.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:57:34 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v8 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Fri, 22 May 2026 14:57:31 -0700
Message-ID: <20260522215733.929238-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vr4Txe2n c=1 sm=1 tr=0 ts=6a10d150 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=Tm2zCBzp3FQG0QxiXacA:9 a=WZGXeFmKUf7gPmL3hEjn:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxOCBTYWx0ZWRfX1p0XrlZO7Uxn
 4GtL/0n9Pf4PvcH0G1WexnWhSWTw9D8qviIQix643/TI4TrsC8VpZ4FfSxzAXGOh7vA4GefMYqE
 6sdDp09DV9uIHcevXqyv0YJQS/8svUkoUiWNhfqVrGn5l9df42QuVu2cNX/cNQO5U4gg6Zp43l6
 IkUzKVP7UMYbIoSdbE8jOju77MiJrevdKH7wPW/gIIxtHhHx6BNVRQ8ef7jqVcg3Rd6Enm4xMW2
 AoBnhkHUlui+vlpLR106wkBIk1CSkxqOgoKOOESQGhhTzoTlNWgPlA5Xo6dLZ04faBpQUf1zitz
 80tSmrsBas/Bd/3LgMiRr7lAzbqdMtNSYNymOMFhVUwnm+QOZjfuGsxpMlNhNqSMiJaBg7DdVfO
 HDmgSPrn820y+J8jsErNVKldt0OlIbEWzVrQkHWjzav3bMzGIb5tV10RP5zICcthL3dPHKdV7f9
 JY08oPg0ye9YCDJlQfQ==
X-Proofpoint-GUID: bf8DnSe89PfiRrtirLQKLXflpY_5BmpK
X-Proofpoint-ORIG-GUID: bf8DnSe89PfiRrtirLQKLXflpY_5BmpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01

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

 net/core/filter.c                          |   1 +
 net/ipv4/tcp_input.c                       |   6 +-
 net/ipv4/tcp_plb.c                         |   5 +-
 net/ipv4/tcp_timer.c                       |   2 +
 net/ipv6/af_inet6.c                        |   3 +
 net/ipv6/inet6_connection_sock.c           |   7 +
 net/ipv6/syncookies.c                      |   4 +
 net/ipv6/tcp_ipv6.c                        |  13 +-
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 952 +++++++++++++++++++++
 11 files changed, 990 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

--
2.53.0-Meta

