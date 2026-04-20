Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D337A48B;
	Mon, 20 Apr 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672188; cv=fail; b=k9CWTHhzBomX0qdEr7YucSX64cSfix23M/JXmQSqADCyxlpD0zwYUw2m5cNZ5WxtYepMvFQCsaCy0TWV1b8t2uvNYoMKnXCVeC9mApvqEHwTtG5EK2WvlAp3ZrT48n1HFB5L6i0xSMuucdxmW1KX7a+g2AnxuBWCavwots1pzxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672188; c=relaxed/simple;
	bh=lkfeIAvUG6vN1EfLK43LfV0dskNSCzhh5WL4XRQ+WNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FATcc3QGHv+OS+xNVdKo8yRnwhFv0fvFgXA9F9S/zUzv04NDtnPP2WpWmneH2B5ufBQSWGakXawk9tkoBd/waHYaIKtAlEXCclTYcGG3J/7KMSHXfORhL22aFPN1b7qxfORBU7HoPbPuR8H41sa034dWQYtwR6aSL/8tFxBTwuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lLuwf9jq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PFIxfly9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLuwf9jq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PFIxfly9"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K0MWR23303455;
	Mon, 20 Apr 2026 08:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=o6ynZgTDJX3+P6ZYEfSJ7TOeOm90E0piBeFvfzwgre8=; b=
	lLuwf9jqEyi6n9RPujr0LIeMAh/CLJhDeoHrLra4Nh97QUVP60kYXKNpReKeZ85v
	wSO3fLGY+zUWdIDCNhYbpWrYlUCQtGHNXkYh7mcJJVaPASGJOqaXOiN1RniOniAt
	jpKdkclucbOsW3QTVAPZikR6lgWH36VJ5wwOQR2aJ4GeP4WFqSxznjFrYI2jGiTP
	wL9/g2kiJIYLQQcPcagXtYPjnsq3Lhhsygj6idUaWxoB389Uzq1bZtOkZEtCAyvM
	l/ZcMka5PV38vo9Cog7MoccjYS0vLcBPf8yP+HT1jeA2bfMtOXYkalt4lSWh2cff
	8hKTk+xsXLz77PZLx2ZTaQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm27vtsnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:03:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63K81H10039369;
	Mon, 20 Apr 2026 08:02:58 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dn1cm2u5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:02:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZhuwlpjdlyN8uXDaO/YKCTsmLmREx6bUnGDlQBgAonAUe5PRVTGxbVFctXi4KT2NmkiPmFb6r/iq1yHomgh0Nwp/t5DU+R7Apk0iksUtCpO5zmzCtg2akf+frqS7iuQ4iaNcYC4J9ihGo6N+Pn4gy9x+iQiG1A1TBsZ9rr9m626Gs9XvJ9Z+c1k09FN/mBUETdnTQ0zpCGYo2PIAvMF8vwXUUjfr8Z/7dilgOViS85BInxw4DoVOmnGJ0gu2viw7H3gdU7V5WJ2gsyZD0txfwfvGUUUTklQlKTMXRyfNNJsgnkTjtplD53pyRzhHdz5ouuosKvtEXTv6cEeh+c1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6ynZgTDJX3+P6ZYEfSJ7TOeOm90E0piBeFvfzwgre8=;
 b=OSkUuZ2Q8CHKEPKJGxAReZ+8k4St06LZr2RYbLQT/ScjnJRWbTsGlJQSdptl6FtTs9YW0rM/wc6CUQwhM/n3Cp1Hse1x86mju87iR7RJPHUSpqp9sfe1r+3Qw7XiG+7OVc/Uf4dnp566eluB2UjLx9Q+TucFe4FfkgLfOCZP+MmF/BvK1eg9IX3Y+m4EiotWZGINTDZN85ma1HKAdm28Ueq+e2VA5u/GPSv91Y6N/0b0M0g1mLEPliDKYTH9lgw0qDb1wBf27m1eXa11CDTAv9TyyE4vLEXp/yyos3lCkb64WmkdlErx/vajAraktsb6G8/3b+hYNnUiPmz8njd6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6ynZgTDJX3+P6ZYEfSJ7TOeOm90E0piBeFvfzwgre8=;
 b=PFIxfly9YSO+7y2jXTCP7FG4TFwm0pPgKESWN9xPZbM4z9zXAk73uGNYJjD8M5WRG+ByqgAWmqTeEkBwI9tM8dARwR+O12AVHf3Xtw6qbnr4vgKR40FQ1pjrrEm2OdHyAM1zn9HWPqZrA32O+jV8IVkm44fN+v2Crl/1idXuWSU=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DM6PR10MB4314.namprd10.prod.outlook.com (2603:10b6:5:216::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:02:55 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:02:55 +0000
Message-ID: <40708ab6-7a2a-4c7a-8943-88f25c13036c@oracle.com>
Date: Mon, 20 Apr 2026 09:02:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 2/6] libbpf: Adjust btf_vlen() to return a
 __u32
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417143023.1551481-3-alan.maguire@oracle.com>
 <20260417170712.74E77C19425@smtp.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260417170712.74E77C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::23) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DM6PR10MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d884364-494c-48e7-dbaf-08de9eb33a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pgKPCODK2x97K4rfrN2T8OTRClPFaXvOeGEIrFjf7Rk7SwnoWJjHpE31WybfQ2XmA6h1kMOea04dr0HuSOLE8ePMqOFOA38+9YLarbKbVml7ZAY5vJmWGdDbSR7b+leIC8m0Gmrsdymj4QxLOnQFupo9MVWB1INEZOOXDaLPzraMOqXlZaNATMxSUVtnaZe/ungwPQdOik9F6wA+QZuiv/7ivS0y8ua8e5C3Tgqr8X69cX51a+ZUhP7j662QiGmwOgWg1uG90DiWsvUbdHgNXUdj0EZvIm34hXRnAzlgXkR23O0fBqGixMPHi1Q4nWgCiONEIQ+7/UHDSpMoNyHg8mVuTPGOTSxxgD9Cl43XSB4kihXt4zFaZ9Qtxe1BKGmpMwA0XhaXL5Dg2vwSVTC+yG/T9eI1AVAwM84P8HMRtt0VRPHSiqMwl2f3FTJNetob6uxs4ss1cf/irORKXnKofMuTLGHoUpx92p0dup/azQpgXZrZ6vgR3keI9zOC6wX/sHCqsmDcXItt/e/ZshPI8KY2vc7ARpqmHIgyCwRo723C19xC/UZ5qsrfVVJptJ8DPoTqs2/8/1CFUEqpY2cK4Lua9B3B04ZKBcFqRtXxT44M9jFTCuHS45zFWf5ML25QM6TbWC1LfigHkf/VNzZScHrSiuAkAbVK8iQcZFs6s19gVAs+NTghef/FxqtdcKVki0tdgqSJU6W9GA6Ku36rO/PK7aAN7/pyK6VlAD9WuKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXNnSEtLWFdHRFJRTW1MZytVYU1aeXloN0FDb3BCbklUU1pKUmFIeXhuWWVR?=
 =?utf-8?B?OUoxaE5XZ21yR0Nmb2VNVmJ6Z1lmU2ZzK1dILytjTUhOZWNrUzVkQ2tKVUZu?=
 =?utf-8?B?QnJoT3JwSHZXaC8ralBELzgvTFQ0Y0Jrb3U4YUdic0g0MkdtSHNhOCtFUHFx?=
 =?utf-8?B?TVZESm1USVpTMTl1RGQ4eVpyZy8zNHM2UHIwUjBTWmIzclpYTEFVT3dZMXI4?=
 =?utf-8?B?TklGUVJDRk13RmFaUmVHR2RES0xZeXpETXIxbktOQVJuNFNqbGVkYmRwZzMw?=
 =?utf-8?B?dDNEUERkYW96T1U5eHAwSkJsU2RaYy80b0FzRzNyeHZYTjJzeGwxSklqQ3VH?=
 =?utf-8?B?SWpCSWJiaXQ3aGdMRDFkSjJKcDdYWkVYOEdTMU9HRGNsTmlkR3JLREM4bW02?=
 =?utf-8?B?dlAraUw4Q2lFM1lnMGZMTjhUMDJOcXZXK01TQnQrRkNXSUo3TUxWV3hNa0Iw?=
 =?utf-8?B?c1RueTFqNm1PK1U0TW9MTTg2Vy9jR2dWSHpaR3puSnZZOEFCeG5QeVRyRXRC?=
 =?utf-8?B?QUpYUGQrTEc3N0VkaHNKZkU0Z0xJRTB5UnlXTUo5dGxMWVJxUnpYQXZGZ2pE?=
 =?utf-8?B?eSt5Q1lUODFhR3FsK0FoYVh3QjBwTElQbU1hSzhldHJ2WlBFMFNrVHZwZnJP?=
 =?utf-8?B?Z3JlaEJwQURpYStSelF4MmQrRkhqN1VkZlhqTW9oemswbDZ4bVA3Y2NiRDNF?=
 =?utf-8?B?c3daaXlobEJGQ2NjazFBdEN6bjFJQ0VuZGszU3NpMTVlSnhGdjZzVkJsMjJM?=
 =?utf-8?B?YjNZcjBibksyYWpxd01QQ3crUlpwM0JBYzM3eFpkdmFjaEZLWnVVSzFNQnIw?=
 =?utf-8?B?ekxGY1NYb1Nrc1Rwazc1R0VESUtkTExqai9HT0k1ZVdtdzV5MktCRGtYeTBr?=
 =?utf-8?B?eHkyVnpnZFdKQWdGOFdqOEZnOERqbFRMeHRrbXJuUFZsM2N6T1htbUQyQ29n?=
 =?utf-8?B?NGNGVHphR3JqVHhKMDArTmFlUUNhYXBvSXU0V2JCVlJxd3Y4eHA2MDJSUm9E?=
 =?utf-8?B?QnovRnBJTDdPN1BrZmFpRVMydDlSQnBkVjhKTEd0Y0ZXM2RuZFl4U3VBRURh?=
 =?utf-8?B?bFcvRDRqMXA2ZmRvbVJyTk42UVlycm5tdE51Z0JtUFRZbXZuWFVQZVlGTG9X?=
 =?utf-8?B?TlYzMFlpKytXRENTclZXRVVLM3RSbGh3TFMwZkRUa0luSmNJOXdsSHQ1R3Fz?=
 =?utf-8?B?bk9BNmhlL2NKUno4MFQ0dUFkbndXc0JxbTFJVXU2L3dwMUVNL1hoT0RTK3Fs?=
 =?utf-8?B?NFQyOEJDWEk0N0s5WFlHTUpaQyt5ZVdWcDhXQ3RyQ3B2Y2JscGtlWkhGc0U2?=
 =?utf-8?B?elRDWFhFYmh5VUNEMzh2aTFSVWlXU1hzQm5sWHgrNlBZbi8xR0I5VHkvL3Uz?=
 =?utf-8?B?b3FtWXMwRUVLQ3QrSEFDbk1oN2JNZlZhaWJ4MVc4cWJERDA3ZjFwNGhURG5N?=
 =?utf-8?B?YWtGT1NnaWViOHJJZlpTNHpXdXFja1F3SGtFY2x2ZXdVYUV5VjZ0RUhyYlFw?=
 =?utf-8?B?Z0RSeXZiU1M1c0xKRVdoVGxZMG94QXFnYWhwVnZkVlBPSFgwUGExMDUrTTZR?=
 =?utf-8?B?aCt4eVhZaFg3STJLcEliSWFjUTFiVTI5Wjk3Sjluc0tkdWREbFlmeTBPNVFw?=
 =?utf-8?B?SXpBYmpONjdUSVpkbnBNSE5QVm1mbXZtZ3FwbDk0ZUFIZm13MkJ5Rm5Kc0Vs?=
 =?utf-8?B?MlZIZjl2SDV3Y2lSajgxYW52a0R2TXUyMUVHU3lrcFZVanhCSk1hUTFDWURr?=
 =?utf-8?B?MXlKbEtVNWorRy9YQ0k2UVlDK0RlcHNacFVHYjVwZVZhNXRoS0h2eERTM2hv?=
 =?utf-8?B?SXlMQjdaazhYWk9XUEgxVzRIOTIwUDAzVHNKSEdyZ1l3c3BRa0FvUnVYL25x?=
 =?utf-8?B?L254L2VVRDRzOTlIQWdqNlFvQlRpbXY0eWYwcVBQR0VZS0dQSDdMRWlUd2hs?=
 =?utf-8?B?c2YxandIN3BzQnhPaisvdGhJQXVCaGYvSzNVdWpKWURtNEt5SlZZRDVZcGV0?=
 =?utf-8?B?cUhua3oveUdtTXR5anFMK0d4ZkNKdUF3cStOWDNyV2ljUlh2R2ZVeWZNajNC?=
 =?utf-8?B?WDFYUXcycUN6RFJJOUdyM0VpRldUSE5HOEFlVDNhS3NWNmNkVW43TlFtL0lP?=
 =?utf-8?B?QW9XTFppVDlPUkdBejJyWmNadHlCUlhkdVRHdWVZbFJyREhVd3JYRXdDdzlM?=
 =?utf-8?B?NUlHa011VmllUnBWNmFlMUdIby8vamcxT0psZVVCSSs3UTVTWVlvMk9jWGtD?=
 =?utf-8?B?VFNIaFRQaUtyR2Fua1dGellXdERLWW16eFVIUG12TjRoMUJZVmRMcnhpRUR4?=
 =?utf-8?B?Qys1dDdwT0kzMEdaT1d4UFF0WjJKOSsxWVZsZnNYajVBNXNxa04vMFJlQklQ?=
 =?utf-8?Q?aM4uPghBNdYfbono=3D?=
