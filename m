Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB12BEC3F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145729; cv=none; b=VDRz28kZwy4glQtcnXAgIRDjLJZ2TaTa/2AiAxMVU/hus+Miwyv9ZOsty2NmDC0hWmGUlwYH+MCKpC8n9i7DH2gHeXXAEoDVf39I8A3gLvvE4zaowtOvj1/pWSYMZ++6c6R5WiAF30Bv5XFfd1uxm2CRuHifXuvZIg5ELpMpxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145729; c=relaxed/simple;
	bh=RynrkmsPjBrTKAylfOdaBo5j7TR9XNO11d/bf45huAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9cFKXgVPVYyUFtDxtarwIANVf6wmnzYD2dBLOCcCWFaogvg6ax8Y/0iFBpmzz0e9GlXv8yqqxXqYJV9lVj5MvU3d3M+s2sPs2cBGxGNpdDHHBUKbBSIDQYjrDNkEzDAbDp3PwXOn2+wjTAyDpuroJ/1wsIzWESrmRPNOM1OP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE9GK/fn; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE9GK/fn"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2cbdd9852aaso51512eec.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775145728; x=1775750528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VErXaAocdlc5UgqhS/sNUrt7vWuZgzHMcDW3jehfG04=;
        b=iE9GK/fnyNItTaCDNKiQpRPgDKN37dpBO4uaNpsZ1gGQn53SvUDJTPysGmXq773Vvl
         oEHMqiH5k1+a6buVzzKEV4pQAORlyHOt9rSwf768Rs0FkFG4k8wlgiZuhnxaDnW9xTXV
         AX3SWrwnH73gAk1mU+3WxQtbLOg/hEZy+DEMDMewfBHKOhFKE0jmtu5JazuxUIFMDUKX
         PQHDx7dBA8EgvZbPU+0X/upvIJTC/9xqz+yPTQW2bcTw6luoQU9+/r5K0egCPjufVxcA
         PkgyRQWjnPlI+1m3VNHxFDgqHQ4ULpmSxEEx9p8BbDPSfhHUyBZKfzErQlYQu2mJeljk
         iPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145728; x=1775750528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VErXaAocdlc5UgqhS/sNUrt7vWuZgzHMcDW3jehfG04=;
        b=Wb+liMmq3q4sasdYN3OpTpEVD/AbYy4Brx0rQXde8x4MNHyh9gJ6eCxjoYgmpWHFQE
         dgkCe0PTBZi5i0fo1b72UPjnEk+HRgaivPvzx4S90nls2evr5WTYxJ+ldoAelPGGFxzR
         M8+GoDZ+ETYaBy6jAQBeDMuW6snERUzBJrg8j/ZvQhhu2fuPvsiq5xqKfM+Y60RfMTJ7
         dqfabMlrjmyMdy0pyKvh3ZpfmzTvdZYr7TCXGB59XESg5+1RHJeTnIHRyP53flE5ODV+
         7GC2yAADfm6rgnOSKyWJ4A7LY68iKohi10h2woMCtgm6KAsDuL6B3/dIXocGG5tKN2Vn
         ThOw==
X-Forwarded-Encrypted: i=1; AJvYcCXbvQhcXnTrR6m191CTUoVDufbETVDSHnmq1qrAXaRRNOMb3P0LG3IIDJe439bEYLc4vYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHOLv3PyjtoOJgG6uwvYogK1b+JrPwoNOXfo2meFVsHp6ysIR
	X0mwZPYTcW+2owKFnF3vm8j38O6/tk8V54mXlLvHIJd5BgCp6UisFtjJ
X-Gm-Gg: AeBDiesGB7aeTTThK/8BOT9gmkHDCUEOG59ZIHl59aamF6XFd1IrMNVt3a6mDDd1Ck7
	u5OnTUOEnD0aq1kJdjEE8WKYDWsx1oMpvD1RfppVxeMNejGZB7LuObXzbZe+C/safBoAz6kmZOS
	ssO7egoho/8EgRHfDW+iE71EqO+Wh7N3ShQqCziusLNxOEDYE2mQvRcXZNqIm9Qgfdx0MB9vete
	i/ZwXB9LFLxhZWOIWY1opVSIz06sNm1HxaUljtAyJT8pwXXy4XRvsFBEDzrqcwR1e6ZfO48ej4W
	x/8HNk0C+bsNIs0z0gMwnXzjAjn3pnA0ZPsMKVDdUt2cAz/L5PNYLZLH0qZGkwkT7fLF5I13GJg
	5YVCvn5N3zFA47GSjNqeUUF5IdnswUXv4BEiP4BO5Ju1QnkJ+l19s8yI18wh3Dphbpgvj64LnTD
	CULRXn7voQubFwq6U1vIy7ZP1S9of+OQSBZ07IFG8V5WKsmhTPqVuEpmWsWUfmF6KzBo34+upV7
	Tm3f3rbyOVnC3mifie/JmqZfMkQHcaNHKz1xElbAPVdlKHck4ZN233ClSFXdsjNcGs=
