Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561356;
	b=TivZuI9s1nuN9uD4qTMIBhk03gU2UlM7g5BNzAXmiQphJJeqgReoTgiJdpBVHIi4tkbu
	 tVtyFp6Hu36d3v0xb5UsfTSQkmTG8eRlkjZ8mlkQ6Iw1zFpcTcGZsX6nriVZz5HkLm2in
	 T3swdCAswpaHVGX+CE+cVTYxFbVaLrYR373JUdowGEOj/ICAtmnvG4OFW7gJ9qUIR9Ryx
	 Pq/9ahpfSz4KoVBrZD4yz+X/qJGq4bkcq1V0DzY/CH8KQKxRjveK3oXjahOKz8kCSWdFE
	 /LoBIamI0y7X0KK4U0580UH5dXZaisL+aijDt1vLvyaaciDWleJc0FV2CIGG4JVl42Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D5BPfe091LT3dmDUExK7fHms4x6j0arLEPQECwd2AVo=;
	b=b9yMKj3zU9O81tcFgauEpKzCm+98wcFkqgvb4LEdTdRCuKWhns71r+mFoz6TegxhpQNk
	 01dMrgBWT2mhP8OgxCEU2X/SY5HFP74UX6U9r5Vr1jTYGz6FNdf/pJUv6MqnLxySjeZnp
	 5CivHHM8Q6/UNsMrEtyCUk4cPhg6sXDaDYUHoatkt+NKXQzR9v78pAGK42C5+AqvQ4NGn
	 ud6ZaXk7QpTKYHgjvSfXu72kxvaxp70OcC8sJT6jhb56BbWg2r1FqP2wZ9/oJyBvJE1Hz
	 FOmk4zb64CGV98malS/a6JYr+XXYivQCatMNpAZyJH7yoLHWTVn4+Je/CpnTNrsJCgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xyip/I4C";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A8606A32C
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544A8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xyip/I4C
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-385d8a00598so7465139eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795561355; x=1796166155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D5BPfe091LT3dmDUExK7fHms4x6j0arLEPQECwd2AVo=;
        b=Xyip/I4CJjOX79oknp9xnxqH8tk7ypjlRD+iGVEGJhXc1Q78Z0uyTgA7aine8/XIdk
         u4cGGtKJxpG5CHBu0FUISUpWRuMSTxqFwiGqnMOgB0J5J282mZWz3MYJpKm6Ui2AnnZn
         QsHovNmRZs6jMvcBr9BQ+uyJ2GWtF1yryusczyPgenGxiO/SScygAAcq0Dq0imjZ7Jce
         wx/x5AVqjyhbNuFwTTKv0J3MYajKHMAo1Z513kotdbsU7rnQX2upFbTYZ+IbRdyVeVMM
         DNDwT1z0nSrpBU9SnaVwzwXSaQNTHxkD/TNtoQvDCWXB1oogCnpD0WKIvTp1zLBPyvYL
         4WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795561355; x=1796166155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D5BPfe091LT3dmDUExK7fHms4x6j0arLEPQECwd2AVo=;
        b=1Bv0KRmhLjG+1V/pC1OytA19zkXCq8xRsA79wM9R3QL1LrX+Xi1jUNq5RJgHHwo0jd
         a0uz7SDSFK5C3fRqI4xiO11xtJ8we+05GSVf/646xcLkGHpw/0N7Bp0J2po3zVvrdvsA
         cJpToDY0MWVjvk8cwr43MKgulbkYhhmWOkVVvP8XX6nufoOgq5p89iqNgWKYev5TLpAR
         sYJdmL8yihOTJPjywbCva4J5q1yFtcTmwHEa9V/qC7VJK/3V7U4dJeTjxaTgQg+D4EhG
         kxBh2C0nIdaeDngcTluRhISaFaU0Sjiv3eTKfyvRZJt0pOtH8032nuIopgOLS3S+YSc3
         saTA==
X-Forwarded-Encrypted: i=1; AL+hErHLhdn7WNMG8E80K5veqcw2n6dP9Ut8JdYvq0mwWU0m9N0LaH8NZugy83LhwTxeN0YI0/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t/7eW5ZYSGiKSxsF6D97QqOnGNtilR1wdtCp44uD1RXLrNUza
	M1++ZVDqDdMZeXB7MM2TgPGg11MknwFEPwU/sZx0h0aIHN37QpdgfyoT
