Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609124DCF6;
	Thu, 30 Jul 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448879; cv=none; b=iu7TEZHL0AN/p68xuzGEbbswC/XZ9HEZvgD675PYBu7ExrUVTTURLMK8dCTrcPHJamOB2MGJad57TDRHERV36oAiIiQv5AzKaLUCocDBPFq4pGOX5oGErirBpr3FBeTo+0hbaXQoAhs8YDDuyqP5axbmJbcvJEpuYlu49YuXlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448879; c=relaxed/simple;
	bh=sQQNI0T320x5izTnyyq6J5o0mamqvX++AhBGZawqwr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zlv/ssJAdaGWluwJQf6dfH7Dg9dMVlaS8rIz4AoGjJ8R2v5CDE+7D+/NS9ZSKt3xl++AR+y3xArxx4NzxaIxRZ1KO++CAfVR6dOFUJab7OB6Ak1R7B3BjljaD+MO6wqxRvFrxrxH54qwyNrXhTXC7hL3Dxe51R46wNY/IJ9vybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OV3ArW9R; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OV3ArW9R"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UL1wL33369365;
	Thu, 30 Jul 2026 15:01:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=UkH7mKEM9
	P7dqP/Lb82d88AqlrpsQErduRlaXFMEngE=; b=OV3ArW9RFioggVk+ukIwRScYb
	/Ry3kjWsOLKKVH2UVK1ciF+eIV5cMT6dF1S8RBncB/8hem9aS3W3nF5VppSLyG4P
	II+/zv4j+hO7MORcLwJma7N0hoAwduNhcI5QZ+FzL08u01HW8cBETF60imIgk3SX
	+kwfWSwxXDX2/bko+Sb3xf3tJkcwCz6trVuwjYLkUeIQPcLh3Y27v1WQq+r6s0D/
	cc1gcrJO4VtU5ai20jvt3tlo1Xkb82YlqzUvwoHISHRPYnO0OQ2yB5kjI/LuE7xT
	FiXI9CyvuiLbH2xdVh5ln9Ck+l6geFiBnuBXrIaK8oGphdG+J33+jMXbWqfsQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrn90upq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Jul 2026 15:01:10 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Thu, 30 Jul
 2026 22:01:09 +0000
From: Tejas Birajdar <tejasbirajdar@meta.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
        <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "David
 S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tejas Birajdar
	<tejasbirajdar@meta.com>,
        Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
Date: Thu, 30 Jul 2026 15:00:55 -0700
Message-ID: <20260730220055.2946171-1-tejasbirajdar@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1OCBTYWx0ZWRfX8J5ZCRBZNJSG
 7H6m7brEmwavmDpmn6rumA7DtK7y9i0/w4BN5CICAKG+LEBUUsqMB6p7OUQ+mg6AGB4W7VOXasI
 bt3E3QNwXQL6CrH+eyY778tQzj4Tjx4sYrkAopefF5Bp70e9KeESYo8DO77jkWih1Pvs4vEHpaL
 QBlmK2vOXY5XrW8UYTvO2WGCf86PTFlDLYcB4Fkf+86BFxvXW6AbDOn3+mq5EWQhSfHAYGGEXih
 TWG/2/d3RKb1PMzErsTra5FC27dFpSEqLql6Mz/oYMpFklmhhPhMk1WtY4a8NVL14bj48Z8ydyG
 DuUa/cGsd2D2WcUlFXSoAoqpG1vHkHkXqEw3fJrQIFYCfhm7e7gAmDhTxwJtD6J/TDxOpxMrLSD
 a/OoBzqSn8H7b8l4ncxTNkBHBPg93GhMZ8J4TQR6V+4BKk027nOnj6r+kj0zhzthgbax0T8dMLB
 4E5URz+mNkJa7+dpLoQ==
X-Authority-Analysis: v=2.4 cv=cpGrVV4i c=1 sm=1 tr=0 ts=6a6bc9a6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=4XeK37IC55s43dnOpu4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1OCBTYWx0ZWRfXzl+zEcI6hfGX
 auRwOi6hYx3cmqyfekwqp8XZdOqL0Dfti67YOL5arF7UPQ23foYC1hplkLaFGweR1wdxjnAUW3f
 sbXuhZ8ZvsdpS493sOCncB1X+rkXnQQ=
X-Proofpoint-ORIG-GUID: MV0HKsZ3_ja9AdgYCADM9FxARXy9_Yft
X-Proofpoint-GUID: MV0HKsZ3_ja9AdgYCADM9FxARXy9_Yft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01

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

tcp_select_initial_window() itself also computes init_rcv_wnd * mss in
32-bit when clamping the offered window down to the requested value. A
large requested window (init_rcv_wnd greater than ~2.9M segments at
1460 mss) wraps this multiply and collapses the offered window to a tiny
value, so compute it in u64 as well.

Fixes: 13d3b1ebe287 ("bpf: Support for setting initial receive window")
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejas Birajdar <tejasbirajdar@meta.com>
---
v3:
  - Also compute init_rcv_wnd * mss in u64 in tcp_select_initial_window();
    a large requested window otherwise overflows the 32-bit multiply and
    collapses the offered window.
v2: https://lore.kernel.org/netdev/20260723214208.3655474-1-tejasbirajdar@meta.com/
  - Compute the inflated full_space in u64 and clamp to INT_MAX in both the
    connect and listener paths; read full_space after tcp_rwnd_init_bpf().
v1: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbirajdar@meta.com/

Verified on the connect path with packetdrill: the offered initial window
now tracks the BPF-requested value, and a large request that previously
overflowed no longer collapses it. No new failures in the in-tree
packetdrill selftests.

 net/ipv4/tcp_minisocks.c | 4 ++--
 net/ipv4/tcp_output.c    | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

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
index d7c1444b5e30..fcaa04e65189 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -251,7 +251,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 		(*rcv_wnd) = space;
 
 	if (init_rcv_wnd)
-		*rcv_wnd = min(*rcv_wnd, init_rcv_wnd * mss);
+		*rcv_wnd = min_t(u64, *rcv_wnd, (u64)init_rcv_wnd * mss);
 
 	*rcv_wscale = 0;
 	if (wscale_ok) {
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

