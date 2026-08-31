Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01F38C2A0;
	Mon, 31 Aug 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195175; cv=fail; b=LQS1NNugsRDSBdbzNpStSfwtyPsue44BonE/9xrGwsFdiCBrKbMyFxqdz6HAkf6clHpK04lGIDQoqt5f/YRPjCvh38AUaZNLBwDojasOg0aTJ0XwDH4sBTQGZL8PRUbbte5u7YdWk5ZMoB/dvoWdzo+XcIAycx2EFj+/1cNqre4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195175; c=relaxed/simple;
	bh=LYw0itHjr8GhlptyLiUuXu+47FzJZ2aSoHmBXp9B6Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXXMbX4jAlffWABOnurs9iD+ne0/QIA0UE3dGKo0Xn2l75W/Z6svsR82ES6fAsdzxaMRtzTI2eAFshaPCfO4tMuhD6pzSPaqKF8R7KEttJcJXY4WCzR11UrlNAEXW9m4D6nO35hEuWk4UIAk/wYX8h6gA6LmwKDnO2tm0UznU0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VeDAnY2a; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VeDAnY2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVK1iEPShqxIi7StTpOf7Vw0N4kmIEVslHwtKW32e6BIqFt8O/ySd3e+CJ2N7qf80hTsD9F/68cLPBHdKgyS831KzUsfBsDRVHhn8r5l3cOwzOBDkBTI9rtgqu7DhgKaJ/fHayJ+PqCpBskTWbiiF/n4yPmBUe4xuax5dEpRTHlxRkbLDiVl47PZdumEPEVZZA0/LH8h+tfAhkr6lnk083kWhISTBZhHNMGiWoJ4TF/cFX76uIsYX4Y6u+fXCzACF26a1ZfxBZOyAqM1hfbHSytbLqM6GL/SetsoQiqPWwX03gcIrkPwoU/TZGrm7tlJcfu1MMGo2RU/iBBJXZ32VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsfgBSH70Jv8tYmbFFimeyKqhYK8FOaK4dygOAAzSp0=;
 b=IXrNNy9fR9uFIxJO7ZxxZgWqCGS775211c39DKvcV+/IsLUFxgk3UFS+wBTe6EfpZSk2lQVgZF/F2jmyeIszcwkp27teu1Q4nh/GrC1uVziMx6UdgBA47q+QqzH9odnsH5/TU8OoNam3OjNgytS1GEPwRS4I2Js7itzxD3GfcxABpWpWDnxZtrQ/I5VH/c7jzos5rwGGjqZR2VtzOUn7nBxfmPbhMoJuv0+Ssq1lihFf3Kwl7IoNG6RCDSlzkJ+Ik2aFmaQA6hLILPxTuzRyHzp61KKUT1OwiV4XjBFgKJ/OD8YjPouOGWxMgv/Uk1xsqbl1bTf3ob33uuhMKsHswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsfgBSH70Jv8tYmbFFimeyKqhYK8FOaK4dygOAAzSp0=;
 b=VeDAnY2a1QhJUg1ySZ/B/aDY2VRp3YPT08S6KHGxZx5FdT+BrCm6qnKVDp2ROo8RLNErWvUFkgKAXy3mjXP3Wjb3eGiS61afsaX204DnRgqEfE189ElpXmfGkZT2LF+Hxq2J9AO/YXntSZqhkv7sLtmbjyzqToEHHjJRDVbnHoXwh7Sa5+8ZJUXAnh2A/yANNPG4g22+rh8HQO0gE4gPfVR+Z/TO0e1ONlfaAqDDyvHm9rtUPZ88ph3zRAVP+Gn3ZFLqJio+reV4MRnkeQn7dXBNNOB+RmIO4tNgfOB/0NdUbBzjNNRxUym5PLOag8Cn1RdjFI/5KB/leot7GrU5Mg==
Received: from AS9PR05CA0136.eurprd05.prod.outlook.com (2603:10a6:20b:497::6)
 by GV2PR07MB12239.eurprd07.prod.outlook.com (2603:10a6:150:366::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:52:48 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:497:cafe::85) by AS9PR05CA0136.outlook.office365.com
 (2603:10a6:20b:497::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 16:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Mon, 31 Aug 2026 16:52:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 7F7B320018;
	Mon, 31 Aug 2026 19:52:45 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com,
	Mike_Rudolph@comcast.com,
	Jeff_Howe@comcast.com,
	srichard@netapp.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next v9 2/2] bpf: make tcp_tso_autosize() available to BPF congestion controls
