Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9E3ACF05
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708954; cv=fail; b=TY/pGd+ebRvY1x5hbd1jFNEbNos5DWZ7PzNb13HQZOCOOi8L6UBUpd2Knl+MxyQOdMNGnkknkFXWq/EU7S2+NTZ26YeirKYsWS6IpPmDKE5M4AD+JkgGVCypO5YPQ7MK/9tBSsP4d/6vOYsUx56+EvDnq7dzOCqmwg0vo9F+1hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708954; c=relaxed/simple;
	bh=evvzprN9EB61QtvkX1TQPSBgLaAC5S33ZcOcz3FyTME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKBIAJn8Fri5EGKbQ8/i6/A0JWCxT9PaxQRgCmQa8qPvD8jCok+0/rOqwf7fMt2itPLI152nqEP0uotExbpHQf7JoUaistwuAK4X7SD4gAJ1Q+kXNzoa067X2GxAzU+tf88kjpDwyBG+k2fvgLmo3MuSXf4XBTS7EATw+h8lhT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iVMUoyt6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UfQs0ZfV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVMUoyt6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UfQs0ZfV"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K8RLSK2999316;
	Mon, 20 Apr 2026 18:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+ZymWUXxeeqPblBwdKJO/0jtgEGmwyQJ/3eWQS3L9bo=; b=
	iVMUoyt6C5Az/Lwxe4PYHqdOCm9MlcJJyFx+wow7ilc1JkFgWd6KYNr3TVYIiOzs
	VCC9wybWaDVcAgWksB3hzLTxsRWmyF3NL6htOOLErBoOFH/dkqIJshIo7aPz+KYS
	DSEUS89ExmLkIwznDvzUgd/D/xuWQKr8kNyVWs6tQfQyEdxoQB1HUCNMZKRi47Gr
	X8aHPW+sOWOuPMWW9di+U0uE6BbTA8b7JVUNzuxBitWz6wBRL7QJJy5HN+z3rVx0
	2MseoUgG4N4eSRJrAfiG5z01265VKztJnZXMFqCOqvcXl82SPSVpgOG1jpQQL4iv
	4pU7LXWsLg0Il77Yh3V9dQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm2grbsb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 18:15:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63KI6KD4000796;
	Mon, 20 Apr 2026 18:15:24 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dn187hb7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 18:15:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1UyETDkOLILzQinwuLOSuWrX6QdI6qc+6b9CTXZ6Ee5JVvtxpdmqGNe2aiy6w7STAjm0pla8UUk2Q+jJRDK3bKDFZ+pw+vvK0jUuB7jYsL1GtFfq/iO5j8Echh90b86+noBaCwOY2A3Abhe7iOlMxc3s6tRmv0LBQ2UunLs7KiZDuBM57SyrAQVkrZ6kAWHj5C54yhQGSLOJRmdpfdec79XuPQ6D3Gg7ciuDkGFdJPyUQfrFTrH0r6+CuEoH2MTiOf54dKqB2ZiOzEqJwvlmDeBP0RceCIZTxOQG77N5Q7n9SKDErnBl/pgjaw8bLJtK7PlJ5B615N/0g01piOX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZymWUXxeeqPblBwdKJO/0jtgEGmwyQJ/3eWQS3L9bo=;
 b=x8yhiplL0nWujXE9hQYcQViQmTILwEjW3pRqoqWZDk5VTNatypu4kWda65yEF5PpLvQlsddrGGFB3mRpbXhIuzaByT4mmOtEYDd8LBSpkRtBF9grnwI+n5jBqKyonJLJdI5zoKgBV8DWDvupt2DkWmeJp7Hj1swRA95+7QaqEZOAMuS7LG5OW5cwco0aWKVsYH7Q35DJ2qxC4bZW2wuLuB3TZxmBjFfSjSL/+/wLRt1Jma0kutcWlSkE5XZKCi5A0N4QFDYyte5g0smPOicn3IcuZ4+/s6/7hMm/IfOLZQp8O1hEY1tXGrzrUNac7ROGK3Q8p56MZHWGEtsX1R9S9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZymWUXxeeqPblBwdKJO/0jtgEGmwyQJ/3eWQS3L9bo=;
 b=UfQs0ZfVxWeSgFfAS/3Mo4go7egiuMeUn9ayR9F17epqeJSBB2hYgakn2nfeqAkDV21WxWsOYGasgV+B5kTrQgQcnRO0vY9LEgcOZj43gbqnwZ3v2hxEhBN9i1oYp0CX5RUIzGdyZOymexgWf7OB/qgsbp7hpiIqn+rvMM5Mrns=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by IA1PR10MB5970.namprd10.prod.outlook.com (2603:10b6:208:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 18:15:18 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 18:15:18 +0000
Message-ID: <34f9c2a7-529d-497b-9091-6e8bcbacc80d@oracle.com>
Date: Mon, 20 Apr 2026 11:15:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Introduce
 __bpf_kfunc_mark_deprecated annotation
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com,
        kernel-team@meta.com
References: <20260418171701.610025-1-memxor@gmail.com>
 <20260418171701.610025-3-memxor@gmail.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <20260418171701.610025-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0373.namprd04.prod.outlook.com
 (2603:10b6:303:81::18) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|IA1PR10MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bcd192-27c0-4a01-92e8-08de9f08c6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11006099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k36CEiL6QgSiiV5w/m73aBpa5lCtxHr2rr6VLT2APKJkLCP4lTghc8egqcEi1rdohrzMe3BoIQTrBokmLMAwbv25tFbm1Us3da866bq5ZbvrQr7MnzLTfhuu7PDSXS4Y4QcIbNpRSXqndiwkXJJyHKqk/lG7JnEK4C53qt2FU/SIT4maG3/UFbm9lVxsuR4USJXuyr5Pl2wzVEN/AHou/NcYtqEHAHhqPaGO1gz5iDeFKRMMvf3jDPwI19MEdn9zu9D1mfKXaKZGmayVSM8gtuHliXVUDRJjhhkSYCciBVY5PVe/eWeRXE+YnkHCOnlcuRgjC9Vaw16vx3kEyxWYfHK6O5V9erbxgVNRgDkmFuStty+IPMRpl7vpQfQmJapjyWih0rBTUKk3cnyyruvnQajmtWEcpgYhlAI5rz9xxIyYza5ESs3Y+wo91FaKm0aKkTU+mzDb+I1uQQ86oeu6X25Vs/k0Wma3g2R9aupNc2zlE7xqZ6gYIC60IxvbtMBG+JsMxW/Gws+vW3w2vbS0uePGxwy6i1rbaMMn7aiTJiZM/ABVtcBXWoEkQAPizeTbJoJEfJfobrqoJ3ywz1EGiIXoXYMpGB3iIvTJ+xsqn1QFUR6DTl0oLrkBWCIBk2ZcBR1mJvkyyfUOhQIIfamNYNLeZQzLQI0YNqP9YjLm/uE3swchUcJ4DjIUm0CJje6F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11006099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG5rRTJ3OFcvWXM5c2h6SGJleUVEMUF6TjMwUFVNcDRDeVFhaFZMNTlZbmVj?=
 =?utf-8?B?Y0ZxSkczemUvcjk2ZnlxZTAwNkZQd3dTY3RZd2JYdE5iSVhTYkRwYXdTaUd4?=
 =?utf-8?B?ZW5ub1F4SmIwUFJZVWlQWEwxdnZ1bVpoL0ZSUld3a3ZGS0JjMStFbWIwQ1J0?=
 =?utf-8?B?eFlLc3lEVUwwdktrT1BvejEyOWh6YXhpNkd3QXpIZjNJT2Rid2NFbXdKbnNz?=
 =?utf-8?B?b2FJcDUwYk1zM21LNGFvS3B3aHRHRGEwaGJWdzRGRVNwcUp3WkxiZzR5MDNt?=
 =?utf-8?B?dVkxVGphcWtDbHI5T0Q2R3NRVzdXeWFXNDhiK05raFJBRDh3eWRaN0FwbjEy?=
 =?utf-8?B?U3gxUUhFN25OcGxuWGt1c0dGUGFzZnZmZXZ4ejVZOEQ1V3VNTnVLNXVmY3Q4?=
 =?utf-8?B?SWJXNDJ2MHNTWXA2M3A0d1NPUUZJZmNJSEhMaS9uV0hWMXUrYjdwMjNPOWpv?=
 =?utf-8?B?Rkdla1REVTRDZ0lhb3hGemlmbG5oTXhUbk5aaDIwd2RKbGtzamxVTGRpSlFs?=
 =?utf-8?B?Y25EOUdHRTFPSml2M3pWdHBtOXNXTmNGREpZN2NjanYzMzZtWVBFcjlhWGlt?=
 =?utf-8?B?VU1BQkJ1a20rMXB1ZmduOUw2bHNRNEdzNEFmNG1tTWtOYy9HbWc4Rk9ST010?=
 =?utf-8?B?UEZHM3ZyTmFKcUxRSG1mcDRNdmlIQ0pxVnJoOVdCVkRac2t3cHNLUU5sUGty?=
 =?utf-8?B?QW03UngrdWNRMnlFL055VlliWTAwYkZ2VWM1YkQzdjg2bUZXM3hlbks2OEND?=
 =?utf-8?B?L0JtSmJ5ZTJQUEF0a05DM1JzS0ljaWd0alUvK0Vsd1NvaXEwNHJoMmQvNWZK?=
 =?utf-8?B?KzJIMlB1UHRFUlVNMk1kQm9JR1p4MnJ2WER5SnZ6clpIRmxLdmxlZ1ptcytL?=
 =?utf-8?B?SE44ZG1uZWtZY3BJT3A4VEtlaHdabFZVYUV2NnI5MXE1OVErWEVBYVJYWU1k?=
 =?utf-8?B?Z1J0eFJZTnRWbHR6Y2FXSXVrVHdpSXR2dzRDS0JmL0k5OVpIQTJnL2dDQ3ds?=
 =?utf-8?B?V3FJUTM5aXhodW9tY2pKejRCcEE4REE1dGRYSGd5bU5aQ1duY05WYW9DQmF3?=
 =?utf-8?B?SFhDSiszU2pWNTRBamZ0VlVNbEZOMXY4OWJFM3FiOUwzNzJYYmM5QnFPcGFq?=
 =?utf-8?B?WmU4anVwOUtDdi9hMzF0dWZ2T3U3eFFLeCtnNTlUTkZrTGFubExCdUxaNGE2?=
 =?utf-8?B?Q3RqV29VVkV2VXp2dHY4ZnExMWY2SndFZGJrOU1YanNpVWRkb2hCdWRqK3A0?=
 =?utf-8?B?R1ROV0xxeHpCYUxFRzNaS1dUS0VWNDlMSXdPU0FVeFFnWE1YOXQ3RExGdnMv?=
 =?utf-8?B?RVlJdVNlR1dUdnoyU2NpYlEyWGc2M3BmK3d1Q2tmaUR3QVVGOFNKMDU3U2Vu?=
 =?utf-8?B?TUdNL0t3K2gvZFkweTVjcXl1SHlTREFqS2UrakdYZzVCYzZxaW8rMzBXZXNs?=
 =?utf-8?B?RFZQK3JEdWh0MFNZbHpXSWs0MFNTQWNhYk91N09zTkhIb1ZKOWJGWExJRE1F?=
 =?utf-8?B?YzJXMGNRTXN3eTVKaCs0ZWFkSkI1R2tYZlhvV0ppaGxtaTdtQ3NCRXBEMHJo?=
 =?utf-8?B?d3BpbTB2Rnp1THBrSllrS0VtOHI3dE96cUViZjBQNFBhWVgzWSs5UTA0Z2Qv?=
 =?utf-8?B?bGZRbHRabWoyaE9mY3Fsa1QwTXI2ZTBIeWZTZ1dBbUJ6ck9BR1dwQnlmUWxX?=
 =?utf-8?B?UHJwRDl4cUIzKzF3TkRhaThPUDVNZERpYW5IdjdoQzVhWmZKeml5QXlrUEgz?=
 =?utf-8?B?UHdrSldGM0NWZW5Eb3BlZDk1SXdDdE5aelQzeUl1dWpLMk9FTnhLR3JYRVVv?=
 =?utf-8?B?UW5mOTBDa3MzNDE2bWkxU20wbFQ5ZHNwcUtmV3ArSCtMb0RROU5kSXdRZlFH?=
 =?utf-8?B?NGorMkdaWDI0OXM0TkJocWo3NUdadWJ1RjNTUkZ3S3h5VC9JZDg0OVRZOHVZ?=
 =?utf-8?B?U3RhUm4zSnc3Ri9pb2RDU3MwRExkSFB6S3NybUlqRGJhbi9TVERndGJQMU1V?=
 =?utf-8?B?aDY1dmx0V2FQdmp2bkdrMisyNXNHOElnTmx5bVNwTDFEL0o4RDRQbmpMNi80?=
 =?utf-8?B?VmMrcmFJRU4rUkJRcFFOVmZ1S3QwUW1NTzR5bXRZUjMvNXlJZ1NzK2cvV09E?=
 =?utf-8?B?Y3F0QnBZVDRxZ0VhZGZES0RmSVYxQThzQnhPejc5UElKU2NEV09zSzFmQkxN?=
 =?utf-8?B?N1E4dU00dmJReVgvS3pGOXFqU2ZHOEZsblZuWHZ2Zzk5clVCYm5SSmZHSVZN?=
 =?utf-8?B?TUVsbEtpZmNpZUNMOURZN3k5VktEZ0ZiemY1eHlzU1k5OUxvY0QwVmlzNnQv?=
 =?utf-8?B?RUFGVHNEK2k2TEJFMFFoTk9LSy9pa0JTdkFjeEtNUVdCTmNZcUFTZz09?=
X-Exchange-RoutingPolicyChecked:
	BHTya9NlPtmXdVRTm7QuPA7QuS204gIlK1JJ5TnbJDj5CrYM3m+VDE348iyPuOMrgjR7+oOEJCzovlxviHNrOvWSl4KAKIWrCDUyKV+S94YcO6XY5Z/LpQHencl5Va+ZnN3OItiaYEYRrAIRfG3laYkVFWTR0YLEzWcr3SaAs9i3hZpBZlU5xIUfoNu9qDY3Dy8bSs9qx5Loj0vnEv7cA8jwPugNQrZWMC8cfvFqIDYT58IlTguLuWR2o8Y+s4zR131A1WmLHdKCnUqKd9mfEfIbTN5u/Z5qSTRz7DbzDxbTaIeP5UhZ0hoHBMpWPcJYgxcK5a9NaQrBqpmNdHEPdg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LLb8dxblZ4RZ27Z+ZILPcgqWyVplb3Tt7kCbX0qQseFnf9/72eDAlC2IC+lHGnrP2go4e6kDESSxXbOUHZKvuE4xxvzA19j0TQAcyngjkxmepXPaW2ipxhIE7jpShWtfMFl1GomiI8TrGkV6pL2XOXsYtHktiGt6Fv3QraGhcccvpXNHdlXjsY+PSI70PcsH6KR9ksHg+qKI0TpNrdz8NtrYhvjYFq3f8krs14s1QKw4fKYI8IBYHqIoocYTHisrBvYOB0BPc6+wlWxCcGqrtZo5owqIY7h9amsyS6+C7iDGAWC33MMhoqTwXpr6yMbanVSW+08T/8qQADBlACmDQ8Ps2+M4BMBPzPMhH/pgrhR1ArnUMGuLY0Qxkgnf7IkfEq9ks2pc/WUZZwauWpZztKv9tdIRTrl/nTHZKO4G52lBJG78LeSgQ9GmssCe3zpbSsLA2SoGkMVt7vqffwDC0XSRgFkgIKUuIg4YKdTklLQrQYq8OIzHR5+I5bkGAlZf5rEVdWpYWoGlrNazdVQIzm/ip2bD6qShG6+n1O0lFpQrHiwZe6kWOV0MUety7s0qPKVHChbhTi0IJb45vX+WzGvp1IvTWQ78xb0NsLYGjL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bcd192-27c0-4a01-92e8-08de9f08c6b2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 18:15:17.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9+s9VWO2fa2V0vJDmaDhDSyzcpajrtUEQdK84ew+GlHtLvUCS1WVbUJ5c/LtJ4/swWpSXg0cDpmYnVHSJC4mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604200176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NiBTYWx0ZWRfXyN3jKTABtBc7
 WMu1BjHdp0Jh+ykEnWnjSBJoIm7+DJguRHUBdS36cmdirnn4HfeMpCI9ejB0/shCJFC0rv+CJtv
 0h10KagqHdjWeSg21o4cdKvSlSGGhksmROFaYPhj/HWHxZnqXHL4TRQD8TyI4c8dJTaNpvGl7JM
 N+xmexKnG5rEWTOxJ2mxcmyLAHXQRO9waVVV7cQHsWiiVp4KSs6jU1RJZF6lFGq+uf7+JZKGGZm
 LQceJkV+uDloujYgmgDDhC8ps/Gtg32yOkdF8l4maY1L+/r2aM4x7ejpENa9hoSO9tswGSUruEH
 Pdyj899s9/EqUy9cp3Q6T0eFq4dHGBd9uEeW+RqKV2OrDJt7nBdrMQfWBZ3asPe3+sBlRyIfgNj
 RgV0e2mwjTyAuHYOp1eV8MPMwcDAQWsxAAVN67ftDnsuk31zz/kRQxn7FPuJIuaApenSIgL7Kg5
 pRS+fLqXzyku3kQEwPw==
X-Authority-Analysis: v=2.4 cv=TN51jVla c=1 sm=1 tr=0 ts=69e66d3c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=CCpqsmhAAAAA:8
 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=E1azB5VJRo3-0MJBtGQA:9
 a=QEXdDO2ut3YA:10 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-ORIG-GUID: Ndupgpz4FY3up4-h4zKvo5eDWtomTDrc
X-Proofpoint-GUID: Ndupgpz4FY3up4-h4zKvo5eDWtomTDrc



On 4/18/26 10:16, Kumar Kartikeya Dwivedi wrote:
> Documentation for KF_DEPRECATED documents the expectations and
> recommendations for deprecating existing kfuncs. Until now, such a flag
> never materialized. Unlike other kfunc flags, more context needs to be
> carried with such a flag, thus we introduce __bpf_kfunc_mark_deprecated
> as a replacement for the (non-existent) kfunc flag which takes a
> replacement kfunc to provide recommendations to the user.
> 
> Apply it to all existing impl-suffixed kfuncs that are preserved for
> backwards compatibility for a few kernel releases, after we introduced
> versions with KF_IMPLICIT_ARGS.
> 
> Note that this is only supported by LLVM-compiled kernels as of writing,
> since GCC does not support for BTF declaration tags.

FYI support in GCC for BTF tags (both declaration and type) has been merged
and will be available in gcc 16:

https://inbox.sourceware.org/gcc-patches/f8ef5eca-4f1c-4efb-96a9-c65533e4573a@oracle.com/

We have been using it successfully with the selftest harness' __failure
__msg etc. macros with gcc master.

> 
> Cc: Vineet Gupta <vineet.gupta@linux.dev>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  Documentation/bpf/kfuncs.rst                  | 42 ++++++++++---------
>  include/linux/bpf_verifier.h                  |  1 +
>  include/linux/btf.h                           |  5 +++
>  include/linux/compiler_types.h                | 14 ++++++-
>  kernel/bpf/helpers.c                          |  8 ++++
>  kernel/bpf/verifier.c                         | 41 ++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
>  7 files changed, 90 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 47d60011d8eb..5beef4432a8d 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -344,22 +344,23 @@ RCU protection but do not take RCU protected arguments.
>  
>  .. _KF_deprecated_flag:
>  
> -2.5.8 KF_DEPRECATED flag
> -------------------------
> -
> -The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
> -changed or removed in a subsequent kernel release. A kfunc that is
> -marked with KF_DEPRECATED should also have any relevant information
> -captured in its kernel doc. Such information typically includes the
> -kfunc's expected remaining lifespan, a recommendation for new
> -functionality that can replace it if any is available, and possibly a
> -rationale for why it is being removed. When verifier warning logging is
> -requested, the verifier will emit a warning when a BPF program uses a
> -deprecated kfunc.
> -
> -Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
> -supported and have its KF_DEPRECATED flag removed, it is likely to be far more
> -difficult to remove a KF_DEPRECATED flag after it's been added than it is to
> +2.5.8 Deprecated kfunc annotation
> +---------------------------------
> +
> +The ``__bpf_kfunc_mark_deprecated(replacement)`` annotation is used for
> +kfuncs which are scheduled to be changed or removed in a subsequent
> +kernel release. A kfunc annotated with
> +``__bpf_kfunc_mark_deprecated(replacement)`` should also have any
> +relevant information captured in its kernel doc. Such information
> +typically includes the kfunc's expected remaining lifespan, a
> +recommendation for new functionality that can replace it if any is
> +available, and possibly a rationale for why it is being removed. When
> +verifier warning logging is requested, the verifier will emit a warning
> +when a BPF program uses such a deprecated kfunc.
> +
> +Note that while on some occasions, a deprecated kfunc may continue to be
> +supported and have its deprecation annotation removed, it is likely to be far
> +more difficult to remove such an annotation after it's been added than it is to
>  prevent it from being added in the first place. As described in
>  :ref:`BPF_kfunc_lifecycle_expectations`, users that rely on specific kfuncs are
>  encouraged to make their use-cases known as early as possible, and participate
> @@ -534,10 +535,11 @@ maintainer if it turns out that the kfunc is actually being used.
>  
>  It's expected that the common case will be that kfuncs will go through a
>  deprecation period rather than being changed or removed without warning. As
> -described in :ref:`KF_deprecated_flag`, the kfunc framework provides the
> -KF_DEPRECATED flag to kfunc developers to signal to users that a kfunc has been
> -deprecated. Once a kfunc has been marked with KF_DEPRECATED, the following
> -procedure is followed for removal:
> +described in :ref:`KF_deprecated_flag`, the kfunc framework provides
> +the ``__bpf_kfunc_mark_deprecated(replacement)`` annotation to signal to users
> +that a kfunc has been deprecated and to identify the replacement kfunc. Once a
> +kfunc has been marked deprecated, the following procedure is followed for
> +removal:
>  
>  1. Any relevant information for deprecated kfuncs is documented in the kfunc's
>     kernel docs. This documentation will typically include the kfunc's expected
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 515afcb83ec7..b70081fe24d8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1461,6 +1461,7 @@ struct bpf_kfunc_desc {
>  	u32 func_id;
>  	s32 imm;
>  	u16 offset;
> +	bool warned_deprecated;
>  	unsigned long addr;
>  };
>  
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 48108471c5b1..c75ecef67096 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -88,6 +88,11 @@
>   */
>  #define __bpf_kfunc __used __retain __noclone noinline
>  
> +#define BPF_KFUNC_DECL_TAG_DEPRECATED "bpf:kfunc:deprecated:"
> +
> +#define __bpf_kfunc_mark_deprecated(replacement) \
> +	BTF_DECL_TAG(BPF_KFUNC_DECL_TAG_DEPRECATED __stringify(replacement))
> +
>  #define __bpf_kfunc_start_defs()					       \
>  	__diag_push();							       \
>  	__diag_ignore_all("-Wmissing-declarations",			       \
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index e8fd77593b68..ba5b20e30d4d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -35,10 +35,20 @@
>   * see https://github.com/rust-lang/rust-bindgen/issues/2244.
>   */
>  #if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
> -	__has_attribute(btf_type_tag) && !defined(__BINDGEN__)
> -# define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
> +	!defined(__BINDGEN__)
> +# if __has_attribute(btf_type_tag)
> +#  define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
> +# else
> +#  define BTF_TYPE_TAG(value) /* nothing */
> +# endif
> +# if __has_attribute(btf_decl_tag)
> +#  define BTF_DECL_TAG(value) __attribute__((btf_decl_tag(value)))
> +# else
> +#  define BTF_DECL_TAG(value) /* nothing */
> +# endif
>  #else
>  # define BTF_TYPE_TAG(value) /* nothing */
> +# define BTF_DECL_TAG(value) /* nothing */
>  #endif
>  
>  #include <linux/compiler-context-analysis.h>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c266..69b4eae257a1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2343,6 +2343,7 @@ __bpf_kfunc void *bpf_obj_new(u64 local_type_id__k, struct btf_struct_meta *meta
>  	return p;
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_obj_new)
>  __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>  {
>  	return bpf_obj_new(local_type_id__k, meta__ign);
> @@ -2367,6 +2368,7 @@ __bpf_kfunc void *bpf_percpu_obj_new(u64 local_type_id__k, struct btf_struct_met
>  	return bpf_mem_alloc(&bpf_global_percpu_ma, size);
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_percpu_obj_new)
>  __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>  {
>  	return bpf_percpu_obj_new(local_type_id__k, meta__ign);
> @@ -2410,6 +2412,7 @@ __bpf_kfunc void bpf_obj_drop(void *p__alloc, struct btf_struct_meta *meta)
>  	__bpf_obj_drop_impl(p, meta ? meta->record : NULL, false);
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_obj_drop)
>  __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>  {
>  	return bpf_obj_drop(p__alloc, meta__ign);
> @@ -2428,6 +2431,7 @@ __bpf_kfunc void bpf_percpu_obj_drop(void *p__alloc, struct btf_struct_meta *met
>  	bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_percpu_obj_drop)
>  __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
>  {
>  	bpf_percpu_obj_drop(p__alloc, meta__ign);
> @@ -2460,6 +2464,7 @@ __bpf_kfunc void *bpf_refcount_acquire(void *p__refcounted_kptr, struct btf_stru
>  	return (void *)p__refcounted_kptr;
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_refcount_acquire)
>  __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
>  {
>  	return bpf_refcount_acquire(p__refcounted_kptr, meta__ign);
> @@ -2514,6 +2519,7 @@ __bpf_kfunc int bpf_list_push_front(struct bpf_list_head *head,
>  	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_list_push_front)
>  __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
>  					 struct bpf_list_node *node,
>  					 void *meta__ign, u64 off)
> @@ -2543,6 +2549,7 @@ __bpf_kfunc int bpf_list_push_back(struct bpf_list_head *head,
>  	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_list_push_back)
>  __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>  					struct bpf_list_node *node,
>  					void *meta__ign, u64 off)
> @@ -2683,6 +2690,7 @@ __bpf_kfunc int bpf_rbtree_add(struct bpf_rb_root *root,
>  	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NULL, off);
>  }
>  
> +__bpf_kfunc_mark_deprecated(bpf_rbtree_add)
>  __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
>  				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
>  				    void *meta__ign, u64 off)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8de2a4e5f5de..1f3b44f47949 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12987,6 +12987,45 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>  static int process_bpf_exit_full(struct bpf_verifier_env *env,
>  				 bool *do_print_state, bool exception_exit);
>  
> +static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
> +				       struct bpf_kfunc_call_arg_meta *meta,
> +				       int insn_idx, s16 offset)
> +{
> +	const struct bpf_line_info *linfo;
> +	const char *replacement;
> +	const struct btf_type *t;
> +	struct bpf_kfunc_desc *desc;
> +	const char *file;
> +	int line_num;
> +
> +	if (!env->prog->aux->btf)
> +		return;
> +
> +	t = btf_type_by_id(meta->btf, meta->func_id);
> +	replacement = btf_find_decl_tag_value(meta->btf, t, -1, BPF_KFUNC_DECL_TAG_DEPRECATED);
> +	if (IS_ERR(replacement) || str_is_empty(replacement))
> +		return;
> +
> +	desc = find_kfunc_desc(env->prog, meta->func_id, offset);
> +	if (!desc || desc->warned_deprecated)
> +		return;
> +
> +	linfo = bpf_find_linfo(env->prog, insn_idx);
> +	if (linfo) {
> +		bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file, NULL, &line_num);
> +		warn(env, "%s:%d (insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
> +		     file, line_num, insn_idx, meta->func_name);
> +	} else {
> +		warn(env, "(insn #%d) uses deprecated kfunc %s(), which will be removed.\n",
> +		     insn_idx, meta->func_name);
> +	}
> +
> +	warn(env, "Switch to kfunc %s() instead.\n", replacement);
> +	warn(env, "For older kernels, choose the correct kfunc using bpf_ksym_exists().\n");
> +
> +	desc->warned_deprecated = true;
> +}
> +
>  static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			    int *insn_idx_p)
>  {
> @@ -13016,6 +13055,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  	insn_aux->is_iter_next = bpf_is_iter_next_kfunc(&meta);
>  
> +	warn_for_deprecated_kfuncs(env, &meta, insn_idx, insn->off);
> +
>  	if (!insn->off &&
>  	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
>  	     insn->imm == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index d876314a4d67..5a57a92a8f8c 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1252,6 +1252,7 @@ __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, st
>  
>  __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
>  __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
> +__bpf_kfunc_mark_deprecated(bpf_kfunc_implicit_arg_legacy)
>  __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
>  
>  /* hook targets */

