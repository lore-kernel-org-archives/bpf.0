Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804537C924
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329904; cv=fail; b=mV2wLChT+FgtriNkT+gxCxMcf2ftgjyAU8PwQZe0hl6VrdRjgJ7avr0YkWqeKqrXkVKEhiWqgsBAe9npuKkTx+opKCi3nA+0k9YD0/UZoJteL9FvRunXa6x61QVLZaymkhlmySPiHo7yje1BUABH8Ps0QwHH0KrOCoairmRjmV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329904; c=relaxed/simple;
	bh=a4S1VoNrTLrP0zZxJVWnVcHqgKiFQJTREuKu8noM5Jo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7xldbumpeDqI/Okuf2QVMdmbfjKZUi0ipEUITyFWbEwyxyUbpibTlG1bY4Pk7nLW8w1vfXmmiBfS2mamCm6AB+lgB+YsmuXkWz+slwbiFxyJyMWe64CmHGbLd9cF7RppXSGakGPVODlhV6icFQL6mMtUY6u7teYOrj1OdFRZ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ke9dZY1W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B5ZihGlP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ke9dZY1W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B5ZihGlP"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6awdS1959102;
	Thu, 16 Apr 2026 08:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Hg23XSIM6kQapYws7T623u8P4395lR6E3LT3Nzo2SnQ=; b=
	Ke9dZY1Wmnrl1ypef7406SXj44w9TRpNKcvarxLyqIaKpXEcJ70BSGu/a/7Crx5A
	NY5alQXeHjAkLoEcZCE26UxlfQivOuvNZ5Ngb7dOA4ftUi8l9zPbRJsv3/oBiL9b
	aht+HmIIzZiGnAYHmYkBU7pr32ECLC4BVjLaRZiZK49w9qbllL9XAnikQDBPgads
	qT54Rdpco8KmKgGaAYFLVEgg4HZBWok+shBYJlC2tE5HC+aP2UF9iL3v+ZlBEi4P
	lsL1GlwTQL/y8V9WPI0zgsNC4dqViP+GAfwU+5//HLyLCmQthzW/MhvlK6jR+LAS
	Y4Xtb76oclw1e3xa7vUbNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85jq3kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 08:57:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63G8nSrW014939;
	Thu, 16 Apr 2026 08:57:30 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7np80mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 08:57:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtLpmZCGxxaw03OdpnEGo0LWA2HEHw9j/r92nRDyFhIa3H024mionKwS31BL2DxOIdWuf+X0MFv/UAatBdZRDP+oqtMtyuXwq7d8FfPEPk8hQBqUUWx6GzoqShcLdcwaBd0rG8VRQB4OaFMBIIK0CzXMzv5hrgCAa9LfX3fHIR60HO7KheccqZaY1ml/u5L1ZuaKIvZ5tvwkdoT4o0i+Fyiqc+4JswZet8jZe+RD8/CbD+yoLz/AwVGBfAcMWPQZXQkOL0YQ8WTlQnw8bueW5Ayr+asTZIXOOLqRVFIX69/m25ChL8tSzb0Vv/sFYe3ogRiRhQg2k6V6U495nNhE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg23XSIM6kQapYws7T623u8P4395lR6E3LT3Nzo2SnQ=;
 b=jTsoqUV/DbBD5m3+NWsLZRgHq5GhqtFjBXmabn0pZfXFbuC+Z7z9bJw39VLnqjClFdpbsKyPHMEgSau2N1TxWefnsZw7sZ/Ag9IraSrfTzJCv3akBoY8YFlFsqPcf+QL7Ple0MuQwt2uE9LPp+kCnKbd9G6g8lguLAjH7ZJDz0M8VCtMZdSZuVp0y0QzW9SGoWxnmlfM+Ujh78oipzyZ3awuxik04Y24s+VoLlanb2g0fC/C8Z5fu09fxm51J0DA9NB0E3WyhKSVoL3o1C2B3sqKcWMu6bcWNVavfRQk0SFn6K/k0jVukxaFcARdEF4VgiqU0ew/jr3r9uvFrD41uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg23XSIM6kQapYws7T623u8P4395lR6E3LT3Nzo2SnQ=;
 b=B5ZihGlP0By00/rjJyryC6KQ19gfsXCpEolLnyonVK3KOEbbOjxbNkR20EivO8tKUpr8gImesLitT+fNpqxzE6aaX38kSDfqCA729DyNkLRB3cWxZS//Yp/urlkegDLA3duH+c6xd1TkL3pWHPcrRTBOOTyJuxk2u7kuXhxg0+c=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DM3PR10MB7946.namprd10.prod.outlook.com (2603:10b6:0:4b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Thu, 16 Apr 2026 08:57:24 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 08:57:24 +0000
