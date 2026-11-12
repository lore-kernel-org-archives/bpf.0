Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.37.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498882;
	b=5sH2UkB7CDf7IGI/4e4kV4hxXPIifOz9EGlObaSDHrHIbTS/4OMVGOAXfCrF79Rg1MIU
	 tBb8lgzt7/YHLgda5rWuMe56QLeGw+3kr7oEpHfnF8+csAkJjHBmCNLz2SjWEeOSat9Bc
	 KhDQt4GO0Xjzd4MWZX9EyFI6QztRZAJavuaECLc1USrRTbyK8iswObVySrmt7t3JU20Nq
	 HkQhh6hOfecnqbUhG43cxkIS8j+9tTFy0EmZVSeZE8FuRUjtAQp4Fqh6FtzZdbDaAoK7K
	 bqvJaWVBwthPyDSf3RqI1ZDMSRZcnMvqsobdbexlRYZDS/ke1sp6uMX/jTaN9c7U5/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498882;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Em2O2PA1Nkm4HqW4nMs7oTvR6S4yCqOBNg32g718jfY=;
	b=O/ggzDbr2XBVQZkYs3EZFxsgHxkfAK4SBsdkJG572MIItD4DffLrYzus3ZcPCyTiM3mV
	 3uvQ2rjuXk/eFSYfRstZSQDV5/dsNcra5ztLQPUZwQiPl1qmsXEMO0YK2h1ooCRn62GCs
	 5Hvh/RW3MQC/nbtDsyCYwIy5jZx5O7shNLhgALmQzzG4lxSdvXz6nwpYAB07eEgL4Geeh
	 gI8zu/yy16EbYnRyK25iT3ESmaX3x/IeIR6/co2qhYyYY388yoL59OQEojGYf9TALFUJO
	 nBG++JZq3LvbAb2nrZqMfY0gZEiEl+nT0hrWdCggCGUIZRM5rnyCuW4sOauYjbFizZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=egKd47zS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.37.25
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazolkn19011025.outbound.protection.outlook.com [52.103.37.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610ED606A33A;
	Thu, 12 Nov 2026 15:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 610ED606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=egKd47zS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCeuGN786pFY6RjfjA4aNvdPmeOXufMTa0SLtDKe6Oj9fjvbrBVIbrGpU8v7dglHMsThcuEU948Cmfi34g+SR0E9sS/x6eS7b8/Q1sDn9/tTXo0teA+I3qSy73D/acopTdPSJKzf7UKYTA+sD1e8p4bLVmfPNi3AfTc4+yamV6y2dlav1y8jLlXPdcdn/VtWv561LzBKaxM448OGmaOCtLkGVFdSoVrs0xbtK8Bx/ijFDXDu6R/bbilFiiVc9Pee7NCJokJ70z3Zcz7ndLl5sqtszI0Y86bbIQFoZK4P6ReFX9xxXkJ6yTQsARhUvd/2s9odnb5OuMt3mTef37ZtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em2O2PA1Nkm4HqW4nMs7oTvR6S4yCqOBNg32g718jfY=;
 b=A4LkKcsViYH2WNW+VIwPLtY+9xlhPFzBCqLFbs1aKi5b0Zb+vSYfOZ5KTtqlrjZH/NE9bgo8C7HQsUYKsHYevhzJBeTEoqzd08v0ilptlXr+syofAqPijeQEYmAHSybOpjcS8X2S/SbLrjaKDJKRPeH6wP1r3Kz3hj/PicwBAFfJRz9Zf9g6c0M7GLmCWMINV9X1Ir3x9SOuNp6wxbHjon5KC3AmHD258pBQeUvpNlAeKw6mW6V+Xxvnw/nRGZFlWMRhEGUqK/MxcKRac5QwtspeMMX3ocO710arzi0zh4yglt/VD3taPaAGhVjrfbagTEFzQg0FrpjYWQ58KIx8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em2O2PA1Nkm4HqW4nMs7oTvR6S4yCqOBNg32g718jfY=;
 b=egKd47zSk84Gajl58nHdO3K1J9G0Z3wVR/dotQLETdkAQR4KQT5geH0rLexQSgvT9/ZGm/KXzZWSsX/MUbQ1q9mnhyF29a75cILE0Euwwj/yOgvD1NgUcArs0dfq8YZLYuuzdzgET1hjmu3W1Vughj/Wb2kvmnfKcjEAV/eQnxZaKduzX6pPgThhoSZ67aX6sH09mfsZ1E2f5deJ6NTb68qYs/c8xG3bKX2YQUGSbtF7GQpCdTO3No7hAmuQQbqGKWrZRcTObG0mPcSuX9L1bxALfmTs9TXk560c/ArbCnLOulNAOq54zoKbYKH8w0YTVhA+Ho2u2Dl5JB1n1CyOIg==
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:378::12)
 by LODP302MB227602.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:4d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:54:40 +0000
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4]) by LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:54:40 +0000
From: Adethya Srinivasan <adethyasrinivasan@outlook.com>
To: bpf@vger.kernel.org
Cc: Adethya Srinivasan <adethyasrinivasan@outlook.com>,
	yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Check writable iterator attach to a read-only array
