Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281C336895
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252992; cv=fail; b=Bi3Dfqt8iMgkOQ4sWermJKUVQKKojiJxabkhiWGeIHtbioYSglUuXcFC6dy/CtOMjwpnSAeN1aZ2MZtG+xwo+MvnQpCCLozEcpWUdRvAaNVuSrmLllMnaP/GJ12PJnAqCiA1SAqCo2tHz917M1NgcICxuTNhOzjSGVtWq0D7F+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252992; c=relaxed/simple;
	bh=w2mn9OPSPS9a4AZ2Hp3XgIRXAJUhT72Yr35HmCasZLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+j5i/Z40t0xeW1DrR69N68UzocZMrZW0cShC1AMrqf+xSC5UrFGKMgZtiF2B7wesF3Q3SlSC91SdvSuM3/sRwh+5vSpn+4PsrrfIOeW5kmnfpxAuWOMqXZXtgpLnDB7EdsnZB5ASPRZOJcTx16s1EmWSKkVQO6wNGU1TLEopp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DfIiKmTc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z2Z6SUSz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DfIiKmTc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z2Z6SUSz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F9BUUA3702824;
	Wed, 15 Apr 2026 11:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ICHRA/T61IoIdRmQkxUEjgAKNaDhRbhGd+s2KPhPkm4=; b=
	DfIiKmTcnwxU/grhcUGM1qVPuSH3E2U+TaTmTswWNYtnbN3NbaQyy92kn7ZfZcVU
	9sRhdSUeJEj/Bm68nB271VMCly20ItKP1wxDO2W2Z3zj58Ng/fyTF4T+vrmWA+uI
	Fc+w6KVyhQNupPUPBbkibrxB4IlBaErkpWcVU92je2r8AwvUVgcA4l/uU0QvetPh
	1LJl0nMtXv93CBrfDwykhuJWuNSFXXK/16dIUhikYfa8a4O0dnfuW7qu+K2Y6/Vi
	DrURYqJk/wSfwMW9N/OJyxiroa9PiFAz5OzS9lPbx/dLoobvyXkbcjLFFQ2jdo4b
	gFIxgc/lVmiRHEamKRgmFA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qcxhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:36:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63FBYP7R010769;
	Wed, 15 Apr 2026 11:36:13 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh9jqj6nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:36:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phskyd+QJPNLu3xFkBpGM46MAn9ovaLp6yDu+Bvh64eUgaoMZ9yYIHnwgCCv8ocqo/3V/NHRiTomrflsf1XpWmEkTKPV++lng0fbPzAuVl9rHTBy9r3wIiKeQoe0bDrF59vtS3YQEQt5rJeTp903b3XylkYiagZzt6m22g+VhmJluRo6KVlJVYUvmb8va6b1PjoxLIrRdERJnGAR8g/1Rc+ACsI8gEcd6V3z6lX1ImfgZw0TfKAMwVPy86ofUOzuEG2YiWiKVwqfD+DftBUF4RQJxAv/jei8oQrufD4r/JdfwUmzZafA+HizhDjbRJhq5UgQg0+KyX4REKC0xEOORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICHRA/T61IoIdRmQkxUEjgAKNaDhRbhGd+s2KPhPkm4=;
 b=B+FBOsL2SaO2tEN7pzqpDvulI8cNTfGwiDI7obyCdrdgLxqCe/jgw1x3zvZKZ09Jv0RKPgRse/CcSmeTpbiodoTxovTE09nA3HpKuFXm+8vDSA5lI66Tq9gqm223+9kf6JtJV5My8FvVmfKaq/pmsSe85Ub1uLQu1x5ZN7mChNODUMCph8GZGiuJZyIR62eyYe5CdO5VH7mar4oM4G8vkQNJqPnhWIw2/Iuk9yy6uX2RAWdcRNUqxP8pePhYR8ShGmGY31f3uI2smQDE/OlJv0rAK3k9W3kVsqCGNkznzpW/0L4c/Ewh2Tr9k19qKJMYpfnFB481Z5rsXB7hEM4Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICHRA/T61IoIdRmQkxUEjgAKNaDhRbhGd+s2KPhPkm4=;
 b=Z2Z6SUSzER+yRZaA3AabJyzGiWAvc0oin2RnVcQN8esMpLz1eTrPSuTFF5aftS+S1qKb1sX03RNl4rbP/eynozlkMy0tR2BnyZxvPZlY6mJIVAMRRhpIPkRUfsykPvC7kwwOvMRD3EmPpdSOHkkm//jw5KAMjyRkbaPuW/Kcus0=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 11:36:09 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 11:36:08 +0000