Message-ID: <2d08ed60-9180-4804-8339-7d0e56640183@oracle.com>
Date: Thu, 16 Apr 2026 09:57:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/6] libbpf: Add feature for kernel extended
 vlen/kind support
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        bpf@vger.kernel.org
References: <20260414195019.684531-1-alan.maguire@oracle.com>
 <20260414195019.684531-4-alan.maguire@oracle.com>
 <ba42c4f7-0bce-4aa9-be90-e102ea04336f@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ba42c4f7-0bce-4aa9-be90-e102ea04336f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX1P273CA0036.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::23) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DM3PR10MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: c49607ea-6430-46e7-809d-08de9b962d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XAqUVP2AiWRU/rtZNj+HqPBwMv7vvsRcLKXYgCAXjKydqcRDqX8k6Tx4RqTnuZQMvdTMI2gzK5+uW/x32Ch7VYaqmDNx7Ux5FU9vhEl1/eMXlT5wQXvzc7iA0qzW814MFeNuCroNVLyGYfipSyakBML5WDb7pELoDVJ476HyshxFL0+vHZoQkBbMJwsJgjHvQqMDxXxyhJrie0xHE32MCMI8XQsdl1nIptxy/C/USvIyVvbon7Ra9wr8YaP9dZM/XieDzTkRZswv4r/GDVfMogh7suehz8H+kkn8cQLHKUqHCsC1PyA5fLcJNsWfiwXxcq3sIhw8K6lfThj9WEywNcvpGxqGPduxCh958u7aGTdlnWspTt9nd9mCcls+7Gz6JR2nSGFk5Zi3AOUA8ZyF7fl2g14kVFBGmFE8jS6Ir3Rz/W+mlUdwa/RqOR0F08AD1Ic5Gf4/bAsL3lWrEYvJV1GQ5j9WJ4D3E6IiN88jasUvbrEpq2TIW+vVcxUsTzdt7Vrg7c6Z+/LeGDgG633NLKLXb3GXbtgt7CQbeEubQk4HzyT1JLtyaEpihSZW+2+7tg1w4pGEfAzY1nsucZeFQ3l8s/mjabS8FV+lJB5/Q9jj1kqbZbGARqQG2+cZ53JW5Hk6cBpaZxErngu8lrX2xNEtDwOZrMVMOsdHSaZu26uaXxvx3X3hjBemNIws+4it6ioYeIrPUdfhp7rWDscLSNC5/oN+iUYtw6bLuIxKda4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVVrTFRuSVBOQWprL1ZmKzZLa0l4ZVd5TDBSQ01MVVVwNFFtZjdxWHM3bXFp?=
 =?utf-8?B?NWx1NGM0c0ZDM00rczlhUWlzTEp1dnpoUHd3Z3Evb0V2V1hqSy9YeGEvVnhQ?=
 =?utf-8?B?SUFiSmJPbWxHOElaektzbjh2eW1RUVM4KzhxbXNUT2xqczk5aHF4TU9qdEJt?=
 =?utf-8?B?OUtoOFRYa0JRRUFoQlN2ZElwVjdZVENyZTNDaWgyUlpkMU9hSlRTb29tQ1F4?=
 =?utf-8?B?VkpUblVyRFR2eEl6MGNPaUgxblZMODZIWDJLaUthZGJSV2Y1WEkvRzk5VHpM?=
 =?utf-8?B?azJ6VWw5OW5qejBaZkdPY2pWTFRqWkZ6YmJyWTh5cU1zWGRNYUdDN2lrWVVH?=
 =?utf-8?B?d2FDMHpqaUEvay9mellzZEpYaU85dVNpMG5hbDdsa1FNOFYzMEg5bEZGdWRm?=
 =?utf-8?B?K0RIMnFVWVFWMVdCMzVPd0xoTXlEQ3FYMDFWL3lMUEwwWWV5RTF2Y2YvOE1X?=
 =?utf-8?B?VlFSQnA2ak8vb3Y4SEdDWUpjVHlUS2tUeGEyck1ZTTVSdFcvSkZYU2p0RUZq?=
 =?utf-8?B?WHhUa01PS0UwbnY4NGdTeWV4OVg3bm56cU1mZGlubUVza0dmcXJLZHFDSlh3?=
 =?utf-8?B?d2RPTUg3RUZORWM5RDFCUUVjb2tweHI0bXdodFo4TDBpSDg0eGNMVGJmdzl3?=
 =?utf-8?B?c1JMMGNnZDdIcHRlS3drMlp6cC9tUlh4YVZwSzlPOEFCTHhjUmxoSWhQcFBL?=
 =?utf-8?B?bitEcVJqVTVFdVBTRDA0ZzBIbGdSUS8yZitSOFA4TVI0YnNSM3NFWllGV2JH?=
 =?utf-8?B?U0R4WGRzcHZNU3EzTHJpNEpBNU9BVVhLcVc5cnp3czJEZFBsSDA2bkcrVTlX?=
 =?utf-8?B?R2dpYjBKRHltVEdYekp2aXlZV2cyQ1UvSm8yVTVSNythVHFwbHAyRGdxWldj?=
 =?utf-8?B?cmlwNDRmbllnVXMwKzIvQTNQNnAxWUU5dU5sdFd6THZPbEp0QlFCb1FZWUw5?=
 =?utf-8?B?eXZvOFZieVF4ZGs1TFVVV0Vad1VaWFYxelJsK0M5SEUzVTVFZlNkRysxdkty?=
 =?utf-8?B?OXlZcW12T0RpR1RqeXErWFhlUDRRQkwrTlNvSTNxclhDdW9BanNGKzUxNkVI?=
 =?utf-8?B?eGQzZUpNb29SM25EMUFTamFsZHAvZlNEWUxKVmJNL2Fmc3VMS3dybkNmOUZh?=
 =?utf-8?B?elNmb2wrWDZMbE5sTUlqaytTbUEyL3BvSGF6dEhkN3NOU00xdWM2K0hLU1M4?=
 =?utf-8?B?cXJBbkZacFBoYlV6aGJGclNrWHFab05Fd0dhZ3crRVZ3MEdRTHFNWnRySzgx?=
 =?utf-8?B?R1g2amlObFgvWmpJclFqWWNTWWZPdmRDV0NYTm9MTVZjYnN4Um83c1FWSk5Y?=
 =?utf-8?B?NVQ5Q0VWbG9HRExEVjVKWmhzRlJ0blQrVzRPRkdaa0hXVTJqT2pxd1NxTG5m?=
 =?utf-8?B?QjBJRnBIcFVWVEZLVGkzVW9RZThVU3liQjNrdlBSUUhxZXdBdDZKT1Bpd2N6?=
 =?utf-8?B?NXRhSFZGcFN5MzQ2c1pxVlhIWFk5eHRwa2luMzVsNmNqcXIwRzk0U0V0NGoy?=
 =?utf-8?B?R0J3OThaL09pd3pNSlBNRjl5V3BNc2JLa29zWjJnd0U5bTFXSHV3ZG1kM3Vi?=
 =?utf-8?B?aWQ0bWxkMm8rVUVCS3JncVNvcDBYTnFJT1RxOW1YY1R2bTF4R3Zhb3VmWVcr?=
 =?utf-8?B?THdHZFEwbmlrUlp6UnVSbGoydHlhbmNjdFp4eHBJNVhvTWZxbVhqcVNIL28w?=
 =?utf-8?B?V3p4aXhMWGptbE5ST21HUEtreGhuSnpobktTMWpzUUhiVUFqRHkxcUE5NjZK?=
 =?utf-8?B?WUxMRjArK1I4YUxtS09jVnRQU2o1eUVlVVVuakpIY01BNnZIRjhwR2JxcjBO?=
 =?utf-8?B?bU45Y2gvZ0pPdHlEWVhoQkM4SzlYREZlcFFJdEc0Rityc0dXckNCWFc0ZndQ?=
 =?utf-8?B?U0dybFFQSEoyTjBkZGc2YlBuVmFlODUxK3l3SHVjNnhuL00rbXJOMXcrTEZa?=
 =?utf-8?B?WUdFeUVBRXd6OXdSQ0w1RXJXSEhRREtXSW1kbFk2OUR0aERNSzIraENUOW1F?=
 =?utf-8?B?QnpnWWRJY1k3Zyt3MitoSm9sbXdFakFzNHhkeHQ1TlFKbVVVTXdNZ21YcCtn?=
 =?utf-8?B?N2d2ZnVjQUVxY1Evb0t2V0xoSWtzUEFzR3VCUzIyNUt6cmlhVVJ2MU9kVGVr?=
 =?utf-8?B?UWhOdkkxQ3ZOQ1E1UVR6cmhwbjU5WHdweWJpRm1iQnI0T2hrc3FRVVdLOEFm?=
 =?utf-8?B?aGVkb1JIQXFZKzdxcjFML3hPSkNWQ2h6QnJaU2YxSVhqRnROaHVqRWZzSDI4?=
 =?utf-8?B?cWtYVXFzTkxNK096VFRzU3JoOFRqdnJYRGpHdklieFhDNlo1S2prZmRVZVZ3?=
 =?utf-8?B?LzRZWnJLK3Q1VEFwb1drSkVoeG5kU3haaUh4dGZ1b21kdUZwaHVFZGpsZVla?=
 =?utf-8?Q?/sr9CPOBIG6MwEj0=3D?=
