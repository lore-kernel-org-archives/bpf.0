Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5723EBF3A
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952729; cv=fail; b=QYDzoRecQjPkteO+BrcvZkD5013QBJcxHm0+RPg3MjmrugzghHfaG9XgPkGNEArnzsMQYOgNdPX4uyM71vM5arvgO3gz/3UQIPyM0OpIEuhfJGMXk2sKIGfVFYsXlJLPT6hyhusGYNp+vZDOMHkr8roX2iBjwp18T42Q5cu8p0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952729; c=relaxed/simple;
	bh=U744I5V+ZFxZaGqu3nUQRNbl0fP4VWTjAnBxrfrm/8I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nUP4EF9iBXaoFq0AyjSIXiAgZZ74Gk9Mk0WwotKb+WiBGDcpUIK6tLXDxcaDE1P+bTokRplzW5XO7t8woNhSnyM92oj8hIzkXXVzt74GJ1QBWvf+2RkxeBY7K9KP+1OwNHdX5CxOdMvtE9iWW65WBw5yZ4It3vMbcU8+6Lhoy8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HS1b7KWi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f5VIrMcY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HS1b7KWi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f5VIrMcY"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OEMl9U351755;
	Tue, 24 Feb 2026 17:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dmHLXzxPJ2mGJGO96fnIFDLiBvM0I8vZD+3qIzxkQYs=; b=
	HS1b7KWicCRNn7qrnT6QjYhimRWtYva/Wyk8D0qCv5AccOgr+hrdJKauBw15WGKY
	vNX9TEmDlWhU61sU3l6a7pyjV8TJkb1MiycNBV2y+/l6fBHE1888w1jbwlBakOq1
	9eJcoE3OFeMLhlsotLMa2rppqkm4BUmpQ+C9ef0yQjUC34ZlFm7I5BVCrceI3qcB
	52yWAfA0y/PobOVAGdOHKp9tQY2JyjZUFSI4oJY4yilKlXguMvlcut5PCtMX7VQ2
	vtbfgUV6zRNHrtvhqOn01qEZQGkAnDzXA76XhEbyRuKZOFy40SnVA/afXMsaicuG
	GBfDJproUtMr+IMF+oYiqA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arcmqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 17:05:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OFrmS5028640;
	Tue, 24 Feb 2026 17:05:25 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf359y67g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 17:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYoHn6lQxIBy45CXWmy3yvW4O77pi9+uerA9Biw8lBnvrRfGKoW4l0mT5lvvyNZWo1pZdLGhcwAmTaBOUEvBoaMSP9m+2Ib/jBA2/GYG4o/Rq8lOs/WaSgdYP9Wq+C7UrMXh4crXE1qoQALW86xOfVJPXpfNdTo01tikDYOsR5eB5MqrR2f0KoyqYTcm6xl8yzOLwSnbEso7Zh5105+N3Ihb0VvXPnMVwqmazuMKwCqFuaOxecTXq2LVBFjrk+i+5L0uUiqxL24ES2vBIouQvJKy18q7NhJFKarAY1f7DGTyYk8MsKFt2w0fSHi8JoGZwfOgpQOElZ4kbBopaKSzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmHLXzxPJ2mGJGO96fnIFDLiBvM0I8vZD+3qIzxkQYs=;
 b=zQpteWSVZgNUCCQYMa4JbE3SGptlEnZXL+5pI/g9YUx5IbwvjXxS5ICrOFjwi7khbg0zjJGM5KVy1Veqi85dLz+LUAJE0jYu1o0jmlQ2mYrctqpicpM/EjOuMyPRhcL6z+OMLiY8cNwotxQ9QhSFCCUgUHPcoR5eJh4W2jD5XIEWZrp6y5HwuEY8CarUOhEcf6q0ePz4gQcmyG8XqQ0IGzctfT9SCls4oTf0tbiExv0+fTjaXIoRIrLkTtX+XMO1d3ZZlq+qQmTTWUDDOuYVksc435ZWsxzo1oKCi+s5cxMgK3kbmvLcB8+yn2J77AyJ8E7VUixk8BFqBkdksSbMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmHLXzxPJ2mGJGO96fnIFDLiBvM0I8vZD+3qIzxkQYs=;
 b=f5VIrMcYwBQp08GQH8fNeQRhlZOpJbhQA8h9zzC7Q8iEuM++3/5BBuvgr+7uaRiNqywzJGdb190rvmqDi3ECcyMMd5AheOjnfJOGSz5xc6miPWJWfw2T74fC6caHz2q6raqtm0OXrt4d8nPPtV3/ZEuTDVj9+g6N5Yj7Wwu1EAg=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 17:05:22 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:05:22 +0000
