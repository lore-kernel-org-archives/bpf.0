Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013049.outbound.protection.outlook.com [52.101.127.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917737F8C2
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990063; cv=fail; b=HY+VzlxueFpNB/CpRhgpUxSLTF8v63KFxSwqkrkADAiw3OY7OI3sJdUkDL+So+wel2jz5e7bU98S2eSjtNj2E4Fmhi+6HLYAqCDtoi5WxSepZwvdJNhOHLGqvdKi9OGHG1er4s7VZtiPRZ96/ifVKI14/aB8RDZDIR3DsCrpz/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990063; c=relaxed/simple;
	bh=XDA+bJCniy21ZKt+Q86CNrzx5X1lRqXixFXlJtb/n4E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pjXzLSU++yOyokA3fxg85Gfpj9cAFDYLy+ZaGKJAbVyOzF6VQQHgp8SqFH/VQ3DNI2l3qL/eHJ1j/vuhTw6KyXpzcLDEONqeknBYu0IIP3sF+XZqpO3M45tWrY01IVlkYwsS9ITeGsw5E7nzRYHmV7CAjw1p6USvPL6goI7aGdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Mtun87zZ; arc=fail smtp.client-ip=52.101.127.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Mtun87zZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akxxPHS8gf5uotErSdwoYTIy+fRRyRVooJDKoa3ud+fgpuWLB+ydbh0T/RkNCx/Tr+B89A17wxWUedwqjM3tiCwbkEdJn2bKLEricPMW/TaPSE2HJ2BXgnIM6M7WoCn3umXbIt2fH/LQloBi/58ahKNY1X2gVkF8wGcLMViGoIsyzesREDOEHlkpqFwqI4o5AjjEXEcsr1L04GkH+6ZARtE4FJTA19pkYhk8Sr0HEjzV7t4HqKu6wJJalgX9DMe6+/JBwzHl0KKuG0C/q1d6iNw8GQNetC5bu0+g8SCa95mXmqtCR9udPAuM5nVZyG9AhPXC30CYG4EuWAySilnPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxMmwyqzCYhft4mbSbxs/IHFY2NUUd0Rf9s1oo7qjak=;
 b=n7ociFKWil12smxbSE2Or7dpQ1pgx28hM2kkWOsgK4o42g7Rz2sE6LZeyglqlG/bqUgm/bc4Bg8PfHMqa37l4TqqUUug7vbOK/oY41of2GgyPJpu5XZk1TGsvNubfXIRizC6Bt9pQBGcigNvn2XjNBlkZWZVPhZghRyZOSdRGPAqhVK8sFNzYwNiERZBD/8nCIIVIrq9CDPJgiwEj3giyvqCaowP4W873cdmpzEqIDNxCqc3rNLuB1XtRa33EF0LpU2n9nv5g8RaWcrSP8mRcMfWIhVq5WSbSpDSWGYCAbPIO1CV8XYSRHOrGylSfAvs0x2PQpcbUeEIPy6wv6aVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxMmwyqzCYhft4mbSbxs/IHFY2NUUd0Rf9s1oo7qjak=;
 b=Mtun87zZx5uDe8SwDmlGQWSZyVHVbpyAXsXMfqASyVL+CN4RmOuXjYzSYHjoTL0CHDNFfuNA6nfNTyrzvy6se/X+n+4QQWqM3zw13ZcxmEXJSGT3yqLUPfD7lCZgIHO83djGjfmv/ieqjDUb0/GglV2H9Rgu0PW8kJYT7btY8MF8ssKKxV/udOfKS2l5wJE/s/8PCniSjTQdiW112vO4d+rkeuirdAlGJhNljJnomYPC2lRM6iQc65Lr2n3xc5WAqo8EAjwlXhyPxLaJ+9E2v1O45B1w3XahGBAOiHUIZzaXEQvZTUwVFMsvkhK3XAG/6b5VcYtvqU8c45dUNsTJIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY1PPFF38CE2865.apcprd06.prod.outlook.com (2603:1096:408::930) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 04:20:57 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 04:20:56 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [RFC PATCH bpf-next 0/2] libbpf: Improve BPF load performance by selectively loading kmod BTFs
Date: Thu,  6 Aug 2026 12:20:25 +0800
Message-ID: <20260806042042.3239428-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TY1PPFF38CE2865:EE_
X-MS-Office365-Filtering-Correlation-Id: 5444032f-7d34-42ce-e39e-08def3721c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|52116014|366016|1800799024|38350700014|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	5YzIzQnjF5uJlJTcRF84OLT1hEP3oN3C2sf4ZxkdMOtPHJ4VJZKmIafX8Vz9l8iueOOkOpdSY7hLkl1A+1SLu9mAXXOjmnn2S8XeoVI6gMbYyGed2FxewDcbwXQBD8TJsnwJpqNPMnVTLxnGp7lSlLMEPPT8BmvqGgGBJQ1s9zd0RLdWzGTPYEiYB6hibGY2fOSWcdECvsN+WvZVBCQupggn3tnH94hOR64t62O3zuFRQ3+NAyd8w9zHNKWs5L5hhwjGuV+2yDrCVn46EatMCsAe4s4kTG3kJZ1HP+hWaf3T4pB+uOTF038o7doYKjKV/JKIFDuzG2N/DzBcr+USYeGaJ4tHZ0KWDMzsfZDthKGlHALew8ySmjhcGrKD9KAaBOYOxr4D5INil+ZxcsIfzC6xDEKOUu6Mj08SJHa/p3xvSN9gcOzWwBrcxtxgpdazvgmibUEeRAGpNlRGXOMFeero0RBhBh5lzFkz3OsMH0kluRyEF9KMYhybqoMZB38o0C1cUDiuspY9Dt9IkP6h80nFPhrVxb22D2D5xp5At4T+6sBTA0zGkTKeXYLzGSoSJ1/iCD5Kp7k7Y0XfSCOR3ZTovmO7vQiZidj95ztKWojlqdzhNHvFtL+KSE2/P/IE9qCkX223jbHOONpKd30ij3urYpk94b3bLKiRC8JbRLCnPtKpyq51gIu3e/nrq8gqgcpNQ+1c6WAEKq3bb4J2HZK5JGJRMcO2bCoB77QMHEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(52116014)(366016)(1800799024)(38350700014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIwzcLW+y02VLKNa1MEbBUjTYLV3R9mwql7FzHxy0MHJmPXOPEhP19uWtv5w?=
 =?us-ascii?Q?uH0UKY9AdiBf1mV9E68lPTo9P//LeYlgUfcaITxoANGHzvSAClznBiR5vEiE?=
 =?us-ascii?Q?xQSbZML0p4WAakKrigvic2glGJHuwnMxmFplvU5es1aEhVdSPe/qP63Hj9dz?=
 =?us-ascii?Q?+FIR+9+HsrQXqZgv9PEZEs+HW70LpfkM1Z1OtBUutIm51Py/GXtEGWBbbehr?=
 =?us-ascii?Q?i2lC37Zide7KSUEwwITfqQv7x6QEnnRMMG4YVdqmyBdW4efv7fUawCLqtjZ3?=
 =?us-ascii?Q?xsUyX7v252RPMvzwkAp5EVQ4SGSGDv4qJRftyTs5AJhVnjeYgSsb4KAX8y+2?=
 =?us-ascii?Q?pXXbPloEaqoGWxMgp12gA6YGSucwQOCQ4234Q4MVorvRpMd29yY3+WH9EnyE?=
 =?us-ascii?Q?+Udtshq9k2+pPpt+Go56PaOAt+MKYYy6ZBpUkGH0V1zC8+5+ozI+hnn+PFAk?=
 =?us-ascii?Q?aHa4YJkdhd2MdrYXxRPJSe5WKPGF7YGWfZ5cn5pobjSr0vd2FecRpWgPDbTD?=
 =?us-ascii?Q?RK6BT6CPnemtRbl76iyM+VRgrly1WHB3+kKwAEOu71uaJvUZ8abjgt3Z+h8P?=
 =?us-ascii?Q?/LjJmwy8me0VtJL5mNrAOcD8bzT4ZLHvYhXZqK982Pukonxm5nhRnr2icTlU?=
 =?us-ascii?Q?aNjGGk/wKG71jKpiKd28QCZcWXOjEkRD86k29TVtpt3yCmMbM8v2uYJZHpKZ?=
 =?us-ascii?Q?PsJfwuHpi7LHDXah0v3afblKEaQuVbf9vK3F6aX3tKwu4WtVvg4clBo4x+HP?=
 =?us-ascii?Q?b+pVOyBp2OkWpkQjp5pDrxMIGQo63zUfR/AMgKo7SNseG6FlU2wQoMSmhpLg?=
 =?us-ascii?Q?KEKYVMVTUKwnBUaM1yE6FGZ+zORlRr8NUxsouTL/MKwtJ+BNfoxWeV3OBmC+?=
 =?us-ascii?Q?RehltJpZwAtRcVRxICTwcB4oD1Fjx39WAOMxUxNVtcdJjWnmSVfBXbQn38T9?=
 =?us-ascii?Q?Ijja3hwqUVNQRXKOEVxtfXiMD/kqKowZ55ln9P2l9QYQixxnVPWTfOR+uwrp?=
 =?us-ascii?Q?zaZnxmLd4VnirUPoKL77nD4cuIOkax28Xl0wwdc5lHB3dLskGzW+iNb2v+c0?=
 =?us-ascii?Q?6aeucfftl480VNlTvFP2muMK4qs9Dbz/Lc9jBajlipUyr7yowrv3FsLk25j9?=
 =?us-ascii?Q?4x7+Y30DtW52KrAW3kTm8dvtTNtV2nGX1lUcl7qL0WlLShqZc98C14A/7jSH?=
 =?us-ascii?Q?V/YAVZDvRmsV2anIzh/Mz1NqN2zfoSo7y4oQTJ1diwh5PHczpLWlUYX8gbki?=
 =?us-ascii?Q?NXWg+lRQWycl2qR0AqdZZ2QWWvbp7EAMZnLxG4Rkah2ncGLLfmy8vENkwtM5?=
 =?us-ascii?Q?NMjAMROt0kQl1/7l5nbKlrmAMZ91G1+WlfFHtG2fOYVTk9BgEnwyr1/kw50+?=
 =?us-ascii?Q?kjbjtubrzzt7xBAXfmCaUtIidvg8x9Rr8rFf2UlgGVO/ZjEcL76pehORSUrC?=
 =?us-ascii?Q?WyN8b+3vQ40ejOu0cll6eS2jXZGrsfVhBNNC6z0LzMxbZyMOxmV+SF9U2SaC?=
 =?us-ascii?Q?vqiE3WuHXy0daE82gK19U6cBKw7t4ubKqsBcVGST5vansyh61PvY7MEderHr?=
 =?us-ascii?Q?MFgQf/A3uOqKxGnlrFsr7aGVs2LXutmqnD2iD1OiIUq8eqkKuuFWjOT85wl3?=
 =?us-ascii?Q?Wrq20jYDtrAU7T5JwQO9m5ufT5ziLIXsY9+1uTshsypw2VKIJN8hrxfr69RO?=
 =?us-ascii?Q?RaiROOjXDIJLPrgXp51P2jqFNwdYv/FDajRcVoySKFXAoNfMI5f7RfhuLaSt?=
 =?us-ascii?Q?nHa1FQJ1aA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5444032f-7d34-42ce-e39e-08def3721c29
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 04:20:56.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dzamFkhOvafpsrPdSmXaJFkiGBm0UuJMrlrKG65sWmbNtRIEf349vADl+gTfL08eHXcN6v5qbeJMBo0rDtOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFF38CE2865

Currently, during BPF object loading, load_module_btfs() unconditionally
iterates over all loaded kernel modules and loads their BTFs. This
introduces unnecessary overhead when a BPF program only needs a specific,
small subset of modules. In environments with hundreds of modules,
loading all module measurably increases the loading time.

This series introduces a ".kmod_btfs" ELF section, allowing BPF programs
to declare the modules that need BTF loading. libbpf parses this
section, collects the module names, and skips loading BTFs for any
module not in the list, thereby reducing overhead. It also stops the
iteration early once all declared modules are found.

Usage example:

  DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod" };

Performance impact (<skel>__open_and_load() time):

  Modules loaded | Without .kmod_btfs | With .kmod_btfs | Speedup
  ---------------|--------------------|-----------------|--------
  1              | 35.0 ms            | 35.0 ms         | Baseline
  10             | 36.5 ms            | 35.1 ms         | +3.8%
  100            | 46.2 ms            | 35.9 ms         | +22.3%
  300            | 65.2 ms            | 38.0 ms         | +41.7%

Fuyu Zhao (2):
  libbpf: support selective kernel module BTF loading via .kmod_btfs
    section
  selftests/bpf: add tests for selective kmod BTF loading

 tools/lib/bpf/bpf_helpers.h                   |  14 +++
 tools/lib/bpf/libbpf.c                        | 112 ++++++++++++++++++
 .../selftests/bpf/prog_tests/kmod_btfs.c      |  47 ++++++++
 tools/testing/selftests/bpf/progs/kmod_btfs.c |  14 +++
 .../selftests/bpf/progs/kmod_btfs_mix.c       |  15 +++
 .../selftests/bpf/progs/kmod_btfs_nonexist.c  |  17 +++
 6 files changed, 219 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c

-- 
2.34.1

