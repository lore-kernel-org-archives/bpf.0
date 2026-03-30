Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD13A7840
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907836; cv=none; b=sE3onz0ujE2TFggUwpiHJdTEQ6Rpin2eYd+H49r+TcRnxxi+PvL67NreTbyysdJjGZpwO+akdh0lLWdOLX1IrT50tnRSfeZjNwGxRllk5MXOoRjzlJydjNPCbr64Ce2wVST7Cy4MKiNSOpeLFlPflEa/leeGSV71urMWIaNr1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907836; c=relaxed/simple;
	bh=pz86PmEpfzQN9js8IsuHqblvmjM03Ljb/l6bvN9B5Ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q3EyBDHXPNiMVzjbGQJR3Jfc9WAPIRZ21rFKYAbA2S8pu9g+euZsA1ieU0TymrIG9Z/08s3xQoqhNSXASqDFDlR21y+fm6lc9kNdu6EYBrwkgAKxJ3yvHO8em7YL/xdE8u44aK1N2Ouve7XYt+J3vXcXwYJk2uz58ahrOCMXT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWab94tu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWab94tu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24611696eso16814165ad.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907831; x=1775512631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DR2NV2QHTTPddHUWacFog7WO7giZkfHr/2vqRIpwBGM=;
        b=IWab94tuiYPgSu5VWUAq8rtCYBUgGNScAaTJO7B5bAHld/Oc5VVHPx99DPFtBfl5tn
         uWPtguVjaxZZtPRLBHhiUiaPmCwfF7ecUuIcbau7Jw/I0ZYCy9jyDw993GwryOqDoxaR
         3+dUCgB31izbB1jXHimalHiGiKqiDms/foCVBXZE8fLEnSspd8s9tvRv8mVqkE16Xezj
         pPe8bXjD8ifT71CCJ2ye5KwpYA3jTe+rKRXvPa5jgIomCcUi8PS14P9Rn1AtQAxM7mvO
         gCEHM8ejmKsx4r+MAQKlHONhpnLqRI11uAp/iikBvjBQ1YFKZGUF/syjfW3btZFYU9Tj
         SoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907831; x=1775512631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DR2NV2QHTTPddHUWacFog7WO7giZkfHr/2vqRIpwBGM=;
        b=V6GPZLUW50hz8+DatJHaZrk2GXJ6eA0h68NHqMaq83CSq8R+ZdiM+HeyYFTCpzPQlO
         LZvszfk7kXO/oc/eBLkcBbEMLuVEgc+4HGEXZCbAbQ61usw3MH5rZb52eEnQFbGPKnxL
         P07e8MD9vmmLlVSGIC+HtBWFWPgAec/8J71seMmoUui1NBeNtoTyJCAfMO+IcZq8F2UK
         huQQPnZBa+KX87U8TJC6PjkhEBLZ9GJqBHgUnwaKdw/d7ySJ934h0yOEORkwea26rbXn
         yi6PFMLChApMJmGLHbsWklXNjVo8WS9DTVbnODsQwWJyOb0+AuUAuQ3XmR1zaODNu21S
         PZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBmSLSpmbuGQcWA1Id4rRaLvzpCfSD+g5USDp6nXhtRIBMA6SsW/Lqye+c29DN/NOyaNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQsQkYDmrEBsUyB11OhjY82m0HsnO3PjG8Mn+25f+VGOre0hQ
	QyuaesWbJ0ATom73kKSs+DU2GkLvVXx66lN2sJmSjMHYBC+a82lt96CBTJAY17Ikaax02acgCbO
	Cug==
X-Received: from pgg12.prod.google.com ([2002:a05:6a02:4d8c:b0:c73:bade:9641])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9187:b0:398:4c9f:d970
 with SMTP id adf61e73a8af0-39c877a9973mr13050112637.14.1774907830685; Mon, 30
 Mar 2026 14:57:10 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:01 +0000
In-Reply-To: <20260330215707.2374657-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-2-jrife@google.com>
Subject: [PATCH net-next v3 1/4] udp: Only compare daddr/dport when sk_state
 == TCP_ESTABLISHED
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

Adjust lookups and scoring to keep their results equivalent to before
even if inet_daddr+inet_dport are left intact after disconnecting a
socket (sk_state == TCP_CLOSE). sk_state == TCP_ESTABLISHED implies that
*daddr is non-zero, so remove redundant checks for that at the same
time. Note that __udp6_lib_demux_lookup already checks if sk_state ==
TCP_ESTABLISHED, so no change was needed there [1].

