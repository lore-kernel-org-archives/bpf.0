Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2F3CEB84;
	Sun, 18 Oct 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358127; cv=fail; b=PskGGO9MfcwLkAaSfNErN3vu3WkAwhSEVfEdRUr+aoqHCeQsnE2ryhJA8vEvnS7neo19D/mOWsnu/aP4IPsW2DyYNlt3nC2dyvo5siL96HmywEpMdmyBe0MbBh2xOv8jsRdZDbFHdKsCcFQRSAveE+IrBre+Ssq+Vh7bJERkTU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358127; c=relaxed/simple;
	bh=zyh5eXIt9Zi/DcM28e+o5Nr0g+xoS5bWCO8jVOBgfUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fLVF6qvpZW6kT2VTFzK3Ke5j5lnHUyVGSjhM7/FUiT95geHYBTShkHrEIZwY8XPwefyCQg97BECZN2gFysDBmA2rhOsR1U6COhsGBF6etJqlnCpW/G5FDetAvV+8hqTfZ3Lcl42WWzJbtkrm19ftJ0XexKYi2E+f2eSYldNpmVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bNJIYY5W; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bNJIYY5W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQrqVLRRmDJ7cC5+ZVIYFxT1YG0a2WizPXQUXGZjoCBiXpBEIQFAT7CDHuYe75EDm3FlpFJDj/Yd5WjjBGld+ZU8dI62ow4CGynQHG81aR6dqIdGx/IFVBylXJTnQaosBScHZRuMV37ccxn7QBQE9fT30xlzk8VEJzaNbB2K544DXbHiSjl77M/E4xXtzpS/tnadH1Ohh0ugiXrYPDokJEZA10O4nWcOuVU0eeb9N9zF1SlQXrpycLY+kFZyiU/op2+6vJa2xoN5lSi7XgqRN9HcCFqicdRgnht8vLdFSv0Sm0E6FeG/djprMMQ8wxCYTFe2Vq6abHztmmB+c0iyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xn821aYEP3Yc5lRpUsJRCMDfINfz6sGUxDOY5qr9w2s=;
 b=qhdrjsN568pRfsaScTc7u348aI7UAp8D8KPjaSA/6nnNpSf8IwsydnGpztlZPYtLI8iXxZKbIKpJFsQ6moCn2UEHB4y8nJNoKU7SOvcZ3+Y4nnkhNRMU9OGmxmWgJwun5t2nmu87x4xsR1FT58+4zDmjBsXYJBxl+6GqZalTjs4XJqVit+KIoBgLSVhHx+jsU2dW0WO74TiUgbvpk3b4igUMRjdubgGnWXoGkcBYuzIoGwPqT9DNi2PrVYjG+f3ThgYqbhh8NxDdIKxITQPGj4OhCd50LT9JDZexGqMOXarA5HfKNUhO4aTBiNhQMepvwicaMSc8NUFexz6JugYpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.1) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn821aYEP3Yc5lRpUsJRCMDfINfz6sGUxDOY5qr9w2s=;
 b=bNJIYY5WHQAPSx+l1fN3W+NT7yLudcX6JDLFGmr4B7QRejToQ0iLpa0VdF4Ff9S5/MEkLQxv8+BcwZYXkFYXrCOf3ZzYQ/1MN7DLWeItk2+CGr0IM9eLqXSznh5AYLKb0sfnAPUpda+4+JKyjM1B5ivDMkof3iI/MEHFHVZm2UhBTROxUpYu8u8z1QlXm1RJl/f/H44KyXHk+hQ3s3MqYZZ3552DsMyNfXVg6lluHppah3jcjuCgtNXwy8yK0u/K/Bf1f+vBm4Gi9eCzPS+Xq+r2vvdD4Tdr3xBLqSNM63tEg00lWzv966gccq192Y+zGcrKRm17cqloyE++CAK1kQ==
