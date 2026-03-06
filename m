Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDD35BDBA;
	Fri,  6 Mar 2026 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836996; cv=fail; b=Vl33fmFMkoa7uK/zDQj2jUgXfJSWBhG+cv9EpIgQ+JKJIwIw1ccM6DOriwBGhZiLkgR+5yWSOhHXZ4iVXlYqLRQ6QMrPTwByahsJ15LGGrm+DL02WpDsA4dRRqSMY6FAst5f2QgaNmGfaxO4Tkgr5vWtliuezmy+cODiCo+ynpQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836996; c=relaxed/simple;
	bh=OPmJgq47robClmLgLT6tTa7KScsamDC5vewuL13qiiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vy1LvyZna83RPL1wWNO5b1T7CipELcfoPBRkRB3VuIwHrtZPg7/mMMBZOuqKEy4GQM3zjwzrrmjjsoXiP/2OssbpxnKY//R1k747j3oPoacswXh2Ia4ASjfXAslt9eTBnkfkhmWAkRxGMQ+M6hZps4W4H3ZTo7iiOnmRpd+fwwQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D0MoZXPN; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D0MoZXPN; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D0MoZXPN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D0MoZXPN"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tv+2Pa+/KNY5w/6XHlnq0oXujIGI/vgtY4YHwf4iNk01GmfoY+VjDvbEsDltS4jT3AoinXtjmtR+fc8GMWoOEt9n82mMOsSq8/c47fviGIAimVMUSO3bTX6i/mViB/BIMja8sZa5hnadXc863JdoFAX4WkoE4pomaVQB0FdMgnvFuP0GMmecaIRcGrNnQIDC28efN+6FzYTb8fC+5+IFFE73iCYq9XyqPgJ/tbKZ659n9iAZjjFkgBfeJPgMkRiVj17+pdLAku7BTDxkc56jQASaoJ/C/KZ4+6Rs++F6+NNfkaKnMwiUFbuIVFcLwMp3IlXdTcQQmP7oVF+GpFqG3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOeS4hJntE80LrrLROuq/xi1yGcetstxV7naICSUjWA=;
 b=TvUWFxuCfw1s5oz7tritIkmasOKGFdD/odBBzsu9ReGhE6jGVZsQAsJ7VO6qqAQvswC2Ve7C3pGlTehDwXf7nyfT5G7cOiiUEVJJkHw756zeb/InTrOfYMS8eR+RGkRdsWMfMSsxv7yYyMjt/32jjJbJ5CQOcxJ2Ck5vDLArvwl+BV0qORXU27gCgrpOk8sVVm870K5PGyhcVCsyn2bhUQAl/SONwmoETUgXWNyRp7LmGOulb9zZjaL+wusr8zUYnT3xiYCs5mEi4HdZtNFWaHZ9I2YaBoE+RjH6FSqQi0gPfw37sSbIcTDbXzICtG3eW7Zjz+XHiaX9mxyGrxIWPw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOeS4hJntE80LrrLROuq/xi1yGcetstxV7naICSUjWA=;
 b=D0MoZXPNOk/VIkhPC9398BDn/TIm/RhjdwopzT2PqIORFBXqNjhjz9C8RBvgnUoqCoCk4EIuYyPfW+JFnHdupdbcW7i4bMZ90ewxLIvGYbhE/gKs9V02bfH0QRU4hcCz3gdHjoL1xNCEcl/ScV0bUay630YsIpfLuoA2ZwVb/CY=