Message-ID: <3cb314b6-7dd4-4a49-9d7e-5021c7773936@oracle.com>
Date: Wed, 15 Apr 2026 12:35:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 bpf] libbpf: Prevent double close of btf objects
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>
References: <20260415082452.1489147-1-jolsa@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260415082452.1489147-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0027.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::11) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c59ffa0-2580-4068-4776-08de9ae32fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2+sN/P+K2zM+DrTCLcTKCxQxoutuZLrCa/iVH+dMKouxrkbBdS3InKQcm+KspdmhdyLqCaW9CRMQJCuWqU2mjLVMbSJpvFlctS+gn7NL1mvK8HXSqUlZ0F6Q+9a9nSWHpdKqrat6mvZh7fqZSgjWPFJk5As5SXeC3Za/gEozHAXJ+vqQg0Con7vjQWSfJyy/fwoYe5S6Ogpn8BVOcKjO2F5tIzrV8K2MlGsCYeRXAWSd5yi+BQX7kH8joqtAqU6jahGKVpEMhtbRzJNN5UIsMG9/2bvMer2/0Xt4pJjf6FHx2LWKcH0lEgYeEcyFIvJrJHfQ+Jyx4tztmr+65K/bvxfBY9Nzch7glbtQPbdTUeZMNVlelqkqNEEcfRc5UwPv5Yxu0/D/6gyhMo+NP5lA+q13JPXZAvXKNy6RH5Is+UNs+zxgeEAwPuk4wVbZBvhllqDmFPqPp2xtTq+Fgdh78EDDbNwWNL1zdHDxHVRv3/7v1bQ1LIN+a6GCmwxGdMdwmSLLMFCJ21FPqsplobw+VWvH40HgIxAHfgla4r8lQPoplsWz0qM5D5gmQZt8AbIFBcaU732xHhC0WzzBpuvLy6GeMNQk9Q0f8gY3P83vWElYjQwgpnBod/C4Qb/FZiYIP/41ib+9ql3kW7FENthysPT3XiPnA2VRkx0/ooneb40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk5VYWJ5RU5Hc0ZjMWt4emUzUlBSZDdyTTR0b2xOUXpEQjFMU2lScndITXBz?=
 =?utf-8?B?alZvc05KWFRxOFNpQlVYd1BnbUQyQStUTHJaLzdlRlMzVEZJRVh6Wm1vOVZQ?=
 =?utf-8?B?amhIbFRQa3ZGa1hvc1dtcUVJZjdveTI3dE1tZFpHUVZBVTJ4OUY1N0JFL0RR?=
 =?utf-8?B?SUVFQW5zMGkwUWNYQUowS1RsQTlueGVEaEFFZ2N6N1dGRXpBSEFJRlFYWnJB?=
 =?utf-8?B?ZjBFNHZQMUZTeDJGbERlOHZuRmFhNjlGUkpxWEZGZUFaRzM1dmpPaG52THBV?=
 =?utf-8?B?cWw0aFJpRm0vb1k4TXFkalJDVzdPUHhjUENUbDNQU3JMd3hUKzBkYTNhb1Bz?=
 =?utf-8?B?TVJDVGp5SysyR2Z5WFpQVGN1NXA2SVQxN3UzY3dTR1NYeU1oTlpDYWRsYmlo?=
 =?utf-8?B?T2lPWXlCYmxZRGFneEt5Qy9IV21aL1ZzSDlIU2xPSUZnMmdPRFIyV2s1Z29Q?=
 =?utf-8?B?ZTRPckVCUWZyUGgydWhzcFVwYlJUSHRnbjZ4VW1PMUdPOVJDQ2lKaHJZSHY5?=
 =?utf-8?B?YzNSTFJtYzBBNDB1R3g5dUk0MjVRQndWUDlvUnBWdDNqd05DUFNkeGpNSTNu?=
 =?utf-8?B?MWt1cFdZV2sxQ0xST0o4b0R4YnJNUHpiZG84T2dJMkdQdno0WDhYb3JkZXgz?=
 =?utf-8?B?SERiNGxSaWxIZDQzUWl1WUR4ZXBNZTNyamYySnZsSEhqLys4RkJSWnNBV1hW?=
 =?utf-8?B?dHAvVE5NeFNIa2E5TWhOZ0FKczdySHVneWNPbFg2eFBYTVBvQkVxUjhObllT?=
 =?utf-8?B?RmdPUld6Ulg1Y1ZyUFpKUDBaRWRybC9pN1JXYXZCMlZHeU9WVVNlbXRhS1Rq?=
 =?utf-8?B?elJDVmRaL2QrcmRNcjNITzdwdExiMU5XODNsSm5QZXk2OHpNWG9DOUFuTkpE?=
 =?utf-8?B?YmVzYlpBWlBkYUxMZStudGtPRVROajNPemVKVDEwajF6akprc2NwZXZ4UlNU?=
 =?utf-8?B?OTlXQ25mc0JXMjlvdGwzcVRVdHFtZEpqM1d4SFVoRk0ydnZPY2RxbmE3UnNE?=
 =?utf-8?B?N0d2SjRReVRlNkQ0eExRdVBGZ01CWUoxV3hYYlBUQ01pbEZzdEhydEdFTG1P?=
 =?utf-8?B?T3RkWG0rU1E3ajFRNlhrNXJxU2RPT3BkeUc1cTVYUUFFYWlPNzFScHpCZU9D?=
 =?utf-8?B?ajhSK044NVU3M05wTStybTZDdWswVFRqdktDYUNUUWsyc21zV2NIMUNSbVVT?=
 =?utf-8?B?dEhvc09SVXhocTgyVVdWblpLUWo2SVhlSm55T093UlMwZit2SENVOUFSdytX?=
 =?utf-8?B?dE1uTU9uVTVoVTNiVUFkV2FEcjYwckJMK2M2bFd5UkxsS2gwUnRrRFJFRTBK?=
 =?utf-8?B?UXRXdjgxU295L2dLOHRqVjZ1a2h4M0RKR0JUcDczYlQ2MFFGWUhpR2M0WWds?=
 =?utf-8?B?ZFZsV0N2bi9Db1dtOFJJSVhaRkV1OVU0WS9zNTRGUFhQMlFLY0E5ZmJoWVcw?=
 =?utf-8?B?TlZBaEY5bHZoMXdJeW5jQzRsTDBmWG9qakI5TmFyVm10YjJ1UklpbmhHSWhs?=
 =?utf-8?B?RHEzVG8zMm54K0Vnd2o2NTU4R0JYNWhvTUllT245S2wvWENmVjNPQytkMFhz?=
 =?utf-8?B?MkdNdHpLUFVHRHNocG1QM0I1NjU4U2RUME90THJzbXVBZ0E1MndjUXczRDRn?=
 =?utf-8?B?dWtYU29pd2w2Q241Q2xyL0dRcUsvZUxCYm1xQXI1ZVk0d0RuMzN5R2F0em9h?=
 =?utf-8?B?b0hxT2VjSVcwbEhMTW00MGkyaURUdTJVSDUzamdzOCtDdERuZjM5VXgxMVFW?=
 =?utf-8?B?Qm9wRWRBU25qTGJjVG5lejNwMHdDNy9oS2daSjFMWklzc08xWHNrc2ZGTGNZ?=
 =?utf-8?B?bWFDM055anVISXBqb1NOb2J6d0pvMDFlYmNoUU5OMlNKcFRnQjBTczJUL2pv?=
 =?utf-8?B?djJaNFpzTGxvbmIrazR0UVJpVWo0LzFqbjJhYU9pTFNHVGxWUVdocEd4c0xt?=
 =?utf-8?B?TUFvQktRSVZBWHBjRm9hQWZYbm1DOG9TdDUxUGNQNUpVdG4yQjJwaVRUSHlG?=
 =?utf-8?B?TUo4ek1KaGYwakpSekFmQnRmUS95eCtvOHZxR3h1VG9xRUx5WUlNTkI4RytX?=
 =?utf-8?B?VWUyMHExQUh0dC9XdVNuamd0aVhrNlZvaFpsamF3cGQ0T1JNQVA3cXlLcGFt?=
 =?utf-8?B?RWxuNkVFSkRwTTVWMGZPYmFGVUtEbG8wYkhrb2hjQ21GWGsycE1lN0E3WExT?=
 =?utf-8?B?K3lsRDFGSXJkWjNYUzBVcDB1dnRZTVdIOS9mTCtEV0VnNDZBQlo3bitRb2pM?=
 =?utf-8?B?MWhBUmRlSVFNWk9UM3Y3UERvR0gzamovUjIwYUliUEVaWlNWTXhKNjZUb2NP?=
 =?utf-8?B?Z05mT3l5cGFZUkdzU2pIRFJYY2VHSGhiYWtCa1plbERqNWV5N3hRQT09?=
