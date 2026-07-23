Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDB34D4D6;
	Thu, 23 Jul 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842958; cv=none; b=s9WEgqS0/xMGbMXyuCoMFU0JuUoLUBha9czj8sfN7Qh8pqAhJ9eDQ1kazYEYU0yssUteGyM7ajYGurPlyJmiyufr6q51lBOhAvBcFaWYIw2t1Wa1+W9waRd38aS7ROYvQt5OoLqqFfg2mHYSaHRR/L6XcFRjrh+WEQWJzHMId5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842958; c=relaxed/simple;
	bh=8Y1UtNu54q11AGiCHnRvtMpeusV9otKE2ExphqBK9MM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DLfyvRHJJLZYiFhrrKjvmjXOBvoqHlogkDqkBW7tAMfh2xxi7sLukuyC3VH/m7W6Wprw0kdhW1kkDqheUY611tHJXT4qNy197zm/LqMoEZx0xZ2eLetGUk8IcYkTec6KjnHlEf0haYX+Qw+2MG5lYN1JOc9LMFUMw3qfc8Vq7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TZoz7OvO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TZoz7OvO"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLbZGG3966303;
	Thu, 23 Jul 2026 14:42:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=bClYz55JI4YoEPtD7v
	ZekWZmKyXf36wzY4xyuyrOxY0=; b=TZoz7OvOVtjgQEkcuBSRRNEgWuNuy4uE0C
	QLj9/cLqS5WzsRlIlxUjzbJAj27dvv24CTDSpg4gM1pfK2ZGMhfQhXA6dIWIeHa2
	ZrgiNvQOmp/mFEXynlGPdBdR1HlEeQUMzXlPZWWOdIbKu6HNe3/fJJ7kYCSQO7ne
	yjpBO+ibUth4jpgBYiWaPkH2n/0RH74IWeOxfEig3meeAhsKHM8huX3OFCWLYwc2
	GbzhAmzcbyqGgyJEF2CoxpUdIlVeuNQWPP7TbLOgsaiiayt6KasXrB8bmRN/sGw2
	B0g/Yu82nODZ5h+uyTdcWui/6BJAaP8dW6nhKZnlAWPHaTIWXijw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fjdmk88p6-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Jul 2026 14:42:29 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 23 Jul
 2026 21:42:26 +0000
From: Tejas Birajdar <tejasbirajdar@meta.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
        <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "David
 S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tejas Birajdar
	<tejasbirajdar@meta.com>
Subject: [PATCH net-next v2] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
Date: Thu, 23 Jul 2026 14:42:08 -0700
Message-ID: <20260723214208.3655474-1-tejasbirajdar@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wSzx9XMAni5hDcA-znLEdqos--3SUixB
X-Proofpoint-ORIG-GUID: wSzx9XMAni5hDcA-znLEdqos--3SUixB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIwOSBTYWx0ZWRfX02lWiVO4KPHd
 xALxxdH4qV4nVt5Z3lalREAumvyWJ43yoOlnQbaz3EgQoG7cT+SEqc9Tja7mUyvDvRSr7cJxHZf
 bKGiqBsnJUwU36geOgSOVxdqeRVY8+r8zRYKdDhW6Mxnr/i8SbLiKNT6ixGuXAKZ2Yj0RTANNut
 xowtG7NCyJKWas4PzN9jZLP3LOZ20Dfdyf+VeiHZlmqmD+OSPjN2I+BTvdO7YtPbY+g4BFlAC6t
 RfSr6i7UkJXDgIwQ3JRqvNHphMt4FwSz9EZs4xXz6m9cHAM+8AoHQCVnGi55V869I1XBCO39oGE
 B5gaCLMpCZJNu4QOwS3eQZ7oyJsvRDhykhqoQPPsJbrLtrVQKEJj2Y7YXL2Zia8bbqo77eJzP2a
 Sc8x/EtjDK98i0l/8AK80YQbbxsi0rS2hBiK1PthGp0rcjbXFUJpzOdGiXRVIcOHJrg8kGDH6xR
 GQTFDb4UepVNjv8DBiQ==
X-Authority-Analysis: v=2.4 cv=CKEamxrD c=1 sm=1 tr=0 ts=6a628ac5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8
 a=4XeK37IC55s43dnOpu4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIwOSBTYWx0ZWRfX0kfLhcrnukPQ
 pk2LXwvEWr1ih0g5DziOXV8l9v4qdcYPhElclyZK0kh7s0YjRHQXKrTvBnCddS5DknUNq6hGklh
 DQpBsx8fN9e544UKwhVJAqyDp4zEUE8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01

BPF_SOCK_OPS_RWND_INIT lets a sockops BPF program pick the initial TCP
receive window, e.g. to advertise a larger window up front in environments
where that is known to be safe. Today it is only effective for the passive
(listener) side; on the active (connect) side the value is computed and
then silently discarded.