Received: from AM0P309CA0026.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::7)
 by PA4PR08MB5984.eurprd08.prod.outlook.com (2603:10a6:102:ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 22:43:10 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::e1) by AM0P309CA0026.outlook.office365.com
 (2603:10a6:20b:28f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.7 via Frontend Transport; Fri, 6
 Mar 2026 22:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Fri, 6 Mar 2026 22:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV9clopNKDcEle1nWpcQwqWG4JBd9AbTcgiYPNONzRb6gcpYdr+8hZQS2JjH87Ou0D461EMRK1cBgLM+3vZWuceAhbKk4byau0qISAAGlC0M3A3bKCU79xQ1Fu/qt8/j51DLJlG6FdpA0vhXp5+KSwDc/s6ROZKWvwthf3PKHHFUlGikzAZoDHKcScC3eohjsxGkHrHOGKBiOJtmiatzktu4RwrkpHiP0BJnqIBi2LPy2UrJYzvjCc2FTbDrKDx/83aHUlHV/1ZgrRZlHA56ZwlAhwHJLbcIcKkXV5YzgEEQ84hSJAtzCJk9A+qbjN5EEHMKh2B9TsQ4Y7dOhioKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOeS4hJntE80LrrLROuq/xi1yGcetstxV7naICSUjWA=;
 b=FS6PG3ws+zwSNUxwzMHv1YHPZUB1DKrx3ShHUyrey9JGwNelN3mECWC3n7ZRmrsv3xTwRCBUWrBJa8bOhcy4jcX5Y95iLxThe25aIqWy2r42nl1DRi4DM/wJBkBiDv/6AN8WOJG0LdHwDON4MUjq54PxOY9dTwAQl18lezfjlBa4rbWMVceEcCn9eiEwjqDwPkbufhQfUaUdM5ksR2AkmzsxqTs1LFJyGgm0jrOF7V7dlSAjfksKj1lAR2VmPViQjqgSmBN+WK/2nWP1EPqMBMObjBIHMl/eymabiYbZSiPGPayHQ2JzxDFXPEjZNu3fBQ9jGRDRYu08BsnubnoRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOeS4hJntE80LrrLROuq/xi1yGcetstxV7naICSUjWA=;
 b=D0MoZXPNOk/VIkhPC9398BDn/TIm/RhjdwopzT2PqIORFBXqNjhjz9C8RBvgnUoqCoCk4EIuYyPfW+JFnHdupdbcW7i4bMZ90ewxLIvGYbhE/gKs9V02bfH0QRU4hcCz3gdHjoL1xNCEcl/ScV0bUay630YsIpfLuoA2ZwVb/CY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB11666.eurprd08.prod.outlook.com
 (2603:10a6:800:308::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 22:42:03 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%3]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 22:42:03 +0000
Date: Fri, 6 Mar 2026 22:42:00 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, richardcochran@gmail.com,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: Re: [PATCH 2/3] bpf: introduce bpf_jit_insn_aux_data
Message-ID: <aatYONvuxEix3HLP@e129823.arm.com>
References: <20260306221330.630971-1-yeoreum.yun@arm.com>
 <20260306221330.630971-3-yeoreum.yun@arm.com>
 <CAADnVQJW2vK9YEsdnDMbij9Ed-wfra3Wbg4mp95C=xiDw6Bteg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJW2vK9YEsdnDMbij9Ed-wfra3Wbg4mp95C=xiDw6Bteg@mail.gmail.com>
X-ClientProxiedBy: PA7P264CA0255.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB11666:EE_|AMS0EPF00000197:EE_|PA4PR08MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 82754222-6721-4a7a-82fb-08de7bd1bdd0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 PFW02O14iU+yJSeztm2NcQFYlEuIrEVYCKiJ2MnGNqVtA4hX7eIQ4Cb/QGJ5Rjh799b849ujscVxhne/UibhBDdcLzLPgMrSkaICQhUnUh2iyePeXn62MPIkdnhEgBP7ZHWEYydMTbaXukB02rLsDQm7iZNEpate3qf+Y6nus9HrmGd3uO0FDSceanl7YHOHYkd4eGpkSsPDUxiP5VlrXvLfzZxsn/GkbAx9c0yU30VZX8WmVH4h0MhixOrldt0XVav/JhvNzN5E2OJ7owo96VhMmjRXSXLWVtufV68x/r2T3Aw9oHUMkPqi5zL9ncH3dufE6Q4nLVPE0jqfQ5ByoY8cXhUnkj7xfQpcm3NYbaLV9F/sjjR2JLRixGlupRGPieFG++8ErzCIueUSD082Z9nce2bsPbDoZu/SIfSl9M3IBltW1aLqOOvNHq4Gl9qAILoPQ0GRvHWfapseZ+QESUiop+QrZWVCHMg/iOeTPnuw1nXRub2T1KuAb/4AILeBwZth1bJDV8VgCEgAKjQk+l12uoo1ZTSsm9cExURq9U+oz28lOWA5u4vqeUPUkBVOtMFF4wOvZnI+FFnD+Zbim9Oj/arndZUMUCxpJtiN4jniVY1+eE2jM8jJLuTxguFojfr2hq5b7KWygEj5cNeHPtVGoV03I2cURo807WhrPuHi4IbJ2JlPOnXsFqNFwIl1Q+tI/U10aBQBKJBtV26WwnZm++cUxRy8cE+nLvdB/2k=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ePSTFJsT/F18hB8Ilsuyzt/raqN1ln+CzJogEiTPYe1ZNEZfzktbJMWGTMPxq8J0jnOdl7Bsx0Jy0OKDhxV09xX5Cbcc6z9DsUmjO+wMZ1MMSeipRohYpAoC+CF2JbuklqjpYZypNliPm+8/oQEcGxouJ3lkKSqIPDdrRu0TTypTU5RX/bpHm4mHRVNFbQb/PtA+CXEKzGWCBH84WErOydWsGjuGZCO/PagWC9cN/TaJGy424EkW+sw1ZJG9F/DWyHXTtnasTfwYFJ5HjDNaAyYnoLTGLFVSzceCEmFAOY0mEje76S4IGwXZrB3Xm6ZB6iwqD4UwdseA0osbAP/s9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11666
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4a0262cd-cf68-4081-e72b-08de7bd1966a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|1800799024|82310400026|14060799003|36860700016|13003099007;
X-Microsoft-Antispam-Message-Info:
	YqTL7w+H162M/vvxHfcopsvRNkdY+WXyEaoPJcvqm3m4qBP4iNOCvbdDmVLaafWBzuTyOpmQqFtZPdSd2MGDf/1155QxBB79HIxa4lXQwTIKFqKg2aRcufY0WYe+ze7i4nxPHdjFQrI+lJwMWmv7xkx0ytq7JinyfobQrre4onu32A9pOG+ST0vFC0hjsmqOmLUQlS2bE/iweDywY+T+tIwspi95zHVRA505b7c+ixWYjT7L2dt+NfsE1XE6AN+Pj33KWgdJUabYplpMuOfKwr92I5JQbj9zBk2rOgwd6MQ9biDQAjDvs9FRZ4BZqyjSnFHRMslTN0YgyMG2zNgu77Ncl3i3KXKn+1BKq4Lmflcr0c+N/vIz2fCJuSxcYGBbm6E06et9IlI1/6qJzfPDboDQ2E3yYYAEpRw39Po4J1aFg2BqQMgB0k/iJJgz29mY3PjaHeUPnNRsWdhAxl9FIwS6rAgGEu8JQDoLon6G2vQMmJ8Wzc3ach7HVnfpBSsgg/PIZPNlSUCGl0JLY4O3BG+9teJZsMj0AC1Wbw8ekTquvN7/e2xpnO0ICt6uWmFQqsktXV1JvdPxBKFLvMMTt7qC2R6on4YpbgwT2NjVQw8K2CP+qYgA85w/pqcsItevEck+igLZ8F7TokD9I3eBzrfIe8NwKf5rgzo2ghfLEuQSkh4BvcLiU9zgAvm0mLFlTl48xijvvIilhU1DNM+ESqBEuO/KkXDxgqw9gcASwbXG4noLVtuWePRjoXPPqoTf+bFsNk1TIZZDQapPSfQLTQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(1800799024)(82310400026)(14060799003)(36860700016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Rh0j+Oim/3P3IBza6PgzT7L/NAosEjnBhOOBvOmHlWZtpyFv79T5B8jzeHBW991Kil9nqyFovlw5jYejNnoVlR1BvD5z8KGMr16CoEG4jX0qNfTBnV21AQloQyWSZFB8/nOfuBuLWoj868jXHHJ6Gtyyq8s6yRzqxQDoUxg9QZHIKDXNeCGCYn0co/ziUB7acH1L2AnVcrKatvEr5CUNVp4rNpRn2HLDFAM/ei67RR4ImxXgSHU/amKmfW9QbtDDVt48MUDLd8ZbuzbfZUPt+AN+/YTG0/Z2K02EQ69pXyxStSmJjnmZWFfUuURLWyZaDNW+MEEaL+Uvnc4/6KS/EkjEkVxgt/jVHRahKBJQVDRe37oJpCjJasdRTB8eXxInkV1q+4MBcrfWaA8v/Lg0+0LcAPC97KuQNWQ2Jj1Gfxsnpm7tdiRV/KBqw6OhmGE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 22:43:09.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82754222-6721-4a7a-82fb-08de7bd1bdd0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5984

> On Fri, Mar 6, 2026 at 2:13 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > This patch prepares for fixing the BTI exception related to gotox.
> >
> > bpf_jit_insn_aux_data contains per-instruction auxiliary data for the JIT,
> > extracted from env->insn_aux_data.
> >
> > For example, it is used to determine whether an instruction is
> > a destination of a gotox, allowing the JIT to emit
> > the appropriate BTI instruction at that location in arm64.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  include/linux/bpf.h    |  6 +++++
> >  include/linux/filter.h |  4 +++
> >  kernel/bpf/core.c      | 59 +++++++++++++++++++++++++++++++++++++++++-
> >  kernel/bpf/verifier.c  | 30 ++++++++++++++++++++-
> >  4 files changed, 97 insertions(+), 2 deletions(-)
>
> before posting patches please scan the mailing list to see whether
> a particular issue was discussed.
>
> pw-bot: cr

Oh. I missed Xu Kuohai's patch posted on today.
  - https://lore.kernel.org/all/20260306102329.2056216-1-xukuohai@huaweicloud.com/

Thanks.

--
Sincerely,
Yeoreum Yun