Message-ID: <24f1ee04-e252-4759-982e-695c85391de8@oracle.com>
Date: Tue, 24 Feb 2026 17:05:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] selftests/bpf: add test for btf__add_btf() with
 split BTF sources
To: Josef Bacik <josef@toxicpanda.com>, bpf@vger.kernel.org
References: <cover.1771950922.git.josef@toxicpanda.com>
 <dbaf8e09041984d90e0e3acb4aa86a3700728b00.1771950922.git.josef@toxicpanda.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <dbaf8e09041984d90e0e3acb4aa86a3700728b00.1771950922.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9ae494-7028-4b1d-d7fc-08de73c6e516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGtGZVM4U3JoSERlWDJUd292SXpJM05VNkFYaTNvOXVoNEpZaStkMGVOUlBr?=
 =?utf-8?B?eDRBUFh1WFlwdi9sRGtuWmZtNisyTFppV0JrcEQzK0VzVG1HWHA3SDJUakJx?=
 =?utf-8?B?VWxxeW9VakZDRWxmSmU2Z1QwTTJoRjk1UEYrb05LWC9PeUNXTU1PVUtwUm1D?=
 =?utf-8?B?dG44bUh5WWFlMHNpN3VNR2p3ZlZJV0lPSnNwUGtIbm1jcTZSd0cvS2VzTEFP?=
 =?utf-8?B?WWRNakUzSzJxVXhwTVQ0aldBa3JqUThYaWpvT3BoS3h3Y1pramwyRFllUFZp?=
 =?utf-8?B?djlVWGtLeFVBME84dDlkckFJaE52aUYxN3IyaUMwb0NLOXJqK3lQZjhDVkZO?=
 =?utf-8?B?amMzUHkwY0FoVjlocElHRTFPRWI2bGVmOHA4dVBDMXdaVjIzdkZKcDExQUdQ?=
 =?utf-8?B?WHgzcjNab3lYZUVQT0xETDFkNDY3RFhLam41ZUtUM1JDRm0vaitPODlMZ1lK?=
 =?utf-8?B?Zkp1UzcyTndqSjZ6a1llUTRUZHFTYXRWRUwrMllHdjh6VTVWcHUvNVZKRkRi?=
 =?utf-8?B?akZWN3YranBxbFJWNmE3Y1djYTI2bmJPZ2diTnMyTnE0ZnE4UjR0d2x5NWRR?=
 =?utf-8?B?Vy9kRjNGZ0VhRHQ0QUROTHZTOW4ybXRKaFQvWXRwS3l1aFdhOXNMSzhiOXA2?=
 =?utf-8?B?OGM1QnprZEJEZGVkM3VFblNrN0NjUUxsSnZTVzlxb2Z1ZCtzWDcxWXdscDY0?=
 =?utf-8?B?OGN4dHhWZjlUZmlEU2wwOTJNeXQ2OHVmbDdtRGlQUHZPSTZJaGRTWm15Z29n?=
 =?utf-8?B?d1dzekxmTDViNUxCUngwKzlxTTZsYjUrZ09OVFo3V3BHamcyRTBjQzZSQld3?=
 =?utf-8?B?bkthaEdaNjZMc1B6MzI2Z3BWTTk2dVJJcDdjY2hlYnE3SE1BeTM2WEdWdmlW?=
 =?utf-8?B?QkVmajdCeWNHd2xFU001TUV2NXJxcU5URjdQY1U0UHN2TVp1VmRZTCtlbk9a?=
 =?utf-8?B?c2phbzNmZ2hDY2VUZFBwK1V0a2tJeitNR1l2cWVjZVZ5SGs4eGxOcmIwMmxq?=
 =?utf-8?B?NGwycU44djZDcENyWURpcFBxLzlQVmNvSXBMZm5aaEIweUw2aCtma1RtbjFi?=
 =?utf-8?B?T2N4eWU4V1ZNNGdNdzBHZDdQSS9YRFJGWER0d2I3WTZaZmF1dVE2dWNoczFO?=
 =?utf-8?B?TjZwNkpZR0pIL2pWZk5iVTFna0o5dkRjSGQydElJdDNzRWc0M3FXL2w0bjZZ?=
 =?utf-8?B?WmlpK1JZdEdKZzcrajg0RGJGT0doeTgzV1gzdXpLZkE2VFFaNU93eHNlT01r?=
 =?utf-8?B?djBQZUlVdTZzZEdYVm5MQ29NZ2kvRTNjM2lNT1hNNlIvaWJLbkE5Ykh6a1NK?=
 =?utf-8?B?S0hSaHczK21wOExXRm10R0FIL3F2YTVtREk2cjNtc3VxakpRQWdrYkpHSDZy?=
 =?utf-8?B?b2VWcTlhNmp4THF0QU9yRlJzdWxLV3dGMVZCaExtRjJ2YXpKR2dRclNsRGlw?=
 =?utf-8?B?SG93U0dnVUdlQm1pT3d1aTdUSmtOclVnYzAzV2lFRmtaTktQdTQyRXF1ZjRs?=
 =?utf-8?B?b3kyTTQ5Ty9JL25FK21UMzVaZmNyWHFrV0pUdExKRFpTN21RUGFoVndZZnI3?=
 =?utf-8?B?T1dOeGF4V3pubnVWbS96YlcwdFV3TFNHYTgvVmxsQ3FDa1N0SmYwMGJTQ0kv?=
 =?utf-8?B?MjYxOGZsQnlpQ1FNVkZ6UXg0d05vd29LT08rQkZxNlJlYS92eTlCdFdIaUlG?=
 =?utf-8?B?TlFYb0tBb1VnT1RMeFJUVUgwUlRvYmRpN2JSWWs1ZEdWZUZ2TE9CU0syZjQv?=
 =?utf-8?B?REJha0xyYnZ5STZTNjdTQ3IrakdURXI3WHE2aVN3eDk3MCtVcG5wNmtQQysr?=
 =?utf-8?B?QlRnUFdLeUVVWThpWkNCc0pLSTNsbXd3NVU3bkg3NTFmWFpYUXdQOFNVMGRw?=
 =?utf-8?B?cFA4SExmY1d4MElXSU1wS2NqMXBvK2wrZDlzU01kdnhGWnFRNVpTdC9SN2oy?=
 =?utf-8?B?SXRXRFZKeUd6eDc3Ylp3eVJnYlViZi9KQ2xGbVhPZTdOYlFwYzZoSU1aN0ZG?=
 =?utf-8?B?aWtQUjVRUnBqc0tNTTlMQ0pHTHhHc3ZDUDdyditqdVpiYnhhZEZiU1lXcVdm?=
 =?utf-8?B?TXpPMU5UVTBhcjl3UUUrdmtoTnc2TThRckJQd3krSUYzVGdTVXlYR2tMRWl2?=
 =?utf-8?Q?YKiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UThySUQydTU1Q0MwVUlJWFlmUzI4ZFhYZ0J4Y0o2ZWVMWmZSeWtSeVZBTWUz?=
 =?utf-8?B?alpDV0FSQ0pDV2pnbHZtZFJwb2R5NDN0b3QyNUZ0UXZTVWVaQzFWQUxpQklH?=
 =?utf-8?B?dXhNbXhGanFqNTlVNlp3dklqbDZ1T2RJUTFtdjd3NjM0SWpwZ1dyOFg2bXB4?=
 =?utf-8?B?RklZNHBuV2ZhZkI3bU1vU0pSZGVDVW1VY25lb09qM1puV3pyYnhJUEZidXBO?=
 =?utf-8?B?dy9aSWlHVVhRK2tESVJxRkNyY2ZVTmJjMkJCWVdibGNleHVEcllnd244RWhm?=
 =?utf-8?B?YkhLSVI2Q3ZwYjRyRHVQVVliNHVacjAveVBqMlJGV2RpQVJ1cEt2T1ZoS3ZG?=
 =?utf-8?B?Vm4xRG1FYU9xaGdpaWZwVFJuS1h5WDExbUd4RXJMRFA3cmJFVjAyS1RmYjRB?=
 =?utf-8?B?aFkraVpwNU40Q2VaN2oxT1BJTVExZ01CREF1dzBoMGVwWXo3Ni9nRDRjVzFF?=
 =?utf-8?B?c0ZRaVlXMkxBNnA5aTZDbDhLZGh2eWg5STNDLzU0TWtOVHVXM09zZ3d0eVBJ?=
 =?utf-8?B?TU9KTURYMC8yVVRkRkhhbkt5emZpaGFPQ1pPdkxXV29Ib0E5QXRubmY1WXpz?=
 =?utf-8?B?Q0V5U3Fwb0xubjBkVXdPNlBIOUpnd0VvS1pSeWpIcjRHZVhUWFFFOXJsN1hO?=
 =?utf-8?B?MUlHWWQ5Z1FJMHFUUkIvTnRnemdzbHhCMW1Ib3hhQ3NON1lqdWJEOGc3eXo4?=
 =?utf-8?B?OUhoRHB5anFzTUxjcksydVlQVE5neElIeENiZUUxeWh2UmFuUkkzbkpmLzFL?=
 =?utf-8?B?VTUxR2pLOSsyR0kxQUt1cjBZMlpTamszZ3lkVlFSWTYycWlGQUJUN1VDenJy?=
 =?utf-8?B?NVg4aHZwVnNlSHRpbUtkbHU0UFBjZ1R0YmdrOWxEUm0rR0ZjQzdKZURrVE5G?=
 =?utf-8?B?NTNjY2xzTFVNdnRZK1ZINzZHV1FORTVkNURENElZUnQ1ZFY2QmQ5d1B3NERK?=
 =?utf-8?B?Q1E2amFHcEd5WEtyRVBQSmFWb1R6ZTRXbGQvN0FuSVV0ejVVYXQ4OElRVzcv?=
 =?utf-8?B?SlFGc0RuM0prTWc5MmNaUmZkaWdGYnJQSWNQVDhvY1hZeTU2WjV6NzJFZHk0?=
 =?utf-8?B?TXAvUmc5S1dLTGZPdDRMSmZzc2k5S2xsSFUxMXNqQThEQzJwN2hNTmhUV2xS?=
 =?utf-8?B?dHArNmttWVBXRU9QbUJkNVlGM2ZzUUZrUzNLM3BRTVI3QnUvcElDbXV6NzZL?=
 =?utf-8?B?ZnYrbS8zVUt5MEZhb3FBQUsrT2xIWjhnSE1lazVBblVKTTJPSXVIV2RFV3hp?=
 =?utf-8?B?ZWh2TzFWSnpxL1lTY2djQzhEZVJwcDF4N1loSmE0WGVZeW1XMDM0QTdIbHlV?=
 =?utf-8?B?bjRBa1dVeUZjdk5ka0xXYWdpS21CRkRpOXR3NlBoczRVWmFMSWVUenJUN3J0?=
 =?utf-8?B?WTJuODdGbEUxSTBiRStIbWRVRVppZHhyTE9MSzRVeTZ3ZGlUMmRYWGhZa21M?=
 =?utf-8?B?M2wzNW84cmlqbkkvQm14bjdrUFgvSHRBaVN4aXBEMkE4ekRIaXN6YTRyMkNv?=
 =?utf-8?B?NGxONVhhR1h1L0srT0VYWHgyVUZmVy9LK1lqdmRmOG9ONFMrK2V1eU5xOEdG?=
 =?utf-8?B?Uy9iaDdVbkdhU1ZDSU9HVExhempZZ0ZsRHU5aUtXOFRXUGpGQ1BuVHlPMVBM?=
 =?utf-8?B?clNvYi8xS0MxSEo4ZE45Y09vcVdDbVlERGJSNk5vRnpQRVEyRnlUMkRkN3NP?=
 =?utf-8?B?b25OZTR6Y3IxeCtiMkhlK0ZsbW1mdHBvVlB5aWxVVGk3V0FlZEN1Q1RjNE9i?=
 =?utf-8?B?MVdTVXhsYzJ0ZW9CK2xwdVRDMnBZSnJpSDVUVW1FQ3JKWDkvSktPL29SWWhX?=
 =?utf-8?B?bGtaaXV5YlprajhiSVhrM1d3bTJWQ2xJdG1FZGNva0o5N2oxcHljQWdsdFgr?=
 =?utf-8?B?MHNuT1hVdU54T2tNOFVGOWN5dEFKNzBrOTR2M1lwUFBkem9mVXlmRkxhSkxs?=
 =?utf-8?B?SU12M3Z1V0tvL3dJQWhBc3FWdUoyM0FQVDJneXdQcDlvZEgxZzBKVEd6TXpl?=
 =?utf-8?B?VGRVVXFvZGxMR3ZqVytFOGR5ei9uc25CQnRZMVFEc1R4VG1CN1R0RTN6Sy9Q?=
 =?utf-8?B?dVJicmRHRTlCM2JRc0JtLzRxWjVDVTFuZnVmdGVHQllNWFFKUW84YXZ4L2Nk?=
 =?utf-8?B?aDNZNkZwUHcyUDBGZXpzZ3dyVGU5Q29RSVltTGtObEloTnJ3QUVxQUNYMzZ4?=
 =?utf-8?B?a0cybnN1L0FCL3UxMlZDNnlNSVRaN2pSOGxmZTE3QlU3QnhEMDhsbmEyK1Q5?=
 =?utf-8?B?bHdBUFljZ1dEVDBCY0hYODU2eXhyNEJlNUdGZUpBb2JmZFpjM3ZFYVpyYXdQ?=
 =?utf-8?B?Z2lzeWJGZVk0dHowN1A5US84cWtrUzUzd3Q5a3JZajZ0ZUdTUEdnUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	imSOXYRN19bkhkNs9uNlRtsTlqkW4st6UVPhGvYGko1O+MvCzqNUhyApwVDXTFS51dIKPqBbNrA7nsJ2uSopw5+VTTBCp9xEkjVrmEqD4sHGjncoXvykJ2VDCY4yPadOn3HqYwEbW7JPLPgINt9r4NCB/FwAUwPcKovA8n9w1f0Pd39WNXTWM75p5yhoO9gCsu11A97b1qx9thFh+ps0ziYNrIhb21hn3NMWBzD8Og3tOpmqIq5oCI3FbPLI2NyX7BvADC0GpR50CKHdQaZR8kvxW5Ar0LM3LmIdXXKB5jXtHwK3smjFHmDDlbGyHS6KPS46mQjHDsGbPvjw1LvzDh+mLJi1llbaQjYYf1fFkyPOoetAXwpzbjWslNRMKqu6VRyIMvmaCaKMvnaPcbkzR0cCv1euXbKYMOwhq+dREEfZXMueLCO2TdJ2P0S3XSLeZZi3j4I/Mink8LdCDx5wboHCIdP/U0/bVQvaks4ymGjU38hIJ6puhZ2gqSfDP2vG4oSLthm+3EPOJtprsOfK5lCaJfANIL19YoCkR3CPWEI8VfSeL0REacR/5aCLcqoRmN52Q8+UFk6jdyLzxWh14wqmw6aGehOLTz2CPMDWqQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9ae494-7028-4b1d-d7fc-08de73c6e516
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 17:05:22.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FThP8SM54LnPvJ32hYgnTUK/lNlFzIRyHdusamxFwP9ddzkcqLNtzQI2/lrUvyfx1gr1SG0n3om9bpW8ei1RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240143
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699dda56 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=maIFttP_AAAA:8
 a=yPCof4ZbAAAA:8 a=RamFXToG9jvxgWPP_k4A:9 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-ORIG-GUID: FmkZK7irm8ibXv88yR8lxg5m7RmHo09Z