Date: Mon, 31 Aug 2026 18:52:30 +0200
Message-Id: <20260831165230.2696893-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|GV2PR07MB12239:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e6005b2b-c353-45b7-5a52-08df07804916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|921020|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FYG1UUTDstA/09tLWn+sS62ZfxZYLz27UkeKg9pj1DuPT/fh+TKqEfWavrrYAQOxtrVMvdXZ+l3ZqV5gOmsLlbrhcz/mXYO+jHhLQ9/NERMTubFB+a352RGyhk6CFCQzW9VhL+Qg6u5spkBVxlKNEpo32xZahz4/4QyeOxR7OtUUUMVe88QBICnIvpqqwldRKHdiyvpDdLD57t8jgGDbpO3wm1ZxttWTR7sqBa4onxQySohbbMCLCFMnqUZLznmNIR2lD4Ki1rmZlBypul+zEG8uYRW0qkVuPtgWYd/VaFI9Tq9cMLXE5m4yJyVZJS6Npp3FbPTvmzOfUP4nTSSy/0+1S1Wg7RME4Sxj/GHgfT9SBAOfRvXlrUDIcExLt3oW3h7+ft0FNf3tH9Dts/eXMYAUr+e08Dn5+fWU5kJP7BxB4XEDIxItFVCQuj2u0v2fFoKjhMNH9V30i2U0o5cgSMHLGQLWNQpYHpXhVsJCyqPWM1e2xg+ixzcThhaZNQ1Zvog1/HyFhcj5NjRdga7ZOY0k1c3uQ1NuoMfaHzLIOYazKTuNu+QKH1hHNvYJSnjvNvIitslSVCy9JkuWfu2lkIkPwGBwEtyD6X64LYi9B6MCOxZlsxRnbBTtO71izXbq01O0qGfo2wYIitSm0KuhR1dKKfUtSTuUE0XTvfehH1AYbRPGT0RMDS5td3telyM+GXHhir/uKgzCUpBGi5l6+xwXcWGWy84l0SpHO7IOpK9yhyaM5QnAsoPksfzbDdre
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	alLL4yuL6kqqzSQ6yL6CRBh5PGDsXQH57LsCECgB/2p/bTJP30sBe7OCOas8imIl96j8Dex4Ts4ds6RyJ8HISQcBGAWc00JHJGv6TMGOVBDIg4cK2HQsgRX011lTWp/++H3Duk/A7qr/m9rsxW5lciwIaSYXv4WS85XWr2KjczOjOXjyJxuOroYaU9ZQz7q2x7aR8zRVaXyzodIsKhSuzUfD/JfNJosJ9Cn2Qryt6rekx50EUBTrVRScVb/AUWWriHRXKkNud+1ZMrx5iGcQupbotSoGH9ijnEZE+ChcFI6ep9XLTRMIW/P4tK32FyVt9/aZ9UIm2Xl1GoNcBrclM/oINXSJTGj/z4Bu44uDN+EV66ZNkQbrvJzhFmggVgFfbYQvOVwC0zt3zEoAmRmYKopEJak94MVUc0+GBtU+N2HyCxaPfuZMhlKOQKjeCW0f
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:52:47.2625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6005b2b-c353-45b7-5a52-08df07804916
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB12239

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Expose tcp_tso_autosize() as a BPF kfunc and register it in the TCP
congestion-control kfunc set. This allows BPF congestion controls to
reuse the kernel TSO autosizing logic while applying their own
minimum TSO segment policy.

To make the kfunc robust against BPF-provided inputs, min_tso_segs is
sanitized to at least 1 and mss_now == 0 returns the sanitized minimum
value instead of performing autosizing.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

--
v8:
- Sanitize min_tso_segs in tcp_tso_autosize()
- Return sanitized min_tso_segs when mss_now == 0
- Update commit messages
---
 net/ipv4/bpf_tcp_ca.c |  1 +
 net/ipv4/tcp_output.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index ed4fea98dfde..9deed2244c2d 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -194,6 +194,7 @@ BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
 BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
 BTF_ID_FLAGS(func, tcp_slow_start)
 BTF_ID_FLAGS(func, tcp_cong_avoid_ai)
+BTF_ID_FLAGS(func, tcp_tso_autosize)
 BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_tcp_ca_kfunc_set = {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b1b493d46b9c..b7f2ee5e7a6b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2252,13 +2252,21 @@ static bool tcp_nagle_check(bool partial, const struct tcp_sock *tp,
  * in bigger TSO bursts. We we cut the RTT-based allowance in half
  * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowance
  * is below 1500 bytes after 6 * ~500 usec = 3ms.
+ *
+ * The min_tso_segs is floored to 1 to avoid surprising conversion. Also,
+ * BPF callers may pass mss_now == 0. In that case the function returns the
+ * sanitized min_tso_segs value and skips autosizing.
  */
-u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
-		     int min_tso_segs)
+__bpf_kfunc u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+				 int min_tso_segs)
 {
+	u32 min_tso = max(min_tso_segs, 1);
 	unsigned long bytes;
 	u32 r;
 
+	if (unlikely(!mss_now))
+		return min_tso;
+
 	bytes = READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift);
 
 	r = tcp_min_rtt(tcp_sk(sk)) >> READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tso_rtt_log);
@@ -2267,7 +2275,7 @@ u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
 
 	bytes = min_t(unsigned long, bytes, sk->sk_gso_max_size);
 
-	return max_t(u32, bytes / mss_now, min_tso_segs);
+	return max_t(u32, bytes / mss_now, min_tso);
 }
 EXPORT_SYMBOL_GPL(tcp_tso_autosize);
 
-- 
2.34.1

