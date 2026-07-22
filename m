Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D94D2EC4;
	Wed, 22 Jul 2026 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739682; cv=none; b=TP31kQRvGv2copJi3FVPxh0BvA7t305ylNQeL9vyBOfSCOwjXIk5HvlUmkM9qBVNUHq9FYLfbXtvI1F+oXz42rfTk/XJF/4EL5Qgb0SEJym0cW3gsUrKVf6knIporfXxhKn8RdetJKL8BA0lUN0VJAweA0uILtDWMejD1Bb6QBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739682; c=relaxed/simple;
	bh=SfpZ/3L0DEK4tUXJgLD6kEAOHVZDwyPm91q/afIdFPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FpygopyFG49KkOS2EdWbnwKZSLqD9vIKS5ZCQU9FRt1p/U7+IsqjTNt81EP5TUHT35yg1xib+ZPqyJCKSIrpH4CeqPuF9dwYa2us64kxIcorlyvI9sO9pU4EyN7zrD0429n8iBsBaOeYqrA8+FUYwmzkZKB3GYmLS2pleQKfkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DdQu2Tvz; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DdQu2Tvz"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66MFZMZg4098128;
	Wed, 22 Jul 2026 10:01:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=QUv5GrDyHCUA0ZFDfv
	P6w4o3Qz1jitC/KXT8IcH1/ok=; b=DdQu2Tvz0imx8OMF9+gp1gBmcUnq10jdEh
	rpbvHLfQoHT5N6ABdCzYK0j0XUywOW91RbSiSl4AZQXj6g1klcaIMLcuXDV2tg3F
	Eis1b1YoFR+SGce4L9OBai90XTynmkYb2A7xBumY5hKY83+RRFwyCuqxj4b4wKtf
	pVNUQlwrNZh1uIgxuCdp8JTS33TVxFCzHTC9GXY+/17Eilm+Wqtsz07QzB1a6rVJ
	bliHag3FJXMghiYzt/8ZdD6HUglLwx0JMqAK5kv1e7nFX77LbZ6nbXR9ZmiXXe7S
	ycAHdZxQAaJc1U1o3jUQvI1DWnliPbuJjgO7mIt4d7jKkfmUTO9Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4fjfj0e5rg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Jul 2026 10:01:01 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 22 Jul
 2026 17:00:59 +0000
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
Subject: [PATCH net-next] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
Date: Wed, 22 Jul 2026 10:00:33 -0700
Message-ID: <20260722170033.2763794-1-tejasbirajdar@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZwSiifyl2BMbGird2mzsH85iUIdr13fz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NyBTYWx0ZWRfX5cDl33mPO8Ep
 ZK4HgM8culeljhHQCMgB+SXhNm3F4xx2fh/3SJ+GLAFVQwBYqR/5iAOnZ1bOrgVjyo9ezNJAw2B
 YmBUuEMM0DA5NxtlkzBueZDELvSRzKKPAWOGZqJPi7VSWNmu51KjszQiIQCqYaR4kj0/I9hAGk1
 DccdoU3iql+ZUxbpgKgNu8ZFXJWORPuOwEl7j5erH0D6kQGvaxJpyEz5IMnxTyslvjstOjZ0T1c
 j0W0ufRGJqj6cwsUC7Kemxe5KkwAwhD9zfXYR66kSTh7nPex9OiaL+QeXq66x+qFJhUSYteAcr7
 LgapLRm5i0/rAaD2JZzSuBqqGIxKSmhs64JdEw2YgFbDsxP6tZk9k6sJn40tatHVHLj/atXRtzt
 sOAgoWLE9PWiOSGUl+KaN6RawOL7gJ+z5hIFX5b228idUxbTMYB1jv1t0tC8mGVErF1ctdbzuwv
 LqWbV0JnqPnVAgVrpJA==
