Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF490340A6A
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259401; cv=none; b=X9OmFJsVjPcKq5t01Ev3mnvn4Jq3H0ofP+hHO01R9p0HGvd3uHT4MKGY4VpXaHRG2wsixvrKVHuvohKLwzEy2IRC5ldxRAQmehK/C6YQ9FDBCNmAwNtvXEZXLpPs0YC3FVJu1C5eT4K/VFuUhbhZ+qN6PTaGqUL6bHAB4uqYAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259401; c=relaxed/simple;
	bh=a6/oTG7zh88ZwO2LZ8qCU2LT63AJQsTtb0qVukG+Brs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY7Z3/XrYHh6h/FJfxbClkuqN2wM7xoQzc/PJtgZaH50nDOFPEGaOFPpPQD843ZCz7KyaVKlOytsZCH0xCalWDZnjFqkEpkMxIuTJDGxBqeGuMnKXvQVajxbCDjcmfCczPenTwak6gbttOjByBH+gWlWerteJ04AgQV8rxqOQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sWf4v4ZS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sWf4v4ZS"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64JE3i3G1382447
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 23:43:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=XDTSLel
	0yuSmWLRK6G+pOiyA0mWgCnSBYp3ZH3fF7Do=; b=sWf4v4ZSxbKqCamhn8ZiB0+
	557we87iXWkgan4FJwpRn3dsAomcCL3pyd/8+iNE1uK3z0/M5TPOk1t9vEG9dx7F
	/aH4ogz0pR8M2kd6E3xshcQtwA73fJ7X3Jq+XPBv0rUghLs3waXDj6iQdwPIOKeK
	W13j/CKg0UsthpiUXrvj//fAwj4ytUyU6MJG48GqltYOAPV6Bdv0NEdTi88MVtAW
	QCXp22kb8eBRGh96wWaNNLTxNRY6qt4eVUJgMF54qDItWKy6biVxFHgWlWcjQdy7
	ehvj/aML0BvyXz+YdUiSc8/kEgQFl5q7KDZU7L+RguOs4LketBx3lqR9/00PWHQ=
	=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by m0001303.ppops.net (PPS) with ESMTPS id 4e8s9rnhu8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 23:43:17 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6967b799acdso10629996eaf.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 23:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259397; x=1779864197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XDTSLel0yuSmWLRK6G+pOiyA0mWgCnSBYp3ZH3fF7Do=;
        b=YjUDB8rxjviLYPkdodDW1Cr0FG+HqZG++GZ/mJStzRTK6jJsdWfOfxILOlXVqhDCjm
         OZZ1WINxy5CtyM/p3ecNoGK/FXwzgzfI/qL8IFulS+CQmfPaHxOZOGKrcIIOwBrkB3ph
         BG+Oix6rbqRpS8stvCpyZ99YUSO0ht0KzK4bXRr21jv84thuEufNwCphyYAmsKp6+Q0Y
         s8X+XjKTkMCO/bmf7eYwyTdb6q660lwuacSrw794wY+GpP8CT+9A0shJgIyAfOKlGofC
         8SW5xURfWdVTaRpWySa6rIK/G76+NlbGbpOvSpmf8AMaC2MFzOqQR3Nr2Zb828jKET0s
         MV5w==
X-Forwarded-Encrypted: i=1; AFNElJ8R1Z+zIklWf62WMoDSXDDLY5SGAqwH47pBJd9qxf88pYi8+Xs+BNbgklVuB6i7HMpVpS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Kyksp2PZIVj5GDkEX2ZQHE3Qw53dQW2Ec+mII809zrT+xViB
	E+v4YHazM+j01CMxholjg7muplzBkZTiMpsar824CmXCR9uAop16FDsyOEbK+LD8PHRF5sAQ1x8
	9DSazNmAPKq59t3n8ryfF1vOGTxQFUtgdmkqNWAHh/FlKvCne/FA=
X-Gm-Gg: Acq92OHyK96u0cUyJNBht+5kGAF9lBFEdBts8H7SUQDDsxysGBH1PD3srsEU1tLbIQG
	R0tEM37gJnm/OSxOJYUBTJaRA/BKGFPk5C2/o5f3czn+TrzlfFcQd8PIUWPoq8/j2ZQAC7RS4bF
	C7Hdc+CYv0IlG/hMf3zNChFy3elPyt60Fa32Sgg4l4fH5M6fvUSwz8CN104l6lVHD3XoJI7Xk2w
	TP2fcCLK4ZFE2zdyR1XqaPtBw4H5Lgaxb/cSfUPYZU+4+bZ7zigyAHNuRgXlLbj81JzMKSx8t5E
	ZcrVqIZs8lyE9qWOnjYG/GXx89MSRQy+ysKp1UIWG/LXCfeCObNsxNdvm4uyoUiZy1tdhMjsE+L
	ZQfsFoznxcSZFiQhzEA==
