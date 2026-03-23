Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C51D5178
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270967; cv=fail; b=CuOBqHGhthPkrwxb45sLMLnucLX+Wj/cAUbJ2/igNTaE6FNrC9GuS3aliZ7hrwftAt2y06ZYObBtpK0Pvfqma/KVno1dGlYPezLb41hFYBwoo3kWEGkEnKipIFYvtP3Ur/YULRl5DHGGTU6LJenjX/Dk0RWVQ6siUU2vWYkyab4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270967; c=relaxed/simple;
	bh=JVFy27n7bzBU/DRDX3IoE594x+TJ1+w6XeXckloMNZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkY8LaEg5S65I2C7bX3bzQb9a/APRQK8LJosJKGLxk8SaB25/+0rpJmYLNo4V8Tw9m7p1gGyoQYnM8sDj65MZsvyrBON9LvP/W63slsoOudVobmQpIQ4yeZbhh5BeuBtS+uHXL2U94vL/miCqfXxN4IIZkVm8hJ4e5LkSieRrIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J03cJ8gA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GR6KC37y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J03cJ8gA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GR6KC37y"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N05C3l1729054;
	Mon, 23 Mar 2026 13:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CyiAYLFCKGyGVvp2fosK7vJmG1aFzxL10fk2rQzw+sM=; b=
	J03cJ8gATfdCVY3wexzabjUd1qC0GRDgjLwE78X81Z2sTXyFo4vEyQ1Zt24v/XBf
	l7y7D/2Up68gqD4q8uW/0+x6GGpgS+pTdzOUTJJsVUWZVxQgwNwTGBwxw3uZL8JZ
	tHr1+cPKzMVIFgA3vtc1sIDa6KmVGs/AG2lAgEKZSHQxMs/8d1y3q8gk8UJ+aw5C
	6lNxDNLXG0IGS9PfFQl/RgaSy4cFe6S4A+oMiScePz25Ca9Mf2Tz6TZ586ApoQef
	AEp+690raRwRle5TErAyEzVzCuHM6BoFJZ+Ces30BPqj1hY3OFHRTNdn0DSXQ2Vr
	UA684ZMAKR4mL+Pzd2JeuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfj7wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 13:02:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBf33F038993;
	Mon, 23 Mar 2026 13:02:43 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs8h3q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 13:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rROPfC7ar797SpFRuvBeizDnnq0z7iR0tkhNsrzKeRSMuv6zqi1UGQRrfho9eZPHIFs0zYAC/AxeEozj+REOaHg19xxedPXx5D5vx5I+0d7IRlJ4nkyMXCQGjME2AMywOuazwZhe5I4XI/QEEWgnSCTvmqntHdnuNp/r+cce+xjMDs3UGJ5zLTotKrr6t2RFzbBGIn+6XVRgCdrS/2scelw4mQmUUWoE+nijNfj3JKumAsstK0f3lW1SnQYu5w9oqtc1lJKvksdbaJTP8khhKJP1wMr1Zvo+02AMYf39zj2zqfcklxa6Pu1nhPgFauh0wen+iXh6e3v01YHm3ZIZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyiAYLFCKGyGVvp2fosK7vJmG1aFzxL10fk2rQzw+sM=;
 b=bYuSYZvXmqzcPEFWmGJ1ByJhMWuNC4MakAJK3+x2lqdN+oAbQz/Ip6rgCI6uBQ9gIUmY/nZs5IeiY8w5F7J/kMy+1BKyfN0gvfUar5lZSNlUTzQ0/xETHwJtGeF9eloxTWv9NkgU+zpVniATgjEi3B07Om7VpRtdk39prD74Ulg3kigiT60CLuR+yKUmfWnLbLqobXWLXbZ/15DA+puUdad2er3PvwOJC0aMQMnJQE0N+/Nrz9QOV20cZs2uY9tofppkXvOFaM/K6Kh/QbPCt58SWoLvqIyMX231C+66Lu8r/nRIDfQWAsacMKsme3MQV8q3PS4I2earv+hgo3IH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyiAYLFCKGyGVvp2fosK7vJmG1aFzxL10fk2rQzw+sM=;
 b=GR6KC37yArWsabDYMCSgAltoF8fmj67qDlOZ1WaCeUhgm4bJFk1hajjnhih84yn59gjo+hygDRkcqvf5lUK0v4GzFTGjddH8mrkBaNajL9NoGPr2/lK/YkbN83ajuFEN9HyJGp3mWS1WeYzT74mBVQNFhGjQ6frRJtpvtiYRbjI=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BL3PR10MB6018.namprd10.prod.outlook.com (2603:10b6:208:3b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:02:39 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:02:38 +0000
Message-ID: <1e6f8fd4-7fe4-4103-8fd0-0901b84c9ab6@oracle.com>
Date: Mon, 23 Mar 2026 13:02:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Enforce definition order for __msg macros
 in BPF tests
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>, cupertinomiranda@gmail.com
References: <20260305130035.192080-1-cupertino.miranda@oracle.com>
 <b073da2be883cf8f22a9a4c5f2dfa112d75d68f9.camel@gmail.com>
 <499f79da-eef7-4495-bcda-bca6c90c6f4c@oracle.com>
 <5d7ad7f651c9a6525f477566ee36f0e746f650cd.camel@gmail.com>
Content-Language: en-US
From: Cupertino Miranda <cupertino.miranda@oracle.com>
In-Reply-To: <5d7ad7f651c9a6525f477566ee36f0e746f650cd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0252.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::18) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BL3PR10MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 872e4819-6df9-4f83-40bd-08de88dc75e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O+iwRuG3iUp38AmdD0DeXA2Q2OADioAILZnTYAk0MwkcLvRxJ2eHuPhsLUMzgNQu10eXOq4zb+FE6onTQTeW26N4rkHCL0l7iL02sujqC242FP0uESsgkfHanmuoqaH2OCj/TmOWQytqNFiuZsS39XfgbBwmui8ikRL9gGY6vMDNAlG3hn026oI1UlWvf/CgGF6hrFGSJmuuZpjk77oYYx7B0VPNQeb+eEJlV2QAsUegUuLUSCPc/N64CkO0dEqAIq614cvSA6qfIxSwjLfqGOB7/1PdoBPSiJYTQfhoW/lNgS0GWcZV9/jKM7fwmKhFgsnDRul/+Py2YfDLHcheokcB0SyITHcSCdHca2CmYrwgo38sJWy9sdwauDqoOw9vJeZkJc7VR75I4ttLMiPDSYAngiUSXt7GrF510RIAtrZTg8M05lYzfELUaEaWLKKtHMOnUDfD98is8+oYhjkYTG4uQXJdmynlfXx/UAYXTiNjPYNUNVKGVpMyXCZUzHCJ2sHfT3fnyChjMzhMNFUs+pwGLw0ZLlzL/RJLoKvxprwYIjL2UwidCw5zIeZY2EE8Y3ggzQ8132tkJGoqYKXKWj7GoLz8EfhOipoQjWTTI9VR0BRLsQEHXTMKATYr6yiBqa58fEhKiLvi2tG0f+9N18+GSQhyLI6qjTW8VYm02FRZtYIYBaPQehGkVKtFvnqwkboDA4Ledg2VvNOE9kREwJ/alK0dhvLhsdAm3Ct9fj0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0U0S1ZkUmZ4ZjBOTXhxQjhoaHluVllSb2Jja3I1cXptelpQdmJsWXRLYlpr?=
 =?utf-8?B?TU1TbmhGSXp6YmFHQ1ZFY2xSd1hXVkc0Q2V2NzJRM2cyM2gzakFBaFU0QUFL?=
 =?utf-8?B?bTl2N2RLTjgwbWNTYmhmdGVZc044Slg5Q2o3QlpFZGhPR2hQcGZucE5UL0Nx?=
 =?utf-8?B?Z2gyTEtpbjJNVVphSEhPRDRMeklQQTBjNlpBRTNhQ2xQSFpUaGtCRnlsaFhr?=
 =?utf-8?B?MkU4RTNiNDZqMkpvckRoWHg0bktSTUZKRDR1b0VUZjZSbUVDWGFxS21nYTdt?=
 =?utf-8?B?b1dENEE1aHFzN1k1T3RxQVhjcXNMZS9vdjlNWFkvR1VYZXAveklZL3lDMEpS?=
 =?utf-8?B?QnpkbTcrTXBpSlN0K2E5MjNEMVg0NVcyVFJNcjcwWUFYbG5BbkphRzdUQU9r?=
 =?utf-8?B?TmQwb2ExTm1adUtEOXN2UzhXVnZYd1RGK284cnB2OHhLcDhSWisvdXFXcU5F?=
 =?utf-8?B?cFcrYm55ZHRCZHVZMXIzRVdrZTlHUXkyWU1tckVpVVU3cE1zL3J4dUQvSHU2?=
 =?utf-8?B?VEJtSUU0MnVWWUVUenhqWVBNaXpCa3RnZEJEZVBUV0hXQzkxOHA5eHVOcGFS?=
 =?utf-8?B?T1VpZUhqcEd5TEgxdjVSVnlzNWVMWUZ3ZHdLVkhNalhkaGpPR1RSQktCQzBG?=
 =?utf-8?B?T2hCdlFhcFVsaU5hNjUzR0c3d05GYkYzc3FGRlMyY0N6eG5Jc3Azc1ZrZUZ4?=
 =?utf-8?B?NjBaQThlSFpEZkJkT3VMMzQ2U1V2aitwc3htd05qTzBNeCtNcGN5ZEJFRmNY?=
 =?utf-8?B?OEp4RHRCdE5GZmpSa216aXhUdHhzWXhSL2RoYkN5UmJGOC9OZ0pVUXJ4cU5F?=
 =?utf-8?B?MW1VMEFQY1IwSzJNdXNlbzZTcGMycGJnMnpNTjRZelpFaEw0bTJxRm01T2pv?=
 =?utf-8?B?Q2c0ck5tVEs4NkpnaE54QnhXVlVkUTdJSDQ1MGhtSlpnNEVDSC96OE1VZW9G?=
 =?utf-8?B?b041R1FZcy9wUE0vV1VNYkpvYy94WHV5ZEtaN2VuVklDNEo1VzVab2t1d25I?=
 =?utf-8?B?OVZkSlY3dlJkYi9IVC9MSHU2OVgvcGV0dU1OVVpWL25ldTRTMEFoSnVYclRR?=
 =?utf-8?B?T1lMSXBUcFBxTVRqbmhDZjBZZ2VuQ0NFeHVoZlVTQ0p5ckpWNFBIemszTVZ0?=
 =?utf-8?B?K3F6cExpNWIyTStDcGdLaUoySlI1QXU5aEx5RWZUUzZabWExdEJaWWpzVmo2?=
 =?utf-8?B?aVUvQ3N2bDVnZ2s0d0ZXbmxtVnFTL21DWGlmMWwxWUhYRjN1U3NYVEdVOGoy?=
 =?utf-8?B?NElPVlR3eHVvcFpML0lZYWt3SCtMQ1daT1M0VkVCYXZvUEdETS8xTFJnSmlm?=
 =?utf-8?B?TVU2anpoVUdHODhvcVllRXZiMmVhZHRIQXJQQVFLcUlRL0tJZEZLaEFxKzlV?=
 =?utf-8?B?S2NxYVpmdHY1R3dBcC9JdG93cGhiN2Q5c3ZpNm4yTEQ2bS92Lzd3RTdtZlF2?=
 =?utf-8?B?WlZML0xlZGVvbVVFY3ZNWmhxZWRmN0dZaGVncVQ2NlY3SEs5RmZYQ0drTmFI?=
 =?utf-8?B?TWkzNHpIeXRQMHMvUHNjcHFzd29BZ0VnOGJSSWdscUtMcHdOTGVJTUFuN0xm?=
 =?utf-8?B?NFdkdFlIdDR6MDdJTmU1MVM1c2pUKzVBZEdLMFozRFAxcUtLQmZEckJFVE1X?=
 =?utf-8?B?YXAzOWlNUE5sc0VSNTZkYTB3SFF1a0lybUd6ajYwbkc0cG5nMzhZZmdLd3Rp?=
 =?utf-8?B?TUorZ1FNQzhuZDB6MExrNll2M2pFUitQdmt6Zzk1d2hXWkViQVZUOGR5bnpH?=
 =?utf-8?B?eDltMzA2WkZFN3RMT2w2R09jNkN1bDc3emNpRzI3U0NXaFVhWHUrdmxaTFdR?=
 =?utf-8?B?V2w3Qy9LS3RmM3c2YzNYUmJxVHYvbERZWXp6TFNueXR1eXVndDM1cVlWU3gy?=
 =?utf-8?B?Qy9RSGd5NEZGbU9YY1N3Q0xtV09Qa2dCOG9tcW55RU9iWnd4aDI4ZE41MGxT?=
 =?utf-8?B?eFZpendPaGFJWFY5UEhrYVVXL2tpN3ppN25TQUdmd1I4bDVoN2p2eTZRenNG?=
 =?utf-8?B?ZmxVbTB4QzlEUHhrUmwrclRVYjhtQk0xNER0Y1NIb1lYbmpVaDJJTmM5Mngr?=
 =?utf-8?B?UGExZ2VyRkpJZzJ4VE1qUTVZejZCdU5Mb1BFOHlnenlnSEFpRE85RjgzV3NR?=
 =?utf-8?B?b1hsVlpJb21IV21xa0JaZGNuOFRkUUdWT1REMXBFMmRTQlQvTEJad1JXMFk1?=
 =?utf-8?B?bWJqTmZNT0dkNWh6Ukhrc09FbWdya2t0OHMxSTA4c29SVFkyMTRjdGx3TTJn?=
 =?utf-8?B?TFFJQjJ4anREN09IRWllNmxGR2ZFSS9Dcmg1VCtPY3RlWXVYVmFBWDhHM2V4?=
 =?utf-8?B?MW5RcWZrZm9sU0xwVVVtV1lJWUF1LzlmT2hYN1JZQXRGa3dqdmxxSmVTK2Fi?=
 =?utf-8?Q?39I4EOEp80qphnuY=3D?=