Received: from AS8PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:20b:311::22)
 by BR0PR07MB738813.eurprd07.prod.outlook.com (2603:10a6:2c8:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 21:15:20 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:311:cafe::8d) by AS8PR05CA0017.outlook.office365.com
 (2603:10a6:20b:311::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Sun,
 18 Oct 2026 21:15:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.1) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.1 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.1; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.1) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 18 Oct 2026 21:15:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id BD626800008E;
	Mon, 19 Oct 2026 00:15:18 +0300 (EEST)
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
Subject: [PATCH net-next v2 0/3] TCP Prague preparation series
Date: Sun, 18 Oct 2026 23:15:11 +0200
Message-Id: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|BR0PR07MB738813:EE_
X-MS-Office365-Filtering-Correlation-Id: f6de31f6-3162-45c0-0cd9-08df2d5ceab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|18002099003|10067099003|3023799007|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sDFrMrojjne0C7zuZFaLa91aFLvVA4ZdXwMe1tTdkm8UJXlMlh0MtiLKMrZSKmXI34HbSByy+nXWcMufF2zB9PeG6PIhlFnO6TAQZJt9uzeKWzrSSLX0m2Fy3GNx+wpk69CAuBzmIWZJnSJaE7rApWrVci4LodubhohCYIF3cy8ryb7k/kGZn039OTGv6OzkvA8JadTx6LS77xJfIlA93UJPfOjrkadbprWLZIfsplxwJyhJ+F37Ho9fJ96Ilct0H6wOTAs8pHMNznPh3ttXRJHuOixRPaJaN6MQJFL38IlN7HDd1zd0a909e9NMhdFYl6Rwh5JuCuezQDEU6THoulKC0nNbun3351l9m/mXpbl4KYOld/nBF7kPiOKBR4HlUWTZPP7UZVFqnAd4rFvUtwSI6eLNGpeXsLVnu+hm0kssAjLFKpxdlKN0FVsP6pHkpmbXBwao5SGMMis8I1djiPuNbGKmVbh02W2uMZ4G0OooAdfZcXkLVv8f5c/aA3m+0HxBzJ3oHuemeO0Ua67HBcMpSxne+/P+5Ck6evuxUZQhM+29muRfGAzLIPpkndnUAp2oVPi9cVu7IZQvv83i5bSN/70RNjpNxZ1YWVkb3FrgVnIQaJZbBq3+jPNKb8Xp7tYsjUdtSLeH6E+Q8bTJL+YOyo2prwA6xjQk38jm5G6Ou1odhm2x/FT8sVmlQUb6Ykw2y1zuxxEU4TwhaQKOFfsEbi8LrNAiUUrfvYcRCvHHexf1xWVqTcPo79Ja2Lh/
X-Forefront-Antispam-Report:
	CIP:131.228.2.1;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(18002099003)(10067099003)(3023799007)(921020)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y0s4wnYjtd0Y2535GihHWbXwBK9UGJM6OFAdF3zfatorne3ddF9VyovXTh+pQsL5paqwaIfnlwwzChbRXoYsY31iwTfIWQKw5mh6qjmIhf6r7G7KikeJ3pQSf8x2M12MpQ2Kb1PJ5P/LVsisR1koAXdd32PcTG7F4BxQb0W41UHQshcZZXKeKWsYD+a7HHPJtmZz/9uropWijGYsiII9RtYYaHfr0TTnyHUKc+7723ddU5Cz5HxC4QIN+B+PoqG/73om4BUmqwJL8Nf6qX79oj80extOWf00tXsWhAWUYlw+eF2zja6Gf+PzII6EVWGb1F+laClwRn4whUm6O2F0yJNjjVEZDCyvGhp46q0iwez0sVw+/XqwD/a4mZ+SJnnz3zE5iSsMrLwh4Kpns/ndW8fAZGocdooyZ97rt6EOLgsdcFp/VCw3LC/Fg2pCINdH
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 21:15:20.6708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6de31f6-3162-45c0-0cd9-08df2d5ceab1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.1];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR07MB738813

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v2 TCP Prague preparation series, and TCP Prague will
be submitted after this series.

This patch includes the following additions:
(1) Add ece_delta to rate_sample;
(2) Add ECT_1_ESTABLISH identifier for use with ECT_1 in negotiation;
(3) Add mss_cache_set_by_cca function for Prague to set the MSS_cache size.

Best regards,
Chia-Yu

---
Chia-Yu Chang (2):
  tcp: ECT_1_ESTABLISH identifier for CA
  tcp: Add mss_cache_set_by_cca for CC algorithm to set MSS

Ilpo Järvinen (1):
  tcp: accecn: Add ece_delta to rate_sample

 include/linux/tcp.h   |  3 ++-
 include/net/tcp.h     |  2 ++
 include/net/tcp_ecn.h |  6 ++++++
 net/ipv4/tcp.c        |  1 +
 net/ipv4/tcp_cong.c   |  4 +++-
 net/ipv4/tcp_input.c  | 41 +++++++++++++++++++----------------------
 net/ipv4/tcp_output.c |  7 ++++---
 7 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.34.1

