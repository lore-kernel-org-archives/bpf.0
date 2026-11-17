Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794893033;
	b=o10t+jy5tAc+NpSHY9f8IGi3r8BPxDL2RU4AaHh1n3qDCoklevXidFsNZKvYStTSMTtV
	 CpkisWK2hjlJNlSDidHNNf0+hFdKkJX7EBC8M+hIk0pSHzmQ29TGmO3jF7FLDE4iooqdX
	 wjnbZIqiYlA1F5kxzZb+jLHac1cXVy/subtrT9Em9judfVwHfdWTzBymKYEQBYW8AB+Pm
	 dlsNTg7kZw2XYebhwWWkVBVhzyciv2iT35nJP8m4/cNKWqdBUIiz3qgtaJBS05CAU/zqO
	 IgMNhNan1aeCVmzMjcYCj4euHROG7fQZ5WRfKg+51HPGXw4e78Vihew4mlAa9sKb1nQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893033;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:References:User-agent:From:To:Cc:
	 Subject:In-reply-to:Date:Message-ID:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID;
	bh=OGNAjlqam3lTwcaMcLj91eU9Rx36mXoMZIuHJDXUVz8=;
	b=Jw/NVBGYDnvlT0qd014Uiu1JlD3OaAmmXdqiZXiAW6W9KzUi4tG4apgDBUeodQlsaq4F
	 peD7n7ODzBgC5rpp7a+nIco6Or3hWcZbBOYIoCorwMdhGWAKB4li2Fmnd5UJqfZC3KsQ+
	 VM0++2KcSPWaNqou/H17c0ZBGtgPJH/TieuPK+S7l1bKXzZXWqxPK+EraF+Rl/8945urE
	 yfRMQ7TVSp8Z7AP9mUJutZ8zW7ed6VNLYo3A5q/kofKz/Iz4YOmaqWB5inFWKVOWBJARy
	 0dw8coTAp/8f+mXToiK3Y/futcTKTzLRDxWkXLAqHx60av9N9xF1Rd+sVgcSULX0+xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=O747JuEu;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gOyhHjqV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E5606A323;
	Tue, 17 Nov 2026 05:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4E5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=O747JuEu;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gOyhHjqV
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGKoijd2600403;
	Tue, 17 Nov 2026 05:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OGNAjlqam3lTwcaMcL
	j91eU9Rx36mXoMZIuHJDXUVz8=; b=O747JuEu16pjPSCMkdGYUjLnjbd1kDys/i
	FUyjX7AnVnAzZcdIEF34O4yVvwL7p7nBUk4S/1KagIGiVzvBe/s/ENAOqgw3pd5b
	esj5SX83fYIRjDFocTL9l6vJLTgqt/TC6e4tr6ynGs267c72S/IJImBk5mRRE8GG
	lv/1og9lxNDwrz/eNL52eo4FVdRYxY//Hzkw6gbmy0xM+AuR4ACb2Zwgk1gtyAeK
	gHXBvH7BDz/H/qyD7Xv1RsKa9wL825cZWD/TsCdCMxtWkZs5j6Mt3TCQ2OqbVQcB
	P+Zj7NeJyw+gdJi0g1te1P7Nugcw+E4Zw8V4DVmEqhL6HquYAW3A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxee43btu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 05:23:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH3gw704036815;
	Tue, 17 Nov 2026 05:23:51 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j0f8y2n8c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Tue, 17 Nov 2026 05:23:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKiHhspn2A7sNa1G07+782pScjvDASvNnG1CqG/+Mt8+tlabQjrcaT4e+054Cwvu3VjpmYwyHv9tQYK5pBWP9xpMdZHV17CNwNcaDfiMs+Jo45ugsqJu/9asGSoQ5krsibto/4X4dm0o+Tj4SFx13UOeVIzlvmr+6dUOrJ6+vOJNWmUI/cFG3LxUJa9C7/mVYELfPCE9el0sCD0xZlNXyfM9EoRpsbzZjztv511KqWZduE6op4fbGxWdsnADoDdgdaB78p3xPj0Y6zJkwApb/1C9hc0b1aDTs+iTi7Bzr9h62BQIM9TdDtRAYKwyKHBziQz6/mMcTdlDQcZvXgFs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGNAjlqam3lTwcaMcLj91eU9Rx36mXoMZIuHJDXUVz8=;
 b=v4NPiEXDNFwfyuT1Mw51PYs0hTdZcxw0N8AJRqaCtMUnAIfbhD0Hzy3rY+wuBbhDQgHd+kM2miPTI/zJ2YdmPGypuGc2OCt2LxEbChNznreuAHABD5iCfSHN1IWarEel3PdzWvmWaugYpkW2+geHkBNFUfLKwq8Un4uooy9jmSk2H2TNyQ2OKuh4o7upFNM2yW2k//oy8qr0nmX/e12fOD6y4FNvtF//x6v4ozOO4QgpJnc+jktPSwq9whpgYeOB0Z0KWgUjsNNdDBtGl3Pvtl5tmdZm9zz7iSJWnIu2+7+O88U6Dej7CJbdM6KsbClnvw0Osa8islcORhU+tDAhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGNAjlqam3lTwcaMcLj91eU9Rx36mXoMZIuHJDXUVz8=;
 b=gOyhHjqVSrydTLK6LX1DH2PbXnMgbYdgEmGIaqbA4cjYTBCAyiipaQNZ0QfJafohgvuKmP6WAMEDPhbaVkIjSLaL7hcLpPrgkRNfvCI5uBFRY6tFhPUDQ8H8RrR6bT8Mrt1C6fi5CKR5haP4mwCSI92mjGb4mNBxNlftx1Aw9gU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 05:23:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:23:47 +0000
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
 <20261116082437.66739-5-ankur.a.arora@oracle.com>
 <sashiko-outbox-216562@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v17 04/16] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
