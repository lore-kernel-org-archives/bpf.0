Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85D311C32
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328330; cv=fail; b=NRXExuF90gDVVyghe4I2Sq9b3A4IjapmuZlI4lNwojOC1BOOCE+H1ckxPTNtAZxLN+KLD4NL3zX2IJPtPIzBuHXRpvAmrA8HgIA33ZP1YC5pDOIxrRKdoXanaSIj8jBfO9VjZru+WikcpB2cmdjkQQszs60uzRd6wd0uXGJgBkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328330; c=relaxed/simple;
	bh=MRhV1MaopO4w+LjQOIc3EUF8NkmWCF2FcDCVIPv8IVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qrREw04wElW2EeWXuhkHOeVA0ry8q+l+FBXsylw7FTZRFtVO0ureERX8kuDiIQaONFy/hi57TlrpOjV9cYa9lnvpu3cKuR3mvcW1F1f+2APRjeXmmUoGUF2LGnWWA2qaffs2Kks7dYTFC0yVnaVptrq5MQZeK5H4MO5VO52hzY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ocb/PDSq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ax0vALbt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ocb/PDSq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ax0vALbt"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6PvRk2136517;
	Thu, 16 Apr 2026 08:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nFfunOs07aLKPa/MqwRWob9zSlIo2WZBYT18E5dV9bw=; b=
	ocb/PDSq0zZkQUBCTH7jctjsVJiALE7FLvj0VvlkGfnJAlaXnsRMNOoJjVx5F1GF
	5NXZDUe+LmjAfwwQtDTVz7caiJ3BYmg9yOPDHfcKZNF8W3Qjp+8SbRR9XyNkDr72
	vGML2GZccXYZM178I0Bs3oqVoQyeQH9v1BFCuvnOoZiFoTvb38zwKBCerzdbBf3B
	h8qh13AHf3j9zrIDwqS9HFAU1vrL9n1gITFFtnQKt0X7rgZ3zTLO33OHgUw1X+f7
	RvIQ8RohRi6f53PLjRMk59k5QoM9qRP6j64SOVV+etZUo/EMDLeDrBez2LXKU+nU
	ff3iq5qNlDyR97/aSOFqPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh86875p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 08:32:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63G8TQkT017441;
	Thu, 16 Apr 2026 08:32:02 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dhyk19jdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 08:32:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQgkNbEYwOQtr4VCr2m4tmrCKgk64XPQGzlgS3ehVzt8qjV/JjG9dclRU/GQFKoxWTSJI9wc7ZTmBf67wfSiwVhU+5O7EXqPzoMixlTG1ICxS9jCxeMqNdn2pr0uXuvDff6pMtpj/T5Ond9yTg57TR+x3BkZblBvGCt2xdSII5i9ifDLMNJsSrkNXv2k1CcMxBYNKzyE4h36FcbBAzjjujYBUN9lx45aoIzAhQE/qKeqkHXWtRhzFpBqT10Ic0iz6YQsHndIOJkm2YdQvvK3oiVk+mqORxS+lyvJc1vaOdzCgu6kr78fhfH39irB7yxhicb2h+w2BXaJ4RU4kRXTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFfunOs07aLKPa/MqwRWob9zSlIo2WZBYT18E5dV9bw=;
 b=nAw6opT8Gn76s5ZwKCicrx3vEUZHuMwjppjH2/VUk+VV7gqTeump5zgcxIjk5582xiRPqAVmFxpqC/XKDhsOyiPvypGLOOecOFxpgtNSs7PB/jvCL5Ql34QXxyw2+QhfW5wjBipAKrdgqsIC3nLK31D+bYz/NfGp5eLWkWvq1Um4rtkujtu6m6g89hwfjyyUhLfSzIxWfh65d6WTQbv/2rbrNG21TezSL2fUCcTFbW2N6RX0NzErQE0U4byddXur1ytYKUew5IKTgI+Qp9g4tE4iPfYu1PUoY1SFh25Z0x1KAAf0TjTI3wDUPCvTPNAoL7RwSC0X49CNUR6fdYA1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFfunOs07aLKPa/MqwRWob9zSlIo2WZBYT18E5dV9bw=;
 b=ax0vALbtEB4fEZusGDURgM8ojI8h8FWJMBe/+zJx6/ZqyY1/lPdOmSvk3nLDSfHnjY7kMtUPv2N9iVyo4d+7V+eMZTJVnHaobhTrxkfGE6YBBJO9f1HQmxKD7xRaB88NrWj44NGKaOzvgclgMQkXQfpx0PmZsUeIhD7z+kwIt/A=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CYYPR10MB7568.namprd10.prod.outlook.com (2603:10b6:930:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 08:31:59 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 08:31:59 +0000
Message-ID: <74ee8ec0-904b-40ae-8fd8-25e1aa24b465@oracle.com>
Date: Thu, 16 Apr 2026 09:31:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: fix deduplication of typedef with base
 definitions
To: Antoine Tenart <atenart@kernel.org>, andrii@kernel.org, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, Paul Houssel <paulhoussel2@gmail.com>
References: <20260416073826.142056-1-atenart@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260416073826.142056-1-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CYYPR10MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 64812269-bb7e-4fb8-f645-08de9b92a025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RIU0F7Y3EmumRdFfWRBdG2EPo/5wjs6uejNqJ5nWgWifQ/t1bU69ktOXmD5W0mzcuelL/+aN8oRiP5CEnMngX+vOP9HWv2WiqctWEAWuBmzoRv2hBmAn67IMiusP2qG9fsIslLWWiOMKpavebnlyZH96lxh5i7ttVEmqpr7Qc4jKrl3gFbvvyfKT8YlOVtD5If9VwFpIuqEEZyzk7h/imQXbPMmYtqu289hPzVl2STTtTYIPz4+YuVNwRNyebONM1MxhyGsR/oXNlWGgh9P42Cv/LYrfiom6ebTiNjTzXgYC17C/proW/bMBk4s2udOyM6nnknmFhD9+Hjuh0tglCLfEpZSuiHSER0SA63omVqtw2xe63TTfhMv3p1A+IBTjBiN7pfKSYOcJNmR5oO1h/BoygaVA9pild+UhPUqEbLOo3J7bqTaqm1AEcXSK9ziI0o4fj7BUGZbFq9jbWG7uHhbbQIesPzm7DKGRo3a35tpvB1z43EggJBmym44TQennEU//rZYooHtfFzFpmM1Fa7dePNolXU1c09rGgx1jnmvBNgUxAaMJKr1OSnzfWS6nJQeO7RfUy2qfvZVfBl/on5SdZYjnN/G/tXh8IvyplaBl90akzE27t//PfAOHEw/zZlUqMpirlneZw/MDnxtgTGdQIZbBig1ajOqJUL3ueF7oNIddKsAQ16cPGKYOI1Ycxe1YJPPUBBWgiD5Tk3UogWhwJJHR6udn8MF42IA5kJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZsSzl3dEhBNUdCVkNNQnNGZDNVc2liUyt3YnpQVHdETW5DcWhHeUJ1b0x6?=
 =?utf-8?B?eERGUVh0dC9NNTBkaTluejBFaUZzQ3dsdzRPUTlWUUNpbm1kby9ZR3AyNEkz?=
 =?utf-8?B?KzRwZzFPdEQ1K0hnVk5nbXorNitNeGZSR0VNOFgrT3d2QXJrZSs2QVlpS0gv?=
 =?utf-8?B?eVdhUW85YkZHdmF1cGQ2YmR3ZUJlcEp5TjdPSWZlUDdlVndTak1NVlBWcFVH?=
 =?utf-8?B?UFRCMjFhRXcxTGxLc2hTaTJ2cVRDYzVyU0hWdEd5ZC8wOHBlQ2VRNHFGZ0pk?=
 =?utf-8?B?Q2FvRG9vbFYvUStyOXZpQlliS2R0eGduRkhZMzB5NVptbWI2WEdZYzc0T0Zo?=
 =?utf-8?B?eVQxNmYzWVNMdUFadDF6bWpQNzh6RHhsV2JUZnlKeUVzakdaK2dhVnorVDE2?=
 =?utf-8?B?SXpxQW9zVCtWOWVxR25jVTZmRS9SYWE4SFVsSkZENjRkS3A1Mi94SW4wdVBD?=
 =?utf-8?B?ZFBOTG1YR0FhTWJXNk1USzBOcFk4SDNWYWwxcHFPc3VIN2dkUmRENkRrbjMx?=
 =?utf-8?B?MWlxcmwvUFZHemJCM1pLNVYxOENtMWxjYUxFcjFxbG9DWGgvV2FzNnJyZHZk?=
 =?utf-8?B?dWE3WENRUEVVSFBOcW01NEhCZWQzQ0pNN0hqSzZKK3B3Uld6Q1I1eWlHMnFT?=
 =?utf-8?B?U1E5WGtMZnFIRXNnZy9IL2dDb0h4c2VyRDRqNnRSL1FQak81RE5vSjUzSldo?=
 =?utf-8?B?RzZ3Q0RaOFRIeVdQVmxZZ0lXc09pcllHT1cybGRHRkZPLzNvS2xXeGhocjdn?=
 =?utf-8?B?N2QxM1Z1TFlFZElFTzdsQ3o1YW9Ua3V5L0xWZDRIdDUrdGx4ZUxSOVdWYkp5?=
 =?utf-8?B?L3FnVWZnU3lqR3ExV0pqdWFOOTNBemZPcG5aQmRPeTNpQmVnRlQ4Y3Z0aUNv?=
 =?utf-8?B?ZDRxNGovaHZsd3dUQnNzQ1Vua0hBVWQ3b09tekNJMVhqL2c0RTUvaTFaV2Fr?=
 =?utf-8?B?MGpqR0hPbmZDSCtSWlhpT3lBdng0ajNKV1hEMWo1TG1mdXFWc2I2ckJoZ0x6?=
 =?utf-8?B?TXc0bUlGeENKdTJPNHdUVldzUFlNeldSMllvQXRvdXJGQmRDMGZFcXZiQTRU?=
 =?utf-8?B?djlvcktyQzdMbHl1cnl6bXhCMWRESm4wc1Zmc2x2aHdEeEYzdGdtRi8rWFR1?=
 =?utf-8?B?Z1JtS1RuM0UvU2tSUGUrc2V2Y1FKUk51VGYwaFlmaWgrcWJqZmFzQk82MzBx?=
 =?utf-8?B?R3krQktSaGpCeE5wSE9MZTN0NmhNL2V4SlY1SFJtaWhrWEZ3M1hwRnpZRS9K?=
 =?utf-8?B?SEh1dVZteUE2dzA5aWhIeWgxTi9lS0phcFRXYnZQd1R0UDAzdkpHb1hJcFBE?=
 =?utf-8?B?ZkRUQllndUMxd012TWFqbHJLRDB3M2pnYWRyeUlKbFhDcHR3a25qaUJOMlBp?=
 =?utf-8?B?Q05PdGdMSFcxTFMvaUhlZXBzWlJQeWxEWkJhRGpSWmVORnZKZWZPUlE2SVlO?=
 =?utf-8?B?WFBzZ0RFOHVpUGtyaTZjNXFqR2IvdFdYRERtWDlyMHZZWmZiK05RRmtJUERu?=
 =?utf-8?B?MldOU1RpTUgxR0N2MHFoMmRKeHB3OEZyYXo0RkEwWGdoaDd5L2FTV3ZrbC9s?=
 =?utf-8?B?RGM3SlY3REs4ZG56Q2JhY1ZOdU4yUDF1TzcyZW1QUndUK1dwa3V6aUhjbk0r?=
 =?utf-8?B?N0hCK05hUDFtOCtLUXVaczd1NXROWkc1TXNmemFTbTdGaFBuS3NQdENJZ1ZT?=
 =?utf-8?B?OFJRbW54ZmU1c2R0YlNIelpEcVpHT00zM01wVG9jenNkV0NnSFVTamlZcysx?=
 =?utf-8?B?enJxaWVHS2JSaTR3UWgvVmFPNCtKMXhmTklWRDRSZVoxdEN1SHVlZFhVZUdD?=
 =?utf-8?B?VExaS0EwUzBOOTZodnFkMlRZMzE3b2FwWWhxWkdKNkp5L09aRUt0eHBUeTRl?=
 =?utf-8?B?TTJQN0N4OTJ4VTVKRjExeEZEOXZ1ZGV0SHNESEpnYUdMaDVxRXoyM1lkZzQ5?=
 =?utf-8?B?NkkzWDB6RUtvNnlqRlNUeXhYZThzR2NYT0VIbCtiV1d6d0xpVm5XdUpVYXJF?=
 =?utf-8?B?SHJlZVpManc4bEl0UnZlQlVFSnRYZzhNcWErZ1JzZ1l4UlJ1S0w0NGhkMTA3?=
 =?utf-8?B?bVREMStDWnhKYmk3TC8xOVEyRy9RRnVMMnBmNEl6MWtwNk1qQW91S0JwQ2hi?=
 =?utf-8?B?cEo3NVA0d1I1T3lzbjY1RWpQclNxZU9SRmw0WlBsQTlQcUJKQmhoNFNzZnBE?=
 =?utf-8?B?Ny90Y2JQYW9OUVk2bk96QTg2VW9qaWwrR2l4S2RCNW5hMmhNMnBlM0pZNmdp?=
 =?utf-8?B?dkVwZmZLZmdobm5xeDlUaEM1S0xrTmxhT05QeG5VUDdjZ2lwTE1nSlJBZ01n?=
 =?utf-8?B?cEhHUVBrc01wU2xaRW93V1lENVFvWmJpeDI5SmZFSXJaUUoyb3l2akQ5cU0x?=
 =?utf-8?Q?dmwj9z2bHdUvLR1M=3D?=
X-Exchange-RoutingPolicyChecked:
	RzsiEhFkqvbNz2Ex5Z2yfYLpQ03dubaH7lGh3DMfPRt7Q+ZMhlDOpLIaQQD1zQsPQB2TFO1uOlRALndsCEgJCdrAD5mXfSjNEmXrc8pTp+8CQWXAsb7lrWZYOShgWYqB+312THh26Rmprk/qjxzO5eOMcZ9zpKMauG5h+JZsZBf5B/Djpz+jFjlb4QR4YmXldjLQF8Us4nyQM7DmI1nRwwmGAMudDGma76dahYuArLeTFE+/w1MOqEP3823P7Ls94ipQWXXxJDyVr2cr/63acthwRWd5LRo15OlbhEzeQ8CzSxcQqLXeHbkaajRAcSv5IMr7vd1ibbD0LsUq8dg5PQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AVbkvY14ulp6MJYUVwFBRmpRANFrGS7YHEbXI1/q2VxZio8IaDvsod7vdKGZRWQn9aHwxtRAR+TIqet3kZuZrLW3ezcALWlVlMhQKHskzJqM15jArnqQxcTKY0Cem9NGs8sV8IxuCmt+/hRfRokv9s72v4q9NVpUi0DIzmqkXsFYxul8o/2j5mD5qHrsFyq/IQNhZL+vD2zHyoBF2wwpiNtPkM9t2akq6L4Otg+koMJh3tJmu0h8eSW0Ew13d2CUh6YLWxhq5qwxPEfLUEGZsyAzsdUbHXCNIshSGKQsHMLKIIZDtjFcdZYsHMECLE3TvIy8nLqqq4SFw5QZ0LgavVq9D3TBI8HAwWP03vSmk2LhXhBCwB/5MFoW/VLQousftVZZSSWn/sKAa16DMX7ck80aO0Rf9LkdpkNBdRTLMy9yvrcSZ6ACnqSZJm7xNV0I2/yjaRSc8xEQtUtdSerImq1M+cy3DB0I4alTJ9g1VNuWSZsNVRUBW6iVJTSY78z641sbuJBPY2Ts748eS9x+H3MGIJ5s8kdg+ePCg42ftEfH/1zRCsQg1lkSKKeUE5hmZOj+VN9p+R4IYnPFJU+JYtOydRWRPtVc5mSCNwEPjIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64812269-bb7e-4fb8-f645-08de9b92a025
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 08:31:59.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WI31JChI5+nT7rGlQuev3BvXEw/8jlwX2iE1pjsCcIGRvRaDshwFkzDL6aFBOsA4b8NS+lWvt0oA0duu1kmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604160079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3OSBTYWx0ZWRfX/ZuxUUfIzIud
 V3BHHM2uoxkF5VMQYTUR6aTPaWy94CU9LB59+JLj2qFfOV4Qts8O3A/qvBSDiPs6bC20Xw1r4ST
 o2WFmGrTTsuXUpBFF0sVRqn+hUH3K/iVmDOnf7466iAJ4MK4mINHcHyBmobz3/DZ4ssLRYnmovP
 Juogv/UyD7s3YwT7a+GpiDTyEkKVa7nKjwlqgoLomhImKGif5hjnLyEv3GWk9cgdzG95B+f6RW5
 8Oqe3GLpUUP+stlOS2RaI4FWxNnaTjiIT0YEUBOWdOjboOlbFeq45Zx5wa+M4xhwRM2dV/ESljk
 aEtzpBWIzR7KkIzCDLE9sbQ3oME2CCJataIdouLFiTxhqOyF8/DEhLCgrFqtXhmzYfrSNpb47Qk
 Fj+lhCOb1SvTQjXUXKt9FGBvlAQqPkzdyANZePlVJDIaGEzydzJTOk3p26iv26pnwjyRLHsLdCj
 X0b7XAQoOwjjvQr3iPA==
X-Proofpoint-GUID: fFr_zx1I29f1Xkk_mzdRMoLQ-0AGAof4
X-Proofpoint-ORIG-GUID: fFr_zx1I29f1Xkk_mzdRMoLQ-0AGAof4
X-Authority-Analysis: v=2.4 cv=JY6Ma0KV c=1 sm=1 tr=0 ts=69e09e83 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=x3nQLAhleA4GWQyVkFwA:9 a=QEXdDO2ut3YA:10

On 16/04/2026 08:38, Antoine Tenart wrote:
> When deduplicating definitions for a module, typedef defined in the base
> are not removed. This is because the hash used for base types differs
> from the one used in the deduplication logic in btf_dedup_struct_type.
> 
> This was introduced by the referenced commit when moving the typedef
> deduplication logic handling from btf_dedup_ref_type to
> btf_dedup_struct_type, as this also changed the hash logic
> (btf_hash_common to btf_hash_typedef).
> 
> This also impacts other types referencing those typedef (e.g. const). In
> my test, the BTF section size of the openvswitch module went from 31KB
> to 45KB.
> 
> Cc: Paul Houssel <paulhoussel2@gmail.com>
> Fixes: 3781413465df ("libbpf: Fix BTF dedup to support recursive typedef definitions").
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Nice catch! It would be great to have test coverage for this in
prog_tests/btf_dedup_split.c ; adding a duplicated typedef to base and split
BTF in test_split_simple() and ensuring it's removed from split BTF
would do the trick I think.
> ---
>  tools/lib/bpf/btf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a878..771aeaa0262b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4578,12 +4578,14 @@ static int btf_dedup_prep(struct btf_dedup *d)
>  		case BTF_KIND_RESTRICT:
>  		case BTF_KIND_PTR:
>  		case BTF_KIND_FWD:
> -		case BTF_KIND_TYPEDEF:
>  		case BTF_KIND_FUNC:
>  		case BTF_KIND_FLOAT:
>  		case BTF_KIND_TYPE_TAG:
>  			h = btf_hash_common(t);
>  			break;
> +		case BTF_KIND_TYPEDEF:
> +			h = btf_hash_typedef(t);
> +			break;
>  		case BTF_KIND_INT:
>  		case BTF_KIND_DECL_TAG:
>  			h = btf_hash_int_decl_tag(t);

