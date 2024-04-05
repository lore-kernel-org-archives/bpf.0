Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69134161901
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311630; cv=fail; b=LQaC+U261oy5l+GtgzcThvpdibrgNquEfedDEyXDPMXG8RhdgvXtAPmbK9nVHDIC/KkLSLlHuIEINxMkfLw9Sl8G1EoS9thk+kkMVf/HipnjlgpCfwj+8Ofq7+3/Fty4Xc7eqV6tSrScBJdEwnuifVAI5IGs5fjcIOXDxxe3oDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311630; c=relaxed/simple;
	bh=B0zGok8AMs9ieUna/utzLqgQ/BZu4a/lmmJpfAOdViU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FoN6OrUnFOQCUuFxweY9JU5GPgxluJIoKEWL06tBv52wI7exPcYetppYBFpEWaL9nv+RhrWcs3+xK8n5A8303NSvnFdsQWCirwXZs8QzyaKTUbD3L8k4hXwHqWIRv2obg0JFbEiJjV3Dihyb4s2VN1pJlM+/VaE6h2lAbKcxvrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZWkBN4Cx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AlCzHPOk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZWkBN4Cx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AlCzHPOk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4358Y5KA004523;
	Fri, 5 Apr 2024 10:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YCpFkPL6GQiskFIbd/a85DCptIfV2AkwkmJSYr3EsVA=;
 b=ZWkBN4CxxJmSxkzA1H3hHSX7uRNGfTc76Z8IqsDsWVBIKWG9oc3waKwlsGFacQMGFMR9
 ruFuXd9XxGRqqwWgfh4l820DA6KL0m1R/s45LN+z9fzaESrOFLTQbKLDXYNJSf3Ksh/s
 CQXk8XHuX8tu/por5HBWF/Jjgd/v3J7HkoAXU8ZmFI9Lx7vGGZuX92CYBmmeG++TstVH
 0Uu+KWEsBX9G7KvRT3zqif/xKHwf/gIkrYFJQtcLMlecPbYSNB4VuzHn2Ql+dxBRNVNE
 X0G4iJWFc3S5oHWezSSe6xkbLyMZQByJfeCnFvbHh7P5q/JzQQK+5su/4DUpcugTFZpP 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9en0k52t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 10:06:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4358PUod024299;
	Fri, 5 Apr 2024 10:06:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emnx68a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 10:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONwLZtBYBHgs5dr5H0zW3agdUeyyw1lyKBIL7cf29SdFAs7hdV047EXfOBs4Z4WCjIONtWdKhP3s2wDKlFxL3Z8IqkFUAheBF6gzBY9XoVn+wCb89kwaydFIOeQwHmtiGBXC9dpy6jYFWiuH/UStGWnJOMgw7sGhBVIDLYturQXJvRYnN5DqJbHtkozraNAMHePuyJItykVe+B25Q+1gjSR9IH0Vsmr5ICCCy+nJE++WClnXS8HRMTe5LWOOcZAXXjX+DJ4GtMpRmQvnUai25Pv65siDjnfccP7ChDK4B8rpABWdt+hzJj2hKm3teP9sEMnTzbOCpMHZbOvoZ7QcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCpFkPL6GQiskFIbd/a85DCptIfV2AkwkmJSYr3EsVA=;
 b=KqXqILDCcQ2ojX4jvB+h9OQBpnvKXgnNTMPHVyhOEjbD9cNXzGtFvW7+mQx9BKoBTopPbOZcF9Il03+3gJVEBvcZ4Fc9YyWmD5q/m159YQpeehb4O273Fcq3rrV1jUb5HIA9MJ6UD4sDKUQZxAeHrH7vfOQ3uvpbDahnR4fVfSN2hKcNBMG5Nkoq3PeUnoc/D4eS0A9XHsjnxAtBoF+nMrIqkGysQ8sSnw8VexkeVaNkPSeL3aQI6gz3W0RMIIjQfAIG0BjzKiNh5G9sHodAhbVYxj6iuRVGkF3rhvLdQS6ExqnGsqEMwSrj/lavMNBPevGKaVLVzAnZARaCAV0rSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCpFkPL6GQiskFIbd/a85DCptIfV2AkwkmJSYr3EsVA=;
 b=AlCzHPOkPfGIfXw4a7rfywfw0EhEjkVAudZlbA8u2IwBq1ViF5pf6NDABYQzDANKqnJVYCv2Flvr5iZC42MM9vuP8be5tLfFiQf9dwUfj4H+QYGPviSExX4HBdn1yB2iGgZvk0hiHezmCLzWMu9R3jgm5yAs8Rxcxneg2LQl+7s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6173.namprd10.prod.outlook.com (2603:10b6:8:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 5 Apr
 2024 10:06:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 10:06:38 +0000
Message-ID: <9be97b85-104b-4c33-a23a-ad68ba7f5838@oracle.com>
Date: Fri, 5 Apr 2024 11:06:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 09/13] libbpf: split BTF reconciliation
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240322102455.98558-1-alan.maguire@oracle.com>
 <20240322102455.98558-11-alan.maguire@oracle.com>
 <CAEf4BzbQEYgiJ=Xc7qaf0Tm_geTd40Ld+623Gk0TaBjPtTsnKg@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbQEYgiJ=Xc7qaf0Tm_geTd40Ld+623Gk0TaBjPtTsnKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rD/PPPMGpGLfi+9nlOwD1ylrwHoJC+TAiGkKQLV8ps/cn5KYVOEhQz8X1l8snhNpRPiOLohmRHfXPVXiarER3vSSl277/YpwmZUe8v6qPYxIb70MnOrkwFNifKOVsGchAC+/rPHWvdHUfT/IfsFE5X5reNNdQteOyKZZxLQ5N25IzHg/FEbl+TeWFsncfqNFnKGp9Fs8zyBWhRqmBj9Xq1f85L0OTm7DdMXlq5AEfhdeX4LgqQsP4zZAjplRwApPuZHuD6wYJLg1b/MKBxrUWfi68grIvCD7iBF/VGX0BoJOr8N7z/evP3bVllq5SsRskKuWlXmqr6CGmzoDvozhuCyji9nhdjc55qZjL4HXqX6y7cHMwYhNlp+9q6klBWr7RuUe4hRoJ5HFSLfAX6SJH17gcDB1hVxo2SidfpKMYj/NBeQ0e6FXPCPMxGZaeZXwAOrdnb4CFB+OMaZOnKnZ/iyVB7f+aflFXcgmjzo0wREF8KwuWnpzLExSo49cDYqlvalrwmJsnvNcXWuwp51ujUnIp+Bl2f8UlbXihns41U0UyTsPVWE4YGU0Krs0lVQB3UM1tWbkyvc9t+GtpPhvGlLo2iisq0uSCYRC+pEIGyZnU/uwrL9iWcHdl1p7xlaEBAifLJj9w9GER5JhUREmMyLwa0jGT11uxTtbRUd29CQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Slh4K2NBbENBb3ZTS28wZXRSbkM4QU9OTTdZTFlpYjU2ZCswMGFHNXF1b1Fx?=
 =?utf-8?B?U3RtZzJVcUdvenM1WmVtcXh2L0JiYTNkQzdBOUUyMkhZYkJDcmJONVdHR0ph?=
 =?utf-8?B?MnpNY3NhSUJOczgyclBpM2piZ3FYMDQ1a01mRzRkMkd0MjlOd0Y1cWJ1SmRC?=
 =?utf-8?B?eEdnb3daUlBwQnN4Mm0vY3ovZGZwaXUxZDFUaEhiRXVadVRndSt1TjdtUWF1?=
 =?utf-8?B?U1p6YXkxRDJvMzY4eVFRc0N3THJGUiswUWpCY1dFcFR4NzlGeld0QlVHeFBQ?=
 =?utf-8?B?eDRLeTE1TE9SanBqSy9RRUtuWVRqSGh2cFZqRUt0OElPa2ZudnViT2RJbWg0?=
 =?utf-8?B?N0pNdk5NZG9XWTRnenRQTjh0MmYvRTFITjhJOEo0eFpBRHVVT0pvNnlBTXAr?=
 =?utf-8?B?YXdOOWJqNW9oTWIyK1Erd3BTdG94QlB3d2ZWN3V3aUNNeUpWVXhRUytYdVVN?=
 =?utf-8?B?dHAwUE5menF4akJIemdwODY5TTFEMEtwQ0pzenhsNndvSUwyZ0w4eW1CZEx0?=
 =?utf-8?B?MjNIdzdHSzQwREFKRThoRXBjb1FYM3RBQjh4bjBCU2Raejd3SXpzN2pzc2Jz?=
 =?utf-8?B?ZmVsQkhMbVEreTVwNHFCVkkvOUc0U21uaExURFRTcWVZUER1blVadUw2K2dC?=
 =?utf-8?B?cFl5OXpIMHJZSkxnN1FCejRWblF5dmxuWHNzcnpBcUZBRGlYdDEzS1JzTHJr?=
 =?utf-8?B?a3ZKMHdGUmU4b2xCcUcvSXR3Q1lrVFNCZ3dCNThyZ2hFOHJ4TWhYYmtuUE1Y?=
 =?utf-8?B?VTdVd3l3bkhpcEdvWFRaaW1laFpGTyt3YTBuWWcwRTVCZnNoY2FHbCtMaGpO?=
 =?utf-8?B?dDRFZHQ1MUNmQVIzbGR1OURVUmNqcWZuVU9HVEUwRm1qZnNMQWIvRDhtM0hv?=
 =?utf-8?B?UjNzS0RLNDRCM1VDZDJ5QUd0MnhTZklQbHlKYndPVTJyV1lEbldLYVhqQyt5?=
 =?utf-8?B?U0NZNGZPT2I2QTNvNGw5d0NJYXpPUExoWFBzUXBCa2ZTUURGcTdvYk1CNEZx?=
 =?utf-8?B?VG95RU1kRmdXWVdSS0I2cE1zbUxQSTZRVTR5a3EvaWNzdTNDVHYzeFh6WE5Q?=
 =?utf-8?B?VWpiRWNrdDA5WiswSXlyRnZtSW1kQmROZStTN1ZjYlRSMVl3NUh3empNcEcy?=
 =?utf-8?B?UEYrYys0bGZ2eWhYVEZPZ1A0R1RnbSsvUXhCd1pIN2Z2cHliSFdyU0g0b0tX?=
 =?utf-8?B?VVhzUzhnUzZDVk9UNVpFSURFbFhFaUVQTkQ4Q3pqRGxFMlhrM0xkTGFyR1hG?=
 =?utf-8?B?TjZ4bnFaQ2JXUmdOMEo3c3dGOThVdHNoTStzSVFjNWZvTjJpYVlVZzFBVG9r?=
 =?utf-8?B?dW14NStqUlIwcnlUTE0rL1N1aUF3cFpUWTVNMHpkQWlrUmFPYmxKRjhnUVkv?=
 =?utf-8?B?bW0xbG9SYlFZVE9mWnNUMGlFRnBnUTdQTTdXZy9IZHEzS09PQXRkcmY4TE8w?=
 =?utf-8?B?NU5mMmxCOFEwOFlqTE01OUVmbGRQSlU4ZjZiLzdSYU9GUnNsenFnMEFIams5?=
 =?utf-8?B?QUI2OVBqTnoxeHVscEVzd0lXdjJMNEdvOVJPSXFFWGJ5Rk9XREV0WnVxN2tp?=
 =?utf-8?B?TjB1Z0RUbm1RK3phNXpDNThsS0V2NkJUVWRWU2RwOGkra0pSTEloSWQzSExv?=
 =?utf-8?B?Y0RBTXpUSmJUa2UxR241VUFRMVRJcHBLc3lYRVZ6LzIwSmY4QTJJV3FiM05T?=
 =?utf-8?B?VmxGaXI2YWtmNjc1L3IraWxWU1BaUGEyWDhzVnI5RU1QTUNydFpzZnRId3J3?=
 =?utf-8?B?aXZqWGxEbjIxb3hPTXhCZUNseFpiRTFBRXhhMmJpVlpabC9ob3paNFJCSFZw?=
 =?utf-8?B?QVBFd1FGUU1mNjR2ME1PSzRPbUVTNFBYWWp6RmpKcGMwUUxVUSs5dmxyVEts?=
 =?utf-8?B?VFFMMTMzdVBCS29XR3c3NGh2R3MrMmQ4anM3VnFPc2E4a2NDZEJnUG4yYUMw?=
 =?utf-8?B?QUh0VnNHdWcySEd5eG1WRWFRNXVYcG5zQk5PSExIazhnWG0weFBFTWx1L1Ft?=
 =?utf-8?B?Ky9LdVNqNkY4THY1aS9ScXMxTDZtd3RaZ2FueXlkVkF6eHVsRGVOZkZwbEdy?=
 =?utf-8?B?KzVEMm1VS3R6dzNSK1JZb3ZXYXRwNUx2djM3dG1xNjBZdGFERGVBZGVOaHBR?=
 =?utf-8?B?RVR4RTQwY2k5ZGVwYWhkelFxamRURjVSWlNXN0swNkhDVDRWMkZmK1dkMkVm?=
 =?utf-8?Q?n66cNBxbz2cTUWFOKZozpa4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iFbeT6Rz4WIxESVUtcVGKQuqbX2HSpLkGz8BDn/jACIiPCjHeBe72hXSW8fnYNrnGF5xtSPSDaKcNKED8SgiHVkO8eDsnjXKsX60WOFAZsWG06Fr7C6BCtHR0i7stRI3CndZ/6Nuguzps6ZvVH7mWdDrJZOd27fMbUC2EAwafQB0z4G4fMpm5xP5dvmZE6HB7ATqTBT8FnHS5sjCXw15hjzr1gZWk27UCdPeQ6IxRvNTrTyxoxcfAGWam4JrU849UC5yn22VnXWDj0wYFQiDJJUy/i8CGvmjjrt/JUmsKl2ny/+d4Sd3+VlgeFhNVlPMnqvRv1F075VKz+cCTVrpwBXpuuerPK7I4H4Fv6PIpjXV8c5eekoa8oNYkk5GSsQkvqWDrtHBh/9JNrOW2SkqUiaLAaxG62a200EXuddZvqius8AxehrOAM/w98CTD/6lBAgflv7rEayvgJ0Z3cCHIVkIpEJK8AD+hionnD4VTI6xfu7ffW8hnp7Ma/9lPJEhZarm/Ip2XllqjCFlYNCAEEdSSEYKEcB7SNCjHJMrFyotgLtc8AhGKAu5VuvHV5t61nVXtzXEVM5zKenne3FsD4IlAQIjhHo6dfWnMNukOsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094e9f8e-2abb-4fc1-69e6-08dc55581586
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 10:06:38.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSpKMllP7m9bTi8BZwpXXXSzaXhx0leNAhMmbk7uggx7mgL0LT3TqsNQKZkeaTy/CU9pbGQWCnQUWmI5QUnpMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_09,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050074
X-Proofpoint-GUID: hes_AIHfVpoPc7ZdoufP3O3eL5ayA-_8
X-Proofpoint-ORIG-GUID: hes_AIHfVpoPc7ZdoufP3O3eL5ayA-_8