X-Authority-Analysis: v=2.4 cv=TtnWQjXh c=1 sm=1 tr=0 ts=6a60f74d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8 a=bl5ZhtMPR9QNAx643iAA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NyBTYWx0ZWRfX8S1I1U+ycpPr
 9VZ9NumWw7g+dEgeQI9/GU9/peGM6/lyIdUag49p7JLVoWCwaS98pIHWH5wJxwAGeQsvs/yYDDy
 5zcvrIxjvfg1+tO2CbrdUEE0OVvCBgg=
X-Proofpoint-ORIG-GUID: ZwSiifyl2BMbGird2mzsH85iUIdr13fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01

BPF_SOCK_OPS_RWND_INIT lets a sockops BPF program pick the initial TCP
receive window, e.g. to advertise a larger window up front in environments
where that is known to be safe. Today it is only effective for the passive
(listener) side; on the active (connect) side the value is computed and
then silently discarded.

On the passive path tcp_openreq_init_rwin() inflates full_space when the
program returns a non-zero window, so tcp_select_initial_window() can offer
it:

	else if (full_space < rcv_wnd * mss)
		full_space = rcv_wnd * mss;

tcp_select_initial_window() only clamps the requested window *down* to the
available space, so without inflating the space first the BPF reply can
never raise the offered window above tcp_full_space(sk).

tcp_connect_init() calls tcp_rwnd_init_bpf() but never inflates full_space,
so on connect() the requested window is clamped back to tcp_full_space(sk)
(~64KB at the default rcvbuf) and the program's value is ignored.

Mirror the listener-side inflation in tcp_connect_init() so both directions
behave the same. tp->advmss is the mss the listener path uses as well (both
are tcp_mss_clamp(tp, dst_metric_advmss(dst))).

Fixes: 13d3b1ebe287 ("bpf: Support for setting initial receive window")
Signed-off-by: Tejas Birajdar <tejasbirajdar@meta.com>
---
Functional test: attached a cgroup sockops BPF program that sets
skops->reply for BPF_SOCK_OPS_RWND_INIT on the connecting socket, and
drove it with packetdrill on the active-open (connect) path (wscale 11,
advmss 1440). On the patched kernel the advertised receive window on the
first post-handshake ACK now reflects the requested value; unpatched it
stays clamped at ~64 KB:

  req_segs   unpatched   patched
  256        ~64 KB      360 KB   (256  * 1440)
  1024       ~64 KB      1.41 MB  (1024 * 1440)
  4096       ~64 KB      5.63 MB  (4096 * 1440)

(The SYN window itself is unscaled/capped; the offered window appears on
the first scaled post-handshake ACK.)

Regression: tools/testing/selftests/net/packetdrill run under virtme-ng
on this commit vs its parent produces an identical pass/fail set (no
newly failing tests).

 net/ipv4/tcp_output.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5e30..478e4951140f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4101,6 +4101,7 @@ static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 static void tcp_connect_init(struct sock *sk)
 {
 	const struct dst_entry *dst = __sk_dst_get(sk);
+	int full_space = tcp_full_space(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	__u8 rcv_wscale;
 	u16 user_mss;
@@ -4133,14 +4134,16 @@ static void tcp_connect_init(struct sock *sk)
 
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
-	    (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp == 0))
-		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
+	    (tp->window_clamp > full_space || tp->window_clamp == 0))
+		WRITE_ONCE(tp->window_clamp, full_space);
 
 	rcv_wnd = tcp_rwnd_init_bpf(sk);
 	if (rcv_wnd == 0)
 		rcv_wnd = dst_metric(dst, RTAX_INITRWND);
+	else if (full_space < rcv_wnd * tp->advmss)
+		full_space = rcv_wnd * tp->advmss;
 
-	tcp_select_initial_window(sk, tcp_full_space(sk),
+	tcp_select_initial_window(sk, full_space,
 				  tp->advmss - (tp->rx_opt.ts_recent_stamp ? tp->tcp_header_len - sizeof(struct tcphdr) : 0),
 				  &tp->rcv_wnd,
 				  &tp->window_clamp,
-- 
2.53.0-Meta