X-Exchange-RoutingPolicyChecked:
	DT/knPSyL47iXI86U+AGGiNBjHmPV1g5T8i94ThJnLGyUkl6e9m+GxkV8kMg24cIeDNddGd+gfgVRXbkZ+RK2aoleu5xEemY8kOX1KHzQrCY+fIc6NzeTiGRozdE2y29B3w1ysbYmQmf3A6UwOly/EODbjdsGdAQlA346/B5WsiDCEE+t8t9Gg22zSYf3weMSC0MpK5beavF4/YTnBirvusXCg5baNinf0e5MW8deCv4bF9MZTOZTnOcQdQF+634GOlMnRcGa4NO5VLzMbEfdL+DT3zkA+0fsOSip7S2onxLsNwA3cqGavJK01zSBkIw0dr0KANi2euIzKygoU2/9Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BkBtr3qANyV70iHvS82nmn5swiA1k80P3CUGM7trUQ/qFj6CMqf7D5HL9S+z9GKAWP8gbgUSsfKMCTLyn5vqYC31IVaDf+FpxGCJ+bV5kG/McUOavuRNSyRx7ehM3cWptjq0lxumT8mRP8IaV9Efatkq2pFY37crsF//tmzB3Gn9CIG7CUnWilreynX3xQyqq46EGF/IMCm8L2EeEw7i4CVfeOHTTI5vZOUy/6x361l7IFrxy7tYE+qJuwywYZiFrkfyCVxWNlVMJmkmOTIj8oVgR825vphr7mhIOvZ5F/hMWKdnha9mMZhUgSGIOs8LpZ5Q3rgWB7Mg5XXcfnD1rbhNBE5q+Mxu/f4ZA6oASvJImoh6gJL1IhxLFx3Q2h64gDQTnJ+oVgcyCmsVt8wbWnMAVbx4klD+xrS/nxcC+D7b6jxInDhyH/GJl4tQDvYRrFF65Ei3j3/KewtpDLK7KWYA/gWPNcYxMzcg9yAPxJJwKR3Pvz1vc3L6XHAXa5+UKeaJFcKktfkErTLGNgIwXX9eb5INhHi0PW5oDxBXlm58IVKR0NthjBR2aXFoPVOWWG9KJuxlF+6ts5NPB1QPs2j7rFnH+acL0+W8lY8/+X0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d884364-494c-48e7-dbaf-08de9eb33a7c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:02:55.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psehRr9AXs287qZj1+NuT56qnNxM3OL9OFpYQuMCU4OgOa88/WwLxkq4wkg82P+Y3+YmFOTlgpgrztS01WmpEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200077