X-Received: by 2002:a05:7300:fd8b:b0:2c0:f15a:ecbc with SMTP id 5a478bee46e88-2ca8fd69069mr1912965eec.33.1775145727172;
        Thu, 02 Apr 2026 09:02:07 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3c11sm2835293eec.4.2026.04.02.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:02:06 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf-next v3] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
Date: Fri,  3 Apr 2026 00:01:47 +0800
Message-ID: <20260402160147.215499-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_test_run_skb() calls eth_type_trans() first and then uses
skb->protocol to initialize sk family and address fields for the test
run.

For IPv4 and IPv6 packets, it may access ip_hdr(skb) or ipv6_hdr(skb)
to initialize sk fields. Reject the input earlier if the Ethernet frame
carries IPv4/IPv6 EtherType but the L3 header is too short.

Fold the IPv4/IPv6 header length checks into the existing protocol
switch and return -EINVAL before accessing the network headers.

Also extend empty_skb selftests with ETH_HLEN-sized packets carrying
IPv4/IPv6 EtherType but no L3 header.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
Changes in v3:
- Rework the fix by moving the checks into the existing protocol switch
  in bpf_prog_test_run_skb() instead of duplicating the switch.
- Add empty_skb selftests for ETH_HLEN-sized packets with IPv4/IPv6
  EtherType but no L3 header.
- Retarget to bpf-next.

Link: https://lore.kernel.org/bpf/20260329161751.1914272-1-sun.jian.kdev@gmail.com/

 net/bpf/test_run.c                            | 20 ++++++++-----
 .../selftests/bpf/prog_tests/empty_skb.c      | 29 +++++++++++++++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..300e2bfc5a62 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1120,19 +1120,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		sk->sk_family = AF_INET;
-		if (sizeof(struct iphdr) <= skb_headlen(skb)) {
-			sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
-			sk->sk_daddr = ip_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET;
+		sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
+		sk->sk_daddr = ip_hdr(skb)->daddr;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
-		sk->sk_family = AF_INET6;
-		if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
-			sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
-			sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET6;
+		sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
+		sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
 		break;
 #endif
 	default:
diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index 438583e1f2d1..d53567e9cd77 100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -12,6 +12,8 @@ void test_empty_skb(void)
 	struct bpf_program *prog;
 	char eth_hlen_pp[15];
 	char eth_hlen[14];
+	char ipv4_eth_hlen[14];
+	char ipv6_eth_hlen[14];
 	int veth_ifindex;
 	int ipip_ifindex;
 	int err;
@@ -46,6 +48,24 @@ void test_empty_skb(void)
 			.err = -EINVAL,
 		},
 
+		/* ETH_HLEN-sized packets with IPv4/IPv6 EtherType but
+		 * no L3 header are rejected.
+		 */
+		{
+			.msg = "veth short IPv4 ingress packet",
+			.data_in = ipv4_eth_hlen,
+			.data_size_in = sizeof(ipv4_eth_hlen),
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+		},
+		{
+			.msg = "veth short IPv6 ingress packet",
+			.data_in = ipv6_eth_hlen,
+			.data_size_in = sizeof(ipv6_eth_hlen),
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+		},
+
 		/* ETH_HLEN-sized packets:
 		 * - can not be redirected at LWT_XMIT
 		 * - can be redirected at TC to non-tunneling dest
@@ -108,6 +128,15 @@ void test_empty_skb(void)
 	SYS(out, "ip addr add 192.168.1.1/16 dev ipip0");
 	ipip_ifindex = if_nametoindex("ipip0");
 
+	memset(ipv4_eth_hlen, 0, sizeof(ipv4_eth_hlen));
+	memset(ipv6_eth_hlen, 0, sizeof(ipv6_eth_hlen));
+
+	ipv4_eth_hlen[12] = 0x08;
+	ipv4_eth_hlen[13] = 0x00;
+
+	ipv6_eth_hlen[12] = 0x86;
+	ipv6_eth_hlen[13] = 0xdd;
+
 	bpf_obj = empty_skb__open_and_load();
 	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
 		goto out;
-- 
2.43.0