X-Exchange-RoutingPolicyChecked:
	Bk7e+O9h9gt4G65kDjHVgzYjdXwArwAJ2W7l+Juo9vd6Yo2ulawnU0pc45xK3nh8MQamEjftIJlB7ywrm0LSlBTa5eYN+1B3plc95gZJ0tHT4vi6Gq43L8zmvMr1Fn3Jaq17EKaWVZdSD3Av1+6fls/WXqWONsbGvWhsAlnTQ0PknQNep5towYwaJaN0E9iDNDoVEVUlkESHm5fz/fjzzRpZRDvnsm6Y5AJ6rlJrp7JsJSan5Ptmv8RjGPWDcdmruwqn/1yeW93KGSinMUbRcxF0BhHFCE3oIIspPvFeY3Fo0bqT2HDZ6figyJ1Nq6BXHv/ihzotKHL6yzYtouYw0w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Q6MVtbXLNW2oJfnhXdZ/xeBdC457m6jxgq/G3Oi2x05E5WEZ9cZx1Q5/CaC2ObvYVeEX35Vmy5TvhN4EdZ0ofY/T9hsi7jg+Jw5TkoOybsFmrWAhdt8v+Bpdeua4HhnP16RT4o8YhkyN+A1EtCNml/7288Gto5W8iWP+hupA7LqY5Poo8vGkDKBp6PZ/FpLgEs9KI9B6lKgyLH1A1D/cvIsSbpQY/Jx4Nyf2Qe3xRl2VilRDB4d/S4VNAnVAIHeTLmME3cCUsqEYLSWLOcjj0OPgGBMLsp2nOxreyEEG5cJWrniKFF607GfbGWmLR3IIdUyu4zAydad3rpWywX7pxzN7lzZRtZbfpBkiI+335bZjRUQ9uuifvwwWvlQuomWYowjE144lR5mhsYKt+Tkh612eWPRPLRjKQ/iEEH7rKTJS7cQsGjamEhr6m4SMsBJe4NWtIL6zycUXjrcZ/4IYaRUsJuHcLSdBaWROagXKsoImUO8DV9G1NGOajBDrd/0dXJejcOC82siyyEcZtCvLlLtbgKFX4r7HZDuRorf3+83UJkodmBTGCuLRdcmhIfX8x76Yej6932634/YYZD1TBG7DR+Pm1dQezHvsJMp3vE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49607ea-6430-46e7-809d-08de9b962d73
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 08:57:24.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64oDTR1p18oeozVxO2fE5Jb57WyVPYHVSuBdl3z/H8n0DJPmWapkTtJVvvY9PZJg+/dxKnK6elIE/O5iwxO9lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604160082
X-Proofpoint-ORIG-GUID: Nz58guT0N4VnWClj31uAloLkMs68I2hY
X-Proofpoint-GUID: Nz58guT0N4VnWClj31uAloLkMs68I2hY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4MyBTYWx0ZWRfX5I74h89LxIHf
 Pi4JWjUn356UcVefH5wQP1RZL0v8pcm9PZ8Z2oktWPV2w8Wu3h8DpBzS8nAtnMoClgjh7BDWN+7
 wa40qSl2KOVXg0AieRlsyAp0NS8YMshIM9H9Y5tdk+KJqipNh8/mUQDKs/IoCfvYFJDSyIyLHCY
 BhVPPvwJIpjm0LnltPsFOuYRRdNqTx2O62Xh1i1It048YgSX9YJJVfGmZ9RQEKe+anqhIAdGGeG
 vhw8z7Q+THGqUrH7bT0PItmwlO4/GaCEsSRtCvrgWKtg4nnTxTNIkOKP155FzqP+PxIHGluA85x
 EPu1GBotMWrzZzm+D/5iMDF5EhlqHi8qT4pGXH5mMaOnYKYJPqMzD00SvJYq6WbgqasNqmXIKEI
 mtMHqvDXXTofPtbrAGYNS8FIy3eTkSg2H/w/1gv5JzY1c+2cODSHvV+1hv9D+uXv5Eq3zt7AN7P
 7Y0iciJuWZnrX5UbPmmL8jlSql04u1K2HSx0qtQU=
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=69e0a47a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=w4cptpXHVcOQkAv8dcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12292