X-Proofpoint-GUID: FmkZK7irm8ibXv88yR8lxg5m7RmHo09Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0MyBTYWx0ZWRfX+LkBn1XcwuOM
 T0Th/p7wbvq4bCGLiHsv1o+sjmyqr8SJp13HjuEdJ/vggg5kohg/jBulnBph3Mx+UYuJ+zxPgft
 rulhOHspkO0mwPNfcjESzAQe3rF/cWvQ4gZLBwNN5GrAaA/u6DUPvesH5s9lJnCz7Qi/mf//U8c
 JbUxp6nEsmSV0wzajmVtQhZFHPN2s4rM38TouNERlhclQTR6H29v9HoZllOrfmUYt7pqgPwwvQJ
 87lNk06zdzAkXpx7tvbWiY7qjWhfHwLHC/BWCQjEH1isZ8JeCMa9a9j+sd6kYTtJbWsLMxPKOSX
 NStKbnhAu71l26jfkAb13VYMq1NHySwiSKSLjTGnFb8vxZ6i2004lJUmOd456z0Dxn4DZ3dvkuZ
 mudiaPJS994SmKdZCEmKji9iDbvBjOI2BiBvcD4TrVaSjQFGW8NAJL33tVvZHRa5FCG7Eyy0aCc
 1Op2ttAnqqOm3oMjEew==