On the passive path tcp_openreq_init_rwin() inflates full_space when the
program returns a non-zero window, so tcp_select_initial_window() can offer
it:

	else if (full_space < (u64)rcv_wnd * mss)
		full_space = min_t(u64, (u64)rcv_wnd * mss, INT_MAX);

tcp_select_initial_window() only clamps the requested window *down* to the
available space, so without inflating the space first the BPF reply can
never raise the offered window above tcp_full_space(sk).

tcp_connect_init() calls tcp_rwnd_init_bpf() but never inflates full_space,
so on connect() the requested window is clamped back to tcp_full_space(sk)
(~64KB at the default rcvbuf) and the program's value is ignored.

Inflate full_space in tcp_connect_init() as well; tp->advmss is the mss the
listener path uses (both are tcp_mss_clamp(tp, dst_metric_advmss(dst))).
Read full_space after tcp_rwnd_init_bpf() so a program that also adjusts
SO_RCVBUF is still reflected. Compute the inflated value in u64 and clamp
to INT_MAX to avoid overflow (full_space is int, rcv_wnd is u32), and
apply the same overflow fix to the existing listener-side computation.

Fixes: 13d3b1ebe287 ("bpf: Support for setting initial receive window")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Tejas Birajdar <tejasbirajdar@meta.com>
---
v2:
  - Do the inflated full_space arithmetic in u64 and clamp to INT_MAX to
    avoid overflow, and apply the same fix to the existing listener path
    in tcp_openreq_init_rwin().
  - Read full_space after tcp_rwnd_init_bpf() so a program that also raises
    SO_RCVBUF via bpf_setsockopt() is reflected in the offered window.
  - Re-ran the sockops BPF/RWND functional test and the full in-tree
    packetdrill regression suite on the revised code (details below).
v1: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbirajdar@meta.com/

Functional test: a cgroup sockops BPF program returning
skops->reply = N for BPF_SOCK_OPS_RWND_INIT was attached to the
connecting socket and driven with packetdrill on the active-open
(connect) path (advmss 1460, negotiated wscale 8). The offered window on
the first post-handshake ACK now tracks the requested value:

  req_segs   offered window (bytes)   = req_segs * advmss
  256        373760
  1024       1495040  (~1.43 MB)
  4096       5980160  (~5.7 MB)

Without an attached program the window stays at the default (~262 KB);
before this patch the requested value was discarded on connect() and the
default was advertised regardless.

Regression: the in-tree tools/testing/selftests/net/packetdrill suite
(471 test cases across ipv4/ipv6/ipv4-mapped-ipv6) was run under
virtme-ng on this commit and on its parent; both produce an identical
pass/fail set, so this patch introduces no newly failing tests.

 net/ipv4/tcp_minisocks.c | 4 ++--
 net/ipv4/tcp_output.c    | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ddc4b17a826b..f8c1123aba43 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -453,8 +453,8 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	rcv_wnd = tcp_rwnd_init_bpf((struct sock *)req);
 	if (rcv_wnd == 0)
 		rcv_wnd = dst_metric(dst, RTAX_INITRWND);
-	else if (full_space < rcv_wnd * mss)
-		full_space = rcv_wnd * mss;
+	else if (full_space < (u64)rcv_wnd * mss)
+		full_space = min_t(u64, (u64)rcv_wnd * mss, INT_MAX);
 
 	/* tcp_full_space because it is guaranteed to be the first packet */
 	tcp_select_initial_window(sk_listener, full_space,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5e30..ffa28c98c211 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4103,6 +4103,7 @@ static void tcp_connect_init(struct sock *sk)
 	const struct dst_entry *dst = __sk_dst_get(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	__u8 rcv_wscale;
+	int full_space;
 	u16 user_mss;
 	u32 rcv_wnd;
 
@@ -4137,10 +4138,13 @@ static void tcp_connect_init(struct sock *sk)
 		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
 
 	rcv_wnd = tcp_rwnd_init_bpf(sk);
+	full_space = tcp_full_space(sk);
 	if (rcv_wnd == 0)
 		rcv_wnd = dst_metric(dst, RTAX_INITRWND);
+	else if (full_space < (u64)rcv_wnd * tp->advmss)
+		full_space = min_t(u64, (u64)rcv_wnd * tp->advmss, INT_MAX);
 
-	tcp_select_initial_window(sk, tcp_full_space(sk),
+	tcp_select_initial_window(sk, full_space,
 				  tp->advmss - (tp->rx_opt.ts_recent_stamp ? tp->tcp_header_len - sizeof(struct tcphdr) : 0),
 				  &tp->rcv_wnd,
 				  &tp->window_clamp,
-- 
2.53.0-Meta