X-Gm-Gg: AZFdTZetr0y5JQCsRn+QQWRJ/Jv5/worQz5V11Jb6vMG/MQvmO+8kpKzOdQEuuhhZZR
	Dod3VCERi/YHCdVw3fhyafvTVrKZJSDtTf8Xfy6pnrA+Xh/tfqMapzRscdR/QslwQYYH57dCfeq
	3TrP/XZ5smX2I4jCvOsfGo7mAXSGic4xiQ9qV3eVw+iwVqU/aNG0k+7U15X8O9qz4t9tEdnek7X
	XQzbAFftb7wyCniDqIfZqGmUHq9h718yl1591J9I4OGYoTtfjUyI84p0rix6jFQsUFspEH2Nf+3
	BZrFcDFKMK1J3j3w7csDrMrSIwdZ2VE7fB9C4li0JJXWTT835DRobHeb0r8Zg1cd0kctkijjf6V
	0dasR7E1uFUCrZfQtjziutFYNPLraAoC9l4jO+Vu3MFeJ+jy19MXcuGbLihnSakywfDZJfi7YTB
	p9TDSfOqBx4uwlONUTwjbWhahZSCQKn6+0qO6ZCQfv14xPyJU3hqyH2lFeDc+5F5n7dw/Rcv2sZ
	k4hk8/RREhRl5Yj0OZrdrnGIo4Zjxmineh2mgTLUr+wnLCz3LhUVG7OTJjHny1B5NBDoDsjYJ0F
	RnVniWXSSE5nj1+i7Lid8qpXmO2C10pmDiGfbqTeHADILSjDbw==
X-Received: by 2002:a05:7300:7316:b0:386:c5d3:7300 with SMTP id 5a478bee46e88-386c5d37603mr3417710eec.12.1795561355161;
        Tue, 24 Nov 2026 15:02:35 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm59747187eec.5.2026.11.24.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 15:02:34 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tcp: avoid NULL skb dereference in zerocopy receive with sockmap
Date: Wed, 25 Nov 2026 08:02:27 +0900
Message-ID: <20261124230228.3868519-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sockmap SK_SKB verdict can remove receive skbs through tcp_read_skb()
without advancing tp->copied_seq. tcp_inq() then reports unread bytes
while sk_receive_queue is empty. Deleting the socket's sockmap entry
does not repair the sequence mismatch.

TCP_ZEROCOPY_RECEIVE uses tcp_inq() before inspecting the native receive
queue. A small request enters tcp_zc_handle_leftover(), where
tcp_recv_skb() can return NULL. A page-sized request can reach the
mapping loop with the same empty queue and dereference a NULL skb.

Check tcp_recv_skb() before using its result in both paths. Also stop
before advancing beyond the last skb in sk_receive_queue. Neither
check consumes data in the sockmap ingress queue.

A custom LLM agent developed by the author found this issue. The author
manually reviewed the root cause and tested the reproducer and fix.
On net/main with KASAN, a privileged SOCKMAP SK_PASS reproducer
triggered NULL dereferences with both small and page-sized requests.
A map-delete variant also triggered the small-request fault. All
completed without a KASAN report after this change. A non-sockmap TCP
baseline still copied one byte. An adapted tcp_mmap -z selftest, with
only its transfer size reduced from 32 GiB to 64 MiB, passed before
and after the fix.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 net/ipv4/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 418842a2dfd9..fa3b4bcbc726 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2072,6 +2072,8 @@ static int tcp_zc_handle_leftover(struct tcp_zerocopy_receive *zc,
 		offset = *seq - TCP_SKB_CB(skb)->seq;
 	} else {
 		skb = tcp_recv_skb(sk, *seq, &offset);
+		if (!skb)
+			return 0;
 		if (TCP_SKB_CB(skb)->has_rxtstamp) {
 			tcp_update_recv_tstamps(skb, tss);
 			zc->msg_flags |= TCP_CMSG_TS;
@@ -2274,10 +2276,14 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			if (skb) {
 				if (zc->recv_skip_hint > 0)
 					break;
+				if (skb_queue_is_last(&sk->sk_receive_queue, skb))
+					break;
 				skb = skb->next;
 				offset = seq - TCP_SKB_CB(skb)->seq;
 			} else {
 				skb = tcp_recv_skb(sk, seq, &offset);
+				if (!skb)
+					break;
 			}
 
 			if (!skb_frags_readable(skb))

base-commit: 37fa509e43ba59d7c329025436e8ea64bdf089d7
-- 
2.43.0