X-Authority-Analysis: v=2.4 cv=JYCMa0KV c=1 sm=1 tr=0 ts=69e5ddb4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=gmCHMQMrHhq7dcJSX5IA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: fByLzMKIwW7wnH-gBx1JFJuOYGED30xb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA3NyBTYWx0ZWRfX4rm3THAE2S9S
 bi4eDoFVhnogVVhQ4n3N2/S73PW0iHkLBRne/aLS3noxFvTxTxTxe6ZD5hBMwZKf7hdj9nLqLU/
 DX01gbN22G0V0BqzgdqHtEfeVJ7aKbPnA/9A0YawtNKP0ygAqpSdxiZjifjZMPb+t5k5CHMZJEg
 xwgJRpYI3J5KMX2gAYVrkY3lpdAevKGXvt0uhwCgqQrgHDsQXmdmn7tQQrCV0hyxoWYeeyrmOkK
 nOAgI6M7CtmTXKnYtLPuO+dDCy/LLB0ELLipFgVQIQoXmrR7ajMSr7EvAY1cinvsf6oKEthEVDZ
 Ax1Jg7aTcrc2zSwhYSNytPBuqEl70MFXVbdNElNyGRiDEG3t/isE8znNhNhyyiOn/Ry5M66GX+O
 2I96esBxQtIlnv9/p/DfBhT8nJxNSqw2rvPYeZV1iTjJdH+agTT0eVVynOTAWuDYvnD01FUrUzq
 AUAN+qR+moQhJkrx4WoEyCfbeFJPlwhd0p5Ud65E=