On 29/03/2024 22:01, Andrii Nakryiko wrote:
> On Fri, Mar 22, 2024 at 3:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Map base reference BTF type ids referenced in split BTF and their
>> references to the base BTF passed in, and if the mapping succeeds,
>> reparent the split BTF to the base BTF.
>>
>> Reconciliation rules are
>>
>> - base types must match exactly
>> - enum[64] types should match all value name/value pairs, but the
>>   to-be-reconciled enum[64] can also define additional name/value pairs
>> - named fwds match to the correspondingly-named struct/union/enum/enum64
> 
> yeah, but what about their size if they are embedded? Using FWD was a
> nice trick, but it's not flexible enough for recording (optionally)
> size... Probably emitting an empty (but named) struct/union/enum would
> be a bit better (and actually make split BTF using base ref more valid
> even without pre-processing).
> 
>> - anon struct/unions must have field names/offsets specified in base
>>   reference BTF matched by those in base BTF we are matching with
>>
>> Reconciliation can not recurse, since it will be used in-kernel also and
>> we do not want to blow up the kernel stack when carrying out type
>> compatibility checks.  Hence we use a stack for reference type
>> reconciliation rather then recursive function calls.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/Build             |   2 +-
>>  tools/lib/bpf/btf.c             |  58 ++++
>>  tools/lib/bpf/btf.h             |   8 +
>>  tools/lib/bpf/btf_reconcile.c   | 590 ++++++++++++++++++++++++++++++++
> 
> how wrong would it be to call this process "relocate" rather than "reconcile"?
>