X-Exchange-RoutingPolicyChecked:
	M2S1zGN/1xUHN1SJb7uAxVqBHU1nqVwMRTLY3vJ0HPuuARHtR9zGvKq56jOOzJjkJ7sYsuVFC7u8DY4upbEEQoy5bAwGRei+5ncw2dNJru4bvy7OgrhEuo9APKdfXJHo73AjxaQFf7HRUmKXaam1kxJ8XC6C33W/x50V4wxYIMjfekUb2gHndld92oek+mciNcNDURpH+J17UQmqVP83+6VmfBdJhUOy4/0jECkGlm3h+c6+YID99ZyN+7RQDndPiXDJdNqvpbjVh4VU45T3yBmrFbJ4KAC4xdIf4i1Ru2wdIWCY011TcacQr6EPMVoaYjUAyd7YWOhLMVqd3iuQBw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cCss0V5swwfp84qicfPqcISH7PBHNzd6aAQlW19j3u1T00iFjoaBE59ij4W3CexlR2f3LwmLMsvkb2Hpg5rV48vT3zNw3rEj6M8c+4KMoEfO+Lqkn+Kz/iWVbA4RgLhunT2DnRhSx0CJkXtQXp2i9348ZU1H9zyI+qbd/M1fqUk4eC8CaaZy8C/sLIVJOfLIa/IJpvR+OJjnUw8lHT1g/5i6XicA5ZlUIkpFOqfocRVIlFA1obu5KWmdeygaKWB976QNuN2VYmXXS13jw8RgbPCVL0bsFo8HHzGa575lrISQZH/kMG2CBFtj73XIe2Ikd/uqaM9WgaUeo/YZQImccVtOxcw7/3aBdnkIGYwGIEJ8fjxdx34mSuur+PhVFgZlHYkg+Z+jP4LJLzPPJCgGmearZ6lC648bJAAGk+ZhTYcDnKtwVE08Mse9DjQkCuXC1KLn3ferjKGrZKh0QxNwf5oFphGOg0z/87hK/+I+qfBG4TFY32AlXF2XPtjXWdWA9tWZgAtLtAIXW2iHUJH4LHQJpLkYMmLIMyaXhABsaUMbuAY6DQ3Fb+NfGiKrJnFThWzlKv8cJ17ZblEQALv5WstHryItlXl1w9/0cIhAdbw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c59ffa0-2580-4068-4776-08de9ae32fba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 11:36:08.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwezTAZAMpNB0dMdhlsjpXWCUVdVnm5tQbeh3UvlH3QTxTB350OcimUep3ELGuDzmYqiXixrQcV0frMs//Mm4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604150107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNyBTYWx0ZWRfXyuEv+v2maZ7Y
 /PoBP3EFf8CCTvQXV3PCkiNi1tp91uNBUwx4hgEtzryPmNosgDmfGAHTU5WAUwdWVRujaU/lM74
 ZC1OM8ndQulo5Fpp/uVI/drU9rqDaABsYa0Ue9ckZUlBAuJRm4JHxpLl+w5mbHb7RNZ5aB/SlHf
 6YqmY6t2ENqkOTmeydye2wQ2doEJGX6uYJPwqISDo6mW4vHd89Ztwjh0E0FG4GpN4/RIAGoFZMd
 7H8DGfNYOC6Q//jIyBfoPA2GE74ANhLNtkeV6wCm55WUuhcxNEZ5oeZO0jOTCoKES8cvEIeSTkU
 9UXM5yn1oq4twoSzaBkm0Y6MOQlg3hRb7MtHMWZ+HDDoXaULlsDQ5vddugul/nbJ887A061D5Y7
 MkZ17q/mN1It2H/3YmoOF72GkwC9blNyg1O+doj7F4amrDV5xWWaPXpiURESInzSF25PclRcma1
 9KoOVd4QMvNCJpZi//w==
