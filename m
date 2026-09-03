Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3A86329
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397984; cv=none; b=DHTtVcHY72YDrz7CI2vcY0IA2qnIVLSp8tdYgg+iMk1v7K+xFWzI8ChDe8qN0OwQWS+1EOHEXhjZqoPsTb+0UxSWLpjyoHsPa+yb38rY9JBbPoV9otWlAtRQHYYAUDglgXGD1CuNqGHUXBP4TVduB5JjE34XNDJc498H0tIkgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397984; c=relaxed/simple;
	bh=39pxQ+8r3RU5eygXIOghhOBqOETu0gPB89a8qb+tmzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BmFaALCI6aT84/X2/ypFtGIb+Rl4yS5LvKJvYugqTlgomRFSt3GItXjBAz19w1mlQAZZyq4TUde2q/6oIM40rNrGAlOapnAu1G2KhkyoOUYx5RX3NPin8VKdt1DOoGkwuun1z9lxHZmU++OWL/8D2ouNO6IL11xKzHrZQh173/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xmGrDgZp; arc=none smtp.client-ip=91.218.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xmGrDgZp"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=39pxQ+8r3RU5eygXIOghhOBqOETu0gPB89a8qb+tmzY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788397976; v=1; x=1789002776;
 b=xmGrDgZp+MqFiyB+TKHpeDcWI6p3t5pon423vG3U9Nb8jzyGi8JC2eSN9ffmCfDCDwAMvtIe
 PsKI7zzmUaeEOA647Jux8vTIktxDeOEOOIrqrNcwkXNJlbontV871gLJV0UMIDoU1O4CzX32dau
 QTYZ/8xwo0Le7OUYT7m5pSyk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c6741134375e7c5;
	Thu, 03 Sep 2026 01:12:46 +0000
X-Mizu-Trace-ID: 4c6741134375e7c5
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 03 Sep 2026 09:12:20 +0800
Subject: [PATCH mptcp-next v2 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-mptcp_nft-v2-1-66283e4b9c3b@kylinos.cn>
References: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
In-Reply-To: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

During the conversion, we retain the same filter and chain names previously
used by iptables/ip6tables. Counters are not added to accept rules because
the test does not inspect them. After conversion, the generated output
matches the original iptables/ip6tables behavior.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 51 ++++++++++++----------
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b9d14647f401..41febb1bbbc7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -528,7 +528,7 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
-		"iptables"* | "ip6tables"*)
+		"iptables"* | "ip6tables"* | "nft"*)
 			if ! "${tool}" -V &> /dev/null; then
 				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
 				exit ${KSFT_SKIP}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a87429b6..a2c20483986d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -15,8 +15,6 @@ cin=""
 cout=""
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-iptables="iptables"
-ip6tables="ip6tables"
 
 ns1=""
 ns2=""
@@ -50,15 +48,25 @@ add_mark_rules()
 	local m=$2
 
 	local t
-	for t in ${iptables} ${ip6tables}; do
+	for t in ip ip6; do
+		ip netns exec "$ns" nft add table "$t" filter
+		ip netns exec "$ns" nft add chain "$t" filter OUTPUT \
+			'{ type filter hook output priority 0; policy accept; }'
+
 		# just to debug: check we have multiple subflows connection requests
-		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
+		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
+			tcp flags \& \(fin \| syn \| rst \| ack\) == syn \
+			meta mark "$m" accept
 
 		# RST packets might be handled by a internal dummy socket
-		ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --mark 0 -j ACCEPT
+		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
+			tcp flags \& rst == rst meta mark 0x0 accept
+
+		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
+			meta l4proto tcp meta mark "$m" accept
+		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
+			meta l4proto tcp meta mark 0 counter drop
 
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
 	done
 }
 
@@ -105,32 +113,29 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
+mptcp_lib_check_tools ip nft
 
 check_mark()
 {
 	local ns=$1
 	local af=$2
 
-	local tables=${iptables}
+	local tables="ip"
 
 	if [ $af -eq 6 ];then
-		tables=${ip6tables}
+		tables="ip6"
 	fi
 
-	local counters values
-	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
-	values=${counters%DROP*}
-
-	local v
-	for v in $values; do
-		if [ $v -ne 0 ]; then
-			mptcp_lib_pr_fail "got $tables $values in ns $ns," \
-					  "not 0 - not all expected packets marked"
-			ret=${KSFT_FAIL}
-			return 1
-		fi
-	done
+	local values
+	values=$(ip netns exec "$ns" nft list table "$tables" filter | \
+		grep -o "packets.*drop" | awk '{print $2}')
+
+	if [[ ! "$values" =~ ^[0-9]+$ ]] || [ "$values" -ne 0 ]; then
+		mptcp_lib_pr_fail "got $tables $values in ns $ns," \
+				  "not 0 - not all expected packets marked"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
 
 	return 0
 }

-- 
2.55.0