Date: Thu, 12 Nov 2026 15:54:07 +0000
Message-ID:
 <LO2P302MB019736CF58FAA4C98C6F78AABC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <LO2P302MB0197C0434BCC2A9031E99A18BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
References: <LO2P302MB0197C0434BCC2A9031E99A18BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CW1P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:290::19) To LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:378::12)
X-Microsoft-Original-Message-ID:
 <20261112155407.136041-3-adethyasrinivasan@outlook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P302MB0197:EE_|LODP302MB227602:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a50cee-92cc-4aad-aced-08df40d542a2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|25010399006|24021099003|51005399006|19110799012|8060799015|15080799012|23021999003|5072599009|41001999006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T4qjsxj4wKdQ07DyJmyXZxvaxqEfu4jxtmMl/MqijTtVwI8jZ057Qtrst6t2?=
 =?us-ascii?Q?bTArvDq+D54PfRWqJML5x4sK47i0WZ1HPGAscVk4QHjQVx3HDmkvQztZK8Bd?=
 =?us-ascii?Q?vBgF0IiKJvKeJyBNS3QOZcaaKHT728+MeoXqpp0DnhN7mNa1MXgZsGYI5Dsq?=
 =?us-ascii?Q?vrrTrrGjCjlR0QRmh1BPbjlM3OpQHbA1lOkTelreYb+q6vsJq71jD0B+5s+D?=
 =?us-ascii?Q?u71kjUfxnEu7bnjTLwVMTRmlr/JnahG5un1S0oTU4beol/UOTl8gpM6IaM1w?=
 =?us-ascii?Q?SjkuKISOK7cyO6O1b3ekqi4wufbyeYGc/NOKwxI4NLyZbu3XYmpQf+0sNvIy?=
 =?us-ascii?Q?gwYKABKP8SubSqyHABZWpjk6U6yBhlagqSchDDUy7+c/100cJLyAm0VfLcO4?=
 =?us-ascii?Q?ZPh6EzoyPkdVqhtewgiYeHZkBzR6fm6HZJszTE9wEtZQW2Nvk0+b4dnHJzKR?=
 =?us-ascii?Q?JAnhflEOj+QIyg8+yw+W8QAAtZkkHoJbkkH1zGbhL3+sKSVs/smJAGt6OjEg?=
 =?us-ascii?Q?0XaQi5EBU1k5dGj9B0+A61dvV9qYxc9qTXLm/En623T2Se/1HFO9mfx5dqe0?=
 =?us-ascii?Q?qrUCYEMjFGwMmgOzWXVBx5D7DkUD12Jz3A8to/oUjD3qEJ/7ZXFuO0WPecL2?=
 =?us-ascii?Q?xHoBwrcWjLc4cRtAYO/wBbLqfy+sDA7am9xqohDHXaRKH1ndmYUDx1S8RlYt?=
 =?us-ascii?Q?8HOuD7qCeL2ZfM3QTJJ0FRToyTeVd2Nsx/Y0eBhSsq+J3kY4T2r3cgvpj86y?=
 =?us-ascii?Q?OYwaVxlEGRptEu7t/ba5NpOXCfHmbFPPUu/Olk0wWCQK/VGsArBv/6v7mbwU?=
 =?us-ascii?Q?vevFSPZN1CEhKRW45rjtxKrsQ0HrICi2sRcCkBo74xoplpujZNen49N3wXri?=
 =?us-ascii?Q?9v3wR+My8+dckT5mWihepAHcTspGvxInnf4z3U2RDjXPiyTkXgakyuXn9ALv?=
 =?us-ascii?Q?TfdpzsK7IExzCG+NiqeHx6EBgJaiGj9B/p6CiuF1F8BlI+sKdnmUFlKkIK9e?=
 =?us-ascii?Q?/LjH?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6bzbs/hlrpHbmAWMMn20kw1gjBsUdRm1tfnEnpMwT6eX3qvcGW43UwQslGj?=
 =?us-ascii?Q?wT3tguNERhETSV7bLmuVjq5Ui8WNMAaeYlYqA9750+wR/YxAZXjdbcuGrtsR?=
 =?us-ascii?Q?QDYlGAxRx1TExzg02Aqz9svewd/ZT4N0Yl1eljgK2gJFD+HIp1N1VAO+zXc8?=
 =?us-ascii?Q?9J9s3bYaBR2wtHN69kA7T/YuJ+eIwQnxcKTGnzb8331QR8afpa2wGrAkpfO8?=
 =?us-ascii?Q?y2LqXYW9fheHGXY6s/vsovj+UUiamUPariFD3baEWLYnxti6vWcyZyOkmhhL?=
 =?us-ascii?Q?N9b93TGc7g5HdnbZxQh6240LLpa5k4YXRwhoD8wrXjNGy1wJyjJlqh5YtCLX?=
 =?us-ascii?Q?fpfEXE01OKHDY9PCMWPwlnlXbQprhg91dMy0NvmJzzVzGZZLdP8v8bgNucpa?=
 =?us-ascii?Q?4o3jvLdnzjuZUpm2qicQ4FlWIlPwYHeoxvHRAyOTVgG6AUFeTbteJzX1L4H2?=
 =?us-ascii?Q?hSBcB/0KU3GdEIp7+AczZk5eyH1gOn+J2R+ijx2myXJ9OJjHrMOGNJhOGSbf?=
 =?us-ascii?Q?EucNTiKtC54BT9nZ1yDEDSRGnlALXVul1zbBz8sPmhzgjVz0401xhBhrXBhs?=
 =?us-ascii?Q?CQ/WPyXNSozQR5eo6TctLDZDsrpFieApM49k9Vc7By8Ugj39QwXimEhSURbP?=
 =?us-ascii?Q?as/OeCnKDVUoHhociA8QCT0fK/zR63rw/WEaI1E2bFCFDSBZ3Z//kd6o711r?=
 =?us-ascii?Q?2wdRlbJvBS8RnZ6Gf3IrOudMhd4AHUSYxBIIi+spq9HMkKU2FgduhRGL0cb2?=
 =?us-ascii?Q?87idjK24nMaUXzxQ7/k9Mx4C/fzm0rFzxyWz3nBSlVBtoI8npXrU4z4OoyP7?=
 =?us-ascii?Q?lC4fNsiCNUO1Cn8gr/R8ByO0B+wXVQ3uk8MmPMC4xPLOT3ot1CdSrfsTYc0O?=
 =?us-ascii?Q?hKfFL6dNKTuI/D+xxGAlJKmEoV2z5ndqbXEYo0fZKaznQi0Qpdk9th1UD4Ty?=
 =?us-ascii?Q?eFf5vFe8BLq3iwh7EQ/dURzgu7XsrprAFZDxm0qYoHwTZ3ukMD3BO471gC16?=
 =?us-ascii?Q?yDfFy/qm03FKuUhuDOQWGyOskoLtw1EFRjrEhx5I/5NeVJ7RJRp8X8kZDfUt?=
 =?us-ascii?Q?N9JsNyo+Y2v4SzXfUD6d+LfN7JcKa3kyT8PYTQ8s6hYAZWop9g4t3kPZCFMI?=
 =?us-ascii?Q?kQ1vaRUWKJsw2hdzv6qYk/5ldO99UN4sgk4MFbQo0jHdjs23BABwSiSaDXqZ?=
 =?us-ascii?Q?lS4wiBhiziCQQjhtKkPL0WcmkYHv3+3e9QEM0oW51E6r1OsHamI5R+6eZiBe?=
 =?us-ascii?Q?ut5Y2lBOxAEVGGg5EjuPNTgsnNMMPE4qU3h1wFBFtMPGO80scnh8wDIq9e6i?=
 =?us-ascii?Q?4G7Y+YNaRmgYg2eemn3W12Ho5zgUL46BVmXJJvZQkwUm/wil0V2vvQswAuA0?=
 =?us-ascii?Q?wwVeNKAqWYnxWR3ZR7eFowAXLuBsDSp4pW2wuUXzWA15f0grxQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a50cee-92cc-4aad-aced-08df40d542a2
