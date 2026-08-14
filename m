Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC03BB695;
	Fri, 14 Aug 2026 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728660; cv=fail; b=Ty7MRcqv3gS0B6O6k/+Op8d844zeCrJWqgoqHIX+2n6rIbi9QF2XIMu9/ZHyoYbgayS3OwKtQ78PLBae2RUqrIiDZ5XS7fNrYB4ucG4TmEIzk1vhslEtn4FhNNZm6cBrS3n4JyAE+IOqT8aVI8jSsKXeXYNDsBp8B+N2+5G5JCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728660; c=relaxed/simple;
	bh=iuQc7wS9iofRoSksNhMCD0AmPUoEnofVjbz1Z2HP0JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbhkxPdo7DhnKMTWtT/7lXDypCvwan1TWf7ug0LIRoS3LK24lMuZ44XUEBR6v/5tx7AzqjKu7seZ6Hrf/+OTSW1UU3kJvPsjoCm1z+X+9ZGKcyrKeLYudzfi9FHPsdooI2GIVsFKJ0ESqlX9eWZquj58olTNl5bSfTJjFNLxX5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X6t4TTw/; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X6t4TTw/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJtWelcUiJYqUonqdbAEayAYdPXEMx/g16wExDW+V8+an6RPoHUJtUkGQhwH/b6EHWSB+pNR5WQzhmSc09819uQ3Vys9b6gg2zxtev9k3efB1qnuzVLn6ccGkMbfa2n6eCX5yMuEEg2STMin3ne+keKsDKoUYXVUMTZYX65IfCj/J235wRsZQ9RjkCjlq83mkF+zqdhCsChRKZWFYL0Q33ZS3o/PBoVOhVmTkzufH4SJFx6QUWlh72OQwWq8HAb5bH3n73TwBld/Wm3XXivz7Wr2GD4/UxMaK4J+qCyJJmRu/uQ4c2QmGUb31mLy6nFNE4k9g+86GyBfhf9klVRcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQp265Ci3MzzT5yyzY/RDTL8IA1Mg4g98UNx74oUfKU=;
 b=tL3+y7A4yq0CqJo+1Ccc5wrsOu6bRSzL9P0sxBsQXmQ+tcUHrd0sWakVv1lA/InYnVDCmpcpxWKU0bUIQrv0Mps122pZukRTu+eoOcsbGroJdWxdpBl2f9CJvU1LXoDw35lbiOS6XXioylwe0HjmD9gNn2Ms4XyoDC1cCtEAQYxYUYZbi6tgh/gsXWnBWrRr3OCtBPIEiZb1so/CpLtjY0OAGWXFLFiWkRR+YkDS/Kf8uCzvzYXPJkuFWWu5l8KF17oorw9qYTkS0D+pZ9bJSUeXmVhEYugxNPGTweHvFhdOBQwVsG3JTr2JD59Mf60sUKDE2zyM6kKbIz9jAtNOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQp265Ci3MzzT5yyzY/RDTL8IA1Mg4g98UNx74oUfKU=;
 b=X6t4TTw/tVj304LVspQwm1mKuColQJ16nKQLohNVZsKheO8ZLFc1ZjZdCsZLb8CsMTjqveds7IDkj+YlhI4Oil9vYbSGw1LsgTUqYgnQu44tBnKxljSacT7vDFPzaMCyQwPg6F5HaovAbhqs6jNKQOs+GO2bsH/y0fbLSzmV977UB3EtInbibWG8b5lqrM0rUSUekDUqm++rkQM/FW8bewS8hFOMtyVFueAUNxcGd96yPAWDJcDqnIP7Pzenn2tCOuUhuriZ/Vrp0sZ5SiTiDoG6kqeaXN9gWYoUQfegz/kphXi3vPTVefz3bFKStRH6iuRnxn3tL/Hd2Nn9iDaqYQ==