X-Proofpoint-GUID: fByLzMKIwW7wnH-gBx1JFJuOYGED30xb

On 17/04/2026 18:07, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] On 32-bit systems, `btf_parse_type_sec()` is vulnerable to pointer arithmetic wrap-around due to missing strict bounds checking, allowing an attacker-crafted BTF layout to bypass safety checks and cause out-of-bounds memory access.
> --
> 
> commit 0d6d9306686384cb94334ae8845f954db44a9f74
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> libbpf: Adjust btf_vlen() to return a __u32
> 
> Now that vlen is 24 bits, btf_vlen() must return a __u32.
> Adjust use cases in libbpf accordingly.  Also add error
> handling to avoid vlen overflow in btf_type_inc_vlen().
> 
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index ceb57b46a8782..267904939098c 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -421,7 +421,7 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
>>  {
>>  	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
>>  	struct btf_layout *l = btf->layout;
>> -	__u16 vlen = btf_vlen(t);
>> +	__u32 vlen = btf_vlen(t);
>>  	__u32 kind = btf_kind(t);
> 
> Can this lead to a pointer arithmetic wrap-around regression on 32-bit
> systems?
> 
> The size is calculated later in this function using unsigned 32-bit
> arithmetic and returned as a signed int:
> 
>     return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
> 
> An attacker could provide a custom layout with an artificially large elem_sz
> (e.g., 2,000,000,000). For a type with vlen = 1, the calculated size fits
> within a positive signed 32-bit int and is returned as a valid positive
> type_size.
> 
> When btf_parse_type_sec() checks if next_type + type_size > end_type, it
> evaluates this using 32-bit pointer arithmetic. If next_type is located high
> in the address space, adding 2,000,000,000 wraps around the 32-bit boundary
> to a numerically smaller low address, incorrectly passing the bounds check.
> 
> This causes next_type to advance to the wrapped address, allowing subsequent
> loop iterations to read arbitrary memory and potentially cause out-of-bounds
> accesses or crashes.
> 
> While this parser logic issue predates this patch, should we address it here
> by safely checking the offset instead? For example:
> 
>     if ((size_t)type_size > (size_t)((char *)end_type - (char *)next_type))
> 

Ok so I think the suggestion is the following in btf_parse_type_sec() is the problem:

		type_size = btf_type_size(btf, next_type);
                if (type_size < 0)
                        return type_size;
                if (next_type + type_size > end_type) {

...specifically the addition of next_type to type_size in the last line above.
A sufficiently high type_size will cause an address wrap on 32-bit systems and
we end up not triggering the bounds check. That seems like an existing issue to
me; even the example cited describes a vlen of 1 with a large elem_sz from the
layout section.

The proposed solution seems to be to check if type_size falls outside of the
remaining space in the types section. It might make sense to do that check locally
in btf_type_size_unknown() instead for clarity and safety. Something like the
following:

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 267904939098..7d0dfb2810e9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -420,9 +420,11 @@ static int btf_parse_layout_sec(struct btf *btf)
 static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
 {
        __u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
+       const void *end_type = btf->types_data + btf->hdr.type_len;
        struct btf_layout *l = btf->layout;
        __u32 vlen = btf_vlen(t);
        __u32 kind = btf_kind(t);
+       int type_size;
 
        /* Fall back to base BTF if needed as they share layout information */
        if (!l) {
@@ -448,7 +450,13 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
                return -EINVAL;
        }
 
-       return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
+       type_size = sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
+       if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {
+               pr_debug("Overflow in type size %d for kind %u\n",
+                        type_size, kind);
+               return -EINVAL;
+       }
+       return type_size;
 }

Given that this problem exists separate from the extended vlen series, might make more
sense to send a separate patch targeting the bpf tree for this issue.

Alan