I could find no discernible difference in performance in
udp4_lib_lookup2 before and after the change in compute_score.

(AMD Ryzen 9 9900X)

kprobe:udp4_lib_lookup2 {
        @start[cpu] = nsecs;
}
kretprobe:udp4_lib_lookup2 {
        @lookup[cpu] = hist(nsecs - @start[cpu], 2);
}

BEFORE
======
@lookup[11]:
[80, 96)         1387077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[96, 112)         364973 |@@@@@@@@@@@@@                                       |
[112, 128)         34261 |@                                                   |
[128, 160)          7246 |                                                    |
[160, 192)           215 |                                                    |
[192, 224)           126 |                                                    |

AFTER
=====
@lookup[11]:
[80, 96)         1408594 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[96, 112)         340568 |@@@@@@@@@@@@                                        |
[112, 128)         30753 |@                                                   |
[128, 160)          8019 |                                                    |
[160, 192)           231 |                                                    |
[192, 224)           157 |                                                    |

[1]: https://lore.kernel.org/netdev/20170623222537.130493-1-tracywwnj@gmail.com/

Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 20 +++++++++++---------
 net/ipv6/udp.c | 18 +++++++++---------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b60fad393e18..d91c587c3657 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -385,16 +385,16 @@ static int compute_score(struct sock *sk, const struct net *net,
 	score = (sk->sk_family == PF_INET) ? 2 : 1;
 
 	inet = inet_sk(sk);
-	if (inet->inet_daddr) {
+	if (sk->sk_state == TCP_ESTABLISHED) {
 		if (inet->inet_daddr != saddr)
 			return -1;
 		score += 4;
-	}
 
-	if (inet->inet_dport) {
-		if (inet->inet_dport != sport)
-			return -1;
-		score += 4;
+		if (inet->inet_dport) {
+			if (inet->inet_dport != sport)
+				return -1;
+			score += 4;
+		}
 	}
 
 	dev_match = udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
@@ -796,8 +796,9 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
 
 	if (!net_eq(sock_net(sk), net) ||
 	    udp_sk(sk)->udp_port_hash != hnum ||
-	    (inet->inet_daddr && inet->inet_daddr != rmt_addr) ||
-	    (inet->inet_dport != rmt_port && inet->inet_dport) ||
+	    (sk->sk_state == TCP_ESTABLISHED &&
+	     (inet->inet_daddr != rmt_addr ||
+	     (inet->inet_dport != rmt_port && inet->inet_dport))) ||
 	    (inet->inet_rcv_saddr && inet->inet_rcv_saddr != loc_addr) ||
 	    ipv6_only_sock(sk) ||
 	    !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
@@ -2854,7 +2855,8 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 	ports = INET_COMBINED_PORTS(rmt_port, hnum);
 
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		if (inet_match(net, sk, acookie, ports, dif, sdif))
+		if (sk->sk_state == TCP_ESTABLISHED &&
+		    inet_match(net, sk, acookie, ports, dif, sdif))
 			return sk;
 		/* Only check first socket in chain */
 		break;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 010b909275dd..b93a9a3e7678 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -147,16 +147,16 @@ static int compute_score(struct sock *sk, const struct net *net,
 	score = 0;
 	inet = inet_sk(sk);
 
-	if (inet->inet_dport) {
+	if (sk->sk_state == TCP_ESTABLISHED) {
 		if (inet->inet_dport != sport)
 			return -1;
 		score++;
-	}
 
-	if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
-		if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
-			return -1;
-		score++;
+		if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
+			if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
+				return -1;
+			score++;
+		}
 	}
 
 	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
@@ -949,9 +949,9 @@ static bool __udp_v6_is_mcast_sock(struct net *net, const struct sock *sk,
 
 	if (udp_sk(sk)->udp_port_hash != hnum ||
 	    sk->sk_family != PF_INET6 ||
-	    (inet->inet_dport && inet->inet_dport != rmt_port) ||
-	    (!ipv6_addr_any(&sk->sk_v6_daddr) &&
-		    !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
+	    (sk->sk_state == TCP_ESTABLISHED &&
+	     ((inet->inet_dport && inet->inet_dport != rmt_port) ||
+	     !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr))) ||
 	    !udp_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if), dif, sdif) ||
 	    (!ipv6_addr_any(&sk->sk_v6_rcv_saddr) &&
 		    !ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr)))
-- 
2.53.0.1118.gaef5881109-goog

