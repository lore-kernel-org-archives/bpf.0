Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0A46D091;
	Mon, 24 Aug 2026 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589113; cv=fail; b=IL0hX+wGMW2GpXhuGI12EtZMqF4i9DxhMJFnSQm38d2rLxpuKk45U4fESv+L3srm95ovc21OawblRBtwJrvlBh9BWfXqIwIZvnT2Y35MMsUUT86c/3qVLr4fKSUWZ5olyWjN6VRtSFcL4AJxbGF4bVMDIXCfGAl649EKdnJvEwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589113; c=relaxed/simple;
	bh=NjwsLEuLunUdmvJK6T/SaO4LxbNl9VnGFM4Ud6HxfiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leQ5PzyIXQ0VBQvEyx4+eDSvcsgDJXKGrD/XOicybAMS0KGNH1vO2tu6PRBxT3Unz/UiWnwiFBBMyHYc4n5w/8aiAieoD13Hlfhbo+I98INAPVOZ/sVMFUqVggO2T8UAXcfrOv3Upm53y8ZfDMlufozgACL6+aJDjvqL36LCRi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AwFZDWa4; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AwFZDWa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVrlf4URKqS3R/948OOlMMofjIj26uT39r67yvZJMjD8hTiuHwTqqEH2hwA/6oa2v5zGaYIXKVT7JqyrN6xVjVfSjOyEcKKdmdMDmFUegHgCfkJSNK+evVC58XmH858u14cNdFsCgESnAk5EpSn66Q9zvFWDY5MEJyDlsiwnmxDfQOB+D85xBRevrl4CdYwWYXaHxoXLHe3QfVs0H4loKyN4eDZhnloMhewUAerKqb8EU1i90wWqAaD3FsTDQ8evul0rn5HjF1Y51D4x4HT6qVwg8XhK07jbUDA0+pNW4pbaEuTaaRgscw3xVnNcojdRk/LLmLMj3bdfmSv25XWW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P17JZCbYtqGmSnLcMEZ40rlWbbYigRdYO61uzNEaqyc=;
 b=M3Flyqt37lnWEhAkC429F7Gg03Pc31SY4OI3EKw23OPh1u7A/XLVwvlXSVe+93zK0So+w12BF52xEOSA6xVb727EfDLSS0XIa8aX0Kd3GvydrgcaaABcrF3qOSk2GB2OK/VpLHEH12Ho+8KolpNh3eoVPuqFoMN/lkqhnP6DSfgqZe38i9Q3FV50HZdnfn+L0tnuV5oDM6444TdC0RLOCC1fzwyVCf9+Ex5YfmOnjfx6ARnbXzkN5KH4EMsGiOY176wGOaPLoyT9Lllos9OajVK3aJfjdtHNLvjCombChpNEPhmN3tCXVNqmepfkke2nsYrGUf4BqLlDR+K7L5DCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.85) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P17JZCbYtqGmSnLcMEZ40rlWbbYigRdYO61uzNEaqyc=;
 b=AwFZDWa4698hkY4DdjuVulydWZf702kS9UR1SRCGyasNR5YMAQBGIhuyFvT9GKBy22v6e4ZETKqDXFKfMsjlbub1i7gtqhDrYC3hb61X6mPeZASFrtTnQeEYUbO+A/LiiK3tGuP6zZpbRNPI418I6rnN1U2nAafyMqVAVnJXvWrchQuVGvV8Xc9rix1P8pEYaOg/JvUqp5kI42bndVqda1cgrO5A4dsVRyjVhmeExc69TMEGE3S1jgA7UpEakSUJF7tHjKljC8vUad1IEgX7HVGObiGDrVrzKaUjQ6Tskhu9FujjqqgZP5g8OjbaW9rKJohwYtMET9bmdj4/pydSVQ==