X-Received: by 2002:a4a:e90b:0:b0:696:806e:fd6 with SMTP id 006d021491bc7-69c9437fcc5mr13184740eaf.40.1779259396638;
        Tue, 19 May 2026 23:43:16 -0700 (PDT)
X-Received: by 2002:a4a:e90b:0:b0:696:806e:fd6 with SMTP id 006d021491bc7-69c9437fcc5mr13184723eaf.40.1779259396154;
        Tue, 19 May 2026 23:43:16 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d048b3c51sm8624333eaf.11.2026.05.19.23.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:43:14 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v7 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue, 19 May 2026 23:43:09 -0700
Message-ID: <20260520064310.4154268-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520064310.4154268-1-ntspring@meta.com>
References: <20260520064310.4154268-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MiBTYWx0ZWRfX9E6g7ye3aHBE
 V/JoNIi70oUfKi0A6M1LPK4/1dVBQj+TOVa0HgDo1VzsUo4D2MvfhfyNC9NyH04jXt7r5N2e+yL
 mWNp5OUwF5Megg8Y38HFVDwvg9C7x/BGf1KZWbXgKJtmLk761VcYRuAwhVgFAxO4LS4fkdNNwSO
 jhFstbbkIV9/2l+jRR5WRO+9UnRrUHAWO29JbdBpc5WjT+QH8Lh6wk1RkYvQ4plQxvSzJS1XKka
 RFcIkfVV3yEdjrkFfkCIhNpxhAEaAcmMIqYS/YSyl79NyXHq3NYrc1LkAHJ8Vx6YabYlT8Frnsz
 uPKI40CRRyHiEUmEXfKXtYPB3exFA4EENYmy6oECgoTbSi6rX45pVk6Tq6nlHrEe0AoFNEpEnmW
 ZiXcxnqhFOaAss3nKi2flhGbAI/1pNsHMOCHGc4R48SYMPoznk2TKyYpSL/5r6JvMVvp856vri+
 HomnaN11BOjhTvRTgjw==
X-Proofpoint-GUID: lbYRQcUaD1Fb-BHpwwc0qizwiZcUAuuo
X-Authority-Analysis: v=2.4 cv=NuzhtcdJ c=1 sm=1 tr=0 ts=6a0d5805 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8 a=Qyuj5v1YA6sZnSWhSqEA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: lbYRQcUaD1Fb-BHpwwc0qizwiZcUAuuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
and spurious-retransmission events, but the cached route is reused and
the new hash is not propagated into the ECMP path selection logic.  Two
changes are needed to make rehash select a different local ECMP path:

1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
   tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
   tcp_plb_check_rehash() so the cached dst is invalidated and the
   next transmit triggers a fresh route lookup.

2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
   SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
   inet6_sk_rebuild_header(), inet6_csk_route_req(),
   inet6_csk_route_socket(), and cookie_v6_check() so
   fib6_select_path() picks a path based on the new hash.

   The mp_hash assignment is guarded by txhash != 0 so that
   non-TCP callers of inet6_csk_route_socket() (e.g., L2TP)
   fall through to the default rt6_multipath_hash() instead of
   forcing all traffic to a single ECMP path.  net_tx_rndhash()
   never returns 0, so txhash == 0 reliably indicates an
   uninitialized hash.  The expression uses (txhash >> 1) ?: 1
   so that the rare txhash == 1 still produces a valid non-zero
   mp_hash.

   This is conditioned on fib_multipath_hash_policy == 0 (L3)
   because policies 1-3 compute a deterministic hash from the
   flow keys (e.g., symmetric 5-tuple for policy 1) which must
   not be overridden by a random txhash.

   It is necessary to update mp_hash explicitly because the
   default ECMP hash derives from fl6->flowlabel via
   np->flow_label, which is not updated from sk_txhash
   (REPFLOW is off by default).  ip6_make_flowlabel() cannot
   help either, as it runs after the route lookup.

sk_set_txhash() is moved before ip6_dst_lookup_flow() in
tcp_v6_connect() so the initial ECMP path is selected by the same
txhash that subsequent route rebuilds will use.  This avoids
unintended path changes when the cached dst is naturally
invalidated (e.g., by PMTU discovery or route changes).