In-reply-to: <sashiko-outbox-216562@kernel.org>
Date: Mon, 16 Nov 2026 23:23:45 -0600
Message-ID: <878q2s2fq6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e9b9ad-6a48-4574-a43e-08df446af49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|4143699003|56012099006|261021123027099003|261021135927099003|261009223027099003|261102130727099003|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TTWp1TlEaZ28W8rA8oidy2zfQHPKEbAM8o0EWYsi6fib5S6CumfVLiNXuARSVIoOUotqaJDKbBl/iltO072U2Dw8lWbpHuJEStnMI63ymQqPxniZIrHS86KrPGSlrS/WrB26M2idM8qupjB8uLb/+/3GgSlzohelRC2RyTuvtSHW2pBbGkGcRHIDvr70KXPYkgZIvm2rHUT0po8V9HM9v78vhWrirzM297TU1GAUNCfOEJ3XOEhiFjunJHhomoKs+YFyKeU8GcE/tB7HKcwru7L2W1oAr6rXS1duiM9+UCwZFHW5WrWMZJRGk6iq72upldsCOWb0b3nYsh6cyi7s7iQsiQspYGfIJQasasLDDN6+5gWeCt1ig7AvEXZV8iauu5laxW9wmcFabPQE96qIr4r4vS4O0nLs09rgkYMyYdC3EavH+TDz5heu2GDsC2ubRpL2GwP9Nnc4+vuyhsryEKCnEkTMwbEuF9sQH4azmK3WuOhzACGjgRJ3VRzcAOibERX9kx7qeXvPysaBkz1EFeo2+0kXVuhj3xBzUHE4ZGX98UwTvD1LIUqFciyDK3kSWxV0G8TLi2V8PBwU2yjoMaV2w1mUAdw85YNXnb+Qfq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(261021123027099003)(261021135927099003)(261009223027099003)(261102130727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keNXfAWLmdmN5hYmIoIaPmVK5aa2RLM0v43QTl1ToyIjTRz3OVzEdF9zX/yu?=
 =?us-ascii?Q?Tv7Uc3mN8nzQq85paPqWj5tDXWVJWXJ+AD8NqlaXIFdW43x7EBzsK1tpasVl?=
 =?us-ascii?Q?sqC0PIT+blm0xNz7gj9WKF5y7DoZebkTgNtqcYDVF4wJKYsdRFZbdUYicq7+?=
 =?us-ascii?Q?rRqlcR++bGvTfOCzFWiS1QLeiI1B+f5Kpz5yKDV5IBK9Yz3ep4pS/dPG8cp2?=
 =?us-ascii?Q?8wB0Z0TsY1ShRdqZ1F2718dvlGq1MBiNJWIt44sdX4MRUllXAAXxUToWIVmb?=
 =?us-ascii?Q?TwuGUH91O5a9IqVluOAYqjSyx+5rR5+SoR+OqI8kOoVSqpxz11VvL5XOfHej?=
 =?us-ascii?Q?qSWQss3jD/IsWd1jaGq2ikrcqHJFP59k0FFRgn+F3gTP6xTjm0dV1N5rT2r1?=
 =?us-ascii?Q?rT5M/e+kUAAvwpleBXAprU7ei/Ng5Es9YMNP5Et7DkP9h2spMXu5RKJG5Oaa?=
 =?us-ascii?Q?4zOP+OnJ9s9L0xbzV/k9z9D3U2ru+b67H66BFRM4LTFP32B+uGqDYyE/x6O/?=
 =?us-ascii?Q?+Wj9yWRvWFurQHo3Zo0UzQSPMITa6x3i0RDV9P5TlYKSoZO0mdos/iOIM4NA?=
 =?us-ascii?Q?3GSdlPgXPGEekXRvU0/eqKK88wgYwNEF30UcquAbAsEW9R0KNuZN5P7ksaQq?=
 =?us-ascii?Q?uYM2tSaNZ1OWv4GP7vwIknyS7GRaDE1Maqm6nD7fQ0iVZ4zDpdxyKTK0Ezf1?=
 =?us-ascii?Q?dgqYDzIq2W+FoTxPabKw/SxwJicw0H9rGv3nZTTBme9HvUauC5/FmTpIs5YL?=
 =?us-ascii?Q?/S7lHIo1IAUeQMaUVioKne6jCLEOyFkZVlhJOzERkCIay/gk9p08rg/RIKUD?=
 =?us-ascii?Q?bP6cE4t5TKWsD41GWTVO/zIwOwt2z58Z2vcoDtUKsXbeZmJsIKHobAneQI1g?=
 =?us-ascii?Q?VfISYn6b0p+ARUI3CB/VBbdW9g5QT5VftIDOO5YKgY7bLLqcieLebplQhUCG?=
 =?us-ascii?Q?XhDaW5izAVkdbsttDKD4gbTbvckUPCv6V6K08W8LPiqfV7mRqWO4vXxdZgZP?=
 =?us-ascii?Q?EuWNvbYcqKaF2wBo8FUg0GOCeT1cEfDjvaNx5IbjjyaBgnqg9HvyrazsP1Dk?=
 =?us-ascii?Q?P4dE7PXGpPiNvgbztP0vOT3x5gy2ri/UcsO5Q5szczRhduMq6c8ieRQfQpUb?=
 =?us-ascii?Q?h+izanDXSXo0vQ7y14woaMOaaiHnIKZFHy+rzz/XiDakNwEVJiB2juGybNJS?=
 =?us-ascii?Q?1zuk51eBL5PbyAMIZFJzFH84Ne7cZpxLuZW+A6KlT9JNQGpTcwbwPXEIPqeZ?=
 =?us-ascii?Q?p7NA92UcIFIkgDyZCS/QowYZ4MEnLT17eq8Zsnwlm2qu7bw7m56fAv+sMEKm?=
 =?us-ascii?Q?K/EcMrx4OCg1YbEE0+qXDN2UBU1pQyMsU9tWA5w+KHc/aLwOU7CM+SldwFjc?=
 =?us-ascii?Q?yDR0QfEDRCLBp3gsEH5ZvnHqQWcNNAdNIVI7G18tbYerOfn6XysMFD2ZovnJ?=
 =?us-ascii?Q?Ruf795/EH0+4+FwpAUh4gJrtWE0sM5HEwm4uX2HyNth1Wrqe61kjP1cEgxMx?=
 =?us-ascii?Q?TMKIKSEgPoKUwtAH/rmi6tYdrI/ATXCNGoAhqcfJzhsWTW06lGw60K3h8mpQ?=
 =?us-ascii?Q?gDkYYH+OSfZvzkKt2A7etoITyDYEn6xmZ/5ytFyYO0vF6q+TjqtFV9+HCblJ?=
 =?us-ascii?Q?5H6LauOiKigBQ+sp9f0h7/jiS4TWyzmmOjQgbgIHaR7APOruMXX5M4a90VM8?=
 =?us-ascii?Q?FKrnbSvEmO66QKlPaQnRau1WEH9j3q1YOUKKJSSkIgwmFNTklQOYIpcJWTUO?=
 =?us-ascii?Q?ap6KNIdjJVe/mk2uxmH5XNppwmQNWFU=3D?=
X-Exchange-RoutingPolicyChecked:
	nLIbXXutBmn+f7W8uYU+ICTJf7wMpF/iLVWJbCCtMq9lUI5hUVu0n8KSiv0n3hFF+p4h/UmNCQmUFOXQ2i9yUG1+s0E3Hu+UGVvw7qul9dzDL5isfRPsrW6ILAh+dl6MO8bF+zGe8W4OD4GmHtw2yt4bQKfDmGoL5neFqR0wIb+67LfT6kDUWL87iodGlr0N833ZGUfuo5nYeMmNh3hr/Lx6DXXMpw6WNq9Nwwvip+DOFwgbq8QwOKUbl5rYSJ4f2w2CTuFiq3/pdKOnOybJ8qFK+DAeuNmaVZlLUHq8Ubc5eNJ83Irp0vvwgNqdnD2Ztqnn3a1POqttnGlGYSJA8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LVsLpRQtuLq3WzKLlhZB9QleSBmaUcx6QlfUEmSamyx/faxDPsAvh9qkIb7Qm9eAXNoGvA4DB3LQ3PjpAxrRERuoP9MdAbMGi4IfYNuRRK77iZiQ7XejskGBVwlVqjubpjGYdNjABNMBx6cNnHEdhVRI+UhmBhnOUMNC92phpe8VWe8e4okrTqJ4x68WfyWQ5NiH4BsHV6u05FYw6XPbGFPxrln678ioM2QQsPewZiaqQD9hE6a0Q3/0gMF5sxaYKWRkBX6pWM9RJ00MyP5YJtzYZ5qV2/+2lPEVC1N6Oes0vTdG7s1XXGfNXDCUkYcwIh+vt74Pn6HPzeZz8oe/sV/gJXT8ReBOH0DBIG8YCuwqZNyTsCS2ynfWTuaZVOioH3pDwKvSIsgPkqeuEVyHA4BMSOSd5eHpTRrWbHQUm9YfJAoNIfxC/QLSD3UPrOFLETj6an26oWZZ4zTqOzNhelXK8TkZbyjcX1t1F3dtaRST2bvMIQAlCG8gvVOlUBfZhshWfHz+RGpXqJ4huIriFIXCGwhjtV7gQD6QVh6AtYpE1XzXGATW9PIO6fWMwFGhDWaCDB0u8609TpVfqT7rzGEPIn/bzdrABIOnZPXSNk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e9b9ad-6a48-4574-a43e-08df446af49d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 05:23:47.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QpC+08n7uO2DSbFQyrjGl8UeBfxTFBQqSvTwAaIgyZAU12iSvHAwDH8veyPWP0Y3T/VN/wsJxX/Q7r3BpuqL6QSI+zN1t20ZRjRNEGU1XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611170021
X-Proofpoint-GUID: Uxb6LlBImwWP3xI9D4NY2V1Q1JkhRpJZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyMSBTYWx0ZWRfX/SV+DBn0Xs2T
 r1gMurL1vRIOdKXq5rW6jfIsoPGjviwIlRapNxUZOuLX0aiQVIQllq8oPOd0Dn12u6AuWQYPdcB
 jNEBar/GT+KMpqRW+Cpwwy9bh1o0ZwGtf/rdoO1ljv6OlDNT/lpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyMSBTYWx0ZWRfXzTtXLMaH8GD6
 zPAB+MIk9VRYdzuZfgd6qpchh8g0N+pKl9752XMnRophoqlQnNig2VjoTq3CTY/xe0HINy35KDI
 wfaAKf1tRHik8o3eNTM0ikXVoYkVAk9L0O2WiZcAFjOFeffNSE2HNEVvv/4EhdsHGDStbshXpfg
 Ez79mCZObvTbcWpmPS69J8jcW2ar2bkiW6zqZkBvKLD6/RIxou+b1NxuQmmN/PGIElvirLD7mBL
 GvOCq52s5laESWhuMab1dZ7kfs0NPyx8U05H67mF4DeaKH64OCqOs4azBOrrrFrM9DdLDEn7bZR
 Xgs07WQbQTQ48Ma9POcTkFst1ptsPVkaCXHFhcQ7jHzX7C4ETKNoE/yq7wkz62RMZQO8K8Ze/WG
 j97n9JRMmRnKj2ZgD8jfOkkRMtRgrelW8fik3uqIoXTY5Tlp0QRxx93SMv9np1JXhqEVnirv8/D
 PwSvbDW9Cz/CWN/1w9xFyHcJwRnqHZgQ3ru+NS4k=
X-Authority-Analysis: v=2.4 cv=W7utxhWk c=1 sm=1 tr=0 ts=6afbe4e7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Y9Lqq_cyp_RBOQrdPzQA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12101
X-Proofpoint-ORIG-GUID: Uxb6LlBImwWP3xI9D4NY2V1Q1JkhRpJZ


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] arm64: cpu_poll_relax() calls non-noinstr
>   arm64_wfet_deadline()
> - [Low] arm64: unexported arch_timer_evtstrm_available() in
>   cpu_poll_relax()
> --
>
> commit 0bd9d96e9ca449b0fa90386c0f9dafaac6bd9c03
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> arm64: support WFET in smp_cond_load_relaxed_timeout()
>
> This commit adds WFET support to cpu_poll_relax() on arm64 via
> __cmpwait_relaxed_timeout() and __cmpwait_case_timeout_##sz(), using
> arm64_wfet_deadline() to compute the wait deadline when ARM64_HAS_WFXT is
> present.
>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index e2263c754a550..3b024058cf2f6 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -224,8 +224,8 @@ do {									\
>>  extern bool arch_timer_evtstrm_available(void);
>>
>>  /*
>> - * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
>> - * for @ptr value to change.
>> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
>> + * __cmpwait_relaxed_timeout() for the ptr value to change.
>>   *
>>   * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
>>   * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that this
>> @@ -235,7 +235,9 @@ extern bool arch_timer_evtstrm_available(void);
>>  #define CPU_POLL_RELAX_WAITS
>>
>>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
>> -	if (arch_timer_evtstrm_available())				\
>> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
>> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
>> +	else if (arch_timer_evtstrm_available())			\
>>  		__cmpwait_relaxed(ptr, val);				\
>>  	else								\
>>  		cpu_relax();						\
>
> [Severity: Low]
> Should arch_timer_evtstrm_available() be exported with EXPORT_SYMBOL_GPL()
> like arm64_wfet_deadline()?

> [ ... ] any non-KUnit loadable module using
> smp_cond_load_relaxed_timeout() or smp_cond_load_acquire_timeout() will
> fail to link with an unresolved reference to
> arch_timer_evtstrm_available().

smp_cond_load_*_timeout() is a fairly niche interface. Let's not invent
hypothetical modules that use this until they actually appear.

>
>> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
>> index 6cf3cd6873f5f..e543366801ce4 100644
>> --- a/arch/arm64/include/asm/cmpxchg.h
>> +++ b/arch/arm64/include/asm/cmpxchg.h
> [ ... ]
>> @@ -235,20 +236,55 @@ __CMPWAIT_CASE( ,  , 64);
>>
>>  #undef __CMPWAIT_CASE
>>
>> -#define __CMPWAIT_GEN(sfx)						\
>> -static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
>> -				  unsigned long val,			\
>> -				  int size)				\
>> +/* Declared locally to avoid recursive include dependency */
>> +u64 arm64_wfet_deadline(u64 timeout_ns);
>> +
>> +#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
>> +static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
>> +					       unsigned long val,	\
>> +					       u64 timeout_ns)		\
>> +{									\
>> +	unsigned long tmp;						\
>> +	u64 ecycles = arm64_wfet_deadline(timeout_ns);			\
>
> [Severity: Medium]
> Does calling arm64_wfet_deadline() from cpu_poll_relax() ->
> __cmpwait_relaxed_timeout() -> __cmpwait_case_timeout_##sz() violate
> noinstr constraints when smp_cond_load_relaxed_timeout() is used from
> cpuidle?

As the previous patch notes, I plan to handle this when adding the
poll_idle() user (updated version of [1]).

  - note that the eventual intent is to use smp_cond_load_relaxed_timeout()
    and thus arm64_wfet_deadline() from poll_idle() (which is noinstr).
    Will do handling for noinstr in arm64_wfet_deadline() (and
    __delay_cycles() etc) as part of that series.

[1] https://lore.kernel.org/all/20250218213337.377987-1-ankur.a.arora@oracle.com/

--
ankur