Received: from DU2PR04CA0260.eurprd04.prod.outlook.com (2603:10a6:10:28e::25)
 by BR2PR07MB997840.eurprd07.prod.outlook.com (2603:10a6:2c8:14::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 16:31:48 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::22) by DU2PR04CA0260.outlook.office365.com
 (2603:10a6:10:28e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 16:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.85)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.85; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.85) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Mon, 24 Aug 2026 16:31:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id D8B0D800009A;
	Mon, 24 Aug 2026 19:31:45 +0300 (EEST)
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
	vidhi_goel@apple.com,
	Mike_Rudolph@comcast.com,
	Jeff_Howe@comcast.com,
	srichard@netapp.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v8 net-next 2/2] bpf: make tcp_tso_autosize() available to BPF congestion controls
Date: Mon, 24 Aug 2026 18:31:39 +0200
Message-Id: <20260824163139.990734-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|BR2PR07MB997840:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d3ef427-34a7-43b6-f12e-08df01fd3175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|921020|6133799003|22082099003|18002099003|11063799006|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	VgEUjj+CsU1yzMQFtQfs/S8dYXXjxkLYlnrEunpLucKLJd3UUrWZoQCyGwJK0fwywIRpFDfxRK3rLEXXEmBj/01IdOUiuCqWak1GVlBI7i26uNna11lhKMTc2ud/hCWsTM2XMloP9rJnZpyx/qwwTxu/3HE4JDe+rRyAjXuEPv7xWO2+EIklb0tL582TFubhBLLDkv2MDgzLDQYqzbAIsP47+9ba/HPlIxTo2vUkQThdaGKjyOtgYDQff1VPH+vOG4mUBsxcNu9NpP5/4kfQXdAmTtfpH1/N9hJWzPYQNmoN5qqvfDqkxgNvP56TUUg2CQ5Ho3G38tzAAPK0S3uvx8Zpv1AjWtBrik+Ro9aLYGmd1PZa4433p1p10huBtbn+Yq+qaoVSVg2zOIbPE3PreW9nsTPjMVSuOp79uzc0Uws5al5wLirTzYqkuK8H5Rsp1rgsko3Ia4+s/gTHKiEIUxnwNHeqU7L49dkZV+fZAsO0nOxwxK8fXg6V93EDUAlEyGvf54PG4zIlsuzP4PpmBhBExiDxxUH//Bc3EeOySADEA1vhZnPSdE8MB9wnJu220Ys7Lmfeera7mM9PUJOu7Rba9/8QkOuRWc5Z4LoP029fUFPlGzNrOCimDqGXXDyL4HbOsiBz2oAnWSAIWS5ibzj2dBmWG3xgrcz6Es4znLlVEVntYrgUQvYxWoOVbx4nHN1uUxqMAg6F14hOQOWfZwKaZg9x7wsLlQ1imVSuSB75u4RjrPgqn+8IGpvWY/I8
X-Forefront-Antispam-Report:
	CIP:131.228.2.85;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(921020)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tjbtThVTC8rf0Ftp0SmNRlnrC1W7wj2BpvQigOzm4zeC/Il890QcmAc4zFLtVhr8bbhAU06z0fbTLNzKOBEmd1tlwlPYli5dHQYiAYb1fdZDgTmBmAJoizBTkaQYjxFdKF0yDx2+cZ4CiR6/wbEkG7GsLEG1xCWrtIutf32kSx8M4LkWLgjAmAsqWRnoSGGJMFtqjk4hV+Rnm4IiwoWTNn7jGD5x2M5IcCcev6kTN61eXQbQENP+mf2cjut8SE2kjlx8vzUaJoLYyWXclIniOAZnrMnUEI9hjCJtnLNaD/qGLg8O1PkXZZ074Ug5fEpPyuv0dueIt1FvO/diLY7VKdC6u1gvW+Rv51jNH7NkZhqyhCZRMSSSHSEAbMvcRaN7d22aPRc3vbtBwIliRgNYkUCXLFA/+XWgGJuXfIsvFLcckHuWOibk5E/f1kxLT1s5
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:31:47.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3ef427-34a7-43b6-f12e-08df01fd3175
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.85];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR07MB997840

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
index 7d3e0e715c4b..a98036bcd987 100644
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