seems fine to me.

>>  tools/lib/bpf/libbpf.map        |   1 +
>>  tools/lib/bpf/libbpf_internal.h |   2 +
>>  6 files changed, 660 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/lib/bpf/btf_reconcile.c
>>
> 
> [...]
> 
>> +/* Find next type after *id in base BTF that matches kind of type t passed in
>> + * and name (if it is specified).  Match fwd kinds to appropriate kind also.
>> + */
>> +static int btf_reconcile_find_next(struct btf_reconcile *r, const struct btf_type *t,
>> +                                  __u32 *id, const struct btf_type **tp)
> 
> I haven't grokked the whole patch logic just yet, doing a first pass,
> so I might be asking stupid questions, sorry.
> 
> But it looks like we have these linear searches here to find matching
> types, is that right? Wouldn't it be better to build an index first to
> speed up search?
> 

It would, but the aim here was to keep things simple with an eye to
sharing the code with the kernel. A lot of the libbpf hash stuff would
be handy but then we'd have to have something on the kernel side. Given
that the size of the base BTF is so small, the linear searches aren't
much of a cost.

>> +{
>> +       const struct btf_type *nt;
>> +       int kind, tkind = btf_kind(t);
>> +       int tkflag = btf_kflag(t);
>> +       __u32 i;
>> +
> 
> [...]
> 
>> +static int btf_reconcile_int(struct btf_reconcile *r, const char *name,
>> +                            const struct btf_type *t, const struct btf_type *bt)
>> +{
>> +       __u32 *info = (__u32 *)(t + 1);
>> +       __u32 *binfo = (__u32 *)(bt + 1);
>> +
>> +       if (t->size != bt->size) {
>> +               pr_warn("INT types '%s' disagree on size; reference base BTF says %d; base BTF says %d\n",
>> +                       name, t->size, bt->size);
>> +               return -EINVAL;
>> +       }
>> +       if (BTF_INT_ENCODING(*info) != BTF_INT_ENCODING(*binfo)) {
>> +               pr_warn("INT types '%s' disagree on encoding; reference base BTF says '(%s/%s/%s); base BTF says '(%s/%s/%s)'\n",
>> +                       name,
>> +                       BTF_INT_ENCODING(*info) & BTF_INT_SIGNED ? "signed" : "unsigned",
>> +                       BTF_INT_ENCODING(*info) & BTF_INT_CHAR ? "char" : "nonchar",
>> +                       BTF_INT_ENCODING(*info) & BTF_INT_BOOL ? "bool" : "nonbool",
>> +                       BTF_INT_ENCODING(*binfo) & BTF_INT_SIGNED ? "signed" : "unsigned",
>> +                       BTF_INT_ENCODING(*binfo) & BTF_INT_CHAR ? "char" : "nonchar",
>> +                       BTF_INT_ENCODING(*binfo) & BTF_INT_BOOL ? "bool" : "nonbool");
> 
> there is btf_int_encoding() helper, please use it
>
will do, and for others below too.

>> +               return -EINVAL;
>> +       }
>> +       if (BTF_INT_BITS(*info) != BTF_INT_BITS(*binfo)) {
> 
> btf_int_bits()
> 
>> +               pr_warn("INT types '%s' disagree on bit size; reference base BTF says %d; base BTF says %d\n",
>> +                       name, BTF_INT_BITS(*info), BTF_INT_BITS(*binfo));
>> +               return -EINVAL;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int btf_reconcile_float(struct btf_reconcile *r, const char *name,
>> +                              const struct btf_type *t, const struct btf_type *bt)
>> +{
>> +
>> +       if (t->size != bt->size) {
>> +               pr_warn("float types '%s' disagree on size; reference base BTF says %d; base BTF says %d\n",
>> +                       name, t->size, bt->size);
>> +               return -EINVAL;
>> +       }
>> +       return 0;
>> +}
>> +
>> +/* Ensure each enum value in type t has equivalent in base BTF and that values (if any) match. */
>> +static int btf_reconcile_enum(struct btf_reconcile *r, const char *name,
>> +                             const struct btf_type *t, const struct btf_type *bt)
>> +{
> 
> should we care about compatibility between ENUM and ENUM64, they can
> both represent the same values of the same size?
> 

so do you mean if one representation uses an enum, another an enum64?
Yep that might well be the case, I'll add that too.

>> +       struct btf_enum *v = (struct btf_enum *)(t + 1);
>> +       struct btf_enum *bv = (struct btf_enum *)(bt + 1);
>> +       bool found, match;
>> +       int i, j;
>> +
>> +       for (i = 0; i < btf_vlen(t); i++, v++) {
>> +               found = match = false;
>> +
>> +               if (!v->name_off)
>> +                       continue;
>> +               for (j = 0; j < btf_vlen(bt); j++, bv++) {
>> +                       if (!bv->name_off)
>> +                               continue;
>> +                       if (strcmp(btf__name_by_offset(r->base_ref_btf, v->name_off),
>> +                                  btf__name_by_offset(r->base_btf, bv->name_off)) != 0)
> 
> nit: please use local vars to shorten these long if conditions, it
> will be easier to read and follow
>

will do.


>> +                               continue;
>> +                       found = true;
>> +                       match = (v->val == bv->val);
>> +                       break;
>> +               }
> 
> [...]
> 
>> +       while ((err = btf_reconcile_find_next(r, t, &base_id, &bt)) != -ENOENT) {
>> +               bt = btf_type_by_id(r->base_btf, base_id);
>> +               switch (btf_kind(t)) {
>> +               case BTF_KIND_INT:
>> +                       err = btf_reconcile_int(r, name, t, bt);
>> +                       break;
>> +               case BTF_KIND_ENUM:
>> +                       err = btf_reconcile_enum(r, name, t, bt);
>> +                       break;
>> +               case BTF_KIND_FLOAT:
>> +                       err = btf_reconcile_float(r, name, t, bt);
>> +                       break;
>> +               case BTF_KIND_ENUM64:
>> +                       err = btf_reconcile_enum64(r, name, t, bt);
>> +                       break;
>> +               case BTF_KIND_FWD:
> 
> well, FWD can be for enum vs struct, gotta check that
> 
>> +                       err = 0;
>> +                       break;
>> +               default:
>> +                       return 0;
>> +               }
>> +               if (!err) {
>> +                       r->map[id] = base_id;
>> +                       return 0;
>> +               }
>> +       }
>> +       return err;
>> +}
> 
> [...]
> 
>> +                               if (err) {
>> +                                       pr_warn("could not find base BTF type for base reference type[%u]\n",
>> +                                               id);
>> +                                       return err;
>> +                               }
>> +                       } else {
>> +                               if (btf_reconcile_push(r, id) < 0 ||
>> +                                   btf_reconcile_push(r, t->type) < 0)
>> +                                       return -ENOSPC;
> 
> I'm missing something, please help me understand. I don't get why we
> need a recursive algorithm at all.
> 
> In my mind, we have this small "base ref" set of types referenced from
> module's BTF (split BTF part), right? So all we should need is to map
> every type from base ref set to vmlinux BTF.
> 
> What I don't yet fully get is why CONST/VOLATILE or PTR need to
> postpone reconciliation via a queue. By the time we get to types in
> split BTF all base ref types should be mapped, so all you need is to
> remap t->type to resolved vmlinux BTF, no?
> 

It's possible to have multiple layers of reference in the distilled base
BTF though; for example here's a case from a module's distilled base BTF:

[41] PTR '(anon)' type_id=42
[42] CONST '(anon)' type_id=0

To resolve type id 41 we need to resolve type id 42, and since type id 0
already has a mapping, at that point we can look for CONSTs that refer
to type id 0 and then once we've established that mapping we can find
PTRs that have a t->type that refers to the const. So as described below
we keep pushing type ids onto the stack until we find one with a t->type
mapping to base BTF; once we hit that we can start looking in base BTF
for types that have the mapped t->type value.

> I suspect the answer might have something to do with those anonymous
> structs/unions which you copy verbatim into base ref BTF?
>

They do add a few more types, but we can get base BTF references that
don't come from that source too. The above case PTR CONST void for
example wasn't referred to via any other distilled base types.

> But on the latter topic, I wonder if we at all need this? Why not keep
> all those anon struct/union/enum in module's part of BTF? If they are
> unnamed, I doubt they will ever be referenced from kfuncs or anything
> like that, so their BTF ID isn't that important.
> 

Changing the module BTF would make things a bit more complicated.
Currently we just update type id references and string offsets. The anon
structs we end up with tend to be very small; from the same distilled
base BTF used above here are the instances of struct/union:

[35] STRUCT '(anon)' size=4 vlen=1
        'counter' type_id=6 bits_offset=0
[62] STRUCT '(anon)' size=8 vlen=1
        'raw_lock' type_id=48 bits_offset=0
[113] UNION '(anon)' size=8 vlen=2
        'kernel' type_id=13 bits_offset=0
        'user' type_id=13 bits_offset=0
[114] STRUCT '(anon)' size=16 vlen=2
        '(anon)' type_id=113 bits_offset=0
        'is_kernel' type_id=11 bits_offset=64 bitfield_size=1
[119] STRUCT '(anon)' size=8 vlen=1
        'net' type_id=85 bits_offset=0

These only added one type that wasn't referenced elsewhere - typedef
arch_rwlock_t.

> If base BTF is all named types, it would simplify the reconciliation
> process significantly, I think.
> 
> But again, I only skimmed the overall algorithm, sorry for my
> laziness, but I figured it would be good to discuss the above first
> anyways.
>

I'll try and walk through an example of how the algorithm proceeds; that
might help make the approach concrete and we can see if it can be
simplified.

Consider split BTF that uses the base BTF type "int *", i.e. a PTR to an
"int". It could do so in an anonymous struct/union, but also as an array
member type or a FUNC_PROTO or VAR. For such a reference type, we first
encounter the outer PTR. If its t->type has a mapping to base BTF "int"
(it will), we look through the base BTF for reference types that match
the kind (here a PTR) _and_ have the required t->type (int). Once we
find the reference type in base BTF, we can add the mapping for PTR to
int from distilled->base BTF id. So the reference type with one layer of
reference is pretty straightforward.

In the case where we don't have a mapping for a t->type - let's say PTR
to PTR to int (int **) - we push the type id for PTR to PTR to int onto
the stack along with the type id for t->type (PTR to int) after. So we
will first pop PTR to int and go through the above-described type
resolution. Next we will pop the PTR to PTR to int and because we've
resolved PTR to int now, it's t->type will have a mapping and we can go
through the search process to find a PTR that refers to a PTR to int
in base BTF, and we then add that mapping too.

For an array we push the member and index types, a func proto the return
type and parameter types, etc.

So once multiple layers of reference are part of the picture I _think_
we need something like this approach.

Alan

>> +                       }
>> +                       break;
> 
> [...]