On 15/04/2026 16:57, Mykyta Yatsenko wrote:
> 
> 
> On 4/14/26 8:50 PM, Alan Maguire wrote:
>> Add feature check for kernel extended vlen/kind support, and reject
>> BTF that uses extended vlens/kinds if the kernel does not support
>> it.  There is no reasonable path to generally sanitize such BTF.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   tools/lib/bpf/features.c        | 39 +++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.c          | 17 +++++++++++++-
>>   tools/lib/bpf/libbpf_internal.h |  2 ++
>>   3 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index 4f19a0d79b0c..4a75d6717bbb 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
>> @@ -615,6 +615,42 @@ static int probe_kern_btf_layout(int token_fd)
>>                            (char *)layout, token_fd));
>>   }
>>   +static int probe_kern_btf_vlen_kind_extended(int token_fd)
>> +{
>> +    struct btf *btf;
>> +    int ret = 0;
>> +    __s32 id;
>> +    int err;
>> +
>> +    btf = btf__load_vmlinux_btf();
>> +    err = libbpf_get_error(btf);
>> +    if (err)
>> +        return err;
>> +    id = btf__find_by_name_kind(btf, "btf_max", BTF_KIND_ENUM);
> 
> Looks like if id > 0 then extended vlen and kinds are available, so there is no point to continue processing the enum and checking value of the BTF_MAX_VLEN. Or is there a scenario, where BTF_MAX_VLEN goes back to 0xffff?
> 

True, the enum presence is enough here. However another point the
bots made here needs to be addressed; other BTF kernel probes rely
on the bpf syscall, loading BTF into the kernel to check for feature
support. We're better off using that approach here too since it will
work even in container envs which don't have /sys/kernel/btf availability.
We can load BTF with an extended vlen (> 0xffff) and ensure it is accepted,
like the test does in patch 5 essentially.

All that said, I think the "enum btf_max" conversion is still worthwhile, 
since it's conceivable users might want some of these values in vmlinux.h,
and we can deal with any potential fallout by using redundant macro 
definintions like

#define BTF_MAX_TYPE            BTF_MAX_TYPE

just in case someone does rely on the UAPI macros.

Thanks for taking a look!

Alan

>> +    if (id > 0) {
>> +        const struct btf_type *t;
>> +        const struct btf_enum *e;
>> +        const char *name;
>> +        __u32 i, vlen;
>> +
>> +        t = btf__type_by_id(btf, id);
>> +        if (t) {
>> +            vlen = btf_vlen(t);
>> +
>> +            for (i = 0, e = btf_enum(t); i < vlen; i++, e++) {
>> +                name = btf__name_by_offset(btf, e->name_off);
>> +                if (!name || strcmp(name, "BTF_MAX_VLEN") != 0)
>> +                    continue;
>> +                if (e->val > 0xffff)
>> +                    ret = 1;
>> +            }
>> +        }
>> +    }
>> +    btf__free(btf);
>> +
>> +    return ret;
>> +}
>> +
>>   typedef int (*feature_probe_fn)(int /* token_fd */);
>>     static struct kern_feature_cache feature_cache;
>> @@ -699,6 +735,9 @@ static struct kern_feature_desc {
>>       [FEAT_BTF_LAYOUT] = {
>>           "kernel supports BTF layout", probe_kern_btf_layout,
>>       },
>> +    [FEAT_BTF_VLEN_KIND_EXTENDED] = {
>> +        "kernel supports extended BTF vlen/kind", probe_kern_btf_vlen_kind_extended,
>> +    },
>>   };
>>     bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 8b0c3246097f..5f19d8ac17a9 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3139,10 +3139,11 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>>       bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>>       bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
>>       bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
>> +    bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
>>         return !has_func || !has_datasec || !has_func_global || !has_float ||
>>              !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec ||
>> -           !has_layout;
>> +           !has_layout || !has_vlen_kind_extended;
>>   }
>>     struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
>> @@ -3156,6 +3157,7 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
>>       bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>>       bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
>>       bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
>> +    bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
>>       int enum64_placeholder_id = 0;
>>       const struct btf_header *hdr;
>>       struct btf *btf = NULL;
>> @@ -3217,6 +3219,19 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
>>       for (i = 1; i < btf__type_cnt(btf); i++) {
>>           t = (struct btf_type *)btf__type_by_id(btf, i);
>>   +        /*
>> +         * If BTF uses extended vlen/kind and kernel does not support
>> +         * it, there is nothing we can do.
>> +         */
>> +        if (!has_vlen_kind_extended) {
>> +            if (btf_vlen(t) > 0xffff || btf_kind(t) > 0x1f) {
>> +                pr_debug("Unsupported %s for id %u\n",
>> +                     btf_kind(t) > 0x1f ? "BTF kind" : "BTF vlen", i);
>> +                btf__free(btf);
>> +                return ERR_PTR(-EINVAL);
>> +            }
>> +        }
>> +
>>           if ((!has_datasec && btf_is_var(t)) || (!has_decl_tag && btf_is_decl_tag(t))) {
>>               /* replace VAR/DECL_TAG with INT */
>>               t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>> index 3781c45b46d3..8ef1fc96b73a 100644
>> --- a/tools/lib/bpf/libbpf_internal.h
>> +++ b/tools/lib/bpf/libbpf_internal.h
>> @@ -398,6 +398,8 @@ enum kern_feature_id {
>>       FEAT_UPROBE_SYSCALL,
>>       /* Kernel supports BTF layout information */
>>       FEAT_BTF_LAYOUT,
>> +    /* Kernel supports BTF vlen > 65535 */
>> +    FEAT_BTF_VLEN_KIND_EXTENDED,
>>       __FEAT_CNT,
>>   };
>>   
> 