X-Proofpoint-GUID: DzTDdX7uomv-Fu7fAucfYuONeHZqFqgK
X-Authority-Analysis: v=2.4 cv=V49NF+ni c=1 sm=1 tr=0 ts=69df782d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=39jqJwDU1JTDA7uT-P0A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: DzTDdX7uomv-Fu7fAucfYuONeHZqFqgK

On 15/04/2026 09:24, Jiri Olsa wrote:
> Sashiko found possible double close of btf object fd [1],
> which happens when strdup in load_module_btfs fails at which
> point the obj->btf_module_cnt is already incremented.
>

nit: maybe the subject should be something like

libbpf: Prevent double close, leak of btf objects

...to reflect the leak fix too?
 
> The error path close btf fd and so does later cleanup code in
> bpf_object_post_load_cleanup function.
> 
> Incrementing obj->btf_module_cnt only if there's no failure
> and releasing btf object in error path.
> 
> Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
> [1] https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> v2 changes:
> - squashed patches together, because they depend on each other [ci]
> - added Fixes tag [ci]
> 
>  tools/lib/bpf/libbpf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8b0c3246097f..79d9607d26e2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5806,7 +5806,6 @@ static int load_module_btfs(struct bpf_object *obj)
>  {
>  	struct bpf_btf_info info;
>  	struct module_btf *mod_btf;
> -	struct btf *btf;
>  	char name[64];
>  	__u32 id = 0, len;
>  	int err, fd;
> @@ -5825,6 +5824,8 @@ static int load_module_btfs(struct bpf_object *obj)
>  		return 0;
>  
>  	while (true) {
> +		struct btf *btf = NULL;
> +
>  		err = bpf_btf_get_next_id(id, &id);
>  		if (err && errno == ENOENT)
>  			return 0;
> @@ -5878,7 +5879,7 @@ static int load_module_btfs(struct bpf_object *obj)
>  		if (err)
>  			goto err_out;
>  
> -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
> +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
>  
>  		mod_btf->btf = btf;
>  		mod_btf->id = id;
> @@ -5888,9 +5889,11 @@ static int load_module_btfs(struct bpf_object *obj)
>  			err = -ENOMEM;
>  			goto err_out;
>  		}
> +		obj->btf_module_cnt++;
>  		continue;
>  
>  err_out:
> +		btf__free(btf);
>  		close(fd);
>  		return err;
>  	}

the err_out label within the loop is a bit confusing, needed more now I guess
since btf is in loop scope. only way round it would be to haul btf back up
to global scope and explicitly NULL it at the start of each iteration. That way 
we could break out of the loop to do error handling. Not a big deal though.