On 24/02/2026 16:40, Josef Bacik wrote:
> Add a test that verifies btf__add_btf() correctly handles merging
> multiple split BTF objects that share the same base BTF. The test
> creates two sibling split BTFs on a common base, merges them into
> a combined split BTF, and validates that base type references are
> preserved while split type references are properly remapped.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  .../selftests/bpf/prog_tests/btf_write.c      | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> index 6e36de1302fc..5c84723cf254 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> @@ -497,10 +497,121 @@ static void test_btf_add_btf()
>  	btf__free(btf2);
>  }
>  
> +static void test_btf_add_btf_split()
> +{
> +	struct btf *base = NULL, *split1 = NULL, *split2 = NULL;
> +	struct btf *combined = NULL;
> +	int id, err;
> +
> +	/* Create a base BTF with an INT and a PTR to it */
> +	base = btf__new_empty();
> +	if (!ASSERT_OK_PTR(base, "base"))
> +		return;
> +
> +	id = btf__add_int(base, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "base_int_id");
> +	id = btf__add_ptr(base, 1);
> +	ASSERT_EQ(id, 2, "base_ptr_id");
> +
> +	/* base has 2 types, type IDs 1..2 */
> +	ASSERT_EQ(btf__type_cnt(base), 3, "base_type_cnt");
> +
> +	/* Create split1 on base: a STRUCT referencing base's int (ID 1) */
> +	split1 = btf__new_empty_split(base);
> +	if (!ASSERT_OK_PTR(split1, "split1"))
> +		goto cleanup;
> +
> +	id = btf__add_struct(split1, "s1", 4);
> +	/* split types start at base_type_cnt = 3 */
> +	ASSERT_EQ(id, 3, "split1_struct_id");
> +	btf__add_field(split1, "x", 1, 0, 0); /* refers to base int */
> +
> +	id = btf__add_ptr(split1, 3);
> +	ASSERT_EQ(id, 4, "split1_ptr_id"); /* ptr to the struct (split self-ref) */
> +
> +	/* Add a typedef "int_alias" -> base int in split1, which will be
> +	 * duplicated in split2 to test that btf__dedup() merges them.
> +	 */
> +	id = btf__add_typedef(split1, "int_alias", 1);
> +	ASSERT_EQ(id, 5, "split1_typedef_id");
> +
> +	/* Create split2 on base: a TYPEDEF referencing base's ptr (ID 2) */
> +	split2 = btf__new_empty_split(base);
> +	if (!ASSERT_OK_PTR(split2, "split2"))
> +		goto cleanup;
> +
> +	id = btf__add_typedef(split2, "int_ptr", 2); /* refers to base ptr */
> +	ASSERT_EQ(id, 3, "split2_typedef_id");
> +
> +	id = btf__add_struct(split2, "s2", 8);
> +	ASSERT_EQ(id, 4, "split2_struct_id");
> +	btf__add_field(split2, "p", 3, 0, 0); /* refers to split2's own typedef */
> +
> +	/* Same "int_alias" typedef as split1 - should be deduped away */
> +	id = btf__add_typedef(split2, "int_alias", 1);
> +	ASSERT_EQ(id, 5, "split2_dup_typedef_id");
> +
> +	/* Create combined split BTF on same base and merge both */
> +	combined = btf__new_empty_split(base);
> +	if (!ASSERT_OK_PTR(combined, "combined"))
> +		goto cleanup;
> +
> +	/* Merge split1: its types (3,4,5) should land at IDs 3,4,5 */
> +	id = btf__add_btf(combined, split1);
> +	if (!ASSERT_GE(id, 0, "add_split1"))
> +		goto cleanup;
> +	ASSERT_EQ(id, 3, "split1_first_id");
> +
> +	/* Merge split2: its types (3,4,5) should be remapped to 6,7,8 */
> +	id = btf__add_btf(combined, split2);
> +	if (!ASSERT_GE(id, 0, "add_split2"))
> +		goto cleanup;
> +	ASSERT_EQ(id, 6, "split2_first_id");
> +
> +	/* Before dedup: base (2) + split1 (3) + split2 (3) = 8 types + void */
> +	ASSERT_EQ(btf__type_cnt(combined), 9, "pre_dedup_type_cnt");
> +
> +	VALIDATE_RAW_BTF(
> +		combined,
> +		/* base types (IDs 1-2) */
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] PTR '(anon)' type_id=1",
> +
> +		/* split1 types (IDs 3-5): base refs unchanged */
> +		"[3] STRUCT 's1' size=4 vlen=1\n"
> +		"\t'x' type_id=1 bits_offset=0",      /* refers to base int=1 */
> +		"[4] PTR '(anon)' type_id=3",          /* refers to split1's struct=3 */
> +		"[5] TYPEDEF 'int_alias' type_id=1",   /* refers to base int=1 */
> +
> +		/* split2 types (IDs 6-8): remapped from 3,4,5 to 6,7,8 */
> +		"[6] TYPEDEF 'int_ptr' type_id=2",     /* base ptr=2, unchanged */
> +		"[7] STRUCT 's2' size=8 vlen=1\n"
> +		"\t'p' type_id=6 bits_offset=0",       /* split2 typedef: 3->6 */
> +		"[8] TYPEDEF 'int_alias' type_id=1");   /* dup of [5] */
> +
> +	/* Dedup to mirror the bpftool merge flow; should remove the
> +	 * duplicate "int_alias" typedef.
> +	 */
> +	err = btf__dedup(combined, NULL);
> +	if (!ASSERT_OK(err, "dedup"))
> +		goto cleanup;
> +
> +	/* After dedup: one int_alias removed, so 7 types + void */
> +	ASSERT_EQ(btf__type_cnt(combined), 8, "dedup_type_cnt");
> +
> +cleanup:
> +	btf__free(combined);
> +	btf__free(split2);
> +	btf__free(split1);
> +	btf__free(base);
> +}
> +
>  void test_btf_write()
>  {
>  	if (test__start_subtest("btf_add"))
>  		test_btf_add();
>  	if (test__start_subtest("btf_add_btf"))
>  		test_btf_add_btf();
> +	if (test__start_subtest("btf_add_btf_split"))
> +		test_btf_add_btf_split();
>  }