Received: from DU2PR04CA0076.eurprd04.prod.outlook.com (2603:10a6:10:232::21)
 by DB5PR07MB11907.eurprd07.prod.outlook.com (2603:10a6:10:64b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Fri, 14 Aug
 2026 17:30:53 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::41) by DU2PR04CA0076.outlook.office365.com
 (2603:10a6:10:232::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 17:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 17:30:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id C3441800009A;
	Fri, 14 Aug 2026 20:30:46 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
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
	kuba@kernel.org,
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
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 2/2] bpf: make tcp_tso_autosize() available to BPF congestion controls
Date: Fri, 14 Aug 2026 19:30:34 +0200
Message-Id: <20260814173034.749151-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|DB5PR07MB11907:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1edb900a-3941-41bc-9385-08defa29cae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006|3023799007|10067099003|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	CFwE1P3FPctoLLWnaqFUGO3rRDIYvVm9jbWkaO7SPrimrdKYShnETCCwujtQVaoyrt4MMd4Bbz8jMyicZv+iw6UV59aoTP3gxjXkgiI6brLDom60NdHYljasZWM3Q+nkJDl8ZEGaUYhptbrkl/DRnL9w4HhB7snR0eTx/SbYRf6kRdBgHBjug8ly9iunm39D5nIgBEnU39Cr4rrktSa9kSjvEpzbvgbI/T7/02J4nuJhT5CR+xDcy/OcdzaFp7pgVEHRHasduCaib/MaXELK+OBmBZcLwSWNRBbB1kzjLSCAGUFpKBel1lFppXIfOyeF3mRPXy32khUhHmp4ze2L1z7e5Xl6GhVVWZtSvjeNQ6cPh10PImw+FCJmSM9wo5TdkLkOM2AWR1XzxFdDxTOHCArhE/AiNUXfftrbmXd9MTJew8Y25uR2V3qXQNebOzl/MyQTmCAx8bM4DfPKY+hkYTEfX+Qovt6CfwS0Yp3gmAcn5B+GSRuRB/GDfDixH5tLDszISlyDp2l7euKm2+3+qoJFUt0k77QIte1VC0kT0YnTfij9zXexOjw/4ndoEiNG4+wPGjKYQWMSv7fV04qURnGpJMYVw8muCHgC3hjg8US9w/+Bbaf0kMAvXQ33xgW8di8itXKVZqLLfk17Knd71dPwf99MVSGD2ZdB6ge+3JNWWCX02emNLVR6pz9RSBCGVuOmg4yIBkQGndwbcujXTRvT2z1qq4q0NGmK+ok9EiOYpaavngWV4RxyaAw/ZjKl
X-Forefront-Antispam-Report:
	CIP:131.228.2.84;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe01smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8I/i6VgBQR7rDA/a8AdZVHp9V1NAfO6Hy2DHvIeUyygViV768Ub6vl0nw0At9MzIBfDkcbBdmj4IoN8/tPkZZwa68XG6qaUnIaaXhB5nSoKsmh4ZBXynmLg8Zf/5+gx5fPw0d0BSfin2djsrk/B2x+iiAhQDHcRVo6NLS+SqC74/BSgNiAqLBszNrKKsVbrLL/N0UP/iZTmkYW2cGiENPY3RynVOtvTswT+LyAElsaFRPKUzDIK8H1g0UpjjXE/DgMLVLk/G/Anx4mXiy7KEbUp0aB//A85EKAczOlDzB/pkrrFtp4U47bHljaIywRPRBWL6pnonjN6be0s7Xo6ppTNKzTILTvi5CPkwAmte/dQIbUzFdT4L1X1erWukpXCZfDqpY/n/4AUYu7pHRzwG/jCaFfzy3bA3F78wi+19HTmb5C8QkbcbnqcREoW3VB1f
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:30:53.7057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edb900a-3941-41bc-9385-08defa29cae7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.84];Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB11907

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Expose tcp_tso_autosize() as a BPF kfunc and register it in the TCP
congestion-control kfunc set. This allows BPF congestion controls to
reuse the kernel TSO autosizing logic while applying their own
minimum TSO segment policy.

Add a selftest exercising tcp_tso_autosize() from a BPF congestion
control through the tso_segs() callback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/bpf_tcp_ca.c                            | 1 +
 net/ipv4/tcp_output.c                            | 4 ++--
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c | 8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

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
index 7d3e0e715c4b..7914287dd571 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2253,8 +2253,8 @@ static bool tcp_nagle_check(bool partial, const struct tcp_sock *tp,
  * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowance
  * is below 1500 bytes after 6 * ~500 usec = 3ms.
  */
-u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
-		     int min_tso_segs)
+__bpf_kfunc u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+				 int min_tso_segs)
 {
 	unsigned long bytes;
 	u32 r;
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
index 58262e490336..c0f8f20f3052 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -28,6 +28,8 @@ extern void cubictcp_state(struct sock *sk, u8 new_state) __ksym;
 extern void cubictcp_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sample) __ksym;
 
+extern u32 tcp_tso_autosize(const struct sock *sk, u32 mss_now, int min_tso_segs) __ksym;
+
 SEC("struct_ops")
 void BPF_PROG(init, struct sock *sk)
 {
@@ -109,6 +111,12 @@ void BPF_PROG(pkts_acked, struct sock *sk, const struct ack_sample *sample)
 	cubictcp_acked(sk, sample);
 }
 
+SEC("struct_ops")
+void BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
+{
+	return tcp_tso_autosize(sk, mss_now, 1);
+}
+
 SEC(".struct_ops")
 struct tcp_congestion_ops tcp_ca_kfunc = {
 	.init		= (void *)init,
-- 
2.34.1