The dst reset is guarded by sk->sk_family == AF_INET6 since IPv4
ECMP does not currently use sk_txhash for path selection.  For
IPv4-mapped IPv6 sockets this produces a redundant dst reset on a
cold path (RTO/PLB); the subsequent IPv4 route lookup returns the
same result.

tcp_rsk(req)->txhash initialization is moved before route_req() in
tcp_conn_request() so that inet6_csk_route_req() reads a valid hash
on the initial SYN/ACK.

bpf_sk_assign_tcp_reqsk() is updated to initialize txhash via
net_tx_rndhash(), matching cookie_tcp_reqsk_alloc().  Without this,
inet6_csk_route_req() would read uninitialized slab memory from
request sockets created by BPF syncookies.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 net/core/filter.c                |  1 +
 net/ipv4/tcp_input.c             |  6 ++++--
 net/ipv4/tcp_plb.c               |  7 ++++++-
 net/ipv4/tcp_timer.c             |  4 ++++
 net/ipv6/af_inet6.c              |  3 +++
 net/ipv6/inet6_connection_sock.c |  7 +++++++
 net/ipv6/syncookies.c            |  4 ++++
 net/ipv6/tcp_ipv6.c              | 13 +++++++++++--
 8 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80a3b702a2d4..7fea9ad881e7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12301,6 +12301,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 
 	treq->req_usec_ts = !!attrs->usec_ts_ok;
 	treq->ts_off = tsoff;
+	treq->txhash = net_tx_rndhash();
 
 	skb_orphan(skb);
 	skb->sk = req_to_sk(req);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7995a89bafc9..8f602a665b71 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5020,8 +5020,10 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
 	    skb->protocol == htons(ETH_P_IPV6) &&
 	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
 	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
-	    sk_rethink_txhash(sk))
+	    sk_rethink_txhash(sk)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
+		__sk_dst_reset(sk);
+	}
 
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
@@ -7636,6 +7638,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_rsk(req)->af_specific = af_ops;
 	tcp_rsk(req)->ts_off = 0;
 	tcp_rsk(req)->req_usec_ts = false;
+	tcp_rsk(req)->txhash = net_tx_rndhash();
 #if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp = 0;
 #endif
@@ -7717,7 +7720,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
-	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	tcp_openreq_init_rwin(req, sk, dst);
 	sk_rx_queue_set(req_to_sk(req), skb);
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index c11a0cd3f8fe..accdd83dfc3d 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -78,7 +78,12 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 	if (plb->pause_until)
 		return;
 
-	sk_rethink_txhash(sk);
+	if (sk_rethink_txhash(sk)) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+#endif
+	}
 	plb->consec_cong_rounds = 0;
 	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..24c1c19eda6e 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -300,6 +300,10 @@ static int tcp_write_timeout(struct sock *sk)
 	if (sk_rethink_txhash(sk)) {
 		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+#endif
 	}
 
 	return 0;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..7a2b1de7487c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
+
 	rcu_read_lock();
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..389d798177b6 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,10 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 &&
+	    tcp_rsk(req)->txhash)
+		fl6->mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +74,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c..70759cd64b34 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -245,6 +245,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
+		if (ip6_multipath_hash_policy(net) == 0 &&
+		    tcp_rsk(req)->txhash)
+			fl6.mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst)) {
 			SKB_DR_SET(reason, IP_OUTNOROUTES);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..ecdc8f84d203 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -258,6 +258,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 		saddr = &sk->sk_v6_rcv_saddr;
 
+	sk_set_txhash(sk);
+
 	fl6->flowi6_proto = IPPROTO_TCP;
 	fl6->daddr = sk->sk_v6_daddr;
 	fl6->saddr = saddr ? *saddr : np->saddr;
@@ -275,6 +277,15 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	/* Non-zero mp_hash bypasses rt6_multipath_hash() in
+	 * fib6_select_path(), letting txhash control ECMP path
+	 * selection so that sk_rethink_txhash() rehashes onto a
+	 * different path.  Policies 1-3 derive a deterministic
+	 * hash from the flow keys and must not be overridden.
+	 */
+	if (ip6_multipath_hash_policy(net) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
+
 	dst = ip6_dst_lookup_flow(net, sk, fl6, final_p);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
@@ -313,8 +324,6 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (err)
 		goto late_failure;
 
-	sk_set_txhash(sk);
-
 	if (likely(!tp->repair)) {
 		union tcp_seq_and_ts_off st;
 
-- 
2.53.0-Meta