X-Exchange-RoutingPolicyChecked:
	ioQU/m9pePSDJbP81RpbkihP0THZoCCdCoqKGg3KJByz3JRc0CLQ2xrsXphmkx2JeMb9ltjneL4U72I08RJrMIteql5UmB3IA+shjj6WV/rZNULkR69eZNQVeDcZ5niUHr87FuinKMgjSwA2OJp4pQ18R9WnbDJoVq9nZQVZ3kO3thuegBbEuNAafokJht9Ov8Lzm1DYLm4fb2uAVq3DIxS4idXtrsosOA+nGD6LerB0T0uF7aiRv2LbQJwtXn876xtus25CweZOMZ0iZSywl6rlQAzxELWleLIyBvbpDATQa5DVNow80k22biEyLJKrpHT8K8zRhXfZxEjrBxGfEg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AFF66Kt5RTvt8Xm4Ir5eCeVSrhbwWxmzceB7lN7D4tiaTOOGPpsuNJVOuj7Df9COMhMDsjfyLiEg05zT70NvoQN/tfS/2u78TxoWKvYFRsXJuGLCySt2lrQ+vkcObNjP9hEGnBWKxTzSXBAVAdH2248Oz2b5CN09JQuGEf2sO6YXs3FiNGpl1D7x6tgWACnxYvdMVJmVZEojZDeRJTmdV3b/QTyyObaVsmQfh3TCYNTd/ChljQbqJhlrdpevz7ls5fJUqRp7AsE79gIMsPLL4KGdjwjlk68qC40pRQOTIlqSxNgobfR4JDjdu7euDoKdtP0ruPQlZ+sgHdbSZb4fIinU+s8P0xJpnX+RhmCk2NdKvnyhmR2hFn/GCnGHkYC1Uc0JlmBUYLo5/BiHfRh4CuSxANu8icaJVmQWo68JAioRtJm2wPeiDXmrXN70CYWfyiyI3QkRhuq8+ZWehd9jl0dv9xS2kRB+xrbjq+GOurHoPAX1Zyy7WC2gxumDRzTMXA06XOUxwNNsK9VdDavtqnkC3YIQe5G9CTCDEWSU48QmGu/1jyQMVWh9r/5a6oW+wrRD+xaRH8nha3jTTtV1gYTgpt7wzQT8UCxpviUiWZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872e4819-6df9-4f83-40bd-08de88dc75e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:02:38.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEYJ1gPCUvl51kCHuqaw0wm0F1LLzdiSTdjnrHnF9tE8Llkmr3eF4CeZPTFRjgAg7bxm0nxWllPZC2HzQmIu3wDxld/+pKofPFYroLlRBgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603230100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMSBTYWx0ZWRfX8weEURu1KJuU
 NJQyW2w+F9DGUK1pAerv+i0uWloJOrzZpLMFV70NcONU++GIqmvVtvGoQh5SbWh7+NraMlUpgEd
 YRvZ0GbL/uw8iumwx5tmbbXOC4WpkCL8gcYdE0NZdJEf8EQVbegLUNlCwdFTAPorvAQZKK+pvPx
 YWwMxaVqR5wf22bBabrf7+HIPyc9xj6ybdzfDsDnZ118MahfcZtXsNijG4M7S87U76dbx6exarq
 h59byp5NktoYeWpk7veDwnviutY5z6Yr7QOqKczsrVRNj8vJeZq51a89+xlu0euk8tzzvOWMg7w
 Q6W0927rMZlbhOjxnA0FU+RyZVrQJhHz+egnNyA4xD0F+FiDiJYcL/C1Spk+V+OZGooptr95Kqn
 Cg9W7GNLRBecDGzq7PUyx8MJ25OQeYNAGtUTtQ7zVpXWHWutrOZ50t2WBOME6ig80LP38/2GgC6
 jvyB5TRrHAifzii3LYvrwpqkAw0Rs3clNC/ru7g4=
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c139f4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=NEAV23lmAAAA:8
 a=ZWkJYhGuPjkGMdQd52AA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf
 awl=host:13824
X-Proofpoint-ORIG-GUID: aBQ5FYUKpn1OLfkWBqCdj10rVO-c4cOa
X-Proofpoint-GUID: aBQ5FYUKpn1OLfkWBqCdj10rVO-c4cOa

Hi Eduard,

> Hi Cupertino,
> 
> Could you please check if [1] works as expected with gcc-bpf?
Yes, it does work in gcc.

> It is bigger than your patch, but I think it is a nice cleanup.
> (I took a liberty of putting your 'Co-developed-by' tag in
>   the patch #3, please let me know if that was inappropriate).
Thanks for sharing the credit! Fair enough!

Cheers,
Cupertino

> 
> [1] https://github.com/kernel-patches/bpf/pull/11484/commits
> 
> Thanks,
> Eduard