X-MS-Exchange-CrossTenant-AuthSource: LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:54:40.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP302MB227602

Reuse dump_bpf_array_map(), which writes to ctx->value, and attempt
to attach it to an array with BPF_F_RDONLY_PROG set. Assert that the
attach returns -EACCES and destroy the link if it unexpectedly succeeds.

The test fails on an unfixed kernel and passes with the fix applied.

Signed-off-by: Adethya Srinivasan <adethyasrinivasan@outlook.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index c69080ca1..5249b07cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1100,6 +1100,39 @@ static void test_bpf_array_map(void)
 	bpf_iter_bpf_array_map__destroy(skel);
 }
 
+static void test_bpf_array_map_rdonly(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_array_map *skel;
+	union bpf_iter_link_info linfo = {};
+	struct bpf_link *link;
+	int err;
+
+	skel = bpf_iter_bpf_array_map__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_array_map__open"))
+		return;
+
+	err = bpf_map__set_map_flags(skel->maps.arraymap1, BPF_F_RDONLY_PROG);
+	if (!ASSERT_OK(err, "set_map_flags"))
+		goto out;
+
+	err = bpf_iter_bpf_array_map__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_bpf_array_map__load"))
+		goto out;
+
+	linfo.map.map_fd = bpf_map__fd(skel->maps.arraymap1);
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(skel->progs.dump_bpf_array_map, &opts);
+	err = libbpf_get_error(link);
+	ASSERT_EQ(err, -EACCES, "attach_rdonly_write_iter");
+	if (!err)
+		bpf_link__destroy(link);
+
+out:
+	bpf_iter_bpf_array_map__destroy(skel);
+}
+
 static void test_bpf_array_map_iter_fd(void)
 {
 	struct bpf_iter_bpf_array_map *skel;
@@ -1770,6 +1803,8 @@ void test_bpf_iter(void)
 		test_bpf_percpu_hash_map();
 	if (test__start_subtest("bpf_array_map"))
 		test_bpf_array_map();
+	if (test__start_subtest("bpf_array_map_rdonly"))
+		test_bpf_array_map_rdonly();
 	if (test__start_subtest("bpf_array_map_iter_fd"))
 		test_bpf_array_map_iter_fd();
 	if (test__start_subtest("bpf_percpu_array_map"))
